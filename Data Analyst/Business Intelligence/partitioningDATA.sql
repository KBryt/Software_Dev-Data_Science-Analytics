-- Your goal is to use partitions and clusters to answer the following question: What is the distribution of avocado sales from 2015 to 2021?


-- Create a tables with Partitions and clusters

--  To begin, create a new table without a partition or cluster. This will serve as a baseline to compare to the partitioned and clustered tables. 
-- Name it avocados.
-- Then, in the Editor tab, copy and paste the following SQL code and click `Run`. 

CREATE TABLE
    `mydataset.avocados`
AS (
    SELECT
        *
    FROM `mydataset.avocado_base`
);

-- Create a table with partition

-- Next, create a table partitioned by an integer range (the years 2015 through 2022). Name it avocados_partitioned.
-- Return to the tab you entered the SQL code into. Delete that code then copy and paste the following SQL code. Click `Run`.

CREATE TABLE
    `mydataset.avocados_partitioned`
PARTITION BY
    RANGE_BUCKET(Year, GENERATE_ARRAY(2015,2022,1))
AS (
    SELECT
        *
    FROM `mydataset.avocado_base`
);

-- Create a table with a partition and a cliuster

-- Next, create a table partitioned by an integer range and clustered by type. Name it avocados_clustered.
-- Return to the tab where you entered the SQL code. Delete that code, then copy and paste the following SQL code. Click `Run`.

CREATE TABLE
    `mydataset.avocados_clustered`
PARTITION BY
    RANGE_BUCKET(Year, GENERATE_ARRAY(2015,2022,1))
CLUSTER BY
    type
AS (
    SELECT
        *
    FROM `mydataset.avocado_base`
);

-- Query the table without a partition or cluster

-- Delete the code in the Editor tab, then copy and paste the following code. 
-- Click Run to query avocados—the table without partition or cluster.

SELECT
    year,
    COUNT(*) AS number_avocados,
    SUM(TotalVolume) AS sum_totalVolume,
    SUM(AveragePrice) AS sum_AveragePrice
FROM `mydataset.avocados`
WHERE type = 'organic'
GROUP BY year
ORDER BY year ASC;

-- Query the partitioned table

-- Delete the code in the Editor tab, then copy and paste the following code. 
-- Click Run to query avocados_partitioned—the table that is partitioned by an integer range.

SELECT
    year,
    COUNT(*) AS number_avocados,
    SUM(TotalVolume) as sum_TotalVolume,
    SUM(AveragePrice) as sum_AveragePrice
FROM `mydataset.avocados_partitioned`
WHERE type = 'organic'
GROUP BY year
ORDER BY year ASC;

-- Query the partitioned and clustered table

-- Delete the code in the Editor tab, then copy and paste the following code. 
-- Click Run to query avocados_clustered—the table that is partitioned by an integer range and clustered by type.

SELECT
    year,
    COUNT(*) AS number_avocados,
    SUM(TotalVolume) as sum_TotalVolume,
    SUM(AveragePrice) as sum_AveragePrice
FROM `mydataset.avocados_clustered`
WHERE type = 'organic'
GROUP BY year
ORDER BY year ASC;


