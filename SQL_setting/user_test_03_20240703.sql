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