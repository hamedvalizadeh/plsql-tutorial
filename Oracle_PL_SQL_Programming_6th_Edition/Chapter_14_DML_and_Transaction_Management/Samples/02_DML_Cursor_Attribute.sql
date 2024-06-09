
declare
  tab_name       varchar2(200) := 'author_tab';
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

create table author_tab (a_id number, a_name varchar2(100));
/

declare
begin
  insert into author_tab (a_id, a_name) values (1, 'hamed');
  insert into author_tab (a_id, a_name) values (2, 'hamid');
  insert into author_tab (a_id, a_name) values (3, 'hadi');
  dbms_output.put_line('*************************INSERT*************************');  
  dbms_output.put_line('FOUND ' || case when(SQL%FOUND) then('Yes') else('No') end);
  dbms_output.put_line('NOTFOUND ' || case when(SQL%NOTFOUND) then('Yes') else('No') end);
  dbms_output.put_line('ROWCOUNT ' || SQL%ROWCOUNT);
  
  dbms_output.put_line('*************************UPDATE*************************');
  update author_tab set a_name = a_name || ' new' where a_id in (1, 2);
  dbms_output.put_line('FOUND ' || case when(SQL%FOUND) then('Yes') else('No') end);
  dbms_output.put_line('NOTFOUND ' || case when(SQL%NOTFOUND) then('Yes') else('No') end);
  dbms_output.put_line('ROWCOUNT ' || SQL%ROWCOUNT);
  
  dbms_output.put_line('*************************UPDATE*************************');
  update author_tab set a_name = a_name || ' new' where a_id in (5);
  dbms_output.put_line('FOUND ' || case when(SQL%FOUND) then('Yes') else('No') end);
  dbms_output.put_line('NOTFOUND ' || case when(SQL%NOTFOUND) then('Yes') else('No') end);
  dbms_output.put_line('ROWCOUNT ' || SQL%ROWCOUNT);
  
end;
