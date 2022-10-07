options(skip =1)
load data
infile 'C:\app\test.txt'
append
into table BUYTBL3
fields terminated by whitespace
trailing nullcols
(
USER_ID
,PROD_NAME
)