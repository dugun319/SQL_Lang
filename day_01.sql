SELECT user_ID AS "사용자 아이디", SUM(price*amount) AS "총 구매 금액" FROM BUYTBL GROUP BY user_ID;

SELECT CAST(AVG(amount) AS NUMBER(5, 3)) AS "평균 구매 갯수" FROM BUYTBL;

SELECT user_ID, CAST(AVG(amount) AS NUMBER(8,5)) AS "평균 구매 갯수" FROM BUYTBL GROUP BY user_ID;

SELECT user_Name, MAX(height), MIN(height) FROM USERTBL GROUP BY user_name;

SELECT user_Name, height FROM USERTBL WHERE height = (SELECT MAX(height) FROM USERTBL) or
height = (SELECT MIN(height) FROM USERTBL);

SELECT user_ID AS "사용자", SUM(price*amount) AS "총 구매액" FROM BUYTBL GROUP BY user_ID;

SELECT user_ID AS "사용자", SUM(price*amount) AS "총 구매액" 
FROM BUYTBL 
-- WHERE SUM(price*amount) > 1000
GROUP BY user_ID
HAVING SUM(price*amount) > 1000
ORDER BY SUM(price*amount) DESC;

SELECT idNum, group_Name, SUM(price*amount) AS "COST" 
FROM BUYTBL
GROUP BY ROLLUP(group_name, idnum);

SELECT group_Name, SUM(price*amount) AS "COST" 
FROM BUYTBL
GROUP BY ROLLUP(group_name);