--1. 이름, 관리자명(emp TBL)

SELECT      c.empno,
            m.ename AS manager
FROM        emp c, emp m
WHERE       c.mgr = m.empno(+)
;

--2. 이름, 급여, 부서코드, 부서명, 근무지,  관리자 명, 전체직원(emp ,dept TBL)

SELECT      c1.ename,
            c1.job,
            c1.sal,
            c1.deptno,
            d.dname,
            d.loc,
            c2.ename AS manger_name
FROM        emp c1, emp c2, dept d
WHERE       c1.deptno = d.deptno
    AND     c1.mgr = c2.empno(+)
;

--3. 이름,급여,등급,부서명,관리자명, 급여가 2000이상인 사람 (emp, dept,salgrade TBL)
SELECT      c1.ename,
            c1.job,
            c1.sal,
            c1.deptno,
            d.dname,
            d.loc,
            c2.ename AS manger_name
FROM        emp c1, 
            emp c2, 
            dept d
WHERE       c1.deptno = d.deptno
    AND     c1.mgr = c2.empno
    AND     c1.sal > (
                    SELECT losal
                    FROM   salgrade
                    WHERE  grade = '2'
                   )
;

SELECT      w.ename,
            w.job,
            w.sal,
            d.dname,
            s.grade,
            m.ename
FROM        (
                SELECT  *
                FROM    emp
                WHERE   sal >= 2000
             ) w,
             emp m,
             dept d,
             salgrade s
WHERE   w.mgr = m.empno
    AND w.deptno = d.deptno
    AND w.sal BETWEEN s.losal AND s.hisal
;



--4. 보너스를 받는 사원에 대하여 이름,부서명,위치를 출력하는 SELECT 문장을 작성emp ,dept TBL)

SELECT  e.ename,
        d.dname,
        d.loc
FROM    emp e, dept d
WHERE   e.deptno = d.deptno
    AND e.comm IS NOT NULL
;

--5. 사번, 사원명, 부서코드, 부서명을 검색하라. 사원명기준으로 오름차순정열(emp ,dept TBL)
SELECT  e.empno,
        e.ename,
        d.deptno,
        d.dname
FROM    emp e, dept d
WHERE   e.deptno = d.deptno
ORDER BY e.ename
;

--6. Blake와 같은 부서에 있는 모든 사원에 대해서 사원 이름과 입사일을 디스플레이하라
SELECT  ename,
        hiredate,
        deptno
FROM    emp
WHERE   deptno = (
                    SELECT  deptno
                    FROM    emp
                    WHERE   ename = 'BLAKE'
                  )
;

--7. 평균 급여 이상을 받는 모든 사원에 대해서 사원 번호와 이름을 디스플레이하는 질의문을 생성. -- ? ?단 출력은 급여 내림차순 정렬하라

SELECT  empno,
        ename,
        sal
FROM    emp
WHERE   sal > (
               SELECT  AVG(sal)
               FROM    emp
               )
ORDER BY sal DESC
;

SELECT  empno,
        ename,
        sal
FROM    emp
WHERE   sal < (
               SELECT  SUM(sal)
               FROM    emp
               )
ORDER BY sal DESC
;

SELECT  empno,
        ename,
        sal
FROM    emp
WHERE   sal < (
               SELECT  MAX(sal)
               FROM    emp
               )
ORDER BY sal DESC
;

--8. 보너스를 받는 어떤 사원의 부서 번호와 급여에 일치하는 사원의 이름, 부서 번호 그리고 급여를 디스플레이하라.
SELECT  ename,
        deptno,
        sal
FROM    emp
WHERE   (deptno, sal) 
    IN  (
            SELECT  deptno,
                    sal
            FROM    emp
            WHERE   comm IS NOT NULL
         )
;

--9. 서브쿼리를 이용하여 학번이 10201인 학생의 학년과 학과 번호를 10103 학번 학생의 학년과 학과 번호와 동일하게 수정하여라

UPDATE  student
    SET     (deptno, grade) = (
                                SELECT  deptno,
                                        grade
                                FROM    student
                                WHERE   studno = '10103'
                               )
    WHERE   studno = '10201'
;

--10. 학생 테이블에서 컴퓨터공학과에 소속된 학생을 모두 삭제하여라. 

DELETE
    FROM    student
    WHERE   deptno = (
                        SELECT  deptno
                        FROM    department
                        WHERE   dname = '컹퓨터공학과'
                      )
;