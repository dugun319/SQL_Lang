CREATE TABLE sampleTBL (
                        memo VARCHAR2(50)
                        )
;

INSERT INTO sampleTBL
    VALUES  ('동해물과 백두산이')
;

INSERT INTO sampleTBL
    VALUES  ('마르고 닳도록 하느님이 보우하사')
;

COMMIT;

SELECT  memo
FROM    sampleTBL
;

SELECT  *
FROM    scott.student
;

UPDATE  SCOTT.student
SET     userid = 'Hwarang'
WHERE   studno = '30103'
;

SELECT  *
FROM    scott.emp
;

GRANT SELECT ON scott.emp
    TO          user_test_03
;

REVOKE SELECT ON scott.emp
    FROM         user_test_03
;

SELECT  *
FROM    scott.job3
;

GRANT SELECT ON scott.job3
    TO          user_test_03
;
