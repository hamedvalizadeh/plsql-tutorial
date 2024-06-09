
declare
  tab_name       varchar2(200) := 'ret_tab';
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

create table ret_tab(r_id number, r_val number);
/

insert into ret_tab (r_id, r_val) values (1, 100);
insert into ret_tab (r_id, r_val) values (2, 200);
insert into ret_tab (r_id, r_val) values (3, 300);

commit;
/

declare
l_r_id number; 
l_r_val number;
begin
  for r in (select * from ret_tab) loop
    update ret_tab set r_val = r_val * 1.5 where r_id = r.r_id
    returning r_id, r_val into l_r_id, l_r_val;
    dbms_output.put_line('ID: ' || l_r_id || ', Updated Value: ' || l_r_val);
  end loop;
end;
