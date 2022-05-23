DROP PROCEDURE IF EXISTS employee_evaluations;
DROP PROCEDURE IF EXISTS Done_Evaluations;
DROP PROCEDURE IF EXISTS IN_PROGRESS_Evaluations;

DELIMITER $$
CREATE PROCEDURE employee_evaluations(IN employee_name VARCHAR(25),IN employee_surname VARCHAR(35))
BEGIN
   DECLARE finishedFlag INT;
   DECLARE evaluator VARCHAR(12);
   DECLARE emp_name VARCHAR(25);
   DECLARE emp_surname VARCHAR(35);
   DECLARE emp_username VARCHAR(15);
   DECLARE eva_name VARCHAR(25);
   DECLARE eva_surname VARCHAR(35);
   DECLARE emp_role ENUM('Administrator','Manager','Employee','Evaluator');
   DECLARE gd1 INT;
   DECLARE gd2 INT;
   DECLARE gd3 INT;
   DECLARE req INT;
   DECLARE fg INT;
   DECLARE user_cursor CURSOR FOR 
   SELECT user_name ,user_surname,user_username,user_role 	FROM users	WHERE user_name = employee_name AND user_surname=employee_surname AND user_role='Employee';
   DECLARE job_cursor CURSOR FOR
   SELECT jobreq FROM requestevaluation	WHERE emplreq = emp_username;
   DECLARE fg_cursor CURSOR FOR
   SELECT FinalGrade FROM evaluationresult	WHERE emp_username = empl_username;
   DECLARE eval_cursor CURSOR FOR
   SELECT user_name, user_surname FROM users INNER JOIN tempresult
   WHERE tempresult.evalusr = users.user_username AND users.user_role = 'Evaluator' LIMIT 1;
   DECLARE CONTINUE HANDLER FOR NOT FOUND SET finishedFlag=1;
   SET finishedFlag = 0;
	OPEN user_cursor;
	FETCH user_cursor INTO emp_name,emp_surname,emp_username,emp_role;
	OPEN job_cursor;
    FETCH job_cursor INTO req;
    OPEN fg_cursor;
    FETCH fg_cursor INTO fg;
    OPEN eval_cursor;
    FETCH eval_cursor INTO eva_name,eva_surname;
	IF (emp_name is Null OR emp_surname is NULL OR emp_role <> 'Employee') THEN
	    Select 'Wrong Information' As 'OUTPUT';
	    Select 'Wrong Information' As 'OUTPUT';
    ELSE
	WHILE(finishedFlag=0) DO
	SELECT user_name AS 'Employee Name',user_surname AS 'Employee Surname',user_username AS 'Employee Username',user_role AS 'Employee Role'
	FROM users WHERE user_name = employee_name AND user_surname=employee_surname AND user_role='Employee';
    FETCH user_cursor INTO emp_name,emp_surname,emp_username,emp_role;
    SELECT emplreq AS 'Employee', jobreq AS 'Job Request' 	FROM requestevaluation	WHERE emplreq = emp_username;
    FETCH job_cursor INTO req;
    SELECT evalusr AS 'Evaluator Username' ,grade1 AS 'Grade 1',grade2  AS 'Grade 2',grade3  AS 'Grade 3'
    FROM tempresult
	WHERE emplusr = emp_username;
    FETCH eval_cursor INTO eva_name,eva_surname;
    SELECT user_name AS 'Evaluator Name',user_surname AS 'Evaluator Surname'
	FROM users
    INNER JOIN tempresult
	WHERE tempresult.evalusr = users.user_username AND users.user_role = 'Evaluator' LIMIT 1;
    SELECT   IF(FinalGrade IS NULL,'Αξιολόγηση σε εξέλιξη',FinalGrade) AS 'FINAL GRADE'
	FROM evaluationresult WHERE emp_username = empl_username;
    FETCH fg_cursor INTO fg;
    SELECT  emp_username,req,fg,eva_name,eva_surname;
	END WHILE;
END IF;
END $$


DELIMITER ;

CALL employee_evaluations('Giannis','Nicolaou');
CALL employee_evaluations('Cleomenis','Georgiadis');
CALL employee_evaluations('Cleomenis','Georgiadissad');

DELIMITER $$
CREATE PROCEDURE Done_Evaluations(IN Id_Of_Job INT)
BEGIN
	DECLARE finishedFlag INT;
	DECLARE emp_username VARCHAR(15);
    DECLARE id INT; 
    DECLARE Grade INT;
    DECLARE COUNT INT;
    DECLARE job_cursor CURSOR FOR 
    SELECT emplusr,jobid,TemporaryFinalGrade 	FROM tempresult	WHERE jobid=Id_Of_Job;
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET finishedFlag=1;
    SET COUNT = 0;
    SET finishedFlag = 0;
	OPEN job_cursor;
	FETCH job_cursor INTO emp_username,id,Grade;
    IF (id = Id_Of_Job) THEN
    WHILE(finishedFlag=0) DO
		IF(GRADE IS NOT NULL) THEN
			Select 'Οριστικοποιημένοι πίνακες' AS 'Output',job_id AS 'FOR JOB',FinalGrade AS 'FinalGrade',empl_username AS 'Employee'
			FROM evaluationresult
			WHERE (job_id = Id_Of_Job AND FinalGrade IS NOT NULL) ORDER BY FinalGrade DESC;
       ELSE
			SET COUNT = COUNT + 1;
		END IF;
		FETCH job_cursor INTO emp_username,id,Grade;
	END WHILE;
    ELSE
	   SELECT 'Δεν υπαρχουν υποψήφιοι' as 'OUTPUT' , ID_Of_Job AS 'FOR JOB';
	END IF;
    IF (COUNT > 0 ) THEN
		SELECT COUNT AS 'Αξιολόγηση σε εξέλιξη', Id_Of_Job AS 'FOR JOB';
	END IF;
END $$
DELIMITER ;


##Proti Periptosi
CALL Done_Evaluations(1);
##Proti Periptosi
CALL Done_Evaluations(3);
##Deuteri Periptosi
CALL Done_Evaluations(5);
##Kanis(Oloi null) Ara deuteri periptosi
CALL Done_Evaluations(7);
##Triti periptosi
CALL Done_Evaluations(8);






DELIMITER $$
CREATE PROCEDURE IN_PROGRESS_Evaluations(IN Id_Of_Job INT,IN evaluator VARCHAR(12))
BEGIN
	DECLARE finishedFlag INT;
	DECLARE eval_username VARCHAR(12);
    DECLARE id INT; 
    DECLARE Grade INT;
    DECLARE Progress_cursor CURSOR FOR 
    SELECT evalusr,jobid,TemporaryFinalGrade 	FROM tempresult	WHERE jobid=Id_Of_Job;
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET finishedFlag=1;
    SET finishedFlag = 0;
	OPEN Progress_cursor;
    FETCH Progress_cursor INTO eval_username,id,Grade;
    WHILE(finishedFlag=0) DO
    FETCH Progress_cursor INTO eval_username,id,Grade;
		IF(Grade IS NULL AND id = Id_Of_Job) THEN
			Select 'Αξιολογήσεις σε εξέλιξη' AS 'Output',jobid AS 'FOR JOB',emplusr AS 'Employee',evaluator AS 'Evaluator' , grade1 AS 'ΒΑΘΜΟΣ 1',grade2 AS'ΒΑΘΜΟΣ 2',grade3 AS 'ΒΑΘΜΟΣ 3'
			FROM tempresult
		    WHERE (jobid = Id_Of_Job AND TemporaryFinalGrade IS NULL);
		END IF;	
    END WHILE;
END $$
DELIMITER ;

CALL IN_PROGRESS_Evaluations(5,'msmith');
CALL IN_PROGRESS_Evaluations(4,'msmith');




#################################################################################################
/*
CREATE PROCEDURE official3.2(IN Id_Of_Job INT,IN evaluator VARCHAR(12))
BEGIN
	DECLARE finishedFlag INT;
	DECLARE eval_username VARCHAR(12);
    DECLARE id INT; 
    DECLARE g1 INT;
    DECLARE g2 INT;
    DECLARE g3 INT;
    DECLARE Progress_cursor CURSOR FOR 
    SELECT evalusr,jobid,g1,g2,g3 FROM tempresult	WHERE jobid=Id_Of_Job;
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET finishedFlag=1;
    SET finishedFlag = 0;
	OPEN Progress_cursor;
    FETCH Progress_cursor INTO eval_username,id,g1,g2,g3
    WHILE(finishedFlag=0) DO
    FETCH Progress_cursor INTO eval_username,id,Grade;
		IF(g1 IS NOT NULL AND g2 IS NOT NULL AND g3 IS NOT NULL ) THEN
			UPDATE evaluationresult
				SET FinalGrade  = g1 + g2 + g3
		    WHERE (job_id = Id_Of_Job AND evaluator_username = evaluator);
		END IF;	
    END WHILE;
END $$
*/

