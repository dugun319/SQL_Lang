--CRUD

--Create
INSERT INTO dept VALUES(50, 'Sales_01', 'Pear Blossom');

INSERT INTO dept VALUES(60, 'Sales_02', 'Chungang');

--Update
UPDATE  dept 
SET     dname = 'OPERATIONS'
WHERE   deptno = 40;

--Select
SELECT * FROM dept;

--Delete
DELETE  dept
WHERE   deptno = 50;

COMMIT;

SELECT * FROM emp;


CREATE OR REPLACE PROCEDURE Dept_Insert
(
    p_deptno    in dept.deptno%TYPE,
    p_dname     in dept.dname%TYPE,
    p_loc       in dept.loc%TYPE
)
IS
begin
    INSERT INTO dept VALUES(p_deptno, p_dname, p_loc);
    COMMIT;
END;


CREATE OR REPLACE PROCEDURE EMP_INFO2
(
    p_empno     in  emp.empno%TYPE,
    p_ename     out emp.ename%TYPE,
    p_sal       out emp.sal%TYPE
)

IS
v_empno emp.empno%TYPE;

begin
    DBMS_OUTPUT.ENABLE;
    --%TYPE �������� ���� ���
    SELECT  empno, ename, sal
    INTO    v_empno, p_ename, p_sal
    -- INTO�� ���ۿ� ������ �����ش�
    FROM    emp
    WHERE   empno = p_empno;
    
    -- output the result
    DBMS_OUTPUT.PUT_LINE('EMP. NO.  : ' || v_empno || CHR(10) || CHR(13) || '�ٹٲ�');
    -- CHR(10) || CHR(13) �ٹٲ�
    DBMS_OUTPUT.PUT_LINE('EMP. Name : ' || p_ename);
    DBMS_OUTPUT.PUT_LINE('EMP. Sal. : ' || p_sal);
    -- sysout�� ����

    COMMIT;
END;

ROLLBACK;
