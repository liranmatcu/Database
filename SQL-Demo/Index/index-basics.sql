USE demo;

/*
 Implicit index creation:

 Indexes will be created for PK, FK and UNIQUE columns
 by default at the time of table creation.
 */
DROP TABLE IF EXISTS dept_index_demo;
CREATE TABLE IF NOT EXISTS dept_index_demo(
    dept_id INT PRIMARY KEY AUTO_INCREMENT,
    dept_name VARCHAR(30)
) ;

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
 Specify indexes for a table at the time of creation

 Syntax:
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
DROP TABLE IF EXISTS book;
CREATE TABLE IF NOT EXISTS book(
    book_id INT,
    book_name VARCHAR(100),
    book_author VARCHAR(100),
    book_comments VARCHAR(300),
    INDEX idx_name(book_name) # A normal non-unique index on book_name
) ;
SHOW INDEXES FROM book;

# Execution plan via EXPLAIN
EXPLAIN SELECT * FROM book WHERE book_name = 'MySQL';
EXPLAIN SELECT * FROM book WHERE book_author = 'John Doe';

DROP TABLE IF EXISTS book;
CREATE TABLE IF NOT EXISTS book(
    book_id INT,
    book_name VARCHAR(100),
    book_author VARCHAR(100),
    book_comments VARCHAR(300),
    UNIQUE INDEX idx_comments(book_comments) # A UNIQUE index on book_comments
) ;
SHOW INDEXES FROM book;

#
/*
 CREATE INDEX index_name ON table_name (column_list)
 */



