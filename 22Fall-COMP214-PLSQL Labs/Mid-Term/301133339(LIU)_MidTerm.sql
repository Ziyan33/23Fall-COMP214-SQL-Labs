--1.	List each donor who has made a pledge and indicated a single lump sum payment. 
--Include first name, last name, pledge date, and pledge amount.

SELECT Firstname, Lastname, Pledfedate, Pledgeamt,
(SELECT sum(Payamt)  FROM DD_Payment b WHERE a.idPledge=b.idPledge)
FROM DD_Pledge a, DD_Donor
group by  Lastname, Firstname, Pledfedate, Pledgeamt;

-- 2.	List each donor who has made a pledge and indicated monthly payments over
--one year.Include first name, last name, pledge date, and pledge amount. 
--Also, display the monthlypayment amount. 
--(Equal monthly payments are made for all pledges paid in monthlypayments.)

 SELECT Firstname, Lastname, Pledfedate, Pledgeamt
FROM DD_Donor, DD_Pledge
WHERE( (paymonths > 12) AND (Firstpledge = "Y" )) ;

--3. Create a PL/SQL block that retrieves and displays information for a specific project 
--based onProject ID. Display the following on a single row of output: project ID, project name,
--number ofpledges made, total dollars pledged, and the average pledge amount.
DECLARE
Lv_idProj_num NUMER(6);
Lv_Projname_var VARCHAR2(60);
Lv_Pledgeamt_num NUMBER(8,2);
Lv_Payamt_num NUMBER(8,2);
Lv_avePledgeamt  DD_Project.Pledgeamt%TYPE;
BEGIN
SELECT idProj, Projname, Pledgamt, Payamt
INTO Lv_idProj_num, Lv_Projname_var, Lv_Pledgeamt_num, Lv_Payamt_num
FROM DD_Project, DD_Pledge;
Lv_avgPledgamt := Lv_Payamt_num / Lv_Pledgeamt_num;
DBMS_OUTPUT.PUT_LINE( "Project ID: " || Lv_idProj_num|| "Project Name:"|| Lv_Projname_var || "Number of Pledges made " 
|| Lv_Pledgeamt_num || "Average Pledge Amount: " || Lv_avgPledgeamt  );
END;

--4. Create a block to retrieve and display pledge and payment information for a specific donor. 
--Foreach pledge payment from the donor, display the pledge ID,pledge amount,
--number of monthlypayments, payment date, and payment amount. (Use Explicit Cursor)
DECLARE
d_ id DD_Pledge.idPledge%TYPE;
d_ Pledgeamt DD_Pledge.Pledgeamt%TYPE;
d_ months DD_Pledge.paymonths%TYPE;
d_ Payamt DD_Payment.Payamt%TYPE;
d_ Paydate DD_Payment.Paydate%TYPE;
CURSOR donor_Info IS 
SELECT idPledge, Pledgeamt, paymonths, Payamt, Paydate
FROM DD_Pledge, DD_Payment
BEGIN
OPEN donor_Info;
LOOP
FETCH donor_Info into d_ id, d_ Pledgeamt, d_ months, d_ Payamt, d_ Paydate
EXIT WHEN donor_info%notfound;
DBMS_OUTPUT.PUT_LINE(d_ id || " "|| d_ Pledgeamt ||" " || d_ months
|| " "|| d_ Payamt || " "||d_ Paydate );
END LOOP;
CLOSE donor_Info;
END;
