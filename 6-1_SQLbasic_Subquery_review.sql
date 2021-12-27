-- 서브쿼리 복습 

-- 1. 서브쿼리 (Subquery) - 개요
--    · 일반적인 쿼리(메인, 주 쿼리) 안에 있는 또 다른 쿼리 -> 보조, 하위 쿼리
--    · 메인 쿼리와 서브쿼리가 합쳐져 한 문장을 이룸
--    · 서브쿼리는 하나의 SELECT 문장으로, 괄호로 둘러싸인 형태
--    · 메인 쿼리 기준으로 여러 개의 서브 쿼리 사용 가능

-- 1. 서브쿼리 (Subquery) - 종류
--    · 서브 쿼리 위치에 따라
--      - 스칼라 서브쿼리 (Scalar Subquery)
--      - 인라인 뷰 (Inline View)
--      - 중첩 서브쿼리 (Nested Subquery)

-- 2. 스칼라 서브쿼리 (Scalar Subquery)
--    · 메인쿼리의 SELECT 절에 위치한 서브쿼리
--    · SELECT 절에서 마치 하나의 컬럼이나 표현식 처럼 사용
--    · 스칼라(Scalar) : 크기만 가지는 값, 양을 의미 (수학, 물리)
--    · 서브쿼리 수행 결과가 하나의 값이 되므로 스칼라 서브쿼리라고 함(?)
--    · 서브쿼리가 최종 반환하는 로우 수는 1개
--    · 서브쿼리가 최종 반환하는 컬럼이나 표현식도 1개
--    · 서브쿼리에 별칭(Alias)을 주는 것이 일반적 -> 하나의 컬럼 역할을 하므로
--    · 서브쿼리 내에서 메인 쿼리와 조인 가능
--      - 조인 하는 것이 일반적
--      - 조인을 안하면 여러 건이 조회될 가능성이 많음
--      - 조인을 한다는 것은 연관성 있는 서브쿼리란 뜻

-- 3. 인라인 뷰 (Inline View)
--    · 메인쿼리의 FROM 절에 위치
--    · 서브쿼리 자체가 마치 하나의 테이블 처럼 동작
--    · 서브쿼리가 최종 반환하는 로우와 컬럼, 표현식 수는 1개 이상 가능
--    · 서브쿼리에 대한 별칭(Alias)은 반드시 명시
--    · 메인쿼리와 조인조건은 메인 쿼리의 WHERE 절에서 처리가 일반적
--    · 인라인 뷰가 필요한 이유
--      - 기존 단일 테이블만 읽어서는 필요한 정보를 가져오기가 어려울 때
--          예, 특정 조건으로 집계한 결과와 조인 필요 시
--      - 인라인 뷰의 쿼리가 여러 테이블을 조인해 읽어오는 경우가 많음
--      - 복잡한 쿼리의 경우, 쿼리 작성을 좀 더 직관적으로 사용하기 위해
--    · LATERAL 키워드 사용 시 서브쿼리 내에서 조인 가능 -> 스칼라 서브쿼리처럼 동작
--      - 과거 서브쿼리 내에서는 메인 쿼리 참조가 불가능 (조인 불가)
--      - 12c 부터 추가된 기능
--      - 서브쿼리 앞에 LATERAL 명시할 경우 메인 쿼리 컬럼 참조 가능

-- 4. 중첩 서브쿼리 (Nested Subquery)
--    · 메인쿼리의 WHERE 절에 위치
--    · 서브쿼리가 조건절의 일부로 사용됨
--    · 서브쿼리 최종 반환 값과 메인쿼리 테이블의 특정 컬럼 값을 비교 시 사용
--    · 서브쿼리가 최종 반환하는 로우와 컬럼, 표현식 수는 1개 이상 가능
--    · 조건절의 일부이므로 서브쿼리에 대한 별칭(Alias) 사용 불가
--    · 서브쿼리 내에서 메인쿼리와 조인 가능
      

-- (1) 사원의 급여를 회사 전체 평균 급여와 해당 사원이 속한 부서 평균 급여와 비교하라

-- 부서별 평균 급여
SELECT department_id, ROUND(AVG(salary),0) dept_avg_sal
  FROM employees
 GROUP BY department_id
 ORDER BY 1;

-- 사원 테이블과 부서별 평균 급여 쿼리를 조인 ? 서브쿼리 사용
SELECT a.employee_id, 
       a.first_name || ' ' || a.last_name emp_name, 
       a.department_id, 
       a.salary, b.dept_avg_sal
  FROM employees a,
       ( SELECT department_id,
                ROUND(AVG(salary),0) dept_avg_sal
           FROM employees
          GROUP BY department_id
       ) b   
 WHERE a.department_id = b.department_id
 ORDER BY 1;
 
-- 회사 전체 급여 평균도 서브쿼리로 추가 
SELECT a.employee_id, 
       a.first_name || ' ' || a.last_name emp_name, 
       a.department_id, 
       a.salary, b.dept_avg_sal,   c.all_avg_sal
  FROM employees a,
       ( SELECT department_id,
                        ROUND(AVG(salary),0) dept_avg_sal
           FROM employees
          GROUP BY department_id    ) b
      ,( SELECT ROUND(AVG(salary),0) all_avg_sal
           FROM employees   ) c    
 WHERE a.department_id = b.department_id
 ORDER BY 1  ;
 

-- 회사 전체 급여 평균 서브쿼리는 단일 값을 반환하므로 스칼라 서브쿼리 형태로 사용 가능 
SELECT a.employee_id, 
       a.first_name || ' ' || a.last_name emp_name, 
       a.department_id, 
       a.salary, b.dept_avg_sal, 
      ( SELECT ROUND(AVG(salary),0)
           FROM employees   ) all_avg_sal
FROM employees a,
       ( SELECT department_id,
                        ROUND(AVG(salary),0) dept_avg_sal
           FROM employees
          GROUP BY department_id    ) b
   WHERE a.department_id = b.department_id
 ORDER BY 1  ;
 
 
--(2) 가장 급여가 많은 사원과 가장 적은 사원 이름과 급여 구하기
 
SELECT MIN(salary) min_sal,
       MAX(salary) max_sal
  FROM employees;


SELECT a.employee_id,
       a.first_name || ' ' || a.last_name emp_name,
       a.salary
  FROM employees a
 WHERE a.salary IN ( SELECT MIN(salary) min_sal,
                            MAX(salary) max_sal
                     FROM employees
                   );


SELECT a.employee_id,
       a.first_name || ' ' || a.last_name emp_name,
       a.salary
  FROM employees a
 WHERE a.salary IN ( SELECT MIN(salary) min_sal                                                        
                     FROM employees
                   );


SELECT a.employee_id,
       a.first_name || ' ' || a.last_name emp_name,
       a.salary
  FROM employees a
 WHERE a.salary IN ( SELECT MIN(salary) min_sal
                     FROM employees
                   )
    OR a.salary IN ( SELECT MAX(salary) min_sal
                     FROM employees
                   );
                   
                   
SELECT a.employee_id,
       a.first_name || ' ' || a.last_name emp_name,
       a.salary
  FROM employees a
 INNER JOIN ( SELECT MIN(salary) min_sal,
                     MAX(salary) max_sal
              FROM employees
            ) b
 ON a.salary = b.min_sal
 OR a.salary = b.max_sal;
                   

-- (3) 사원에 할당되지 않은 부서 정보 조회
SELECT *
  FROM departments 
 WHERE department_id NOT IN ( SELECT a.department_id
                              FROM employees a
                            ) ;

SELECT *
  FROM departments a
 WHERE NOT EXISTS ( SELECT 1
                    FROM employees b
                    WHERE a.department_id = b.department_id
                   ) 
ORDER BY 1;


-- (4) 입사 년도별 사원들의 급여 총액과  전년 대비 증가율을 구하라
SELECT TO_CHAR(hire_date, 'YYYY') years, SUM(salary) sal
  FROM employees 
 GROUP BY TO_CHAR(hire_date, 'YYYY')
 ORDER BY 1;


SELECT ty.years, ty.sal, ly.years, ly.sal
  FROM ( SELECT TO_NUMBER(TO_CHAR(hire_date, 'YYYY')) years, 
                SUM(salary) sal
         FROM employees 
         GROUP BY TO_CHAR(hire_date, 'YYYY')
        ) ty
  LEFT JOIN ( SELECT TO_NUMBER(TO_CHAR(hire_date, 'YYYY')) years, 
                     SUM(salary) sal
                FROM employees 
               GROUP BY TO_CHAR(hire_date, 'YYYY')
            ) ly
    ON ty.years - 1 = ly.years
 ORDER BY 1; 


SELECT ty.years, ty.sal, NVL(ly.sal,0) pre_sal,
       CASE WHEN NVL(ly.sal,0) = 0 THEN 0
            ELSE ROUND((ty.sal - ly.sal) / ly.sal * 100,2)
       END rates
  FROM ( SELECT TO_NUMBER(TO_CHAR(hire_date, 'YYYY')) years, SUM(salary) sal
           FROM employees 
          GROUP BY TO_CHAR(hire_date, 'YYYY')
       ) ty
  LEFT JOIN 
       ( SELECT TO_NUMBER(TO_CHAR(hire_date, 'YYYY')) years, SUM(salary) sal
           FROM employees 
          GROUP BY TO_CHAR(hire_date, 'YYYY')
       ) ly
    ON ty.years - 1 = ly.years
 ORDER BY 1; 
 
 
 
WITH cte1 AS (
SELECT  TO_NUMBER(TO_CHAR(hire_date, 'YYYY')) years, SUM(salary) sal
  FROM employees 
  GROUP BY TO_CHAR(hire_date, 'YYYY')
),
cte2 AS (
SELECT a.years, a.sal, b.years y2, NVL(b.sal,0) pre_sal
  FROM cte1 a
 LEFT JOIN cte1 b 
   ON a.years - 1 = b.years
)
SELECT years, sal, pre_sal,
       CASE WHEN pre_sal = 0 THEN 0
            ELSE ROUND((sal - pre_sal) / pre_sal * 100,2)
       END rates
 FROM cte2
 ORDER BY 1;



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
