--HINT: delete etable if exists
declare
  tab_name       varchar2(200) := 'book_tab';
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
create table book_tab(b_id number, b_name varchar2(200));
/

insert
  into book_tab(b_id, b_name) values(1, 'n1');
insert into book_tab (b_id, b_name) values (2, 'n2');
insert into book_tab (b_id, b_name) values (3, 'n3');
insert into book_tab (b_id, b_name) values (4, 'n4');
insert into book_tab (b_id, b_name) values (5, 'n5');

commit;
/

declare
  cursor c is(
    select * from book_tab where b_id <= 3);
begin
  for r in c loop
    update book_tab
       set b_name = b_name || '_' || b_id
     where b_id = r.b_id;
    if (c%found) then
      dbms_output.put_line('Row Count: ' || c%rowcount || ', ID: ' || r.b_id || ' Updated');
    end if;
  end loop;
end;
