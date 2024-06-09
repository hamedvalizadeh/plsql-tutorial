create or replace type pet_ty is object
(
  tag_no integer,
  name   varchar2(60),
  member function set_tag_no(new_tag_no in integer) return pet_ty
);
/

create or replace type pet_visit_ty is object
(
visit_date date,
reason varchar2(200)
);
/

create or replace type pet_visist_n_ty is table of pet_visit_ty;
/

create or replace type pet_ty is object
(
  tag_no integer,
  name   varchar2(60),
  cares pet_visist_n_ty,
  member function set_tag_no(new_tag_no in integer) return pet_ty
);
/

declare
  type pet_n_ty is table of pet_ty;
  pets pet_n_ty := pet_n_ty(
  pet_ty(14, 'p14', pet_visist_n_ty(pet_visit_ty(sysdate, 'for fun'), pet_visit_ty(sysdate, 'eye problem'))),
  pet_ty(53, 'p53', pet_visist_n_ty(pet_visit_ty(sysdate, 'foot pain')))
  );
begin
  for pi in pets.first .. pets.last loop
    dbms_output.put_line(pi || ' :: ' || pets(pi).tag_no || ' :: ' || pets(pi).name);
    for pc in pets(pi).cares.first .. pets(pi).cares.last loop
      dbms_output.put_line('   - ' || pets(pi).cares(pc).visit_date || ' :: ' || pets(pi).cares(pc).reason);
    end loop;
    /*dbms_output.put_line(pi || ' :: ' || pets(pi).care.visit_date || ' :: ' || pets(pi).care.reason);*/
  end loop;
end;
