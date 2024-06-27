SELECT * FROM tab;

DESC dept;

DESCRIBE dept;

SELECT Deptno, loc FROM dept;

SELECT Deptno FROM dept;

SELECT dname, deptno FROM dept;

-- 중복제거 -> DISTINCT
SELECT DISTINCT deptno FROM student;

SELECT  dname dept_name, deptno AS dn
From    department;

SELECT * FROM department;

SELECT  STUDNO || ' ' || NAME AS stAli 
FROM    student; 

SELECT deptno FROM student;

SELECT  NAME, WEIGHT, WEIGHT * 2.2 AS weight_pound 
FROM    student;

CREATE TABLE ex_type
(c  CHAR(10),
 v  VARCHAR2(10)
 );
 
 INSERT INTO ex_type 
 VALUES('sql', 'sql');
 COMMIT;
 
 SELECT *   
 FROM   ex_type
 WHERE  v = 'sql';
 
 SELECT *   
 FROM   ex_type
 WHERE  v = c;
 
SELECT c, v
 FROM   ex_type
 WHERE  v = c;
 
 SELECT c, v
 FROM   ex_type
 WHERE  v = trim(c);
 
 SELECT c, v   
 FROM   ex_type
 WHERE  v = 'sql';
 
 SELECT STUDNO, NAME, DEPTNO
 FROM   student
 WHERE  grade = 1
 ;
 
SELECT STUDNO, NAME, DEPTNO
 FROM   student
 WHERE  grade = TO_NUMBER(1)
 ;
 
SELECT STUDNO, NAME, DEPTNO
 FROM   student
 WHERE  grade = '1'
 ;
 
 SELECT STUDNO, NAME, GRADE, DEPTNO, WEIGHT
 FROM   student
 WHERE  weight <= 70
 ;
 
 SELECT NAME, GRADE, WEIGHT, DEPTNO
 FROM   student
 WHERE  GRADE = '1'
 AND    weight >= 70
 ;
 
 SELECT NAME, GRADE, WEIGHT, DEPTNO
 FROM   student
 WHERE  GRADE = '1'
 OR    weight >= 70
 ;
 
 SELECT STUDNO, NAME, WEIGHT
 FROM   student
 WHERE  weight BETWEEN 50 AND 70
 ;
 
 SELECT NAME, BIRTHDATE
 FROM   student
 -- WHERE  birthdate BETWEEN '81/01/01' AND '83/12/31'
 -- WHERE  idnum BETWEEN '810101' AND '831231'
 WHERE  birthdate BETWEEN TO_DATE('810101') AND TO_DATE('831231')
 ;
 
 SELECT NAME, GRADE, DEPTNO
 FROM   student
 WHERE  DEPTNO in ('102', '201')
 ;
 
 SELECT NAME, GRADE, DEPTNO
 FROM   student
 WHERE  NAME LIKE('김__영')
 ;
 
 SELECT NAME, GRADE, DEPTNO
 FROM   student
 WHERE  NAME LIKE('%진')
 ;
 
SELECT  EMPNO, SAL, COMM
FROM    EMP
;

SELECT  EMPNO, SAL, COMM, SAL + COMM
FROM    EMP
;

SELECT  EMPNO, SAL, COMM, SAL + NVL(comm, 0)
FROM    EMP
;

SELECT  NAME, POSITION, COMM
FROM    professor
;

SELECT  NAME, POSITION, COMM
FROM    professor
WHERE   COMM IS NULL
;

SELECT  NAME, POSITION, SAL, COMM, SAL + NVL(COMM, 0) AS sal_com
FROM    professor
;

SELECT  NAME, POSITION, SAL, COMM, SAL + NVL(COMM, 0)
FROM    professor
;

SELECT  NAME, GRADE, DEPTNO
FROM    student
WHERE   deptno = '102' 
AND     GRADE IN('1', '4')
;

CREATE TABLE stud_heavy
AS
    SELECT  *
    FROM    student
    WHERE   weight >= 70
    AND     GRADE = '1'
;

CREATE TABLE stud_101
AS
SELECT  *
FROM    student
WHERE   DEPTNO = '101'
AND     GRADE = '1'
;

SELECT  STUDNO, NAME, USERID
FROM    stud_heavy
UNION
SELECT  STUDNO, NAME, USERID
FROM    stud_101
;

SELECT  STUDNO, NAME, USERID
FROM    stud_heavy
UNION ALL
SELECT  STUDNO, NAME, USERID
FROM    stud_101
;

SELECT  STUDNO, NAME, USERID
FROM    stud_heavy
INTERSECT
SELECT  STUDNO, NAME, USERID
FROM    stud_101
;

SELECT  STUDNO, NAME
FROM    stud_heavy
MINUS
SELECT  STUDNO, NAME
FROM    stud_101
;

UPDATE stud_101
    SET     userid = 'SEO'
    WHERE   name = '서재진'
;

SELECT  NAME, GRADE, TEL
FROM    student
-- ORDER BY NAME
-- 기본은 Ascending
-- ORDER BY NAME ASC
ORDER BY NAME DESC
;

SELECT      NAME, GRADE, TEL
FROM        student
ORDER BY    GRADE DESC
;

SELECT      ENAME, SAL, DEPTNO
FROM        emp
ORDER BY    DEPTNO, SAL DESC
;

SELECT      ENAME, JOB, SAL, DEPTNO
FROM        emp
WHERE       DEPTNO IN('10', '30')
ORDER BY    ENAME
;

SELECT      ENAME, HIREDATE
FROM        emp
-- WHERE       hiredate LIKE('82%')
WHERE       TO_CHAR(hiredate, 'yymmdd') LIKE('82%')
;

SELECT      ENAME, SAL, COMM
FROM        emp
WHERE       comm is NOT NULL
    AND     comm != 0
ORDER BY    SAL DESC, COMM DESC
;


SELECT      ENAME, SAL, COMM
FROM        emp
WHERE       COMM >= (SAL * 0.2)
    AND     DEPTNO = '30'
;
