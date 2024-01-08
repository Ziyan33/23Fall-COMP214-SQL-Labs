--Question 1
--Create a procedure that accepts a customer id and retrieves the
--a history of the products and quantities that the customer ordered.
-- Use an anonymous to call the procedure and output the result.
CREATE PROCEDURE search_cus (cus_id IN CHAR)
IS
    r_cus customer%ROWTYPE;
BEGIN
    SELECT orderid, quantity
    INTO r_cus
    FROM orders a,orderdetails b
    WHERE a.orderid=b.orderid;

FOR cus IN r_cus LOOP
    DBMS_OUTPUT.PUT_LINE( r_cus.customerid || " " || r_cus.orderid || " " ||
    r_cus.quantity );
END LOOP;
END;

--Question 2
--Create a procedure to insert a new product into an order, include
--the product id, unit price, quantity, check to make sure that 
--the order exists. Send a message to the calling program if the 
--update succeeded
CREATE PROCEDURE insert_order (orderid IN NUMBER)
IS
    r_order order%ROWTYPE;
BEGIN
    INSERT INTO r_order
    (productid, unitprice,quantity)
    SELECT productid, unitprice,quantityperunit
    FROM products
    WHERE NOT EXISTS ( SELECT *
                                         FROM r_order
                                         WHERE r_order.orderid=producys.orderid);
FOR order IN r_order LOOP
    DBMS_OUTPUT.PUT_LINE( r_order.productid || " " || r_order.unitprice || " " ||
    r_order.quantity );
END LOOP;
END;

--Question 3
--Create a procedure that accepts a category name and retrieves the 
--product and the total sales for the category.

CREATE PROCEDURE acc_cate (categoryname IN VARCHAR2)
IS
    r_cate categories%TYPE;
    total_sales NUMBER(11,2):=0;
BEGIN
FOR categoryid IN products LOOP
    total_sales := products.unitprice * products.quantityperunit ;
END LOOP;

FOR categories IN acc_cate LOOP
    DBMS_OUTPUT.PUT_LINE( "Categoriy Name: " || acc_cate.categoryname ||
    "Total sales: " || acc_cate.total_sales );
END LOOP;
END;

--Question 4
-- Create a stored procedure to retrieve the n most expensive 
--products, where n is a number. Use an anonymous block to call
--the stored procedure and display the results.
CREATE PROCEDURE search_max (unitprice_in IN NUMBER)
IS
    r_price unitprice%TYPE;
    
    CURSOR p1 IS
    SELECT MAX(unitprice)
    FROM products;
    
BEGIN
    OPEN p1;
    FETCH p1 INTO r_price;
    SELECT productname FROM products WHERE unitprice=p1;
     DBMS_OUTPUT.PUT_LINE("Product Name" || products.productname ||
     "has the most expensive price "|| r_price.unitprice);
    CLOSE p1;
END;
    
