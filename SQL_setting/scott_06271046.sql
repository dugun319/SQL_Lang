SELECT  COUNT(*),
        COUNT(comm)
FROM    professor
WHERE   deptno = '102'
;

SELECT  AVG(weight),
        SUM(weight)
FROM    student
;

SELECT  MAX(weight),
        MIN(weight)
FROM    student
;

SELECT  ROUND(STDDEV(sal), 3),
        ROUND(VARIANCE(sal), 3)
FROM    professor
;

SELECT      deptno,
            COUNT(*),
            AVG(weight),
            SUM(weight)
FROM        student
GROUP BY    deptno
;

SELECT      deptno,
            COUNT(*),
            COUNT(comm)
FROM        professor
-- WHERE       comm is NOT NULL
GROUP BY    deptno
;

SELECT      deptno,
            COUNT(*),
            COUNT(comm)
FROM        professor
-- WHERE       COUNT(*) > 1
GROUP BY    deptno
HAVING      COUNT(*) > 1
;

SELECT      grade,
            COUNT(*),
            ROUND(AVG(height), 1) AS avg_height,
            ROUND(AVG(weight), 1) AS avg_weight
FROM        student
GROUP BY    grade
HAVING      ROUND(AVG(height), 1) >= 168
    AND     COUNT(*) >= 4
ORDER BY    avg_height DESC, avg_weight DESC
;            


SELECT      deptno,
            MAX(hiredate) AS newbie,
            MIN(hiredate) AS goinmul
FROM        emp
GROUP BY    deptno
;

SELECT      deptno,
            job,
            count(*),
            SUM(sal)
FROM        emp
GROUP BY    deptno, job
ORDER BY    deptno, job
;

SELECT      deptno,
            MAX(sal),
            SUM(sal)
FROM        emp
GROUP BY    deptno
HAVING      SUM(sal) >= 3000
ORDER BY    deptno
;


SELECT      deptno,
            grade,
            count(*),
            ROUND(AVG(weight)) AS avg_weight,
            ROUND(AVG(height)) AS avg_height
FROM        student
GROUP BY    deptno, grade
ORDER BY    deptno, grade
;

SELECT      deptno,
            SUM(sal)
FROM        professor
GROUP BY    ROLLUP(deptno)
;

SELECT      deptno,
            position,
            COUNT(*)
FROM        professor
GROUP BY    ROLLUP(deptno, position)
;

SELECT      deptno,
            position,
            COUNT(*)
FROM        professor
GROUP BY    CUBE(deptno, position)
;


UPDATE  emp
SET     sal = sal * 1.1
WHERE   empno = 7369
;

UPDATE  emp
SET     sal = sal * 1.1
WHERE   empno = 7839
;

UPDATE  emp
SET     comm = 500
WHERE   empno = 7839
;

UPDATE  emp
SET     comm = 300
WHERE   empno = 7369
;

INSERT  INTO dept
        VALUES(72, 'kk', 'kk');
COMMIT;

SELECT      studno, 
            name,
            deptno
FROM        student
WHERE       studno = '10101'
;

SELECT      dname
FROM        department
WHERE       deptno = '101'
;

SELECT      studno,
            name,
            student.deptno,
            department.dname
FROM        student, department
WHERE       student.deptno = department.deptno
;

SELECT      s.studno,
            s.name,
            s.deptno,
            d.dname
FROM        student s, department d
WHERE       s.deptno = d.deptno
;

SELECT      s.studno,
            s.name,
            s.weight,
            d.dname,
            d.loc
FROM        student s, department d
WHERE       s.deptno = d.deptno
    AND     s.name = 'ÀüÀÎÇÏ'
;

SELECT      s.studno,
            s.name,
            s.weight,
            d.dname,
            d.loc
FROM        student s, department d
WHERE       s.deptno = d.deptno
    AND     s.weight >= 80
;

SELECT      s.studno,
            s.name,
            s.weight,
            d.dname,
            d.loc,
            d.deptno
FROM        student s, department d
;

SELECT      s.studno,
            s.name,
            s.weight,
            d.dname,
            d.loc,
            d.deptno
FROM        student s
CROSS JOIN  department d
;

SELECT          s.studno,
                s.name,
                s.weight,
                d.dname,
                d.loc,
                d.deptno
FROM            student s
NATURAL JOIN    department d
;

SELECT          s.studno,
                s.name,
                s.weight,
                d.dname,
                d.loc,
                deptno
FROM            student s
NATURAL JOIN    department d
;

SELECT          p.profno,
                p.name,
                d.dname,
                deptno
FROM            professor p
NATURAL JOIN    department d
;

SELECT          s.studno,
                s.name,
                s.weight,
                s.grade,
                d.dname,
                d.loc,
                deptno
FROM            student s
NATURAL JOIN    department d
WHERE           s.grade = '4'
;