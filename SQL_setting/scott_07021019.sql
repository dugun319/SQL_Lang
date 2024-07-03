--문1)  학생 테이블에서 101번 학과 학생들의 학번, 이름, 학과 번호로 정의되는 단순 뷰를 생성
---     뷰 명 :  v_stud_dept101

CREATE OR REPLACE VIEW  v_stud_dept101
    AS SELECT           studno,
                        name,
                        deptno
    FROM                student
    WHERE               deptno = '101'
;

--문2) 학생 테이블과 부서 테이블을 조인하여 102번 학과 학생들의 학번, 이름, 학년, 학과 이름으로 정의되는 복합 뷰를 생성
--      뷰 명 :   v_stud_dept102

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
                        

--문3)  교수 테이블에서 학과별 평균 급여와     총계로 정의되는 뷰를 생성
--  뷰 명 :  v_prof_avg_sal       Column 명 :   avg_sal      sum_sal

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
                                '홍길동1'
                            )
;

INSERT INTO view_complex_emp(
                                empno,
                                ename,
                                deptno
                            )
       VALUES               (
                                '1502',
                                '홍길동2',
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
                                '홍길동3',
                                '20',
                                '공무팀',
                                '낙성대'
                            )
;

DELETE FROM emp
WHERE ename = '홍길동'
;

-- 계층적 질의문
-------------------------------------
-- 1. 관계형 데이터 베이스 모델은 평면적인 2차원 테이블 구조
-- 2. 관계형 데이터 베이스에서 데이터간의 부모 관계를 표현할 수 있는 칼럼을 지정하여 
--    계층적인 관계를 표현
-- 3. 하나의 테이블에서 계층적인 구조를 표현하는 관계를 순환관계(recursive relationship)
-- 4. 계층적인 데이터를 저장한 칼럼으로부터 데이터를 검색하여 계층적으로 출력 기능 제공

-- 사용법
-- SELECT 명령문에서 START WITH와 CONNECT BY 절을 이용
-- 계층적 질의문에서는 계층적인 출력 형식과 시작 위치 제어
-- 출력 형식은  top-down 또는 bottom-up
-- 참고) CONNECT BY PRIOR 및 START WITH절은 ANSI SQL 표준이 아님



-- 문1) 계층적 질의문을 사용하여 부서 테이블에서 학과,학부,단과대학을 검색하여 단대,학부
-- 학과순으로 top-down 형식의 계층 구조로 출력하여라. 단, 시작 데이터는 10번 부서

SELECT                  deptno,
                        dname,
                        college
FROM                    department
    START WITH          deptno = '10'
    CONNECT BY PRIOR    deptno = college
;


-- 문2)계층적 질의문을 사용하여 부서 테이블에서 학과,학부,단과대학을 검색하여 학과,학부
-- 단대 순으로 bottom-up 형식의 계층 구조로 출력하여라. 단, 시작 데이터는 102번 부서이다

SELECT                  deptno,
                        dname,
                        college
FROM                    department
    START WITH          deptno = '102'
    CONNECT BY PRIOR    college = deptno
;

-- 문3) 계층적 질의문을 사용하여 부서 테이블에서 부서 이름을 검색하여 단대, 학부, 학과순의
---     top-down 형식으로 출력하여라. 단, 시작 데이터는 ‘공과대학’이고,
---     각 LEVEL(레벨)별로 우측으로 2칸 이동하여 출력

SELECT                  LEVEL,
                        deptno,
                        LPAD(' ',2*(LEVEL-1)) || dname AS ORGANIZATION,
                        college
FROM                    department
    START WITH          deptno = '10'
    CONNECT BY PRIOR    deptno = college
;



-- TableSpace  
-- 정의  :데이터베이스 오브젝트 내 실제 데이터를 저장하는 공간
-- 이것은 데이터베이스의 물리적인 부분이며, 세그먼트로 관리되는 모든 DBMS에 대해 
-- 저장소(세그먼트)를 할당 C:\Backup\tableSpace


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
--  1. 정의 : 어떤 사건이 발생했을 때 내부적으로 실행되도록 데이터베 이스에 저장된 프로시저
--              트리거가 실행되어야 할 이벤트 발생시 자동으로 실행되는 프로시저 
--              트리거링 사건(Triggering Event), 즉 오라클 DML 문인 INSERT, DELETE, UPDATE이 
--              실행되면 자동으로 실행
--  2. 오라클 트리거 사용 범위
--    1) 데이터베이스 테이블 생성하는 과정에서 참조 무결성과 데이터 무결성 등의 복잡한 제약 조건 생성하는 경우 
--    2) 데이터베이스 테이블의 데이터에 생기는 작업의 감시, 보완 
--    3) 데이터베이스 테이블에 생기는 변화에 따라 필요한 다른 프로그램을 실행하는 경우 
--    4) 불필요한 트랜잭션을 금지하기 위해 
--    5) 컬럼의 값을 자동으로 생성되도록 하는 경우 


CREATE OR REPLACE TRIGGER   trigger_test
BEFORE UPDATE ON            dept
FOR EACH ROW
BEGIN   
    dbms_output.enable;
    dbms_output.put_line('변경 전 컬럼 값 : '||:old.dname);
    dbms_output.put_line('변경 후 컬럼 값 : '||:new.dname);
END
;
/


UPDATE  dept
SET     dname = '회계3팀',
        loc = '충무로'
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
    DBMS_OUTPUT.PUT_LINE('이전급여 : '||:old.sal);
    DBMS_OUTPUT.PUT_LINE('최신급여 : '||:new.sal);
    DBMS_OUTPUT.PUT_LINE('급여차액 : '||sal_diff);
    -- DBMS_OUTPUT.PUT_LINE('급여차액 : '||:new.sal-:old.sal);
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
    VALUES('3000', '유지원', '5000', 50)
;

INSERT INTO emp(
                empno,
                ename,
                sal,
                deptno
                )
    VALUES(     '3001',
                '황보슬',
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