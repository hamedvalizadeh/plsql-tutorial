create table color_model
(
color_type varchar2(12),
colors color_tab_ty
)
nested table colors store as color_st
/

insert into color_model
  (color_type, colors)
values
  ('RGB', color_tab_ty('Red', 'Green', 'Blue'));
/

declare
  l_colors color_tab_ty;
begin
  select colors into l_colors from color_model where color_type = 'RGB';

  for i in l_colors.first .. l_colors.last loop
    dbms_output.put_line(l_colors(i));
  end loop;

end;
/

declare
  l_colors color_tab_ty;
begin
  select colors into l_colors from color_model where color_type = 'RGB';

  for i in l_colors.first .. l_colors.last loop
    if (l_colors(i) = 'Red') then
      l_colors(i) := 'Fuchsia';
    end if;
  end loop;

  insert into color_model (color_type, colors) values ('FGB', l_colors);

  commit;

end;

select * from color_model c, table(c.colors)
