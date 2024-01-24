declare
  type ia_ty is table of number index by pls_integer;
  type itab_ty is table of number;
  type iv_ty is varray(10) of number;

  total number;

  ia_ages   ia_ty;
  itab_ages itab_ty := itab_ty();
  iv_ages   iv_ty := iv_ty();

  ia_first pls_integer;
  ia_last pls_integer;

begin
  ia_ages(1) := 10;
  ia_ages(-81) := 70;
  ia_ages(150) := 15;
  ia_ages(900) := 145;

  itab_ages.extend(5);
  itab_ages(1) := 36;
  itab_ages(2) := 12;
  itab_ages(3) := 65;
  itab_ages(4) := 85;
  itab_ages(5) := 15;
  itab_ages.delete(4);

  iv_ages.extend(6);
  iv_ages(1) := 18;
  iv_ages(2) := 9;
  iv_ages(3) := 3;
  iv_ages(4) := 8;
  iv_ages(5) := 5;
  iv_ages(6) := 2;
  iv_ages.trim(3);

  ia_first := ia_ages.first;
  total    := 0;
  loop
    exit when ia_first is null;
    total    := total + ia_ages(ia_first);
    ia_first := ia_ages.next(ia_first);
  end loop;
  dbms_output.put_line('Assotiative Total From First' || ' = ' || total);
    
  ia_last := ia_ages.last;
  total    := 0;
  loop
    exit when ia_last is null;
    total    := total + ia_ages(ia_last);
    ia_last := ia_ages.prior(ia_last);
  end loop;
  dbms_output.put_line('Assotiative Total From Last' || ' = ' || total);
  
  total := 0;
  for i in itab_ages.first .. itab_ages.last loop
    if (itab_ages.exists(i)) then
      total := total + itab_ages(i);
    end if;
  end loop;
  dbms_output.put_line('Nested Table Total' || ' = ' || total);
  
  total := 0;
  for i in iv_ages.first .. iv_ages.last loop
    total := total + iv_ages(i);
  end loop;
  dbms_output.put_line('VArray Total' || ' = ' || total);
  
end;
