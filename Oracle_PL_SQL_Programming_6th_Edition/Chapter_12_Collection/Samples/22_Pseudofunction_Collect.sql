create or replace type string_n_ty is table of varchar2(3000);
/

select e.job_title,
       cast(collect((last_name || ', ' || first_name) order by first_name) as
            string_n_ty) as by_first_name,
       count(*) as job_title_emloyee_count
  from employees e
 group by e.job_title
 order by count(*);
 
  
 select e.job_title,
       cast(collect(distinct (last_name || ', ' || first_name) order by first_name) as
            string_n_ty) as by_first_name,
       count(*) as job_title_emloyee_count
  from employees e
 group by e.job_title
 order by count(*);
 /
