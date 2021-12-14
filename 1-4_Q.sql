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
