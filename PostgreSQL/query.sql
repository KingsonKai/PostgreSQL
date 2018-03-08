Q1：
SELECT data->>'ORDERKEY' AS key,data->>'TOTALPRICE' AS totalprice
FROM Orders
WHERE data->>'ORDERPRIORITY'='2-HIGH' AND data->>'ORDERDATE' = '1994-09-29'
Q2：
SELECT data->>'ORDERPRIORITY' AS priority,COUNT(*) AS sum
FROM Orders
WHERE data->>'ORDERDATE' > '1998-01-01'
GROUP BY priority
ORDER BY priority desc
Q3：
SELECT l.data->>'SHIPMODE' AS mode, SUM(cast(l.data->>'QUANTITY' AS numeric)) AS total
FROM Lineitem l,Orders o
WHERE o.data->>'ORDERDATE'>'1998-10-31' AND o.data->>'ORDERDATE'<'1998-12-01' AND l.data->>'ORDERKEY'=o.data->>'ORDERKEY'
GROUP BY mode
HAVING l.data->>'SHIPMODE'!='MAIL'
Q4：
SELECT MAX(cast(l.data->>'EXTENDEDPRICE' AS numeric)) AS maxextendprice
FROM Lineitem l,Orders o
WHERE o.data->>'ORDERDATE'<'1997-01-01' AND o.data->>'ORDERKEY'=l.data->>'ORDERKEY'
Q5：
SELECT p.data->>'NAME' AS name, p.data->>'SIZE' AS size
FROM Part p,Partsupp pa
WHERE p.data->>'PARTKEY'=pa.data->>'PARTKEY'
		AND pa.data->>'SUPPKEY'='39'
Q6：

SELECT p.data->>'PARTKEY' AS key,
		p.data->>'NAME' AS name,
		p.data->>'BRAND' AS brand,
		SUM(cast(l.data->>'QUANTITY' AS numeric)) AS totalquantity
FROM Part p,Lineitem l
WHERE p.data->>'PARTKEY'=l.data->>'PARTKEY'
		AND l.data->>'SHIPDATE'<='1995-12-12'
		AND l.data->>'SHIPDATE'>='1993-01-01'
GROUP BY key,name,brand
ORDER BY totalquantity desc limit 3
Q7：
SELECT c.data->>'CUSTKEY' AS key,c.data->>'NAME' AS name,
		c.data->>'ADDRESS' AS address,c.data->>'PHONE' AS phone,
		COUNT(*) AS totalorders
FROM Customer c,Orders o,Lineitem l
WHERE c.data->>'CUSTKEY'=o.data->>'CUSTKEY'
		AND o.data->>'ORDERKEY'=l.data->>'ORDERKEY'
		AND o.data->>'ORDERDATE'<='1996-12-31'
		AND o.data->>'ORDERDATE'>='1996-01-01'
		AND l.data->>'SHIPMODE'='AIR'
GROUP BY key,name,address,phone
HAVING COUNT(*)>=2