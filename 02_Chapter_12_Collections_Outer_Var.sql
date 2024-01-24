declare
  type da10_arr_ty is varray(10) of date;
  dates da10_arr_ty := da10_arr_ty();
begin
  dates.EXTEND(2);
  dates(1) := sysdate;

  declare
    function inner_function(in_dates in da10_arr_ty) return number is
      l_dates_coun number;
    begin
      l_dates_coun := in_dates.count;
      return l_dates_coun;
    end;
  begin
    dbms_output.put_line(inner_function(dates));
  end;

end;
