select * from netflix;

-- Q1. What is the total number of Movies and TV Shows on Netflix?
SELECT type, COUNT(*) AS total_titles
FROM netflix
GROUP BY type;

-- Q2. Which are the Top 10 countries producing the most Netflix content?
SELECT country, COUNT(*) AS total_titles
FROM netflix
WHERE country <> 'Unknown'
GROUP BY country
ORDER BY total_titles DESC
LIMIT 10;

-- Q3. What are the Top 10 most common genres on Netflix?
SELECT genre, COUNT(*) AS occurrences
FROM (
    SELECT TRIM(SUBSTRING_INDEX(SUBSTRING_INDEX(listed_in, ',', n.n), ',', -1)) AS genre
    FROM netflix
    JOIN (
        SELECT 1 n UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4
    ) n
    ON CHAR_LENGTH(listed_in) - CHAR_LENGTH(REPLACE(listed_in, ',', '')) >= n.n - 1
) AS g
GROUP BY genre
ORDER BY occurrences DESC
LIMIT 10;

-- Q4. How many titles were added per year? 
SELECT year_added AS year, COUNT(*) AS total_titles
FROM netflix
WHERE year_added IS NOT NULL
GROUP BY year_added
ORDER BY year_added;

-- Q5. Which rating category (TV-MA, PG-13, etc.) has the most content?
SELECT rating, COUNT(*) AS total_titles
FROM netflix
GROUP BY rating
ORDER BY total_titles DESC;

-- Q6. Who are the Top 10 most frequent directors on Netflix?
SELECT director, COUNT(*) AS total_titles
FROM netflix
WHERE director <> 'Unknown'
GROUP BY director
ORDER BY total_titles DESC
LIMIT 10;

-- Q7. Which years had the highest number of movie releases?
SELECT release_year, COUNT(*) AS total_movies
FROM netflix
WHERE type = 'Movie'
GROUP BY release_year
ORDER BY total_movies DESC;

-- Q8. Which countries produce the most TV Shows?
SELECT country, COUNT(*) AS total_tv_shows
FROM netflix
WHERE type = 'TV Show' AND country <> 'Unknown'
GROUP BY country
ORDER BY total_tv_shows DESC
LIMIT 10;

-- Q9. What are the most common durations for Movies? (E.g., 90 mins, 120 mins)
SELECT movie_minutes, COUNT(*) AS frequency
FROM netflix
WHERE type = 'Movie' AND movie_minutes IS NOT NULL
GROUP BY movie_minutes
ORDER BY frequency DESC
LIMIT 10;

-- Q10. Which month sees the highest number of new content additions?
SELECT month_added, COUNT(*) AS total_added
FROM netflix
WHERE month_added IS NOT NULL
GROUP BY month_added
ORDER BY total_added DESC;
