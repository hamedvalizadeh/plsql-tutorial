create or replace package string_tracker is
  subtype name_t is varchar2(32767);
  type v_aa_ty is table of boolean index by name_t;
  procedure use_str(k_n in name_t);
  function is_used(k_n in varchar2) return boolean;
  function get_names return v_aa_ty;
end string_tracker;
/

create or replace package body string_tracker is
  names v_aa_ty;
  procedure use_str(k_n in name_t) is
  begin
    names(k_n) := TRUE;
  end use_str;

  function is_used(k_n in varchar2) return boolean is
  begin
    return names.exists(k_n);
  end;

  function get_names return v_aa_ty is
  begin
    return names;
  end;

end string_tracker;
/

declare
  names   string_tracker.v_aa_ty;
  l_index string_tracker.name_t;
begin
  string_tracker.use_str('b');
  names   := string_tracker.get_names;
  l_index := names.first;
  while (l_index is not null) loop
    dbms_output.put_line(l_index || ' = ' || case names(l_index)
                           when TRUE then
                            'T'
                           when FALSE then
                            'F'
                           else
                            'N'
                         end);
    l_index := names.next(l_index);
  end loop;
end;
/
