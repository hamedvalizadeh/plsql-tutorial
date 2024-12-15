```plsql
create or replace directory TEMPLATE_DIR_HAMED
  as 'D:\ProjectsLab\ORACLE_TEMPLATE_DIR';
/
create or replace FUNCTION clob_to_blob(p_data IN CLOB) RETURN BLOB AS
  l_blob         BLOB;
  l_dest_offset  PLS_INTEGER := 1;
  l_src_offset   PLS_INTEGER := 1;
  l_lang_context PLS_INTEGER := DBMS_LOB.default_lang_ctx;
  l_warning      PLS_INTEGER := DBMS_LOB.warn_inconvertible_char;
BEGIN

  DBMS_LOB.createtemporary(lob_loc => l_blob, cache => TRUE);

  DBMS_LOB.converttoblob(dest_lob     => l_blob,
                         src_clob     => p_data,
                         amount       => DBMS_LOB.lobmaxsize,
                         dest_offset  => l_dest_offset,
                         src_offset   => l_src_offset,
                         blob_csid    => DBMS_LOB.default_csid,
                         lang_context => l_lang_context,
                         warning      => l_warning);

  RETURN l_blob;
END;
/
create or replace PROCEDURE SaveFile(FileContent IN OUT NOCOPY BLOB,
                                     FolderName  IN VARCHAR2,
                                     FileName    IN VARCHAR2) IS
  BUFFER     RAW(1024);
  OFFSET     PLS_INTEGER := 1;
  FileLength PLS_INTEGER;
  amount     PLS_INTEGER := 1024;
  fhandle    UTL_FILE.FILE_TYPE;
BEGIN
  FileLength := DBMS_LOB.GETLENGTH(FileContent);
  fhandle    := UTL_FILE.FOPEN(FolderName, FileName, 'A', 32767);
  LOOP
    EXIT WHEN OFFSET > FileLength;
    DBMS_LOB.READ(FileContent, amount, OFFSET, BUFFER);
    UTL_FILE.PUT_RAW(fhandle, BUFFER, TRUE);
    OFFSET := OFFSET + amount;
  END LOOP;
  UTL_FILE.FCLOSE(fhandle);
EXCEPTION
  WHEN OTHERS THEN
    IF UTL_FILE.IS_OPEN(fhandle) THEN
      UTL_FILE.FCLOSE(fhandle);
    END IF;
    RAISE;
END SaveFile;
/
create or replace PROCEDURE GENERATE_FILE(P_TEXT           IN VARCHAR2,
                                          P_DIRECTORY_NAME IN VARCHAR2,
                                          P_FILE_NAME      IN VARCHAR2) AS
  V_FILE     BLOB;
  V_FILENAME VARCHAR2(500) := P_FILE_NAME || '.txt';
  V_CLOB     CLOB := P_TEXT;
BEGIN
  BEGIN
    SELECT CLOB_TO_BLOB(V_CLOB) INTO V_FILE FROM dual;
  EXCEPTION
    WHEN OTHERS THEN
      V_FILE := NULL;
  END;

  IF V_FILE IS NOT NULL AND V_FILENAME IS NOT NULL THEN
    SAVEFILE(V_FILE, P_DIRECTORY_NAME, V_FILENAME);
  ELSE
    dbms_output.put_line('Text File Not Generate');
  END IF;
END;
/

```

