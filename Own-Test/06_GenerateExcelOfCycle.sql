declare
  --HINT: persian date format is (( YYYY/MM/DD ))

  l_filename_s varchar(50) := '&file_name';

  l_start_persain_d MYTYPES.varchar10 := '&Start_Date';
  l_start_d         MYTYPES.myDate;

  l_end_persain_d MYTYPES.varchar10 := '&End_Date';
  l_end_d         MYTYPES.myDate;

  l_total_period_days_n      MYTYPES.int3;
  l_cycle_index_loop_check_n MYTYPES.int3 := 1;
  l_cycle_index_n            MYTYPES.int3 := 1;

  l_cycle_list MYTYPES.l_cycle_list_type;

  cycle_index MYTYPES.myBINARY_INTEGER;

  v_file UTL_FILE.FILE_TYPE;

begin

  l_start_d := pesriantomiladidate(l_start_persain_d);
  l_end_d   := pesriantomiladidate(l_end_persain_d);

  l_total_period_days_n := (l_end_d - l_start_d) + 1;

  for i in 1 .. l_total_period_days_n loop
  
    if ((mod(l_cycle_index_loop_check_n, 14) = 0)) then
    
      --HINT: Work Period
      l_cycle_list(l_cycle_index_n).type_name := 'Work';
      l_cycle_list(l_cycle_index_n).start_date := l_start_d - 13;
      l_cycle_list(l_cycle_index_n).start_date_persian := (miladitoPesriandate(l_start_d - 13));
      l_cycle_list(l_cycle_index_n).end_date := l_start_d;
      l_cycle_list(l_cycle_index_n).end_date_persian := (miladitoPesriandate(l_start_d));
    
      --HINT: Rest Period
      l_start_d       := l_start_d + 8;
      l_cycle_index_n := l_cycle_index_n + 1;
    
      l_cycle_list(l_cycle_index_n).type_name := 'Rest';
      l_cycle_list(l_cycle_index_n).start_date := l_start_d - 7;
      l_cycle_list(l_cycle_index_n).start_date_persian := (miladitoPesriandate(l_start_d - 7));
      l_cycle_list(l_cycle_index_n).end_date := l_start_d - 1;
      l_cycle_list(l_cycle_index_n).end_date_persian := (miladitoPesriandate(l_start_d - 1));
    
      l_cycle_index_n := l_cycle_index_n + 1;
    
      l_cycle_index_loop_check_n := l_cycle_index_loop_check_n + 1;
    
    elsif (l_start_d < l_end_d) then
      l_start_d                  := l_start_d + 1;
      l_cycle_index_loop_check_n := l_cycle_index_loop_check_n + 1;
    end if;
  
  end loop;

  v_file := UTL_FILE.FOPEN(location     => 'TEMP_DIR',
                           filename     => l_filename_s || '.csv',
                           open_mode    => 'w',
                           max_linesize => 32767);

  UTL_FILE.PUT_LINE(v_file, 'Number,Type,Start,End');

  cycle_index := l_cycle_list.first;
  while cycle_index is not null loop
  
    UTL_FILE.PUT_LINE(v_file,
                      cycle_index || ',' || l_cycle_list(cycle_index).type_name || ',' || l_cycle_list(cycle_index).start_date_persian || ',' || l_cycle_list(cycle_index).end_date_persian);
  
    cycle_index := l_cycle_list.NEXT(cycle_index);
  
  end loop;

  UTL_FILE.FCLOSE(v_file);

end;
