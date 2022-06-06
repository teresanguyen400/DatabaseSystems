	--Create your output file (include the full path). This will start logging to the specified file .
		spool 'C:\Users\redli\OneDrive\Desktop\project2_ttn.txt'
	
	--This will ensure that all input and output is logged to the file.
		set echo on

	--Teresa Nguyen
	--INSY 3304-001
	--Project 2

	--Drop all tables so that any previously created tables will be deleted then re-created below. Otherwise, there will be errors
	--for each CREATE TABLE statements because the tables were created in a previous run of the SQL file. 
	--IMPORTAT: Drop the tables in the OPPOSITE order they were created.

	DROP TABLE PATIENT_ttn CASCADE CONSTRAINTS;
	DROP TABLE BILLINGTYPE_ttn CASCADE CONSTRAINTS;
	DROP TABLE INSURANCECO_ttn CASCADE CONSTRAINTS;
	DROP TABLE DOCTOR_ttn CASCADE CONSTRAINTS;
	DROP TABLE PMTSTATUS_ttn CASCADE CONSTRAINTS;
	DROP TABLE APPTSTATUS_ttn CASCADE CONSTRAINTS;
	DROP TABLE BLOCK_ttn CASCADE CONSTRAINTS;
	DROP TABLE APPTREASON_ttn CASCADE CONSTRAINTS;
	DROP TABLE APPTDETAIL_ttn CASCADE CONSTRAINTS;
	DROP TABLE APPOINTMENT_ttn CASCADE CONSTRAINTS;

	--Part 1A
	CREATE TABLE PATIENT_ttn(
		PatientID		NUMBER(3),
		PatientFName	VARCHAR(15)	NOT NULL,
		PatientLName	VARCHAR(15)	NOT NULL,
		PatientPhone	CHAR(10),
		PRIMARY KEY (PatientID)
		);

	CREATE TABLE BILLINGTYPE_ttn(
		BillingType		VARCHAR(2),
		BillingTypeDesc	VARCHAR(15)	NOT NULL,
		PRIMARY KEY (BillingType)
		);

	CREATE TABLE INSURANCECO_ttn(
		InsCoID		NUMBER(3),
		InsCoName	VARCHAR(15)	NOT NULL,
		PRIMARY KEY (InsCoID)
		);

	CREATE TABLE DOCTOR_ttn(
		DrID		NUMBER(1),
		DrFName		VARCHAR(15)	NOT NULL,
		DrLName		VARCHAR(15)	NOT NULL,
		PRIMARY KEY (DrID)
		);

	CREATE TABLE PMTSTATUS_ttn(
		PmtStatusCode	CHAR(2),
		PmtStatusDesc	VARCHAR(15)	NOT NULL,
		PRIMARY KEY(PmtStatusCode)
		);

	CREATE TABLE APPTSTATUS_ttn(
		ApptStatusCode	VARCHAR(2),
		ApptStatusDesc	VARCHAR(15)	NOT NULL,
		PRIMARY KEY (ApptStatusCode)
		);

	CREATE TABLE BLOCK_ttn(
		BlockCode			CHAR(2),
		BlockCodeDesc		CHAR(7)		NOT NULL,
		BlockCodeMinutes	NUMBER(2)	NOT NULL,
		PRIMARY KEY (BlockCode)
		);

	CREATE TABLE APPTREASON_ttn(
		ApptReasonCode	VARCHAR(3),
		ApptReasonDesc	VARCHAR(25)	NOT NULL,
		PRIMARY KEY (ApptReasonCode)
		);

	CREATE TABLE APPTDETAIL_ttn(
		ApptID		NUMBER(3),
		BlockCode	CHAR(2)		NOT NULL,
		ReasonCode	VARCHAR(3),
		PRIMARY KEY (ApptID,ReasonCode),
		FOREIGN KEY (ReasonCode)		REFERENCES APPTREASON_ttn,
		FOREIGN KEY (BlockCode)			REFERENCES BLOCK_ttn
		);

	CREATE TABLE APPOINTMENT_ttn(
		ApptID		NUMBER(3),
		ApptDate	DATE			NOT NULL,
		ApptTime	VARCHAR(15)		NOT NULL,
		PatientID	NUMBER(3),
		BillingType	VARCHAR(15)		NOT NULL,
		InsCoID		NUMBER(3),
		DrID		NUMBER(1)		NOT NULL,
		ApptStatusCode	VARCHAR(2)	NOT NULL,
		PmtStatusCode	CHAR(2)		NOT NULL,

		PRIMARY KEY (ApptID),
		FOREIGN KEY (PatientID)			REFERENCES PATIENT_ttn,
		FOREIGN KEY (BillingType)		REFERENCES BILLINGTYPE_ttn,
		FOREIGN	KEY (InsCoID)			REFERENCES INSURANCECO_ttn,
		FOREIGN KEY (DrID)				REFERENCES DOCTOR_ttn,
		FOREIGN KEY (PmtStatusCode)		REFERENCES PMTSTATUS_ttn,
		FOREIGN KEY (ApptStatusCode)	REFERENCES APPTSTATUS_ttn
		);

	--Part 1B
	DESCRIBE PATIENT_ttn
	DESCRIBE BILLINGTYPE_ttn
	DESCRIBE INSURANCECO_ttn
	DESCRIBE DOCTOR_ttn
	DESCRIBE PMTSTATUS_ttn
	DESCRIBE APPTSTATUS_ttn
	DESCRIBE BLOCK_ttn
	DESCRIBE APPTREASON_ttn
	DESCRIBE APPTDETAIL_ttn
	DESCRIBE APPOINTMENT_ttn

	--Part 2A
	--IMPORTANT: Insert rows into the tables in the same order the tables were created 

	--Add rows to the PATIENT table
	INSERT INTO PATIENT_ttn
	VALUES(101, 'Wesleyy', 'Tanner', '8175551193');

	INSERT INTO PATIENT_ttn
	VALUES(100, 'Brenda', 'Rhodes', '2145559191');

	INSERT INTO PATIENT_ttn
	VALUES(15, 'Jeff', 'Miner', '4695552301');

	INSERT INTO PATIENT_ttn
	VALUES(77, 'Kim', 'Jackson', '8175554911');

	INSERT INTO PATIENT_ttn
	VALUES(119, 'Mary', 'Vaugn', '8175552334');

	INSERT INTO PATIENT_ttn
	VALUES(97, 'Chris', 'Mancha', '4695553440');

	INSERT INTO PATIENT_ttn
	VALUES(28, 'Renee', 'Walker', '2145559285');

	INSERT INTO PATIENT_ttn
	VALUES(105, 'Johnny', 'Redmond', '2145551084');

	INSERT INTO PATIENT_ttn
	VALUES(84, 'James', 'Clayton', '2145559285');

	INSERT INTO PATIENT_ttn
	VALUES(23, 'Shelby', 'Davis', '8175551198');

	COMMIT;

	--Add rows to the BILLINGTYPE table
	INSERT INTO BILLINGTYPE_ttn
	VALUES('I', 'Insurance');

	INSERT INTO BILLINGTYPE_ttn
	VALUES('SP', 'Self-Pay');

	INSERT INTO BILLINGTYPE_ttn
	VALUES('WC', 'Workers Comp');

	COMMIT;

	--Add rows to the INSURANCECO table
	INSERT INTO INSURANCECO_ttn
	VALUES(323, 'Humana');

	INSERT INTO INSURANCECO_ttn
	VALUES(129, 'Blue Cross');

	INSERT INTO INSURANCECO_ttn
	VALUES(210, 'State Farm');

	INSERT INTO INSURANCECO_ttn
	VALUES(135, 'TriCare');

	COMMIT;

	--Add rows to the DOCTOR table
	INSERT INTO DOCTOR_ttn
	VALUES(2, 'Michael', 'Smith');

	INSERT INTO DOCTOR_ttn
	VALUES(5, 'Janice', 'May');

	INSERT INTO DOCTOR_ttn
	VALUES(1, 'Kay', 'Jones');

	INSERT INTO DOCTOR_ttn
	VALUES(3, 'Ray', 'Schultz');

	COMMIT;

	--Add rows to the PMTSTATUS table
	INSERT INTO PMTSTATUS_ttn
	VALUES('PF', 'Paid in Full');

	INSERT INTO PMTSTATUS_ttn
	VALUES('PP', 'Partial Pmt');

	INSERT INTO PMTSTATUS_ttn
	VALUES('NP', 'Not Paid');

	COMMIT;

	--Add rows to the APPTSTATUS table
	INSERT INTO APPTSTATUS_ttn
	VALUES('CM', 'Complete');

	INSERT INTO APPTSTATUS_ttn
	VALUES('CN', 'Confirmed');

	INSERT INTO APPTSTATUS_ttn
	VALUES('NC', 'Not Confirmed');

	COMMIT;

	--Add rows to the BLOCK table
	INSERT INTO BLOCK_ttn
	VALUES('L1', 'Level 1', '10');

	INSERT INTO BLOCK_ttn
	VALUES('L2', 'Level 2', '15');

	INSERT INTO BLOCK_ttn
	VALUES('L3', 'Level 3', '20');

	INSERT INTO BLOCK_ttn
	VALUES('L4', 'Level 4', '30');

	COMMIT;

	--Add rows to the APPTREASON table
	INSERT INTO APPTREASON_ttn
	VALUES('NP', 'New Patient');

	INSERT INTO APPTREASON_ttn
	VALUES('GBP', 'General Back Pain');

	INSERT INTO APPTREASON_ttn
	VALUES('XR', 'X-Ray');

	INSERT INTO APPTREASON_ttn
	VALUES('PSF', 'Post-Surgery Follow Up');

	INSERT INTO APPTREASON_ttn
	VALUES('SR', 'Suture Removal');

	INSERT INTO APPTREASON_ttn
	VALUES('PT', 'Physical Therapy');

	INSERT INTO APPTREASON_ttn
	VALUES('AI', 'Auto Injury');

	INSERT INTO APPTREASON_ttn
	VALUES('HP', 'Hip Pain');

	COMMIT;

	--Add rows to the APPTDETAIL table
	INSERT INTO APPTDETAIL_ttn
	VALUES(101, 'L1', 'NP');

	INSERT INTO APPTDETAIL_ttn
	VALUES(101, 'L2', 'GBP');

	INSERT INTO APPTDETAIL_ttn
	VALUES(101, 'L2', 'XR');

	INSERT INTO APPTDETAIL_ttn
	VALUES(102, 'L1', 'PSF');

	INSERT INTO APPTDETAIL_ttn
	VALUES(102, 'L1', 'SR');

	INSERT INTO APPTDETAIL_ttn
	VALUES(103, 'L1', 'PSF');

	INSERT INTO APPTDETAIL_ttn
	VALUES(103, 'L2', 'SR');

	INSERT INTO APPTDETAIL_ttn
	VALUES(104, 'L3', 'PT');

	INSERT INTO APPTDETAIL_ttn
	VALUES(105, 'L1', 'NP');

	INSERT INTO APPTDETAIL_ttn
	VALUES(105, 'L2', 'AI');

	INSERT INTO APPTDETAIL_ttn
	VALUES(106, 'L4', 'PT');

	INSERT INTO APPTDETAIL_ttn
	VALUES(107, 'L3', 'PT');

	INSERT INTO APPTDETAIL_ttn
	VALUES(108, 'L2', 'GBP');

	INSERT INTO APPTDETAIL_ttn
	VALUES(109, 'L1', 'PSF');

	INSERT INTO APPTDETAIL_ttn
	VALUES(109, 'L2', 'SR');

	INSERT INTO APPTDETAIL_ttn
	VALUES(110, 'L4', 'PT');

	INSERT INTO APPTDETAIL_ttn
	VALUES(111, 'L1', 'NP');

	INSERT INTO APPTDETAIL_ttn
	VALUES(111, 'L2', 'HP');

	INSERT INTO APPTDETAIL_ttn
	VALUES(111, 'L2', 'XR');

	COMMIT;

	--Add rows to the APPOINTMENT table
	INSERT INTO APPOINTMENT_ttn
	VALUES(101, '25-SEP-2021', '9:00 AM', 101, 'I', 323, 2, 'CM', 'PF');

	INSERT INTO APPOINTMENT_ttn
	VALUES(102, '25-SEP-2021', '9:00 AM', 100, 'I', 129, 5, 'CM', 'PP');

	INSERT INTO APPOINTMENT_ttn
	VALUES(103, '25-SEP-2021', '10:00 AM', 15, 'SP','', 2, 'CM', 'PF'); 

	INSERT INTO APPOINTMENT_ttn
	VALUES(104, '25-SEP-2021', '10:30 AM', 77, 'WC', 210, 1, 'CM', 'PF');

	INSERT INTO APPOINTMENT_ttn
	VALUES(105, '25-SEP-2021', '10:30 AM', 119, 'I', 129, 2, 'CM', 'PP');

	INSERT INTO APPOINTMENT_ttn
	VALUES(106, '25-SEP-2021', '10:30 AM', 97, 'SP','', 3, 'CM', 'NP');

	INSERT INTO APPOINTMENT_ttn
	VALUES(107, '25-SEP-2021', '11:30 AM', 28, 'I', 129, 3, 'CN', 'PP');

	INSERT INTO APPOINTMENT_ttn
	VALUES(108, '25-SEP-2021', '11:30 AM', 105, 'I', 323, 2, 'CN', 'NP');

	INSERT INTO APPOINTMENT_ttn
	VALUES(109, '25-SEP-2021', '2:00 PM', 84, 'I', 135, 5, 'CN', 'NP');

	INSERT INTO APPOINTMENT_ttn
	VALUES(110, '26-SEP-2021', '8:30 AM', 84, 'I', 135, 3, 'NC', 'NP');

	INSERT INTO APPOINTMENT_ttn
	VALUES(111, '26-SEP-2021', '8:30 AM', 23, 'WC', 323, 1, 'CN', 'NP');

	COMMIT;

	--Part 2B
	SELECT * FROM PATIENT_ttn;
	SELECT * FROM BILLINGTYPE_ttn;
	SELECT * FROM INSURANCECO_ttn;
	SELECT * FROM DOCTOR_ttn;
	SELECT * FROM APPTSTATUS_ttn;
	SELECT * FROM PMTSTATUS_ttn;
	SELECT * FROM BLOCK_ttn;
	SELECT * FROM APPTREASON_ttn;
	SELECT * FROM APPTDETAIL_ttn;
	SELECT * FROM APPOINTMENT_ttn;

	--Part 3
	UPDATE PATIENT_ttn
		SET PatientPhone = '2145551234'
	WHERE PatientID = 101;

	INSERT INTO PATIENT_ttn
	VALUES(120, 'Amanda', 'Green', '');

	INSERT INTO APPTSTATUS_ttn
	VALUES('X', 'Cancelled');

	UPDATE APPOINTMENT_ttn
		SET ApptTime = '11:30 AM'
	WHERE ApptID = 110;

	UPDATE APPOINTMENT_ttn
		SET ApptStatusCode = 'X'
	WHERE ApptID = 108;

	INSERT INTO APPTDETAIL_ttn
	VALUES(108, 'L1', 'NP');

	COMMIT;

	--Part 4
	SELECT * FROM PATIENT_ttn
	ORDER BY PatientID;

	SELECT * FROM BILLINGTYPE_ttn
	ORDER BY BillingType;

	SELECT * FROM INSURANCECO_ttn
	ORDER BY InsCoID;

	SELECT * FROM DOCTOR_ttn
	ORDER BY DrID;

	SELECT * FROM APPTSTATUS_ttn
	ORDER BY ApptStatusCode;

	SELECT * FROM PMTSTATUS_ttn
	ORDER BY PmtStatusCode;

	SELECT * FROM BLOCK_ttn
	ORDER BY BlockCode;

	SELECT * FROM APPTREASON_ttn
	ORDER BY ApptReasonCode;

	SELECT * FROM APPTDETAIL_ttn
	ORDER BY ApptID, ReasonCode;

	SELECT * FROM APPOINTMENT_ttn
	ORDER BY ApptID;


	--Turn off logging.
		set echo on

	--CLose the file.
		spool off