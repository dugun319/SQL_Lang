INSERT INTO emp 
VALUES(EMP_ROW_SEQ.nextval, 
      'GRAY', 
      'CLERK', 
      '7566', 
       sysdate, 
      '3600', 
      '300', 
      '10')
;


DELETE FROM board WHERE ref = 17;

DELETE FROM board WHERE ref = '16';

ROLLBACK;

DELETE FROM board WHERE ref=15;

