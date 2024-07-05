CREATE OR REPLACE PROCEDURE deleteEMP (p_empno IN emp.empno%TYPE)
-- HW_01
-- PROCEDURE Delete_emp
-- SQL> EXECUTE Delete_emp(5555);
-- �����ȣ : 5555
-- ����̸� : 55
-- �� �� �� : 81/12/03
-- ������ ���� ����
--  1. Parameter : ��� �Է�
--  2. ��� �̿��� �����ȣ ,����̸� , �� �� �� ���
--  3. ��� �ش��ϴ� ������ ���� 
    IS
        v_empno     emp.empno%TYPE;
        v_ename     emp.ename%TYPE;
        v_hiredate  emp.hiredate%TYPE;
    BEGIN
        SELECT  empno,
                ename,
                hiredate
        INTO    v_empno,
                v_ename,
                v_hiredate
        FROM    emp
        WHERE   empno = p_empno
        ;
        DBMS_OUTPUT.PUT_LINE('DEL. EMPNO : ' || v_empno);
        DBMS_OUTPUT.PUT_LINE('DEL. NAME  : ' || v_ename);
        DBMS_OUTPUT.PUT_LINE('DEL. DATE  : ' || v_hiredate);
        DELETE FROM emp
        WHERE empno = p_empno
        ;
    END deleteEMP;
/

EXEC deleteEMP(2002);




CREATE OR REPLACE FUNCTION emp_Tax3 (p_empno IN emp.empno%TYPE)
-- EMP ���̺��� ����� �Է¹޾� �ش� ����� �޿��� ���� ������ ����.
-- 1. �޿��� 2000 �̸��̸� �޿��� 6%, 
-- 2. �޿��� 3000 �̸��̸� 8%, 
-- 3. 5000 �̸��̸� 10%, 
-- 4. �� �̻��� 15%�� ����
---FUNCTION  emp_tax3
-- 1) ���: p_empno
--    ����: v_sal(�޿�)
--          v_pct(����)
--          TAX(å������)        
-- 2)����� ������ �޿��� ����
-- 3)�޿��� ������ ������ å�� 
-- 4)å�� �� ������ Return
RETURN NUMBER
    IS  v_pct   NUMBER(5, 2);
        v_sal   emp.sal%TYPE;
        TAX     NUMBER(5, 2);
    BEGIN
        SELECT      sal
        INTO        v_sal
        FROM        emp
        WHERE       empno = p_empno;
        IF          v_sal < 2000
            THEN    v_pct := 0.06;
                    TAX := v_sal * v_pct; 
        ELSIF       v_sal BETWEEN 2000 AND 3000
                    -- v_sal < 3000
            THEN    v_pct := 0.08;
                    TAX := v_sal * v_pct; 
        ELSIF       v_sal BETWEEN 3000 AND 5000
                    -- v_sal < 5000
            THEN    v_pct := 0.1;
                    TAX := v_sal * v_pct; 
        ELSE        v_pct := 0.15;
                    TAX := v_sal * v_pct;
        END IF;
    RETURN TAX;
    END emp_Tax3;
/

SELECT  emp_Tax3(7369), 
        emp_Tax3(7782),
        emp_Tax3(3001),
        emp_Tax3(7839)
FROM    dual
;

SELECT  ename,
        sal,
        emp_Tax3(empno) AS TAX
FROM    emp
;



CREATE OR REPLACE PROCEDURE salUp_emp (p_empno IN emp.empno%TYPE)
-- Procedure salUp_emp ���� ���
-- Parameter : p_empno 
-- ���� :     v_job(����)
--           v_up(�λ���)
-- ���� 1) job = SALE����    v_up : 10
--     2)            MAN   v_up : 7  
--     3)                  v_up : 5
--   job�� ���� �޿� �λ��� ����  sal = sal+sal*v_up/100
-- Ȯ�� : DB -> TBL
    IS
        v_job   emp.job%TYPE;
        v_up    NUMBER(5, 2);
    BEGIN
        SELECT      job
        INTO        v_job
        FROM        emp
        WHERE       empno = p_empno;
        IF          UPPER(v_job)LIKE('SALE%')
            THEN    v_up := 10;
        ELSIF       UPPER(v_job)LIKE('MAN%')
            THEN    v_up := 7;
        ELSE        v_up := 5;
        END IF;
        UPDATE      emp
        SET         sal = sal + (sal * v_up / 100)
        WHERE       empno = p_empno
        ;
    COMMIT;
    END salUp_emp;
/

EXEC salUp_emp(7844);

SELECT  ename,
        sal
FROM    emp
WHERE   empno = '7844'
;

CREATE OR REPLACE PROCEDURE deptEmpSearch_01 (p_deptno IN emp.deptno%TYPE)
-- �ൿ���� : �μ���ȣ �Է� �ش� emp ����  PROCEDURE 
-- SQL> EXECUTE DeptEmpSearch(40);
--  ��ȸȭ�� :    ���    : 5555
--              �̸�    : ȫ�浿
    IS  v_empno emp.empno%TYPE;
        v_ename emp.ename%TYPE;
    BEGIN
        dbms_output.enable;
        SELECT  empno,
                ename
        INTO    v_empno,
                v_ename
        FROM    emp
        WHERE   deptno = p_deptno
        ;
        DBMS_OUTPUT.PUT_LINE('EMP. EMPNO : ' || v_empno);
        DBMS_OUTPUT.PUT_LINE('EMP. NAME  : ' || v_ename);
    END deptEmpSearch_01;
/

EXEC infoEmp(51);

INSERT INTO emp
    VALUES      (
                    '3002',
                    '������',
                    'SALESMAN',
                    '7521',
                    SYSDATE,
                    '3600',
                    '500',
                    '50'
                )
;
                    
CREATE OR REPLACE PROCEDURE deptEmpSearch_02 (p_deptno IN emp.deptno%TYPE)
-- %ROWTYPE �� �̿��Ͽ� �� ��ü�� ����
-- �ൿ���� : �μ���ȣ �Է� �ش� emp ����  PROCEDURE 
-- SQL> EXECUTE DeptEmpSearch(40);
--  ��ȸȭ�� :    ���    : 5555
--              �̸�    : ȫ�浿
    IS  --v_empno emp.empno%TYPE;
        --v_ename emp.ename%TYPE;
        v_emp     emp%ROWTYPE;  
    BEGIN
        dbms_output.enable;
        SELECT  *
        INTO    v_emp
        FROM    emp
        WHERE   deptno = p_deptno
        ;
        DBMS_OUTPUT.PUT_LINE('EMP. EMPNO : ' || v_emp.empno);
        DBMS_OUTPUT.PUT_LINE('EMP. NAME  : ' || v_emp.ename);
    END deptEmpSearch_02;
/

EXEC deptEmpSearch_02(51);

CREATE OR REPLACE PROCEDURE deptEmpSearch_03 (p_deptno IN emp.deptno%TYPE)
-- %ROWTYPE �� �̿��Ͽ� �� ��ü�� ����
-- �ټ��� ���� �޾ƾ� �ϴ� ��� EXCEPTION�� �̿��Ͽ� ������ ó��
-- �ൿ���� : �μ���ȣ �Է� �ش� emp ����  PROCEDURE 
-- SQL> EXECUTE DeptEmpSearch(40);
--  ��ȸȭ�� :    ���    : 5555
--              �̸�    : ȫ�浿
    IS  --v_empno emp.empno%TYPE;
        --v_ename emp.ename%TYPE;
        --CURSOR 
        v_emp     emp%ROWTYPE;  
        
    BEGIN
        dbms_output.enable;
        SELECT  *
        INTO    v_emp
        FROM    emp
        WHERE   deptno = p_deptno
        ;
        DBMS_OUTPUT.PUT_LINE('EMP. EMPNO : ' || v_emp.empno);
        DBMS_OUTPUT.PUT_LINE('EMP. NAME  : ' || v_emp.ename);
        
    EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('ERROR CODE 01 : ' || TO_CHAR(SQLCODE));
            DBMS_OUTPUT.PUT_LINE('ERROR CODE 02 : ' || SQLCODE);
            DBMS_OUTPUT.PUT_LINE('ERROR MESSAGE : ' || SQLERRM);
            
    END deptEmpSearch_03;
/

EXEC deptEmpSearch_03(10);

CREATE OR REPLACE PROCEDURE deptEmpSearch_04 (p_deptno IN emp.deptno%TYPE)
-- %ROWTYPE �� �̿��Ͽ� �� ��ü�� ����
-- �ټ��� ���� �޾ƾ� �ϴ� ��� EXCEPTION�� �̿��Ͽ� ������ ó��
-- �ൿ���� : �μ���ȣ �Է� �ش� emp ����  PROCEDURE 
-- SQL> EXECUTE DeptEmpSearch(40);
--  ��ȸȭ�� :    ���    : 5555
--              �̸�    : ȫ�浿
    IS  
        CURSOR  empCur
            IS  SELECT  *
                FROM    emp
                WHERE   deptno = p_deptno
                ;
                v_emp     emp%ROWTYPE;  
        
    BEGIN
        dbms_output.enable;
        OPEN    empCur;
        LOOP
            FETCH   empCur  INTO    v_emp;
            EXIT WHEN empCur%NOTFOUND;
            DBMS_OUTPUT.PUT_LINE('EMP. EMPNO : ' || v_emp.empno
                              || '   EMP. NAME  : ' || v_emp.ename
                              || '   EMP. JOB   : ' || v_emp.job
                              || '   EMP. SAL  : ' || v_emp.sal);
        END LOOP;
        CLOSE empCur;
    EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('ERROR CODE 01 : ' || TO_CHAR(SQLCODE));
            DBMS_OUTPUT.PUT_LINE('ERROR CODE 02 : ' || SQLCODE);
            DBMS_OUTPUT.PUT_LINE('ERROR MESSAGE : ' || SQLERRM);
            
    END deptEmpSearch_04;
/

EXEC deptEmpSearch_04(10);


CREATE  OR REPLACE PROCEDURE    deptSalSum (p_deptno IN emp.deptno%TYPE)
    IS
        CURSOR  deptSum
            IS  SELECT   dname,
                         COUNT(*) AS cnt,
                         SUM(e.sal) AS sumSal,
                         AVG(e.sal) AS avgSal
                FROM     emp e,
                         dept d
                WHERE    e.deptno = d.deptno
                    AND  e.deptno LIKE (p_deptno||'%')
                GROUP BY dname                
                ;
                v_dname     dept.dname%TYPE;
                v_cnt       NUMBER;
                v_sumSal    NUMBER;
                v_avgSal    NUMBER;
    BEGIN
        dbms_output.enable;
        OPEN    deptSum;
            LOOP
                FETCH deptSum INTO v_dname, v_cnt, v_sumSal, v_avgSal;
                EXIT WHEN deptSum%NOTFOUND; 
                DBMS_OUTPUT.PUT_LINE('DNAME : ' || v_dname);
                DBMS_OUTPUT.PUT_LINE('COUNT : ' || v_cnt);
                DBMS_OUTPUT.PUT_LINE('SUM   : ' || v_sumSal);
                DBMS_OUTPUT.PUT_LINE('AVG   : ' || v_avgSal);
            END LOOP;
        CLOSE   deptsum;
        
    EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('ERROR CODE 01 : ' || TO_CHAR(SQLCODE));
            DBMS_OUTPUT.PUT_LINE('ERROR CODE 02 : ' || SQLCODE);
            DBMS_OUTPUT.PUT_LINE('ERROR MESSAGE : ' || SQLERRM);
                
             
    END deptSalSum;
/

EXEC deptSalSum(10);
EXEC deptSalSum(20);
EXEC deptSalSum(30);
EXEC deptSalSum(50);



-- FOR���� ����ϸ� Ŀ���� OPEN, FETCH, CLOSE�� �ڵ� �߻��ϹǷ� 
-- ���� ����� �ʿ䰡 ����, ���ڵ� �̸��� �ڵ�
-- ����ǹǷ� ���� ������ �ʿ䰡 ����.

CREATE OR REPLACE PROCEDURE ForCur_salSum
IS
    CURSOR  deptSum
        IS SELECT   b.dname, 
                    COUNT(a.empno) AS cnt,
                    SUM(a.sal) AS salary
           FROM     emp a, dept b
           WHERE    a.deptno = b.deptno
           GROUP BY b.dname
        ;
        
    BEGIN
        dbms_output.enable;
        FOR emp_list IN  deptSum
        LOOP
            DBMS_OUTPUT.PUT_LINE('DNAME  : ' || emp_list.dname);
            DBMS_OUTPUT.PUT_LINE('NUMofP : ' || emp_list.cnt);
            DBMS_OUTPUT.PUT_LINE('sumSal : ' || emp_list.salary);
        END LOOP;
        
    EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('ERROR CODE 01 : ' || TO_CHAR(SQLCODE));
        DBMS_OUTPUT.PUT_LINE('ERROR CODE 02 : ' || SQLCODE);
        DBMS_OUTPUT.PUT_LINE('ERROR MESSAGE : ' || SQLERRM);
    END;
 /     
 
 EXEC ForCur_salSum;
 
CREATE OR REPLACE PROCEDURE    preException    (v_deptno IN emp.deptno%TYPE)
    IS
        v_emp   emp%ROWTYPE;
    BEGIN
        dbms_output.enable;
        
        SELECT  empno,
                ename,
                deptno
        INTO    v_emp.empno,
                v_emp.ename,
                v_emp.deptno
        FROM    emp
        WHERE   deptno = v_deptno
        ;
            DBMS_OUTPUT.PUT_LINE('EMPNO  : ' || v_emp.empno);
            DBMS_OUTPUT.PUT_LINE('NAME   : ' || v_emp.ename);
            DBMS_OUTPUT.PUT_LINE('DEPTNO : ' || v_emp.deptno);
            
        EXCEPTION
            WHEN DUP_VAL_ON_INDEX THEN
                DBMS_OUTPUT.PUT_LINE('�ߺ� �����Ͱ� �����մϴ�');
                DBMS_OUTPUT.PUT_LINE('DUP_VAL_ON_INDEX ERROR �߻�');
            WHEN TOO_MANY_ROWS THEN
                DBMS_OUTPUT.PUT_LINE('TOO_MANY_ROWS ERROR �߻�');
            WHEN NO_DATA_FOUND THEN
                DBMS_OUTPUT.PUT_LINE('NO_DATA_FOUND ERROR �߻�');
            WHEN OTHERS THEN
                DBMS_OUTPUT.PUT_LINE('ERROR CODE 01 : ' || TO_CHAR(SQLCODE));
                DBMS_OUTPUT.PUT_LINE('ERROR CODE 02 : ' || SQLCODE);
                DBMS_OUTPUT.PUT_LINE('ERROR MESSAGE : ' || SQLERRM);
        
    END;
/

EXEC preException (90);



SELECT   a.deptno,
         b.dname,
         COUNT(a.empno) AS cnt,
         SUM(a.sal) AS salary
FROM     emp a,
         dept b            
GROUP BY a.deptno, b.dname
;

--   Procedure :  in_emp
----   Action    : emp Insert
----   1. Error ����
---      1) DUP_VAL_ON_INDEX  :  PreDefined --> Oracle ���� Error
---      2) User Defind Error :  lowsal_err (�����޿� ->1500)  
----------------------------------------

CREATE OR REPLACE PROCEDURE in_emp (
                                    p_name      IN  emp.ename%TYPE,
                                    p_sal       IN  emp.sal%TYPE,
                                    p_job       IN  emp.job%TYPE,
                                    p_deptno    IN  emp.deptno%TYPE
                                    )
    IS
        v_empno     emp.empno%TYPE;
        lowSal_err  EXCEPTION;
    
    BEGIN
        dbms_output.enable;
        SELECT  MAX(empno) + 1
        INTO    v_empno
        FROM    emp;
        
        IF  p_sal >= 1500 THEN
            INSERT INTO emp(
                            empno,
                            ename,
                            sal,
                            job,
                            deptno,
                            hiredate
                            )
                    VALUES  (
                            v_empno,
                            p_name,
                            p_sal,
                            p_job,
                            '10',
                            SYSDATE
                            );
        ELSE
            RAISE   lowSal_err;
        END IF;
        
    EXCEPTION
        WHEN DUP_VAL_ON_INDEX THEN
                DBMS_OUTPUT.PUT_LINE('�ߺ� �����Ͱ� �����մϴ�');
                DBMS_OUTPUT.PUT_LINE('DUP_VAL_ON_INDEX ERROR �߻�');
        WHEN lowSal_err THEN
                DBMS_OUTPUT.PUT_LINE('���ġ, ������ �װ� ����???');
    
    END in_emp;
/

EXEC in_emp('������', '2200', 'MANAGER', '10');



--   Procedure :  in_emp3
----   Action    : emp Insert
----   1. Error ����
---      1) DUP_VAL_ON_INDEX  :  PreDefined --> Oracle ���� Error
---      2) User Defind Error :  highsal_err (�ְ�޿� ->9000 �̻� ���� �߻�)  
---   2. ��Ÿ����
---      1) emp.ename�� Unique ���������� �ɷ� �ִٰ� ���� 
---      2) parameter : p_name, p_sal, p_job
---      3) PK(empno) : Max ��ȣ �Է� 
---      3) hiredate     : �ý��� ��¥ �Է� 
---      4) emp(empno,ename,sal,job,hiredate)  --> 5 Column�Է��Ѵ� ����

CREATE OR REPLACE PROCEDURE in_emp3(
                                    p_ename emp.ename%TYPE,
                                    p_sal   emp.sal%TYPE,
                                    p_job   emp.job%TYPE
                                    )
    IS
        v_empno       emp.empno%TYPE;
        highSal_err   EXCEPTION;
    
    BEGIN
        dbms_output.enable;
        SELECT  MAX(empno) + 1
        INTO    v_empno
        FROM    emp;
        
        IF  p_sal < 9000 THEN
            INSERT INTO emp(
                            empno,
                            ename,
                            sal,
                            job,
                            hiredate
                            )
                    VALUES  (
                            v_empno,
                            p_ename,
                            p_sal,
                            p_job,
                            SYSDATE
                            );
        ELSE    
            RAISE   highSal_err;
        END IF;
    
    EXCEPTION
        WHEN DUP_VAL_ON_INDEX THEN
            DBMS_OUTPUT.PUT_LINE('�ߺ� �����Ͱ� �����մϴ�');
            DBMS_OUTPUT.PUT_LINE('DUP_VAL_ON_INDEX ERROR �߻�');
        WHEN highSal_err THEN
            DBMS_OUTPUT.PUT_LINE('�ʹ� ������???');
    END;
/

EXEC in_emp3('������', '5200', 'MANAGER');
EXEC in_emp3('Ȳ�� ��', '5200', 'MANAGER');
EXEC in_emp3('�̽���', '9200', 'MANAGER');
