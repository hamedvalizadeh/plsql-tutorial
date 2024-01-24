declare
  subtype temp is number;
  subtype cor_axis is pls_integer;

  type temp_x_ty is table of temp index by cor_axis;
  type temp_xy_ty is table of temp_x_ty index by cor_axis;
  type temp_xyz_ty is table of temp_xy_ty index by cor_axis;

  spacial_temps temp_xyz_ty;

  x pls_integer;
  y pls_integer;
  z pls_integer;

begin
  spacial_temps(1)(1)(1) := 111;
  spacial_temps(1)(1)(2) := 112;
  spacial_temps(1)(1)(3) := 113;

  spacial_temps(1)(2)(1) := 121;
  spacial_temps(1)(2)(2) := 122;
  spacial_temps(1)(2)(3) := 123;

  spacial_temps(1)(3)(1) := 131;
  spacial_temps(1)(3)(2) := 132;
  spacial_temps(1)(3)(3) := 133;

  spacial_temps(2)(1)(1) := 211;
  spacial_temps(2)(1)(2) := 212;
  spacial_temps(2)(1)(3) := 213;

  spacial_temps(2)(2)(1) := 221;
  spacial_temps(2)(2)(2) := 222;
  spacial_temps(2)(2)(3) := 223;

  spacial_temps(2)(3)(1) := 231;
  spacial_temps(2)(3)(2) := 232;
  spacial_temps(2)(3)(3) := 233;

  spacial_temps(3)(1)(1) := 311;
  spacial_temps(3)(1)(2) := 312;
  spacial_temps(3)(1)(3) := 313;

  spacial_temps(3)(2)(1) := 321;
  spacial_temps(3)(2)(2) := 322;
  spacial_temps(3)(2)(3) := 323;

  spacial_temps(3)(3)(1) := 331;
  spacial_temps(3)(3)(2) := 332;
  spacial_temps(3)(3)(3) := 333;

  x := spacial_temps.first;
  while (x is not null) loop
    dbms_output.put_line(x);
    y := spacial_temps(x).first;
    while (y is not null) loop
      dbms_output.put_line(' ++ ' || y);
      z := spacial_temps(x)(y).first;
      while (z is not null) loop
        dbms_output.put_line('    -- ' || z || ' :: ' || spacial_temps(x) (y) (z));
        z := spacial_temps(x)(y).next(z);
      end loop;
      y := spacial_temps(x).next(y);
    end loop;
    x := spacial_temps.next(x);
  end loop;

end;
/

create or replace package multidim is
  type dim1_ty is table of varchar2(32767) index by pls_integer;
  type dim2_ty is table of dim1_ty index by pls_integer;
  type dim3_ty is table of dim2_ty index by pls_integer;

  procedure setcell(arr      in out dim3_ty,
                    dim1_in  in pls_integer,
                    dim2_in  in pls_integer,
                    dim3_in  in pls_integer,
                    value_in in varchar2);

  function getcell(arr     in out dim3_ty,
                   dim1_in in pls_integer,
                   dim2_in in pls_integer,
                   dim3_in in pls_integer) return varchar2;

  function exist(arr     in out dim3_ty,
                 dim1_in in pls_integer,
                 dim2_in in pls_integer,
                 dim3_in in pls_integer) return boolean;

end multidim;
/

create or replace package body multidim is

  procedure setcell(arr      in out dim3_ty,
                    dim1_in  in pls_integer,
                    dim2_in  in pls_integer,
                    dim3_in  in pls_integer,
                    value_in in varchar2) is
  begin
    arr(dim3_in)(dim2_in)(dim1_in) := value_in;
  end setcell;

  function getcell(arr     in out dim3_ty,
                   dim1_in in pls_integer,
                   dim2_in in pls_integer,
                   dim3_in in pls_integer) return varchar2 is
  begin
    return arr(dim3_in)(dim2_in)(dim1_in);
  end getcell;

  function exist(arr     in out dim3_ty,
                 dim1_in in pls_integer,
                 dim2_in in pls_integer,
                 dim3_in in pls_integer) return boolean is
    l_v varchar2(32767);
  begin
    l_v := arr(dim3_in) (dim2_in) (dim1_in);
    return true;
  exception
    when no_data_found then
      return false;
  end exist;

end multidim;
/

declare
  arr multidim.dim3_ty;
begin
  multidim.setcell(arr, 1, 5, 800, 'v1');
  multidim.setcell(arr, 1, 15, 900, 'v2');
  multidim.setcell(arr, 5, 5, 700, 'v3');
  multidim.setcell(arr, 5, 5, 805, 'v4');

  dbms_output.put_line(multidim.getcell(arr, 5, 5, 805));
  
  dbms_output.put_line(case(multidim.exist(arr, 5, 5, 400)) when(TRUE) then('OK') else('Not') end);
  dbms_output.put_line(case(multidim.exist(arr, 5, 5, 805)) when(TRUE) then('OK') else('Not') end);
  
  dbms_output.put_line(arr.count);

end;
