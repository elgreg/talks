##  What&#39;s a database?

My definition: a place to save data. You know, like a list!

![a spreadsheet](./resources/spreadsheet-pages-basic.png "Spreadsheets")



A relational database assumes that you'll probably have a couple of lists and that they are somehow related.



For example, you might have a list of products you sold and another list of how much each of those products cost.

OR you might have a list of articles you published and another list of the authors of those articles.

![two spreadsheets - one of pages and the other of authors](./resources/two-sheets.png "More spreadsheets")



But why make a table

![authors sheet](./resources/two-sheets-author.png "two sheets authors")



Because now we can use the ids for the authors

![pages sheet with int authors](./resources/pages-sheet-id-authors.png "Authors as ids")


And if something changes about them, we only have to change it in one spot

![chaging names](./resources/name-change.gif "Name Change")


We've also saved a lot of space. We only store each author name once and numbers are smaller to store than letters in the Author column of pages.


In a relational database, lists are called "tables" and they have a lot more definition than rows in a spreadsheet. For each column of the spreadsheet, you define what data is allowed (e.g. text, numbers, etc.) and you can make constraints on those columns.

![table definition](./resources/table-definition.png "Table definition")



If you want to get both the page information and the authors name, you use SQL and `join` the two tables in a _query_.

```sql
SELECT * FROM pages
JOIN authors ON pages.author_id = authors.id
```


There are loads of other differences between databases and spreadsheets.


Unlike spreadsheets, databases are typically hosted on a separate server and accessed by multiple clients at the same time (either multiple connections from the same web app or multiple users).

![database connection](./resources/database-connection.png "Connection")


Because of this, making changes to databases is more complicated than making changes to spreadsheets. You can't just decide that the `Author` column should change its name to `Author Id` because the applications that are talking to the database are looking for a column called `Author` to join on. You have to change the database first by migrating the data and then tell the application to update its queries.

