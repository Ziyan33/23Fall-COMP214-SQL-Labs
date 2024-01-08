--2 Sequence
CREATE SEQUENCE employee_seq
  MINVALUE 1
  MAXVALUE 5
  START WITH 1
  INCREMENT BY 1
  NOCACHE
  CYCLE;
  
DROP SEQUENCE employee_seq;
  
ALTER TABLE comm_Employee
  ADD EMPLOYEE_ORDER INT;
  
--Test sequence order using employee_order
UPDATE comm_Employee
SET employee_order= employee_seq.NEXTVAL;

SELECT * FROM comm_Employee;

--5 Package
--Two Procedures
CREATE OR REPLACE PACKAGE t_package AS 
   PROCEDURE addTicket(
      t_id  comm_ticket.ticket_ID%type, 
      t_filghtID  comm_ticket.flightInfo_ID%type, 
      t_seatNum  comm_ticket.seat_number%type, 
      t_cus  comm_ticket.customer_ID%type); 
      
 PROCEDURE delTicket(t_id   comm_ticket.ticket_ID%type);
 PROCEDURE listTicket ;
 END t_package;
 /
CREATE OR REPLACE PACKAGE BODY t_package AS 
   PROCEDURE addTicket(
      t_id  comm_ticket.ticket_ID%type, 
      t_filghtID  comm_ticket.flightInfo_ID%type, 
      t_seatNum  comm_ticket.seat_number%type, 
      t_cus  comm_ticket.customer_ID%type) 
   IS 
   BEGIN 
      INSERT INTO comm_ticket (ticket_ID, flightInfo_ID ,seat_number, customer_ID) 
         VALUES(t_id, t_filghtID, t_seatNum, t_cus); 
   END addTicket; 
   
   PROCEDURE delTicket(t_id   comm_ticket.ticket_ID%type) IS 
   BEGIN 
      DELETE FROM comm_ticket 
      WHERE ticket_ID = t_id; 
   END delTicket;  
   
 PROCEDURE listTicket IS 
 
   CURSOR t_tickets is 
      SELECT  ticket_ID FROM comm_ticket; 
      
   TYPE t_list is TABLE OF comm_ticket.ticket_ID%type; 
   ticket_list t_list := t_list(); 
   counter integer :=0; 
   
   BEGIN 
      FOR n IN t_tickets LOOP 
      counter := counter +1; 
      ticket_list.extend; 
      ticket_list(counter) := n.ticket_ID; 
      dbms_output.put_line('The list of Ticket ID: '||ticket_list(counter)); 
      END LOOP; 
      
   END listTicket;
END t_package;
/

--------------USING THIS PACKAGE
DECLARE
   temp comm_ticket.ticket_ID%type:=007;
BEGIN
   -- t_package.addTicket(006,10111,'B4321',1001);
    --t_package.addTicket(007,10112,'C5432',1002);
  --  t_package.listTicket;
  t_package.delTicket(temp);
--    t_package.listTicket;
END;
/
select *from comm_ticket;

-------Two Functions
CREATE OR REPLACE PACKAGE c_package AS
FUNCTION get_cusName(n_cus_id NUMBER) 
 RETURN VARCHAR2;
FUNCTION get_cusAddress(n_cus_id NUMBER) 
  RETURN VARCHAR2;
END c_package;
/

CREATE OR REPLACE PACKAGE BODY c_package AS
  -- get customer's fullname
  FUNCTION get_cusName(n_cus_id NUMBER) RETURN VARCHAR2 IS
      v_cusName VARCHAR2(30);
  BEGIN
    SELECT firstName || ',' ||  lastName
    INTO v_cusName
    FROM comm_Customer
    WHERE customer_ID = n_cus_id;
    RETURN v_cusName;
    
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        RETURN NULL;
  END; 

  -- get customer's fulladdress
  FUNCTION get_cusAddress(n_cus_id NUMBER) RETURN VARCHAR2 IS
      v_cusAddress VARCHAR2(30);
  BEGIN
    SELECT address || ' ' ||  city || ' '||zip
    INTO v_cusAddress
    FROM comm_Customer
    WHERE customer_ID = n_cus_id;
    RETURN v_cusAddress;
   
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        RETURN NULL;
  END; 
END c_package;
/
----USING FUNCTION

SET SERVEROUTPUT ON SIZE 100000;
DECLARE
  v_address   VARCHAR2(40);
  v_name   VARCHAR2(30);
  n_cus_id NUMBER := &cus_id;
BEGIN

  v_name   := c_package.get_cusName(n_cus_id);
  v_address := c_package.get_cusAddress(n_cus_id);

  IF v_name  IS NOT NULL AND
    v_address IS NOT NULL
  THEN
    dbms_output.put_line('Customer Name: ' || v_name);
    dbms_output.put_line('Address:' || v_address);
  END IF;
END;
/

--TRIGGER
select *from comm_ticket;


--BEGIN
--  UPDATE comm_ticket
--    SET boarding_gate = 'A23'
--    WHERE ticket_id = 1;
--END;
/
CREATE OR REPLACE TRIGGER boardingGate_changes
AFTER UPDATE OR DELETE ON comm_ticket
FOR EACH ROW
--WHEN (OLD.boarding_gate<>NEW.boarding_gate)
DECLARE
BEGIN 
--dbms_output.put_line ('Original boarding gate:' || boarding_gate);
--dbms_output.put_line ('New boarding gate' || NEW.boarding_gate);
END;

DROP TRIGGER boardingGate_changes;
/

