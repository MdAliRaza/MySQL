-- first run create_movie.sql from database_script folder to create the database in your MySQL

use movie;

-- 1. Write a SQL query to find those reviewers who have rated nothing for some movies. Return reviewer name.

SELECT rev_name 'Reviewer' -- selecting reviewer name 
FROM reviewer -- from reviewer table
WHERE rev_id in -- where reviewer id is in the subquery
(SELECT rev_id FROM rating WHERE rev_stars = 0); -- selecting those reviewer ids from rating table where reviewed stars are zero

-- 2. Write a SQL query to find the movies, which have been reviewed by any reviewer body except by 'Paul Monks'. Return movie title.

SELECT mov_title 'Movie' -- selecting movie title 
FROM movie -- from movie table
WHERE mov_id in -- where movie id is in the subquery
(SELECT mov_id FROM rating WHERE rev_id in -- selecting movie id from rating where reviewer id is in another subquery
(SELECT rev_id FROM reviewer WHERE rev_name != 'Paul Monks')); -- selecting those reviewer id from reviewer table whose reviewer name is not Paul Monks 

-- 3. Write a SQL query to find the lowest rated movies. Return reviewer name, movie title, and number of stars for those movies. 
 
-- if asking for zero rating movies
SELECT rev_name 'Reviewer', mov_title 'Movie', rev_stars 'Review Stars' -- selecting reviewer name movie title and starts got as reviewed
FROM reviewer, movie, rating -- from reviewer movie and rating tables
WHERE rating.rev_stars =  (SELECT min(rating.rev_stars) FROM rating) -- where reviewed stars is equal to minimum reviewed stars from rating table
and rating.rev_id = reviewer.rev_id and rating.mov_id = movie.mov_id; -- and also follow these conditions to connect the rating reviewer and movie table

-- if asking for lowest rating movie other than zero
SELECT rev_name 'Reviewer', mov_title 'Movie', rev_stars 'Review Stars' -- selecting reviewer name movie title and starts got as reviewed
FROM reviewer, movie, rating -- from reviewer movie and rating tables  
WHERE rating.rev_stars =  (SELECT min(rating.rev_stars) FROM rating WHERE rating.rev_stars != 0) -- where reviewed stars is equal to minimum reviewed stars but not zero from rating table
and rating.rev_id = reviewer.rev_id and rating.mov_id = movie.mov_id; -- and also follow these conditions to connect the rating reviewer and movie table


-- 4. Write a SQL query to find the movies directed by 'James Cameron'. Return movie title.

SELECT mov_title 'Movie' -- selecting movie name
FROM movie -- from movie table
WHERE mov_id in -- where movie id is in subquery 
(SELECT mov_id FROM movie_direction WHERE dir_id in -- selectig movie id from movie direction table on director id from another sub query
(SELECT dir_id FROM director WHERE dir_fname = 'James' and dir_lname='Cameron')); -- selecting director id from director table where we have director name as James Cameron

-- 5. Write a query in SQL to find the name of those movies where one or more actors acted in two or more movies. 

SELECT mov_title 'Movie' -- selecting movie title 
FROM movie -- from movie table
WHERE mov_id in -- where movie id is in sub query
(SELECT mov_id FROM movie_cast WHERE act_id in -- selecting movie id from movie cast table on actor id from another sub query
(SELECT act_id FROM actors WHERE act_id in -- selecting actor id from actors table on actor id from another sub query
(SELECT act_id FROM movie_cast group by act_id having count(act_id)>1))); -- selecting actor id from movie cast table and grouping them to count those actor id who is repeated more than once
