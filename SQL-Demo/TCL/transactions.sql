USE demo;

DROP TABLE IF EXISTS bank_account;
-- Create a bank account table
CREATE TABLE IF NOT EXISTS bank_account(
    cid INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(30) UNIQUE,
    balance INT
);
-- Populate the table with two user accounts
INSERT INTO bank_account(name, balance)
VALUES ('Tom', 5000), ('Sue', 5000);

# Demo: Money Transfer as "Transactions"
-- Example: transfer 1,000 from Tom to Sue

# Normal sequence
-- Step 1:
SELECT balance
FROM bank_account
WHERE name = 'Tom';

-- Step 2
UPDATE bank_account
SET balance = balance - 1000
WHERE name = 'Tom';

-- Step 3
UPDATE bank_account
SET balance = balance + 1000
WHERE name = 'Sue';

-- Check results
SELECT * FROM bank_account;
-- Also check the data in DB

# With an exception
-- Step 1:
SELECT balance
FROM bank_account
WHERE name = 'Tom';
-- Step 2
UPDATE bank_account
SET balance = balance - 1000
WHERE name = 'Tom';
-- An exception
This is an exception...
-- Step 3
UPDATE bank_account
SET balance = balance + 1000
WHERE name = 'Sue';

-- Check results
SELECT * FROM bank_account;
-- Also check the data in DB

# Set balance to the original values
UPDATE bank_account
SET balance = 5000
WHERE name = 'Tom' OR name = 'Sue';


# Transaction Control (TCL) in SQL

-- Method 1: Change AUTOCOMMIT to false
SELECT @@autocommit;
SET AUTOCOMMIT = 0;
-- SET @@autocommit=0;

-- Normal Execution vs. Exception
UPDATE bank_account
SET balance = balance + 1000
WHERE name = 'Tom';

-- Check
SELECT * FROM bank_account;

-- COMMIT
/*
 The COMMIT statement saves all the modifications
 made in the current transaction since the last commit
 or the START TRANSACTION statement.

 COMMIT makes its changes permanent.
 */
COMMIT;
-- Check values in database

-- Data recovery with ROLLBACK
/*
 ROLLBACK rolls back the current transaction,
 canceling its changes.
 */
ROLLBACK;


-- Method 2: Use "START TRANSACTION" or "BEGIN TRANSACTION"
# Set AUTOCOMMIT back to 1, which is the default value
SET AUTOCOMMIT = 1;

# Set balance to the original values
UPDATE bank_account
SET balance = 5000
WHERE name = 'Tom' OR name = 'Sue';

START TRANSACTION;
-- Step 1:
SELECT balance
FROM bank_account
WHERE name = 'Tom';
-- Step 2
UPDATE bank_account
SET balance = balance - 1000
WHERE name = 'Tom';
This is an exception...
-- Step 3
UPDATE bank_account
SET balance = balance + 1000
WHERE name = 'Sue';

SELECT * FROM bank_account;

ROLLBACK;

# Isolation in AC(I)D for Concurrent Transactions
/*
 The database transactions must complete their tasks
 independently from the other transactions.

 So, the data changes which are made up by the
 transactions are not visible until the transactions
 complete (committed) their actions.

 The SQL standard describes three read phenomena/anomalies,
 and they can be experienced when more than one transaction
 tries to read and write to the same resources.
    1. Dirty-reads: read uncommitted data

    2. Non-repeatable reads: read committed UPDATES from another transaction.
    The same row now has different values than it did when the transaction began.

    3. Phantom reads: read committed INSERTS and/or DELETES from another transaction.
    There are new rows or disappeared rows since the begin the transaction.
 */

# Transaction Isolation Levels
/*
 InnoDB offers all four transaction isolation levels:
 READ UNCOMMITTED, READ COMMITTED, REPEATABLE READ, and SERIALIZABLE.
 The default isolation level for InnoDB is REPEATABLE READ.

+----------------+------------+---------------------+--------------+
|isolation level | dirty read | non-repeatable read | phantom read |
+----------------+------------+---------------------+--------------+
|Read uncommitted| ×(unsolved)|   ×                 |  ×           |
|Read committed  | √(solved)  |   ×                 |  ×           |
|Repeatable read | √          |   √                 |  ×           |
|Serializable    | √          |   √                 |  √           |
+----------------+------------+---------------------+--------------+
 */

# Show current TRANSACTION ISOLATION LEVEL
SELECT @@transaction_ISOLATION;

# Set ISOLATION LEVEL to be READ UNCOMMITTED
SET SESSION TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
SELECT @@transaction_ISOLATION;

START TRANSACTION;
SELECT * FROM bank_account;

-- Run an update transaction in a separate session
START TRANSACTION;
UPDATE bank_account
SET balance = balance - 1000
WHERE name = 'Tom';
-- Note that this transaction is not committed yet

-- Check (the select query) again in this session.
-- What will happen?

-- Dirty read will happen; so do other anomalies

ROLLBACK;



# Set ISOLATION LEVEL to be READ COMMITTED
SET SESSION TRANSACTION ISOLATION LEVEL READ COMMITTED;
SELECT @@transaction_ISOLATION;

START TRANSACTION;
SELECT * FROM bank_account;
-- Run update in another session; check;
-- then commit; check again
START TRANSACTION;
UPDATE bank_account
SET balance = balance - 1000
WHERE name = 'Tom';



-- Dirty read will NOT happen; Yet, unrepeatable reads;




# Set ISOLATION LEVEL to default: REPEATABLE READ
SET SESSION TRANSACTION ISOLATION LEVEL REPEATABLE READ;
SELECT @@transaction_ISOLATION;

START TRANSACTION;
SELECT * FROM bank_account;

-- Run insert in another session and commit;
START TRANSACTION;
INSERT INTO bank_account(cid, name, balance)
VALUES (100, 'Daemon', 5000);
COMMIT;

-- Check select in this session
SELECT * FROM bank_account WHERE cid = 100;
SELECT * FROM bank_account WHERE name = 'Daemon';
-- and check insert in this session
INSERT INTO bank_account(cid, name, balance)
VALUES (100, 'Daemon', 5000);


-- Phantom read will happen during insertion


-- Now, if read again with a new transaction
START TRANSACTION;
SELECT * FROM bank_account;



# Set ISOLATION LEVEL to SERIALIZABLE
SET SESSION TRANSACTION ISOLATION LEVEL SERIALIZABLE;
SELECT @@transaction_ISOLATION;

START TRANSACTION;
SELECT * FROM bank_account;

-- Run insert in another session
START TRANSACTION;
INSERT INTO bank_account(name, balance)
VALUES ('Real', 5000);
COMMIT;
-- Would the insert be successfully?



-- The insertion would fail b/c SERIALIZABLE
-- Phantom read will not happen during insertion


-- Clean the demo data
DELETE FROM bank_account
WHERE name = 'Real' OR name = 'Daemon';