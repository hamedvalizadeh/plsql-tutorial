
--HINT: delete the table if exists
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

--HINT: create table
create table book_tab(b_id number, b_name varchar2(200));
/

--HINT: create count function
create or replace function books_count return number is
  l_c number;
begin
  select count(*) into l_c from book_tab;
  return l_c;
end;
/

--HINT: create a procedure to delete the table
create or replace procedure DELETE_BOOKS(tab_count out number) is
begin
  select count(*) into tab_count from book_tab;

  delete book_tab;
  --HINT: by switching following line between comment status you can examine the result
  raise no_data_found;
end;
/

--HINT: prepare the data
insert into book_tab(b_id, b_name) values(1, 'b1');
insert into book_tab(b_id, b_name) values(2, 'b2');
insert into book_tab(b_id, b_name) values(3, 'b3');
insert into book_tab(b_id, b_name) values(4, 'b4');
insert into book_tab(b_id, b_name) values(5, 'b5');

commit;
/

--HINT: Examine that an exception in a block will not rollback the transaction automatically
declare
  l_tab_count number := -1;
begin
  DELETE_BOOKS(l_tab_count);
  dbms_output.put_line('Count After Delete (Normal): ' || books_count());
  dbms_output.put_line('Count Before Delete (Normal): ' || l_tab_count);
exception
  when others then
    dbms_output.put_line('Count After Delete (Exception): ' || books_count());
    dbms_output.put_line('Count Before Delete (Exception): ' || l_tab_count);
end;
