/* Exercise 1: For each order, list the order number and order date along with the number and name of the customer that placed the order. */
SELECT ORDER_NUM, ORDER_DATE, CUSTOMER.CUSTOMER_NUM, CUSTOMER_NAME
FROM ORDERS, CUSTOMER
WHERE ORDERS.CUSTOMER_NUM = CUSTOMER.CUSTOMER_NUM;

/* Exercise 2: For each order placed on October 15, 2015, list the order number along with the number and name of the customer that placed the order. */
SELECT ORDER_NUM, CUSTOMER.CUSTOMER_NUM, CUSTOMER_NAME
FROM ORDERS, CUSTOMER
WHERE ORDERS.CUSTOMER_NUM = CUSTOMER.CUSTOMER_NUM
AND ORDER_DATE = '10/15/2015';

/* Exercise 3: For each order, list the order number, order date, item number, number of units ordered, and quoted price for each order line that makes up the order. */
SELECT ORDER_LINE.ORDER_NUM, ORDER_DATE, ITEM_NUM, NUM_ORDERED, QUOTED_PRICE
FROM ORDERS, ORDER_LINE
WHERE ORDERS.ORDER_NUM = ORDER_LINE.ORDER_NUM;

/* Exercise 4: Use the IN operator to find the number and name of each customer that placed an order on October 15, 2015. */
SELECT CUSTOMER_NUM, CUSTOMER_NAME
FROM CUSTOMER
WHERE CUSTOMER_NUM IN
 (SELECT CUSTOMER_NUM
FROM ORDERS
WHERE ORDER_DATE = '10/15/2015');

/* Exercise 5: Repeat Exercise 4, but this time use the EXISTS operator in your answer. */
SELECT CUSTOMER_NUM, CUSTOMER_NAME
FROM CUSTOMER
WHERE EXISTS
 (SELECT *
FROM ORDERS
WHERE CUSTOMER.CUSTOMER_NUM = ORDERS.CUSTOMER_NUM
AND ORDER_DATE = '10/15/2015');

/* Exercise 6: Find the number and name of each customer that did not place an order on October 15, 2015. */
SELECT CUSTOMER_NUM, CUSTOMER_NAME
FROM CUSTOMER
WHERE CUSTOMER_NUM IN
 (SELECT CUSTOMER_NUM
FROM ORDERS
WHERE ORDER_DATE != '10/15/2015');

/* Exercise 7: For each order, list the order number, order date, item number, description, and category for each item that makes up the order. */
SELECT ORDER_LINE.ORDER_NUM, ORDER_DATE, ITEM.ITEM_NUM, DESCRIPTION, CATEGORY
FROM ORDERS, ORDER_LINE, ITEM
WHERE ORDERS.ORDER_NUM = ORDER_LINE.ORDER_NUM
AND ORDER_LINE.ITEM_NUM = ITEM.ITEM_NUM;

/* Exercise 8: Repeat Exercise 7, but this time order the rows by category and then by order number. */
SELECT ORDER_LINE.ORDER_NUM, ORDER_DATE, ITEM.ITEM_NUM, DESCRIPTION, CATEGORY
FROM ORDERS, ORDER_LINE, ITEM
WHERE ORDERS.ORDER_NUM = ORDER_LINE.ORDER_NUM
AND ORDER_LINE.ITEM_NUM = ITEM.ITEM_NUM
ORDER BY CATEGORY, ORDER_NUM;

/* Exercise 9: Use a subquery to find the rep number, last name, and first name of each sales rep who represents at least one customer with a credit limit of $10,000. List each sales rep only once in the results. */
SELECT REP_NUM, LAST_NAME, FIRST_NAME
FROM REP
WHERE REP_NUM IN
 (SELECT REP_NUM
FROM CUSTOMER
WHERE CREDIT_LIMIT = 10000);

/* Exercise 10: Repeat Exercise 9, but this time do not use a subquery. */
SELECT CUSTOMER.REP_NUM, LAST_NAME, FIRST_NAME
FROM REP, CUSTOMER
WHERE REP.REP_NUM = CUSTOMER.REP_NUM
AND CREDIT_LIMIT = 10000;

/* Exercise 11: Find the number and name of each customer that currently has an order on file for a Rocking Horse. */
SELECT ORDERS.CUSTOMER_NUM, CUSTOMER_NAME
FROM CUSTOMER, ORDERS, ORDER_LINE, ITEM
WHERE CUSTOMER.CUSTOMER_NUM = ORDERS.CUSTOMER_NUM
AND ORDERS.ORDER_NUM = ORDER_LINE.ORDER_NUM
AND ORDER_LINE.ITEM_NUM = ITEM.ITEM_NUM
AND DESCRIPTION = 'Rocking Horse';

/* Exercise 12: List the item number, description, and category for each pair of items that are in the same category. (For example, one such pair would be item CD33 and item DL51, because the category for both items is TOY.) */
SELECT A.ITEM_NUM, A.DESCRIPTION, B.ITEM_NUM, B.DESCRIPTION, A.CATEGORY
FROM ITEM A, ITEM B
WHERE A.CATEGORY = B.CATEGORY
AND A.ITEM_NUM < B.ITEM_NUM;

/* Exercise 13: List the order number and order date for each order placed by the customer named Johnson's Department Store. (Hint: To enter an apostrophe (single quotation mark) within a string of characters, type two single quotation marks.) */
SELECT ORDER_NUM, ORDER_DATE
FROM ORDERS, CUSTOMER
WHERE CUSTOMER.CUSTOMER_NUM = ORDERS.CUSTOMER_NUM
AND CUSTOMER_NAME = 'Johnson''s Department Store';

/* Exercise 14: List the order number and order date for each order that contains an order line for a Fire Engine. */
SELECT ORDER_LINE.ORDER_NUM, ORDER_DATE
FROM ORDERS, ORDER_LINE, ITEM
WHERE ORDERS.ORDER_NUM = ORDER_LINE.ORDER_NUM
AND ORDER_LINE.ITEM_NUM = ITEM.ITEM_NUM
AND DESCRIPTION = 'Fire Engine';

/* Exercise 15: List the order number and order date for each order that either was placed by Almondton General Store or that contains an order line for a Fire Engine. */
SELECT ORDER_LINE.ORDER_NUM, ORDER_DATE
FROM ORDERS, ORDER_LINE, ITEM
WHERE ORDERS.ORDER_NUM = ORDER_LINE.ORDER_NUM
AND ORDER_LINE.ITEM_NUM = ITEM.ITEM_NUM
AND DESCRIPTION = 'Fire Engine'
UNION
SELECT ORDER_NUM, ORDER_DATE
FROM ORDERS, CUSTOMER
WHERE CUSTOMER.CUSTOMER_NUM = ORDERS.CUSTOMER_NUM
AND CUSTOMER_NAME = 'Almondton General Store';

/* Exercise 16: List the order number and order date for each order that was placed by Almondton General Store and that contains an order line for an order line for a Fire Engine. */
SELECT ORDER_LINE.ORDER_NUM, ORDER_DATE
FROM ORDERS, ORDER_LINE, ITEM
WHERE ORDERS.ORDER_NUM = ORDER_LINE.ORDER_NUM
AND ORDER_LINE.ITEM_NUM = ITEM.ITEM_NUM
AND DESCRIPTION = 'Fire Engine'
INTERSECT
SELECT ORDER_NUM, ORDER_DATE
FROM ORDERS, CUSTOMER
WHERE CUSTOMER.CUSTOMER_NUM = ORDERS.CUSTOMER_NUM
AND CUSTOMER_NAME = 'Almondton General Store';

/* Exercise 17: List the order number and order date for each order that was placed by Almondton General Store but that does not contain an order line for a Fire Engine. */
SELECT ORDER_NUM, ORDER_DATE
FROM ORDERS, CUSTOMER
WHERE CUSTOMER.CUSTOMER_NUM = ORDERS.CUSTOMER_NUM
AND CUSTOMER_NAME = 'Almondton General Store'
MINUS
SELECT ORDER_LINE.ORDER_NUM, ORDER_DATE
FROM ORDERS, ORDER_LINE, ITEM
WHERE ORDERS.ORDER_NUM = ORDER_LINE.ORDER_NUM
AND ORDER_LINE.ITEM_NUM = ITEM.ITEM_NUM
AND DESCRIPTION = 'Fire Engine';

/* Exercise 18: List the item number, description, unit price, and category for each item that has a unit price greater than the unit price of every item in category GME. Use either the ALL or ANY operator in your query. (Hint: Make sure you select the correct operator.) */
SELECT ITEM_NUM, DESCRIPTION, PRICE, CATEGORY
FROM ITEM
WHERE PRICE > ALL
 (SELECT PRICE
FROM ITEM
WHERE CATEGORY = 'GME');

/* Exercise 19: For each item, list the item number, description, units on hand, order number, and number of units ordered. All items should be included in the results. For those items that are currently not on order, the order number and number of units ordered should be left blank. Order the results by item number. */
SELECT ITEM.ITEM_NUM, DESCRIPTION, ON_HAND, ORDER_NUM, NUM_ORDERED
FROM ITEM
LEFT JOIN ORDER_LINE
ON ITEM.ITEM_NUM = ORDER_LINE.ITEM_NUM
ORDER BY ITEM_NUM;

/* Exercise 20: If you used ALL in Exercise 18, repeat the exercise using ANY. If you used ANY, repeat the exercise using ALL, and then run the new command. What question does the new command answer? */
SELECT ITEM_NUM, DESCRIPTION, PRICE, CATEGORY
FROM ITEM
WHERE PRICE > ANY
 (SELECT PRICE
FROM ITEM
WHERE CATEGORY = 'GME');
/* The new command answers: List the item number, description, unit price, and category for each item that has a unit price greater than the minimum unit price of any item with category GME. */

/* Exercise 21: For each rep, list the customer number, customer name, rep last name, and rep first name. All reps should be included in the results. Order the results by rep number. There are two SQL commands for this query that will list the same results. Create and run each SQL command. */
/* Way 1: */
SELECT CUSTOMER_NUM, CUSTOMER_NAME, LAST_NAME, FIRST_NAME
FROM REP
LEFT JOIN CUSTOMER
ON CUSTOMER.REP_NUM = REP.REP_NUM
ORDER BY REP.REP_NUM;

/* Way 2: */
SELECT CUSTOMER_NUM, CUSTOMER_NAME, LAST_NAME, FIRST_NAME
FROM CUSTOMER
RIGHT JOIN REP
ON CUSTOMER.REP_NUM = REP.REP_NUM
ORDER BY REP.REP_NUM;

/* Way 3: */
SELECT CUSTOMER.CUSTOMER_NUM, CUSTOMER.CUSTOMER_NAME, REP.LAST_NAME, REP.FIRST_NAME
FROM CUSTOMER, REP
WHERE CUSTOMER.REP_NUM(+) = REP.REP_NUM
ORDER BY REP.REP_NUM;
