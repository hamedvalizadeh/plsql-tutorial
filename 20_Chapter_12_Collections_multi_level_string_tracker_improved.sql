create or replace package string_tracker_3 is
  subtype maxvarchar2_ty is varchar2(32767);
  subtype list_name_ty is maxvarchar2_ty;
  subtype variable_name_ty is maxvarchar2_ty;
  procedure create_list(list_name_in  in list_name_ty,
                        description_n in varchar2 default null);
  procedure mark_as_used(list_name_in     in list_name_ty,
                         variable_name_in in variable_name_ty);
  function string_in_use(list_name_in     in list_name_ty,
                         variable_name_in in variable_name_ty) return BOOLEAN;
end string_tracker_3;
/

create or replace package body string_tracker_3 is

  type used_aa_ty is table of boolean index by variable_name_ty;

  type list_rc_ty is record(
    des            maxvarchar2_ty,
    list_of_values used_aa_ty);

  type list_of_lists_aa_ty is table of list_rc_ty index by list_name_ty;

  g_list_of_lists list_of_lists_aa_ty;

  procedure create_list(list_name_in  in list_name_ty,
                        description_n in varchar2 default null) is
  begin
    g_list_of_lists(list_name_in).des := description_n;
  end create_list;

  procedure mark_as_used(list_name_in     in list_name_ty,
                         variable_name_in in variable_name_ty) is
  begin
    g_list_of_lists(list_name_in).list_of_values(variable_name_in) := TRUE;
  end mark_as_used;

  function string_in_use(list_name_in     in list_name_ty,
                         variable_name_in in variable_name_ty) return BOOLEAN is
  begin
    return g_list_of_lists(list_name_in).list_of_values.EXISTS(variable_name_in);
  
  exception
    when NO_DATA_FOUND then
      return FALSE;
  end string_in_use;

end string_tracker_3;
/

declare
  n_ string_tracker_3.list_name_ty := 'n1';
  v_ string_tracker_3.variable_name_ty := 'v1';
  r_ BOOLEAN;
begin
  string_tracker_3.create_list(n_, 'd1');
  string_tracker_3.mark_as_used(n_, v_);
  dbms_output.put_line(sys.diutil.bool_to_int(string_tracker_3.string_in_use('n1', 'v1')));
  dbms_output.put_line(sys.diutil.bool_to_int(string_tracker_3.string_in_use(n_, v_)));
  dbms_output.put_line(sys.diutil.bool_to_int(string_tracker_3.string_in_use(n_, 'v2')));
end;

