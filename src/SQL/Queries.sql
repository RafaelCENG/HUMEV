/* Query to update the AFM tou manager_Rep*/
UPDATE manager_rep
INNER JOIN employee ON(manager_rep.emplusr = employee.employee_username)
SET manager_rep.firm = employee.employee_AFM_Etairias;

/* Query to update the Username tou manager_rep*/
UPDATE manager_rep
INNER JOIN manager ON(manager_rep.firm = manager.company_firm)
SET manager_rep.manusr = manager.manager_username;

/* Query to update the TempResult me kapoia stoixia*/
UPDATE tempresult
INNER JOIN employee ON (tempresult.emplusr = employee.employee_username)
SET tempresult.employees_interview = employee.employee_interview;

UPDATE tempresult
INNER JOIN employee ON (tempresult.emplusr = employee.employee_username)
SET tempresult.employee_sistatikes = employee.employee_sistatikes;

UPDATE tempresult
INNER JOIN employee ON (tempresult.emplusr = employee.employee_username)
SET tempresult.employee_certificates = employee.employee_certificates;

UPDATE tempresult
INNER JOIN employee ON (tempresult.emplusr = employee.employee_username)
SET tempresult.employee_awards = employee.employee_awards;

/* Query to update the TempResult me to report tou manager*/
UPDATE tempresult
INNER JOIN manager_rep ON (tempresult.emplusr = manager_rep.emplusr)
SET tempresult.manager_report = manager_rep.report;

/* Query to update the TempResult me ton arithmo ton project tou employee*/
UPDATE TempResult 
   SET employee_NumberOfProjects = (
       SELECT COUNT(project_username) 
		FROM project 
        WHERE TempResult.emplusr = project.project_username 
       );

       