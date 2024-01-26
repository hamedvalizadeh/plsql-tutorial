declare
  l_dir  varchar(100) := 'D:\';
  l_name varchar(100) := 'Test.txt';
  l_file UTL_FILE.FILE_TYPE;
  l_line varchar(32767);

  n_line_index number := 0;
begin
  --select * from dba_directories where directory_name='temp_dir';
  --create or replace directory temp_dir as 'C:\temp';
  --grant read, write on directory temp_dir to OT;
  
  --HINT: write file
  l_file := utl_file.fopen('TEMP_DIR', l_name, 'W');
  utl_file.put_line(l_file, 'Line one Data', true);
  utl_file.put_line(l_file, 'Line two Data', true);
  utl_file.fclose(l_file);
  
  --HINT: read file
  l_file := utl_file.fopen('TEMP_DIR', l_name, 'R', 32767);

  loop
    utl_file.get_line(l_file, l_line);
    n_line_index := n_line_index + 1;
    dbms_output.put_line('Line ' || n_line_index || ': ' || l_line);
  end loop;

  

exception
  when no_data_found then
    utl_file.fclose(l_file);
    dbms_output.put_line('File Ended');
  
end;
