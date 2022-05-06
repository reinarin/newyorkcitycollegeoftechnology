/* Exercise 1: Create a table named SALES_REP. The table has the same structure as the REP table shown in Figure 3-11 except the LAST_NAME column should use the VARCHAR data type and the COMMISSION and RATE columns should use the NUMBER data type. Execute the command to describe the layout and characteristics of the SALES_REP table. */
CREATE TABLE SALES_REP
(REP_NUM CHAR(2) PRIMARY KEY,
LAST_NAME VARCHAR(15),
FIRST_NAME CHAR(15),
STREET CHAR(15),
CITY CHAR(15),
STATE CHAR(2),
POSTAL_CODE CHAR(5),
COMMISSION NUMBER(7,2),
RATE NUMBER(3,2) );

DESCRIBE SALES_REP;

/* Exercise 2: Add the following row to the SALES_REP table: rep number: 35; last name: Lim; first name: Louise; street: 535 Vincent Dr.; city: Grove; state: CA; postal code: 90092; commission: 0.00; and rate: 0.05. Display the contents of the SALES_REP table. */
INSERT INTO SALES_REP
VALUES('35','Lim','Louise','535 Vincent Dr.','Grove','CA','90092',0.00,0.35);

/* Exercise 3Delete the SALES_REP table.
*/
DROP TABLE SALES_REP;

/* Exercise 5: Confirm that you have added all data correctly by describing each table and comparing the results to Figures 3-11, 3-30, 3-32, 3-34, and 3-36. */
DESCRIBE REP;
DESCRIBE CUSTOMER;
DESCRIBE ORDERS;
DESCRIBE ITEM;
DESCRIBE ORDER_LINE;

/* Exercise 6: Confirm that you have added all data correctly by viewing the data in each table and comparing the results to Figure 2-1 in Chapter 2. */
SELECT * FROM REP;
SELECT * FROM CUSTOMER;
SELECT * FROM ORDERS;
SELECT * FROM ITEM;
SELECT * FROM ORDER_LINE;

/* Exercise 7: Review the data for the ITEM table in Figure 2-1 in Chapter 2 and then review the data types used to create the ITEM table in Figure 3-34. Suggest alternate data types for the DESCRIPTION, ON_HAND, AND STOREHOUSE fields and explain your recommendations. */
/*
Alternate data type for:
DESCRIPTION	VARCHAR(n)    stores actual character string
ON_HAND                   NUMBER(p,q)	
STOREHOUSE                INT, SMALLINT	INT stores integers, SMALLINT stores integers and uses less space than INT data type
*/