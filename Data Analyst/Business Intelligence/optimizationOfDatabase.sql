<div class="tdb-block-inner td-fix-index"><h1 class="tdb-title-text">SQL Query Optimization: How to Tune Performance of SQL Queries</h1><div></div><div class="tdb-title-line"></div></div></div><div class="tdb-block-inner td-fix-index">
<p>In the article, we are going to examine how to optimize SQL queries and improve query performance by using SQL query optimization tips and techniques, such as <a rel="noreferrer noopener" href="https://blog.devart.com/sql-server-execution-plans.html" target="_blank">execution plans</a>, indexes, wildcards, and many others. </p>



<span id="more-30364"></span>



<figure class="wp-block-image"><a href="https://www.devart.com/dbforge/sql/studio/download.html" target="_blank" rel="noreferrer noopener"><img decoding="async" width="990" height="190" src="data:image/svg+xml,%3Csvg%20xmlns='http://www.w3.org/2000/svg'%20viewBox='0%200%20990%20190'%3E%3C/svg%3E" alt="Download a 30-day trial version of dbForge Studio for SQL Server and evaluate its cutting-edge features" class="wp-image-30934" data-lazy-srcset="https://blog.devart.com/wp-content/uploads/2021/12/Banner_blog_Studio_for_SQL_Server_big.png 990w, https://blog.devart.com/wp-content/uploads/2021/12/Banner_blog_Studio_for_SQL_Server_big-300x58.png 300w, https://blog.devart.com/wp-content/uploads/2021/12/Banner_blog_Studio_for_SQL_Server_big-768x147.png 768w" data-lazy-sizes="(max-width: 990px) 100vw, 990px" data-lazy-src="/wp-content/uploads/2021/12/Banner_blog_Studio_for_SQL_Server_big.png" /><noscript><img decoding="async" width="990" height="190" src="/wp-content/uploads/2021/12/Banner_blog_Studio_for_SQL_Server_big.png" alt="Download a 30-day trial version of dbForge Studio for SQL Server and evaluate its cutting-edge features" class="wp-image-30934" srcset="https://blog.devart.com/wp-content/uploads/2021/12/Banner_blog_Studio_for_SQL_Server_big.png 990w, https://blog.devart.com/wp-content/uploads/2021/12/Banner_blog_Studio_for_SQL_Server_big-300x58.png 300w, https://blog.devart.com/wp-content/uploads/2021/12/Banner_blog_Studio_for_SQL_Server_big-768x147.png 768w" sizes="(max-width: 990px) 100vw, 990px" /></noscript></a></figure>



<p>When businesses and companies face SQL Server performance challenges, they focus usually on applying <a rel="noreferrer noopener" aria-label="performance tuning tools (opens in a new tab)" href="https://www.devart.com/dbforge/sql/studio/sql-server-query-optimization.html" target="_blank">performance tuning tools</a> and optimization techniques. This will help not only analyze and make queries run faster but also eliminate performance issues, troubleshoot poor performance, and avoid any chaos or minimize the impact on SQL Server databases.</p>



<p><strong>Contents</strong></p>



<ul>
<li><a href="#sql-query-optimization-basics">SQL query optimization basics</a></li>



<li><a href="#query-optimization-tips-for-better-performance">12 Query optimization tips for better performance</a><ul><li><a href="#missing-indexes">Tip 1: Add missing indexes </a></li><li><a href="#Non-used-indexes">Tip 2: Check for unused indexes</a></li><li><a href="#or-in-join-predicate">Tip 3: Avoid using multiple OR in the FILTER predicate </a></li></ul>
<ul>
<li><a href="#use-wildcards">Tip 4: Use wildcards at the end of a phrase only</a> </li>



<li><a href="#high-table-count">Tip 5: Avoid too many JOINs</a></li>



<li><a href="#avoid-using-select-distinct">Tip 6: Avoid using SELECT DISTINCT</a></li>



<li><a href="#use-select-fields-instead-of-select-all">Tip 7: Use SELECT fields instead of SELECT *</a></li>



<li><a href="#use-top-to-sample-query-results">Tip 8: Use TOP to sample query results</a></li>



<li><a href="#run-query-during-offpeak-hours">Tip 9: Run the query during off-peak hours</a></li>



<li><a href="#minimize-usage-of-query-hint">Tip 10: Minimize the usage of any query hint</a></li>



<li><a href="#minimize-large-write-operations">Tip 11: Minimize large write operations</a> </li>



<li><a href="#create-joins-with-inner-join">Tip 12: Create joins with INNER JOIN (not WHERE)</a></li>
</ul>
</li>



<li> <a href="#sql-query-optimization-best-practices">SQL query optimization best practices</a> </li>
</ul>



<h2 class="wp-block-heading" id="sql-query-optimization-basics">SQL query optimization basics</h2>



<p>Query optimization is a process of defining the most efficient and optimal way and techniques that can be used to improve query performance based on the rational use of system resources and performance metrics. The purpose of query tuning is to find a way to decrease the response time of the query, prevent the excessive consumption of resources, and identify poor query performance.</p>



<p>In the context of query optimization, query processing identifies how to faster retrieve data from SQL Server by analyzing the execution steps of the query, optimization techniques, and other information about the query.</p>



<h2 class="wp-block-heading" id="query-optimization-tips-for-better-performance">12 Query optimization tips for better performance </h2>



<p>Monitoring metrics can be used to evaluate query runtime, detect performance pitfalls, and show how they can be improved. For example, they include:</p>



<ul>
<li><strong>Execution plan</strong>: A SQL Server query optimizer executes the query step by step, scans indexes to retrieve data, and provides a detailed overview of metrics during query execution.</li>



<li><strong>Input/Output statistics</strong>: Used to identify the number of logical and physical reading operations during the query execution that helps users detect cache/memory capacity issues.</li>



<li><strong>Buffer cache</strong>: Used to reduce memory usage on the server.</li>



<li><strong>Latency</strong>: Used to analyze the duration of queries or operations. </li>



<li><strong>Indexes</strong>: Used to accelerate reading operations on the SQL Server.</li>



<li><strong>Memory-optimized tables</strong>: Used to store table data in memory to make reading and writing operations run faster.</li>
</ul>



<p>Now, we&#8217;ll discuss the best SQL Server performance tuning practices and tips you may apply when writing SQL queries.</p>



<h3 class="wp-block-heading" id="missing-indexes">Tip 1: Add missing indexes</h3>



<p>Table indexes in databases help retrieve information faster and more efficiently.</p>



<p>In SQL Server, when you execute a query, the optimizer generates an execution plan. If it detects the missing index that may be created to optimize performance, the execution plan suggests this in the warning section. With this suggestion, it informs you which columns the current SQL should be indexed, and how performance can be improved upon completion.</p>



<p>Let&#8217;s run the <a href="https://www.devart.com/dbforge/sql/studio/sql-query-profiler.html" target="_blank" rel="noreferrer noopener" aria-label="Query Profiler (opens in a new tab)">Query Profiler</a> available in dbForge Studio for SQL Server to see how it works.</p>



<figure class="wp-block-image"><img decoding="async" width="1000" height="649" src="data:image/svg+xml,%3Csvg%20xmlns='http://www.w3.org/2000/svg'%20viewBox='0%200%201000%20649'%3E%3C/svg%3E" alt="Execution plan displays missing indexes in dbForge Studio for SQL Server" class="wp-image-31391" data-lazy-srcset="https://blog.devart.com/wp-content/uploads/2021/12/missing-index.png 1000w, https://blog.devart.com/wp-content/uploads/2021/12/missing-index-300x195.png 300w, https://blog.devart.com/wp-content/uploads/2021/12/missing-index-768x498.png 768w" data-lazy-sizes="(max-width: 1000px) 100vw, 1000px" data-lazy-src="/wp-content/uploads/2021/12/missing-index.png" /><noscript><img decoding="async" width="1000" height="649" src="/wp-content/uploads/2021/12/missing-index.png" alt="Execution plan displays missing indexes in dbForge Studio for SQL Server" class="wp-image-31391" srcset="https://blog.devart.com/wp-content/uploads/2021/12/missing-index.png 1000w, https://blog.devart.com/wp-content/uploads/2021/12/missing-index-300x195.png 300w, https://blog.devart.com/wp-content/uploads/2021/12/missing-index-768x498.png 768w" sizes="(max-width: 1000px) 100vw, 1000px" /></noscript></figure>



<p>You can also understand which tables need indexes by analyzing graphical query plans. The thicker the arrow between operators on the query execution plan is, the more data is passed. Seeing thick arrows you need to think about adding indexes to the tables being processed to reduce the amount of data passed through the arrow. </p>



<figure class="wp-block-image"><img decoding="async" width="1000" height="800" src="data:image/svg+xml,%3Csvg%20xmlns='http://www.w3.org/2000/svg'%20viewBox='0%200%201000%20800'%3E%3C/svg%3E" alt="" class="wp-image-45803" data-lazy-srcset="https://blog.devart.com/wp-content/uploads/2022/09/index-optimization-1.png 1000w, https://blog.devart.com/wp-content/uploads/2022/09/index-optimization-1-300x240.png 300w, https://blog.devart.com/wp-content/uploads/2022/09/index-optimization-1-768x614.png 768w" data-lazy-sizes="(max-width: 1000px) 100vw, 1000px" data-lazy-src="/wp-content/uploads/2022/09/index-optimization-1.png" /><noscript><img decoding="async" width="1000" height="800" src="/wp-content/uploads/2022/09/index-optimization-1.png" alt="" class="wp-image-45803" srcset="https://blog.devart.com/wp-content/uploads/2022/09/index-optimization-1.png 1000w, https://blog.devart.com/wp-content/uploads/2022/09/index-optimization-1-300x240.png 300w, https://blog.devart.com/wp-content/uploads/2022/09/index-optimization-1-768x614.png 768w" sizes="(max-width: 1000px) 100vw, 1000px" /></noscript></figure>



<p>On the execution plan, you might encounter Table Spool (Lazy Spool in our case) that builds a temporary table in the tempdb and fills it in a lazy manner. Simply put, the table is filled by reading and storing the data only when individual rows are required by the parent operator.  The Index Spool operator works in a somehow similar manner ⁠— all input rows are scanned and a copy of each row is placed in a hidden spool file that is stored in the tempdb database and exists only for the lifetime of the query. After that, an index on the rows is built. Both Table Spool and Index Spool might require optimization and adding indexes on the corresponding tables.</p>



<p>Nested Loops might also need your attention. Nested Loops must be indexed, as they take the first value from the first table and search for a match in the second table. Without indexes, SQL Server will have to scan and process the whole table, which can be time-consuming and resource-intensive.</p>



<p>Keep in mind that the missing index does not 100% guarantee better performance. In SQL Server, you can use the following  dynamic management views to get a deep insight in using indexes based on query execution history:</p>



<ul>
<li><strong>sys.dm_db_missing_index_details</strong>: Provides information about the suggested missing index, except for spatial indexes.</li>



<li><strong>sys.dm_db_missing_index_columns</strong>: Returns information about the table columns that do not contain indexes.</li>



<li><strong>sys.dm_db_missing_index_group_stats</strong>: Returns summary information about the missing index group, such as query cost, <em>avg_user_impact</em> (informs you how much performance can be improved by increasing the missing index), and some other metrics to measure effectiveness.</li>



<li><strong>sys.dm_db_missing_index_groups: </strong>Provides information about missing indexes included in a specific index group. </li>
</ul>



<h3 class="wp-block-heading" id="Non-used-indexes">Tip 2: Check for unused indexes</h3>



<p>You may encounter a situation where indexes exist but are not being used. One of the reasons for that might be implicit data type conversion. Let&#8217;s consider the following query:</p>



<pre class="wp-block-code"><code>SELECT *
FROM TestTable
WHERE IntColumn = '1';</code></pre>



<p>When executing this query, SQL Server will perform implicit data type conversion, i.e. convert int data to varchar and run the comparison only after that. In this case, indexes won&#8217;t be used. How can you avoid this? We recommend using the CAST() function that converts a value of any type into a specified datatype. Look at the query below.</p>



<pre class="wp-block-code"><code>SELECT *
FROM TestTable
WHERE IntColumn = CAST(@char AS INT);</code></pre>



<p>Let&#8217;s study one more example.</p>



<pre class="wp-block-code"><code>SELECT *
FROM TestTable
WHERE DATEPART(YEAR, SomeMyDate) = '2021';</code></pre>



<p>In this case, implicit data type conversion will take place too, and the indexes won&#8217;t be used. To avoid this, we can optimize the query in the following way:</p>



<pre class="wp-block-code"><code>SELECT *
FROM TestTable
WHERE SomeDate >= '20210101'
AND SomeDate &lt; '20220101'</code></pre>



<p>Filtered indexes can affect performance too. Suppose, we have an index on the Customer table.</p>



<pre class="wp-block-code"><code>CREATE UNIQUE NONCLUSTERED INDEX IX ON Customer (MembershipCode)
WHERE MembershipCode IS NOT NULL;</code></pre>



<p>The index won&#8217;t work for the following query:</p>



<pre class="wp-block-code"><code>SELECT *
FROM Customer
WHERE MembershipCode = '258410';</code></pre>



<p>To make use of the index, you&#8217;ll need to optimize the query in the following way:</p>



<pre class="wp-block-code"><code>SELECT *
FROM Customer
WHERE MembershipCode = '258410'
AND MembershipCode IS NOT NULL;</code></pre>



<h3 class="wp-block-heading" id="or-in-join-predicate">Tip 3: Avoid using multiple OR in the FILTER predicate</h3>



<p>When you need to combine two or more conditions, it is recommended to eliminate the usage of the OR operator or split the query into parts separating search expressions. SQL Server can not process OR within one operation. Instead, it evaluates each component of the OR which, in turn, may lead to poor performance. </p>



<p>Let&#8217;s consider the following query.</p>



<pre class="wp-block-code"><code>SELECT *
FROM USER
WHERE Name = @P
OR login = @P;</code></pre>



<p>If we split this query into two SELECT queries and combine them by using the UNION operator, SQL Server will be able to make use of the indexes, and the query will be optimized.</p>



<pre class="wp-block-code"><code>SELECT * FROM USER
WHERE Name = @P
UNION
SELECT * FROM USER
WHERE login = @P;</code></pre>



<h3 class="wp-block-heading" id="use-wildcards">Tip 4: Use wildcards at the end of a phrase only</h3>



<p><a href="https://www.devart.com/dbforge/sql/sqlcomplete/sql-wildcard-search.html" target="_blank">Wildcards in SQL Server</a> work as a placeholder for words and phrases and can be added at the beginning/end of them. To make data retrieval faster and more efficient, you can use wildcards in the SELECT statement at the end of a phrase. For example:</p>



<pre class="wp-block-code"><code>SELECT
  p.BusinessEntityID
 ,p.FirstName
 ,p.LastName
 ,p.Title
FROM Person.Person p
WHERE p.FirstName LIKE 'And%';</code></pre>



<p>As a result, the query will retrieve a list of customers whose First Name matches the specified condition, i.e. their First Name starts with &#8216;And&#8217;.</p>



<figure class="wp-block-image"><img decoding="async" width="529" height="524" src="data:image/svg+xml,%3Csvg%20xmlns='http://www.w3.org/2000/svg'%20viewBox='0%200%20529%20524'%3E%3C/svg%3E" alt="Retrieve data using wildcards in the SELECT statement" class="wp-image-31346" data-lazy-srcset="https://blog.devart.com/wp-content/uploads/2021/12/wildcards.png 529w, https://blog.devart.com/wp-content/uploads/2021/12/wildcards-150x150.png 150w, https://blog.devart.com/wp-content/uploads/2021/12/wildcards-300x297.png 300w" data-lazy-sizes="(max-width: 529px) 100vw, 529px" data-lazy-src="/wp-content/uploads/2021/12/wildcards.png" /><noscript><img decoding="async" width="529" height="524" src="/wp-content/uploads/2021/12/wildcards.png" alt="Retrieve data using wildcards in the SELECT statement" class="wp-image-31346" srcset="https://blog.devart.com/wp-content/uploads/2021/12/wildcards.png 529w, https://blog.devart.com/wp-content/uploads/2021/12/wildcards-150x150.png 150w, https://blog.devart.com/wp-content/uploads/2021/12/wildcards-300x297.png 300w" sizes="(max-width: 529px) 100vw, 529px" /></noscript></figure>



<p>However, you might encounter situations where you regularly need to search by the last symbols of a word, number, or phrase — for example, by the last digits of a telephone number. In this case, we recommend creating a persisted computed column and running the REVERSE() function on it for easier back-searching. </p>



<pre class="wp-block-code"><code>CREATE TABLE dbo.Customer (
  id INT IDENTITY PRIMARY KEY
 ,CardNo VARCHAR(128)
 ,ReversedCardNo AS REVERSE(CardNo) PERSISTED
)
GO

CREATE INDEX ByReversedCardNo ON dbo.Customer (ReversedCardNo)
GO
CREATE INDEX ByCardNo ON dbo.Customer (CardNo)
GO

INSERT INTO dbo.Customer (CardNo)
  SELECT
    NEWID()
  FROM master.dbo.spt_values sv

SELECT TOP 100
  *
FROM Customer c

--searching for CardNo that end in 510c
SELECT *
FROM dbo.Customer
WHERE CardNo LIKE '%510c'

SELECT
  *
FROM dbo.Customer
WHERE ReversedCardNo LIKE REVERSE('%510c')</code></pre>



<h3 class="wp-block-heading" id="high-table-count">Tip 5: Avoid too many JOINs</h3>



<p>When you add multiple tables to a query and join them, you may overload the server. In addition, a large number of tables to retrieve data from may result in an inefficient execution plan. When generating a plan, the SQL query optimizer needs to identify how the tables are joined, in which order, and how and when to apply filters and aggregation. </p>



<p>All SQL experts are aware of the <a href="https://www.devart.com/dbforge/sql/sqlcomplete/sql-join-statements.html" target="_blank">SQL JOINs</a> importance, and understanding how to use them in queries appropriately is critical. In particular, JOIN elimination is one of the many techniques to achieve efficient query plans. You can split a single query into several separate queries which can later be joined, and thus remove unnecessary joins, subqueries, tables, etc. </p>



<h3 class="wp-block-heading" id="avoid-using-select-distinct">Tip 6: Avoid using SELECT DISTINCT</h3>



<p> The SQL DISTINCT operator is used to select only unique values of the column and thus eliminate duplicated values. It has the following syntax:</p>



<pre class="wp-block-code"><code>SELECT DISTINCT column_name FROM table_name;</code></pre>



<p>However, this may require the tool to process large volumes of data and as a result, make the query run slowly. Generally, it is recommended to avoid using SELECT DISTINCT and simply execute the SELECT statement but specify columns. </p>



<p>Another issue is that quite often people build JOINs unnecessarily, and when the data doubles, they add DISTINCT. This happens mainly in a leader-follower relation when people do <code>SELECT DISTINCT … FROM LEADER JOIN FOLLOWER…</code> instead of doing the correct <code>SELECT … FROM LEADER WHERE EXISTS (SELECT… FROM FOLLOWER)</code>.</p>



<h3 class="wp-block-heading" id="use-select-fields-instead-of-select-all">Tip 7: Use SELECT fields instead of SELECT *</h3>



<p>The SELECT statement is used to retrieve data from the database. In the case of large databases, it is not recommended to retrieve all data because this will take more resources on querying a huge volume of data. </p>



<p>If we execute the following query, we will retrieve all data from the <strong>Users</strong> table, including, for example, users&#8217; avatar pictures. The result table will contain lots of data and will take too much memory and CPU usage.</p>



<pre class="wp-block-code"><code>SELECT
  *
FROM Users;</code></pre>



<p>Instead, you can specify the exact columns you need to get data from, thus, saving database resources. In this case, SQL Server will retrieve only the required data, and the query will have lower cost.</p>



<p>For example:</p>



<pre class="wp-block-code"><code>SELECT
    FirstName
   ,LastName
   ,Email
   ,Login
FROM Users;</code></pre>



<p>If you need to retrieve this data regularly, for example, for authentication purposes, we recommend using covering indexes, the biggest advantage of which is that they contain all the fields required by query and can significantly improve query performance and guarantee better results.</p>



<pre class="wp-block-code"><code>CREATE NONCLUSTERED INDEX IDX_Users_Covering ON Users
INCLUDE (FirstName, LastName, Email, Login)</code></pre>



<h3 class="wp-block-heading" id="use-top-to-sample-query-results">Tip 8: Use TOP to sample query results</h3>



<p>The SELECT TOP command is used to set a limit on the number of records to be returned from the database. To make sure that your query will output the required result, you can use this command to fetch several rows as a sample.</p>



<p>For example, take the query from the previous section and define the limit of 5 records in the result set.</p>



<pre class="wp-block-code"><code>SELECT TOP 5
  p.BusinessEntityID
 ,p.FirstName
 ,p.LastName
 ,p.Title
FROM Person.Person p
WHERE p.FirstName LIKE 'And%';</code></pre>



<p>This query will retrieve only 5 records matching the condition:</p>



<figure class="wp-block-image"><img decoding="async" width="419" height="360" src="data:image/svg+xml,%3Csvg%20xmlns='http://www.w3.org/2000/svg'%20viewBox='0%200%20419%20360'%3E%3C/svg%3E" alt="Use LIMIT (TOP in SQL) to sample query results" class="wp-image-31353" data-lazy-srcset="https://blog.devart.com/wp-content/uploads/2021/12/use-limit.png 419w, https://blog.devart.com/wp-content/uploads/2021/12/use-limit-300x258.png 300w" data-lazy-sizes="(max-width: 419px) 100vw, 419px" data-lazy-src="/wp-content/uploads/2021/12/use-limit.png" /><noscript><img decoding="async" width="419" height="360" src="/wp-content/uploads/2021/12/use-limit.png" alt="Use LIMIT (TOP in SQL) to sample query results" class="wp-image-31353" srcset="https://blog.devart.com/wp-content/uploads/2021/12/use-limit.png 419w, https://blog.devart.com/wp-content/uploads/2021/12/use-limit-300x258.png 300w" sizes="(max-width: 419px) 100vw, 419px" /></noscript></figure>



<h3 class="wp-block-heading" id="run-query-during-offpeak-hours">Tip 9: Run the query during off-peak hours</h3>



<p>Another SQL tuning technique is to schedule the query execution at off-peak hours, especially if you need to run multiple SELECT queries from large tables or execute complex queries with nested subqueries, looping queries, etc. If you are running a heavy query against a database, SQL Server locks the tables you are working with to prevent concurrent use of resources by different transactions. That means that other users are not able to work with those tables. Thus, executing heavy queries at peak times leads not only to server overload but also to restricting other users&#8217; access to certain amounts of data. One of the popular mechanisms to avoid this is to use the <strong>WITH (NOLOCK)</strong> hint. It allows the user to retrieve the data without being affected by the locks. The biggest drawback of using <strong>WITH (NOLOCK)</strong> is that it may result in working with dirty data. We recommend that users should give preference to snapshot isolation which helps avoid data locking by using row versioning and guarantees that each transaction sees a consistent snapshot of the database. </p>



<h3 class="wp-block-heading" id="minimize-usage-of-query-hint">Tip 10: Minimize the usage of any query hint</h3>



<p>When you face performance issues, you may use query hints to optimize queries. They are specified in T-SQL statements and make the optimizer select the execution plan based on this hint.&nbsp;Usually, query hints include  NOLOCK, Optimize For and Recompile. However, you should carefully consider their usage because sometimes they may cause more unexpected side effects, undesirable impacts, or even break business logic when trying to solve the issue. For example, you write additional code for the hints that can be inapplicable or obsolete after a while. This means that you should always monitor, manage, check, and keep hints up to date.</p>



<h3 class="wp-block-heading" id="minimize-large-write-operations">Tip 11: Minimize large write operations</h3>



<p>Writing, modifying, deleting, or importing large volumes of data may impact query performance and even block the table when it requires updating and manipulating data, adding indexes or check constraints to queries, processing triggers, etc. In addition, writing a lot of data will increase the size of log files. Thus, large write operations may not be a huge performance issue, but you should be aware of their consequences and be prepared in case of unexpected behavior.</p>



<p>One of the best practices in optimizing SQL Server performance lies in using filegroups that allow you to spread your data across multiple physical disks. Thereby multiple write operations can be processed simultaneously and thus much faster.</p>



<p>Compression and data partitioning can also optimize performance and help minimize the cost of large write operations.</p>



<h3 class="wp-block-heading" id="create-joins-with-inner-join">Tip 12: Create JOINs with INNER JOIN (not WHERE)</h3>



<p>The <a href="https://www.devart.com/dbforge/sql/sqlcomplete/sql-inner-join-statement.html" target="_blank">SQL INNER JOIN</a> statement returns all matching rows from joined tables, while the WHERE clause filters the resulting rows based on the specified condition. Retrieving data from multiple tables based on the WHERE keyword condition is called NON-ANSI JOINs while INNER JOIN belongs to ANSI JOINs. </p>



<p>It does not matter for SQL Server how you write the query &#8211; using ANSI or NON-ANSI joins &#8211; it&#8217;s just much easier to understand and analyze queries written using ANSI joins. You can clearly see where the JOIN conditions and the WHERE filters are, whether you missed any JOIN or filter predicates, whether you joined the required tables, etc.</p>



<p>Let&#8217;s see how to optimize a SQL query with INNER JOIN on a particular example. We are going to retrieve data from the tables <strong>HumanResources.Department </strong>and <strong>HumanResources.EmployeeDepartmentHistory </strong>where DepartmentIDs are the same. First, execute the SELECT statement with the INNER JOIN type:</p>



<pre class="wp-block-code"><code>SELECT
  d.DepartmentID
 ,d.Name
 ,d.GroupName
FROM HumanResources.Department d
INNER JOIN HumanResources.EmployeeDepartmentHistory edh
  ON d.DepartmentID = edh.DepartmentID</code></pre>



<p>Then, use the WHERE clause instead of INNER JOIN to join the tables in the SELECT statement: </p>



<pre class="wp-block-code"><code>SELECT
  d.Name
 ,d.GroupName
 ,d.DepartmentID
FROM HumanResources.Department d
    ,HumanResources.EmployeeDepartmentHistory edh
WHERE d.DepartmentID = edh.DepartmentID</code></pre>



<p>Both queries will output the following result:</p>



<figure class="wp-block-image"><img decoding="async" width="448" height="240" src="data:image/svg+xml,%3Csvg%20xmlns='http://www.w3.org/2000/svg'%20viewBox='0%200%20448%20240'%3E%3C/svg%3E" alt="Retrieve data using INNER JOIN" class="wp-image-31293" data-lazy-srcset="https://blog.devart.com/wp-content/uploads/2021/12/inner-joins.png 448w, https://blog.devart.com/wp-content/uploads/2021/12/inner-joins-300x161.png 300w" data-lazy-sizes="(max-width: 448px) 100vw, 448px" data-lazy-src="/wp-content/uploads/2021/12/inner-joins.png" /><noscript><img decoding="async" width="448" height="240" src="/wp-content/uploads/2021/12/inner-joins.png" alt="Retrieve data using INNER JOIN" class="wp-image-31293" srcset="https://blog.devart.com/wp-content/uploads/2021/12/inner-joins.png 448w, https://blog.devart.com/wp-content/uploads/2021/12/inner-joins-300x161.png 300w" sizes="(max-width: 448px) 100vw, 448px" /></noscript></figure>



<h2 class="wp-block-heading" id="sql-query-optimization-best-practices">SQL query optimization best practices</h2>



<p>SQL Server performance tuning and SQL query optimization are some of the main aspects for database developers and administrators. They need to carefully consider the usage of specific operators, the number of tables on a query, the size of a query, its execution plan, statistics, resource allocation, and other performance metrics &#8211; all that may improve and tune query performance or make it worse.</p>



<p>For better query performance, we recommend using tips and techniques presented in the article, such as running queries at off-peak hours, creating indexes, retrieving data only for the specific columns, applying the correct filter, joins, and operators, as well as trying not to overload queries.</p>



<p>In addition, we propose some recommendations which may not directly relate to coding techniques, but they can still help you write precise and efficient SQL code.</p>



<p><strong>Use uppercase for keywords</strong></p>



<p>Keywords in SQL are generally case-insensitive. You can use lower case, upper case, or both mixed across all popular database management systems, including Microsoft SQL Server. However, it is recommended to use the upper case for keywords for improved code readability.</p>



<p>Although some developers may find it cumbersome to switch between upper and lower case while coding, modern SQL code formatting tools provide the functionality to configure case usage, text coloring, indents, and other options. These tools can automatically apply the preferable formatting while typing.</p>



<p><strong>Write comments for your SQL code</strong></p>



<p>Commenting on the code is optional, but it is highly recommended. Even if some code solutions seem obvious at the moment, what happens in a couple of months when you need to revisit it, especially after writing lots of other code for different modules or projects? This is especially important for your colleagues who will have to work with your code.</p>



<p>Another essential point is to review your existing comments whenever you make changes to your code, ensuring that they remain relevant. It may take time, but it greatly improves the readability of your code, and your efforts will pay off.</p>



<p><strong>Use a professional SQL code editor</strong></p>



<p>As a developer, you may apply various techniques and customize your workflows according to your preferences, but creating code manually from scratch consumes a lot of time and demands exceptional precision. A reliable and potent SQL editor makes code writing easier and enhances accuracy.</p>



<p>Modern SQL editors offer robust functionality for query development, such as auto-completion options, libraries of code snippets, syntax validation, and code formatting. Advanced <a href="https://www.devart.com/dbforge/edge/" target="_blank">tools for SQL development</a> allow developers to double the coding speed twice (at least) and guarantee outstanding code quality.</p>



<h2 class="wp-block-heading">Conclusion</h2>
