SELECT LAST_NAME, JOB_ID, e.DEPARTMENT_ID, DEPARTMENT_NAME
FROM employees e, departments d
WHERE e.department_id = d.DEPARTMENT_ID -- AND e.manager_id = d.manager_id
AND DEPARTMENT_NAME = 'Shipping'
order by last_name;


SELECT LAST_NAME, JOB_ID, DEPARTMENT_ID, DEPARTMENT_NAME
FROM employees NATURAL JOIN departments
WHERE DEPARTMENT_NAME = 'Shipping'
order by last_name;
 
select * from employees;
select * from departments;

CREATE TABLE bonuses (employee_id NUMBER, bonus NUMBER DEFAULT 100); 

desc bonuses; 

INSERT ALL
  INTO bonuses values (145, 100)
  INTO bonuses values (146, 100)
  INTO bonuses values (147, 100)  
SELECT * FROM DUAL;
rollback;
select * from bonuses order by 1; 
select * from employees;

SELECT employee_id, salary, department_id FROM employees
   WHERE department_id = 80 and salary > 10000;

MERGE INTO bonuses D
   USING (SELECT employee_id, salary, department_id FROM employees
   WHERE department_id = 80) S
   ON (D.employee_id = S.employee_id)
   WHEN MATCHED THEN UPDATE SET D.bonus = D.bonus + S.salary*.01
     DELETE WHERE (S.salary > 10000)
   WHEN NOT MATCHED THEN INSERT (D.employee_id, D.bonus)
     VALUES (S.employee_id, S.salary*.01)
     WHERE (S.salary <= 8000);
