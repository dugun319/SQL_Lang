SELECT * FROM board;


SELECT * 
    FROM board
    ORDER BY REF DESC, re_step
;

SELECT
    *
FROM (
    SELECT ROWNUM as rn, a.*
    FROM (
        SELECT * 
            FROM board
            ORDER BY REF DESC, re_step   
    ) a
)
WHERE rn BETWEEN 1 AND 10
;

SELECT MAX(num)
FROM board
;