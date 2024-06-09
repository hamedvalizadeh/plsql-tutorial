create or replace type auto_spec_ty as object
(
  make             varchar2(100),
  model            varchar2(100),
  available_colors color_tab_ty
)
;

/

create table auto_spec_tab of auto_spec_ty 
nested table available_colors store as available_colors_st;
