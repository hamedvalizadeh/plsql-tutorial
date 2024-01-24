create or replace package TEST_PGA is
  function full_name(e_id in employees.employee_id%type)
    return employees.first_name%type;
end TEST_PGA;
/

create or replace package body TEST_PGA is
  type fullnames_ty is table of varchar2(100) index by pls_integer;
  fullnames fullnames_ty;
  function full_name(e_id in employees.employee_id%type)
    return employees.first_name%type is
  
    function get_from_db return employees.first_name%type is
      l_fullname employees.first_name%type;
    begin
      select first_name || ' ' || last_name
        into l_fullname
        from employees
       where employee_id = e_id;
    
      return l_fullname;
    end get_from_db;
  begin
    dbms_output.put_line('From PGA');
    return fullnames(e_id);
  exception
    when no_data_found then
      dbms_output.put_line('From DB');
      fullnames(e_id) := get_from_db();
      return fullnames(e_id);
  end full_name;

end TEST_PGA;
/

declare
begin
  dbms_output.put_line(TEST_PGA.full_name(107));
end;
