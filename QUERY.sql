SET LINESIZE 200;

SELECT  *
FROM TICKET;

------------------

SELECT  NUMBER_PLATE
       ,COST 
FROM BUS
WHERE COST >= 500
AND COST <= 1000;


-----------------------------------------------
-- __QUERY__ : DISTINCT Cost between 500 to 1000
SELECT  DISTINCT(COST) AS distinct_cost
       ,NUMBER_PLATE
FROM BUS
WHERE COST >= 500
AND COST <= 1000;


-- ______LIKE (SUB STRING MATCH)_______ --
-- __QUERY__ : select start point a bus where start_point contains LA as a sub string (COMILLA)
SELECT  START_POINT
FROM SCHEDULE
WHERE START_POINT LIKE '%LA%';
-- DESC OF COST --
SELECT  NUMBER_PLATE
       ,COST
FROM BUS
ORDER BY COST DESC;

-- CALCULTE ALL TICKET PRICE BY COUNT
-- AT FIRST GET TICKET PRICE FROM CO-RESPONDING BUS
-- ///// TO DOOOO // -----------
-- __QUERY__ : SELECT MAX COST GROPU BY BUS TYPE (AC/NON AC) --
SELECT  MAX(COST)
       ,BUS_TYPE
FROM BUS
GROUP BY  BUS_TYPE;

-- _________ HAVING  ________ --
-- __QUERY__ : select route id and sum of bus cost on that route where sum of bus cost is greater than 1000 and less then 2000 --
SELECT  ROUTE_ID
       ,SUM(COST)
FROM BUS
GROUP BY  ROUTE_ID
HAVING SUM(COST) > 1000 AND SUM(COST) < 2000;

-- _________ HAVING  ________ --
-- ___ QUERY ___ : select route ids from bus which has minimum capacity greater than equal 38
SELECT  ROUTE_ID
FROM BUS
GROUP BY  ROUTE_ID
HAVING MIN(CAPACITY) >= 38;

-- ________________ NESTED QUERY ________________ --
-- __QUERY__ : FIND PHONE AND CUST_ID OF CUSTOMERS WHOSE TICKET START POINT IS FROM DHAKA
SELECT  C.PHONE ,C.CUST_ID
FROM CUSTOMER C
WHERE C.PHONE IN (  SELECT C.PHONE 
                    FROM CUSTOMER C, TICKET T 
                    WHERE C.CUST_ID = T.CUST_ID AND T.START_POINT = 'DHAKA' );

-- ________________ UNION (DISTINCT) QUERY ________________ --
-- __QUERY__ : Select distinct bus and route_id where capacity > 40 or capacity less then 40
SELECT  BUS_TYPE
       ,ROUTE_ID
FROM BUS
WHERE CAPACITY < 40
UNION
SELECT  BUS_TYPE
       ,ROUTE_ID
FROM BUS
WHERE CAPACITY > 40;

-- ________________ UNION ALL (DISTINCT) QUERY ________________ --
-- __QUERY__ : Select all bus and route_id where capacity > 40 or capacity less then 40
SELECT  BUS_TYPE
       ,ROUTE_ID
FROM BUS
WHERE CAPACITY < 40 
UNION ALL
SELECT  BUS_TYPE
       ,ROUTE_ID
FROM BUS
WHERE CAPACITY > 40;

-- ________________ INTERSECT QUERY ________________ --
-- __QUERY__ : Select bus and route_id where capacity > 40 AND capacity less then 40
SELECT  BUS_TYPE
       ,ROUTE_ID
FROM BUS
WHERE CAPACITY < 40 
INTERSECT
SELECT  BUS_TYPE
       ,ROUTE_ID
FROM BUS
WHERE CAPACITY > 40;

-- ________________ MINUS QUERY ________________ --
-- __QUERY__ : Select bus and route_id where capacity > 40 minus capacity less then 40
SELECT  BUS_TYPE
       ,ROUTE_ID
FROM BUS
WHERE CAPACITY < 40
MINUS
SELECT  BUS_TYPE
       ,ROUTE_ID
FROM BUS
WHERE CAPACITY > 40;

-- ________________ NATURAL JOIN QUERY ________________ --
-- __QUERY__ : Select bus number_plate, start and destination
SELECT  NUMBER_PLATE
       ,START_POINT
       ,DESTINATION
FROM BUS NATURAL
JOIN SCHEDULE;

-- ________________ CROSS JOIN QUERY ________________ --
-- __QUERY__ : Select tikcet number and customer name
SELECT  TICKET_NUMBER
       ,USER_NAME
FROM TICKET T CROSS JOIN CUSTOMER C CROSS JOIN USERS U
WHERE T.CUST_ID = C.CUST_ID
AND U.USERS_ID = C.USERS_ID;

-- ________________ LEFT OUTER JOIN QUERY ________________ --
-- __QUERY__ : Select tikcet number and route_id with left outer join
SELECT  B.NUMBER_PLATE
       ,S.ROUTE_ID
       ,S.START_POINT
       ,S.DESTINATION
FROM BUS B LEFT OUTER JOIN SCHEDULE S
ON B.ROUTE_ID = S.ROUTE_ID;

-- ________________ RIGHT OUTER JOIN QUERY ________________ --
-- __QUERY__ : Select tikcet number and route_id with left outer join
SELECT  B.NUMBER_PLATE
       ,S.ROUTE_ID
       ,S.START_POINT
       ,S.DESTINATION
FROM BUS B RIGHT OUTER JOIN SCHEDULE S
ON B.ROUTE_ID = S.ROUTE_ID;

-- ________________ FULL OUTER JOIN QUERY ________________ --
SELECT  B.NUMBER_PLATE
       ,S.ROUTE_ID
       ,S.START_POINT
       ,S.DESTINATION
FROM BUS B FULL OUTER JOIN SCHEDULE S
ON B.ROUTE_ID = S.ROUTE_ID;

-- ________________ PL SQL  ________________ --
-- __QUERY__ : find total cost of ticket number 1007
SET SERVEROUTPUT ON 
DECLARE 
seats TICKET.TOTAL_SEAT %TYPE; cost BUS.COST%TYPE;

BEGIN
SELECT  TICKET.TOTAL_SEAT ,BUS.COST INTO seats ,cost
FROM    BUS NATURAL JOIN TICKET
WHERE   TICKET.TICKET_NUMBER = 1007;

DBMS_OUTPUT.PUT_LINE('Total Cost: ' || cost * seats);

END;

/ 

-- ________________ **PL SQL**  ________________ --
-- __QUERY__ : find Maximum total ticket price of all sold tickets
SET SERVEROUTPUT ON 
DECLARE 
seats TICKET.TOTAL_SEAT%TYPE;
cost BUS.COST%TYPE;

BEGIN
SELECT
    MAX(TICKET.TOTAL_SEAT * BUS.COST) INTO cost
FROM BUS NATURAL JOIN TICKET;

DBMS_OUTPUT.PUT_LINE('Total Cost: ' || cost);

END;

/

 -- ________________ **PL SQL**  ________________ --
-- ________________ *** PROCEDURE and CURSOR ***  ________________ --
-- __QUERY__ : find all ticket price
SET SERVEROUTPUT ON 

CREATE OR REPLACE PROCEDURE getAllTicketPrice IS 

CURSOR ticket_cursor IS SELECT
                            TICKET.TICKET_NUMBER,
                            TICKET.CUST_ID,
                            TICKET.SEAT_NO,
                            TICKET.TOTAL_SEAT,
                            BUS.COST
                        FROM
                            TICKET NATURAL JOIN BUS;

ticket_record ticket_cursor%ROWTYPE;

BEGIN 
    OPEN ticket_cursor;

LOOP 
    FETCH ticket_cursor INTO ticket_record;
    EXIT WHEN ticket_cursor%NOTFOUND;
    DBMS_OUTPUT.PUT_LINE(
          'Tikcet Number: ' || ticket_record.TICKET_NUMBER || ' Custormer Id: ' || ticket_record.CUST_ID || ' Total Price: ' || (ticket_record.TOTAL_SEAT) * (ticket_record.COST) || ' Seat No: ' || ticket_record.SEAT_NO
        );

END LOOP;

CLOSE ticket_cursor;

END;

/ 
show errors;

BEGIN 

    getAllTicketPrice;

END;

/
 -- ________________ **PL SQL**  ________________ --
-- ________________ *** FUNCTION ***  ________________ --
-- __QUERY__ : get user name by customer id
SET SERVEROUTPUT ON 
CREATE OR REPLACE FUNCTION getUserName (custid IN CUSTOMER.CUST_ID%TYPE) RETURN USERS.USER_NAME%TYPE IS 

userName USERS.USER_NAME%TYPE;

BEGIN
SELECT
    USER_NAME INTO userName
FROM USERS JOIN CUSTOMER ON CUSTOMER.CUST_ID = custid
    AND CUSTOMER.USERS_ID = USERS.USERS_ID;
RETURN userName;

END getUserName;

/
SHOW errors;

BEGIN 

    DBMS_OUTPUT.PUT_LINE('User name is: ' || getUserName(260));

END;

/ 

 
-- ************************************* TRIGGER ************************************ --
-- TRIGGER when inserting new ticket calculte ticket_number and total cost;

ALTER TABLE TICKET 
    DROP COLUMN TOTAL_COST;

 ALTER TABLE TICKET
    ADD TOTAL_COST INTEGER ; 



CREATE OR REPLACE TRIGGER addNewTicket BEFORE INSERT ON TICKET
FOR EACH ROW
 

BEGIN
    
    SELECT  B.COST*:NEW.TOTAL_SEAT INTO :NEW.TOTAL_COST
    FROM BUS B
    WHERE B.NUMBER_PLATE = :NEW.NUMBER_PLATE;

    SELECT MAX(TICKET_NUMBER)+1 INTO :NEW.TICKET_NUMBER
    FROM TICKET ;


END;
/ 
SHOW ERRORS;
INSERT INTO TICKET VALUES(NULL ,3,910,'34 12','RAJSHAHI','KHULNA','04-OCT-2021','12-OCT-2021',91742390,NULL);


SELECT * FROM TICKET;
ROLLBACK;
 

 



-- ************************************* DATE ************************************ --
--  

SELECT TICKET_NUMBER
FROM TICKET
WHERE JOURNEY_DATE-BOOKING_DATE <=1 ;

SELECT EXTRACT(YEAR FROM JOURNEY_DATE) AS JOURNEY_YEAR
FROM TICKET;