--HINT: get one by variable
declare
  type emp_tab_ty is table of employees%rowtype;
  emp emp_tab_ty := emp_tab_ty();

  found_emp employees%rowtype;
begin
  select * into found_emp from employees where employee_id = 107;
  found_emp.first_name := 'Summer2';

  emp.extend;
  emp(emp.last) := found_emp;
  dbms_output.put_line('EMPLOYEE_ID: ' || emp(emp.last).first_name ||
                       ', FIRST_NAME: ' || emp(emp.last).FIRST_NAME ||
                       ', LAST_NAME: ' || emp(emp.last).LAST_NAME ||
                       ', EMAIL: ' || emp(emp.last).EMAIL || ', PHONE: ' || emp(emp.last).PHONE ||
                       ', HIRE_DATE: ' || emp(emp.last).HIRE_DATE ||
                       ', MANAGER_ID: ' || emp(emp.last).MANAGER_ID ||
                       ', JOB_TITLE: ' || emp(emp.last).JOB_TITLE);
end;
/

--HINT: get one by select
declare
  type va_ty is table of employees%rowtype index by pls_integer;
  emp_item va_ty;
begin
  select * into emp_item(1) from employees where employee_id = 107;

  dbms_output.put_line('EMPLOYEE_ID: ' || emp_item(1).first_name ||
                       ', FIRST_NAME: ' || emp_item(1).FIRST_NAME ||
                       ', LAST_NAME: ' || emp_item(1).LAST_NAME ||
                       ', EMAIL: ' || emp_item(1).EMAIL || ', PHONE: ' || emp_item(1).PHONE ||
                       ', HIRE_DATE: ' || emp_item(1).HIRE_DATE ||
                       ', MANAGER_ID: ' || emp_item(1).MANAGER_ID ||
                       ', JOB_TITLE: ' || emp_item(1).JOB_TITLE);
end;
/

--HINT: get list by cursor
declare
  type emp_tab_ty is table of employees%rowtype;
  emp_tab emp_tab_ty := emp_tab_ty();
begin

  for r in (select * from employees where employee_id > 103) loop
    emp_tab.extend;
    emp_tab(emp_tab.last) := r;
  end loop;

  for i in emp_tab.first .. emp_tab.last loop
  
    dbms_output.put_line('EMPLOYEE_ID: ' || emp_tab(i).first_name ||
                         ', FIRST_NAME: ' || emp_tab(i).FIRST_NAME ||
                         ', LAST_NAME: ' || emp_tab(i).LAST_NAME ||
                         ', EMAIL: ' || emp_tab(i).EMAIL || ', PHONE: ' || emp_tab(i).PHONE ||
                         ', HIRE_DATE: ' || emp_tab(i).HIRE_DATE ||
                         ', MANAGER_ID: ' || emp_tab(i).MANAGER_ID ||
                         ', JOB_TITLE: ' || emp_tab(i).JOB_TITLE);
  end loop;

end;
/

--HINT: get list by (( bulk collect ))
declare
  type empa_ty is table of employees%rowtype index by pls_integer;
  emp_a empa_ty;

  type emp_tab_ty is table of employees%rowtype;
  emp_tab emp_tab_ty := emp_tab_ty();
begin

  select * bulk collect into emp_a from employees where employee_id > 103;

  for i in emp_a.first .. emp_a.last loop
  
    dbms_output.put_line('EMPLOYEE_ID: ' || emp_a(i).first_name ||
                         ', FIRST_NAME: ' || emp_a(i).FIRST_NAME ||
                         ', LAST_NAME: ' || emp_a(i).LAST_NAME ||
                         ', EMAIL: ' || emp_a(i).EMAIL || ', PHONE: ' || emp_a(i).PHONE ||
                         ', HIRE_DATE: ' || emp_a(i).HIRE_DATE ||
                         ', MANAGER_ID: ' || emp_a(i).MANAGER_ID ||
                         ', JOB_TITLE: ' || emp_a(i).JOB_TITLE);
  end loop;

  dbms_output.put_line('***********************************************');

  select *
    bulk collect
    into emp_tab
    from employees
   where employee_id > 103;

  for i in emp_tab.first .. emp_tab.last loop
  
    dbms_output.put_line('EMPLOYEE_ID: ' || emp_tab(i).first_name ||
                         ', FIRST_NAME: ' || emp_tab(i).FIRST_NAME ||
                         ', LAST_NAME: ' || emp_tab(i).LAST_NAME ||
                         ', EMAIL: ' || emp_tab(i).EMAIL || ', PHONE: ' || emp_tab(i).PHONE ||
                         ', HIRE_DATE: ' || emp_tab(i).HIRE_DATE ||
                         ', MANAGER_ID: ' || emp_tab(i).MANAGER_ID ||
                         ', JOB_TITLE: ' || emp_tab(i).JOB_TITLE);
  end loop;

end;
/

--HINT: direct assign
declare
  type va_ty is table of varchar2(100) index by pls_integer;
  olds va_ty;
  news va_ty;
begin
  olds(1) := 'on1';
  olds(2) := 'on2';

  news(110) := 'n110';
  news(111) := 'n111';

  dbms_output.put_line('Before Aggregate Assign:');
  for i in news.first .. news.last loop
    dbms_output.put_line(news(i));
  end loop;

  news := olds;
  dbms_output.put_line('After Aggregate Assign:');
  for i in news.first .. news.last loop
    dbms_output.put_line(news(i));
  end loop;

end;
/



