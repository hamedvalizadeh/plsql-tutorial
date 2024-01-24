create or replace type List_ty is table of varchar2(100);
/

create or replace procedure delete_list_items_but_last_one(the_list in out List_ty) is
  l_first       number := the_list.first;
  l_one_to_last number := the_list.prior(the_list.last);
begin
  the_list.delete(l_first, l_one_to_last);
end;
/

declare
  my_list List_ty := List_ty('L1', 'L2', 'L3', 'L4', 'L5', 'L6', 'L7', 'L8');
begin
  delete_list_items_but_last_one(my_list);

  for i in my_list.first .. my_list.last loop
    dbms_output.put_line(my_list(i));
  end loop;
end;
/

declare
  v_code  NUMBER;
  v_errm  VARCHAR2(64);
  v_block VARCHAR2(64);
  type va4_ty is varray(4) of varchar2(100);
  names va4_ty := va4_ty('n1', 'n2', 'n3');

  families va4_ty;

  type vc_tab_ty is table of varchar2(100);
  adrs  vc_tab_ty;
  vAdrs va4_ty;
  
  colors color_tab_ty := color_tab_ty();

begin
  begin
    dbms_output.put_line('names Count: ' || names.count);
  
  exception
    when others then
      v_block := 'Count 1';
      v_code  := SQLCODE;
      v_errm  := SUBSTR(SQLERRM, 1, 64);
  end;

  begin
    dbms_output.put_line('families Count: ' || families.count);
  
  exception
    when others then
      v_block := 'Count 2';
      v_code  := SQLCODE;
      v_errm  := SUBSTR(SQLERRM, 1, 64);
  end;

  begin
    adrs := vc_tab_ty('a1', 'a2', 'a3');
    for a in adrs.first .. adrs.last loop
      dbms_output.put_line(adrs(a));
    end loop;
  
    dbms_output.put_line('**************Delete');
    adrs.delete(2);
    for a in adrs.first .. adrs.last loop
      dbms_output.put_line(adrs(a));
    end loop;
  
  exception
    when others then
      v_block := 'Delete';
      v_code  := SQLCODE;
      v_errm  := SUBSTR(SQLERRM, 1, 64);
  end;

  begin
    vAdrs := va4_ty('n1', 'n2', 'n3');
    vAdrs.delete();
    for a in vAdrs.first .. vAdrs.last loop
      dbms_output.put_line(vAdrs(a));
    end loop;
  exception
    when others then
      v_block := 'Delete VArray';
      v_code  := SQLCODE;
      v_errm  := SUBSTR(SQLERRM, 1, 64);
  end;
  
  begin
    if (colors.exists(1)) then
      dbms_output.put_line('Item 1 Exist');
    else
      dbms_output.put_line('Item 1 Not Exist');      
    end if;
  end;

  DBMS_OUTPUT.PUT_LINE(v_block || ' # ' || v_code || ' # ' || v_errm);
end;
