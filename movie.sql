-- first run create_movie.sql from database_script folder to create the database in your MySQL
use movie;
-- 1. Write a SQL query to find the actors who were cast in the movie 'Annie Hall'. Return actor first name, last name and role.

select act_fname 'First Name', act_lname 'Last Name', role 'Role' -- selecting first and last name of actors and role columns
from actors -- from actors table
join movie_cast on actors.act_id = movie_cast.act_id -- joining actors and movie cast table using actor id 
join movie on movie_cast.mov_id = movie.mov_id -- joining movie_cast and movie table using movie id 
where mov_title = 'Annie Hall'; -- using where filter to find movie name in movie title

-- 2. From the following tables, write a SQL query to find the director who directed a movie that casted a role for 'Eyes Wide Shut'. 
-- 	  Return director first name, last name and movie title.

select dir_fname 'First Name', dir_lname 'Last Name', mov_title 'Movie Title' -- selecting first and last name of director and their directed movie
from director -- from director table
join movie_direction on director.dir_id = movie_direction.dir_id -- joining director and movie direction table usimg director id
join movie on movie_direction.mov_id = movie.mov_id -- joining movie and movie direction table using movie id
where mov_title = 'Eyes Wide Shut'; -- using where filter to find movie name in movie title

-- 3. Write a SQL query to find who directed a movie that casted a role as ‘Sean Maguire’. Return director first name, last name and movie title.

select dir_fname 'First Name', dir_lname 'Last Name', mov_title 'Movie Title' -- selecting first and last name of director and their directed movie
from director -- from director table
join movie_direction on director.dir_id = movie_direction.dir_id -- joining director and movie direction using director id
join movie on movie_direction.mov_id = movie.mov_id -- joining movie direction and movie table using movie id 
join movie_cast on movie.mov_id = movie_cast.mov_id -- joining movie_cast and movie table using movie id
where role = 'Sean Maguire'; -- using where filter to check in role name in role column

-- 4. Write a SQL query to find the actors who have not acted in any movie between1990 and 2000 (Begin and end values are included). 
--    Return actor first name, last name, movie title and release year. 

select act_fname 'First Name', act_lname 'Last Name', mov_title 'Movie', mov_year 'Release Year' -- selecting first and last name from actors table their movie name along with released year
from actors -- from actors table
join movie_cast on actors.act_id = movie_cast.act_id -- joining actors and movie cast table using actor id
join movie on movie_cast.mov_id = movie.mov_id -- joinng movie cast and movie table using movie id
where mov_year not between 1990 and 2000; -- using where filter to select movie year except from 1990 to 2000

-- 5. Write a SQL query to find the directors with number of genres movies. Group the result set on director first name, last name and generic title. 
--    Sort the result-set in ascending order by director first name and last name. Return director first name, last name and number of genres movies.

select dir_fname 'First Name', dir_lname 'Last Name', count(gen_title) 'Number of Genre Movie' -- selecting first and last name of director and counting genre
from director -- from director table
natural join movie_direction -- joining director and movie direction table
natural join movie_genres -- joining director, movie direction and movie genre table
natural join genres -- joining director, movie direction, movie genre and genre table
group by dir_fname, dir_lname,gen_title -- grouping director first and last name along with genre
order by dir_fname,dir_lname; -- filtering director first and last name in ascending order

-- 6. Write a SQL query to find the movies with year and genres. Return movie title, movie year and generic title.

select mov_title 'Movie', mov_year 'Year', gen_title 'Genre' -- selecting movie name along with released year and their genre
from movie -- from movie table
natural join movie_genres -- joining movie and movie genre table
natural join genres; -- joining movie, movie genre and genre tbale

-- 7. Write a SQL query to find all the movies with year, genres, and name of the director. 

select concat(dir_fname ,' ', dir_lname) 'Director Name',mov_title 'Movie', mov_year 'Year', gen_title 'Genre' -- selecting director name with their movie, movie released year and genre
from director -- from director
natural join movie_direction -- joining director and movie direction table
natural join movie --  joining director, movie direction and movie table
natural join movie_genres -- joining director, movie direction, movie, and movie genre table
natural join genres; -- joining director, movie direction, movie, movie genre and genre table

-- 8. Write a SQL query to find the movies released before 1st January 1989. 
--    Sort the result-set in descending order by date of release. 
--    Return movie title, release year, date of release, duration, and first and last name of the director. 

select mov_title 'Movie', mov_year 'Year', date_format(mov_dt_rel, '%d') 'Date', mov_time 'Duration(min)', concat(dir_fname ,' ', dir_lname) 'Director Name' -- selecting movie title with their released year and date, duration time withe their director
from director -- from director
natural join movie_direction -- joining director and movie direction table
natural join movie -- joining director, movie direction and movie table
where mov_dt_rel < '1989-01-01' and mov_dt_rel != 0000-00-00 -- using where filter to find movie released before 1st January 1989 and also for null entries that are zeros
order by 3 desc; -- using order by filter to show date of release in descending order

