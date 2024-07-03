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

-- 동의어(synonym)
-- 1. 정의 : 하나의 객체에 대해 다른 이름을 정의하는 방법
--      동의어와 별명(Alias) 차이점
--      동의어는 데이터베이스 전체에서 사용
--      별명은 해당 SQL 명령문에서만 사용
-- 2. 동의어의 종류
--   1) 전용 동의어(private synonym) 
--      객체에 대한 접근 권한을 부여 받은 사용자가 정의한 동의어로 해당 사용자만 사용
--
--   2) 공용 동의어(public sysnonym)
--      권한을 주는 사용자가 정의한 동의어로 누구나 사용
--      DBA 권한을 가진 사용자만 생성 (예 : 데이터 딕셔너리)