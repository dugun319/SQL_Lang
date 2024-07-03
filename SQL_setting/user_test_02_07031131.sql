--GRANT   CREATE SESSION, 
--        CREATE TABLE,
--        CREATE VIEW
--    TO  user_test_02;

SELECT  *
FROM    scott.emp
;


-- scott���� ���� ������ Ÿ�ο��� �ο�
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