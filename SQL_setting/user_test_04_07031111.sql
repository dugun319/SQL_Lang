CREATE TABLE sampleTBL (
                        memo VARCHAR2(50)
                        )
;

INSERT INTO sampleTBL
    VALUES  ('���ع��� ��λ���')
;

INSERT INTO sampleTBL
    VALUES  ('������ �⵵�� �ϴ����� �����ϻ�')
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
