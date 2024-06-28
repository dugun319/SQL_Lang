SELECT      s.name,
            s.grade,
            p.name,
            p.position
FROM        student s, professor p
WHERE       s.profno(+) = p.profno(+)
ORDER BY    p.profno
;

SELECT      s.name,
            s.grade,
            p.name,
            p.position
FROM        student s, professor p
WHERE       s.profno(+) = p.profno
UNION
SELECT      s.name,
            s.grade,
            p.name,
            p.position
FROM        student s, professor p
WHERE       s.profno = p.profno(+)
;

SELECT      s.name,
            s.grade,
            s.profno,
            p.name,
            p.position
FROM        student s
    FULL OUTER JOIN professor p
       ON s.profno = p.profno
;


SELECT      c.deptno,
            c.dname,
            c.college,
            d.dname AS college_name,
            g.dname AS group_name
FROM        department c, department d, department g
WHERE       c.college = d.deptno
    AND     d.college = g.deptno
;

SELECT      c.deptno,
            c.dname,
            c.college,
            CONCAT(CONCAT(c.dname, ' is member of '), d.dname) AS member
FROM        department c, department d
WHERE       c.college = d.deptno
    AND     c.deptno > 200
;