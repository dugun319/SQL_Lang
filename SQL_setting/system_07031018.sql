CREATE USER         user_test_01
    IDENTIFIED BY   tiger
;

CREATE USER         user_test_02
    IDENTIFIED BY   tiger
;

CREATE USER         user_test_03
    IDENTIFIED BY   tiger
;

CREATE USER         user_test_04
    IDENTIFIED BY   tiger
;

-- GRANT CREATE SESSION TO -> 접속 권한만 부여
GRANT CREATE SESSION TO user_test_01;

GRANT   CREATE SESSION, 
        CREATE TABLE,
        CREATE VIEW
    TO  user_test_02;

-- 개발자 권한    
GRANT   CONNECT, 
        RESOURCE
    TO  user_test_03;

  
GRANT DBA TO user_test_04;

REVOKE DBA FROM user_test_04;

GRANT   CONNECT, 
        RESOURCE
    TO  user_test_04;
    
SELECT  *
FROM    emp
;

SELECT  *
FROM    scott.emp
;

CREATE TABLE systemTBL (
                        memo VARCHAR2(50)
                        )
;

INSERT INTO systemTBL
    VALUES  ('동해물과 백두산이')
;

INSERT INTO systemTBL
    VALUES  ('마르고 닳도록 하느님이 보우하사')
;

GRANT
    SELECT, UPDATE, INSERT, DELETE
    ON   systemTBL
    TO   user_test_04
    WITH GRANT OPTION
;

CREATE PUBLIC SYNONYM   pub_system
    FOR                 systemTBL
;

CREATE PUBLIC SYNONYM   pub_system
    FOR                 HELP
;

DROP PUBLIC SYNONYM pub_system;


CREATE TABLE privateTBL (
                        memo VARCHAR2(50)
                        )
;

INSERT INTO privateTBL
    VALUES  ('동해물과 백두산이')
;

INSERT INTO privateTBL
    VALUES  ('마르고 닳도록 하느님이 보우하사')
;

GRANT
    SELECT ON   privateTBL
    TO          user_test_04
;

REVOKE
    SELECT ON   privateTBL
    FROM        user_test_04
;

CREATE PUBLIC SYNONYM   privateTBL
    FOR                 privateTBL
;