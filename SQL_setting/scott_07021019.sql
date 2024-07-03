--��1)  �л� ���̺��� 101�� �а� �л����� �й�, �̸�, �а� ��ȣ�� ���ǵǴ� �ܼ� �並 ����
---     �� �� :  v_stud_dept101

CREATE OR REPLACE VIEW  v_stud_dept101
    AS SELECT           studno,
                        name,
                        deptno
    FROM                student
    WHERE               deptno = '101'
;

--��2) �л� ���̺�� �μ� ���̺��� �����Ͽ� 102�� �а� �л����� �й�, �̸�, �г�, �а� �̸����� ���ǵǴ� ���� �並 ����
--      �� �� :   v_stud_dept102

CREATE OR REPLACE VIEW  v_stud_dept102
    AS SELECT           s.studno,
                        s.name,
                        s.grade,
                        s.deptno,
                        d.dname
    FROM                student s,
                        department d
    WHERE               s.deptno = d.deptno
        AND             s.deptno = '102'
;
                        

--��3)  ���� ���̺��� �а��� ��� �޿���     �Ѱ�� ���ǵǴ� �並 ����
--  �� �� :  v_prof_avg_sal       Column �� :   avg_sal      sum_sal

CREATE OR REPLACE VIEW  v_prof_avg_sal
    AS SELECT           deptno,
                        AVG(sal) AS avg_sal,
                        SUM(sal) AS sum_sal
    FROM                professor
    GROUP BY            deptno
    ORDER BY            deptno
;

INSERT INTO v_prof_avg_sal
    VALUES  ('203', '600', '300')
;

DROP VIEW v_prof_avg_sal;

SELECT  view_name,
        text
FROM    user_views
;

CREATE OR REPLACE VIEW  view_professor
    AS SELECT           profno,
                        name,
                        userid,
                        position,
                        hiredate,
                        deptno
    FROM                professor
;

SELECT  *
FROM    view_professor
;


INSERT INTO view_professor
    VALUES  (
                '2000',
                'view',
                'useid',
                'position',
                sysdate,
                '1012'
            )
;
                
INSERT INTO view_professor (
                            profno,
                            userid,
                            position,
                            hiredate,
                            deptno
                            )
    VALUES                 (
                            '2001',
                            'userid',
                            'position2',
                            sysdate,
                            '101'
                            )
;
      
CREATE OR REPLACE VIEW  view_emp_sample
    AS SELECT           empno,
                        ename,  
                        job,
                        mgr,
                        deptno
    FROM                emp
;


INSERT INTO view_emp_sample (
                                empno,
                                ename,  
                                job,
                                mgr,
                                deptno
                            )
    VALUES                  (
                                '2001',
                                'userid2',
                                'position2',
                                '7839',
                                '10'
                            )
;

DROP VIEW view_complex_emp;

CREATE OR REPLACE VIEW  view_complex_emp
    AS SELECT           e.empno,
                        e.ename,  
                        e.job,
                        e.mgr,
                        e.hiredate,
                        e.sal,
                        e.comm,
                        e.deptno,
                        d.dname,
                        d.loc
    FROM                emp e,
                        dept d
    WHERE               e.deptno = d.deptno
;

CREATE OR REPLACE VIEW  view_complex_emp
    AS SELECT           *
    FROM                emp 
        NATURAL JOIN    dept
;

INSERT INTO view_complex_emp(
                                empno,
                                ename
                            )
       VALUES               (
                                '1501',
                                'ȫ�浿1'
                            )
;

INSERT INTO view_complex_emp(
                                empno,
                                ename,
                                deptno
                            )
       VALUES               (
                                '1502',
                                'ȫ�浿2',
                                '20'
                            )
;

INSERT INTO view_complex_emp(
                                empno,
                                ename,
                                deptno,
                                dname,
                                loc
                            )
       VALUES               (
                                '1503',
                                'ȫ�浿3',
                                '20',
                                '������',
                                '������'
                            )
;

DELETE FROM emp
WHERE ename = 'ȫ�浿'
;

-- ������ ���ǹ�
-------------------------------------
-- 1. ������ ������ ���̽� ���� ������� 2���� ���̺� ����
-- 2. ������ ������ ���̽����� �����Ͱ��� �θ� ���踦 ǥ���� �� �ִ� Į���� �����Ͽ� 
--    �������� ���踦 ǥ��
-- 3. �ϳ��� ���̺��� �������� ������ ǥ���ϴ� ���踦 ��ȯ����(recursive relationship)
-- 4. �������� �����͸� ������ Į�����κ��� �����͸� �˻��Ͽ� ���������� ��� ��� ����

-- ����
-- SELECT ��ɹ����� START WITH�� CONNECT BY ���� �̿�
-- ������ ���ǹ������� �������� ��� ���İ� ���� ��ġ ����
-- ��� ������  top-down �Ǵ� bottom-up
-- ����) CONNECT BY PRIOR �� START WITH���� ANSI SQL ǥ���� �ƴ�



-- ��1) ������ ���ǹ��� ����Ͽ� �μ� ���̺��� �а�,�к�,�ܰ������� �˻��Ͽ� �ܴ�,�к�
-- �а������� top-down ������ ���� ������ ����Ͽ���. ��, ���� �����ʹ� 10�� �μ�

SELECT                  deptno,
                        dname,
                        college
FROM                    department
    START WITH          deptno = '10'
    CONNECT BY PRIOR    deptno = college
;


-- ��2)������ ���ǹ��� ����Ͽ� �μ� ���̺��� �а�,�к�,�ܰ������� �˻��Ͽ� �а�,�к�
-- �ܴ� ������ bottom-up ������ ���� ������ ����Ͽ���. ��, ���� �����ʹ� 102�� �μ��̴�

SELECT                  deptno,
                        dname,
                        college
FROM                    department
    START WITH          deptno = '102'
    CONNECT BY PRIOR    college = deptno
;

-- ��3) ������ ���ǹ��� ����Ͽ� �μ� ���̺��� �μ� �̸��� �˻��Ͽ� �ܴ�, �к�, �а�����
---     top-down �������� ����Ͽ���. ��, ���� �����ʹ� ���������С��̰�,
---     �� LEVEL(����)���� �������� 2ĭ �̵��Ͽ� ���

SELECT                  LEVEL,
                        deptno,
                        LPAD(' ',2*(LEVEL-1)) || dname AS ORGANIZATION,
                        college
FROM                    department
    START WITH          deptno = '10'
    CONNECT BY PRIOR    deptno = college
;



-- TableSpace  
-- ����  :�����ͺ��̽� ������Ʈ �� ���� �����͸� �����ϴ� ����
-- �̰��� �����ͺ��̽��� �������� �κ��̸�, ���׸�Ʈ�� �����Ǵ� ��� DBMS�� ���� 
-- �����(���׸�Ʈ)�� �Ҵ� C:\Backup\tableSpace


CREATE TABLESPACE user1 DATAFILE 'C:\Backup\tableSpace\user1.ora' SIZE 100M;
CREATE TABLESPACE user2 DATAFILE 'C:\Backup\tableSpace\user2.ora' SIZE 100M;
CREATE TABLESPACE user3 DATAFILE 'C:\Backup\tableSpace\user3.ora' SIZE 100M;
CREATE TABLESPACE user4 DATAFILE 'C:\Backup\tableSpace\user4.ora' SIZE 100M;

SELECT  index_name,
        table_name,
        tablespace_name
FROM    user_indexes
;

ALTER INDEX         PK_RELIGIONNO3 
REBUILD TABLESPACE  user1
;


SELECT  table_name,
        tablespace_name
FROM    user_tables
;

ALTER TABLE     job3
MOVE TABLESPACE user2
;


ALTER DATABASE DATAFILE 'C:\Backup\tableSpace\user4.ora' RESIZE 200M;


-- EXPDP scott/tiger DIRECTORY=mdBackup2 DUMPFILE=scott.dmp

-- IMPDP scott/tiger DIRECTORY=mdBackup2 DUMPFILE=scott.dmp

-- EXP scott/tiger FILE = dept_second.dmp  TABLES = dept_second
-- EXP scott/tiger FILE = address.dmp      TABLES = address
-- EXP scott/tiger FILE = bonus.dmp        TABLES = address

-- IMP scott/tiger FILE = dept_second.dmp  TABLES = dept_second
-- IMP scott/tiger FILE = address.dmp      TABLES = address
-- IMP scott/tiger FILE = bonus.dmp        TABLES = address


--                     Trigger 
--  1. ���� : � ����� �߻����� �� ���������� ����ǵ��� �����ͺ� �̽��� ����� ���ν���
--              Ʈ���Ű� ����Ǿ�� �� �̺�Ʈ �߻��� �ڵ����� ����Ǵ� ���ν��� 
--              Ʈ���Ÿ� ���(Triggering Event), �� ����Ŭ DML ���� INSERT, DELETE, UPDATE�� 
--              ����Ǹ� �ڵ����� ����
--  2. ����Ŭ Ʈ���� ��� ����
--    1) �����ͺ��̽� ���̺� �����ϴ� �������� ���� ���Ἲ�� ������ ���Ἲ ���� ������ ���� ���� �����ϴ� ��� 
--    2) �����ͺ��̽� ���̺��� �����Ϳ� ����� �۾��� ����, ���� 
--    3) �����ͺ��̽� ���̺� ����� ��ȭ�� ���� �ʿ��� �ٸ� ���α׷��� �����ϴ� ��� 
--    4) ���ʿ��� Ʈ������� �����ϱ� ���� 
--    5) �÷��� ���� �ڵ����� �����ǵ��� �ϴ� ��� 


CREATE OR REPLACE TRIGGER   trigger_test
BEFORE UPDATE ON            dept
FOR EACH ROW
BEGIN   
    dbms_output.enable;
    dbms_output.put_line('���� �� �÷� �� : '||:old.dname);
    dbms_output.put_line('���� �� �÷� �� : '||:new.dname);
END
;
/


UPDATE  dept
SET     dname = 'ȸ��3��',
        loc = '�湫��'
WHERE   deptno = '72'
;

ROLLBACK;  

CREATE OR REPLACE TRIGGER   emp_sal_change
BEFORE DELETE OR INSERT OR UPDATE ON            emp
FOR EACH ROW
    WHEN (new.empno > 0)
    DECLARE
        sal_diff    NUMBER;    
BEGIN
    dbms_output.enable;
    sal_diff := :new.sal - :old.sal;
    DBMS_OUTPUT.PUT_LINE('�����޿� : '||:old.sal);
    DBMS_OUTPUT.PUT_LINE('�ֽű޿� : '||:new.sal);
    DBMS_OUTPUT.PUT_LINE('�޿����� : '||sal_diff);
    -- DBMS_OUTPUT.PUT_LINE('�޿����� : '||:new.sal-:old.sal);
END
;
/

UPDATE  emp
SET     sal = '1000'
WHERE   empno = '7369'
;


CREATE SEQUENCE emp_row_seq;

CREATE TABLE    emp_row_audit(
                                e_id    NUMBER(6)       CONSTRAINT emp_row_pk   PRIMARY KEY,
                                e_name  VARCHAR2(30),
                                e_gubun VARCHAR2(10),
                                e_date  DATE
                              )
;


CREATE OR REPLACE TRIGGER           emp_row_audit
AFTER
    INSERT OR UPDATE OR DELETE ON   emp
FOR EACH ROW
BEGIN
    IF INSERTING THEN
        INSERT INTO emp_row_audit
            VALUES  (
                        EMP_ROW_SEQ.nextval,
                        :new.ename,
                        'inserting',
                        SYSDATE
                     );
    ELSIF UPDATING THEN
        INSERT INTO emp_row_audit
            VALUES  (
                        EMP_ROW_SEQ.nextval,
                        :old.ename,
                        'updating',
                        SYSDATE
                    );
    ELSIF DELETING THEN
        INSERT INTO emp_row_audit
            VALUES  (
                        EMP_ROW_SEQ.nextval,
                        :old.ename,
                        'deleting',
                        SYSDATE
                    );
    END IF;
END;
/


INSERT INTO emp(
                empno,
                ename,
                sal,
                deptno
                )
    VALUES('3000', '������', '5000', 50)
;

INSERT INTO emp(
                empno,
                ename,
                sal,
                deptno
                )
    VALUES(     '3001',
                'Ȳ����',
                '4900',
                '50')
;

UPDATE  emp
SET     sal = '3000'
WHERE   empno = '1501'
;

DELETE  emp
WHERE   empno = '1501'
;