--HINT: delete etable if exists
declare
  tab_name       varchar2(200) := 'dml_row_tab';
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
create table dml_row_tab(d_id number primary key, d_pr number, d_name varchar2(200));
/

--HINT: create procedure that insert into or update the table based on row type.
create or replace procedure upsert_dml(dml_in dml_row_tab%rowtype) as
begin
  insert into dml_row_tab values dml_in;
exception
  when dup_val_on_index then
    update dml_row_tab set row = dml_in where d_id = dml_in.d_id;
end;

/

--HINT: use the procedure
declare
  dml_in dml_row_tab%rowtype;
begin
  dml_in.d_id   := 1;
  dml_in.d_pr   := 150;
  dml_in.d_name := 'n1';
  upsert_dml(dml_in);
  commit;
  
  dml_in.d_pr   := 152;
  dml_in.d_name := 'n1_new';
  upsert_dml(dml_in);
  commit;
end;

/

--HINT: test the result
select * from dml_row_tab;
