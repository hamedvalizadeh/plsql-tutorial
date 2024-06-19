**HINT:** inside `PL/Sql` block, we can not write DDL commands (like: create, drop), unless we run the as dynamic SQL.

**HINT:** to remove time part from date we can use `trunc` function as `select trunc(sysdate) from dual`.  



# Cursor Attribute for DML

- SQL%FOUND
  - `true` if any record modified.
- SQL%NOTFOUND
  - `true` if no record modified.
- SQL%ROWCOUNT
  - number of rows modified.



# Return Info from DML

to get information of newly inserted or updated or deleted record without need to select from database. the command is `RETURNING [comma seperated columns] into [coma seperated variables]`.



# DML and Record

it is possible to insert into or update a table with the use of `row type` instead of individual variables.

insert syntax would be:

```powershell
insert into [table] values [row type variable]
```



update syntax:

```powershell
update [table] set row = [row type variable] where [row type variable].[unique column name] = [table].[unique column name]
```



