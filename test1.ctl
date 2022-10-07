options (skip = 1)
load data
infile 'C:\app\test1.csv'
append
into table TEST_TBL
fields terminated by ','
trailing nullcols
(
    date_time,
    ability_s,
    current_n,
    predict_n,
    residu_su,
    ratio_resi,
    residu_op,
    ratio_op
)