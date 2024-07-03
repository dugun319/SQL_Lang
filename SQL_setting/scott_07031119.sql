-- ���Ѻο�
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

-- ���Ǿ�(synonym)
-- 1. ���� : �ϳ��� ��ü�� ���� �ٸ� �̸��� �����ϴ� ���
--      ���Ǿ�� ����(Alias) ������
--      ���Ǿ�� �����ͺ��̽� ��ü���� ���
--      ������ �ش� SQL ��ɹ������� ���
-- 2. ���Ǿ��� ����
--   1) ���� ���Ǿ�(private synonym) 
--      ��ü�� ���� ���� ������ �ο� ���� ����ڰ� ������ ���Ǿ�� �ش� ����ڸ� ���
--
--   2) ���� ���Ǿ�(public sysnonym)
--      ������ �ִ� ����ڰ� ������ ���Ǿ�� ������ ���
--      DBA ������ ���� ����ڸ� ���� (�� : ������ ��ųʸ�)