/*
create or replace package TYPE_API is
  type vc_ix_tab_ty is table of varchar2(100) index by pls_integer;
  type vc_tab_ty is table of varchar2(100);
  type va4_arr_ty is varray(4) of varchar2(100);
end TYPE_API;
/
*/

declare
  names TYPE_API.vc_ix_tab_ty;
  l_n   pls_integer;

  colors TYPE_API.vc_tab_ty := TYPE_API.vc_tab_ty();

  cars TYPE_API.va4_arr_ty := TYPE_API.va4_arr_ty();
begin
  dbms_output.put_line('***************************Associative Array***************************');

  names(1) := 'a1';
  names(-9) := 'a-9';
  names(10) := 'a10';
  names(0) := 'a0';

  l_n := names.first;
  while (l_n is not null) loop
    dbms_output.put_line(names(l_n));
    l_n := names.next(l_n);
  end loop;

  dbms_output.put_line('***************************Nested Table***************************');

  colors.extend(4);
  colors(1) := 'c1';
  colors(4) := 'c4';

  for c in colors.first .. colors.last loop
    dbms_output.put_line(colors(c));
  end loop;

  dbms_output.put_line('***************************VArray***************************');
  
  cars.extend(4);
  cars(1) := 'ca1';
  cars(2) := 'ca2';
  cars(4) := 'ca4';

  for ca in cars.first .. cars.last loop
    dbms_output.put_line(cars(ca));
  end loop;

end;
