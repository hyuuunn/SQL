-- 데이터 입력/수정/삭제 
-- INSERT 구문1 실습 
DROP TABLE EMP;

CREATE TABLE  EMP (
       emp_no      VARCHAR2(30)  NOT NULL,
       emp_name    VARCHAR2(80)  NOT NULL,
       salary      NUMBER            NULL,
       hire_date   DATE              NULL
);

ALTER TABLE EMP
ADD CONSTRAINTS EMP_PK PRIMARY KEY (emp_no);

-- INSERT 구문1
INSERT INTO EMP ( emp_no, emp_name, salary, hire_date)
VALUES (1, '홍길동', 1000, '2020-06-01');

SELECT *
  FROM emp;
  
  

INSERT INTO EMP ( emp_no, emp_name)
VALUES (2, '김유신');

SELECT *
  FROM emp;
  
  

INSERT INTO EMP ( emp_name, emp_no )
VALUES ('강감찬', 3);

SELECT *
  FROM emp;
  
  
  
INSERT INTO EMP 
VALUES (4, '세종대왕', 1000, SYSDATE);

SELECT *
  FROM emp;
  
  
  
INSERT INTO EMP  ( emp_no,  salary, hire_date)
VALUES (5,  1000, SYSDATE);

INSERT INTO EMP  
VALUES (4, '신사임당', 1000, SYSDATE);

SELECT *
  FROM emp;
  
  
  
INSERT INTO EMP  
VALUES (5, '신사임당', 1000, TO_DATE('2020-06-29 19:54:30', 'YYYY-MM-DD HH24:MI:SS'));

SELECT *
  FROM emp;

-- INSERT 구문2 실습 

INSERT INTO EMP
SELECT emp_no + 10, emp_name, salary, hire_date
  FROM emp;

SELECT *
  FROM emp;
  
  
TRUNCATE TABLE EMP;

INSERT INTO EMP
SELECT employee_id, first_name || ' ' || last_name, salary, hire_date
  FROM EMPLOYEES
 WHERE department_id = 90;

SELECT *
  FROM emp;


INSERT INTO EMP
SELECT employee_id, first_name || ' ' || last_name, salary, hire_date
FROM employees;


CREATE TABLE EMP_INFO1 (
   emp_no          VARCHAR2(30)  NOT NULL,
   emp_name        VARCHAR2(80)  NOT NULL,
   salary          NUMBER            NULL,
   hire_date       DATE              NULL,
   department_name VARCHAR2(80)      NULL,
   country_name    VARCHAR2(80)      NULL
);

INSERT INTO EMP_INFO1
SELECT a.employee_id, 
       a.first_name || ' ' || a.last_name, 
       a.salary, a.hire_date,
       b.department_name,
       d.country_name
  FROM employees a,
       departments b,
       locations c,
       countries d
 WHERE a.department_id = b.department_id
   AND b.location_id   = c.location_id
   AND c.country_id    = d.country_id;

SELECT *
  FROM EMP_INFO1;


-- INSERT 구문3 실습
CREATE TABLE  EMP1 (
       emp_no      VARCHAR2(30)  NOT NULL,
       emp_name    VARCHAR2(80)  NOT NULL,
       salary      NUMBER            NULL,
       hire_date   DATE              NULL,
       dept_id     NUMBER            NULL       
);

ALTER TABLE EMP1
ADD CONSTRAINTS EMP1_PK PRIMARY KEY (emp_no);

CREATE TABLE  EMP2 (
       emp_no      VARCHAR2(30)  NOT NULL,
       emp_name    VARCHAR2(80)  NOT NULL,
       salary      NUMBER            NULL,
       hire_date   DATE              NULL,
       dept_id     NUMBER            NULL       
);

ALTER TABLE EMP2
ADD CONSTRAINTS EMP2_PK PRIMARY KEY (emp_no);

CREATE TABLE  EMP3 (
       emp_no      VARCHAR2(30)  NOT NULL,
       emp_name    VARCHAR2(80)  NOT NULL,
       salary      NUMBER            NULL,
       hire_date   DATE              NULL,
       dept_id     NUMBER            NULL       
);

ALTER TABLE EMP3
ADD CONSTRAINTS EMP3_PK PRIMARY KEY (emp_no);

INSERT ALL
  INTO EMP1 (emp_no, emp_name, salary, hire_date)
    VALUES  (emp_no, emp_name, salary, hire_date)
  INTO EMP2 (emp_no, emp_name, salary, hire_date)
    VALUES  (emp_no, emp_name, salary, hire_date)    
SELECT employee_id emp_no, first_name || ' ' || last_name emp_name, salary, hire_date
  FROM employees;
  
SELECT *
FROM EMP1;

SELECT *
FROM EMP2;

  
TRUNCATE TABLE emp1;
TRUNCATE TABLE emp2;  

INSERT ALL
  INTO EMP1 (emp_no, emp_name, salary, hire_date)
    VALUES  (emp_no, emp_name, salary, hire_date)
  INTO EMP2 (emp_no, emp_name, salary)
    VALUES  (emp_no, emp_name, salary)
  INTO EMP3 (emp_no, emp_name)
    VALUES  (emp_no, emp_name)        
SELECT employee_id emp_no, first_name || ' ' || last_name emp_name, salary, hire_date
  FROM employees;
  
-- INSERT 구문 4-1 
TRUNCATE TABLE emp1;
TRUNCATE TABLE emp2;  
TRUNCATE TABLE emp3;  
 
INSERT ALL
  WHEN dept_id = 20 THEN
    INTO EMP1 (emp_no, emp_name, salary, hire_date, dept_id)
       VALUES (emp_no, emp_name, salary, hire_date, dept_id)
  WHEN dept_id BETWEEN 30 AND 50 THEN        
    INTO EMP2 (emp_no, emp_name, salary, hire_date, dept_id)
       VALUES (emp_no, emp_name, salary, hire_date, dept_id)
  WHEN dept_id > 50 THEN        
    INTO EMP3 (emp_no, emp_name, salary, hire_date, dept_id)
       VALUES (emp_no, emp_name, salary, hire_date, dept_id)
SELECT employee_id emp_no, 
       first_name || ' ' || last_name emp_name, 
       salary, hire_date, department_id dept_id
  FROM employees;
  
  
-- INSERT 구문 4-2
TRUNCATE TABLE emp1;
TRUNCATE TABLE emp2;  
TRUNCATE TABLE emp3;

INSERT ALL
  WHEN salary >= 2500 THEN
    INTO EMP1 (emp_no, emp_name, salary, hire_date, dept_id)
       VALUES (emp_no, emp_name, salary, hire_date, dept_id)
  WHEN salary >= 5000 THEN        
    INTO EMP2 (emp_no, emp_name, salary, hire_date, dept_id)
       VALUES (emp_no, emp_name, salary, hire_date, dept_id)
  WHEN salary >= 7000 THEN        
    INTO EMP3 (emp_no, emp_name, salary, hire_date, dept_id)
       VALUES (emp_no, emp_name, salary, hire_date, dept_id)
SELECT employee_id emp_no, 
       first_name || ' ' || last_name emp_name, 
       salary, hire_date, department_id dept_id
  FROM employees;
  
SELECT MIN(salary), MAX(salary)
FROM EMP1;

SELECT MIN(salary), MAX(salary)
FROM EMP2;

SELECT MIN(salary), MAX(salary)
FROM EMP3;

TRUNCATE TABLE emp1;
TRUNCATE TABLE emp2;  
TRUNCATE TABLE emp3;
  
INSERT FIRST
  WHEN salary >= 2500 THEN
    INTO EMP1 (emp_no, emp_name, salary, hire_date, dept_id)
       VALUES (emp_no, emp_name, salary, hire_date, dept_id)
  WHEN salary >= 5000 THEN        
    INTO EMP2 (emp_no, emp_name, salary, hire_date, dept_id)
       VALUES (emp_no, emp_name, salary, hire_date, dept_id)
  WHEN salary >= 7000 THEN        
    INTO EMP3 (emp_no, emp_name, salary, hire_date, dept_id)
       VALUES (emp_no, emp_name, salary, hire_date, dept_id)
SELECT employee_id emp_no, 
       first_name || ' ' || last_name emp_name, 
       salary, hire_date, department_id dept_id
  FROM employees;  
  
  
SELECT MIN(salary), MAX(salary)
FROM EMP1;

SELECT MIN(salary), MAX(salary)
FROM EMP2;

SELECT MIN(salary), MAX(salary)
FROM EMP3;  
  
-- UPDATE
SELECT *
  FROM EMP;
  
UPDATE emp
   SET salary = 0
 WHERE salary < 20000;

SELECT *
  FROM EMP;

ALTER TABLE emp
ADD retire_date DATE ;

UPDATE emp
   SET retire_date = SYSDATE
 WHERE emp_no = 102;

SELECT *
  FROM EMP;


UPDATE EMP_INFO1 
   SET emp_name = emp_name || '(middle)'
 WHERE salary BETWEEN 10000 AND 20000;
 
SELECT *
  FROM EMP_INFO1
 WHERE INSTR(emp_name, 'middle') > 0 ;
 
SELECT *
  FROM EMP_INFO1
 WHERE INSTR(emp_name, 'middle') > 0 
   AND salary NOT BETWEEN 10000 AND 20000;
     
UPDATE EMP_INFO1
   SET emp_name = emp_name || ' (1)',
       department_name = department_name || ' (1)'
 WHERE hire_date < TO_DATE('2005-01-01', 'YYYY-MM-DD');


SELECT *
  FROM EMP_INFO1
 WHERE INSTR(department_name, '(1)') > 0 ;


SELECT *
  FROM EMP1
 WHERE dept_id IS NULL;
 
 
UPDATE EMP1
   SET dept_id = ( SELECT MAX(department_id)
                     FROM DEPARTMENTS
                    WHERE manager_id IS NULL
                 )
 WHERE dept_id IS NULL;
 
SELECT *
  FROM EMP1
 WHERE emp_no = 178;
 

-- DELETE
SELECT *
  FROM emp;
  
DELETE emp
 WHERE emp_no in (101, 102);
 

DELETE emp1
 WHERE emp_name LIKE 'J%';

SELECT *
  FROM emp1
 ORDER BY emp_name;

COMMIT; 

-- titanic 데이터 확인
SELECT *
  FROM titanic;
  
  
-- 테이블 생성과 데이터 복사를 동시에 
CREATE TABLE employees_copy AS
 SELECT *
   FROM employees; 
   
SELECT *
  FROM employees_copy;
   
-- 트랜잭션 처리 
CREATE TABLE emp_tran AS
SELECT *
FROM emp1;


SELECT *
  FROM emp_tran;


DELETE emp_tran 
WHERE dept_id = 90;

COMMIT;

SELECT * FROM emp_tran;

UPDATE emp_tran
   SET emp_name = 'HAHA'
 WHERE dept_id = 60;

ROLLBACK;

SELECT * FROM emp_tran;

  
-- Merge
CREATE TABLE dept_mgr AS
SELECT *
FROM departments;

ALTER TABLE dept_mgr
ADD CONSTRAINTS dept_mgr_pk PRIMARY KEY (department_id);

SELECT *
  FROM dept_mgr;


MERGE INTO dept_mgr a
USING ( SELECT 280 dept_id, '영업부(Merge)' dept_name
          FROM dual
         UNION ALL
        SELECT 285 dept_id, '경리부(Merge)' dept_name
          FROM dual
      ) b
  ON ( a.department_id = b.dept_id )
WHEN MATCHED THEN  -- ON 조건에 만족하는 건이 있으면
UPDATE SET a.department_name = b.dept_name
WHEN NOT MATCHED THEN  --일치하는 건이 없으면
INSERT (a.department_id, a.department_name)
VALUES (b.dept_id, b.dept_name);


SELECT *
  FROM dept_mgr;



MERGE INTO dept_mgr a
USING ( SELECT 280 dept_id, '영업부(Merge)2' dept_name
          FROM dual
        UNION ALL
        SELECT 285 dept_id, '경리부(Merge)2' dept_name
          FROM dual
      ) b
  ON ( a.department_id = b.dept_id)
WHEN MATCHED THEN      -- 일치하는 건이 있으면
UPDATE SET a.department_name = b.dept_name
WHEN NOT MATCHED THEN  --일치하는 건이 없으면
INSERT (a.department_id, a.department_name)
VALUES (b.dept_id, b.dept_name);

SELECT *
  FROM dept_mgr;



MERGE INTO dept_mgr a
USING ( SELECT 280 dept_id, '영업부(Merge)3' dept_name
          FROM dual
        UNION ALL
        SELECT 290 dept_id, '전산팀(Merge)' dept_name
          FROM dual
      ) b
  ON ( a.department_id = b.dept_id)
WHEN MATCHED THEN     -- 일치하는 건이 있으면
UPDATE SET a.department_name = b.dept_name
WHEN NOT MATCHED THEN --일치하는 건이 없으면
INSERT (a.department_id, a.department_name)
VALUES (b.dept_id, b.dept_name);

SELECT *
  FROM dept_mgr;

-- View
SELECT a.employee_id, a.first_name || ' ' || a.last_name emp_names, 
       b.department_id ,b.department_name
  FROM employees a,
       departments b
 WHERE a.department_id = b.department_id
 ORDER BY 1; 
 
 
CREATE OR REPLACE VIEW emp_dept_v AS
SELECT a.employee_id, 
       a.first_name || ' ' || a.last_name emp_names, 
       b.department_id ,b.department_name
  FROM employees a,
       departments b
 WHERE a.department_id = b.department_id
 ORDER BY 1; 
 
SELECT *
  FROM emp_dept_v;
  
CREATE OR REPLACE VIEW emp_dept_v AS
SELECT a.employee_id, 
       a.first_name || ' ' || a.last_name emp_names, 
       a.salary,
       b.department_id ,b.department_name
  FROM employees a,
       departments b
 WHERE a.department_id = b.department_id
 ORDER BY 1;   
 
-- hr2 사용자 생성  
CREATE USER hr2 IDENTIFIED BY hr2;
 
-- hr2 접속 권한 부여 
GRANT CREATE SESSION TO hr2;

CREATE OR REPLACE VIEW emp_dept_v2 AS
SELECT a.employee_id, 
       a.first_name || ' ' || a.last_name emp_names, 
       b.department_id ,b.department_name
  FROM employees a,
       departments b
 WHERE a.department_id = b.department_id
 ORDER BY 1; 

GRANT SELECT ON emp_dept_v2 TO hr2;

-- hr2 사용자로 로그인
SELECT *
  FROM emp_dept_v2;
  

SELECT *
  FROM hr.emp_dept_v2;
  
  
SELECT *
  FROM hr.employees;
  
  
  
-- 데이터 딕셔너리
SELECT *
  FROM user_objects;

SELECT *
  FROM user_tables
 ORDER BY 1;
 
SELECT *
  FROM user_indexes;
  
SELECT *
  FROM user_constraints;    
  
SELECT *
  FROM user_tab_cols
 ORDER BY table_name, column_id ;
 
SELECT ',a.' || column_name
  FROM user_tab_cols
 WHERE table_name = 'EMPLOYEES' 
 ORDER BY column_id ;
