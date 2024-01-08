--Question 1
--List all products whose unit price is less than the average price.
SELECT * FROM products
WHERE unitprice<(SELECT AVG(unitprice)
                               FROM products);
--Question 2
--List the shipper id, shipping company and freight cost 
--for the order with the lowest freight charge.
SELECT shipperid, companyname, freight
FROM  orders , shippers 
WHERE freight IN ( SELECT MIN( freight)
                                FROM orders);

--Question 3
--List all products with their highest unit price, i.e. not discounted.
SELECT* 
FROM products
 WHERE (categoryid,unitprice) IN(SELECT categoryid, MAX(unitprice)
                                                      FROM products
                                                      GROUP BY categoryid)
ORDER BY categoryid;

--Question 4
--List the average unit price for each product category and
--the average unit price without discounts

 SELECT categoryid, to_char(AVG(unitprice),999.99) cataverage, (SELECT to_char(AVG(unitprice),999.99) 
                                                                                                      FROM products 
                                                                                                      WHERE discontinued=0 ) catAverageWithoutDiscount
FROM products
GROUP BY categoryid
ORDER BY categoryid;