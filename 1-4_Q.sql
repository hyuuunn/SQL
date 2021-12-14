-- 1-1 

-- Q1. CREATE TABLE 문을 사용해 테이블을 생성한 후 테이블에 있는 컬럼의 데이터 형을 수정하려면 ALTER COLUMN 문을 사용해야 한다.

-- => X
-- 만들어진 테이블의 컬럼에 대한 속성을 변경하려면 ALTER TABLE 문을 사용해야 한다. 즉, ALTER TABLE ... MODIFY ... 문을 사용한다.
-- ALTER COLUMN 문은 존재하지 않는다.

-- Q2. 다음 내용을 보고 country_test 란 테이블을 만들어 보세요
-- 컬럼명         설명     데이터형          NULL허용여부  PK여부
-- COUNTRY_ID   국가번호   NUMBER         N           Y
-- COUNTRY_NAME 국가명    VARCHAR2(100)   N

CREATE TABLE COUNTRY_TEST (
  COUNTRY_ID NUMBER NOT NULL,
  COUNTRY_NAME VARCHAR2(100) NOT NULL,
 PRIMARY KEY (COUNTRY_ID)
 );
 
-- Q3. country_test 테이블에 REGION_ID 란 컬럼을 추가하는 문장을 작성하세요. (REGION_ID : 숫자형, NULL 허용 컬럼)

ALTER TABLE COUNTRY_TEST
 ADD REGION_ID NUMBER;

-- Q4. country_test 테이블의 REGION_ID 는 NULL 허용 컬럼입니다. 이를 NOT NULL 컬럼으로 변경하는 문장을 작성하세요.

ALTER TABLE COUNTRY_TEST
MODIFY REGION_ID NOT NULL;

-- Q5. country_test 테이블을 삭제하는(제거하는) 문장을 작성해 보세요.

DROP TABLE COUNTRY_TEST;

------------------------------------------------------------------------------------------------------

-- 1-2

-- Q1. SELECT 문은 테이블에 있는 데이터를 조회하는 SQL 문장으로 특정 조건에 맞는 데이터를 선별하거나 특정 컬럼 별로 정렬해 데이터를 조회할 수 있다.

-- => O
-- SELECT 문에서 WHERE 절을 사용해 특정 조건에 맞는 데이터만 골라 조회할 수 있다.
-- 또한 ORDER BY 절을 사용해 특정 컬럼 데이터를 기준으로 오름차순 혹은 내림차순으로 정렬해 볼 수 있다.

-- Q2. 다음 문장의 WHERE 절에서 OR 연산자를 AND로 바꾸면 결과는 어떻게 될까요?

SELECT *
  FROM employees
 WHERE salary <= 2400
  OR salary >= 20000;
-- ->
SELECT *
  FROM employees
 WHERE salary <= 2400
  AND salary >= 20000;
  
-- => 조회되는 데이터가 없다.
-- OR는 두 조건 중 하나라도 참이면 성립하는 것이고 AND는 두 조건 모두 참이어야 합니다.
-- 첫 번째 문장은 SALARY 값이 2400 이하 혹은 20000 이상인 건을 조회하지만,
-- AND를 사용할 경우 2400 이하이고 20000 이상인 두 조건을 모두 만족해야 하므로 조회되는 건은 없습니다.

-- Q3. SELECT문에서 데이터를 정렬해 보려면 ORDER BY 절을 사용하는데, 기본적인 정렬 방법은 내림차순 이다.

-- => X
-- ORDER BY 절의 기본 정렬 방법은 오름차순이다.
-- 오름차순은 ASC, 내림차순은 DESC를 명시해야 하는데, 아무 것도 명시하지 않고 컬럼명만 명시한 경우 기본적으로 오름차순이 적용된다.

-- Q4. LOCATIONS 테이블은 부서의 주소 관련 데이터가 담겨 있습니다. 이 테이블의 컬럼과 데이터 형(타입), 각 컬럼의 NULL 허용 여부를 찾아 정리해 보세요.

DESC LOCATIONS;

-- Q5. LOCATIONS 테이블에서 LOCATION_ID 값이 2000보다 크거나 같고 3000 보다 작은 건을 조회하는 문장을 작성해 보세요.

SELECT *
  FROM LOCATIONS
 WHERE LOCATION_ID >= 2000
  AND LOCATION_ID < 3000;

-- Q6. EMPLOYEES 테이블에서 FIRST_NAME이 'David'이고 급여가 6000이상인 사람이 속한 부서가 위치한 도시를 찾는 문장을 작성해 보세요. (힌트: 3개의 문장이 필요함)

SELECT *
  FROM employees
 WHERE first_name = 'David'
  AND salary >= 6000;

SELECT *
  FROM departments
 WHERE department_id = 80;

SELECT *
  FROM LOCATIONS
 WHERE location_id = 2500;

------------------------------------------------------------------------------------------------------

-- 1-3

-- Q1. Employees 테이블의 manager_id 컬럼에는 해당 사원의 상관의 사번이 저장되어 있습니다.
--     따라서 가장 높은 직급인 사장은 이 컬럼에 값이 들어있지 않습니다. 사장을 조회하는 쿼리를 작성해 보세요.

SELECT *
  FROM employees
 WHERE manager_id IS NULL;

-- Q2. employees 테이블에는 인센티브 값이 있는 commission_pct 컬럼이 있습니다.
--    그런데 commission_pct를 모든 사원이 받는 것은 아니어서 이 컬럼 값이 null인 건이 존재합니다.
--    Null인 건은 salary만, null이 아닌 건은 salary + (salary * commission_pct) 로 처리하는 Case 표현식을 작성해 보세요.

SELECT employee_id, first_name, last_name, salary, commission_pct
      ,CASE WHEN commission_pct IS NULL THEN salary
            ELSE salary + (salary * commission_pct)
      END real_salary
 FROM employees

-- Q3. 다음 문장을 실행하면 조회되는 로우는 몇 건일까요?
SELECT employee_id, first_name, last_name
  FROM employees
 WHERE ROWNUM < 1;
 
-- => 0 건
-- Rownum 의사컬럼은 쿼리 결과로 반환된 로우의 수를 나타내는데 where절에서 rownum이 1보다 작은 건을 조회하라는 조건을 주었으므로,
-- 결국 rownum = 0인 조건을 만족해야 하므로 0건이 조회됩니다.

--Q4. LOCATIONS 테이블에서 도시 이름이 S로 시작하는 건을 도시이름으로 내림차순 정렬해 조회하는 문장을 작성하시오.

SELECT *
  FROM LOCATIONS
 WHERE city like 'S%'
 ORDER BY city DESC
 
--Q5. LOCATIONS 테이블에서 미국에 있는 사무실(country_id 값이 US)에 우편물을 보내려고 주소를 작성하고자 합니다. 다음과 같은 형태로 결과가 조회되도록 문장을 작성하시오.
(우편번호 – 거리명 – 도시명 – 주명 – 국가코드 )

SELECT POSTAL_CODE || ' - ' || STREET_ADDRESS || ' - ' || CITY || ' - ' || STATE_PROVINCE || ' - ' || COUNTRY_ID AS 주소
  FROM LOCATIONS
 WHERE country_id = 'US'
 ORDER BY 1;

--Q6. 5번 문제에서 미국이 아닌 영국(country_id값이 UK)에 있는 사무실 주소를 조회한 결과인데, 첫 번째 건의 우편번호가 없습니다. 우편번호가 없는 건을 제외하고 조회하는 문장을 작성하시오.

SELECT POSTAL_CODE || ' - ' || STREET_ADDRESS || ' - ' || CITY || ' - ' || STATE_PROVINCE || ' - ' || COUNTRY_ID AS
주소
  FROM LOCATIONS
  WHERE country_id = 'UK'
   AND postal_code IS NOT NULL
  ORDER BY 1;
  
 --Q7. 6번 문제에서 우편번호가 없는 건을 제외하는 대신 우편번호가 없는 건은 우편번호를 '99999'로 나오도록 조회하는 문장을 작성하시오.

SELECT CASE WHEN POSTAL_CODE IS NULL THEN '99999'
            ELSE POSTAL_CODE
       END || ' - ' || STREET_ADDRESS || ' - ' || CITY || ' - ' || STATE_PROVINCE || ' - ' || COUNTRY_ID AS 주소
  FROM LOCATIONS
 WHERE country_id = 'UK'
 ORDER BY 1;
