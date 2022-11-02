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

# Isolation in ACID
/*
 The database transactions must complete their tasks
 independently from the other transactions.

 This property enables us to execute the transactions
 concurrently on the database systems.

 So, the data changes which are made up by the
 transactions are not visible until the transactions
 complete (committed) their actions.

 The SQL standard describes three read phenomena,
 and they can be experienced when more than one transaction
 tries to read and write to the same resources.
    1. Dirty-reads: the state of reading uncommitted data
    2. Non-repeatable reads
    3. Phantom reads
 */

/*
 InnoDB offers all four transaction isolation levels described
 by the SQL:1992 standard:
 READ UNCOMMITTED, READ COMMITTED, REPEATABLE READ, and SERIALIZABLE.
 The default isolation level for InnoDB is REPEATABLE READ.
 */

# Show current TRANSACTION ISOLATION LEVEL
SELECT @@transaction_ISOLATION;

# START TRANSACTION;
# UPDATE bank_account
# SET balance = balance - 1000
# WHERE name = 'Tom';
# SELECT * FROM bank_account;
#
# ROLLBACK;

