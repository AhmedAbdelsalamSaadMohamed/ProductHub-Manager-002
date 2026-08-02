CREATE OR REPLACE PROCEDURE execute_workspace_sql_file (
    p_file_name IN VARCHAR2
) AUTHID CURRENT_USER
IS
    l_file_blob       BLOB;
    l_script          CLOB;
    l_statement       CLOB;
    l_line            VARCHAR2(32767);

    l_source_offset   PLS_INTEGER := 1;
    l_dest_offset     PLS_INTEGER := 1;
    l_lang_context    PLS_INTEGER := DBMS_LOB.default_lang_ctx;
    l_warning         PLS_INTEGER;

    l_position        PLS_INTEGER := 1;
    l_next_position   PLS_INTEGER;
    l_line_number     PLS_INTEGER := 0;
    l_statement_no    PLS_INTEGER := 0;
    l_statement_started BOOLEAN := FALSE;
    l_statement_uses_slash BOOLEAN := FALSE;

    --------------------------------------------------------------------------
    -- Execute the currently collected statement.
    --------------------------------------------------------------------------
    PROCEDURE execute_statement (
        p_strip_trailing_semicolon IN BOOLEAN DEFAULT FALSE
    )
    IS
        l_sql CLOB;
    BEGIN
        l_sql := TRIM(l_statement);

        IF l_sql IS NULL THEN
            RETURN;
        END IF;

        IF p_strip_trailing_semicolon
            AND SUBSTR(l_sql, LENGTH(l_sql), 1) = ';'
        THEN
            l_sql := RTRIM(SUBSTR(l_sql, 1, LENGTH(l_sql) - 1));
        END IF;

        l_statement_no := l_statement_no + 1;

        DBMS_OUTPUT.put_line(
            'Executing statement ' || l_statement_no || '...'
        );

        EXECUTE IMMEDIATE l_sql;

        DBMS_OUTPUT.put_line(
            'Statement ' || l_statement_no || ' completed successfully.'
        );

    EXCEPTION
        WHEN OTHERS THEN
            RAISE_APPLICATION_ERROR(
                -20001,
                'Error in statement ' || l_statement_no ||
                ', near file line ' || l_line_number ||
                ': ' || SQLERRM
            );
    END execute_statement;

    FUNCTION is_ignored_sqlplus_line (
        p_line IN VARCHAR2
    ) RETURN BOOLEAN
    IS
        l_trimmed VARCHAR2(32767) := LTRIM(p_line);
        l_upper   VARCHAR2(32767) := UPPER(l_trimmed);
    BEGIN
        RETURN l_upper LIKE 'PROMPT%'
            OR l_upper LIKE 'SET %'
            OR l_upper LIKE 'WHENEVER %'
            OR l_upper LIKE 'SPOOL%'
            OR l_upper LIKE 'REM %'
            OR l_upper LIKE '@%';
    END is_ignored_sqlplus_line;

    FUNCTION is_comment_or_blank (
        p_line IN VARCHAR2
    ) RETURN BOOLEAN
    IS
        l_trimmed VARCHAR2(32767) := LTRIM(p_line);
    BEGIN
        RETURN l_trimmed IS NULL
            OR l_trimmed LIKE '--%'
            OR l_trimmed LIKE '/*%'
            OR l_trimmed LIKE '*%'
            OR l_trimmed LIKE '*/%';
    END is_comment_or_blank;

    FUNCTION requires_slash_terminator (
        p_line IN VARCHAR2
    ) RETURN BOOLEAN
    IS
        l_upper VARCHAR2(32767) := UPPER(LTRIM(p_line));
    BEGIN
        RETURN l_upper LIKE 'DECLARE%'
            OR l_upper LIKE 'BEGIN%'
            OR l_upper LIKE 'CREATE%PACKAGE%'
            OR l_upper LIKE 'CREATE%PROCEDURE%'
            OR l_upper LIKE 'CREATE%FUNCTION%'
            OR l_upper LIKE 'CREATE%TRIGGER%'
            OR l_upper LIKE 'CREATE%TYPE%';
    END requires_slash_terminator;

BEGIN
    --------------------------------------------------------------------------
    -- The stored file name does not include #WORKSPACE_FILES#.
    --------------------------------------------------------------------------
    SELECT file_content
      INTO l_file_blob
      FROM apex_workspace_static_files
     WHERE file_name = p_file_name;

    --------------------------------------------------------------------------
    -- Convert the uploaded BLOB to a CLOB.
    --------------------------------------------------------------------------
    DBMS_LOB.createtemporary(
        lob_loc => l_script,
        cache   => TRUE
    );

    DBMS_LOB.converttoclob(
        dest_lob     => l_script,
        src_blob     => l_file_blob,
        amount       => DBMS_LOB.lobmaxsize,
        dest_offset  => l_dest_offset,
        src_offset   => l_source_offset,
        blob_csid    => NLS_CHARSET_ID('AL32UTF8'),
        lang_context => l_lang_context,
        warning      => l_warning
    );

    DBMS_LOB.createtemporary(
        lob_loc => l_statement,
        cache   => TRUE
    );

    --------------------------------------------------------------------------
    -- Read the script line by line.
    --
    -- A slash "/" on its own line executes PL/SQL blocks and package/trigger DDL.
    -- Normal SQL ending with ";" is executed after stripping the SQL*Plus terminator.
    --------------------------------------------------------------------------
    WHILE l_position <= DBMS_LOB.getlength(l_script)
    LOOP
        l_next_position := DBMS_LOB.instr(
            lob_loc => l_script,
            pattern => CHR(10),
            offset  => l_position
        );

        IF l_next_position = 0 THEN
            l_next_position := DBMS_LOB.getlength(l_script) + 1;
        END IF;

        l_line := DBMS_LOB.substr(
            lob_loc => l_script,
            amount  => LEAST(
                           l_next_position - l_position,
                           32767
                       ),
            offset  => l_position
        );

        -- Remove Windows carriage-return.
        l_line := RTRIM(l_line, CHR(13));

        l_line_number := l_line_number + 1;

        IF is_ignored_sqlplus_line(l_line) THEN
            NULL;
        ELSIF TRIM(l_line) = '/' THEN
            execute_statement(FALSE);

            DBMS_LOB.trim(l_statement, 0);
            l_statement_started := FALSE;
            l_statement_uses_slash := FALSE;
        ELSE
            IF NOT l_statement_started
                AND NOT is_comment_or_blank(l_line)
            THEN
                l_statement_started := TRUE;
                l_statement_uses_slash := requires_slash_terminator(l_line);
            END IF;

            DBMS_LOB.writeappend(
                lob_loc => l_statement,
                amount  => LENGTH(l_line || CHR(10)),
                buffer  => l_line || CHR(10)
            );

            IF l_statement_started
                AND NOT l_statement_uses_slash
                AND SUBSTR(RTRIM(l_line), -1) = ';'
            THEN
                execute_statement(TRUE);

                DBMS_LOB.trim(l_statement, 0);
                l_statement_started := FALSE;
                l_statement_uses_slash := FALSE;
            END IF;
        END IF;

        l_position := l_next_position + 1;
    END LOOP;

    --------------------------------------------------------------------------
    -- Execute any remaining content if the file does not end with "/".
    --------------------------------------------------------------------------
    IF DBMS_LOB.getlength(l_statement) > 0 THEN
        execute_statement(NOT l_statement_uses_slash);
    END IF;

    DBMS_OUTPUT.put_line(
        'File completed. Statements executed: ' || l_statement_no
    );

    IF DBMS_LOB.istemporary(l_statement) = 1 THEN
        DBMS_LOB.freetemporary(l_statement);
    END IF;

    IF DBMS_LOB.istemporary(l_script) = 1 THEN
        DBMS_LOB.freetemporary(l_script);
    END IF;

EXCEPTION
    WHEN NO_DATA_FOUND THEN
        IF DBMS_LOB.istemporary(l_statement) = 1 THEN
            DBMS_LOB.freetemporary(l_statement);
        END IF;

        IF DBMS_LOB.istemporary(l_script) = 1 THEN
            DBMS_LOB.freetemporary(l_script);
        END IF;

        RAISE_APPLICATION_ERROR(
            -20002,
            'Workspace static file not found: ' || p_file_name
        );

    WHEN TOO_MANY_ROWS THEN
        RAISE_APPLICATION_ERROR(
            -20003,
            'More than one workspace file has the name: ' || p_file_name
        );

    WHEN OTHERS THEN
        IF DBMS_LOB.istemporary(l_statement) = 1 THEN
            DBMS_LOB.freetemporary(l_statement);
        END IF;

        IF DBMS_LOB.istemporary(l_script) = 1 THEN
            DBMS_LOB.freetemporary(l_script);
        END IF;

        RAISE;
END execute_workspace_sql_file;
/
