DROP DATABASE IF EXISTS trading;

CREATE DATABASE IF NOT EXISTS trading;
USE trading;

CREATE TABLE members (
  `member_id` VARCHAR(6) PRIMARY KEY,
  `first_name` VARCHAR(7),
  `region` VARCHAR(13)
);

CREATE TABLE prices (
  `ticker` VARCHAR(3),
  `market_date` DATE,
  `price` FLOAT,
  `open` FLOAT,
  `high` FLOAT,
  `low` FLOAT,
  `volume` VARCHAR(7),
  `change` VARCHAR(7),
  PRIMARY KEY (ticker, market_date)
);

CREATE TABLE transactions (
  `txn_id` INTEGER PRIMARY KEY,
  `member_id` VARCHAR(6),
  `ticker` VARCHAR(3),
  `txn_date` DATE,
  `txn_type` VARCHAR(4),
  `quantity` FLOAT,
  `percentage_fee` FLOAT,
  `txn_time` TIMESTAMP
);

