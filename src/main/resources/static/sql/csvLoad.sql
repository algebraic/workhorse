
---------------------------------------------------------------------------------
--  csv_data is a little bit hosed... 
--  the big proper ocommand doesn't work because of csv datatypes I think
--  so we're just doing the quick-n-dirty table load for the data 
--  ** still need to make sure the format doesn't contain % or , characters **
---------------------------------------------------------------------------------
DROP TABLE IF EXISTS RECORD_COUNT;
CREATE TABLE RECORD_COUNT AS SELECT * FROM CSVREAD('C:\\stuff\\h2\\csv_data_clean.csv');
ALTER TABLE RECORD_COUNT ADD COLUMN id INT AUTO_INCREMENT PRIMARY KEY;
------------------------------------------------------------------------------------------
DROP TABLE IF EXISTS csv_data;
CREATE TABLE csv_data AS SELECT * FROM CSVREAD('C:\\stuff\\h2\\csv_data_clean.csv');
ALTER TABLE csv_data ADD COLUMN id INT AUTO_INCREMENT PRIMARY KEY;


DROP TABLE IF EXISTS csv_data;
CREATE TABLE csv_data (
    id INT AUTO_INCREMENT PRIMARY KEY,
    KPI_ID VARCHAR(255),
    -- FOREIGN KEY (KPI_ID) REFERENCES csv_kpi(KPI_ID),
    EntryDate VARCHAR(255),
    PRCT_VAL DECIMAL(5, 2), -- Adjust the precision and scale as needed
    COUNT_VAL INT
);
INSERT INTO csv_data (KPI_ID, EntryDate, PRCT_VAL, COUNT_VAL)
SELECT "KPI_ID" as KPI_ID, "EntryDate" as EntryDate, "PRCT_Val" as	PRCT_VAL, "COUNT_Val" as COUNT_VAL
FROM CSVREAD('C:\\stuff\\h2\\csv_data_clean.csv');




------------------------------------------------------------------------
--  csv_kpi is working :)
--  
------------------------------------------------------------------------

DROP TABLE IF EXISTS KPI;
CREATE TABLE KPI (
    id INT AUTO_INCREMENT PRIMARY KEY,
    bureau VARCHAR(255),
    KPI_AREA VARCHAR(255),
    KPI_Name VARCHAR(255),
    KPI_ID VARCHAR(255),
    historical_data VARCHAR(255),
    data_type VARCHAR(255),
    data_store_type VARCHAR(255),
    calc_denominator INT,
    target VARCHAR(255),
    rolling_avg BOOLEAN,
    access VARCHAR(255),
    requested_by VARCHAR(255),
    source_system VARCHAR(255),
    data_feed VARCHAR(255),
    comments VARCHAR(255),
    dev_comments VARCHAR(255)
);

INSERT INTO KPI (bureau, KPI_AREA, KPI_Name, KPI_ID, historical_data, data_type, data_store_type, calc_denominator, target, rolling_avg, access, requested_by, source_system, data_feed, comments, dev_comments)
SELECT "BUREAU" AS bureau, "KPI_AREA" AS KPI_AREA, "KPI Name" AS KPI_Name, "KPI_ID" AS KPI_ID, "Historical Data Processed From" AS historical_data, "TYPE" AS data_type, "Data Stored As" AS data_store_type, "Denominator for % Calculation" AS calc_denominator, "TARGET" AS target, "12 Month Rolling Avg." AS rolling_avg, "ACCESS" AS access, "Requested by" AS requested_by, "Source System" AS source_system, "Data Feed" AS data_feed, "COMMENTS" AS comments, "Dev Comments" AS dev_comments
FROM CSVREAD('C:\\stuff\\h2\\csv_kpi.csv');