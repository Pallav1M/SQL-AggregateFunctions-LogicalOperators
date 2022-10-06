CREATE DATABASE book_shop;
use book_shop;

CREATE TABLE book
	(
		book_id INT NOT NULL AUTO_INCREMENT,
		title VARCHAR(100),
		author_fname VARCHAR(100),
		author_lname VARCHAR(100),
		released_year INT,
		stock_quantity INT,
		pages INT,
		PRIMARY KEY(book_id)
	);
desc book;
INSERT INTO book (title, author_fname, author_lname, released_year, stock_quantity, pages)
VALUES
('The Namesake', 'Jhumpa', 'Lahiri', 2003, 32, 291),
('Norse Mythology', 'Neil', 'Gaiman',2016, 43, 304),
('American Gods', 'Neil', 'Gaiman', 2001, 12, 465),
('Interpreter of Maladies', 'Jhumpa', 'Lahiri', 1996, 97, 198),
('A Hologram for the King: A Novel', 'Dave', 'Eggers', 2012, 154, 352),
('The Circle', 'Dave', 'Eggers', 2013, 26, 504),
('The Amazing Adventures of Kavalier & Clay', 'Michael', 'Chabon', 2000, 68, 634),
('Just Kids', 'Patti', 'Smith', 2010, 55, 304),
('A Heartbreaking Work of Staggering Genius', 'Dave', 'Eggers', 2001, 104, 437),
('Coraline', 'Neil', 'Gaiman', 2003, 100, 208),
('What We Talk About When We Talk About Love: Stories', 'Raymond', 'Carver', 1981, 23, 176),
("Where I'm Calling From: Selected Stories", 'Raymond', 'Carver', 1989, 12, 526),
('White Noise', 'Don', 'DeLillo', 1985, 49, 320),
('Cannery Row', 'John', 'Steinbeck', 1945, 95, 181),
('Oblivion: Stories', 'David', 'Foster Wallace', 2004, 172, 329),
('Consider the Lobster', 'David', 'Foster Wallace', 2005, 92, 343);

select * from book;

-- Adding more data to the table 

INSERT INTO book
    (title, author_fname, author_lname, released_year, stock_quantity, pages)
    VALUES ('10% Happier', 'Dan', 'Harris', 2014, 29, 256), 
           ('fake_book', 'Freida', 'Harris', 2001, 287, 428),
           ('Lincoln In The Bardo', 'George', 'Saunders', 2017, 1000, 367);
 
 select title from book;
 
--  Using distinct

 select distinct author_lname from book;
 
 select distinct released_year 
 from book 
 where released_year = 2003;
 
 SELECT DISTINCT CONCAT(author_fname,' ', author_lname) FROM book;
 
 select distinct author_fname, author_lname
 from book;
 
--  ORDER BY
select distinct author_lname from book order by author_lname;

select distinct released_year from book 
order by released_year desc;

select title, author_fname, author_lname
from book order by 2;
-- sorts by author_name 

SELECT author_fname, author_lname FROM book
ORDER BY author_lname, author_fname;

-- LIMIT 

select title, released_year from book
order by released_year desc limit 5;
-- displays first five 

select title, released_year from book
order by released_year desc limit 5, 464757587;

SELECT title, released_year FROM book
ORDER BY released_year DESC LIMIT 10,1;
-- displays one row from the 11th row till (it starts at 0th row)

SELECT title, released_year FROM book
ORDER BY released_year DESC LIMIT 1,3;

select * from book ORDER BY released_year DESC;

-- SEARCHES WITH WILDCARD
-- %

select title, author_fname
from book
where author_fname like '%da%';

select title, author_fname
from book
where author_fname like 'da%';

select title
from book
where title like 'the%';

-- SEARCH with _ 

select title, stock_quantity
from book
where stock_quantity like '____';
-- exact number of characters

SELECT title FROM book WHERE title LIKE '%\%%';
-- the percentatge after the backslash is the character we are searching for
 
SELECT title FROM book WHERE title LIKE '%\_%';

-- select titles with stories in it
select title as 'title_with_story' from book
where title like '%stories%';

-- select the longest book
select title, pages from book order by pages desc limit 1;

-- select titile and release year
select concat(title, " - ", released_year) as summary 
from book order by released_year desc limit 3;

-- where author last name has a space
select author_lname from book 
where author_lname like '%\ %';

-- select all caps the following
select concat('MY FAVORITE AUTHOR IS', ' ', upper(author_fname), ' ', upper(author_lname), '!' ) from book;

-- MAGIC OF AGGREGATE FUNCTIONS
-- COUNT
select count(distinct(author_fname)) from book;

select count(distinct author_fname, author_lname) from book;

select count(title) from book 
where title like '%the%';

-- GROUP BY (summarizes or aggregates identical data into single rows)
select author_lname, count(*)
from book
group by author_lname;

select author_fname, author_lname, count(*) as 'number of book'
from book 
group by author_fname, author_lname;

select released_year, count(*) 
from book 
group by released_year order by  1 desc;

select author_lname from book
group by author_lname;

-- SUBQUERY - PROBLEM WITH MIN AND MAX

Select title, pages from book 
where pages = (select max(pages) from book);

select title, pages from book 
order by pages desc limit 1;

-- USING MIN AND MAX WITH GROUP BY

-- find the year each author published their first book?

select min(released_year) , author_fname, author_lname from book 
group by author_fname, author_lname;

select min(pages) , author_fname, author_lname from book 
group by author_fname, author_lname;

SELECT
  CONCAT(author_fname, ' ', author_lname) AS author,
  MAX(pages) AS 'longest book'
FROM book
GROUP BY author_lname,
         author_fname;
         
-- SUM

select sum(pages) 
from book;

-- Sum all pages each author has written 

SELECT 
    SUM(pages), author_fname, author_lname
FROM
    book
GROUP BY author_fname , author_lname;

-- AVG

Select round(avg(pages),2) from book;

-- Calculate the average stock quantity for books released in the ssame year

select avg(stock_quantity), released_year 
from book 
group by released_year;

-- AGGREGATE FUNCTION CHALLENGES

-- print number of books in the database
select count(title) 
from book;

-- no of books released in each year

select count(title) , released_year
from book
group by released_year;

select sum(stock_quantity) from book;

-- find average released_year for each author
select round(avg(released_year), 0), author_fname, author_lname
from book 
group by author_fname, author_lname;

-- find full name of te author who wrote the longest book (3 ways)

select concat(author_fname, ' ' ,author_lname), max(pages)
from book
group by author_fname, author_lname
order by max(pages) desc limit 1;

select author_fname, author_lname, pages
from book 
where pages =( 
select max(pages) from book);

select concat(author_fname, ' ' ,author_lname), pages
from book
order by pages desc limit 1;

select released_year, count(title), avg(pages) 
from book 
group by released_year;

-- THE POWER OF LOGICAL OPERATOR 
-- NOT EQUAL TO
-- Select all book titles that are not published in 2017
use book_shop;
SELECT 
    title, released_year
FROM
    book
WHERE
    released_year != 2017;
    
SELECT 
    title, author_lname
FROM
    book
WHERE
    author_lname != 'Harris';

-- NOT LIKE

select title from book where title like "W%";

-- Select all titles that do not start with W

select title from book where title not like "W%";

-- GREATER THAN
-- Released year after 2000
select * from book 
where released_year > 2000 
order by released_year asc; 

select title, stock_quantity from book 
where stock_quantity >= 100;

select 99 > 1; 
-- (evaluates to true i.e 1)

select 99> 567;

select 100 > 5;

select -15 > 15;

select 9 > -10;

select 1 > 1;

select 'a' > 'b';

select 'A' = 'a';

SELECT title, author_lname FROM book WHERE author_lname = 'Eggers';
 
SELECT title, author_lname FROM book WHERE author_lname = 'eggers';
 
SELECT title, author_lname FROM book WHERE author_lname = 'eGGers';

-- LESS THAN

select * from book 
where released_year < 2000 
order by released_year asc; 

select 3 < -10;
-- 0
select -10 < -9;
-- 1
select 42 <= 42;
-- 1
select 'h' < 'p';
-- 1
select 'Q' <= 'q';
-- 1

-- LOGICAL AND

-- select books written by eggers and published after 2010
select title, author_lname
from book where author_lname = "eggers"
and released_year > 2010;

select title, author_lname
from book where author_lname = "eggers"
&& released_year > 2010;

SELECT 1 < 5 && 7 = 9;
-- false
 
SELECT -10 > -20 && 0 <= 0;
-- true
 
SELECT -40 <= 0 AND 10 > 40;
--false
 
SELECT 54 <= 54 && 'a' = 'A';
-- true

SELECT * 
FROM book
WHERE author_lname='Eggers' 
    AND released_year > 2010 
    AND title LIKE '%novel%';
    
-- LOGICAL OR
SELECT 
    title, 
    author_lname, 
    released_year 
FROM book
WHERE author_lname='Eggers' || released_year > 2010;
 
 
SELECT 40 <= 100 || -2 > 0;
-- true
 
SELECT 10 > 5 || 5 = 5;
-- true
 
SELECT 'a' = 5 || 3000 > 2000;
-- true
 
SELECT title, 
       author_lname, 
       released_year, 
       stock_quantity 
FROM   book
WHERE  author_lname = 'Eggers' 
              || released_year > 2010 
OR     stock_quantity > 100;

-- BETWEEN
select title, released_year 
from book 
where released_year >= 2004 and released_year <=2015;

SELECT title, released_year FROM book
WHERE released_year BETWEEN 2004 AND 2015;
 
SELECT title, released_year FROM book 
WHERE released_year NOT BETWEEN 2004 AND 2015;
 
SELECT CAST('2017-05-02' AS DATETIME);
 
show databases;
 
use testing_db;
 
SELECT name, birthdt FROM people WHERE birthdt BETWEEN '1980-01-01' AND '2000-01-01';
-- Better way to write it is to use CAST
SELECT 
    name, 
    birthdt 
FROM people
WHERE 
    birthdt BETWEEN CAST('1980-01-01' AS DATETIME)
    AND CAST('2000-01-01' AS DATETIME);
 
--  IN and NOT IN

use book_shop;

SELECT 
    title, 
    author_lname 
FROM book
WHERE author_lname='Carver' OR
      author_lname='Lahiri' OR
      author_lname='Smith';
 
--  Using IN
SELECT title, author_lname FROM book
WHERE author_lname IN ('Carver', 'Lahiri', 'Smith');
 
SELECT title, released_year FROM book
WHERE released_year IN (2017, 1985);
 
SELECT title, released_year FROM book
WHERE released_year != 2000 AND
      released_year != 2002 AND
      released_year != 2004 AND
      released_year != 2006 AND
      released_year != 2008 AND
      released_year != 2010 AND
      released_year != 2012 AND
      released_year != 2014 AND
      released_year != 2016;
 
SELECT title, released_year FROM book
WHERE released_year NOT IN 
(2000,2002,2004,2006,2008,2010,2012,2014,2016);
 
SELECT title, released_year FROM book
WHERE released_year >= 2000
AND released_year NOT IN 
(2000,2002,2004,2006,2008,2010,2012,2014,2016);
 
--  Using modulo operator
SELECT title, released_year FROM book
WHERE released_year >= 2000 AND
released_year % 2 != 0;
 
SELECT title, released_year FROM book
WHERE released_year >= 2000 AND
released_year % 2 != 0 ORDER BY released_year;

-- CASE Statements 
SELECT title, released_year,
       CASE 
         WHEN released_year >= 2000 THEN 'Modern Lit'
         ELSE '20th Century Lit'
       END AS GENRE
FROM book;
 
SELECT title, stock_quantity,
    CASE 
        WHEN stock_quantity BETWEEN 0 AND 50 THEN '*'
        WHEN stock_quantity BETWEEN 51 AND 100 THEN '**'
        ELSE '***'
    END AS STOCK
FROM book;
 
SELECT title,
    CASE 
        WHEN stock_quantity BETWEEN 0 AND 50 THEN '*'
        WHEN stock_quantity BETWEEN 51 AND 100 THEN '**'
        ELSE '***'
    END AS STOCK
FROM book;
 
SELECT title, stock_quantity,
    CASE 
        WHEN stock_quantity BETWEEN 0 AND 50 THEN '*'
        WHEN stock_quantity BETWEEN 51 AND 100 THEN '**'
        WHEN stock_quantity BETWEEN 101 AND 150 THEN '***'
        ELSE '****'
    END AS STOCK
FROM book;
 
SELECT title, stock_quantity,
    CASE 
        WHEN stock_quantity <= 50 THEN '*'
        WHEN stock_quantity <= 100 THEN '**'
        ELSE '***'
    END AS STOCK
FROM book; 

-- LOGICAL OPERATOR EXERCISE
Select 10 !=10;
-- 0
select 15 > 14 and 99 - 5 <= 94;
-- 1 and 1= 1
select 1  in (5,3) || 9 between 8 and 10;
-- 0 or 1 = 1

-- select all books written before 1980
select title, released_year
from book 
where released_year < 1980;

-- select all books written by eggers or chabon
select title, author_lname 
from book
where author_lname in("eggers", "chabon");

select title, author_lname 
from book
where author_lname = "eggers"
or author_lname = "chabon";

-- select all books written by lahiri, published after 2000
select title, author_lname, released_year 
from book
where author_lname = "lahiri" 
and released_year > 2000;

-- select all books where page counts between 100 and 200

select title, pages 
from book 
where pages between 100 and 200;

select title, pages 
from book 
where pages >=100 and pages <=200;

-- select all books where the author last name starts with a c or s
select title , author_lname
from book 
where author_lname like 'c%' or author_lname like 's%';

select title, author_lname 
from book
where substr(author_lname,1,1) = 'c' or 
substr(author_lname,1,1) = 's';

select title, author_lname 
from book
where substr(author_lname,1,1) in ('c','s');

-- question on case
SELECT title,
       CASE 
		WHEN title like '%stories%' THEN 'Short Stories'
		WHEN title = 'Just Kids' or title like '%a heartbreaking work%' THEN 'Memoir'
		ELSE 'Novel'
        END AS Type
FROM book; 

select author_lname,
case
when count(*) = 1 then '1 book'
else concat(count(*), ' books')
end as count
from book
group by author_lname, author_fname;






