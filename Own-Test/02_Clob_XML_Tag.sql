SELECT ExtractValue(XMLTYPE.createXML(profile_binary_value),
                    '/QuickReportParameterSet/NAME/text()',
                    'xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:ifsrecord="urn:ifsworld-com:ifsrecord" xmlns="urn:ifsworld-com:schemas:quick_report_parameter_set"') report_name,
       
       t.profile_binary_value as a,
       XMLTYPE               (t.profile_binary_value).EXTRACT('//name/text()'               ).getStringVal()                as b,
       XMLTYPE               (t.profile_binary_value).EXTRACT('//QuickReportParameterSet/NAME/text()'               , 'xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:ifsrecord="urn:ifsworld-com:ifsrecord" xmlns="urn:ifsworld-com:schemas:quick_report_parameter_set"'               ).getStringVal()                as c
  FROM FNDRR_CLIENT_PROFILE_VALUE_TAB t
 where t.Binary_value_type = 'DataRow'
   and t.profile_section like
       'User/Windows/Application Data/QuickReport/1070%';
