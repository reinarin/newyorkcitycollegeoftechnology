/* Exercise 1: Create a view named MAJOR_CUSTOMER. It consists of the customer number, name, balance, credit limit, and rep number for every customer whose credit limit is $10,000 or less. */
/* a)	Write and execute the CREATE VIEW command to create the MAJOR_CUSTOMER view. */
CREATE VIEW MAJOR_CUSTOMER AS
SELECT CUSTOMER_NUM, CUSTOMER_NAME, BALANCE, CREDIT_LIMIT, REP_NUM
FROM CUSTOMER
WHERE CREDIT_LIMIT <= 10000;

SELECT * FROM MAJOR_CUSTOMER;

/* b)	Write and execute the command to retrieve the customer number and name of each customer in the MAJOR_CUSTOMER view with a balance that exceeds the credit limit. */
SELECT CUSTOMER_NUM, CUSTOMER_NAME
FROM MAJOR_CUSTOMER
WHERE BALANCE > CREDIT_LIMIT;

/* c)	Write and execute the query that the DBMS actually executes. */
SELECT CUSTOMER_NUM, CUSTOMER_NAME
FROM CUSTOMER
WHERE CREDIT_LIMIT <= 10000
AND BALANCE > CREDIT_LIMIT;

/* d)	Does updating the database through this view create any problems? If so, what are they? If not, why not? */
/* Updating the database through this view does not create any problems because if every column not included in the view can accept nulls, you can add new rows. */

/* Exercise 2: Create a view named ITEM_ORDER. It consists of the item number, description, price, order number, order date, number ordered, and quoted price of all order lines currently on file. */
/* a)	Write and execute the CREATE VIEW command to create the ITEM_ORDER view. */
CREATE VIEW ITEM_ORDER AS
SELECT ITEM.ITEM_NUM, DESCRIPTION, PRICE, ORDERS.ORDER_NUM, ORDER_DATE, NUM_ORDERED, QUOTED_PRICE
FROM ITEM, ORDERS, ORDER_LINE
WHERE ITEM.ITEM_NUM = ORDER_LINE.ITEM_NUM
AND ORDERS.ORDER_NUM = ORDER_LINE.ORDER_NUM;

SELECT * FROM ITEM_ORDER;

/* b)	Write and execute the command to retrieve the item number, description, order number, and quoted price for all orders in the ITEM_ORDER view for items with quoted prices that exceed $100. */
SELECT ITEM_NUM, DESCRIPTION, ORDER_NUM, QUOTED_PRICE
FROM ITEM_ORDER
WHERE QUOTED_PRICE > 100;

/* c)	Write and execute the query that the DBMS actually executes. */
SELECT ITEM.ITEM_NUM, DESCRIPTION, ORDERS.ORDER_NUM, QUOTED_PRICE
FROM ITEM, ORDERS, ORDER_LINE
WHERE ITEM.ITEM_NUM = ORDER_LINE.ITEM_NUM
AND ORDERS.ORDER_NUM = ORDER_LINE.ORDER_NUM
AND QUOTED_PRICE > 100;

/* d) Does updating the database through this view create any problems? If so, what are they? If not, why not? */
/* Updating the database through this view does create problems because the ITEM and ORDER_LINE tables are joined on column ITEM_NUM, and the ORDERS and ORDER_LINE tables are joined on column ORDER_NUM. ITEM_NUM is the primary key of the ITEM table. ORDER_NUM is the primary key for the ORDERS table. ITEM_NUM and ORDER_NUM are the primary keys for the ORDER_LINE table. There will be inconsistencies in the data. */

/* Exercise 3: Create a view named ORDER_TOTAL. It consists of the order number and order total for each order currently on file. (The order total is the sum of the number of units ordered multiplied by the quoted price on each order line for each order.) Sort the rows by order number. Use TOTAL_AMOUNT as the name for the order total. */
/* a)	Write and execute the CREATE VIEW command to create the ORDER_TOTAL view. */
CREATE VIEW ORDER_TOTAL (ORDER_NUM, TOTAL_AMOUNT) AS
SELECT ORDERS.ORDER_NUM, SUM(NUM_ORDERED * QUOTED_PRICE) AS TOTAL_AMOUNT
FROM ORDERS, ORDER_LINE
WHERE ORDERS.ORDER_NUM = ORDER_LINE.ORDER_NUM
GROUP BY ORDERS.ORDER_NUM
ORDER BY ORDERS.ORDER_NUM;

SELECT * FROM ORDER_TOTAL;

/* b)	Write and execute the command to retrieve the order number and order total for only those orders totaling more than $500. */
SELECT ORDER_NUM, TOTAL_AMOUNT
FROM ORDER_TOTAL
WHERE TOTAL_AMOUNT > 500;

/* c)	Write and execute the query that the DMBS actually executes. */
SELECT ORDERS.ORDER_NUM, SUM(NUM_ORDERED * QUOTED_PRICE) AS TOTAL_AMOUNT
FROM ORDERS, ORDER_LINE
WHERE ORDERS.ORDER_NUM = ORDER_LINE.ORDER_NUM
HAVING SUM(NUM_ORDERED * QUOTED_PRICE) > 500
GROUP BY ORDERS.ORDER_NUM
ORDER BY ORDERS.ORDER_NUM;

/* d)	Does updating the database through this view create any problems? If so, what are they? If not, why not? */
/* Updating the database through this view does create problems. According to the textbook, you cannot add rows to a view that includes calculations. */

/* Exercise 4: Write, but do not execute, the commands to grant the following privileges: */
/* a) User Ashton must be able to retrieve data from the ITEM table. */
GRANT SELECT ON ITEM TO ASHTON;

/* b) User Kelly and Morgan must be able to add new orders and order lines. */
GRANT INSERT ON ORDERS TO KELLY, MORGAN;
GRANT INSERT ON ORDER_LINE TO KELLY, MORGAN;

/* c) User James must be able to change the price for all items. */
GRANT UPDATE (PRICE) ON ITEM TO JAMES;

/* d) User Danielson must be able to delete customers. */
GRANT DELETE ON CUSTOMER TO DANIELSON;

/* e) All users must be able to retrieve each customer's number, name, street, city, state, and postal code. */
GRANT SELECT (CUSTOMER_NUM, CUSTOMER_NAME, STREET, CITY, STATE, POSTAL_CODE) ON CUSTOMER TO PUBLIC;

/* f) User Perez must be able to create an index on the ORDERS table. */
GRANT INDEX ON ORDERS TO PEREZ;

/* g) User Washington must be able to change the structure of the ITEM table. */
GRANT ALTER ON ITEM TO WASHINGTON;

/* h) User Grinstead must have all privileges on the ORDERS table. */
GRANT ALL ON ORDERS TO GRINSTEAD;

/* Exercise 5: Write, but do not execute, the command to revoke the privilege given to user Ashton in Exercise 4a. */
REVOKE SELECT ON ITEM TO ASHTON;

/* Exercise 6: Perform the following tasks: */
/* a)	Create an index named ITEM_INDEX1 on the ITEM_NUM column in the ORDER_LINE table. */
CREATE INDEX ITEM_INDEX1 ON ORDER_LINE(ITEM_NUM);

/* b)	Create an index named ITEM_INDEX2 on the CATEGORY column in the ITEM table. */
CREATE INDEX ITEM_INDEX2 ON ITEM(CATEGORY);

/* c) Create an index named ITEM_INDEX3 on the CATEGORY and STOREHOUSE columns in the ITEM table. */
CREATE INDEX ITEM_INDEX3 ON ITEM(CATEGORY, STOREHOUSE);

/* d) Create an index named ITEM_INDEX4 on the CATEGORY and STOREHOUSE columns in the ITEM table. List categories in descending order. */
CREATE INDEX ITEM_INDEX4 ON ITEM(CATEGORY DESC, STOREHOUSE);

/* Exercise 7: Delete the index named ITEM_INDEX3. */
DROP INDEX ITEM_INDEX3;

/* Exercise 8: Write the commands to obtain the following information from the system catalog. Do not execute these commands unless your instructor asks you to do so. */
/* a)	List every table that you own. */
SELECT TABLE_NAME
FROM DBA_TABLES
WHERE OWNER = 'REINA';

/* b)	List every column in the ITEM table and its associated data type. */
SELECT COLUMN_NAME, DATA_TYPE
FROM DBA_TAB_COLUMNS
WHERE OWNER = 'REINA'
AND TABLE_NAME = 'ITEM';

/* Exercise 9: Add the ORDER_NUM column as a foreign key in the ORDER_LINE table. */
ALTER TABLE ORDER_LINE
ADD FOREIGN KEY (ORDER_NUM) REFERENCES ORDERS;

/* Exercise 10: Ensure that the only legal values for the CREDIT_LIMIT column are 5000, 7500, 10000, and 15000. */
ALTER TABLE CUSTOMER
ADD CHECK (CREDIT_LIMIT IN (5000, 7500, 10000, 15000));

/* Exercise 11: Toys Galore currently has a credit limit of $7,500. Because Toys Galore has an excellent credit rating, TAL Distributors is increasing the company's credit limit to $10,000. If you run the SQL query in Exercise 1 after the credit limit has been increased, would Toys Galore still be included in the view? Why or why not? */
/* Toys Galore would still be included in the view because the condition of the view is to include the data of customers that have credit limits less than or equal to $10,000. If we change Toys Galore's credit from $7,500 to $10,000, it satisfies the condition. */