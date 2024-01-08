SELECT title
FROM BOOKS;

SELECT title, category
FROM BOOKS;

SELECT category, title
FROM BOOKS;

SELECT lname ||',  '|| fname 
FROM author;

SELECT quantity * paideach AS "Item Total"
FROM orderitems;

SELECT lastname ||', '|| firstname AS Name, address, city ||', '|| state AS Location, zip
FROM customers;

SELECT substr(((retail-cost) /cost)*100 , 1,5)  AS "Profit %"
FROM BOOKS;

