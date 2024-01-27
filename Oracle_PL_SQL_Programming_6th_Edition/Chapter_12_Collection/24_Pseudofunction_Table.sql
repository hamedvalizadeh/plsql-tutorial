create table birds
(
gunus varchar2(128),
species varchar2(128),
color color_va_ty,
primary key(gunus, species)
);
/

insert into birds
  (gunus, species, color)
values
  ('bird_1', 'species_1_a', color_va_ty('blue', 'green'));

insert into birds
  (gunus, species, color)
values
  ('bird_1', 'species_1_b', color_va_ty('blue-gray', 'green'));

insert into birds
  (gunus, species, color)
values
  ('bird_2', 'species_2', color_va_ty('gray'));

insert into birds
  (gunus, species, color)
values
  ('bird_3', 'species_3', color_va_ty('blue', 'yellow', 'red'));

commit;
/

select b.*
  from birds b
 where 'blue' in (select * from table(b.color))
    or 'green' in (select * from table(b.color));

/

-------------------------------Example 2-----------------------------------

create or replace type list_of_names_n_ty is table of varchar2(100);
/

declare
  happyfamily list_of_names_n_ty := list_of_names_n_ty();
begin
  happyfamily.extend(6);
  happyfamily(1) := 'n1';
  happyfamily(2) := 'n2';
  happyfamily(3) := 'n3';
  happyfamily(4) := 'n4';
  happyfamily(5) := 'n5';
  happyfamily(6) := 'n6';

  for rec in (select column_value family_name
                from table(happyfamily)
               order by family_name) loop
    dbms_output.put_line(rec.family_name);
  end loop;
end;





