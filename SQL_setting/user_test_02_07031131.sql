--GRANT   CREATE SESSION, 
--        CREATE TABLE,
--        CREATE VIEW
--    TO  user_test_02;

SELECT  *
FROM    scott.emp
;


-- scott에게 받은 권한을 타인에게 부여
GRANT SELECT ON scott.emp
    TO          user_test_04
    WITH GRANT OPTION
;

SELECT  *
FROM    scott.job3
;

GRANT SELECT ON scott.job3
    TO          user_test_04
    WITH GRANT OPTION
;