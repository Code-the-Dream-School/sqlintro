### A Sample Database for use in Learning SQL

To use this database, do the following:
```
bundle install
cp ./starter.db ./test.db
ruby sqlcommand.rb
```
You can then enter SQL commands, such as:
```
SELECT * FROM Products;
```
To exit the program, just type quit.  The following tables are present:

- Customers
- Products
- Orders
- Categories
- Shippers
- Suppliers
- OrderDetails
- Employees

Foreign key constraints are enforced.  If you need to restore the database
to the starting state, quit the sqlcommand program and copy ./starter.db to
./test.db. 