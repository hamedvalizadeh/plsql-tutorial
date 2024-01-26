declare
    v_req       utl_http.req;
    v_res       utl_http.resp;
    v_buffer    varchar2(4000); 
    v_body      varchar2(4000) := '{"field":"value"}'; -- Your JSON
begin
    -- Set connection.
    v_req := utl_http.begin_request('https://mocki.io/v1/0c7ab249-7908-46d1-ae62-22ea4ed8ab47', 'POST');
    utl_http.set_authentication(v_req, 'your_username','your_password');
    utl_http.set_header(v_req, 'content-type', 'application/json'); 
    utl_http.set_header(v_req, 'Content-Length', length(v_body));
    
    -- Invoke REST API.
    utl_http.write_text(v_req, v_body);
  
    -- Get response.
    v_res := utl_http.get_response(v_req);
    begin
        loop
            utl_http.read_line(v_res, v_buffer);
            -- Do something with buffer.
            dbms_output.put_line(v_buffer);
        end loop;
        utl_http.end_response(v_res);
    exception
        when utl_http.end_of_body then
            utl_http.end_response(v_res);
    end;
end;
