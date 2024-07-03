
------------            제약조건(Constraint)        ***
--  정의  : 데이터의 정확성과 일관성을 보장
-- 1. 테이블 생성시 무결성 제약조건을 정의 가능
-- 2. 테이블에 대해 정의, 데이터 딕셔너리에 저장되므로 응용 프로그램에서 입력된 
--     모든 데이터에 대해 동일하게 적용
-- 3. 제약조건을 활성화, 비활성화 할 수 있는 융통성



------------            제약조건(Constraint)   종류      ***
-- 1 .NOT NULL  : 열이 NULL을 포함할 수 없음
-- 2. 기본키(primary key, PK) : UNIQUE +  NOT NULL + 최소성  제약조건을 결합한 형태
-- 3. 참조키(foreign key) :  테이블 간에 외래 키 관계를 설정 ***
-- 4. CHECK : 해당 칼럼에 저장 가능한 데이터 값의 범위나 조건 지정
-------------------------------------------------------------
-- 1.  제약조건(Constraint) 적용 위한 강좌(subject) 테이블 인스턴스



CREATE  TABLE   subject (
                        subno       NUMBER(5)       CONSTRAINT  subject_no_pk   PRIMARY KEY,
                        subname     VARCHAR2(20)    CONSTRAINT  subject_name_nn NOT NULL,
                        term        VARCHAR2(1)     CONSTRAINT  subject_term_ck CHECK(term IN('1', '2')),
                        typeGubun   VARCHAR2(1)
                        )
;

COMMENT ON COLUMN   subject.subno   IS  '수강번호';
COMMENT ON COLUMN   subject.subname IS  '수강과목';
COMMENT ON COLUMN   subject.term    IS  '수강학기';


INSERT  INTO    subject(subno,
                        subname,
                        term
                        )
        VALUES  (
                 '10000',
                 '컴퓨터개론',
                 '1'
                 )
;

INSERT  INTO    subject(subno,
                        subname,
                        term,
                        typegubun)
        VALUES  (
                 '10001',
                 'DB개론',
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
                 'JSP개론',
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
                 'spring개론',
                 '1',
                 '1'
                 )
;

INSERT  INTO    subject(
                        subname,
                        term,
                        typegubun)
        VALUES  (
                 'JSP개론2',
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
                 'spring개론2',
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
                    '대조영',
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
                    '연남생',
                    '8012301036613'
                    )
;

INSERT INTO student(
                    studno,
                    name
                    )
            VALUES (
                    '30102',
                    '연남생'
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
--  인덱스는 SQL 명령문의 처리 속도를 향상(*) 시키기 위해 칼럼에 대해 생성하는 객체
--  인덱스는 포인트를 이용하여 테이블에 저장된 데이터를 랜덤 액세스하기 위한 목적으로 사용
--  [1]인덱스의 종류
--   1)고유 인덱스 : 유일한 값을 가지는 칼럼에 대해 생성하는 인덱스로 모든 인덱스 키는
--           테이블의 하나의 행과 연결

CREATE UNIQUE INDEX idx_dept_name
    ON              department(dname)
;


INSERT INTO department
            VALUES      (
                            '300',
                            '이과대학',
                            '10',
                            '4호관'
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
                            '이과대학',
                            '10',
                            '4호관'
                        )
;


-- 비고유 인덱스 birthdate  --> constraint  X   , 성능에만 영향 미침 
--   2)비고유 인덱스
-- 문) 학생 테이블의 birthdate 칼럼을 비고유 인덱스로 생성하여라

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
                    '김유신',
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



--   3)단일 인덱스
--   4)결합 인덱스 :  두 개 이상의 칼럼을 결합하여 생성하는 인덱스
--     문) 학생 테이블의 deptno, grade 칼럼을 결합 인덱스로 생성
--          결합 인덱스의 이름은 idx_stud_dno_grade 로 정의

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


-- [2]인덱스가 효율적인 경우 
--   1) WHERE 절이나 조인 조건절에서 자주 사용되는 칼럼
--   2) 전체 데이터중에서 10~15%이내의 데이터를 검색하는 경우
--   3) 두 개 이상의 칼럼이 WHERE절이나 조인 조건에서 자주 사용되는 경우
--   4) 테이블에 저장된 데이터의 변경이 드문 경우
--   5) 열에 널 값이 많이 포함된 경우, 열에 광범위한 값이 포함된경우

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


-- 5)함수 기반 인덱스(FBI) function based index
--      오라클 8i 버전부터 지원하는 새로운 형태의 인덱스로 칼럼에 대한 연산이나 함수의 계산 결과를 
--      인덱스로 생성 가능
--      UPPER(column_name) 또는 LOWER(column_name) 키워드로 정의된
--      함수 기반 인덱스를 사용하면 대소문자 구분 없이 검색

CREATE INDEX    uppercase_idx
    ON          emp(UPPER(job))
;

SELECT  *
FROM    emp
WHERE   UPPER(job) = 'SALESMAN'
;



-- 트랜잭션 개요  ***
-- 관계형 데이터베이스에서 실행되는 여러 개의 SQL명령문을 하나의 논리적 작업 단위로 처리하는 개념
-- COMMIT : 트랜잭션의 정상적인 종료
--               트랜잭션내의 모든 SQL 명령문에 의해 변경된 작업 내용을 디스크에 영구적으로 저장하고 
--               트랜잭션을 종료
--               해당 트랜잭션에 할당된 CPU, 메모리 같은 자원이 해제
--               서로 다른 트랜잭션을 구분하는 기준
--               COMMIT 명령문 실행하기 전에 하나의 트랜잭션 변경한 결과를
--               다른 트랜잭션에서 접근할 수 없도록 방지하여 일관성 유지
 
-- ROLLBACK : 트랜잭션의 전체 취소
--                   트랜잭션내의 모든 SQL 명령문에 의해 변경된 작업 내용을 전부 취소하고 트랜잭션을 종료
--                   CPU,메모리 같은 해당 트랜잭션에 할당된 자원을 해제, 트랜잭션을 강제 종료




-- SEQUENCE ***
-- 유일한 식별자
-- 기본 키 값을 자동으로 생성하기 위하여 일련번호 생성 객체
-- 예를 들면, 웹 게시판에서 글이 등록되는 순서대로 번호를 하나씩 할당하여 기본키로 지정하고자 할때 
-- 시퀀스를 편리하게 이용
-- 여러 테이블에서 공유 가능  -- > 일반적으로는 개별적 사용 
----------------------------------
-- 1) SEQUENCE 형식
--CREATE SEQUENCE sequence
--[INCREMENT BY n]
--[START WITH n]
--[MAXVALUE n | NOMAXVALUE]
--[MINVALUE n | NOMINVALUE]
--[CYCLE | NOCYCLE]
--[CACHE n | NOCACHE];
--INCREMENT BY n : 시퀀스 번호의 증가치로 기본은 1,  일반적으로 ?1 사용
--START WITH n : 시퀀스 시작번호, 기본값은 1
--MAXVALUE n : 생성 가능한 시퀀스의 최대값
--MAXVALUE n : 시퀀스 번호를 순환적으로 사용하는 cycle로 지정한 경우, MAXVALUE에 도달한 후 새로 시작하는 시퀀스값
--CYCLE | NOCYCLE : MAXVALUE 또는 MINVALUE에 도달한 후 시퀀스의 순환적인 시퀀스 번호의 생성 여부 지정
--CACHE n | NOCACHE : 시퀀스 생성 속도 개선을 위해 메모리에 캐쉬하는 시퀀스 개수, 기본값은 20

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
                '회계',
                '이대'
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
                '인사팀',
                '당산'
            )
;

SELECT  dept_dno_seq.CURRVAL
FROM    dual
;

--MAX 전환

INSERT INTO dept_second
    VALUES  (
                (
                    SELECT MAX  (deptno) + 1
                    FROM        dept_second
                ),
                '경영팀',
                '대림'
            )
;
    
INSERT INTO dept_second
    VALUES  (
                dept_dno_seq.NEXTVAL, 
                '인사8팀',
                '당산'
            )
;        


-- FK ***


DELETE emp
WHERE empno = 1000;

-- 1. Restrict : 자식 존재 삭제 안됨  (연관 관계 때문)
--    1) 선언   Emp Table에서  REFERENCES DEPT (DEPTNO) 
--    2) 예시   integrity constraint (SCOTT.FK_DEPTNO) violated - child record found
DELETE dept
WHERE deptno = 50;

-- 2. Cascading Delete : 같이 죽자
--    1)종속삭제 선언 : Emp Table에서 REFERENCES DEPT (DEPTNO) ON DELETE CASCADE

DELETE dept
WHERE deptno = 50;

-- 3.  SET NULL
--    1) 종속 NULL 선언 : Emp Table에서 REFERENCES DEPT (DEPTNO)  ON DELETE SET NULL
DELETE dept
WHERE deptno = 50;