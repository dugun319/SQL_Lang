CREATE USER         user_test_01
    IDENTIFIED BY   tiger
;

CREATE USER         user_test_02
    IDENTIFIED BY   tiger
;

CREATE USER         user_test_03
    IDENTIFIED BY   tiger
;

CREATE USER         user_test_04
    IDENTIFIED BY   tiger
;

-- GRANT CREATE SESSION TO -> ���� ���Ѹ� �ο�
GRANT CREATE SESSION TO user_test_01;

GRANT CREATE SESSION, CREATE TABLE, CREATE VIEW TO user_test_02;