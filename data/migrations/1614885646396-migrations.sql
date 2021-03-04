--Creating a copy of the database so that we can
CREATE DATABASE lab14_normal WITH TEMPLATE lab14;

-- make the authors table
CREATE TABLE authors (id SERIAL PRIMARY KEY, name VARCHAR(255));

-- Selects all of the authors that are unique in books
INSERT INTO authors(name) SELECT DISTINCT author FROM books;

--Create a column author-id which will be used to relate to the author table
ALTER TABLE books ADD COLUMN author_id INT;

-- Insert the id into the book table from the author table where the author name matches the author column
UPDATE books SET author_id=author.id FROM (SELECT - FROM authors) AS author WHERE books.author=author.name;

--Deletes the author column from book since we no longer need it
 ALTER TABLE books DROP COLUMN author;

-- Adds a function that requires the oclumn of author_id that 
 ALTER TABLE books ADD CONSTRAINT fk_authors FOREIGN KEY (author_id) REFERENCES authors(id);
 