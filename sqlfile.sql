COLUMN first_name heading "NAME" format A15
COLUMN last_name heading "Last" format A20
COLUMN email heading "E-mail" format A20
COLUMN phone_number heading "Mobile" format A20

CREATE TABLE userTBL
(   user_ID    CHAR(10) NOT NULL PRIMARY KEY,
    user_Name   NVARCHAR2(5) NOT NULL,
    BirthYear   NUMBER(10) NOT NULL,
    Address     NCHAR(10) NOT NULL,
    Mobile1     CHAR(3),
    Mobile2     CHAR(8),
    Height      NUMBER(3),
    mDate       DATE
);

CREATE TABLE buyTBL
(   idNum       NUMBER(8) NOT NULL PRIMARY KEY,
    user_ID     CHAR(10) NOT NULL,
    Prod_Name   NCHAR(5) NOT NULL,
    Group_Name  NCHAR(5),
    Price       NUMBER(8) NOT NULL,
    Amount      NUMBER(3) NOT NULL,
    FOREIGN KEY (user_ID) REFERENCES userTBL(user_ID)
);


CREATE TABLE TEST_TBL
(   date_time   CHAR(20) NOT NULL,
    ability_s   CHAR(10) NOT NULL,
    current_n   CHAR(10) NOT NULL,
    predict_n   CHAR(10) NOT NULL,
    residu_su   CHAR(10) NOT NULL,
    ratio_resi  CHAR(10) NOT NULL,
    residu_op   CHAR(10) NOT NULL,
    ratio_op    CHAR(10) NOT NULL
);

$sqlldr userid=c##sqldb/1234 control='C:\app\test1.ctl'

ALTER TABLE sample_product DROP COLUMN factory_name;