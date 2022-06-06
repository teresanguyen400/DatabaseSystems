	--Create your output file (include the full path). This will start logging to the specified file .
		start C:\Users\redli\OneDrive\Desktop\Project2.sql
		spool 'C:\Users\redli\OneDrive\Desktop\project3_ttn.txt'  
	
	--This will ensure that all input and output is logged to the file.
		set echo on

	--Teresa Nguyen
	--INSY 3304-001
	--Project 3

	--1. Format the columns to ensure that the headings don't get truncated.
	COLUMN PatientID FORMAT a10
	COLUMN PatientPhone FORMAT a13
	COLUMN BillingType FORMAT a12
	COLUMN InsCoID FORMAT a8
	COLUMN DrID FORMAT a5
	COLUMN PmtStatusCode FORMAT a14
	COLUMN ApptStatusCode FORMAT a15
	COLUMN BlockCode FORMAT a10
	COLUMN BlockCodeDesc FORMAT a14
	COLUMN ApptReasonCode FORMAT a15
	COLUMN ApptID FORMAT a7
	COLUMN ReasonCode FORMAT a11
	
	ALTER SESSION SET nls_date_format = 'DD-MON-YYYY hh24:mi';

	--2. Set the width of the page to 130 characters.
	SET PAGESIZE 50
	SET LINESIZE 130

	--3. Aliases and dot notation will be applied in SELECT statements that require a JOIN.

	--4. Rename the ApptDate and ApptTime columns.
	ALTER TABLE APPOINTMENT_ttn
	RENAME COLUMN ApptDate
		TO ApptDateTime;

	--Change the data type to DATETIME for ApptDate and ApptTime.

	--Update the Appointments with the new date/time data
	UPDATE APPOINTMENT_ttn
		SET ApptDateTime = '25-SEP-2021 09:00'
	WHERE ApptID = 101;

	UPDATE APPOINTMENT_ttn
		SET ApptDateTime = '25-SEP-2021 09:00'
	WHERE ApptID = 102;

	UPDATE APPOINTMENT_ttn
		SET ApptDateTime = '25-SEP-2021 10:30'
	WHERE ApptID = 103;

	UPDATE APPOINTMENT_ttn
		SET ApptDateTime = '25-SEP-2021 10:30'
	WHERE ApptID = 104;

	UPDATE APPOINTMENT_ttn
		SET ApptDateTime = '25-SEP-2021 10:30'
	WHERE ApptID = 105;

	UPDATE APPOINTMENT_ttn
		SET ApptDateTime = '25-SEP-2021 10:30'
	WHERE ApptID = 106;

	UPDATE APPOINTMENT_ttn
		SET ApptDateTime = '25-SEP-2021 11:30'
	WHERE ApptID = 107;

	UPDATE APPOINTMENT_ttn
		SET ApptDateTime = '25-SEP-2021 11:30'
	WHERE ApptID = 108;

	UPDATE APPOINTMENT_ttn
		SET ApptDateTime = '25-SEP-2021 14:00'
	WHERE ApptID = 109;

	UPDATE APPOINTMENT_ttn
		SET ApptDateTime = '26-SEP-2021 08:30'
	WHERE ApptID = 110;

	UPDATE APPOINTMENT_ttn
		SET ApptDateTime = '26-SEP-2021 08:30'
	WHERE ApptID = 111;

	/*To DROP a column, use the following syntax
	ALTER TABLE <tablename>
	DROP COLUMN <columnname>;
	*/

	--Drop ApptTime COLUMN
	ALTER TABLE APPOINTMENT_ttn
		DROP COLUMN ApptTime;

	--5. If necessary, use an ALTER TABLE statement to modify the datatype of BlockMinutes column to be Number(2).
	--This is already changed in Project 2.

	--6. Add a new appointment and appointment detail row.
	INSERT INTO APPOINTMENT_ttn
		VALUES ((SELECT (MAX(ApptID) + 1) FROM APPOINTMENT_ttn), '26-SEP-2021 11:00', 15, 'SP', NULL, 1, 'CN', 'NP');

		--Add appointment details using the ApptID for the new appointment above:
	INSERT INTO APPTDETAIL_ttn
		VALUES ((SELECT MAX(ApptID) FROM APPOINTMENT_ttn), 'PT', 'L4');

	--7. Add a new appointment. Generate the ApptID for by incrementing the max ApptID by 1. 
	INSERT INTO APPOINTMENT_ttn
		VALUES ((SELECT (MAX(ApptID) + 1) FROM APPOINTMENT_ttn), '26-SEP-2021 13:00', 101, 'I', 323, 3, 'NC', 'NP');

	--Add appointment details using the ApptID for the new appointment above:
	INSERT INTO APPTDETAIL_ttn
		VALUES ((SELECT MAX(ApptID) FROM APPOINTMENT_ttn), 'PT', 'L4');

	--8. Add a new appointment status: 
	INSERT INTO APPTSTATUS_ttn 
		VALUES ('RS', 'Rescheduled');

	--9. Change the ApptStatus for ApptID 108 to “RS”
	UPDATE APPOINTMENT_ttn
		SET ApptStatusCode = 'RS'
	WHERE ApptID = 108;

	--10. Commit all changes above before proceeding to the next step.
	COMMIT; 

	--The above statements will add new rows everytime you run your file, so be sure to run your Project 2 file immediatley before
	--your final run of Project 3. Otherwise, your final Project 3 results will have incorrect data based on the extra rows.

	--11. List the patient ID, first name, and last name for all patients for whom no phone number exists.  
	SELECT PatientID, PatientFName, PatientLName
		FROM PATIENT_ttn
	WHERE PatientPhone IS NULL ;

	--12. List the count of unique insurance companies found in the Appointment table. Use Insurance Co Count as the column 
	--heading.
	SELECT COUNT(DISTINCT InsCoID) AS "Insurance Co Count"
		FROM INSURANCECO_ttn;

	--13. List the ApptReasonCode and count of appointments for each reason code. Use the following column headings: ReasonCode,
	--ApptCount. Hint: Use a GROUP BY clause.
	SELECT ApptReasonCode AS "ReasonCode", COUNT(ApptReasonCode) AS "ApptCount"
		FROM APPTREASON_ttn
	GROUP BY ApptReasonCode;

	--14. List the BillingType and count of appointments for each billing type. Sort by count. Hint: Use a GROUP BY clause.
	SELECT BillingType AS "BillingType", COUNT(BillingType) AS "BillingCount"
		FROM BILLINGTYPE_ttn
	GROUP BY BillingType;

	--15. List all rows and all columns from the ApptDetail table; sort by ApptID then by ReasonCode, both in ascending order. 
	--Use the following column headings: ApptID, ReasonCode, BlockCode.
	SELECT * FROM APPTDETAIL_ttn
	ORDER BY ApptID, ReasonCode;

	--16. List the average number of minutes for all rows in the ApptDetail table.  Use “Avg Appt Time” as the column heading and 
	--format the result as “# Minutes” (where “#” represents the calculated number of minutes). 
	SELECT TO_CHAR(AVG(BlockCodeMinutes), '999') AS "#Minutes"
		FROM APPTDETAIL_ttn A, BLOCK_ttn B
	WHERE A.BlockCode = B.BlockCode;

	--17. List the appt ID, date, patient ID, patient last name, doctor ID, doctor last name, appt status desc for all 
	--appointments on or after 9/25/21. Show the date formatted as “mm/dd/yy.”
	SELECT ApptID, TO_CHAR(ApptDateTime, 'mm/dd/yy'), PatientID, A.DrID, DrLName, ApptStatusDesc
		FROM APPOINTMENT_ttn A, DOCTOR_ttn D, APPTSTATUS_ttn AP
	WHERE A.DrID = D.DrID AND
	A.ApptStatusCode = AP.ApptStatusCode AND
	ApptDateTime >= '25-SEP-21';

	--18. List the appt ID, date/time, and total number of minutes for each appointment. Use the following column headings: 
	--Appt ID, DateTime, Total Minutes. Hint: Use a GROUP BY clause.
	SELECT A.ApptID AS "Appt ID", ApptDateTime AS "DateTime", SUM(BlockCodeMinutes) AS "Total Minutes"
		FROM APPOINTMENT_ttn A, BLOCK_ttn B, APPTDETAIL_ttn AD
	WHERE A.ApptID = AD.ApptID AND
	AD.BlockCode = B.BlockCode
	GROUP BY A.ApptID, ApptDateTime;

	--19. List the block code, block code description, and count of appointments for each block code. Sort by count in descending 
	--order. Use the following column headings: BlockCode, Description, Count. Hint: Use a GROUP BY clause.
	SELECT B.BlockCode AS "BlockCode", BlockCodeDesc AS "Description", COUNT(A.ApptID) AS "Count"
		FROM BLOCK_ttn B, APPTDETAIL_ttn A
	WHERE A.BlockCode = B.BlockCode
	GROUP BY B.BlockCode, BlockCodeDesc;

	--20. List the patient ID, first name, last name, and phone number for all patients. Show the phone number formatted as 
	--‘(###) ###-####’ and sort by patient ID. Use the following column headings: Patient ID, First Name, Last Name, Phone. 
	'(###)###-####' and sort by patient ID.
	SELECT PatientID AS "Patient ID", PatientFName AS "First Name", PatientLName AS "Last Name",  SUBSTR(PatientPhone, 1, 3) || '-' || SUBSTR(PatientPhone, 4, 3) || '-' || SUBSTR(PatientPhone, 7, 4) AS "Phone"
	FROM PATIENT_ttn;

	--21. List the pay type, pay type description, and count of appointments for each pay type. Use the following column headings:  
	--Pay Type, Description, Count. Sort by count in descending order. Hint: use a GROUP BY clause.
	SELECT A.BillingType AS "Billing Type", BillingTypeDesc AS "Description", COUNT(A.ApptID) AS "Count"
		FROM BILLINGTYPE_ttn B, APPOINTMENT_ttn A
	WHERE B.BillingType = A.BillingType 
	GROUP BY A.BillingType, BillingTypeDesc;

	--22. List the patient ID, first name, last name, and phone number for all “self pay” patients. Show the phone number 
	--formatted as ‘(###) ###-####’ and use the following column headings: PatientID, FirstName, LastName, Phone.
	SELECT A.PatientID AS "Patient ID", PatientFName AS "First Name", PatientLName AS "Last Name", SUBSTR(PatientPhone, 1, 3) || '-' || SUBSTR(PatientPhone, 4, 3) || '-' || SUBSTR(PatientPhone, 7, 4) AS "Phone"
		FROM PATIENT_ttn P, BILLINGTYPE_ttn B, APPOINTMENT_ttn A
	WHERE A.BillingType = B.BillingType AND
	A.PatientID = P.PatientID AND
	A.BillingType = 'SP';

	--23. List the appt ID, date/time, patient ID, last name, doctor ID, doctor last name, pay type description, and appointment 
	--status description for all appointments on or before 6/25/20. Format the date/time as “mm-dd-yyyy 00:00” and use the following 
	--column headings: Appt ID, DateTime, Patient ID, Patient Name, Dr ID, Dr Name, Pay Type, Appt Status. Sort by Appt ID.
	SELECT ApptID AS "Appt ID", ApptDateTime AS "DateTime", A.PatientID AS "Patient ID", (PatientFName || ' ' || PatientLName) AS "Patient Name", A.DrID AS "Dr ID", (DrFName || ' ' || DrLName) AS "Dr Name", A.BillingType AS "Bill Type", A.ApptStatusCode AS "Appt Status"
		FROM APPOINTMENT_ttn A, APPTSTATUS_ttn AP, DOCTOR_ttn D, BILLINGTYPE_ttn B, PATIENT_ttn P
	WHERE A.ApptStatusCode = AP.ApptStatusCode AND
	A.DrID = D.DrID AND
	A.BillingType = B.BillingType AND
	A.PatientID = P.PatientID AND
	ApptDateTime >= '25-SEP-21'
	GROUP BY ApptID, ApptDateTime, A.PatientID, PatientFName, PatientLName, A.DrID, DrFName, DrLName, A.BillingType, A.ApptStatusCode;

	--24. List the doctor ID, first name, last name, and count of appointments for each doctor. Combine the first and last name 
	--into one column and use the following column headings:  Dr ID, Dr Name, Appt Count. Sort by doctor last name.
	SELECT A.DrID AS "Dr ID", DrFName || ' ' || DrLName AS "Dr Name", COUNT(A.ApptID) AS "Appt Count"
		FROM DOCTOR_ttn D, APPOINTMENT_ttn A
	WHERE A.DrID = D.DrID
	GROUP BY A.DrID, DrFName, DrLName
	ORDER BY DrLName;

	--25. List the patient ID, patient first name, patient last name, and total number of appointments for each patient. Sort by 
	--appointment count in descending order.  Use the following column headings:  Patient ID, Patient First Name, Patient Last 
	--Name, Appt Count. Hint: use a GROUP BY clause.
	SELECT PatientID AS "Patient ID", PatientFName AS "First Name", PatientLName AS "Last Name", COUNT(PatientID) AS "Appt Count"
		FROM PATIENT_ttn
	GROUP BY PatientID, PatientFName, PatientLName;

	--26. For each appointment, list the appt ID, date/time, patient ID, patient first name, patient last name, doctor ID, doctor 
	--last name, and count of reason codes; combine the patient first and last name into one column, and sort by count of reason 
	--codes in descending order, then by appt ID in ascending order.  Show the date/time formatted as ‘mm-dd-yyyy 00:00.’  Use the 
	--following column headings:  Appt, DateTime, Patient ID, Patient Name, Dr ID, Dr Name, Code Count. Hint:  use a GROUP BY 
	--clause.
	SELECT A.ApptID AS "Appt", ApptDateTime AS "DateTime", A.PatientID AS "Patient ID", PatientFName || '' || PatientLName AS "Patient Name", A.DrID AS "Dr ID", DrFName || '' || DrLName AS "Dr Name", COUNT(AD.ReasonCode) AS "Code Count"
	FROM APPOINTMENT_ttn A, DOCTOR_ttn D, APPTREASON_ttn AR, PATIENT_ttn P, APPTDETAIL_ttn AD
		WHERE A.PatientID = P.PatientID AND
	D.DrID = A.DrID AND
	AD.ReasonCode = AR.ApptReasonCode AND
	A.ApptID = AD.ApptID
	GROUP BY A.ApptID, ApptDateTime, A.PatientID, PatientFName, PatientLName, A.DrID, DrFName, DrLName;

	--27. List the appt ID, appt date, appt time, and total number of minutes for the appointment(s) with the highest total 
	--minutes.  Sort by appt ID.  Use the following column headings:  ApptID, Date, Time, TotalMinutes. Hint: use a GROUP BY 
	--clause and a nested SELECT or HAVING.
	SELECT A.ApptID AS "Appt ID", ApptDateTime AS "DateTime",  SUM(B.BlockCodeMinutes) as "TotalMinutes"
		FROM APPOINTMENT_ttn A, APPTDETAIL_ttn AD, BLOCK_ttn B
	WHERE A.ApptID = AD.ApptID AND
	AD.BlockCode = B.BlockCode 
	GROUP BY A.ApptID, ApptDateTime
	HAVING SUM(BlockCodeMinutes) >= '30';

	--28. List the doctor ID, first name, last name, and count of appointments for the doctor with the least number of 
	--appointments.  Combine the first and last names into one column, use the following column headings: Dr ID, Name, 
	--Appt Count. Hint: use a GROUP BY clause and a nested SELECT or HAVING.  
	SELECT A.DrID AS "Dr ID", DrFName || '' || DrLName AS "Dr Name", COUNT(A.ApptID) AS "Appt Count"
		FROM DOCTOR_ttn D, APPOINTMENT_ttn A
	WHERE A.DrID = D.DrID
	GROUP BY A.DrID, DrFName, DrLName
	HAVING COUNT(A.DrID) >= '2';

	--29. List the appt ID, Date/time, patient ID, patient last name, doctor ID, and doctor last name for all appointments with a 
	--total number of minutes greater than or equal to 30 minutes. Sort by total minutes in descending order, then by appt ID in 
	--ascending order. Use the following column headings: Appt ID, DateTime, Patient ID, Patient Name, Doctor ID, Doctor Name.
	SELECT A.ApptID AS "Appt ID", ApptDateTime AS "DateTime", A.PatientID AS "Patient ID", PatientLName AS "Patient Name", A.DrID AS "Doctor ID", DrLName AS "Doctor Name", SUM(BlockCodeMinutes)
		FROM APPOINTMENT_ttn A, DOCTOR_ttn D, PATIENT_ttn P, APPTDETAIL_ttn AD, BLOCK_ttn B
	WHERE A.DrID = D.DrID AND
	A.PatientID = P.PatientID AND
	A.ApptID = AD.ApptID AND
	AD.BlockCode = B.BlockCode
	GROUP BY A.ApptID, ApptDateTime, A.PatientID, PatientLName, A.DrID, DrLName
	HAVING SUM(BlockCodeMinutes) >= 30;

	--30. List the appt ID, date, patient last name, and doctor last name for all appointments that have a total number of 
	--minutes greater than the average total minutes for all appointments. Use the following column headings: ApptID, Date, 
	--Patient, Doctor, TotalMinutes.  Sort by appt ID.  Hint:  use a nested SELECT.  
	SELECT A.ApptID AS "ApptID", ApptDateTime AS "Date", PatientLName AS "Patient Name", DrLName AS "Doctor", SUM(BlockCodeMinutes) AS "TotalMinutes"
		FROM APPOINTMENT_ttn A, DOCTOR_ttn D, PATIENT_ttn P, APPTDETAIL_ttn AD, BLOCK_ttn B
	WHERE A.DrID = D.DrID AND
	A.PatientID = P.PatientID AND
	A.ApptID = AD.ApptID AND
	AD.BlockCode = B.BlockCode 
	GROUP BY A.ApptID, ApptDateTime, PatientLName, DrLName
	HAVING SUM(BlockCodeMinutes) > AVG(BlockCodeMinutes);

	--31. List the appt ID, date, patient last name, pay type description, insurance company, and count of reason codes for all 
	--appointments that have 2 or more reason. Sort by count of reason codes in descending order, then by appt ID in ascending 
	--order.  Use the following column headings: ApptID, Date, Patient, PayType, InsCo, ReasonCount.
	SELECT A.ApptID AS "ApptID", ApptDateTime AS "Date", PatientLName AS "Patient Name", BillingTypeDesc AS "BillType", InsCoName AS "InsCo", COUNT(AD.ReasonCode) AS "ReasonCount"
		FROM APPOINTMENT_ttn A, BILLINGTYPE_ttn B, PATIENT_ttn P, APPTDETAIL_ttn AD, APPTREASON_ttn AR, INSURANCECO_ttn I
	WHERE A.PatientID = P.PatientID AND
	A.ApptID = AD.ApptID AND
	A.BillingType = B.BillingType AND
	AD.ReasonCode = AR.ApptReasonCode AND
	A.InsCoID = I.InsCoID
	GROUP BY A.ApptID, ApptDateTime, PatientLName, BillingTypeDesc, InsCoName
	HAVING COUNT(AD.ReasonCode) >= '2';

	--32. List the reason code, reason description, block code, block minutes for the appt detail row with the highest number of 
	--minutes in each appointment.  Show the minutes formatted as “# minutes” and use the following column headings: Reason Code, 
	--Description, Block Code, Minutes. Hint: use a GROUP by and nested SELECT.
	SELECT ApptReasonCode AS "Reason Code", ApptReasonDesc AS "Description", AD.BlockCode AS "Block Code", BlockCodeMinutes AS "Minutes"
		FROM APPTDETAIL_ttn AD, APPTREASON_ttn AR, BLOCK_ttn B
	WHERE AD.ReasonCode = AR.ApptReasonCode AND
	AD.BlockCode = B.BlockCode AND
	(AD.ApptID, BlockCodeMinutes) IN (SELECT ApptID, MAX(BlockCodeMinutes) FROM APPTDETAIL_ttn GROUP BY ApptID);

	--Turn off logging.
		set echo on

	--CLose the file.
		spool off