
-- Creating a copy of the database so that we don't break the production db
CREATE DATABASE lab14_normal WITH TEMPLATE lab14;

-- make the authors table
CREATE TABLE authors (id SERIAL PRIMARY KEY, name VARCHAR(255));

-- Selects all of the authors that are unique in books
INSERT INTO authors(name) SELECT DISTINCT author FROM books;

-- Create a column author_id which will be used to relate to the author table
ALTER TABLE books ADD COLUMN author_id INT;

-- insert the id into the book table from the author table where the author name matches the author column
UPDATE books SET author_id=author.id FROM (SELECT * FROM authors) AS author WHERE books.author = author.name;

-- Deletes the author column from book since we no longer need it
ALTER TABLE books DROP COLUMN author;

-- adds a function that requires the column of author_id to always be set to a real id from the authors table and permanently ties them together
ALTER TABLE books ADD CONSTRAINT fk_authors FOREIGN KEY (author_id) REFERENCES authors(id);