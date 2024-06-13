SQL is a powerful language for accessing data.  The data in an SQL database is organized in tables, like a spreadsheet, where each row has a number of columns, each with a column name.

All back end developers should learn SQL, as it is a skill expected and required by employers.  No-SQL databases, such as MongoDB, also exist, and they are valuable for many kinds of applications, but they do not support the rich relationships between tables that is supported in SQL.

Within Rails, we use SQL indirectly.  The actual code we write uses an object relational mapper (ORM)
called Active Record.  But, as you will see, Active Record is making SQL calls under the covers.

Read the Odin Project introduction to SQL [here.](https://www.theodinproject.com/lessons/databases-databases-and-sql)  Then do SQLBolt Lessons 1-9 [here.](https://sqlbolt.com/)

Another useful reference is the W3Schools tutorial [here.](https://www.w3schools.com/sql/default.asp)  However, the SQL TryIt editor provided with the tutorial does not work correctly, because of recent browser changes.

### Here are some additional points:

Once you have completed the tutorial, read through the following section.  You will need to understand this additional content in order to complete the assignment.  The assignment includes a database with a number of tables, including a table for Customers, one for Orders, one for Products, and one for OrderDetails.  

The SQLBolt tutorial does not talk about *ambiguous column names*, but sometimes you will have them
when doing joins.  Suppose you want to join a Customers table with an Orders table, and both contain
a column called CustomerID.  The join statement you want is:
```
SELECT Customers.CustomerID, CustomerName, OrderID FROM Customers JOIN Orders ON Customers.CustomerID = Orders.CustomerID;
```
Because you have CustomerID in both tables, you have to qualify any reference to CustomerID with the table name.  You can do this more succinctly by using an alias, specified with AS, as follows:
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
have the name CustomerID.  (This often not the case.  The default for Rails is that the primary key is called just ID, but the foreign key is called CustomerID.)  You can find out how many orders each customer has with the following query:

```
Select CustomerName, COUNT(OrderID) AS OrderCount FROM Customers c JOIN Orders o ON c.CustomerID = o.CustomerID GROUP BY c.CustomerID;
```

### Many to Many Associations

There may be many orders for a given product, and there may be many products for a given order.  To make this work, we have a table in the middle, called a join table.  The join table, in this case the OrderDetails table, has two foreign keys, one being the OrderID, one being the ProductID.  Let's walk this through.

For each Order, there are a records in the OrderDetails table that say which product was ordered, and how many of that product was ordered.  You'll have a few different products in the order, so you need a few different records in the OrderDetails table.  But the OrderDetails table does not have the information describing the product, such as the product name.  Information about the product is in the Products table.  You could put all of the product information into the OrderDetails table -- but then you would have to repeat it for each other order that includes that product.  That would be inefficient.  So, to get the product name and other information into a full description of the order, you have to join the Orders table with both the OrderDetails table and the Product table.

In this case, the OrderDetails table is the join table.  We can then see, for example, the products and quantity for each order:
```
SELECT o.OrderID, ProductName, Quantity FROM Orders o JOIN OrderDetails od ON o.OrderID = od.OrderID JOIN Products p ON od.ProductID = p.ProductID ORDER BY o.OrderID;
```
