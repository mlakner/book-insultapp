DROP TABLE IF EXISTS SLA_PENALTY;
DROP TABLE IF EXISTS SLA_SOLUTION;
DROP TABLE IF EXISTS SLA_SERVICELEVEL;

BEGIN;

CREATE TABLE SLA_PENALTY
(
	SLA_NAME	    varchar(255) NOT NULL,
	LIMIT_DEV_MIN	numeric(6)	 NOT NULL,
	LIMIT_DEV_MAX	numeric(6)	 NOT NULL,
	PENALTY_REL		numeric(6)	 NOT NULL,
    VALID_FROM      varchar(14)  NOT NULL, 
    VALID_TO        varchar(14)  NOT NULL,
    
    CONSTRAINT SLA_PENALTY_CHK_LIMITDEV CHECK (LIMIT_DEV_MIN<=LIMIT_DEV_MAX),
    CONSTRAINT PK_SLA_PENALTY PRIMARY KEY (SLA_NAME, LIMIT_DEV_MIN, VALID_FROM, VALID_TO)
)
;


--PostgreSQL automatically creates an index for each unique constraint and primary key constraint to enforce uniqueness. Thus, it is not necessary to create an index explicitly for primary key columns. 
--not neeed:
CREATE INDEX IDX3_SLA_PENALTY ON SLA_PENALTY (SLA_NAME);
CREATE UNIQUE INDEX IDX2_SLA_PENALTY ON SLA_PENALTY (SLA_NAME, LIMIT_DEV_MAX, VALID_FROM, VALID_TO);


--maybe?
--CREATE UNIQUE INDEX IDX2_LKP_SLA_PENALTY ON SLA_PENALTY (SLA_NAME) INCLUDE (LIMIT_DEV_MAX, VALID_FROM, VALID_TO);

CREATE TABLE SLA_SOLUTION
(
	SOLUTION	            varchar(40)     NOT NULL,
    RECORD_DATE	            varchar(6)		NOT NULL,
    CUSTOMER    	        varchar(100)            ,
	NUMBER_ACTIVE_SPS		numeric(6)	    NOT NULL,
	CANCELLATION_DATE		varchar(14)
)
;



CREATE TABLE SLA_SERVICELEVEL
(
	SLA_NAME	    varchar(255) PRIMARY KEY NOT NULL,
	SPCOMMIT_VALUE	numeric(38)	 NOT NULL,
	SOLCOMMIT_FLAG	numeric(1)	 NOT NULL,
	SLA_TYPE		numeric(1)	 NOT NULL,
	SLA_VERSION		varchar(10)	 NOT NULL,
	PROCESS_FLAG	numeric(1)	 NOT NULL,
    VALID_FROM      varchar(14)          , 
    VALID_TO        varchar(14)          ,
    CONSTRAINT PK_SLA_SERVICELEVEL UNIQUE(SLA_NAME),
    CONSTRAINT SLA_SERVICELEVEL_CHK_PROCF CHECK (PROCESS_FLAG IN (-1,0,1,2,3)),
    CONSTRAINT SLA_SERVICELEVEL_CHK_STYPE CHECK (SLA_TYPE IN (1,2)),
    CONSTRAINT SLA_SERVICELEVEL_CHK_SOLCF CHECK (SOLCOMMIT_FLAG IN (0,1))
)
;

--INSERT 
--SLA_PENALTY
INSERT INTO SLA_PENALTY
VALUES ('sla1', 111111, 999999, 122222, '2018.01.', '2020.01' );

INSERT INTO SLA_PENALTY
VALUES ('sla2', 222222, 888888, 322222, '2017.01.', '2019.01' );

INSERT INTO SLA_PENALTY
VALUES ('sla3', 333333, 777777, 422222, '2016.01.', '2021.01' );

--SLA_SOLUTION
INSERT INTO SLA_SOLUTION
VALUES ('solution1', '180101', 'customer1' 111111, '2018.02');

INSERT INTO SLA_SOLUTION
VALUES ('solution2', '170101', 'customer2' 111112, '2017.02');

--SLA_SERVICELEVEL
INSERT INTO SLA_SERVICELEVEL
VALUES ('sla1', 555, 1, 2, 'version1', 0, '2018.01.', '2020.01');

INSERT INTO SLA_SERVICELEVEL
VALUES ('sla2', 666, 0, 2, 'version2', 0, '2017.01.', '2019.01');

INSERT INTO SLA_SERVICELEVEL
VALUES ('sla13', 555, 0, 1, 'version1', 3, '2016.01.', '2021.01');


END;
COMMIT;
