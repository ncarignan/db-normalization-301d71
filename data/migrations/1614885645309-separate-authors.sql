------------ Cloned DB ------------
CREATE DATABASE lab14_normal WITH TEMPLATE lab14;
------------ Create Author Table ------------
CREATE TABLE authors (id SERIAL PRIMARY KEY, name VARCHAR(255));
------------ Copy authors into Table ------------
INSERT INTO authors(name) SELECT DISTINCT author FROM books;
------------ Add Author_Id Column ------------
ALTER TABLE books ADD COLUMN author_id INT;
------------ Set Author Key Based on Name ------------
UPDATE books SET author_id=author.id FROM (SELECT * FROM authors) AS author WHERE books.author = author.name;
------------ Remove Old Column ------------
ALTER TABLE books DROP COLUMN author;
------------ Add FK Constraint ------------
ALTER TABLE books ADD CONSTRAINT fk_authors FOREIGN KEY (author_id) REFERENCES authors(id);
