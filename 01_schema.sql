-- Bank Customer Churn Analysis | MySQL 8+
CREATE DATABASE IF NOT EXISTS bank_churn;
USE bank_churn;
DROP TABLE IF EXISTS customers, geography, age_bands, churn_raw;

CREATE TABLE geography (
  geography_id INT PRIMARY KEY AUTO_INCREMENT,
  country VARCHAR(30) UNIQUE NOT NULL
);
INSERT INTO geography (country) VALUES ('France'),('Germany'),('Spain');

CREATE TABLE age_bands (band VARCHAR(10) PRIMARY KEY, min_age INT, max_age INT);
INSERT INTO age_bands VALUES
('18-29',18,29),('30-39',30,39),('40-49',40,49),('50-59',50,59),('60+',60,120);

CREATE TABLE customers (
  customer_id INT PRIMARY KEY, surname VARCHAR(50), credit_score INT,
  geography_id INT, gender VARCHAR(10), age INT, tenure INT,
  balance DECIMAL(12,2), num_products INT, has_cr_card TINYINT,
  is_active_member TINYINT, estimated_salary DECIMAL(12,2), exited TINYINT,
  FOREIGN KEY (geography_id) REFERENCES geography(geography_id)
);

-- Staging table: download Churn_Modelling.csv into /data first
CREATE TABLE churn_raw (
  RowNumber INT, CustomerId INT, Surname VARCHAR(50), CreditScore INT,
  Geography VARCHAR(30), Gender VARCHAR(10), Age INT, Tenure INT,
  Balance DECIMAL(12,2), NumOfProducts INT, HasCrCard TINYINT,
  IsActiveMember TINYINT, EstimatedSalary DECIMAL(12,2), Exited TINYINT
);
-- SET GLOBAL local_infile = 1;
LOAD DATA LOCAL INFILE 'data/Churn_Modelling.csv' INTO TABLE churn_raw
FIELDS TERMINATED BY ',' ENCLOSED BY '"' LINES TERMINATED BY '\n' IGNORE 1 ROWS;
-- Alternative: MySQL Workbench > Table Data Import Wizard

INSERT INTO customers
SELECT r.CustomerId, r.Surname, r.CreditScore, g.geography_id, r.Gender, r.Age,
       r.Tenure, r.Balance, r.NumOfProducts, r.HasCrCard, r.IsActiveMember,
       r.EstimatedSalary, r.Exited
FROM churn_raw r JOIN geography g ON g.country = r.Geography;
