/* Exercise 1: Create a NONGAME table with the structure shown in Figure 6-28. */
CREATE TABLE NONGAME
(ITEM_NUM CHAR(4) PRIMARY KEY,
DESCRIPTION CHAR(30),
ON_HAND DECIMAL(4,0),
CATEGORY CHAR(3),
PRICE DECIMAL(6,2) );

/* Exercise 2: INSERT into the NONGAME table the item number, description, number of units on hand, category, and unit price from the ITEM table for each item that is not in category GME. */
INSERT INTO NONGAME
SELECT ITEM_NUM, DESCRIPTION, ON_HAND, CATEGORY, PRICE
FROM ITEM
WHERE CATEGORY <> 'GME';

/* Exercise 3: In the NONGAME table, change the description of item number DL51 to "Classic Train Set." */
UPDATE NONGAME
SET DESCRIPTION = 'Classic Train Set'
WHERE ITEM_NUM = 'DL51';

/* Exercise 4: In the NONGAME table, increase the price of each item in category TOY by two percent. (Hint: Multiply each price by 1.02.) */
UPDATE NONGAME
SET PRICE = PRICE * 1.02
WHERE CATEGORY = 'TOY';

/* Exercise 5: Add the following item to the NONGAME table: item number: TL92; description: Dump Truck; number of units on hand: 10; category: TOY; and price: 59.95. */
INSERT INTO NONGAME
VALUES
('TL92', 'Dump Truck', 10, 'TOY', 59.95);

/* Exercise 6: Delete every item in the NONGAME table for which the category is PZL. */
DELETE FROM NONGAME
WHERE CATEGORY = 'PZL';

/* Exercise 7: In the NONGAME table, change the category for item FD11 to null. */
UPDATE NONGAME
SET CATEGORY = NULL
WHERE ITEM_NUM = 'FD11';

/* Exercise 8: Add a column named ON_HAND_VALUE to the NONGAME table. The on-hand value is a seven-digit number with two decimal places that represents the product of the number of units on hand and the price. Then set all values of ON_HAND_VALUE to ON_HAND * PRICE. */
ALTER TABLE NONGAME
ADD ON_HAND_VALUE DECIMAL(7,2);

UPDATE NONGAME
SET ON_HAND_VALUE = ON_HAND * PRICE;

/* Exercise 9: In the NONGAME table, increase the length of the DESCRIPTION column to 40 characters. */
ALTER TABLE NONGAME
MODIFY DESCRIPTION CHAR(40);

/* Exercise 10: Remove the NONGAME table from the TAL Distributors database. */
DROP TABLE NONGAME;

/* Exercise 11: Use the internet to find the SQL command to delete a column in a table in Oracle. Write the SQL command to delete the ON_HAND_VALUE column from the NONGAME table. Be sure to cite your references. */
ALTER TABLE NONGAME
DROP COLUMN ON_HAND_VALUE;
/* Source: https://www.techonthenet.com/oracle/tables/alter_table.php */