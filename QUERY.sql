-- LAB 3
SELECT
    *
FROM
    TICKET;

SELECT
    NUMBER_PLATE,
    COST
FROM
    BUS
WHERE
    COST >= 500
    AND COST <= 1000;

-- __QUERY__ : DISTINCT Cost between 500 to 1000
SELECT
    DISTINCT(COST) AS distinct_cost,
    NUMBER_PLATE
FROM
    BUS
WHERE
    COST >= 500
    AND COST <= 1000;

-- ______LIKE (SUB STRING MATCH)_______ --
-- __QUERY__ : select start point a bus where start_point contains LA as a sub string (COMILLA)
SELECT
    START_POINT
FROM
    SCHEDULE
WHERE
    START_POINT LIKE '%LA%';

-- DESC OF COST --
SELECT
    NUMBER_PLATE,
    COST
FROM
    BUS
ORDER BY
    COST DESC;

-- CALCULTE ALL TICKET PRICE BY COUNT
-- AT FIRST GET TICKET PRICE FROM CO-RESPONDING BUS
-- ///// TO DOOOO // -----------

-- __QUERY__ : SELECT MAX COST GROPU BY BUS TYPE (AC/NON AC) --
SELECT
    MAX(COST),
    BUS_TYPE
FROM
    BUS
GROUP BY
    BUS_TYPE;

-- _________ HAVING  ________ --
-- __QUERY__ : select route id and sum of bus cost on that route where sum of bus cost is greater than 1000 and less then 2000 --
SELECT
    ROUTE_ID,
    SUM(COST)
FROM
    BUS
GROUP BY
    ROUTE_ID
HAVING
    SUM(COST) > 1000
    AND SUM(COST) < 2000;

-- _________ HAVING  ________ --
-- ___ QUERY ___ : select route ids from bus which has minimum capacity greater than equal 38
SELECT
    ROUTE_ID
FROM
    BUS
GROUP BY
    ROUTE_ID
HAVING
    MIN(CAPACITY) >= 38;


-- ________________ NESTED QUERY ________________ --
-- __QUERY__ : FIND PHONE AND CUST_ID OF CUSTOMERS WHOSE TICKET START POINT IS FROM DHAKA
SELECT  C.PHONE, C.CUST_ID  
FROM  CUSTOMER C 
WHERE C.PHONE IN (
    SELECT C.PHONE
    FROM CUSTOMER C, TICKET T
    WHERE C.CUST_ID = T.CUST_ID AND T.START_POINT = 'DHAKA'
);

-- ________________ UNION (DISTINCT) QUERY ________________ --
-- __QUERY__ : Select distinct bus and route_id where capacity > 40 or capacity less then 40 
SELECT BUS_TYPE, ROUTE_ID
FROM BUS
WHERE  CAPACITY < 40  
UNION
SELECT BUS_TYPE, ROUTE_ID
FROM BUS
WHERE  CAPACITY > 40  ;

-- ________________ UNION ALL (DISTINCT) QUERY ________________ --
-- __QUERY__ : Select all bus and route_id where capacity > 40 or capacity less then 40 
SELECT BUS_TYPE, ROUTE_ID
FROM BUS
WHERE  CAPACITY < 40  
UNION ALL
SELECT BUS_TYPE, ROUTE_ID
FROM BUS
WHERE  CAPACITY > 40  ;

-- ________________ INTERSECT QUERY ________________ --
-- __QUERY__ : Select bus and route_id where capacity > 40 AND capacity less then 40 
SELECT BUS_TYPE, ROUTE_ID
FROM BUS
WHERE  CAPACITY < 40  
INTERSECT
SELECT BUS_TYPE, ROUTE_ID
FROM BUS
WHERE  CAPACITY > 40  ;

-- ________________ MINUS QUERY ________________ --
-- __QUERY__ : Select bus and route_id where capacity > 40 minus capacity less then 40 
SELECT BUS_TYPE, ROUTE_ID
FROM BUS
WHERE  CAPACITY < 40  
MINUS
SELECT BUS_TYPE, ROUTE_ID
FROM BUS
WHERE  CAPACITY > 40  ;



