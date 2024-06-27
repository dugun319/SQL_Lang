SELECT  name, INITCAP(userid)
FROM    student
WHERE   name = '김영균'
;

SELECT  name, INITCAP('userid')
FROM    student
WHERE   name = '김영균'
;

SELECT  userid, LOWER(userid), UPPER(userid)
FROM    student
WHERE   studno = 20101
;

SELECT  DNAME, LENGTH(DNAME), LENGTHB(DNAME)
FROM    DEPT
;

INSERT  INTO DEPT
VALUES  (59, '경영지원팀', '충정로')
;


SELECT  CONCAT(CONCAT(name, '''s job category is '), position) AS cur_JOB
FROM    professor
;

SELECT  ((name || '''s job category is ') || position) AS cur_JOB
FROM    professor
;

SELECT  name || '''s job category is ' || position AS cur_JOB
FROM    professor
;

SELECT  name, idnum, 
        SUBSTR(idnum, 1, 6) AS birth_date, 
        SUBSTR(idnum, 3, 2) AS birthe_month,
        SUBSTR(idnum, 7, 1) AS gender
FROM    student
WHERE   GRADE = '1'
ORDER BY gender
;

SELECT  DNAME, INSTR(DNAME,'과')
FROM    department
;

SELECT  POSITION,
        LPAD(POSITION, 10, '*') AS lpad_position,
        USERID,
        RPAD(USERID, 12, '+') AS rpad_userid
FROM    professor
;

SELECT  ' abcdefg ',
        LTRIM(' abcdefg ', ' '),
        RTRIM(' abcdefg ', ' '),
        TRIM(' abcd efg ')
FROM    dual
;

SELECT  DNAME, RTRIM(DNAME,'과')
FROM    department
;

SELECT  NAME, 
        SAL, 
        SAL / 22 AS sal_day,
        ROUND( SAL / 22) AS sal_dayR,
        ROUND( SAL / 22, 1) AS sal_dayR1,
        ROUND( SAL / 22, 2) AS sal_dayR2,
        ROUND( SAL / 22, 3) AS sal_dayR3,
        ROUND( SAL / 22, -1) AS sal_dayR4,
        ROUND( SAL / 22, -2) AS sal_dayR5
FROM    professor
WHERE   DEPTNO = '101'
;

SELECT  NAME, 
        SAL, 
        SAL / 22 AS sal_day,
        TRUNC( SAL / 22) AS sal_dayR,
        TRUNC( SAL / 22, 1) AS sal_dayR1,
        TRUNC( SAL / 22, 2) AS sal_dayR2,
        TRUNC( SAL / 22, 3) AS sal_dayR3,
        TRUNC( SAL / 22, -1) AS sal_dayR4,
        TRUNC( SAL / 22, -2) AS sal_dayR5
FROM    professor
WHERE   DEPTNO = '101'
;

SELECT  NAME,
        SAL,
        MOD(SAL, COMM) AS sal_comm
FROM professor
WHERE   DEPTNO = '101'
;

SELECT  SAL/3,
        CEIL(SAL/3)
FROM    professor
;

SELECT  SAL/3,
        FLOOR(SAL/3)
FROM    professor
;

SELECT  CEIL(-12.4),
        CEIL(-12.6),
        FLOOR(-12.4),
        FLOOR(-12.6)
FROM    dual
;

SELECT  NAME,
        HIREDATE,
        HIREDATE + 30 AS h_30,
        HIREDATE + 60 AS h_60
FROM    professor
WHERE   PROFNO = '9908'
;
        
SELECT  SYSDATE
FROM    dual
;

SELECT  NAME,
        HIREDATE,
        SYSDATE - HIREDATE AS work_dat,
        ROUND((SYSDATE - HIREDATE) /365, 1) AS work_year
FROM    professor
WHERE   PROFNO = '9908'
;


SELECT  PROFNO,
        HIREDATE,
        MONTHS_BETWEEN(HIREDATE, SYSDATE) AS be_month,
        ADD_MONTHS(HIREDATE, 6) AS six_month
FROM    professor
WHERE   MONTHS_BETWEEN(SYSDATE, HIREDATE) < 360
;

SELECT  TO_CHAR(SYSDATE)
FROM    dual
;

SELECT  studno, 
        name,
        TO_CHAR(birthdate, 'yy-mm') AS birth_date1,
        TO_CHAR(birthdate, 'yymm') AS birth_date2,
        TO_CHAR(birthdate, 'yy/mm') AS birth_date3,
        TO_CHAR(birthdate, 'yyyy-mm-dd, MON') AS birth_date4
FROM    student
WHERE   name = '전인하'
;


SELECT  SYSDATE,
        LAST_DAY(SYSDATE),
        NEXT_DAY(SYSDATE, '월')
FROM    dual
;


SELECT  TO_CHAR(SYSDATE, 'YY/MM/DD HH24:MI:SS') AS NORMAL,
        TO_CHAR(SYSDATE, 'YY/MM/DD HH24:MI:SS') AS TRUNC,
        TO_CHAR(SYSDATE, 'YY/MM/DD HH24:MI:SS') AS ROUND
FROM    dual
;

SELECT  NAME,
        TO_CHAR(HIREDATE, 'YY/MM/DD HH24:MI:SS') AS H_date,
        TO_CHAR(ROUND(HIREDATE, 'DD'), 'YY/MM/DD HH24:MI:SS') AS HR_DD,
        TO_CHAR(ROUND(HIREDATE, 'MM'), 'YY/MM/DD HH24:MI:SS') AS HR_MM,
        TO_CHAR(ROUND(HIREDATE, 'YY'), 'YY/MM/DD HH24:MI:SS') AS HR_YY
FROM    professor
;

SELECT  TO_CHAR(SYSDATE, 'YY/MM/DD HH24:MI:SS') AS H_date,
        TO_CHAR(ROUND(SYSDATE, 'DD'), 'YY/MM/DD HH24:MI:SS') AS HR_DD,
        TO_CHAR(ROUND(SYSDATE, 'MM'), 'YY/MM/DD HH24:MI:SS') AS HR_MM,
        TO_CHAR(ROUND(SYSDATE, 'YY'), 'YY/MM/DD HH24:MI:SS') AS HR_YY
FROM    dual
;


SELECT  NAME,
        STUDNO,
        BIRTHDATE,
        TO_CHAR(BIRTHDATE, 'MM') AS birth_mon,
        TO_CHAR(BIRTHDATE, 'MONTH') AS birth_month,
        TO_CHAR(BIRTHDATE, 'YY//MM') AS birth_year,
        TO_CHAR(BIRTHDATE, 'YYYY') AS birth_year
FROM    student
WHERE   NAME = '전인하'        
;

SELECT  NAME,
        SAL,
        COMM,
        TO_CHAR((SAL + COMM) * 12, '999,999') AS anual_sal
FROM    professor
WHERE   COMM IS NOT NULL
    AND COMM != 0
;

SELECT  TO_CHAR(0.1230) AS NUM1,
        TO_CHAR(0.1230, 'FM999.9999') AS NUM2,
        TO_CHAR(0.1230, 'FM999.0000') AS NUM3,
        TO_CHAR(0.1230, 'FM000.000') AS NUM4,
        TO_CHAR(0.1230, 'FM000.0000') AS NUM5
FROM DUAL
;

SELECT  to_number('1234')
FROM    dual;

SELECT  NAME,
        IDNUM,
        BIRTHDATE,
        TO_CHAR(TO_DATE(SUBSTR(IDNUM, 1,6), 'YYMMDD'), 'YY/MM/DD') AS birthDate
FROM    student
;

SELECT  NAME,
        POSITION,
        SAL,
        COMM,
        DEPTNO,
        SAL + NVL(COMM, 0) AS sum_salComm,
        NVL(SAL + COMM, SAL) AS sum2
FROM    professor
WHERE   DEPTNO IN('101', '102')
;

SELECT  TO_DATE('800319', 'YY/MM/DD')
--      TO_CHAR('800319', 'YY/MM/DD') -> ERROR
FROM    DUAL
;

SELECT  *
FROM    SALGRADE
;

SELECT  *
FROM    user_tables
;

SELECT  *
FROM    tab
;

SELECT  EMPNO,
        ENAME,
        SAL,
        JOB,
        HIREDATE
FROM    EMP
;

SELECT  EMPNO,
        ENAME,
        SAL,
        JOB,
        HIREDATE
FROM    EMP
WHERE   SAL < 2000
;

SELECT  EMPNO,
        ENAME,
        SAL,
        JOB,
        HIREDATE
FROM    EMP
WHERE   HIREDATE > '80/02/01'
;


SELECT  EMPNO,
        ENAME,
        SAL,
        JOB
FROM    EMP
WHERE   SAL BETWEEN 1500 AND 3000
--WHERE   SAL >= 1500
--    AND SAL <= 3000
; 

SELECT  EMPNO,
        ENAME,
        SAL,
        JOB
FROM    EMP
WHERE   SAL >= 2500
    AND JOB = 'MANAGER'
;

SELECT  EMPNO,
        ENAME,
        SAL,
        JOB,
        (SAL + NVL(COMM, 0)) * 12 AS "연 봉" --anual_sal
FROM    EMP
;

SELECT  EMPNO,
        ENAME,
        HIREDATE,
        --CONCAT(CONCAT(CONCAT('입사자들 중 ', ENAME), ' 는 입사일이 '), HIREDATE)
        '입사자들 중 ' || ENAME || ' 는 입사일이 ' || HIREDATE AS emp_date
FROM    EMP
WHERE   HIREDATE > '81/02/01'
;

SELECT  EMPNO,
        ENAME,
        HIREDATE
FROM    EMP
WHERE   ENAME LIKE('%T%')
;

SELECT  NAME,
        POSITION,
        SAL,
        COMM,
        NVL2(COMM, COMM + SAL, SAL) AS total_sal
FROM    professor
WHERE   DEPTNO = '102'
;

SELECT  NAME,
        POSITION,
        USERID,
        LENGTHB(NAME),
        LENGTHB(USERID),
        NULLIF(LENGTHB(NAME), LENGTHB(USERID)) AS res_nullif
FROM    professor
;

SELECT  NAME,
        POSITION,
        DEPTNO,
        DECODE(DEPTNO, '101', 'Computer',
                       '102', 'Multi-Media',
                       '201', 'Electronics',
                       '202', 'Mechanics') AS dept_name
                       -- 'Mechanics')
FROM    professor
;

SELECT  NAME,
        POSITION,
        DEPTNO,
        CASE WHEN DEPTNO = '101' THEN 'Computer'
             WHEN DEPTNO = '102' THEN 'Multi-Media'
             WHEN DEPTNO = '201' THEN 'Electronics'
             ELSE                     'Mechanics'
        END dept_name
FROM    professor
;

SELECT  NAME,
        POSITION,
        SAL,
        DEPTNO,
        DECODE(DEPTNO, '101', SAL * 0.1,
                       '102', SAL * 0.2,
                       '201', SAL * 0.3,
                              SAL * 0) AS bonus
FROM    professor
;

SELECT  NAME,
        POSITION,
        SAL,
        DEPTNO,
        CASE WHEN DEPTNO = '101' THEN SAL * 0.1
             WHEN DEPTNO = '102' THEN SAL * 0.2
             WHEN DEPTNO = '201' THEN SAL * 0.3
             ELSE                     SAL * 0
        END  bonus
FROM    professor
;

SELECT  ENAME,
        LOWER(ENAME),
        UPPER(ENAME),
        INITCAP(ENAME)
FROM    EMP
;

SELECT  ENAME,
        JOB,
        SUBSTR(JOB, 2, 4)
FROM    EMP
;

SELECT  ENAME,
        LPAD(ENAME, 10, '#')
FROM    EMP
;

SELECT  ENAME,
        JOB,
        CASE WHEN JOB = 'MANAGER'   THEN '관리자'
        END  Position
        --DECODE(job, 'MANAGER', '관리자') AS 'Position'
FROM    EMP
;

SELECT  ENAME,
        SAL,
        ROUND(SAL / 7) AS r_sal,
        ROUND(SAL / 7, 1) AS r_sal1,
        ROUND(SAL / 7, 2) AS r_sal2,
        ROUND(SAL / 7, 3) AS r_sal3,
        ROUND(SAL / 7, -1) AS r_sal4,
        ROUND(SAL / 7, -2) AS r_sal5
FROM    EMP
;

SELECT  ENAME,
        SAL,
        TRUNC(SAL / 7) AS t_sal,
        TRUNC(SAL / 7, 1) AS t_sal1,
        TRUNC(SAL / 7, 2) AS t_sal2,
        TRUNC(SAL / 7, 3) AS t_sal3,
        TRUNC(SAL / 7, -1) AS t_sal4,
        TRUNC(SAL / 7, -2) AS t_sal5
FROM    EMP
;

SELECT  ENAME,
        SAL,
        ROUND(SAL / 7) AS r_sal,
        TRUNC(SAL / 7) AS t_sal,
        CEIL (SAL / 7) AS c_sal,
        FLOOR(SAL / 7) AS f_sal
FROM    EMP
;

SELECT  ename,
        sal,
        MOD(sal, 7) AS mod_sal
FROM    emp
;

SELECT  ename,
        sal,
        hiredate,
        ROUND(SYSDATE - hiredate) AS h_days,
        ROUND(MONTHS_BETWEEN(SYSDATE, hiredate)) AS h_months,
        ROUND(MONTHS_BETWEEN(SYSDATE, hiredate) / 12) AS h_years
FROM    emp
;

SELECT  empno,
        ename,
        job,
        sal,
        CASE 
             WHEN job = 'CLERK'     THEN (sal * 1.1)
             WHEN job = 'ANALYSIS'  THEN (sal * 1.2)
             WHEN job = 'MANAGER'   THEN (sal * 1.3)
             WHEN job = 'PRESIDENT' THEN (sal * 1.4)
             WHEN job = 'SALESMAN'  THEN (sal * 1.5)
             ELSE                        (sal * 1.6)
        END  new_sal
FROM    emp
;      

SELECT  empno,
        ename,
        job,
        sal,
        CASE job
             WHEN 'CLERK'     THEN (sal * 1.1)
             WHEN 'ANALYSIS'  THEN (sal * 1.2)
             WHEN 'MANAGER'   THEN (sal * 1.3)
             WHEN 'PRESIDENT' THEN (sal * 1.4)
             WHEN 'SALESMAN'  THEN (sal * 1.5)
             ELSE                  (sal * 1.6)
        END  new_sal
FROM    emp
; 

SELECT  empno,
        ename,
        job,
        sal,
        DECODE(job, 'CLERK',    (sal * 1.1),
                    'ANALYSIS', (sal * 1.2),
                    'MANAGER',  (sal * 1.3),
                    'PRESIDENT',(sal * 1.4),
                    'SALESMAN', (sal * 1.5),
                                (sal * 1.6)) AS new_sal
FROM    emp
;         