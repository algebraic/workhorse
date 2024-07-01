DROP TABLE IF EXISTS RECORD;
CREATE TABLE IF NOT EXISTS RECORD(
  KPI_ID        VARCHAR(11) PRIMARY KEY
  ,REC_YEAR     INTEGER 
  ,REC_MONTH    INTEGER 
  ,REC_COUNT    DECIMAL(10,2)
  ,created_by varchar(255)
  ,created_on timestamp
  ,modified_by varchar(255)
  ,modified_on timestamp
);

