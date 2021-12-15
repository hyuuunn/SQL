-- 집합쿼리 - 집합연산자 

-- 1. 집합 쿼리
--  · 집합 연산자를 사용한 쿼리
--  · 하나의 SELECT 문장이 반환한 결과를 한 집합으로 보고, 한 개 이상의 SELECT 문장이 집합 연산자로 연결된 형태
--  · 여러 개의 SELECT 문이 연결되어 최종적으로는 하나의 결과 집합이 만들어짐
SELECT ...
  FROM ...
 WHERE ...
 집합연산자
SELECT ...
  FROM ...
 WHERE ...
 집합연산자
...
-- <제한사항>
--  · 각 SELECT 절의 컬럼 수, 데이터 타입은 동일
--  · 최종 반환되는 컬럼 명은 맨 첫 SELECT 절의 컬럼 이름을 따름
--  · ORDER BY 절은 맨 마지막 SELECT 문장에서만 붙일 수 있음

-- 2. 집합 연산자
--  · 집합 쿼리는 집합 연산자를 사용해 SELECT 문장을 연결하는 형태
--  · UNION, UNION ALL, INTERSECT, MINUS 4개 연산자 존재
--  · 집합 연산자는 수학의 집합 개념과 유사
--  · 각 SELECT 문이 반환하는 결과를 하나의 집합으로 보고 집합 연산자를 통해 연결

-- 2. 집합 연산자 - UNION
--  ·두 집합의 모든 원소를 가져오는 합집합 개념
SELECT col1
  FROM Tbl_A
UNION
SELECT col1
  FROM Tbl_B
ORDER BY 1;
--  · 두 문장의 SELECT 절에 명시하는 컬럼 수, 데이터 타입은 동일해야 함
--  · 조회된 결과의 컬럼명은 첫 번째 SELECT 문장의 컬럼명으로 보임
--  · ORDER BY 절은 맨 마지막에 붙일 수 있음 (생략 가능)
--  · 각 결과 집합에서 조회된 중복 값은 1번만 조회됨

-- 2. 집합 연산자 – UNION ALL
--  · UNION과 동일하나 중복 값도 모두 조회됨
--  · 나머지 내용은 UNION 과 동일

-- 2. 집합 연산자 - INTERSECT
--  · 두 집합의 공통 원소를 가져오는 교집합 개념 (Distinct Row)

-- 2. 집합 연산자 - MINUS
--  · 선두 집합 에만 있는 원소를 가져오는 차집합 개념 (Distinct Row)
--  · 먼저 명시한 SELECT 문의 결과 집합이 기준 (Distinct Row)

 

-- A 집합 
SELECT job_id
  FROM employees
 WHERE 1=1
   AND salary BETWEEN 2000 and 5000
 ORDER BY job_id;
 
SELECT DISTINCT job_id
  FROM employees
 WHERE 1=1
   AND salary BETWEEN 2000 and 5000
 ORDER BY job_id;
--> AD_ASST, IT_PROG, PU_CLERK, SH_CLERK, ST_CLERK 

-- B 집합    
SELECT job_id
  FROM employees
 WHERE 1=1   
   AND salary BETWEEN 5001 AND 6000
 ORDER BY job_id;
--> IT_PROG, MK_REP, ST_MAN 
 
-- UNION
-- A집합
SELECT job_id
  FROM employees
 WHERE 1=1
   AND salary BETWEEN 2000 and 5000
 UNION
-- B집합
SELECT job_id
  FROM employees
 WHERE 1=1   
   AND salary BETWEEN 5001 AND 6000
 ORDER BY job_id;
 
 
-- UNION 오류 -- 결과 열 수 불일치 
SELECT job_id, salary
  FROM employees
 WHERE 1=1
   AND salary BETWEEN 2000 and 5000
 UNION 
SELECT job_id
  FROM employees
 WHERE 1=1   
   AND salary BETWEEN 5001 AND 6000
 ORDER BY job_id;
--> 컬럼 개수와 데이터 유형이 같아야함. (같은 컬럼일 필요는 없음)
 
 
-- UNION 오류 -- 결과 열의 데이텨형 불일치 
SELECT job_id, salary
  FROM employees
 WHERE 1=1
   AND salary BETWEEN 2000 and 5000
 UNION 
SELECT job_id, phone_number
  FROM employees
 WHERE 1=1   
   AND salary BETWEEN 5001 AND 6000
 ORDER BY job_id; 
--> Salary는 NUMBER 형, phone_number 는 문자형 => 데이터 형 불일치
 

-- UNION 오류 -- 문장오류는 없으나 의미상 오류인 쿼리 
SELECT job_id, salary
  FROM employees
 WHERE 1=1
   AND salary BETWEEN 2000 and 5000
 UNION 
SELECT job_id, department_id
  FROM employees
 WHERE 1=1   
   AND salary BETWEEN 5001 AND 6000
 ORDER BY job_id;
--> 구문 오류는 없으나, 의미상 오류
--> salary, department_id는 NUMBER 형이나 데이터 성격이 다름
 
 
-- UNION ALL
SELECT job_id
  FROM employees
 WHERE 1=1
   AND salary BETWEEN 2000 and 5000
 UNION ALL
SELECT job_id
  FROM employees
 WHERE 1=1   
   AND salary BETWEEN 5001 AND 6000
 ORDER BY job_id; 
 
 
-- INTERSECT 
SELECT job_id
  FROM employees
 WHERE 1=1
   AND salary BETWEEN 2000 and 5000
 INTERSECT
SELECT job_id
  FROM employees
 WHERE 1=1   
   AND salary BETWEEN 5001 AND 6000
 ORDER BY job_id;  
 

-- MINUS
-- A - B
SELECT job_id
  FROM employees
 WHERE 1=1
   AND salary BETWEEN 2000 and 5000
 MINUS
SELECT job_id
  FROM employees
 WHERE 1=1   
   AND salary BETWEEN 5001 AND 6000
 ORDER BY job_id;  
 
-- B - A 
SELECT job_id
  FROM employees
 WHERE 1=1   
   AND salary BETWEEN 5001 AND 6000 
 MINUS
SELECT job_id
  FROM employees
 WHERE 1=1
   AND salary BETWEEN 2000 and 5000
 ORDER BY job_id;


-- 집계 쿼리 실습 
-- (1) 급여가 10000 이상인 사원의 평균 급여를 구하라
SELECT AVG(salary)
  FROM employees
 WHERE salary >= 10000;
 
SELECT ROUND(AVG(salary), 0)
  FROM employees
 WHERE salary >= 10000;

-- (2) 입사 월별 사원수를 구하라
SELECT TO_CHAR(hire_date, 'MM'), COUNT(*)
  FROM employees
GROUP BY TO_CHAR(hire_date, 'MM')
ORDER BY 1;

-- 요일별 입사 사원수는? 
SELECT TO_CHAR(hire_date, 'day'), COUNT(*)
  FROM employees
GROUP BY TO_CHAR(hire_date, 'day')
ORDER BY 1;


-- (3) 이름이 동일한 사원과 동일인 수를 구하라
SELECT  *
  FROM employees
ORDER BY first_name;

SELECT first_name
      ,COUNT(*)
  FROM employees
 GROUP BY first_name
 ORDER BY first_name;
 
 
SELECT first_name
      ,COUNT(*)
  FROM employees
 GROUP BY first_name
 HAVING COUNT(*) > 1
 ORDER BY first_name;
 

  
-- 집합연산자 활용
-- 1.예산 대비 실적 
create table budget_table (
     yearmon      VARCHAR2(6),
     budget_amt   NUMBER     );
     
INSERT INTO budget_table values('201901', 1000);   
INSERT INTO budget_table values('201902', 2000);   
INSERT INTO budget_table values('201903', 1500);   
INSERT INTO budget_table values('201904', 3000);   
INSERT INTO budget_table values('201905', 1050);   

create table sale_table (
     yearmon      VARCHAR2(6),
     sale_amt     NUMBER     );
     
INSERT INTO sale_table values('201901', 900);   
INSERT INTO sale_table values('201902', 2000);   
INSERT INTO sale_table values('201903', 1000);   
INSERT INTO sale_table values('201904', 3100);   
INSERT INTO sale_table values('201905', 800);   

SELECT yearmon, budget_amt, 0 sale_amt
  FROM budget_table
 UNION 
SELECT yearmon, 0 budget_amt, sale_amt
  FROM sale_table;
  
SELECT yearmon, 
       SUM(budget_amt) budget, 
       SUM(sale_amt) sale,
       ROUND(SUM(sale_amt) / SUM(budget_amt),2) * 100 rates
  FROM ( SELECT yearmon, budget_amt, 0 sale_amt
                FROM budget_table
                UNION 
                SELECT yearmon, 0 budget_amt, sale_amt
                FROM sale_table
              )   
  GROUP BY yearmon
  ORDER BY 1;


-- 컬럼을 로우로 
CREATE TABLE test_score (
    years     VARCHAR2(4),
    gubun     VARCHAR2(20),
    korean    NUMBER,
    english   NUMBER,
    math      NUMBER );
    
INSERT INTO test_score VALUES ('2019', '중간고사', 92, 87, 67);
INSERT INTO test_score VALUES ('2019', '기말고사', 88, 80, 91);


SELECT years, gubun, '국어' subject, korean score FROM test_score
UNION ALL
SELECT years, gubun, '영어' subject, english score FROM test_score
UNION ALL
SELECT years, gubun, '수학' subject, math score FROM test_score
ORDER BY 2 desc;

-- INTERSECT
SELECT state_province dup_loc_name
  FROM locations
INTERSECT
SELECT city
  FROM locations
ORDER BY 1;  

SELECT state_province, city
  FROM locations 
 WHERE state_province = city
ORDER BY 1;

-- 보너스 문제
create table GROUPBYMULTIPLY (
  department_name  VARCHAR2(100),
  num_data         NUMBER 
);

insert into groupbymultiply values ('dept1', 10);
insert into groupbymultiply values ('dept1', 20);
insert into groupbymultiply values ('dept1', 30);
insert into groupbymultiply values ('dept2', 5);
insert into groupbymultiply values ('dept2', 7);
insert into groupbymultiply values ('dept2', 40);
insert into groupbymultiply values ('dept3', 69);
insert into groupbymultiply values ('dept3', 71);
insert into groupbymultiply values ('dept3', 12);

commit;


SELECT *
FROM groupbymultiply;


SELECT department_name,
        SUM(num_data)
FROM groupbymultiply
GROUP BY department_name
ORDER BY 1 ;


SELECT department_name
      ,EXP(SUM(LN(num_data))) multiply_result
FROM groupbymultiply
WHERE 1=1
GROUP BY department_name
ORDER BY 1;
