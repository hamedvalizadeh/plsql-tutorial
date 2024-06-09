
declare
  tab_name       varchar2(200) := 'emp_tab';
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

create table emp_tab (e_id number, e_name varchar2(100));
/

insert into emp_tab
(e_id, e_name)
values
(1, 'hamed');

insert into emp_tab
(e_id, e_name)
values
(2, 'ali');

insert into emp_tab
(e_id, e_name)
values
(3, 'ahmad');

insert into emp_tab
(e_id, e_name)
values
(4, 'morad');

insert into emp_tab
(e_id, e_name)
values
(5, 'naser');

commit;
/

declare
  tab_name       varchar2(200) := 'bon_tab';
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

create table bon_tab (e_id number, bon_val number);
/

insert into bon_tab (e_id, bon_val) values (1, 100);
insert into bon_tab (e_id, bon_val) values (2, 100);
insert into bon_tab (e_id, bon_val) values (3, 100);
insert into bon_tab (e_id, bon_val) values (4, 100);
--HINT: to check the Merge command, switch following one line between commented and uncommented state
--insert into bon_tab (e_id, bon_val) values (5, 100);
commit;
/

declare
begin
  merge into bon_tab b
  using (select * from emp_tab where e_id = 5) e
  on (b.e_id = e.e_id)
  when matched then
    update set b.bon_val = b.bon_val * 2
  when not matched then
    insert (b.e_id, b.bon_val) values (5, 150);
  
  commit;
end;
/
select * from bon_tab;
