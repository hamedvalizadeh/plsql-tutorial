
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

  type ty_n_id is table of number;
  type ty_n_val is table of number;

  t_r_id  ty_n_id;
  t_r_val ty_n_val;

begin
  update ret_tab
     set r_val = r_val * 1.5
  returning r_id, r_val bulk collect into t_r_id, t_r_val;

  for i in 1 .. t_r_id.count loop
    dbms_output.put_line(t_r_id(i));
    dbms_output.put_line(t_r_val(i));
  end loop;

end;
