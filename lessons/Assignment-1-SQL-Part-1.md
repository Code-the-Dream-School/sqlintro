For your assignment, you use a database that is included with [this repository.](https://github.com/Code-the-Dream-School/sqlintro)  You first fork this repository.  You find the fork button in the upper right when you open the repository link.  Click on that, and in a few moments, you will have your fork.  Then, clone your fork.  You clone as follows: Click on the Code button, and then click on the copy icon for the HTTPS version of the link.  Be sure that you clone **your fork**, not the original repository.  Then, on your workstation, in the folder where you will keep your assignments, do:

```
git clone <URL>
```
where the you paste in the URL you copied in the previous step. The clone step will create a folder called sqlintro, with the rest of the contents of the repository.  Do:
```
cd sqlintro
git checkout -b lesson1
```
This creates the lesson1 branch, which is where you'll do your work.

This lesson assumes that you have set up your machine for Ruby and Rails.  The sqlcommand program provided uses Ruby.

To use the database in this lesson, do the following:
```
bundle install
cp ./starter.db ./test.db
ruby sqlcommand.rb
```
You can then enter SQL commands, such as:
```
SELECT * FROM Products;
```
To exit the program, just type ctrl-c.  The following tables are present:

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

In your repository, there is a file sql1.txt.  It directs you to compose various SELECT statements.  Compose the SQL statements and try them out against the database using the sqlcommand program.   Once you have them
working, paste them in as answers into sql1.txt.

## Submitting Your Work

To submit your work, do the following:
```
git add -A
git commit -m "lesson 1 commit"
git push origin lesson1
```
Then, on github, within your sqlinintro repository, create a pull request for your changes.  The pull request should be for the lesson1 branch, and the target (base) of the pull request should be the main branch of YOUR repository.  **Be careful here!** It is very easy to make the target of the pull request to be the main branch of the Code the Dream Repository, but this is NOT correct.  Click on the base, and choose the main branch of your repository, before creating the pull request.  Submit a link to your pull request with your homework submission.  Do NOT merge the pull request until your reviewer has approved it!.

Your reviewer may request changes.  If that happens, be sure you are on the lesson1 branch (a ```git status``` will tell you, and ```git checkout lesson1``` will switch to that branch.)  Make your changes, and then add, commit, and push them as before.  Your changes will be applied to your previous pull request.

This is the procedure you will follow to submit each of the class assignments.