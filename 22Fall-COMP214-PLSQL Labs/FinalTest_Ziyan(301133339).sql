--1.  BrewBean wants to know the total sold amount for a specific product 
--within a particular year. Create a function to meet the requirement. 
--Include exception handling section. 

CREATE OR REPLACE PACKAGE b_package AS
FUNCTION get_soldProduct(idbasket NUMBER) 
 RETURN VARCHAR2;

END b_package;
/

CREATE OR REPLACE PACKAGE BODY b_package AS
  -- get customer's fullname
  FUNCTION get_soldProduct(idbasket NUMBER) RETURN VARCHAR2 IS
      b_quantity VARCHAR2(30),
      b_year DATE;
  BEGIN
    SELECT quantity
    INTO b_quantity
    FROM bb_Basket
    WHERE b_quantity = 0;
    RETURN b_quantity;
    
    IF b_quantity = 0 THEN
    SELECT dtCreated
    INTO b_year
    FROM bb_Basket;
    END IF;
    
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        RETURN NULL;
  END; 

END b_package;
/
----USING FUNCTION

SET SERVEROUTPUT ON SIZE 100000;
DECLARE
  b_product   VARCHAR2(40);
  b_soldYear   DATE;
  idbasket NUMBER := &b_id;
BEGIN

  b_soldYear   := b_package.get_soldProduct(idbasket);

  IF b_soldYear  IS NOT NULL AND
    b_product IS NOT NULL
  THEN
   dbms_output.put_line('Product Name is' || b_product);
    dbms_output.put_line('It sold out at the date of ' || b_soldYear);
    
  END IF;
END;
/

--2.Allow customers to cancel their order is one of essential functionalities 
--for BrewBean’s site. 
CREATE OR REPLACE TRIGGER cancelOrder_changes
AFTER UPDATE OR DELETE ON bb_basket
FOR EACH ROW
DECLARE
id_stage NUMBER(5),
order_status VARCHAR2(10);
BEGIN 
IF id_Stage=4 THEN
order_status=0
ELSE
order_status=1
END IF;

UPDATE bb_basket SET
orderplaced=0 
WHERE order_status=: OLD.order_status;

END;
/
-----USING SQL statement to implemented trigger
UPDATE bb_basketstatus
SET order_status=1
WHERE id_Stage=4 ;

/
DROP TRIGGER cancelOrder_changes;
/

--3.	Use Mongo shell  commands to answer following questions
--based on the collection sample_restaurants.restaurants 
--a
db.restaurants.find(
                      {"address.zipcode" :
                         {10065}
                      },
                         {"restaurant_id" : 1,"name":1}
                    );
-------------------------------------------------


---b
db.collection.insert({
 "address": {
   "building": "Manhattan",
   "street": "2580 Broadway",
   "zipcode": "10025"
 },
 "borough": "NY",
 "cuisine": "Thai",
   "name": "Thai food",
   "restaurant_id": "123456"
})
-------------------
--c
db.collection.update(
"restaurant_id": "123456",
"grades": [ {
   "grade": "A",
   "score": 9
 }]})