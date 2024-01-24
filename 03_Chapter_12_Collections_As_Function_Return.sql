create or replace type color_tab_ty is table of varchar2(100)
/

create table plant_tab
(plant_id number, name varchar2(100), colors color_tab_ty)
NESTED TABLE colors STORE AS color_tab_s;
/


declare
  l_colors color_tab_ty := color_tab_ty();
begin
  l_colors.extend(5);
  l_colors(1) := 'c1';
  l_colors(2) := 'c2';
  l_colors(3) := 'c3';
  l_colors(4) := 'c4';
  l_colors(5) := 'c5';

  insert into plant_tab (plant_id, name, colors) values (1, 'p1', l_colors);

  l_colors := color_tab_ty();
  l_colors.extend(3);
  l_colors(1) := 'ca1';
  l_colors(2) := 'ca2';
  l_colors(3) := 'ca3';
  
  insert into plant_tab (plant_id, name, colors) values (2, 'p2', l_colors);
  
end;
/

create or replace function get_plant_colors(l_plant_id in number)
  return color_tab_ty is
  plant_colors color_tab_ty;
begin
  select colors
    into plant_colors
    from plant_tab
   where plant_id = l_plant_id;
  return plant_colors;
end;
/

declare
  found_colors color_tab_ty;
begin
  found_colors := get_plant_colors(2);

  for c in found_colors.first .. found_colors.last loop
    dbms_output.put_line(found_colors(c));
  end loop;
  
  dbms_output.put_line(get_plant_colors(2)(1));
  
end;





