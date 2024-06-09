declare
  cursor cur is(
    select * from countries);

  type vc_ix_ty is table of varchar2(100) index by pls_integer;
  col_countriy_id vc_ix_ty;
  l_first         pls_integer;
  
  type vc_tab_ty is table of varchar2(100);
  c_c vc_tab_ty := vc_tab_ty();
begin
  c_c.extend(1545);
  c_c(1) := 'c1';
  c_c(2) := 'c2';
  c_c(3) := 'c3';
  c_c(4) := 'c4';
  dbms_output.put_line(c_c.limit);
  
  for r in cur loop
    col_countriy_id((col_countriy_id.COUNT) + 1) := r.country_id;
  end loop;

  l_first := col_countriy_id.first;
  while (l_first is not null) loop
    dbms_output.put_line(l_first || ' - ' || col_countriy_id(l_first));
    l_first := col_countriy_id.next(l_first);
  end loop;
end;
