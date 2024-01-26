--Source: https://oracle-base.com/articles/11g/fine-grained-access-to-network-services-11gr1

--HINT: should be connected as (( CONN sys/password@db11g AS SYSDBA )) to be able to run following blocks
--HINT: principal is case sensitive
--HINT: privilege - Use 'connect' for UTL_TCP, UTL_SMTP, UTL_MAIL and UTL_HTTP access. Use 'resolve' for UTL_INADDR name/IP resolution. The text is case sensitive.
BEGIN
  DBMS_NETWORK_ACL_ADMIN.create_acl (
    acl          => '{a name for file}.xml', 
    description  => '{description of the acl}',
    principal    => '{username or role name}',
    is_grant     => {TRUE/FALSE},
    privilege    => 'connect',
    start_date   => SYSTIMESTAMP,
    end_date     => NULL);

  COMMIT;
END;

--HINT: Additional users or roles are added to the ACL using the ADD_PRIVILEGE procedure
BEGIN
  DBMS_NETWORK_ACL_ADMIN.add_privilege ( 
    acl         => '{a name for file}.xml',
    principal   => '{username or role name}',
    is_grant    => {TRUE/FALSE}, 
    privilege   => 'connect', 
    position    => NULL, 
    start_date  => NULL,
    end_date    => NULL);

  COMMIT;
END;

--HINT: Privileges are removed using the DELETE_PRIVILEGE procedure. If the IS_GRANT or PRIVILEGE parameters are NULL, all grants or privileges for the ACL and principal are removed.
BEGIN
  DBMS_NETWORK_ACL_ADMIN.delete_privilege ( 
    acl         => '{a name for file}.xml', 
    principal   => '{username or role name}',
    is_grant    => FALSE, 
    privilege   => 'connect');

  COMMIT;
END;

--HINT: ACLs are deleted using the DROP_ACL procedure.
BEGIN
  DBMS_NETWORK_ACL_ADMIN.drop_acl ( 
    acl         => 'test_acl_file.xml');

  COMMIT;
END;

--HINT: The code below shows the ACL created previously being assigned to a specific IP address and a subnet.
BEGIN
  DBMS_NETWORK_ACL_ADMIN.assign_acl (
    acl         => '{a name for file}.xml', 
    host        => '{IP/Domain}', 
    lower_port  => {Port},
    upper_port  => NULL); 
    
  COMMIT;
END;

--HINT: The UNASSIGN_ACL procedure allows you to manually drop ACL assignments. It uses the same parameter list as the ASSIGN_ACL procedure, with any NULL parameters acting as wildcards.
BEGIN
  DBMS_NETWORK_ACL_ADMIN.unassign_acl (
    acl         => '{a name for file}.xml', 
    host        => '{IP/Domain}',
    lower_port  => {Port},
    upper_port  => NULL); 

  COMMIT;
END;

--HINT: The DBA_NETWORK_ACLS view displays information about network and ACL assignments.
SELECT host, lower_port, upper_port, acl
FROM   dba_network_acls;

--HINT: The DBA_NETWORK_ACL_PRIVILEGES view displays information about privileges associated with the ACL.
SELECT acl,
       principal,
       privilege,
       is_grant,
       TO_CHAR(start_date, 'DD-MON-YYYY') AS start_date,
       TO_CHAR(end_date, 'DD-MON-YYYY') AS end_date
FROM   dba_network_acl_privileges;

--HINT: The USER_NETWORK_ACL_PRIVILEGES view displays the current users network ACL settings.
SELECT host, lower_port, upper_port, privilege, status
FROM   user_network_acl_privileges;


--HINT: also privileges can be checked using the CHECK_PRIVILEGE and CHECK_PRIVILEGE_ACLID functions of the DBMS_NETWORK_ACL_ADMIN package.
SELECT DECODE(
         DBMS_NETWORK_ACL_ADMIN.check_privilege('{a name for file}.xml',  '{username or role name}', 'connect'),
         1, 'GRANTED', 0, 'DENIED', NULL) privilege 
FROM dual;

--HINT: The DBMS_NETWORK_ACL_UTILITY package contains functions to help determine possible matching domains. The DOMAINS table function returns a collection of all possible references that may affect the specified host, domain, IP address or subnet, in order of precedence.
SELECT *
FROM   TABLE(DBMS_NETWORK_ACL_UTILITY.domains('oel5-11g.localdomain'));
         
SELECT *
FROM   TABLE(DBMS_NETWORK_ACL_UTILITY.domains('192.168.2.3'));

--HINT: The DOMAIN_LEVEL function returns the level of the specified host, domain, IP address or subnet.
SELECT DBMS_NETWORK_ACL_UTILITY.domain_level('oel5-11g.localdomain')
FROM   dual;

SELECT DBMS_NETWORK_ACL_UTILITY.domain_level('192.168.2.3')
FROM   dual;

--HINT: These functions may be useful for when querying the ACL views for possible matches to a specific host, domain, IP address or subnet.
SELECT host,
       lower_port,
       upper_port,
       acl,
       DECODE(
         DBMS_NETWORK_ACL_ADMIN.check_privilege_aclid(aclid,  '{username or role name}', 'connect'),
         1, 'GRANTED', 0, 'DENIED', null) PRIVILEGE
FROM   dba_network_acls
WHERE  host IN (SELECT *
                FROM   TABLE(DBMS_NETWORK_ACL_UTILITY.domains('10.1.10.191')))
ORDER BY 
       DBMS_NETWORK_ACL_UTILITY.domain_level(host) desc, lower_port, upper_port;
       
--Example: the API is created with Mockoon tool installed loacally.
DECLARE
  l_url            VARCHAR2(400) := 'http://0.0.0.0:3001/api/test/getname';
  l_http_request   UTL_HTTP.req;
  l_http_response  UTL_HTTP.resp;
  value VARCHAR2(1024);
BEGIN
  l_http_request  := UTL_HTTP.begin_request(l_url);
  l_http_response := UTL_HTTP.get_response(l_http_request);
  dbms_output.put_line(l_http_response.status_code);
  LOOP
    UTL_HTTP.READ_LINE(l_http_response, value, TRUE);
    dbms_output.put_line(value);
  END LOOP;
  UTL_HTTP.end_response(l_http_response);
END;



