

grant execute on utl_http to sqlu1;
grant execute on dbms_lock to ot;



--select * from dba_network_acls;

begin
  --dbms_network_acl_admin.drop_acl('www.xml');



/*
dbms_network_acl_admin.create_acl (
     acl => 'www.xml',
     description => 'WWW ACL', 
     principal => 'OT',
     is_grant => TRUE,
     privilege => 'resolve');
*/

     
     
     

/*
          dbms_network_acl_admin.assign_acl(
     acl => 'www.xml',
     host => '*',
     lower_port => 443
 );
*/

     
/*
dbms_network_acl_admin.add_privilege(
     acl => 'www.xml',
     principal => 'OT',
     is_grant => true,
     privilege => 'resolve'
 );
*/
 
end;




/*
declare
  req utl_http.req;
  res utl_http.resp;
  url varchar2(4000) := 'https://mocki.io/v1/0c7ab249-7908-46d1-ae62-22ea4ed8ab47';
  buffer varchar2(4000); 
  /*
  name varchar2(4000);
  
  content varchar2(4000) := '{"room":"'||p_room_id||'", "partySize":"'||p_party_Size||'"}';
  */
 
begin
  req := utl_http.begin_request(url, 'GET');
 /*
  utl_http.set_header(req, 'user-agent', 'mozilla/4.0'); 
  utl_http.set_header(req, 'content-type', 'application/json'); 
  utl_http.set_header(req, 'Content-Length', length(content));
 
  utl_http.write_text(req, content);
 */
  res := utl_http.get_response(req);
  -- process the response from the HTTP call
  begin
    loop
      utl_http.read_line(res, buffer);
      dbms_output.put_line(buffer);
    end loop;
    utl_http.end_response(res);
  exception
    when utl_http.end_of_body 
    then
      utl_http.end_response(res);
  end;
end;

*/
