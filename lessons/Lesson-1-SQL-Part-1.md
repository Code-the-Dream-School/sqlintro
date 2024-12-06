SQL is a powerful language for accessing data.  The data in an SQL database is organized in tables, like a spreadsheet, where each row has a number of columns, each with a column name.

All back end developers should learn SQL, as it is a skill expected and required by employers.  No-SQL databases, such as MongoDB, also exist, and they are valuable for many kinds of applications, but they do not support the rich relationships between tables that is supported in SQL.

Within Rails, we use SQL indirectly.  The actual code we write uses an object relational mapper (ORM)
called Active Record.  But, as you will see, Active Record is making SQL calls under the covers.

Read the Odin Project introduction to SQL [here.](https://www.theodinproject.com/lessons/databases-databases-and-sql)  Then do SQLBolt Lessons 1-9 [here.](https://sqlbolt.com/)

Another useful reference is the W3Schools tutorial [here.](https://www.w3schools.com/sql/default.asp)  However, the SQL TryIt editor provided with the tutorial does not work correctly, because of recent browser changes.

### Here are some additional points:

Once you have completed the tutorial, read through the following section.  You will need to understand this additional content in order to complete the assignment.  The assignment includes a database with a number of tables, including a table for customers, one for orders, one for products, one for employees, and one for line_items.  

The SQLBolt tutorial does not talk about *ambiguous column names*, but sometimes you will have them
when doing joins.  Suppose you want to join a customers table with an orders table, and both contain
a column called customer_id.  The join statement you want is:
```sql
SELECT customers.customer_id, customer_name, order_id FROM customers JOIN orders ON customers.customer_id = orders.customer_id;
```
Because you have customer_id in both tables, you have to qualify any reference to customer_id with the table name.  You can do this more succinctly by using an alias, specified with AS, as follows:
```sql
SELECT c.customer_id, customer_name, order_id FROM customers AS c JOIN orders AS o ON c.customer_id = o.customer_id;
```
And, you can even leave out the AS:
```sql
SELECT c.customer_id, customer_name, order_id FROM customers c JOIN orders o ON c.customer_id = o.customer_id;
```
### Compound Joins

Sometimes you want to join more than one table.  You do that by having multiple JOINs in a single SQL statement.  For example, suppose for each order, you want to get the line_items, which are the 
list of products and quantities, plus the product name.  You need to access the orders, line_items, and products tables, as follows:
```sql
SELECT o.order_id, quantity, product_name FROM orders o JOIN line_items li ON o.order_id = li.order_id JOIN products p ON li.product_id = p.product_id;
```

### One to Many Associations

An example of a one to many association is the association between customers and orders.  A customer will have many orders.  The way this works is that each entry in the orders table has a foreign key, customer_id, that has the same value as the primary key for the customer that made that order.  In the database we will use, both
have the name customer_id.  (This often not the case.  The default for Rails is that the primary key is called just ID, but the foreign key is called CustomerID.)  You can find out how many orders each customer has with the following query:

```sql
SELECT customer_name, COUNT(OrderID) AS OrderCount FROM customers c JOIN orders o ON c.customer_id = o.customer_id GROUP BY c.customer_id;
```

### Many to Many Associations

There may be many orders for a given product, and there may be many products for a given order.  To make this work, we have a table in the middle, called a join table.  The join table, in this case the line_items table, has two foreign keys, one being the order_id, one being the product_id.  Let's walk this through.

For each order, there are a records in the line_items table that say which product was ordered, and how many of that product was ordered.  You'll have a few different products in the order, so you need a few different records in the line_items table.  But the line_items table does not have the information describing the product, such as the product name.  Information about the product is in the products table.  You could put all of the product information into the line_items table -- but then you would have to repeat it for each other order that includes that product.  That would be inefficient.  So, to get the product name and other information into a full description of the order, you have to join the orders table with both the line_items table and the product table.

In this case, the line_items table is the join table.  We can then see, for example, the products and quantity for each order:
```sql
SELECT o.order_id, product_name, quantity FROM orders o JOIN line_items li ON o.order_id = li.order_id JOIN products p ON li.product_id = p.product_id ORDER BY o.order_id;
```
