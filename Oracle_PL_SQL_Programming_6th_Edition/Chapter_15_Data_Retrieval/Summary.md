# Explicit Cursor

important attribute in explicit cursor are as follow:

- `%found`
- reports the status of the most recent fetch. `TRUE` if the fetch returns a result.
- `%notfound`
- `%isopen`



after first call to the expression `fetch [cursor name] into [record]`, the attributes `%found` and `%notfound` will have the correct value. 