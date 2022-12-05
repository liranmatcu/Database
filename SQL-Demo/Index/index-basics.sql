USE demo;

/*
 Implicit index creation:
 -- Indexes will be created for PK, FK and UNIQUE columns
    by default at the time of table creation.
 */
DROP TABLE IF EXISTS dept_index_demo;
CREATE TABLE IF NOT EXISTS dept_index_demo(
    dept_id INT PRIMARY KEY AUTO_INCREMENT,
    dept_name VARCHAR(30)
) ;
SHOW INDEXES FROM dept_index_demo;

DROP TABLE IF EXISTS emp_index_demo;
CREATE TABLE IF NOT EXISTS emp_index_demo(
    emp_id INT PRIMARY KEY AUTO_INCREMENT,
    emp_name VARCHAR(30) UNIQUE,
    dept_id INT,
    CONSTRAINT emp_dept_id_fk
        FOREIGN KEY (dept_id) REFERENCES dept_index_demo(dept_id)
) ;
SHOW INDEXES FROM emp_index_demo;

/*
 Explicit index creation:
    -- Specify indexes for a table at the time of creation

 Syntax (inside CREATE TABLE):
 [UNIQUE | FULLTEXT | SPATIAL] INDEX index_name (column_list)

 * INDEX (or KEY) refers to a normal non-unique index.

 * UNIQUE refers to an index where all rows of the index must be unique.
 That is, the same row may not have identical non-NULL values
 for all columns in this index as another row.

 * PRIMARY acts exactly like a UNIQUE index, except that it is always named 'PRIMARY',
 and there may be only one on a table

 * FULLTEXT indexes are only useful for full text searches,
 and their behaviour differs significantly between database systems.

 * SPATIAL indexes are for indexing geo-objects - shapes.
 The spatial index makes it possible to efficiently search for objects that overlap in space.

 */

# Create a normal non-unique index
DROP TABLE IF EXISTS book;
CREATE TABLE IF NOT EXISTS book(
    book_id INT,
    book_name VARCHAR(100),
    book_author VARCHAR(100),
    book_comments VARCHAR(300),
    INDEX idx_name(book_name) # A normal non-unique index on book_name
) ;
SHOW INDEX FROM book;

# Check execution plan via EXPLAIN
EXPLAIN SELECT * FROM book WHERE book_name = 'MySQL';
EXPLAIN SELECT * FROM book WHERE book_author = 'John Doe';

# Create a unique index
DROP TABLE IF EXISTS book;
CREATE TABLE IF NOT EXISTS book(
    book_id INT,
    book_name VARCHAR(100),
    book_author VARCHAR(100),
    book_comments VARCHAR(300),
    UNIQUE INDEX idx_comments(book_comments) # A UNIQUE index on book_comments
) ;
SHOW INDEXES FROM book;

# Create a multi-column index
DROP TABLE IF EXISTS book;
CREATE TABLE IF NOT EXISTS book(
    book_id INT,
    book_name VARCHAR(100),
    book_author VARCHAR(100),
    book_comments VARCHAR(300),
    INDEX idx_multi(book_name, book_author, book_comments)
) ;
SHOW INDEXES FROM book;


/*
 Create indexes after table creation:
    -- CREATE INDEX index_name ON table_name (column_list)
 */

DROP TABLE IF EXISTS book;
CREATE TABLE IF NOT EXISTS book(
    book_id INT,
    book_name VARCHAR(100),
    book_author VARCHAR(100),
    book_comments VARCHAR(300)
) ;

CREATE INDEX idx_name ON book(book_name);
CREATE UNIQUE INDEX idx_comments ON book(book_comments);
SHOW INDEX FROM book;

ALTER TABLE book
ADD PRIMARY KEY (book_id);
SHOW INDEX FROM book;

-- Drop indexes
DROP INDEX idx_name ON book;
ALTER TABLE book DROP INDEX idx_comments;
ALTER TABLE book DROP PRIMARY KEY;
SHOW INDEX FROM book;

