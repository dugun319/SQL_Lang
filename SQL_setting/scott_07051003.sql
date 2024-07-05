CREATE OR REPLACE PROCEDURE insert_emp (
                                        p_empno  IN emp.empno%TYPE,
                                        p_ename  IN emp.ename%TYPE,
                                        p_job    IN emp.job%TYPE,
                                        p_mgr    IN emp.mgr%TYPE,
                                        p_sal    IN emp.sal%TYPE,
                                        p_deptno IN emp.deptno%TYPE
                                        )
--  20240705 HW1
-- 1. 파라메타 : (p_empno, p_ename  , p_job,p_MGR ,p_sal,p_DEPTNO )
-- 2. emp TBL에  Insert_emp Procedure 
-- 3. v_job =  'MANAGER' -> v_comm  := 1000;
--              아니면                    150; 
-- 4. Insert -> emp 
-- 5. 입사일은 현재일자
    IS
        v_comm  emp.comm%TYPE;
    BEGIN
        
        IF  UPPER(p_job) LIKE ('MAN%')
            THEN    v_comm := 1000;
        ELSE        v_comm := 150;
        END IF;
        INSERT INTO emp (   empno,
                            ename,
                            job,
                            mgr,
                            sal,
                            comm,
                            deptno
                        )
                VALUES  (
                            p_empno,
                            p_ename,
                            p_job,
                            p_mgr,
                            p_sal,
                            v_comm,
                            p_deptno
                        );
        
    END insert_emp;
/

CREATE OR REPLACE PROCEDURE update_empno (
                                            p_empno IN  emp.empno%TYPE,
                                            p_job   IN  emp.job%TYPE
                                          )
--  20240705 현장Work01
-- 1.  PROCEDURE update_empno
-- 2.  parameter -> p_empno
-- 3.  해당 empno에 관련되는 사원들을(Like) job을 사람의 직업을 SALESMAN으로 업데이트
-- 4. Update -> emp 직업
-- 5.              입사일은 현재일자

    IS
        CURSOR  empnoCur
        IS  SELECT  empno
            FROM    emp
            WHERE   empno LIKE(p_empno||'%')                
        ;
        
    BEGIN
        FOR empno_list IN empnoCur
        LOOP
            UPDATE  emp
            SET     job = p_job,
                    hiredate = SYSDATE
            WHERE   empno = empno_list.empno
            ;
        END LOOP;
    
    EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('ERROR MESSAGE : ' || SQLERRM);
    
    END update_empno;
/

EXEC update_empno(3, 'CLERK');

ROLLBACK;


--    Package
--  자주 사용하는 프로그램과 로직을 모듈화
--  응용 프로그램을 쉽게 개발 할 수 있음
--  프로그램의 처리 흐름을 노출하지 않아 보안 기능이 좋음
--  프로그램에 대한 유지보수 작업이 편리
--  같은 이름의 프로시저와 함수를 여러 개 생성


-- 1.Header -->  역할 : 선언 (Interface 역할)
--     여러 PROCEDURE 선언 가능
CREATE OR REPLACE PACKAGE   emp_info AS
    PROCEDURE   all_emp_info;
    PROCEDURE   all_sal_info;
    PROCEDURE   dept_emp_info(p_deptno IN emp.deptno%TYPE);    
END emp_info;
/


--2. BODY 실제 구현
CREATE OR REPLACE PACKAGE BODY  emp_info AS
    -- 모든 사원의 사원 정보(사번, 이름, 입사일)
    -- 1. CURSOR  : emp_cursor 
    -- 2. FOR  IN
    -- 3. DBMS  -> 각각 줄 바꾸어 사번,이름,입사일 
    -- 4. 기본적  EXCEPTION  처리 
    PROCEDURE   all_emp_info
        IS
            CURSOR       empCur
            IS SELECT    empno,
                         ename,
                         TO_CHAR(hiredate, 'yyyy/mm/dd') AS hiredate
                FROM     emp
                ORDER BY hiredate
            ;
                        
        BEGIN
            dbms_output.enable;
            FOR emp_list IN empCur
            LOOP
                DBMS_OUTPUT.PUT_LINE('사원번호 : ' || emp_list.empno);
                DBMS_OUTPUT.PUT_LINE('사원이름 : ' || emp_list.ename);
                DBMS_OUTPUT.PUT_LINE('입사날자 : ' || emp_list.hiredate);
            END LOOP;
            
        EXCEPTION
            WHEN OTHERS THEN
                DBMS_OUTPUT.PUT_LINE('ERROR MESSAGE : ' || SQLERRM);
        
        END all_emp_info;
        
        
        
    PROCEDURE   all_sal_info
        IS
            CURSOR       empCur
            IS SELECT    d.dname,
                         ROUND(AVG(e.sal), 2) AS avg_sal,
                         MAX(e.sal) AS max_sal,
                         MIN(e.sal) AS min_sal
                FROM     emp e,
                         dept d
                WHERE    e.deptno = d.deptno                
                GROUP BY d.dname
            ;
                        
        BEGIN
            dbms_output.enable;
            FOR emp_list IN empCur
            LOOP
                DBMS_OUTPUT.PUT_LINE('부서이름 : ' || emp_list.dname);
                DBMS_OUTPUT.PUT_LINE('부서평균 : ' || emp_list.avg_sal);
                DBMS_OUTPUT.PUT_LINE('부서최대 : ' || emp_list.max_sal);
                DBMS_OUTPUT.PUT_LINE('부서최소 : ' || emp_list.min_sal);
                DBMS_OUTPUT.PUT_LINE('');
            END LOOP;
            
        EXCEPTION
            WHEN OTHERS THEN
                DBMS_OUTPUT.PUT_LINE('ERROR MESSAGE : ' || SQLERRM);
        
        END all_sal_info;
        
        
        
        
    PROCEDURE   dept_emp_info(p_deptno IN emp.deptno%TYPE)
        IS
            CURSOR       empCur
            IS SELECT    empno,
                         ename,
                         job,
                         TO_CHAR(hiredate,'yyyy/mm/dd') AS hiredate
                FROM     emp
                WHERE    deptno = p_deptno
                ORDER BY hiredate                
            ;
                        
        BEGIN
            dbms_output.enable;
            FOR emp_list IN empCur
            LOOP
                DBMS_OUTPUT.PUT_LINE('사원번호 : ' || emp_list.empno);
                DBMS_OUTPUT.PUT_LINE('사원이름 : ' || emp_list.ename);
                DBMS_OUTPUT.PUT_LINE('담당업무 : ' || emp_list.job);
                DBMS_OUTPUT.PUT_LINE('입사일자 : ' || emp_list.hiredate);
                DBMS_OUTPUT.PUT_LINE('');
            END LOOP;
            
        EXCEPTION
            WHEN OTHERS THEN
                DBMS_OUTPUT.PUT_LINE('ERROR MESSAGE : ' || SQLERRM);
        
        END dept_emp_info;        
        
END emp_info;
/

EXECUTE scott.emp_info.dept_emp_info('50');

