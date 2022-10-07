WITH cte_usertbl(addr, max_height)
AS
(
    SELECT address, MAX(height) FROM usertbl GROUP BY address
    )
SELECT AVG(max_height) AS "지역별 최고키 평균" FROM cte_usertbl;

SELECT first_name, last_name, email, phone_number FROM employees;

SELECT user_id AS "사용자", SUM(price * amount) AS "총 구매액" FROM buytbl GROUP by user_ID
ORDER by SUM(price * amount) DESC;

WITH abc(user_ID, total)
AS
(SELECT user_ID, SUM(price * amount) FROM buytbl GROUP BY user_ID)
SELECT * FROM abc ORDER BY total DESC;


CREATE SEQUENCE idSEQ
    START WITH 1
    INCREMENT BY 1;


 CREATE TABLE testTBL2
(   id NUMBER(4),
    user_name NCHAR(3),
    age NUMBER(2),
    nation NCHAR(4) DEFAULT '대한민국'
    );

INSERT INTO TESTTBL2 VALUES (idseq.nextval, '유나', 25, DEFAULT);
INSERT INTO TESTTBL2 (id, user_name, age, nation) VALUES (idseq.nextval, '혜정', 24, '영국');
INSERT INTO TESTTBL2 (id, user_name, age, nation) VALUES (11, '쯔위', 18, '대만');
ALTER SEQUENCE idSEQ
    INCREMENT BY 10;

INSERT INTO TESTTBL2 (id, user_name, age, nation) VALUES (idseq.nextval, '미나', 21, '일본');    
    
ALTER SEQUENCE idSEQ
    INCREMENT BY 1;
    
INSERT INTO TESTTBL2 (id, user_name, age, nation) VALUES (idseq.nextval, '수지', 24, DEFAULT);
INSERT INTO TESTTBL2 (id, user_name, age, nation) VALUES (3, '정아', 44, DEFAULT);


SELECT 100*100 FROM DUAL;



CREATE TABLE testtbl3(id number(3));
CREATE SEQUENCE cycleSEQ
    START WITH 100
    INCREMENT BY 100
    MINVALUE 100
    MAXVALUE 300
    CYCLE
    NOCACHE;

INSERT INTO testtbl3 VALUES(cycleSEQ.NEXTVAL);
INSERT INTO testtbl3 VALUES(cycleSEQ.NEXTVAL);
INSERT INTO testtbl3 VALUES(cycleSEQ.NEXTVAL);
INSERT INTO testtbl3 VALUES(cycleSEQ.NEXTVAL);
INSERT INTO testtbl3 VALUES(cycleSEQ.NEXTVAL);
INSERT INTO testtbl3 VALUES(cycleSEQ.NEXTVAL);
INSERT INTO testtbl3 VALUES(cycleSEQ.NEXTVAL);
INSERT INTO testtbl3 VALUES(cycleSEQ.NEXTVAL);
INSERT INTO testtbl3 VALUES(cycleSEQ.NEXTVAL);


CREATE TABLE testtbl4
(   emp_ID NUMBER(6),
    first_name VARCHAR2(20),
    last_name VARCHAR2(25),
    phone VARCHAR2(20)
    );

INSERT INTO testtbl4
    SELECT EMPLOYEE_ID, 
    FIRST_NAME,
    LAST_NAME,
    PHONE_NUMBER
    FROM HR.employees;
    