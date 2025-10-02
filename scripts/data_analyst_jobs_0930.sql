-- #### Provide the SQL queries and answers for the following questions/tasks using the data_analyst_jobs table you have created in PostgreSQL:

-- 1.	How many rows are in the data_analyst_jobs table? 1793
SELECT
	COUNT(*)
FROM data_analyst_jobs;

-- 2.	Write a query to look at just the first 10 rows. What company is associated with the job posting 
--on the 10th row? "ExxonMobil"
SELECT 
	company
FROM data_analyst_jobs
LIMIT 10;

-- 3.	How many postings are in Tennessee? 21 
	  --How many are there in either Tennessee or Kentucky? 27
SELECT 
	COUNT(location)
FROM data_analyst_jobs
WHERE location = 'TN';

SELECT 
	COUNT(location)
FROM data_analyst_jobs
WHERE location = 'TN'
OR location = 'KY';

-- 4.	How many postings in Tennessee have a star rating above 4? 3
SELECT
	COUNT(star_rating)
FROM data_analyst_jobs
WHERE star_rating > 4
AND location = 'TN';


-- 5.	How many postings in the dataset have a review count between 500 and 1000? 151
SELECT
	COUNT(review_count)
FROM data_analyst_jobs
WHERE review_count BETWEEN 500 AND 1000;

-- 6.	Show the average star rating for companies in each state. 
--The output should show the state as `state` and the average rating for the state as `avg_rating`. 
--Which state shows the highest average rating? NE = 4.199

SELECT
	location AS state,
	AVG(star_rating) AS avg_rating	
FROM data_analyst_jobs
WHERE star_rating IS NOT NULL
GROUP BY location
ORDER BY avg_rating DESC;

-- 7.	Select unique job titles from the data_analyst_jobs table. How many are there? 881
SELECT DISTINCT(title)
FROM data_analyst_jobs;

-- 8.	How many unique job titles are there for California companies? 230
SELECT 
	DISTINCT(title)
FROM data_analyst_jobs
WHERE location = 'CA';

-- 9.	Find the name of each company and its average star rating for all companies that have 
--more than 5000 reviews across all locations. How many companies are there with more that 5000 reviews 
--across all locations? 40

SELECT 
	DISTINCT (company), 
	ROUND(AVG(star_rating),2) AS avg_rating
	FROM data_analyst_jobs
WHERE review_count > 5000
AND
company IS NOT NULL
GROUP BY company, location
ORDER BY company; 

-- 10.	Add the code to order the query in #9 from highest to lowest average star rating.
--Which company with more than 5000 reviews across all locations in the dataset has the highest 
--star rating? What is that rating? 6 companies with 4.20 rating 
SELECT 
	DISTINCT (company), 
	ROUND(AVG(star_rating),2) AS avg_rating
	FROM data_analyst_jobs
WHERE review_count > 5000
AND
company IS NOT NULL
GROUP BY company
ORDER BY avg_rating DESC; 

-- 11.	Find all the job titles that contain the word ‘Analyst’. 
--How many different job titles are there? 774
SELECT 
	DISTINCT title
FROM data_analyst_jobs
WHERE title iLIKE '%Analyst%';

-- 12.	How many different job titles do not contain either the word ‘Analyst’ or the word ‘Analytics’? 4
--What word do these positions have in common? Tableau
SELECT 
	DISTINCT(title)
FROM data_analyst_jobs
WHERE title NOT iLIKE '%Analyst%' 
AND
title NOT iLIKE '%Analytics%' 

-- **BONUS:**
-- You want to understand which jobs requiring SQL are hard to fill. 
-- Answer: Data Analyst for Consulting and Business Services is hard to fill.

SELECT title, skill, days_since_posting, domain 
FROM data_analyst_jobs
WHERE skill LIKE 'SQL'
ORDER BY days_since_posting DESC;

--Find the number of jobs by industry (domain) that require SQL and have been
-- posted longer than 3 weeks. 
-- Disregard any postings where the domain is NULL. 
-- Order your results so that the domain with the greatest
--number of `hard to fill` jobs is at the top. 
-- Which three industries are in the top 3 on this list? 
--How many jobs have been listed for more than 3 weeks for each of the top 3?
--4	"Consulting and Business Services"
--2	"Consumer Goods and Services"
--1	"Real Estate"

SELECT COUNT(title) AS No_of_jobs, domain, days_since_posting, skill 
FROM data_analyst_jobs
WHERE days_since_posting > 21
AND skill = 'SQL'
AND domain IS NOT NULL
GROUP BY days_since_posting, domain,skill
ORDER BY No_of_jobs DESC, days_since_posting DESC;
