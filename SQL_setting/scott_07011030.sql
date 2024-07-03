
------------            ��������(Constraint)        ***
--  ����  : �������� ��Ȯ���� �ϰ����� ����
-- 1. ���̺� ������ ���Ἲ ���������� ���� ����
-- 2. ���̺� ���� ����, ������ ��ųʸ��� ����ǹǷ� ���� ���α׷����� �Էµ� 
--     ��� �����Ϳ� ���� �����ϰ� ����
-- 3. ���������� Ȱ��ȭ, ��Ȱ��ȭ �� �� �ִ� ���뼺



------------            ��������(Constraint)   ����      ***
-- 1 .NOT NULL  : ���� NULL�� ������ �� ����
-- 2. �⺻Ű(primary key, PK) : UNIQUE +  NOT NULL + �ּҼ�  ���������� ������ ����
-- 3. ����Ű(foreign key) :  ���̺� ���� �ܷ� Ű ���踦 ���� ***
-- 4. CHECK : �ش� Į���� ���� ������ ������ ���� ������ ���� ����
-------------------------------------------------------------
-- 1.  ��������(Constraint) ���� ���� ����(subject) ���̺� �ν��Ͻ�



CREATE  TABLE   subject (
                        subno       NUMBER(5)       CONSTRAINT  subject_no_pk   PRIMARY KEY,
                        subname     VARCHAR2(20)    CONSTRAINT  subject_name_nn NOT NULL,
                        term        VARCHAR2(1)     CONSTRAINT  subject_term_ck CHECK(term IN('1', '2')),
                        typeGubun   VARCHAR2(1)
                        )
;

COMMENT ON COLUMN   subject.subno   IS  '������ȣ';
COMMENT ON COLUMN   subject.subname IS  '��������';
COMMENT ON COLUMN   subject.term    IS  '�����б�';


INSERT  INTO    subject(subno,
                        subname,
                        term
                        )
        VALUES  (
                 '10000',
                 '��ǻ�Ͱ���',
                 '1'
                 )
;

INSERT  INTO    subject(subno,
                        subname,
                        term,
                        typegubun)
        VALUES  (
                 '10001',
                 'DB����',
                 '2',
                 '1'
                 )
;

INSERT  INTO    subject(subno,
                        subname,
                        term,
                        typegubun)
        VALUES  (
                 '10002',
                 'JSP����',
                 '1',
                 '1'
                 )
;

-- ERROR type
INSERT  INTO    subject(
                        subno,
                        subname,
                        term,
                        typegubun)
        VALUES  (
                 '10001',
                 'spring����',
                 '1',
                 '1'
                 )
;

INSERT  INTO    subject(
                        subname,
                        term,
                        typegubun)
        VALUES  (
                 'JSP����2',
                 '1',
                 '1'
                 )
;

INSERT  INTO    subject(
                        subno,
                        term,
                        typegubun)
        VALUES  (
                 '10003',
                 '1',
                 '1'
                 )
;

INSERT  INTO    subject(
                        subno,
                        subname,
                        term,
                        typegubun)
        VALUES  (
                 '10003',
                 'spring����2',
                 '5',
                 '1'
                 )
;


ALTER   TABLE   student
    ADD CONSTRAINT  stud_idnum_uk   UNIQUE(idnum)
;


INSERT INTO student(
                    studno,
                    name,
                    idnum
                    )
            VALUES (
                    '30101',
                    '������',
                    '8012301036613'
                    )
;


INSERT INTO student(
                    studno,
                    name,
                    idnum
                    )
            VALUES (
                    '30102',
                    '������',
                    '8012301036613'
                    )
;

INSERT INTO student(
                    studno,
                    name
                    )
            VALUES (
                    '30102',
                    '������'
                    )
;


ALTER TABLE student
    MODIFY (name CONSTRAINT stud_name_nn NOT NULL)
;

INSERT INTO student(
                    studno,
                    idnum
                    )
    VALUES         (
                    '30101',
                    '8012301036614'
                    )
;

SELECT  CONSTRAINT_name,
        CONSTRAINT_type
FROM    user_constraints
WHERE   table_name IN(
                        'SUBJECT',
                        'STUDENT'
                     )
;



--  INDEX      ***
--  �ε����� SQL ��ɹ��� ó�� �ӵ��� ���(*) ��Ű�� ���� Į���� ���� �����ϴ� ��ü
--  �ε����� ����Ʈ�� �̿��Ͽ� ���̺� ����� �����͸� ���� �׼����ϱ� ���� �������� ���
--  [1]�ε����� ����
--   1)���� �ε��� : ������ ���� ������ Į���� ���� �����ϴ� �ε����� ��� �ε��� Ű��
--           ���̺��� �ϳ��� ��� ����

CREATE UNIQUE INDEX idx_dept_name
    ON              department(dname)
;


INSERT INTO department
            VALUES      (
                            '300',
                            '�̰�����',
                            '10',
                            '4ȣ��'
                        )
;

INSERT INTO department (
                        deptno,
                        dname,
                        college,
                        loc
                        )
            VALUES      (
                            '301',
                            '�̰�����',
                            '10',
                            '4ȣ��'
                        )
;


-- ����� �ε��� birthdate  --> constraint  X   , ���ɿ��� ���� ��ħ 
--   2)����� �ε���
-- ��) �л� ���̺��� birthdate Į���� ����� �ε����� �����Ͽ���

CREATE INDEX    idx_stud_birthdate
    ON          student(birthdate)
;


INSERT INTO student(
                    studno,
                    name,
                    idnum,
                    birthdate
                    )
    VALUES          (
                    '30103',
                    '������',
                    '8012301031267',
                    '84/09/16'
                    )
;

SELECT  studno,
        name,
        birthdate
FROM    student
WHERE   birthdate = '84/09/16'
;



--   3)���� �ε���
--   4)���� �ε��� :  �� �� �̻��� Į���� �����Ͽ� �����ϴ� �ε���
--     ��) �л� ���̺��� deptno, grade Į���� ���� �ε����� ����
--          ���� �ε����� �̸��� idx_stud_dno_grade �� ����

CREATE INDEX    idx_stud_dno_grade
    ON          student(
                        deptno,
                        grade
                        )
;


SELECT  studno,
        name,
        grade,
        deptno,
        weight
FROM    student
--WHERE   grade = 2
--    AND deptno = 101
WHERE   deptno = 101
    AND grade = 2
;
    
ALTER SESSION SET OPTIMIZER_MODE = RULE; 
ALTER SESSION SET OPTIMIZER_MODE = CHOOSE;
ALTER SESSION SET OPTIMIZER_MODE = FIRST_ROWS;
ALTER SESSION SET OPTIMIZER_MODE = ALL_ROWS;

--SQL OPTIMIZER (HINT phrase)
SELECT  /*+first_rows*/ ename
FROM    emp
;

SELECT  /*+RULE*/ ename
FROM    emp
;


SELECT  NAME,
        VALUE,
        ISDEFAULT,
        ISMODIFIED,
        DESCRIPTION
FROM    v$system_parameter
WHERE NAME LIKE '%optimizer_mode%'
;


-- [2]�ε����� ȿ������ ��� 
--   1) WHERE ���̳� ���� ���������� ���� ���Ǵ� Į��
--   2) ��ü �������߿��� 10~15%�̳��� �����͸� �˻��ϴ� ���
--   3) �� �� �̻��� Į���� WHERE���̳� ���� ���ǿ��� ���� ���Ǵ� ���
--   4) ���̺� ����� �������� ������ �幮 ���
--   5) ���� �� ���� ���� ���Ե� ���, ���� �������� ���� ���ԵȰ��

ALTER INDEX PK_DEPTNO   REBUILD;

SELECT  index_name,
        table_name,
        column_name
FROM    user_ind_columns
;

CREATE INDEX    idx_emp_job
    ON          emp(job)
;

ALTER SESSION SET OPTIMIZER_MODE = RULE; 

-- FOLLOW THE RULES
SELECT  *
FROM    emp
WHERE   job = 'MANAGER'
;

SELECT  *
FROM    emp
WHERE   job LIKE 'MA%'
;

--IGNORE THE RULE
SELECT  *
FROM    emp
WHERE   job <> 'MANAGER'
;

SELECT  *
FROM    emp
WHERE   job LIKE '%NA%'
;

SELECT  *
FROM    emp
WHERE   UPPER(job) = 'MANAGER'
;

SELECT  *
FROM    emp
WHERE   LOWER(job) = 'manager'
;


-- 5)�Լ� ��� �ε���(FBI) function based index
--      ����Ŭ 8i �������� �����ϴ� ���ο� ������ �ε����� Į���� ���� �����̳� �Լ��� ��� ����� 
--      �ε����� ���� ����
--      UPPER(column_name) �Ǵ� LOWER(column_name) Ű����� ���ǵ�
--      �Լ� ��� �ε����� ����ϸ� ��ҹ��� ���� ���� �˻�

CREATE INDEX    uppercase_idx
    ON          emp(UPPER(job))
;

SELECT  *
FROM    emp
WHERE   UPPER(job) = 'SALESMAN'
;



-- Ʈ����� ����  ***
-- ������ �����ͺ��̽����� ����Ǵ� ���� ���� SQL��ɹ��� �ϳ��� ���� �۾� ������ ó���ϴ� ����
-- COMMIT : Ʈ������� �������� ����
--               Ʈ����ǳ��� ��� SQL ��ɹ��� ���� ����� �۾� ������ ��ũ�� ���������� �����ϰ� 
--               Ʈ������� ����
--               �ش� Ʈ����ǿ� �Ҵ�� CPU, �޸� ���� �ڿ��� ����
--               ���� �ٸ� Ʈ������� �����ϴ� ����
--               COMMIT ��ɹ� �����ϱ� ���� �ϳ��� Ʈ����� ������ �����
--               �ٸ� Ʈ����ǿ��� ������ �� ������ �����Ͽ� �ϰ��� ����
 
-- ROLLBACK : Ʈ������� ��ü ���
--                   Ʈ����ǳ��� ��� SQL ��ɹ��� ���� ����� �۾� ������ ���� ����ϰ� Ʈ������� ����
--                   CPU,�޸� ���� �ش� Ʈ����ǿ� �Ҵ�� �ڿ��� ����, Ʈ������� ���� ����




-- SEQUENCE ***
-- ������ �ĺ���
-- �⺻ Ű ���� �ڵ����� �����ϱ� ���Ͽ� �Ϸù�ȣ ���� ��ü
-- ���� ���, �� �Խ��ǿ��� ���� ��ϵǴ� ������� ��ȣ�� �ϳ��� �Ҵ��Ͽ� �⺻Ű�� �����ϰ��� �Ҷ� 
-- �������� ���ϰ� �̿�
-- ���� ���̺��� ���� ����  -- > �Ϲ������δ� ������ ��� 
----------------------------------
-- 1) SEQUENCE ����
--CREATE SEQUENCE sequence
--[INCREMENT BY n]
--[START WITH n]
--[MAXVALUE n | NOMAXVALUE]
--[MINVALUE n | NOMINVALUE]
--[CYCLE | NOCYCLE]
--[CACHE n | NOCACHE];
--INCREMENT BY n : ������ ��ȣ�� ����ġ�� �⺻�� 1,  �Ϲ������� ?1 ���
--START WITH n : ������ ���۹�ȣ, �⺻���� 1
--MAXVALUE n : ���� ������ �������� �ִ밪
--MAXVALUE n : ������ ��ȣ�� ��ȯ������ ����ϴ� cycle�� ������ ���, MAXVALUE�� ������ �� ���� �����ϴ� ��������
--CYCLE | NOCYCLE : MAXVALUE �Ǵ� MINVALUE�� ������ �� �������� ��ȯ���� ������ ��ȣ�� ���� ���� ����
--CACHE n | NOCACHE : ������ ���� �ӵ� ������ ���� �޸𸮿� ĳ���ϴ� ������ ����, �⺻���� 20

CREATE SEQUENCE sample_seq
INCREMENT BY 1
START WITH   10000
;

SELECT  SAMPLE_SEQ.nextval
FROM    dual
;

SELECT  sample_seq.CURRVAL
FROM    dual
;

CREATE SEQUENCE dept_dno_seq
INCREMENT BY    1
START WITH      76
;

INSERT INTO dept_second
    VALUES  (
                dept_dno_seq.NEXTVAL, 
                'Accounting',
                'NEWYORK'
            )
;

SELECT  dept_dno_seq.CURRVAL
FROM    dual
;

INSERT INTO dept_second
    VALUES  (
                dept_dno_seq.NEXTVAL, 
                'ȸ��',
                '�̴�'
            )
;

SELECT  dept_dno_seq.CURRVAL
FROM    dual
;


--empty table copy
--CREATE TABLE  empty_table
--  AS  SELECT FROM * dept
--  WHERE 0=1;


INSERT INTO dept_second
    VALUES  (
                dept_dno_seq.NEXTVAL, 
                '�λ���',
                '���'
            )
;

SELECT  dept_dno_seq.CURRVAL
FROM    dual
;

--MAX ��ȯ

INSERT INTO dept_second
    VALUES  (
                (
                    SELECT MAX  (deptno) + 1
                    FROM        dept_second
                ),
                '�濵��',
                '�븲'
            )
;
    
INSERT INTO dept_second
    VALUES  (
                dept_dno_seq.NEXTVAL, 
                '�λ�8��',
                '���'
            )
;        


-- FK ***


DELETE emp
WHERE empno = 1000;

-- 1. Restrict : �ڽ� ���� ���� �ȵ�  (���� ���� ����)
--    1) ����   Emp Table����  REFERENCES DEPT (DEPTNO) 
--    2) ����   integrity constraint (SCOTT.FK_DEPTNO) violated - child record found
DELETE dept
WHERE deptno = 50;

-- 2. Cascading Delete : ���� ����
--    1)���ӻ��� ���� : Emp Table���� REFERENCES DEPT (DEPTNO) ON DELETE CASCADE

DELETE dept
WHERE deptno = 50;

-- 3.  SET NULL
--    1) ���� NULL ���� : Emp Table���� REFERENCES DEPT (DEPTNO)  ON DELETE SET NULL
DELETE dept
WHERE deptno = 50;