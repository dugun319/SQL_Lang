import cx_Oracle 

sql =   """
        select ID, USER_NAME, AGE, NATION 
        from TESTTBL2
        """
conn = cx_Oracle.connect('c##sqldb/1234@localhost:1521/xe')
# conn = cx_Oracle.connect('user_id/password@host_name:port/sid')
cs = conn.cursor()
rs = cs.execute(sql)

col1 = []
col2 = []
col3 = []
col4 = []

for record in rs:
    col1.append(record[0])
    col2.append(record[1])
    col3.append(record[2])
    col4.append(record[3])
    
print("col1 : ", col1)
print("col2 : ", col2)
print("col3 : ", col3)
print("col4 : ", col4)

