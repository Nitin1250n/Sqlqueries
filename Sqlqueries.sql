-- 1.Display all records from the titles table.
select *
from titles;

-- 2. Display only id, title, type, and release_year from the titles table
select 
id,
title,
type,
release_year
from titles;

-- 3. Find all titles that are Movies.
select title
from titles
where type='Movie';

-- 4. Find all titles that are  Shows.
select title
from titles
where type='Show';

-- 5. Find all titles released after 2020.
select title
from titles
where release_year>2020;

-- 6. Find all titles with an IMDb score greater than 8.
select title
from titles
where IMDb_score>8;

-- 7. Display all titles ordered by imdb_score from highest to lowest.
select title,imdb_score
from titles
order by imdb_score desc;

-- 8. Find the top 10 highest-rated titles based on IMDb score.
select title,imdb_score
from titles
order by imdb_score desc
limit 10;

-- 9. Find the total number of titles in the dataset.
select count(title) as Number_of_titles
from titles;

-- 10. Find the number of unique release years.
select count(distinct release_year) as unique_years
from titles;

-- 11.Count the total number of titles for each type (Movie and Show).
select type,count(*) Number_of_titles
from titles
group by type;

-- 12. Count how many titles were released in each release year.
select release_year,count(title) as total_tiles
from titles
group by release_year;

-- 13. Find the average IMDb score for each type.
select type ,avg(IMDb_score) as Avg_IMDB_SCORE
from titles
group by type;

-- 14. Count the number of titles with an IMDb score of 8 or higher.
SELECT  COUNT(TITLE) AS Total_titles
FROM TITLES
WHERE IMDb_score>=8;

-- 15. Find the average IMDb score for each release year.
select release_year, avg(IMDb_score) as Avg_IMDb_score
from titles
group by release_year;

-- 17. Find the highest IMDb score among titles released after 2015.
select title,IMDb_score
from titles 
where release_year>2015
order by IMDb_score desc;

-- 18. Find all titles with a runtime greater than 120 minutes.
select title,runtime
from titles 
where runtime>120;

-- Create a new column called rating_category using CASE WHEN:
SELECT title,
imdb_score,
CASE
WHEN IMDb_score>=8 THEN 'Excellent'
WHEN IMDb_score>=6 THEN 'Good'
ELSE 'Average'
END AS rating_category
FROM titles;

-- 19. Count the number of unique release years for each type.
select type,count(distinct(release_year)) as Unique_Year
from titles
group by type;

-- 20. Find the top 5 directors who have directed the highest number of titles.
select c.name,count(title) as Number_of_Titles
from titles as t
join credits as c
on t.id=c.id
where c.role='director'
group by c.name
order by Number_of_Titles desc
limit 5;

-- 21. Find the top 10 highest-rated titles along with their title, IMDb score, and release year.
select 
title, 
IMDb_score,
release_year
from titles
order by IMDb_score desc
limit 10;

-- 22. Find the top 3 highest-rated titles for each release year using a window function.
with cte as(
select title,release_year,Imdb_score,
dense_rank() over( PARTITION BY release_year order by Imdb_score desc) as Rank_no
from titles
)
select * 
from cte
where Rank_no<=3;

-- 23. Find the average IMDb score for each type, and show only types where the average score is greater than 7.
SELECT 
    type,
    AVG(imdb_score) AS avg_imdbscore
FROM titles
GROUP BY type
HAVING AVG(imdb_score) > 7;

-- 24. Find the director who has directed the most titles.
SELECT 
c.name AS director,
COUNT(t.title) AS total_titles
FROM titles AS t
JOIN credits AS c
ON t.id = c.id
WHERE c.role = 'director'
GROUP BY c.name
ORDER BY total_titles DESC
LIMIT 1;

-- 25. ind all titles whose IMDb score is higher than the overall average IMDb score of all titles.
select title,Imdb_score
from titles
where Imdb_score>(
select avg(Imdb_score)  as Avg_Imdbscore
from titles
)