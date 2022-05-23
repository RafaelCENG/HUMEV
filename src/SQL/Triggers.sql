DROP TRIGGER  IF EXISTS projects_number_update;
DROP TRIGGER  IF EXISTS evaluationresult_names_insert;
DROP TRIGGER IF EXISTS Update_TemporaryFinalGrade;
DROP TRIGGER IF EXISTS Insert_TemporaryFinalGrade;
DROP TRIGGER IF EXISTS After_Insert_Tempresult_To_FinalResult;
DROP TRIGGER IF EXISTS After_Update_Tempresult_To_FinalResult;
DROP TRIGGER IF EXISTS Insert_RequestEvalution_To_TempResult;
DROP TRIGGER IF EXISTS set_created_date;
DROP TRIGGER IF EXISTS set_created_regdate;
DROP TRIGGER IF EXISTS company_changes;
DROP TRIGGER IF EXISTS insert_job;
DROP TRIGGER IF EXISTS manager_changes;
DROP TRIGGER IF EXISTS insert_job_a;
DROP TRIGGER IF EXISTS update_job;
DROP TRIGGER IF EXISTS delete_job;
DROP TRIGGER IF EXISTS update_employee;
DROP TRIGGER IF EXISTS delete_employee;
DROP TRIGGER IF EXISTS insert_employee;
DROP TRIGGER IF EXISTS delete_requestevaluation;
DROP TRIGGER IF EXISTS update_requestevaluation;
DROP TRIGGER IF EXISTS insert_requestevaluation;



DELIMITER $$
CREATE TRIGGER projects_number_update
  AFTER INSERT ON project
  FOR EACH ROW 
	BEGIN
	UPDATE TempResult
		SET employee_NumberOfProjects = employee_NumberOfProjects + 1
		WHERE TempResult.emplusr = NEW.project_username;
	END$$

CREATE TRIGGER evaluationresult_names_insert
  AFTER INSERT ON tempresult
  FOR EACH ROW 
	BEGIN
	INSERT INTO evaluationresult (empl_username,job_id,evaluator_username) VALUES (New.emplusr,NEW.jobid,NEW.evalusr);
	END$$


CREATE TRIGGER Insert_TemporaryFinalGrade
  BEFORE INSERT ON tempresult
  FOR EACH ROW
  BEGIN
	IF(((new.grade1 BETWEEN 0 AND 4) OR (new.grade1 IS NULL)) AND ((new.grade2 BETWEEN 0 AND 4) OR (new.grade2 IS NULL)) AND ((new.grade3 BETWEEN 0 AND 2) OR (new.grade1 IS NULL))) THEN
		IF(new.grade1 IS NOT NULL  AND new.grade2 IS NOT NULL AND new.grade3 IS NOT NULL) THEN
			SET NEW.TemporaryFinalGrade = new.grade1 + new.grade2 + new.grade3;
		END IF;
	ELSE
		SIGNAL SQLSTATE VALUE '45000'
		SET MESSAGE_TEXT = 'For Grade1 choose 0-4, For Grade2 choose 0-4, For Grade3 choose 0-2 OR NULL';
   END IF;
  END$$

CREATE TRIGGER Update_TemporaryFinalGrade
  BEFORE UPDATE ON tempresult
  FOR EACH ROW
  BEGIN
	IF(((new.grade1 BETWEEN 0 AND 4) OR (new.grade1 IS NULL)) AND ((new.grade2 BETWEEN 0 AND 4) OR (new.grade2 IS NULL)) AND ((new.grade3 BETWEEN 0 AND 2) OR (new.grade1 IS NULL))) THEN
		IF(new.grade1 IS NOT NULL  AND new.grade2 IS NOT NULL AND new.grade3 IS NOT NULL) THEN
			SET NEW.TemporaryFinalGrade = new.grade1 + new.grade2 + new.grade3;
		END IF;
    ELSE
		SIGNAL SQLSTATE VALUE '45000'
		SET MESSAGE_TEXT = 'For Grade1 choose 0-4, For Grade2 choose 0-4, For Grade3 choose 0-2 OR NULL';
   END IF;
  END$$


CREATE TRIGGER After_Insert_Tempresult_To_FinalResult
  AFTER  INSERT  ON tempresult
  FOR EACH ROW
  BEGIN
    IF (NEW.TemporaryFinalGrade IS NOT NULL) THEN
		UPDATE evaluationresult
        SET FinalGrade = NEW.TemporaryFinalGrade ,FinalComments = NEW.evaluator_comments
        WHERE evaluationresult.EvID = New.ID;
	END IF;
  END$$


CREATE TRIGGER After_Update_Tempresult_To_FinalResult
  AFTER  UPDATE  ON tempresult
  FOR EACH ROW
  BEGIN
    IF (NEW.TemporaryFinalGrade IS NOT NULL) THEN
		UPDATE evaluationresult
        SET FinalGrade = NEW.TemporaryFinalGrade ,FinalComments = NEW.evaluator_comments
        WHERE evaluationresult.EvID = New.ID;
	END IF;
  END$$


CREATE TRIGGER Insert_RequestEvalution_To_TempResult
  AFTER INSERT ON requestevaluation
  FOR EACH ROW 
	BEGIN
	INSERT INTO tempresult (emplusr,jobid) VALUES (New.emplreq,NEW.jobreq);
    UPDATE tempresult
    INNER JOIN job
    SET tempresult.evalusr = job.job_evaluator
    WHERE job.job_id = tempresult.jobid;
    UPDATE evaluationresult
    INNER JOIN tempresult
    SET evaluationresult.evaluator_username = tempresult.evalusr
    WHERE evaluationresult.job_id = tempresult.jobid;
	END$$



CREATE TRIGGER set_created_date
AFTER INSERT ON users
FOR EACH ROW
BEGIN
	INSERT INTO user_reg_date (reg_username) VALUES (New.user_username);
END$$

CREATE TRIGGER set_created_regdate
BEFORE INSERT ON user_reg_date
FOR EACH ROW 
BEGIN
	SET NEW.user_regdate = now();
END$$


CREATE TRIGGER company_changes
BEFORE UPDATE ON company
FOR EACH ROW
BEGIN
	IF NEW.AFM<>OLD.AFM THEN SET NEW.AFM = OLD.AFM;
    END IF;
    IF NEW.DOY<>OLD.DOY THEN SET NEW.DOY = OLD.DOY;
    END IF;
    IF NEW.name<>OLD.name THEN SET NEW.name = OLD.name;
    END IF;
END$$


##Trigger  το οποιο δεν αφήνει κάποια συγκεκριμένα πεδία να αλλαχτούν απο το πίνακα του manager
CREATE TRIGGER manager_changes
BEFORE UPDATE ON manager
FOR EACH ROW
BEGIN
	IF NEW.manager_exp_years<>OLD.manager_exp_years THEN SET NEW.manager_exp_years = OLD.manager_exp_years;
    END IF;
    IF NEW.company_firm<>OLD.company_firm THEN SET NEW.company_firm = OLD.company_firm;
    END IF;
END$$




##Kanonika einai BEFORE INSERT KAI EPEITA KANOUME AFTER GIA NA DOUME AN EINAI SUCCESSFULL. OMOS LOGO PROBLIMATOS ME TO USERNAME DEN MPOROUME NA KANOUME TON ELEGXO
CREATE TRIGGER insert_job
AFTER INSERT ON job
FOR EACH ROW
BEGIN
	DECLARE current_username VARCHAR(20);
    -- SELECT users.user_username INTO current_username WHERE  users.user_username = LoginSession.user_username;
	SELECT USER() INTO current_username;
	INSERT INTO data_log(username,timestamp,action,table_name,yes_no)
	VALUES(current_username,NOW(),"INSERT","job","yes");
END$$

CREATE TRIGGER update_job
AFTER UPDATE ON job
FOR EACH ROW
BEGIN
	DECLARE current_username VARCHAR(20);
    -- SELECT users.user_username INTO current_username WHERE  users.user_username = LoginSession.user_username;
	SELECT USER() INTO current_username;
	INSERT INTO data_log(username,timestamp,action,table_name,yes_no)
	VALUES(current_username,NOW(),"UPDATE","job","yes");
END$$

CREATE TRIGGER delete_job
AFTER DELETE ON job
FOR EACH ROW
BEGIN
	DECLARE current_username VARCHAR(20);
    -- SELECT users.user_username INTO current_username WHERE  users.user_username = LoginSession.user_username;
	SELECT USER() INTO current_username;
	INSERT INTO data_log(username,timestamp,action,table_name,yes_no)
	VALUES(current_username,NOW(),"DELETE","job","yes");
END$$



#######################################################################
##Kanonika einai BEFORE INSERT KAI EPEITA KANOUME AFTER GIA NA DOUME AN EINAI SUCCESSFULL. OMOS LOGO PROBLIMATOS ME TO USERNAME DEN MPOROUME NA KANOUME TON ELEGXO
CREATE TRIGGER insert_employee
AFTER INSERT ON employee
FOR EACH ROW
BEGIN
	DECLARE current_username VARCHAR(20);
    -- SELECT users.user_username INTO current_username WHERE  users.user_username = LoginSession.user_username;
	SELECT USER() INTO current_username;
	INSERT INTO data_log(username,timestamp,action,table_name,yes_no)
	VALUES(current_username,NOW(),"INSERT","job","yes");
END$$

CREATE TRIGGER update_employee
AFTER UPDATE ON employee
FOR EACH ROW
BEGIN
	DECLARE current_username VARCHAR(20);
    -- SELECT users.user_username INTO current_username WHERE  users.user_username = LoginSession.user_username;
	SELECT USER() INTO current_username;
	INSERT INTO data_log(username,timestamp,action,table_name,yes_no)
	VALUES(current_username,NOW(),"UPDATE","job","yes");
END$$

CREATE TRIGGER delete_employee
AFTER DELETE ON employee
FOR EACH ROW
BEGIN
	DECLARE current_username VARCHAR(20);
    -- SELECT users.user_username INTO current_username WHERE  users.user_username = LoginSession.user_username;
	SELECT USER() INTO current_username;
	INSERT INTO data_log(username,timestamp,action,table_name,yes_no)
	VALUES(current_username,NOW(),"DELETE","job","yes");
END$$


########################################################################
##Kanonika einai BEFORE INSERT KAI EPEITA KANOUME AFTER GIA NA DOUME AN EINAI SUCCESSFULL. OMOS LOGO PROBLIMATOS ME TO USERNAME DEN MPOROUME NA KANOUME TON ELEGXO
CREATE TRIGGER insert_requestevaluation
AFTER INSERT ON requestevaluation
FOR EACH ROW
BEGIN
	DECLARE current_username VARCHAR(20);
    -- SELECT users.user_username INTO current_username WHERE  users.user_username = LoginSession.user_username;
	SELECT USER() INTO current_username;
	INSERT INTO data_log(username,timestamp,action,table_name,yes_no)
	VALUES(current_username,NOW(),"INSERT","job","yes");
END$$

CREATE TRIGGER update_requestevaluation
AFTER UPDATE ON requestevaluation
FOR EACH ROW
BEGIN
	DECLARE current_username VARCHAR(20);
    -- SELECT users.user_username INTO current_username WHERE  users.user_username = LoginSession.user_username;
	SELECT USER() INTO current_username;
	INSERT INTO data_log(username,timestamp,action,table_name,yes_no)
	VALUES(current_username,NOW(),"UPDATE","job","yes");
END$$

CREATE TRIGGER delete_requestevaluation
AFTER DELETE ON requestevaluation
FOR EACH ROW
BEGIN
	DECLARE current_username VARCHAR(20);
    -- SELECT users.user_username INTO current_username WHERE  users.user_username = LoginSession.user_username;
	SELECT USER() INTO current_username;
	INSERT INTO data_log(username,timestamp,action,table_name,yes_no)
	VALUES(current_username,NOW(),"DELETE","job","yes");
END$$
DELIMITER ;