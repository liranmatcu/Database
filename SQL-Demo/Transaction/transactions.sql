USE demo;

CREATE TABLE IF NOT EXISTS bank_account(
    cid INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(30),
    balance INT
);

-- Populate database
INSERT INTO bank_account(name, balance)
VALUES ('Tom', 5000), ('Sue', 3000);

-- Money Transfer
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

-- Check
SELECT *
FROM bank_account;

# With exception
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


# Introduce transaction control
-- Method 1: Change autocommit
SELECT @@autocommit;
SET @@autocommit=0;
# SET autocommit=0;

-- Normal execution vs. Exception

UPDATE bank_account
SET balance = balance + 1000
WHERE name = 'Tom';

-- Check
SELECT *
FROM bank_account;

COMMIT;

-- Data recovery
ROLLBACK;

-- Method 2: Start transaction
SET autocommit=1;

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

ROLLBACK;