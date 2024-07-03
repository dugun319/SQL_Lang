-- 권한부여
GRANT SELECT ON scott.student
    TO          user_test_04
;

GRANT SELECT ON scott.emp
    TO          user_test_02
    WITH GRANT OPTION
;

GRANT SELECT ON scott.stud_101
    TO          user_test_02
;

GRANT SELECT ON scott.job3
    TO          user_test_02
    WITH GRANT OPTION
;

REVOKE SELECT ON scott.job3
    FROM         user_test_02
;


CREATE SYNONYM privateTBL for system.privateTBL;

SELECT  *
FROM    system.privateTBL
;

SELECT  *
FROM    privateTBL
;

DROP SYNONYM privateTBL;

------------------------------------

CREATE OR REPLACE FUNCTION  calTax (money IN NUMBER)
RETURN NUMBER
    IS
        v_tax   NUMBER;
    BEGIN
        v_tax := money * 0.07;
        RETURN (v_tax);
    END;
/

SELECT  calTax(100)
FROM    dual
;


CREATE OR REPLACE PROCEDURE insert_emp (
                                        p_empno     IN emp.empno%TYPE,
                                        p_ename     IN emp.ename%TYPE,
                                        p_job       IN emp.job%TYPE,
                                        p_mgr       IN emp.mgr%TYPE,
                                        p_sal       IN emp.sal%TYPE,
                                        p_deptno    IN emp.deptno%TYPE
                                        )
    IS
        v_comm  emp.comm%TYPE;
    BEGIN
        IF          p_job = 'MANAGER'
            THEN    v_comm := 1000;
            ELSE    v_comm := 150;
        END IF;
        INSERT INTO emp(
                        empno,
                        ename,
                        job,
                        mgr,
                        hiredate,
                        sal,
                        comm,
                        deptno
                        )
            VALUES     (
                        p_empno,
                        p_ename,
                        p_job,
                        p_mgr,
                        SYSDATE,
                        p_sal,
                        v_comm,
                        p_deptno
                        );
        COMMIT;
    END;
/
        
        