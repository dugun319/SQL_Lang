--1. �̸�, �����ڸ�(emp TBL)

SELECT      c.empno,
            m.ename AS manager
FROM        emp c, emp m
WHERE       c.mgr = m.empno(+)
;

--2. �̸�, �޿�, �μ��ڵ�, �μ���, �ٹ���,  ������ ��, ��ü����(emp ,dept TBL)

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

--3. �̸�,�޿�,���,�μ���,�����ڸ�, �޿��� 2000�̻��� ��� (emp, dept,salgrade TBL)
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



--4. ���ʽ��� �޴� ����� ���Ͽ� �̸�,�μ���,��ġ�� ����ϴ� SELECT ������ �ۼ�emp ,dept TBL)

SELECT  e.ename,
        d.dname,
        d.loc
FROM    emp e, dept d
WHERE   e.deptno = d.deptno
    AND e.comm IS NOT NULL
;

--5. ���, �����, �μ��ڵ�, �μ����� �˻��϶�. ������������ ������������(emp ,dept TBL)
SELECT  e.empno,
        e.ename,
        d.deptno,
        d.dname
FROM    emp e, dept d
WHERE   e.deptno = d.deptno
ORDER BY e.ename
;

--6. Blake�� ���� �μ��� �ִ� ��� ����� ���ؼ� ��� �̸��� �Ի����� ���÷����϶�
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

--7. ��� �޿� �̻��� �޴� ��� ����� ���ؼ� ��� ��ȣ�� �̸��� ���÷����ϴ� ���ǹ��� ����. -- ? ?�� ����� �޿� �������� �����϶�

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

--8. ���ʽ��� �޴� � ����� �μ� ��ȣ�� �޿��� ��ġ�ϴ� ����� �̸�, �μ� ��ȣ �׸��� �޿��� ���÷����϶�.
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

--9. ���������� �̿��Ͽ� �й��� 10201�� �л��� �г�� �а� ��ȣ�� 10103 �й� �л��� �г�� �а� ��ȣ�� �����ϰ� �����Ͽ���

UPDATE  student
    SET     (deptno, grade) = (
                                SELECT  deptno,
                                        grade
                                FROM    student
                                WHERE   studno = '10103'
                               )
    WHERE   studno = '10201'
;

--10. �л� ���̺��� ��ǻ�Ͱ��а��� �Ҽӵ� �л��� ��� �����Ͽ���. 

DELETE
    FROM    student
    WHERE   deptno = (
                        SELECT  deptno
                        FROM    department
                        WHERE   dname = '��ǻ�Ͱ��а�'
                      )
;