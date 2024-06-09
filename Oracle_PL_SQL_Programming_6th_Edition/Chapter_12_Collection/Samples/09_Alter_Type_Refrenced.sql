create or replace type v2a_invalidate_ty is varray(2) of varchar(5);
create or replace type v2a_cascade_ty is varray(2) of varchar(5);
/

create table assotiative_invalidate_test_tab
(
tid varchar2(10),
names v2a_invalidate_ty
);
/

create table assotiative_cascade_test_tab
(
tid varchar2(10),
names v2a_cascade_ty
);
/

declare
  l_i_names v2a_invalidate_ty := v2a_invalidate_ty('n1', 'n4');
  l_c_names v2a_cascade_ty := v2a_cascade_ty('n1', 'n4');
begin
  insert into assotiative_invalidate_test_tab
    (tid, names)
  values
    ('id1', l_i_names);

  insert into assotiative_cascade_test_tab
    (tid, names)
  values
    ('id1', l_c_names);
end;
/

select * from assotiative_invalidate_test_tab;
ALTER TYPE v2a_invalidate_ty MODIFY ELEMENT TYPE VARCHAR2(14) invalidate;
select * from assotiative_invalidate_test_tab;

select * from assotiative_cascade_test_tab;
ALTER TYPE v2a_cascade_ty MODIFY ELEMENT TYPE VARCHAR2(7) cascade;
select * from assotiative_cascade_test_tab;
