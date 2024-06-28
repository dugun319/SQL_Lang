SELECT  position
FROM    professor
WHERE   name = '전은지'
;

SELECT  name,
        position
FROM    professor
WHERE   position = '전임강사'
;

SELECT  name,
        position
FROM    professor
WHERE   position = (
                    SELECT  position
                    FROM    professor
                    WHERE   name = '전은지'
                    )
;


SELECT  studno,
        name,
        grade
FROM    student
WHERE   grade = (
                 SELECT grade
                 FROM   student
                 WHERE  userid = 'jun123'
                 )
;

SELECT  deptno,
        AVG(weight)
FROM    student
WHERE   deptno = '101'
GROUP BY    deptno
;

SELECT  name,
        grade,
        deptno,
        weight
FROM    student
WHERE   weight < (
                    SELECT  AVG(weight)
                    FROM    student
                    WHERE   deptno = '101'
                  )
ORDER BY deptno DESC
;

SELECT  s.name,
        s.grade,
        s.height,
        d.dname
FROM    student s, department d
WHERE   s.deptno = d.deptno
    AND
        s.grade = (
                    SELECT  grade
                    FROM    student
                    WHERE   studno = '20101'
                )
    AND s.height > (
                    SELECT  height
                    FROM    student
                    WHERE   studno = '20101'
                )
ORDER BY    d.dname DESC
;


SELECT  name,
        grade,
        deptno
FROM    student
WHERE   deptno = (
                    SELECT  deptno
                    FROM    department
                    WHERE   college = '100'
                  )
;


SELECT  name,
        grade,
        deptno
FROM    student
WHERE   deptno IN (
                    SELECT  deptno
                    FROM    department
                    WHERE   college = '100'
                  )
;


SELECT  studno,
        name,
        grade,
        height
FROM    student
WHERE   height > ANY (
                        SELECT  height
                        FROM    student
                        WHERE   grade = '4'
                      )
;

SELECT  studno,
        name,
        grade,
        height
FROM    student
WHERE   height > ALL (
                        SELECT  height
                        FROM    student
                        WHERE   grade = '4'
                      )
;


SELECT      profno,
            name,
            sal,
            comm,
            position
FROM        professor
WHERE EXISTS    (
                    SELECT  position
                    FROM    professor
                    WHERE   comm IS NOT NULL
                )
;

SELECT      profno,
            name,
            sal,
            comm,
            position
FROM        professor
WHERE EXISTS    (
                    SELECT  position
                    FROM    professor
                    WHERE   deptno = '301'
                )
;


SELECT      profno,
            name,
            sal,
            comm,
            NVL2(comm, sal + comm, sal) AS sal_comm
            --sal + NVL(comm, 0) AS sal_comm
FROM        professor
WHERE EXISTS    (
                    SELECT  position
                    FROM    professor
                    WHERE   comm IS NOT NULL
                )
;

SELECT      1 AS userid_exist
FROM        dual
WHERE NOT EXISTS (
                    SELECT  userid
                    FROM    student
                    WHERE   userid = 'greatstudent'
                  )
;



SELECT      name,
            grade,
            weight
FROM        student
WHERE       (grade, weight)
    IN      (
                SELECT  grade,
                        MIN(weight)
                FROM    student
                GROUP BY grade
            )
;


SELECT      name,
            grade,
            weight
FROM        student
WHERE       grade
    IN      (
                SELECT  grade
                FROM    student
                GROUP BY grade
            )
    AND     weight
    IN      (
                SELECT  MIN(weight)
                FROM    student
                GROUP BY grade
            )
;


SELECT      deptno,
            name,
            grade,
            height
FROM        student s1
WHERE       height > (
                        SELECT  AVG(height)
                        FROM    student s2
                        WHERE   s2.deptno = s1.deptno
                     )
ORDER BY deptno
;

SELECT      deptno,
            AVG(height)
FROM        student
GROUP BY deptno
;

SELECT      c.empno,
            c.ename,
            c.job,
            m.ename AS manager
FROM        emp c, emp m
WHERE       c.mgr = m.empno
ORDER BY    c.empno
;

INSERT      INTO dept
VALUES      (73, '인사')
;

INSERT      INTO dept
VALUES      (73, '인사', '이대')
;

INSERT      INTO dept (deptno, dname, loc)
VALUES      (74, '회계', '아현')
;

INSERT      INTO dept (deptno, loc, dname)
VALUES      (75, '충정로', '자재')
;

INSERT      INTO dept (deptno, loc)
VALUES      (76, '당산')
;

INSERT
    INTO    professor (profno, name, position, hiredate, deptno)
    VALUES  ('9910', '백미선', '전임강사', sysdate, '101')
;            

INSERT
    INTO    professor (profno, name, position, hiredate, deptno)
    VALUES  ('9920', '최윤식', '조교수', '06/01/01', '102')
;

CREATE  
    TABLE   job3
        (jobno          NUMBER(2)      PRIMARY KEY,
         jobname       VARCHAR2(20)
         )
;

INSERT        INTO    job3                     VALUES  ('10', '학교');
INSERT        INTO    job3(jobno, jobname)     VALUES  ('11', '공무원');
INSERT        INTO    job3(jobname, jobno)     VALUES  ('공기업', '12');
INSERT        INTO    job3                     VALUES  ('13', '대기업');
INSERT        INTO    job3                     VALUES  ('14', '중소기업');



CREATE
    TABLE Religion   
        (
            religion_no         NUMBER(2)     CONSTRAINT PK_ReligionNo3 PRIMARY KEY,
            religion_name     VARCHAR2(20)
        )
;

INSERT        INTO    religion                              VALUES  ('10', '기독교');
INSERT        INTO    religion(religion_no, religion_name)  VALUES  ('20', '카톨릭');
INSERT        INTO    religion(religion_name, religion_no)  VALUES  ('불교', '30');
INSERT        INTO    religion                              VALUES  ('40', '무교');

commit;


CREATE  TABLE   dept_second
AS
    SELECT  *
    FROM    dept
;


CREATE  TABLE   emp20
AS
    SELECT  empno,
            ename,
            sal*12 AS annual_sal
    FROM    emp
    WHERE   deptno = '20'
;

CREATE  TABLE   dept30
AS
    SELECT  deptno,
            dname
    FROM    dept
    WHERE   1=2 --무조건 거짓, 따라서 values가 없는 틀만 생성
;

ALTER   TABLE   dept30
ADD     (birth date);

INSERT  INTO    dept30
    VALUES  ('10', '중앙학교', sysdate)
;

ALTER   TABLE   dept30
    MODIFY  dname   VARCHAR2(20)
;


ALTER   TABLE   dept30
    DROP COLUMN dname
;

RENAME  dept30  TO  dept35
;


DROP    TABLE   dept35
;


TRUNCATE    TABLE   dept_second
;

CREATE  TABLE   height_info
                (
                    studno  NUMBER(5),
                    name    VARCHAR2(20),
                    height  NUMBER(5, 2)
                )
;

CREATE  TABLE   weight_info
                (
                    studno  NUMBER(5),
                    name    VARCHAR2(20),
                    weight  NUMBER(5, 2)
                )
;

INSERT  ALL
    INTO    height_info
        VALUES  (studno, name, height)
    INTO    weight_info
        VALUES  (studno, name, weight)
    SELECT  studno, name, height, weight
    FROM    student
    WHERE   grade >= '2'
;

TRUNCATE    TABLE   height_info
;

TRUNCATE    TABLE   weight_info
;

INSERT  ALL
    WHEN    height > 170 THEN
        INTO    height_info
            VALUES  (studno, name, height)
    WHEN    weight > 75 THEN
        INTO    weight_info
            VALUES  (studno, name, weight)
    SELECT  studno, name, height, weight
    FROM    student
    WHERE   grade >= '2'
;

DELETE  height_info;
DELETE  weight_info;

UPDATE  professor
    SET     position = '부교수',
            userid = 'doraemong'
    WHERE   profno = '9903'
;

UPDATE  professor
    SET     position = '부교수',
            userid = 'doraemong'
    WHERE   1 = 1
;

ROLLBACK;

UPDATE  student
    SET     (deptno, grade) = (
                                SELECT  deptno,
                                        grade
                                FROM    student
                                WHERE   studno = '10103'
                               )
    WHERE   studno = '10201'
;


DELETE
    FROM    student
    WHERE   studno = '20103'
;

ROLLBACK;

DELETE
    FROM    student
    WHERE   deptno = (
                        SELECT  deptno
                        FROM    department
                        WHERE   dname = '컴퓨터공학과'
                      )
;

CREATE  TABLE   professor_temp
    AS  SELECT  *
        FROM    professor
        WHERE   position = '교수'
;

UPDATE  professor_temp
    SET     position = '명예교수'
    WHERE   position = '교수'
;

INSERT
    INTO    professor_temp
        VALUES  ('9999', '김도경', 'aroma21', '전임강사', '200', sysdate, '10', '101')
;

MERGE
    INTO    professor p
    USING   professor_temp t
    ON      (p.profno = t.profno)
        WHEN MATCHED THEN
            UPDATE  SET     p.position = t.postition
        WHEN NOT MATCHED THEN
            INSERT  VALUES (
                            t.profno,
                            t.name,
                            t.userid,
                            t.position,
                            t.sal,
                            t.hiredate,
                            t.comm,
                            t.deptno
                            )
;
                