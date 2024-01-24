create or replace type pet_ty is object
(
  tag_no integer,
  name   varchar2(60),
  member function set_tag_no(new_tag_no in integer) return pet_ty
)
;

declare
  type pet_n_ty is table of pet_ty;
  pets pet_n_ty := pet_n_ty(pet_ty(14, 'p1'), pet_ty(27, 'p2'));
begin
  for pi in pets.first .. pets.last loop
    dbms_output.put_line(pi || ' :: ' || pets(pi).tag_no || ' :: ' || pets(pi).name);
  end loop;
end;
