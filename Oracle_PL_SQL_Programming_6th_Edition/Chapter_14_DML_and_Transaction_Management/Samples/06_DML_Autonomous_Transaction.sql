--HINT: delete etable if exists
declare
  tab_name       varchar2(200) := 'log_tab';
  found_tab_name varchar2(200) := NULL;
begin
  begin
    select table_name
      into found_tab_name
      from all_tables
     where owner = 'HAMED'
       and upper(table_name) = upper(tab_name);
  
  exception
    when no_data_found then
      found_tab_name := NULL;
  end;

  if (found_tab_name is not null) then
    EXECUTE IMMEDIATE 'DROP TABLE ' || found_tab_name;
  end if;
end;
/

--HINT: create etable if exists
create table log_tab(code integer, text varchar2(400), create_at date, create_by varchar2(200), edit_at date, edit_by varchar2(200));
/

--HINT: create package interface to manage logging
create or replace package log_manager_api is
  procedure put_line(sql_code integer, sql_errm varchar2);
  procedure save_line(sql_code integer, sql_errm varchar2);
end log_manager_api;
/

--HINT: create package body to manage logging
create or replace package body log_manager_api is
  procedure put_line(sql_code integer, sql_errm varchar2) as
  begin
    insert into log_tab
      (code, text, create_at, create_by, edit_at, edit_by)
    values
      (sql_code, sql_errm, sysdate, user, sysdate, user);
  end put_line;

  procedure save_line(sql_code integer, sql_errm varchar2) as
    pragma autonomous_transaction;
  begin
    put_line(sql_code, sql_errm);
    commit;
  exception
    when others then
      rollback;
  end save_line;
end log_manager_api;

/

--HINT: simulate the error and use the procedure
declare
  l integer := 10;
  a integer := 0;
  r integer := NULL;
begin
  r := l / a;
exception
  when others then
    log_manager_api.save_line(SQLCODE, SQLERRM);
end;
/

--HINT: test logging
select * from log_tab
