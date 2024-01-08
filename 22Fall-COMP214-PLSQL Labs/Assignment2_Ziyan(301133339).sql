--Question 1
--Retrieving Order Totals

DECLARE
        lv_id_num NUMBER(3);
        lv_name_txt ot_products.productname%TYPE;
        lv_order_num ot_products.unitsonorder%TYPE;
        lv_price_num ot_products.unitprice%TYPE;
        lv_subtotal NUMBER(5);

BEGIN
SELECT productid,productname,unitsonorder,unitprice
INTO lv_id_num, lv_name_txt,  lv_order_num,lv_price_num
FROM products a ,orderdetails b
WHERE a.productid=b.productid;

DBMS_OUTPUT.PUT_LINE('Product ID: ' || lv_id_num || 'Name: ' || lv_name_txt);
END;

--Question 2
--Adding an Order
DECLARE
    lv_cusid_num ;
    lv_empid_num ;
    lv_terrid_num ;
    lv_ordate_date DATE := SYSDATE;
    lv_data IS NULL:="unknown";
BEGIN
    INSERT INTO orders(orderid,customerid,emplyeeid,territoryid,orderdate)
    VALUES(orderid_seq.NEXTVAL,lv_cusid_num,lv_empid_num.lv_terrid_num,lv_ordate_date)
    COMMIT;
END;

--Question3

DECLARE
  lv_territory_id territories.territoryid%ROWTYPE;
  lv_terrdesc_id territories.territorydescription%ROWTYPE;
  BEGIN
  SELECT  territoryid, territorydescription
  INTO lv_territory_id, lv_terrdesc_id
  FROM territories
  WHERE totalsales;
  
  END;
  --Question4
DECLARE
lv_eid_num employees.employeid%TYPE;
lv_mid_num employees.managerid%TYPE;
lv_hire_date employees.hiredate%TYPE;;
BEGIN
SELECT employeid,managerid,hiredate
INTO lv_eid_num,lv_mid_num,lv_hire_date
FROM employees
WHERE region='Southern';
END;
