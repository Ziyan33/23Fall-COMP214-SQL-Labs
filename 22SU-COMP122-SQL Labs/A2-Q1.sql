CREATE TABLE supplier
(
supplier_id NUMBER(10),
supplier_name VARCHAR2(50) unique,
contact_name VARCHAR2(50),
city VARCHAR2(10),
region CHAR(2),
CONSTRAINT supplier_supplierid_pk PRIMARY KEY(supplier_id),
CHECK (region IN('N','NW','NE','S','SE','SW','W','E'))
);
clear screen;

INSERT INTO supplier (supplier_id, supplier_name, contact_name, city, region)
VALUES(100,'A1','B1','Toronto','S');

INSERT INTO supplier (supplier_id, supplier_name, contact_name, city, region)
VALUES(200,'A2','B2','Nunavut','N');

INSERT INTO supplier (supplier_id, supplier_name, contact_name, city, region)
VALUES(300,'A3','B3','Yukon','NW');

INSERT INTO supplier (supplier_id, supplier_name, contact_name, city, region)
VALUES(400,'A4','B4','Ottawa','S');

INSERT INTO supplier (supplier_id, supplier_name, contact_name, city, region)
VALUES(500,'A5','B5','Toronto','S');

SELECT*FROM supplier;

SELECT* 
FROM supplier 
WHERE supplier_id=500 AND city='Toronto';

ALTER TABLE supplier
ADD phone_number NUMBER(12);

ALTER TABLE supplier
SET UNUSED (city);

ALTER TABLE supplier
DROP UNUSED COLUMNS;

RENAME supplier TO SUPPLIER_CONTACT;

ALTER SESSION SET RECYCLEBIN=ON;
DROP TABLE SUPPLIER_CONTACT;

SHOW RECYCLEBIN;

DROP TABLE SUPPLIER_CONTACT PURGE;
