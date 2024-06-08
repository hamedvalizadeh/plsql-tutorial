# Install Oracle Database Server

to be able to create database in our local machine, first we should install an instance of oracle database server in our machine. we installed oracle database version `11.2.0`.



**HINT:** in the installation steps a be cautious about the password asked for `sys` user, and save it in a place that you do not forget. we set it `Hamed123456`.  



# Create Database

after installing oracle database server a database named `ORCL` is created by default.

but also we can create one for ourself with the tool `database Configuration Assistant`. 

after creating a database with the tool `database Configuration Assistant` (say we have created a new database named `LocalTestDB`), check the following paths:

- `[base install path]\product\11.2.0\dbhome_1\NETWORK\ADMIN\tnsnames.ora`
- `[base install path]\product\11.2.0\dbhome_1\NETWORK\ADMIN\listener.ora`



**HINT:** based on our example, we should see that settings related to the database `LocalTestDB` has been added to the file `tnsnames.ora`.

**Caution:** my base install path is `C:\app\oraclehome_server`.



# Install Oracle SQL Developer

we installed Version `23.1.0.097`. 

open the app after installation and create 2 connections, one for `sys` user with password `Hamed123456` in database `orcl`, the other for `sys` user with password `Hamed123456` in database `localTestDB`.



![](D:\Tutorial\PLSQL\plsql-tutorial\sqlserver_connection_dialogue.png)



now login to each users in each database you desire and create new users and set privileges to them, as follow:

```powershell
CREATE USER Hamed IDENTIFIED BY Hamed123456;

GRANT CONNECT TO Hamed;
GRANT CONNECT, RESOURCE, DBA TO Hamed;
GRANT CREATE SESSION TO Hamed;
GRANT UNLIMITED TABLESPACE TO Hamed;
```

