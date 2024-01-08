SELECT lastname,firstname,state FROM customers
WHERE state='NJ';

SELECT order#,orderdate FROM orders
WHERE orderdate>'09-04-01';

SELECT title,category FROM books
WHERE category <>'FITNESS';
    
SELECT customer#,lastname,state FROM customers
WHERE state IN('GA','NJ') 
ORDER BY lastname; 

SELECT customer#,lastname,state FROM customers
WHERE state='GA' OR state='NJ' 
ORDER BY lastname; 
    
SELECT order#,orderdate FROM orders
WHERE orderdate<='09-04-01';

SELECT order#,orderdate FROM orders
WHERE orderdate <= TO_DATE('01/04/2009','DD/MM/YYYY');
   
SELECT lname,fname FROM author
WHERE lname LIKE'%IN%'
ORDER BY lname,fname;
    
SELECT lastname,customer# FROM customers
WHERE referred IS NOT NULL;
    
SELECT title,category FROM books
WHERE category='CHILDREN' OR category='COOKING';

SELECT title,category FROM books
WHERE  category LIKE 'CHILDREN' OR category LIKE 'COOKING' ;

SELECT title,category FROM books
WHERE category IN('CHILDREN','COOKING');

SELECT isbn,title FROM books
WHERE title LIKE '_A_N%'
ORDER BY title DESC;
 
SELECT title,pubdate FROM books
WHERE category='COMPUTER' AND pubdate BETWEEN '05-01-01' AND '05-12-31';
 
SELECT title,pubdate FROM books
WHERE category='COMPUTER' AND (pubdate >='05-01-01' AND pubdate <= '05-12-31' );

SELECT title,pubdate FROM books
WHERE category LIKE 'COMPUTER' AND pubdate LIKE '05%' ;
   
SELECT * FROM orders;