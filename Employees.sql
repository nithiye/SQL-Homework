--drop table if exists departments;
--drop table if exists dept_emp;
--drop table if exists dept_manager;
--drop table if exists employees;
--drop table if exists salaries;
--drop table if exists titles;


----------------------------------------------------- TABLE SCHEMATA:





-- Exported code from https://app.quickdatabasediagrams.com

CREATE TABLE "departments" (
    "dept_no" VARCHAR(4)   NOT NULL,
    "dept_name" VARCHAR(30)   NOT NULL,
    CONSTRAINT "pk_departments" PRIMARY KEY (
        "dept_no"
     )
);

CREATE TABLE "dept_emp" (
    "emp_no" INT   NOT NULL,
    "dept_no" VARCHAR(4)   NOT NULL,
    "from_date" DATE   NOT NULL,
    "to_date" DATE   NOT NULL
);

CREATE TABLE "dept_manager" (
    "dept_no" VARCHAR(4)   NOT NULL,
    "emp_no" INT   NOT NULL,
    "from_date" DATE   NOT NULL,
    "to_date" DATE   NOT NULL
);

CREATE TABLE "employees" (
    "emp_no" INT   NOT NULL,
    "birth_date" DATE   NOT NULL,
    "first_name" VARCHAR   NOT NULL,
    "last_name" VARCHAR   NOT NULL,
    "gender" VARCHAR   NOT NULL,
    "hire_date" DATE   NOT NULL,
    CONSTRAINT "pk_employees" PRIMARY KEY (
        "emp_no"
     )
);

CREATE TABLE "salaries" (
    "emp_no" INT   NOT NULL,
    "salary" INT   NOT NULL,
    "from_date" DATE   NOT NULL,
    "to_date" DATE   NOT NULL
);

CREATE TABLE "titles" (
    "emp_no" INT   NOT NULL,
    "title" VARCHAR   NOT NULL,
    "from_date" DATE   NOT NULL,
    "to_date" DATE   NOT NULL
);

ALTER TABLE "dept_emp" ADD CONSTRAINT "fk_dept_emp_emp_no" FOREIGN KEY("emp_no")
REFERENCES "employees" ("emp_no");

ALTER TABLE "dept_emp" ADD CONSTRAINT "fk_dept_emp_dept_no" FOREIGN KEY("dept_no")
REFERENCES "departments" ("dept_no");

ALTER TABLE "dept_manager" ADD CONSTRAINT "fk_dept_manager_dept_no" FOREIGN KEY("dept_no")
REFERENCES "departments" ("dept_no");

ALTER TABLE "dept_manager" ADD CONSTRAINT "fk_dept_manager_emp_no" FOREIGN KEY("emp_no")
REFERENCES "employees" ("emp_no");

ALTER TABLE "salaries" ADD CONSTRAINT "fk_salaries_emp_no" FOREIGN KEY("emp_no")
REFERENCES "employees" ("emp_no");

ALTER TABLE "titles" ADD CONSTRAINT "fk_titles_emp_no" FOREIGN KEY("emp_no")
REFERENCES "employees" ("emp_no");

-- After importing, I verify that cvs files were imported correctly

select * from departments;
select * from dept_emp;
select * from dept_manager;
select * from employees;
select * from salaries;
select * from titles;




------------------------------------------------------ QUERIES:





-- List the following details of each employee: employee number, last name, first name, gender, and salary.
SELECT e.emp_no, e.last_name, e.first_name, e.gender, s.salary
FROM salaries s
INNER JOIN employees e ON
e.emp_no = s.emp_no;
-- 300,024

-- List employees who were hired in 1986.
SELECT first_name, last_name
FROM employees
WHERE hire_date BETWEEN '1986-01-01'
AND '1986-12-31';
-- 36,150

-- List the manager of each department with the following information: 
-- department number, department name, the manager's employee number,
-- last name, first name, and start and end employment dates.

SELECT e.emp_no, e.first_name, e.last_name, dm.dept_no, dm.from_date, dm.to_date, d.dept_no, d.dept_name
FROM departments d
JOIN dept_manager dm on d.dept_no=dm.dept_no
JOIN employees e on dm.emp_no=e.emp_no;
-- 24 rows

-- List the department of each employee with the following information: employee number, last name, first name, and department name.
SELECT e.emp_no, e.first_name, e.last_name, d.dept_name
FROM departments d
JOIN dept_emp de on d.dept_no=de.dept_no
JOIN employees e on de.emp_no=e.emp_no;
-- 331,603 rows

-- List all employees whose first name is "Hercules" and last names begin with "B."
SELECT *
FROM employees
WHERE 
	first_name='Hercules'
	AND last_name like 'B%';
-- 20 rows

-- List all employees in the Sales department, including
-- their employee number, last name, first name, and department name.

SELECT e.emp_no, e.first_name, e.last_name, d.dept_name
FROM departments d
JOIN dept_emp de on d.dept_no=de.dept_no
JOIN employees e on de.emp_no=e.emp_no
WHERE d.dept_name = 'Sales';
-- 52,245 rows

-- what if I change the order of the joined tables? result= 52,245 rows (same rows numbers!)
SELECT e.emp_no, e.first_name, e.last_name, d.dept_name
FROM employees e
JOIN dept_emp de on e.emp_no=de.emp_no
JOIN departments d on de.dept_no=d.dept_no
WHERE d.dept_name = 'Sales';
-- 52,245 rows

-- List all employees in the Sales and Development departments, including
-- their employee number, last name, first name, and department name.

SELECT e.emp_no, e.first_name, e.last_name, d.dept_name
FROM employees e
JOIN dept_emp de on e.emp_no=de.emp_no
JOIN departments d on de.dept_no=d.dept_no
WHERE d.dept_name = 'Sales' OR d.dept_name = 'Development';
-- 137,952 rows

-- In descending order, list the frequency count of employee last names,
-- i.e., how many employees share each last name.

SELECT last_name, COUNT (last_name) AS "Number of Employees"
FROM employees
GROUP BY last_name
ORDER BY COUNT(last_name) DESC;
-- 1,638 rows








	






























