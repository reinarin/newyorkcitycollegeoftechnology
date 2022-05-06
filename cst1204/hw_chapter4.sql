/*
Exercise 1
List the item number, description, and price for all items.
*/

SELECT ITEM_NUM, DESCRIPTION, PRICE
FROM ITEM;

/*
Exercise 2
List all rows and columns for the complete ORDERS table.
*/

SELECT *
FROM ORDERS;

/*
Exercise 3
List the names of customers with credit limits of $10,000 or more.
*/

SELECT CUSTOMER_NAME
FROM CUSTOMER
WHERE CREDIT_LIMIT >= 10000;

/*
Exercise 4
List the order number for each order placed by customer number 126 on 10/15/2015. (Hint: If you need help, use the discussion of the DATE data type in Figure 3-16 in Chapter 3.)
*/

SELECT ORDER_NUM
FROM ORDERS
WHERE CUSTOMER_NUM = '126'
AND ORDER_DATE = '10/15/2015';

/*
Exercise 5
List the number and name of each customer represented by sales rep 30 or sales rep 45.
*/

SELECT CUSTOMER_NUM, CUSTOMER_NAME
FROM CUSTOMER
WHERE REP_NUM = '30'
OR REP_NUM = '45';

/*
Exercise 6
List the item number and description of each item that is not in category PZL.
*/

SELECT ITEM_NUM, DESCRIPTION
FROM ITEM
WHERE CATEGORY <> 'PZL';

/*
Exercise 7
List the item number, description, and number of units on hand for each item that has between 20 and 40 units on hand, including both 20 and 40. Do this two ways.
*/

/* Way 1: */
SELECT ITEM_NUM, DESCRIPTION, ON_HAND
FROM ITEM
WHERE ON_HAND >= 20
AND ON_HAND <= 40;

/* Way 2: */
SELECT ITEM_NUM, DESCRIPTION, ON_HAND
FROM ITEM
WHERE ON_HAND BETWEEN 20 AND 40;

/*
Exercise 8
List the item number, description, and on-hand value (units on hand * unit price) of each item in category TOY. (On-hand value is really units on hand * cost, but there is no COST column in the ITEM table.) Assign the name ON_HAND_VALUE to the computed column.

*/
SELECT ITEM_NUM, DESCRIPTION, ON_HAND*PRICE AS ON_HAND_VALUE
FROM ITEM
WHERE CATEGORY = 'TOY';

/*
Exercise 9
List the item number, description, and on-hand value for each item whose on-hand value is at least $1,500. Assign the name ON_HAND_VALUE to the computed column.
*/

SELECT ITEM_NUM, DESCRIPTION, ON_HAND*PRICE AS ON_HAND_VALUE
FROM ITEM
WHERE (ON_HAND*PRICE) >= 1500;

/*
Exercise 10
Use the IN operator to list the item number and description of each item in category GME or PZL.
*/

SELECT ITEM_NUM, DESCRIPTION
FROM ITEM
WHERE CATEGORY IN ('GME','PZL');

/*
Exercise 11
Find the number and name of each customer whose name begins with the letter "C."
*/

SELECT CUSTOMER_NUM, CUSTOMER_NAME
FROM CUSTOMER
WHERE CUSTOMER_NAME LIKE 'C%';

/*
Exercise 12
List all details about all items. Order the output by description.
*/

SELECT *
FROM ITEM
ORDER BY DESCRIPTION;

/*
Exercise 13
List all details about all items. Order the output by item number within storehouse. (That is, order the output by storehouse and then by item number.)
*/

SELECT *
FROM ITEM
ORDER BY STOREHOUSE, ITEM_NUM;

/*
Exercise 14
How many customers have balances that are more than their credit limits?
*/

SELECT COUNT(*)
FROM CUSTOMER
WHERE BALANCE > CREDIT_LIMIT;

/*
Exercise 15
Find the total of the balances for all customers represented by sales rep 15 with balances that are less than their credit limits.
*/

SELECT SUM(BALANCE)
FROM CUSTOMER
WHERE REP_NUM = '15'
AND BALANCE < CREDIT_LIMIT;

/*
Exercise 16
List the item number, description, and on-hand value of each item whose number of units on hand is more than the average number of units on hand for all items. (Hint: Use a subquery.)
*/

SELECT ITEM_NUM, DESCRIPTION, ON_HAND*PRICE AS ON_HAND_VALUE
FROM ITEM
WHERE ON_HAND >
 (SELECT AVG(ON_HAND)
FROM ITEM);

/*
Exercise 17
What is the price of the least expensive item in the database?
*/

SELECT MIN(PRICE)
FROM ITEM;

/*
Exercise 18
What is the item number, description, and price of the least expensive item in the database? (Hint: Use a subquery.)
*/

SELECT ITEM_NUM, DESCRIPTION, PRICE
FROM ITEM
WHERE PRICE IN
 (SELECT MIN(PRICE)
FROM ITEM);

/*
Exercise 19
List the sum of the balances of all customers for each sales rep. Order and group the results by sales rep number.
*/

SELECT REP_NUM, SUM(BALANCE)
FROM CUSTOMER
GROUP BY REP_NUM
ORDER BY REP_NUM;

/*
Exercise 20
List the sum of the balances of all customers for each sales rep, but restrict the output to those sales reps for which the sum is more than $5,000. Order the results by sales rep number.
*/

SELECT REP_NUM, SUM(BALANCE)
FROM CUSTOMER
GROUP BY REP_NUM
HAVING SUM(BALANCE) > 5000
ORDER BY REP_NUM;

/*
Exercise 21
List the item number of any item with an unknown description.
*/

SELECT ITEM_NUM
FROM ITEM
WHERE DESCRIPTION IS NULL;

/*
Exercise 22
List the item number and description of all items that are in the PZL or TOY category and contain the word "Set" in the description.
*/

SELECT ITEM_NUM, DESCRIPTION
FROM ITEM
WHERE CATEGORY IN ('PZL','TOY')
AND DESCRIPTION LIKE '%Set%';

/*
Exercise 23
TAL Distributors is considering discounting the price of all items by 10 percent. List the item number, description, and discounted price for all items. Use DISCOUNTED_PRICE as the name for the computed column.
*/

SELECT ITEM_NUM, DESCRIPTION, (PRICE-0.10*PRICE) AS DISCOUNTED_PRICE
FROM ITEM;
