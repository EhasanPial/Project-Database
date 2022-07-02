---------------------------------
DROP TABLE TICKET;

DROP TABLE BUS;

DROP TABLE SCHEDULE;

----------------------------------
DROP TABLE ADMIN;

DROP TABLE DRIVER;

DROP TABLE CUSTOMER;

DROP TABLE CONDUCTOR;

DROP TABLE USERS;

CREATE TABLE USERS (
    USERS_ID INT NOT NULL,
    USERS_EMAIL VARCHAR2(20),
    USERS_PASS INT,
    USER_NAME VARCHAR(15),
    PRIMARY KEY(USERS_ID)
);

CREATE TABLE ADMIN (
    ADMIN_ID INT NOT NULL,
    USERS_ID INT,
    PRIMARY KEY(ADMIN_ID),
    FOREIGN KEY(USERS_ID) REFERENCES USERS (USERS_ID) ON DELETE CASCADE
);

CREATE TABLE CUSTOMER (
    CUST_ID INT NOT NULL,
    PHONE NUMBER,
    USERS_ID INT,
    PRIMARY KEY(CUST_ID),
    FOREIGN KEY(USERS_ID) REFERENCES USERS (USERS_ID) ON DELETE CASCADE
);

CREATE TABLE DRIVER (
    DRIVER_ID INT NOT NULL,
    PHONE NUMBER,
    USERS_ID INT,
    PRIMARY KEY (DRIVER_ID),
    FOREIGN KEY(USERS_ID) REFERENCES USERS (USERS_ID) ON DELETE CASCADE
);

CREATE TABLE CONDUCTOR (
    CONDUCTOR_ID INT NOT NULL,
    PHONE NUMBER,
    USERS_ID INT,
    PRIMARY KEY (CONDUCTOR_ID),
    FOREIGN KEY(USERS_ID) REFERENCES USERS (USERS_ID) ON DELETE CASCADE
);

CREATE TABLE SCHEDULE (
    ROUTE_ID INT NOT NULL,
    STOPPPAGES VARCHAR(20),
    START_POINT VARCHAR(15),
    DESTINATION VARCHAR(15),
    PRIMARY KEY (ROUTE_ID)
);

CREATE TABLE BUS (
    NUMBER_PLATE INT NOT NULL,
    BUS_TYPE VARCHAR(15),
    CAPACITY INT,
    COST NUMBER(5, 2),
    ROUTE_ID INT,
    CONDUCTOR_ID INT,
    DRIVER_ID INT,
    PRIMARY KEY (NUMBER_PLATE),
    FOREIGN KEY(ROUTE_ID) REFERENCES SCHEDULE (ROUTE_ID) ON DELETE CASCADE,
    FOREIGN KEY(CONDUCTOR_ID) REFERENCES CONDUCTOR (CONDUCTOR_ID) ON DELETE CASCADE,
    FOREIGN KEY(DRIVER_ID) REFERENCES DRIVER (DRIVER_ID) ON DELETE CASCADE
);

CREATE TABLE TICKET (
    TICKET_NUMBER INT NOT NULL,
    SEAT_TYPE VARCHAR2(15),
    TOTAL_SEAT NUMBER(2),
    CUST_ID INT,
    SEAT_NO VARCHAR(15),
    START_POINT VARCHAR(15),
    DESTINATION VARCHAR(15),
    TOTAL_PRICE NUMBER(5, 2),
    BOOKING_DATE DATE,
    JOURNEY_DATE DATE,
    NUMBER_PLATE INT,
    PRIMARY KEY (TICKET_NUMBER),
    FOREIGN KEY(CUST_ID) REFERENCES CUSTOMER (CUST_ID) ON DELETE CASCADE
);