 SELECT * FROM data_analyst_jobs;

-- 1. How many rows are in the data_analyst_jobs table?
SELECT COUNT(*) 
FROM data_analyst_jobs;  /*1793*/

-- 2. Write a query to look at just the first 10 rows. What company is associated with the job posting on the 10th row?
SELECT * 
FROM data_analyst_jobs
WHERE company IS NOT NULL
LIMIT 10; /* EXXONMOBIL*/

-- 3. How many postings are in Tennessee? How many are there in either Tennessee or Kentucky?
SELECT COUNT(*) 
FROM data_analyst_jobs 
WHERE location = 'TN';
/* TN 21 */
SElECT COUNT(*) 
FROM data_analyst_jobs 
WHERE location = 'KY';
/* KY 6 */
SELECT COUNT(*) 
FROM data_analyst_jobs 
WHERE location IN ('TN','KY');
/* 27 */

-- 4. How many postings in Tennessee have a star rating above 4?
SELECT COUNT(*) 
FROM data_analyst_jobs 
WHERE star_rating > 4 AND location = 'TN';
/* 3 postings in TN*/

-- 5. How many postings in the dataset have a review count between 500 and 1000?
SELECT COUNT(review_count)
FROM data_analyst_jobs 
WHERE review_count BETWEEN 500 AND 1000;
/* 151*/

-- 6. Show the average star rating for companies in each state. The output should show the state as state and the average rating for the state as avg_rating. 
-- Which state shows the highest average rating?
SELECT company, ROUND(AVG(star_rating),2) AS avg_rating, location AS state
FROM data_analyst_jobs
WHERE star_rating IS NOT NULL
GROUP BY company, state
ORDER BY avg_rating DESC;
/* CA */

-- 7. Select unique job titles from the data_analyst_jobs table. How many are there?
SELECT COUNT(DISTINCT(title)) /* take away count to see what they were*/
FROM data_analyst_jobs
WHERE title IS NOT NULL
/* 881 */

-- 8. How many unique job titles are there for California companies?
SELECT COUNT(DISTINCT title) 
FROM data_analyst_jobs AS d 
WHERE d.location = 'CA' AND d.company IS NOT NULL;
/* 230 */

-- 9. Find the name of each company and its average star rating for all companies that have more than 5000 reviews across all locations. 
-- How many companies are there with more that 5000 reviews across all locations?
SELECT DISTINCT(company), ROUND(AVG(star_rating),2) AS avg_rating
FROM data_analyst_jobs
WHERE company IS NOT NULL
	   AND review_count > 5000
GROUP BY company;
/* 40 */

-- 10. Add the code to order the query in #9 from highest to lowest average star rating. 
-- Which company with more than 5000 reviews across all locations in the dataset has the highest star rating? What is that rating?
SELECT DISTINCT(company), ROUND(AVG(star_rating),2) AS avg_rating
FROM data_analyst_jobs
WHERE company IS NOT NULL
	   AND review_count > 5000
GROUP BY company
ORDER BY avg_rating DESC;
/* American Express 4.20 */

-- 11. Find all the job titles that contain the word ‘Analyst’. How many different job titles are there?
SELECT (title)
FROM data_analyst_jobs
WHERE title ILIKE '%Analyst%'
/* 1669 */

-- 12. How many different job titles do not contain either the word ‘Analyst’ or the word ‘Analytics’? What word do these positions have in common?
SELECT title
FROM data_analyst_jobs
WHERE lower(title) NOT LIKE '%analyst%'
	AND lower(title) NOT LIKE '%analytics%';
/*4 and Specialist */

-- BONUS: You want to understand which jobs requiring SQL are hard to fill. 
--Find the number of jobs by industry (domain) that require SQL and have been posted longer than 3 weeks.
SELECT domain, COUNT(title) AS jobs
FROM data_analyst_jobs
WHERE lower(skill) LIKE lower('%SQL%')
	AND days_since_posting > 21
	AND domain IS NOT NULL
GROUP BY domain
ORDER by jobs DESC;

/* Disregard any postings where the domain is NULL.
Order your results so that the domain with the greatest number of hard to fill jobs is at the top.
Which three industries are in the top 4 on this list? How many jobs have been listed for more than 3 weeks for each of the top 4?*/ 

SELECT domain
FROM data_analyst_jobs
WHERE days_since_posting >= 21 
	AND domain IS NOT NULL
	AND skill = 'SQL'
ORDER BY domain DESC;
