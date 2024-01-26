declare
  c_delimiter constant char(1) := '^';
  type string_ty is table of employees%rowtype index by employees.email%type;
  type ids_ty is table of employees%rowtype index by pls_integer;

  by_name  string_ty;
  by_email string_ty;
  by_id    ids_ty;

  ceo_name employees.last_name%type := 'Brooks' || c_delimiter || 'Elliot';
  l_n      varchar2(500);

  procedure load_arrays is
    cursor cur is(
      select * from employees);
  begin
    for rec in cur loop
      by_name(rec.last_name || c_delimiter || rec.first_name) := rec;
      by_email(rec.email) := rec;
      by_id(rec.EMPLOYEE_ID) := rec;
    end loop;
  end;
begin
  load_arrays;

  dbms_output.put_line('fololwing employees have the same name with CEO: ');
  l_n := by_email.first;
  while (l_n is not null) loop
    if ((by_name(ceo_name).first_name = by_email(l_n).first_name)) then
      dbms_output.put_line(by_email(l_n).first_name || ' ' || by_email(l_n).last_name || ' ' || by_email(l_n).employee_id);
    end if;
    l_n := by_email.next(l_n);
  end loop;
end;
