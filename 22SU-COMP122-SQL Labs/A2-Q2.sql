CREATE TABLE EMPLOYEE
(
eno     CHAR(4),
ename VARCHAR2(30),
job     VARCHAR2(30),
manager CHAR(4),
jdate TIMESTAMP(8),
gender CHAR(1),
salary NUMBER(8,2),
comission NUMBER(8,2) DEFAULT 0,
deptno NUMBER(7,2),
CONSTRAINT employee_eno_pk PRIMARY KEY (eno),
CONSTRAINT employee_deptno_fk FOREIGN KEY(deptno)
    REFERENCES dept (dno),
CONSTRAINT  salary_ch CHECK(salary>0),   
CONSTRAINT gender_ch CHECK(gender in('F','M'))
);
DROP TABLE EMPLOYEE PURGE;

CREATE TABLE DEPARTMENT
(
dno NUMBER(7,0),
dname VARCHAR2(30),
dlocation VARCHAR2(30),
CONSTRAINT department_pk PRIMARY KEY (dno),
CONSTRAINT department_dname_un UNIQUE (dname),
CONSTRAINT department_dlocation_un UNIQUE (dlocation)
);

INSERT INTO EMPLOYEE (eno, ename, deptno,salary)
VALUES(1,'A1',10,3000);

INSERT INTO EMPLOYEE (eno, ename, deptno,salary)
VALUES(2,'A2',11,3001);

INSERT INTO EMPLOYEE (eno, ename, deptno,salary)
VALUES(3,'A3',12,3002);

INSERT INTO EMPLOYEE (eno, ename, deptno,salary)
VALUES(4,'A4',13,3003);

INSERT INTO EMPLOYEE (eno, ename, deptno,salary)
VALUES(5,'A5',14,3004);
