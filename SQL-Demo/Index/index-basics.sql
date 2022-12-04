USE demo;

# Implicit index creation on table creation by default
# Indexes will be created for PK, FK and Unique columns
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

# Explicit index creation on table creation
DROP TABLE IF EXISTS book;
CREATE TABLE IF NOT EXISTS book(
    book_id INT,
    book_name VARCHAR(100),
    book_author VARCHAR(100),
    book_comments VARCHAR(300),
    INDEX idx_name(book_name)
) ;
SHOW INDEXES FROM book;

# Performance analysis
EXPLAIN SELECT * FROM book WHERE book_name = 'MySQL';
EXPLAIN SELECT * FROM book WHERE book_author = 'John Doe';

DROP TABLE IF EXISTS book;
CREATE TABLE IF NOT EXISTS book(
    book_id INT,
    book_name VARCHAR(100),
    book_author VARCHAR(100),
    book_comments VARCHAR(300),
    UNIQUE INDEX idx_comments(book_comments)
) ;
SHOW INDEXES FROM book;





