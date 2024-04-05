DROP TABLE IF EXISTS KPI;
CREATE TABLE IF NOT EXISTS KPI(
   bureau          VARCHAR(3) 
  ,KPI_Area        VARCHAR(11)
  ,KPI_Name        VARCHAR(68)
  ,KPI_ID          VARCHAR(11) PRIMARY KEY
  ,fromExcel       BOOLEAN 
  ,dataType        VARCHAR(4)
  ,dataStoreType   VARCHAR(5)
  ,calcDenominator INTEGER 
  ,target          VARCHAR(30)
  ,rollingAvg      BOOLEAN 
  ,access          VARCHAR(8)
  ,requestedBy     VARCHAR(6)
  ,sourceSystem    VARCHAR(6)
  ,dataFeed        VARCHAR(6)
  ,comments        VARCHAR(16)
  ,devComments     VARCHAR(63)
);
INSERT INTO KPI(bureau,KPI_Area,KPI_Name,KPI_ID,fromExcel,dataType,dataStoreType,calcDenominator,target,rollingAvg,access,requestedBy,sourceSystem,dataFeed,comments,devComments) VALUES ('BCC','Inspections','% of required elevator inspections completed each month.','BCC_INSP_01',TRUE,'PRCT','COUNT',2034,NULL,TRUE,'Internal','Dustin','Accela','Manual','% to be entered',NULL);
INSERT INTO KPI(bureau,KPI_Area,KPI_Name,KPI_ID,fromExcel,dataType,dataStoreType,calcDenominator,target,rollingAvg,access,requestedBy,sourceSystem,dataFeed,comments,devComments) VALUES ('BCC','Inspections','% of required boiler inspections completed each month.','BCC_INSP_02',TRUE,'PRCT','COUNT',856,NULL,TRUE,'Internal','Dustin','Accela','Manual','% to be entered',NULL);
INSERT INTO KPI(bureau,KPI_Area,KPI_Name,KPI_ID,fromExcel,dataType,dataStoreType,calcDenominator,target,rollingAvg,access,requestedBy,sourceSystem,dataFeed,comments,devComments) VALUES ('BCC','Inspections','% of required manufactured housing inspections completed each month.','BCC_INSP_03',TRUE,'PRCT','COUNT',85,NULL,TRUE,'Internal','Dustin','Accela','Manual','% to be entered',NULL);
INSERT INTO KPI(bureau,KPI_Area,KPI_Name,KPI_ID,fromExcel,dataType,dataStoreType,calcDenominator,target,rollingAvg,access,requestedBy,sourceSystem,dataFeed,comments,devComments) VALUES ('BCC','Inspections','% of required ski/amusement inspections completed each month.','BCC_INSP_04',TRUE,'PRCT','COUNT',155,NULL,TRUE,'Internal','Dustin','Accela','Manual','% to be entered',NULL);
INSERT INTO KPI(bureau,KPI_Area,KPI_Name,KPI_ID,fromExcel,dataType,dataStoreType,calcDenominator,target,rollingAvg,access,requestedBy,sourceSystem,dataFeed,comments,devComments) VALUES ('BFS','Inspections','% of required storage tank inspections completed each month.','BFS_INSP_01',TRUE,'PRCT','COUNT',292,NULL,TRUE,'Internal','Dustin','Accela','Manual','% to be entered','Double check if mapped backend data/ row is correct with Dustin');
INSERT INTO KPI(bureau,KPI_Area,KPI_Name,KPI_ID,fromExcel,dataType,dataStoreType,calcDenominator,target,rollingAvg,access,requestedBy,sourceSystem,dataFeed,comments,devComments) VALUES ('BFS','Inspections','% of required marijuana facility inspections completed each month.','BFS_INSP_02',TRUE,'PRCT','COUNT',225,NULL,TRUE,'Internal','Dustin','Accela','Manual','% to be entered',NULL);
INSERT INTO KPI(bureau,KPI_Area,KPI_Name,KPI_ID,fromExcel,dataType,dataStoreType,calcDenominator,target,rollingAvg,access,requestedBy,sourceSystem,dataFeed,comments,devComments) VALUES ('BPL','Inspections','% of required barber shop inspections completed each month.','BPL_INSP_01',TRUE,'PRCT','COUNT',113,NULL,TRUE,'Internal','Dustin','Accela','Manual','% to be entered',NULL);


-- zj: new update for field names
create table kpi (
  id bigint not null,
  kpi_area varchar(255),
  kpi_id varchar(255),
  kpi_name varchar(255),
  access varchar(255),
  bureau varchar(255),
  calc_denominator integer not null,
  comments varchar(255),
  data_feed varchar(255),
  data_store_type varchar(255),
  data_type varchar(255),
  dev_comments varchar(255),
  from_excel boolean not null,
  requested_by varchar(255),
  rolling_avg boolean not null,
  source_system varchar(255),
  target varchar(255),
  primary key (id)
)
insert into kpi(id,kpi_area,kpi_id,kpi_name,access,bureau,calc_denominator,comments,data_feed,data_store_type,data_type,dev_comments,from_excel,requested_by,rolling_avg,source_system,target) values (1,'Inspections','BCC_INSP_01','% of required elevator inspections completed each month.','Internal','BCC',2034,'% to be entered','Manual','COUNT','PRCT',NULL,TRUE,'Dustin',TRUE,'Accela',NULL);
insert into kpi(id,kpi_area,kpi_id,kpi_name,access,bureau,calc_denominator,comments,data_feed,data_store_type,data_type,dev_comments,from_excel,requested_by,rolling_avg,source_system,target) values (2,'Inspections','BCC_INSP_02','% of required boiler inspections completed each month.','Internal','BCC',856,'% to be entered','Manual','COUNT','PRCT',NULL,TRUE,'Dustin',TRUE,'Accela',NULL);
insert into kpi(id,kpi_area,kpi_id,kpi_name,access,bureau,calc_denominator,comments,data_feed,data_store_type,data_type,dev_comments,from_excel,requested_by,rolling_avg,source_system,target) values (3,'Inspections','BCC_INSP_03','% of required manufactured housing inspections completed each month.','Internal','BCC',85,'% to be entered','Manual','COUNT','PRCT',NULL,TRUE,'Dustin',TRUE,'Accela',NULL);
insert into kpi(id,kpi_area,kpi_id,kpi_name,access,bureau,calc_denominator,comments,data_feed,data_store_type,data_type,dev_comments,from_excel,requested_by,rolling_avg,source_system,target) values (4,'Inspections','BCC_INSP_04','% of required ski/amusement inspections completed each month.','Internal','BCC',155,'% to be entered','Manual','COUNT','PRCT',NULL,TRUE,'Dustin',TRUE,'Accela',NULL);
insert into kpi(id,kpi_area,kpi_id,kpi_name,access,bureau,calc_denominator,comments,data_feed,data_store_type,data_type,dev_comments,from_excel,requested_by,rolling_avg,source_system,target) values (5,'Inspections','BFS_INSP_01','% of required storage tank inspections completed each month.','Internal','BFS',292,'% to be entered','Manual','COUNT','PRCT','Double check if mapped backend data/ row is correct with Dustin',TRUE,'Dustin',TRUE,'Accela',NULL);
insert into kpi(id,kpi_area,kpi_id,kpi_name,access,bureau,calc_denominator,comments,data_feed,data_store_type,data_type,dev_comments,from_excel,requested_by,rolling_avg,source_system,target) values (6,'Inspections','BFS_INSP_02','% of required marijuana facility inspections completed each month.','Internal','BFS',225,'% to be entered','Manual','COUNT','PRCT',NULL,TRUE,'Dustin',TRUE,'Accela',NULL);
insert into kpi(id,kpi_area,kpi_id,kpi_name,access,bureau,calc_denominator,comments,data_feed,data_store_type,data_type,dev_comments,from_excel,requested_by,rolling_avg,source_system,target) values (7,'Inspections','BPL_INSP_01','% of required barber shop inspections completed each month.','Internal','BPL',113,'% to be entered','Manual','COUNT','PRCT',NULL,TRUE,'Dustin',TRUE,'Accela',NULL);