/* Exercise 1: List the item number and description for all items. The descriptions should appear in uppercase letters. */
SELECT ITEM_NUM, UPPER(DESCRIPTION)
FROM ITEM;

/* Exercise 2: List the customer number and name for all customers located in the city of Grove. Your query should ignore case. For example, a customer with the city Grove should be included as should customers whose city is GROVE, grove, GrOvE, and so on. */
SELECT CUSTOMER_NUM, CUSTOMER_NAME
FROM CUSTOMER
WHERE UPPER(CITY) = 'GROVE';

/* Exercise 3: List the customer number, name, and balance for all customers. The balance should be rounded to the nearest dollar. */
SELECT CUSTOMER_NUM, CUSTOMER_NAME, ROUND(BALANCE,0)
FROM CUSTOMER;

/* Exercise 4: TAL Distributors is running a promotion that is valid for up to 20 days after an order is placed. List the order number, customer number, customer name, and the promotion date for each order. The promotion date is 20 days after the order was placed. */
SELECT ORDER_NUM, ORDERS.CUSTOMER_NUM, CUSTOMER_NAME, ORDER_DATE+20 AS PROMOTION_DATE
FROM ORDERS, CUSTOMER
WHERE CUSTOMER.CUSTOMER_NUM = ORDERS.CUSTOMER_NUM;

/* Exercise 5: Write PL/SQL or T-SQL procedures to accomplish the following tasks: */
/* a) Obtain the name and credit limit of the customer whose number currently is stored in I_CUSTOMER_NUM. Place these values in the variables I_CUSTOMER_NAME and I_CREDIT_LIMIT, respectively. Output the contents of I_CUSTOMER_NAME and I_CREDIT_LIMIT. */
CREATE OR REPLACE PROCEDURE DISP_EX05A (I_CUSTOMER_NUM IN CUSTOMER.CUSTOMER_NUM%TYPE) AS
    I_CUSTOMER_NAME    CUSTOMER.CUSTOMER_NAME%TYPE;
    I_CREDIT_LIMIT    CUSTOMER.CREDIT_LIMIT%TYPE;
    
    BEGIN
    SELECT CUSTOMER_NAME, CREDIT_LIMIT
    INTO I_CUSTOMER_NAME, I_CREDIT_LIMIT
    FROM CUSTOMER
    WHERE CUSTOMER_NUM = I_CUSTOMER_NUM;
    
    DBMS_OUTPUT.PUT_LINE(RTRIM(I_CUSTOMER_NAME)||', Credit Limit: $'||RTRIM(I_CREDIT_LIMIT));
    
    END;
    /

BEGIN
DISP_EX05A('126');
END;
/

/* b) Obtain the order date, customer number, and name for the order whose number currently is stored in I_ORDER_NUM. Place these values in the variables I_ORDER_DATE, I_CUSTOMER_NUM, and I_CUSTOMER_NAME, respectively. Output the contents of I_ORDER_DATE, I_CUSTOMER_NUM, and I_CUSTOMER_NAME. */
CREATE OR REPLACE PROCEDURE DISP_EX05B (I_ORDER_NUM IN ORDERS.ORDER_NUM%TYPE) AS
    I_ORDER_DATE    ORDERS.ORDER_DATE%TYPE;
    I_CUSTOMER_NUM    CUSTOMER.CUSTOMER_NUM%TYPE;
    I_CUSTOMER_NAME    CUSTOMER.CUSTOMER_NAME%TYPE;
    
    BEGIN
    SELECT ORDER_DATE, CUSTOMER.CUSTOMER_NUM, CUSTOMER_NAME
    INTO I_ORDER_DATE, I_CUSTOMER_NUM, I_CUSTOMER_NAME
    FROM ORDERS, CUSTOMER
    WHERE CUSTOMER.CUSTOMER_NUM = ORDERS.CUSTOMER_NUM
    AND ORDER_NUM = I_ORDER_NUM;
    
    DBMS_OUTPUT.PUT_LINE(RTRIM(I_ORDER_DATE)||', '||RTRIM(I_CUSTOMER_NUM)||', '||RTRIM(I_CUSTOMER_NAME));
    
    END;
    /

BEGIN
DISP_EX05B('51608');
END;
/

/* c) Add a row to the ORDERS table. */
CREATE OR REPLACE PROCEDURE DISP_EX05C (I_ORDER_NUM IN ORDERS.ORDER_NUM%TYPE, I_ORDER_DATE IN ORDERS.ORDER_DATE%TYPE, I_CUSTOMER_NUM IN ORDERS.CUSTOMER_NUM%TYPE) AS

    BEGIN
    INSERT INTO ORDERS
    VALUES(I_ORDER_NUM, I_ORDER_DATE, I_CUSTOMER_NUM);
    
    END;
    /

BEGIN
DISP_EX05C('51626','05-12-2018','126');
END;
/

/* d) Change the date of the order whose number is stored in I_ORDER_NUM to the date currently found in I_ORDER_DATE. */
CREATE OR REPLACE PROCEDURE DISP_EX05D (I_ORDER_NUM IN ORDERS.ORDER_NUM%TYPE, I_ORDER_DATE IN ORDERS.ORDER_DATE%TYPE) AS
    
    BEGIN
    UPDATE ORDERS
    SET ORDER_DATE = I_ORDER_DATE
    WHERE ORDER_NUM = I_ORDER_NUM;
    
    END;
    /

BEGIN
DISP_EX05D('51608','05-12-2018');
END;
/

/* e) Delete the order whose number is stored in I_ORDER_NUM. */
CREATE OR REPLACE PROCEDURE DISP_EX05E (I_ORDER_NUM IN ORDERS.ORDER_NUM%TYPE) AS
    
    BEGIN
    
    DELETE
    FROM ORDER_LINE
    WHERE ORDER_NUM = I_ORDER_NUM;
        
    DELETE
    FROM ORDERS
    WHERE ORDER_NUM = I_ORDER_NUM;
    
    END;
    /

BEGIN
DISP_EX05E('51608');
END;
/

/* Exercise 6: Write PL/SQL or T-SQL procedures to retrieve and output the item number, description, storehouse number, and unit price of every item in the category stored in I_CATEGORY. */
CREATE OR REPLACE PROCEDURE DISP_EX06 (I_CATEGORY IN ITEM.CATEGORY%TYPE) AS
    I_ITEM_NUM    ITEM.ITEM_NUM%TYPE;
    I_DESCRIPTION     ITEM.DESCRIPTION%TYPE;
    I_STOREHOUSE    ITEM.STOREHOUSE%TYPE;
    I_PRICE    ITEM.PRICE%TYPE;
    
    CURSOR CURSOR1 IS
    SELECT ITEM_NUM, DESCRIPTION, STOREHOUSE, PRICE
    FROM ITEM
    WHERE CATEGORY = I_CATEGORY;
    
    BEGIN

    OPEN CURSOR1;
    
    LOOP
        FETCH CURSOR1 INTO I_ITEM_NUM, I_DESCRIPTION, I_STOREHOUSE, I_PRICE;
        EXIT WHEN CURSOR1%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE(RTRIM(I_ITEM_NUM)||' '||RTRIM(I_DESCRIPTION)||' '||RTRIM(I_STOREHOUSE)||' '||RTRIM(I_PRICE));
    END LOOP;
    
    CLOSE CURSOR1;
    END;
    /

BEGIN
DISP_EX06('TOY');
END;
/

/* Exercise 8: Write a stored procedure in PL/SQL or T-SQL that will change the price of an item with a given item number. How would you use this stored procedure to change the price of item AH74 to $26.95? */
CREATE OR REPLACE PROCEDURE DISP_EX8_08 (I_ITEM_NUM IN ITEM.ITEM_NUM%TYPE, I_PRICE IN ITEM.PRICE%TYPE) AS
    
    BEGIN
    UPDATE ITEM
    SET PRICE = I_PRICE
    WHERE ITEM_NUM = I_ITEM_NUM;
    
    END;
    /

BEGIN
DISP_EX8_08('AH74',26.95);
END;
/

/* Exercise 9: Write the code for the following triggers in PL/SQL or T-SQL following the style shown in the text. */
/* a) When adding a customer, add the customer's balance multiplied by the sale rep's commission rate to the commission for the corresponding sales rep. */
CREATE OR REPLACE TRIGGER EX_09A
    AFTER INSERT ON CUSTOMER FOR EACH ROW
    BEGIN
    UPDATE REP
    SET REP.COMMISSION = REP.COMMISSION + :NEW.BALANCE * REP.RATE
    WHERE REP_NUM = :NEW.REP_NUM;
    
    END;

/* b) When updating a customer, add the difference between the new balance and the old balance multiplied by the sales rep's commission rate to the commission for the corresponding sales rep. */
CREATE OR REPLACE TRIGGER EX_09B
    AFTER UPDATE ON CUSTOMER FOR EACH ROW
    BEGIN
    UPDATE REP
    SET REP.COMMISSION = REP.COMMISSION + ((:NEW.BALANCE - :OLD.BALANCE) * REP.RATE)
    WHERE REP_NUM = :NEW.REP_NUM;
    
    END;

/* c) When deleting a customer, subtract the balance multiplied by the sales rep's commission rate from the commission for the corresponding sales rep. */
CREATE OR REPLACE TRIGGER EX_09C
    AFTER DELETE ON CUSTOMER FOR EACH ROW
    BEGIN
    UPDATE REP
    SET REP.COMMISSION = REP.COMMISSION - (:NEW.BALANCE * REP.RATE)
    WHERE REP_NUM = :NEW.REP_NUM;
    
    END;