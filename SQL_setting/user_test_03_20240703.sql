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