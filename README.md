# Ruby on Rails Lesson 1: Introduction to SQL

SQL is a powerful language for accessing data.  The data in an SQL database is organized in tables.
All back end developers should learn SQL, as it is a skill expected and required by employers.  No-SQL
databases, such as MongoDB, also exist, but they do not support the rich relationships between tables
that is supported in SQL.

Within Rails, we use SQL indirectly.  The actual code we write uses an object relational mapper (ORM)
called Active Record.  But, as you will see, Active Record is making SQL calls under the covers.

This repository contains Ruby on Rails Lessons 1 and 2, both of which have to do with SQL.  You should
first fork this repository, so that your own github account has a copy.  You do that by clicking on
the fork button in the upper right.  Then you clone your fork, to make a copy of it on your laptop.
To do the clone, click on the green code button, and then on the little clipboard icon, to copy the
URL of your repository into the clipboard.  Then, on your laptop, do:
```
git clone <URL>
```
Where ```<URL>```is the URL you copied to your clipboard.  Be sure that you clone YOUR copy of the repository, and NOT the Code The Dream School one, because otherwise you will not be able to push your changes.  Also, be sure that when you clone, you do not clone to a directory that is part of another git repository.  Then, do
```
git checkout -b lesson1
```
You will do your homework in this branch.

## Lesson 1 Materials

Read the Odin Project introduction to SQL [here.](https://www.theodinproject.com/lessons/databases-databases-and-sql)  THen do SQLBolt Lessons 1-9 [here.](https://sqlbolt.com/)  Another useful reference is the W3Schools tutorial [here.](https://www.w3schools.com/sql/default.asp)  HOever, the SQL TryIt editor provided with the tutorial does not work correctly, because of recent browser changes.

### Here are some additional points:

The SQLBolt tutorial does not talk about *ambiguous column names*, but sometimes you will have them
when doing joins.  Suppose you want to join a Customers table with an Orders table, and both contain
a column called CustomerID.  The join statement you want is:
```
SELECT Customer.CustomerID, CustomerName, OrderID FROM Customers JOIN Orders ON Customer.CustomerID = Orders.CustomerID;
```
Because you have CustomerID in both tables, you have to qualify any reference to CustomerID with the table name.  You can do this more efficiently by using an alias, specified with AS, as follows:
```
SELECT c.CustomerID, CustomerName, OrderID FROM Customers AS c JOIN Orders AS o ON c.CustomerID = o.CustomerID;
```
And, you can even leave out the AS:
```
SELECT c.CustomerID, CustomerName, OrderID FROM Customers c JOIN Orders o ON c.CustomerID = o.CustomerID;
```
### Compound Joins

Sometimes you want to join more than one table.  You do that by having multiple JOINs in a single SQL statement.  For example, suppose for each order, you want to get the order details, which is the 
list of products and quantities, plus the product name.  You need to access the Orders, OrderDetails, and
products tables, as follows:
```
SELECT o.OrderID, Quantity, ProductName FROM Orders o JOIN OrderDetails od ON o.OrderID = od.OrderID JOIN
Products p ON od.ProductID = p.ProductID;
```

### One to Many Associations

An example of a one to many association is the association between Customers and Orders.  A customer will
have many Orders.  The way this works is that each entry in the Orders table has a foreign key, CustomerID, that equals the primary key for the customer that made that order.  In the database we will use, both
have the name CustomerID, but this is not always the case.  So, you could find out how many orders each
customer has with the following query:

```
Select CustomerName, COUNT(OrderID) AS OrderCount FROM Customers c JOIN Orders o ON c.CustomerID = o.CustomerID GROUP BY c.CustomerID;
```

### Many to Many Associations

There may be many orders for a given product, and there may be many products for a given order.  To make
this work, we have a table in the middle, called a join table.  The join table has two foreign keys, one
being the OrderID, one being the ProductID.  In this case, the OrderDetails table is the join table.
We can then see, for example, the products and quantity for each order:
```
SELECT o.OrderID, ProductName, Quantity FROM Orders o JOIN OrderDetails od ON o.OrderID = od.OrderID JOIN Products p ON od.ProductID = p.ProductID ORDER BY o.OrderID;
```
## Lesson 1 Assignment

For your assignment, you use a database that is included with this repository.

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
./test.db. Ctrl-C exits the program.

In this repository, there is a file sql1.txt.  It directs you to do various SELECT statements.  Compose the SQL statements and try them out against the database using the sqlcommand program.   Once you have them
working, paste them in as answers into sql1.txt.

## Submitting Your Work

To submit your work, do the following:
```
git add -A
git commit -m "lesson 1 commit"
git push origin lesson1
```
Then, on github, create a pull request for your changes.  The pull request should be for the lesson1 branch, and the target of the pull request shouold be the main branch of YOUR repository.  *Be careful here!* It is very easy to make the target of the pull request to be the main branch of the Code the Dream Repository, but this is NOT correct.  Submit a link to your pull request with your homework submission.

# Ruby on Rails Lesson 2: More SQL

## Lesson 2 Materials

Continue with the SQLBolt tutorial [here.](https://sqlbolt.com/)  Complete all exercises through 18.

## Lesson 2 Assignment

Create a new branch, called lesson2.  This is the branch you will use for your work.

In this repository, there is a file sql2.txt.  It directs you to do various SELECT statements.  Compose the SQL statements and try them out against the database using the sqlcommand program.   Once you have them
working, paste them in as answers into sql2.txt.

## Submitting Your Work

Add, commit, and push your changes for the lesson2 branch.  Then create the pull request as before.  Then submit a link to the pull request with your homework submission.