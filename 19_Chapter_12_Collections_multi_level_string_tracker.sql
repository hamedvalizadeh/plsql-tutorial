create or replace package string_tracker_2 is

  subtype maxvarchar_ty is varchar2(32767);
  subtype list_name_ty is maxvarchar_ty;
  subtype variable_name_ty is maxvarchar_ty;
  
  procedure create_list(list_name_in   in list_name_ty,
                        description_in in varchar2 default null);
                        
  procedure mark_as_read(list_name_in     in list_name_ty,
                         variable_name_in in variable_name_ty);

  function string_in_use(list_name_in     in list_name_ty,
                         variable_name_in in variable_name_ty) return boolean;
end string_tracker_2;
/

create or replace package body string_tracker_2 is

  type used_aa_ty is table of boolean index by variable_name_ty;

  type list_rec is record(
    description    maxvarchar_ty,
    list_of_values used_aa_ty);

  type list_of_lists_aa_ty is table of list_rec index by list_name_ty;

  g_list_of_lists list_of_lists_aa_ty;

  procedure create_list(list_name_in   in list_name_ty,
                        description_in in varchar2 default null) is
  begin
    g_list_of_lists(list_name_in).description := description_in;
  end create_list;

  procedure mark_as_read(list_name_in     in list_name_ty,
                         variable_name_in in variable_name_ty) is
  begin
    g_list_of_lists(list_name_in).list_of_values(variable_name_in) := TRUE;
  end mark_as_read;

  function string_in_use(list_name_in     in list_name_ty,
                         variable_name_in in variable_name_ty) return boolean is
  begin
    return g_list_of_lists(list_name_in).list_of_values.exists(variable_name_in);
  exception
    when no_data_found then
      return FALSE;
    
  end string_in_use;

end string_tracker_2;
/
