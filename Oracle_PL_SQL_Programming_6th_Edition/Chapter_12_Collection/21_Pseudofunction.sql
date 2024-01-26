create or replace type color_n_ty is table of varchar2(30);
/
create or replace type color_va_ty is varray(16) of varchar2(30);
/
create table color_models
(
model_type varchar2(12),
colors color_va_ty
);
/

insert into color_models
(model_type, colors)
values
('m1', color_va_ty('m1_c1', 'm1_c2'));

insert into color_models
(model_type, colors)
values
('m2', color_va_ty('m2_c1', 'm2_c2', 'm2_c3'));

insert into color_models
(model_type, colors)
values
('m3', color_va_ty('m3_c1'));

commit;
/

select COLUMN_VALUE my_colors
  from table (select cast(colors as color_n_ty)
                from color_models
               where model_type = 'm2');
