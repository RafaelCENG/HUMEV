DROP DATABASE IF EXISTS HUMEV_DATABASE;
CREATE  DATABASE HUMEV_DATABASE;
USE HUMEV_DATABASE;


CREATE TABLE IF NOT EXISTS company
(
  AFM CHAR(9) NOT NULL,
  DOY VARCHAR(15) NOT NULL,
  name VARCHAR(35) NOT NULL default 'NO-NAME registered',
  phone INT NOT NULL,
  street VARCHAR(15) NOT NULL,
  num INT NOT NULL,
  city VARCHAR(15) NOT NULL,
  country VARCHAR(15) NOT NULL,
  PRIMARY KEY (AFM)
);


CREATE TABLE IF NOT EXISTS Users
(
  user_username VARCHAR(15) NOT NULL,
  user_password VARCHAR(25) NOT NULL,
  user_name VARCHAR(25) NOT NULL,
  user_surname VARCHAR(35) NOT NULL,
  user_email VARCHAR(30) NOT NULL,
  user_role ENUM('Administrator','Manager','Employee','Evaluator') NOT NULL,
  PRIMARY KEY (user_username)
);

CREATE TABLE IF NOT EXISTS User_reg_date
(
  reg_username VARCHAR(15) NOT NULL,
  user_regdate TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  CONSTRAINT user_is FOREIGN KEY (reg_username) REFERENCES Users(user_username)
  ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS administrator
(
    Admin_username VARCHAR(15) NOT NULL,
    Admin_password VARCHAR(10) NOT NULL,
	PRIMARY KEY(Admin_username),
    CONSTRAINT admin_is FOREIGN KEY (Admin_username) REFERENCES users(user_username)
    ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS manager
(
  manager_username VARCHAR(12) NOT NULL,
  manager_exp_years tinyint NOT NULL,
  company_firm CHAR(9) NOT NULL,
  PRIMARY KEY (manager_username),
  CONSTRAINT manager_is FOREIGN KEY (manager_username) REFERENCES users(user_username)
  ON UPDATE CASCADE ON DELETE CASCADE,
  CONSTRAINT cmp FOREIGN KEY (company_firm) REFERENCES company (AFM)
  ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS antikeim
(
  antikeim_title VARCHAR(36) NOT NULL,
  antikeim_descr TINYTEXT NOT NULL,
  belongs_to VARCHAR(36),
  PRIMARY KEY (antikeim_title),
  CONSTRAINT ANTIKEIMENO FOREIGN KEY (belongs_to) REFERENCES antikeim(antikeim_title)
  ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS employee
(
  employee_username VARCHAR(12) NOT NULL,
  employee_bio TEXT NOT NULL,
  employee_sistatikes VARCHAR(35) NOT NULL,
  employee_certificates VARCHAR(35) NOT NULL,
  employee_awards VARCHAR(35) NOT NULL DEFAULT 'NO AWARDS',
  employee_AFM_Etairias CHAR(9) NOT NULL,
  employee_interview TEXT NULL,
  PRIMARY KEY (employee_username),
  CONSTRAINT WORKS_FOR FOREIGN KEY (employee_AFM_Etairias) REFERENCES company(AFM)
  ON UPDATE CASCADE ON DELETE CASCADE,
  CONSTRAINT IS_USER FOREIGN KEY (employee_username) REFERENCES users(user_username)
  ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS languages
(
  languages_username VARCHAR(12) NOT NULL,
  lang SET('EN','FR','SP','GR'),
  CONSTRAINT has_languages FOREIGN KEY (languages_username) REFERENCES employee(employee_username)
  ON UPDATE CASCADE ON DELETE CASCADE
);


CREATE TABLE IF NOT EXISTS project
(
  ProjectID INT NOT NULL AUTO_INCREMENT,
  project_username VARCHAR(12),
  project_num INT NOT NULL,
  descr VARCHAR(100) NOT NULL,
  url VARCHAR(60) NOT NULL,
  PRIMARY KEY (ProjectID,project_num, project_username),
  CONSTRAINT projectwork FOREIGN KEY (project_username) REFERENCES employee(employee_username)
  ON UPDATE CASCADE ON DELETE CASCADE
);


CREATE TABLE IF NOT EXISTS degree
(
  deg_titlos VARCHAR(50) NOT NULL,
  deg_idryma VARCHAR(40) NOT NULL,
  deg_bathmida ENUM('LYKEIO','UNIV','MASTER','PHD'),
  PRIMARY KEY (deg_titlos,deg_idryma)
);

CREATE TABLE has_degree (
empl_usrname VARCHAR(12) NOT NULL,
degr_title VARCHAR(50) NOT NULL,
degr_idryma VARCHAR (40) NOT NULL,
etos YEAR,
grade FLOAT,
PRIMARY KEY (degr_title, degr_idryma, empl_usrname),
CONSTRAINT HAS_DEGR FOREIGN KEY (degr_title, degr_idryma) REFERENCES degree(deg_titlos, deg_idryma) ON DELETE CASCADE ON UPDATE CASCADE,
CONSTRAINT HAS_Empl FOREIGN KEY (empl_usrname) REFERENCES employee(employee_username) ON DELETE CASCADE ON UPDATE CASCADE
);



CREATE TABLE IF NOT EXISTS evaluator
(
  evaluator_username VARCHAR(12) NOT NULL,
  evaluator_exp_years TINYINT NOT NULL,
  evaluator_firm CHAR(9) NOT NULL,
  PRIMARY KEY (evaluator_username),
  CONSTRAINT ev_firm FOREIGN KEY (evaluator_firm) REFERENCES company (AFM)
  ON UPDATE CASCADE ON DELETE CASCADE,
  CONSTRAINT evaluator_is FOREIGN KEY (evaluator_username) REFERENCES users(user_username)
  ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS job
(
  job_id INT NOT NULL AUTO_INCREMENT,
  job_start_date DATE NOT NULL,
  job_salary FLOAT NOT NULL,
  job_position VARCHAR(40) NOT NULL,
  job_edra VARCHAR(45) NOT NULL,
  job_evaluator VARCHAR(12) NOT NULL,
  job_announce_date DATE NOT NULL,
  job_submission_date DATE NOT NULL,
  PRIMARY KEY (job_id),
  CONSTRAINT job_has FOREIGN KEY (job_evaluator) REFERENCES evaluator(evaluator_username)
  ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS requestevaluation
(
  emplreq VARCHAR(12) NOT NULL,
  jobreq INT NOT NULL,
  PRIMARY KEY (jobreq,emplreq),
  CONSTRAINT emplrequest FOREIGN KEY (emplreq) REFERENCES employee(employee_username)
  ON UPDATE CASCADE ON DELETE CASCADE,
  CONSTRAINT jobrequest FOREIGN KEY (jobreq) REFERENCES job(job_id)
  ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS evaluationresult
(
  EvID INT NOT NULL AUTO_INCREMENT,
  FinalGrade INT  DEFAULT NULL,
  FinalComments VARCHAR(255)  DEFAULT 'NO COMMENTS',
  empl_username VARCHAR(12) NOT NULL,
  job_id INT NOT NULL,
  evaluator_username VARCHAR(12) NOT NULL,
  PRIMARY KEY (EvID),
  CONSTRAINT emplusr FOREIGN KEY (empl_username) REFERENCES employee(employee_username)
  ON UPDATE CASCADE ON DELETE CASCADE,
  CONSTRAINT jobid FOREIGN KEY (job_id) REFERENCES job(job_id)
  ON UPDATE CASCADE ON DELETE CASCADE
);
ALTER TABLE evaluationresult AUTO_INCREMENT=1;

CREATE TABLE IF NOT EXISTS TempResult
( 
  ID INT NOT NULL AUTO_INCREMENT,
  emplusr VARCHAR(12) NOT NULL,
  jobid INT NOT NULL,
  evalusr VARCHAR(12) NOT NULL DEFAULT 'No Evaluator',
  employees_interview TEXT,
  manager_report TEXT,
  employee_sistatikes VARCHAR(35) NOT NULL DEFAULT 'Null',
  employee_certificates VARCHAR(35) NOT NULL DEFAULT 'Null',
  employee_awards VARCHAR(35) NOT NULL DEFAULT 'NO AWARDS',
  employee_NumberOfProjects INT NOT NULL DEFAULT 0,
  evaluator_comments VARCHAR(255),
  grade1 INT,
  grade2 INT,
  grade3 INT,
  TemporaryFinalGrade INT,
  PRIMARY KEY (ID),
  CONSTRAINT employee_username FOREIGN KEY (emplusr) REFERENCES employee(employee_username)
  ON UPDATE CASCADE ON DELETE CASCADE,
  CONSTRAINT job_id FOREIGN KEY (jobid) REFERENCES job(job_id)
  ON UPDATE CASCADE ON DELETE CASCADE
 ## CONSTRAINT evaluator_username FOREIGN KEY (evalusr) REFERENCES evaluator(evaluator_username)
  ##ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS needs
(
  needs_jobid INT NOT NULL,
  needs_title VARCHAR(36) NOT NULL,
  PRIMARY KEY (needs_jobid,needs_title),
  CONSTRAINT needs_job FOREIGN KEY (needs_jobid) REFERENCES job(job_id)
  ON UPDATE CASCADE ON DELETE CASCADE,
  CONSTRAINT needs_antikeimeno FOREIGN KEY (needs_title) REFERENCES antikeim(antikeim_title)
  ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS manager_rep
(
	emplusr VARCHAR(12) NOT NULL,
    manusr VARCHAR(12)  NOT NULL DEFAULT 'None',
    report VARCHAR(255) NOT NULL DEFAULT 'There is no report yet',
    firm CHAR(9) NOT NULL DEFAULT 'None',
	CONSTRAINT employee_usrn FOREIGN KEY (emplusr) REFERENCES employee(employee_username)
    ON UPDATE CASCADE ON DELETE CASCADE
);


CREATE TABLE data_log (
   username VARCHAR(15) NOT NULL,
   timestamp   TIMESTAMP,
   action VARCHAR(255),
   table_name VARCHAR(255),
   yes_no VARCHAR(255)
);
