declare
  type v_aa_ty is table of employees%rowtype index by pls_integer;
  l_emps v_aa_ty;
  l_index pls_integer;
begin
  select * bulk collect into l_emps from employees;
  
  l_index := l_emps.first;
  
  while(l_index is not null) loop
    dbms_output.put_line(l_index || ' = ' || l_emps(l_index).first_name);
    l_index := l_emps.next(l_index);
  end loop;
end;
