SET SERVEROUTPUT ON
CREATE OR REPLACE PROCEDURE getAllTicketPrice IS
    CURSOR ticket_cursor IS SELECT TICKET.TICKET_NUMBER, TICKET.CUST_ID , TICKET.SEAT_NO, TICKET.TOTAL_SEAT, BUS.COST
                            FROM TICKET NATURAL JOIN  BUS; 
    ticket_record ticket_cursor%ROWTYPE;

BEGIN
    OPEN ticket_cursor;
    LOOP
        FETCH ticket_cursor INTO ticket_record;
        EXIT WHEN ticket_cursor%NOTFOUND;
         
       DBMS_OUTPUT.PUT_LINE('Tikcet Number: '|| ticket_record.TICKET_NUMBER ||' Custormer Id: ' ||ticket_record.CUST_ID
                                || ' Total Price: '|| (ticket_record.TOTAL_SEAT)*(ticket_record.COST) || ' Seat No: ' || ticket_record.SEAT_NO ); 
    END LOOP;
    CLOSE ticket_cursor;

END;
/
show errors;

BEGIN
    getAllTicketPrice;
END;
/