# Connect as `SYSBDA`

to use `SQL/Plus` we can run power-shell and execute command `sqlplus /nolog`, we will be connected to sell on `SQL/Plus`.  then execute the command `CONNECT / AS SYSDBA`.



# Switch To Another User

if we have a user in named `Hamed` with password `Hamed123456`, to switch to `Hamed` we can execute the command `connect hamed` and the enter the wanted password.





# To Connect to desired Service

there is a variable named `ORACLE_SID` that shows the service the current session is connected to. to find this value execute the query `select INSTANCE_NAME from v$instance;`. 

imagine we have 2 instances of oracle services installed in our machine named `orcl` and `localtestdb`, to connect to each one we can execute following commands:

```plsql
connect Hamed@"orcl"
connect Hamed@"localtestdb"
```



**HINT:** for complete connection details refer to   following link:

[]: https://docs.oracle.com/en/database/oracle/oracle-database/19/spmdu/step-4-submit-the-sql-plus-connect-command.html	"Complete Oracle SQL*PLUS Connection command"

