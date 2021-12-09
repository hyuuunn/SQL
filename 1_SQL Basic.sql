-- 테이블 생성
CREATE TABLE  EMP (
       emp_no      VARCHAR2(30)  NOT NULL,
       emp_name    VARCHAR2(80)  NOT NULL,
       salary      NUMBER            NULL,
       hire_date   DATE              NULL
);


-- emp 테이블 내역 조회
DESC EMP;

--emp_name 컬럼 크기를  80에서 100으로 변경 
ALTER TABLE emp 
MODIFY EMP_NAME VARCHAR2(100);

-- 컬럼 추가 
ALTER TABLE emp
ADD EMP_NAME2  VARCHAR2(80);

-- 컬럼명 변경
ALTER TABLE emp
RENAME COLUMN EMP_NAME2 TO EMP_NAME3;

-- 컬럼 삭제 
ALTER TABLE emp
DROP COLUMN EMP_NAME3;

-- emp 테이블 내역 조회
DESC EMP;

-- emp 테이블 삭제 
DROP TABLE emp;

-- emp 테이블 삭제 확인 
DESC EMP;

-- 테이블 생성 시 PK 생성1
CREATE TABLE  EMP (
       emp_no      VARCHAR2(30)  PRIMARY KEY, 
       emp_name    VARCHAR2(80)  NOT NULL,
       salary      NUMBER            NULL,
       hire_date   DATE              NULL
);

-- 테이블 생성 시 PK 생성2
CREATE TABLE  EMP2 (
       emp_no      VARCHAR2(30)  , 
       emp_name    VARCHAR2(80)  NOT NULL,
       salary      NUMBER            NULL,
       hire_date   DATE              NULL,
       PRIMARY KEY (emp_no)
);


-- alter table 문 사용  
 CREATE TABLE  EMP3 (
       emp_no      VARCHAR2(30)  ,
       emp_name    VARCHAR2(80)  NOT NULL,
       salary      NUMBER            NULL,
       hire_date   DATE              NULL
       );


ALTER TABLE EMP3
ADD CONSTRAINTS EMP3_PK PRIMARY KEY ( EMP_NO );

-- 생성, 수정, 삭제 실습
CREATE TABLE DEPT_TEST (
       dept_no      NUMBER        NOT NULL,
       dept_name    VARCHAR2(50)  NOT NULL,
       dept_desc    VARCHAR2(100)     NULL,
       create_date  DATE 
);

-- 테이블 생성 확인
DESC DEPT_TEST;

-- DEPT_DESC1 컬럼 추가
ALTER TABLE DEPT_TEST
ADD  DEPT_DESC1 VARCHAR2(80);

-- DEPT_DESC1 컬럼 삭제
ALTER TABLE DEPT_TEST
DROP COLUMN DEPT_DESC1 ;

-- DEPT_TEST_PK 란 이름으로 PK 생성
ALTER TABLE DEPT_TEST
ADD CONSTRAINTS DEP_TEST_PK PRIMARY KEY ( DEPT_NO);


-- DEPT_TEST 테이블 삭제 
DROP TABLE DEPT_TEST;

-----------------------------------------------------------------------------------------------------

-- SELECT 실습

-- employees 테이블 조회  
SELECT *
FROM EMPLOYEES;

-- employees 테이블 layout  
DESC EMPLOYEES;
=>
이름             널?       유형           
-------------- -------- ------------ 
EMPLOYEE_ID    NOT NULL NUMBER(6)    
FIRST_NAME              VARCHAR2(20) 
LAST_NAME      NOT NULL VARCHAR2(25) 
EMAIL          NOT NULL VARCHAR2(25) 
PHONE_NUMBER            VARCHAR2(20) 
HIRE_DATE      NOT NULL DATE         
JOB_ID         NOT NULL VARCHAR2(10) 
SALARY                  NUMBER(8,2)  
COMMISSION_PCT          NUMBER(2,2)  
MANAGER_ID              NUMBER(6)    
DEPARTMENT_ID           NUMBER(4) 

-- employees 테이블 일부컬럼 조회  
SELECT EMPLOYEE_ID, FIRST_NAME, LAST_NAME, SALARY
FROM EMPLOYEES;
=>
EMPLOYEE_ID  FIRST_NAME   LAST_NAME  SALARY
100	     Steven	  King        24000
101	     Neena	  Kochhar     17000
102	     Lex	  De Haan     17000

-- departmemts 테이블 조회
SELECT *
  FROM departments;
  
  

-- WHERE 절 실습
-- 사번이 100번인 사원 조회 
SELECT *
  FROM EMPLOYEES
 WHERE EMPLOYEE_ID = 100;

-- 사번이 100번이 아닌 사원 조회1
SELECT *
  FROM EMPLOYEES
 WHERE EMPLOYEE_ID <> 100;
 
-- 사번이 100번이 아닌 사원 조회2
 SELECT *
  FROM EMPLOYEES
 WHERE EMPLOYEE_ID != 100;
 
-- 사번이 100보다 크고 JOB_ID가 ST_CLERK인 사원 조회 
SELECT *
  FROM EMPLOYEES
 WHERE EMPLOYEE_ID > 100
   AND JOB_ID = 'ST_CLERK';
 
-- 급여가 5000 이상인 사원 조회
SELECT *
  FROM EMPLOYEES
 WHERE SALARY >= 5000;
 
-- 급여가 5000 이상인 사원의 사번과 이름, 급여를 조회 
SELECT EMPLOYEE_ID, FIRST_NAME, LAST_NAME, SALARY
  FROM EMPLOYEES
 WHERE SALARY >= 5000;
 =>
 EMPLOYEE_ID   FIRST_NAME  LAST_NAME  SALARY
 100	       Steven	   King       24000
 101	       Neena	   Kochhar    17000
 102	       Lex	   De Haan    17000
 
 
-- 급여가 2400 이하이고 20000 이상인 사원 조회  
SELECT *
  FROM employees
 WHERE salary <= 2400
    OR salary >= 20000; 
    
    
-- last_name이 grant인 사원 조회 
SELECT *
  FROM employees
 WHERE last_name = 'grant' ;
 => 
 없음
 
-- last_name이 Grant인 사원 조회  
SELECT *
  FROM employees
 WHERE last_name = 'Grant' ;
 =>
 EMPLOYEE_ID  FIRST_NAME    LAST_NAME     EMAIL         PHONE_NUMBER         HIRE_DATE                 JOB_ID          SALARY        COMMISSION_PCT       MANAGER_ID    DEPARTMENT_ID
 199	       Douglas	    Grant	  DGRANT	650.507.9844	     2008/01/13 00:00:00	SH_CLERK       2600		                  124	         50
 178	       Kimberely    Grant	  KGRANT	011.44.1644.429263   2007/05/24 00:00:00	SA_REP	       7000	     0.15	          149	
    
   
-- ORDER BY 절 실습     
-- 사번 순으로 정렬
SELECT *
FROM employees
ORDER BY employee_id;

-- 사번 내림차순 정렬
SELECT *
FROM employees
ORDER BY employee_id DESC;

-- 이름, 성 순으로 오름차순 정렬
SELECT *
FROM employees
ORDER BY first_name, last_name
;

-- 이름은 오름차순, 성은 내림차순으로 정렬
SELECT employee_id, first_name, last_name
FROM employees
ORDER BY first_name, last_name desc
;


SELECT employee_id, first_name, last_name, salary
  FROM employees
 WHERE salary >= 5000
 ORDER BY salary desc;


-- 숫자를 명시해 정렬1 
-- 2, 3 : 첫번째 컬럼과 두번째 컬럼 순으로 정렬
SELECT *
FROM employees
ORDER BY 2, 3 DESC
;


-- 숫자를 명시해 정렬2
-- 셀렉트된 항목은 4가지. 5번째 컬럼 없으므로 오류
SELECT employee_id, first_name, last_name, email
FROM employees
ORDER BY 2, 3, 5;


-- 숫자를 명시해 정렬3
-- first_name, last_name, phone_number 기준으로 정렬되지만 phone_number는 보여지지 않음.
SELECT employee_id, first_name, last_name, email
FROM employees
ORDER BY 2, 3, phone_number;


-- commission_pct 컬럼으로 오름차순 정렬
-- 오라클에서는 null 값이 큰 값
SELECT employee_id, first_name, last_name, commission_pct
FROM employees
ORDER BY commission_pct;
=>
employee_id   first_name    last_name     commission_pct
173	      Sundita       Kumar	  0.1
166	      Sundar        Ande	  0.1
163	      Danielle      Greene	  0.15


-- commission_pct 컬럼으로 내림차순 정렬
SELECT employee_id, first_name, last_name, commission_pct
FROM employees
ORDER BY commission_pct DESC;

-- NULL을 먼저  
SELECT employee_id, first_name, last_name, commission_pct
  FROM employees
 ORDER BY commission_pct NULLS FIRST;
 
-- NULL을 나중에 
SELECT employee_id, first_name, last_name, commission_pct
  FROM employees
 ORDER BY commission_pct NULLS LAST; 

-----------------------------------------------------------------------------------------------------

-- 연산자 실습
-- 더하기, 빼기
SELECT 1+1 plus_test, 1-1 minus_test
  FROM DUAL;
=>
plus_test     minus_test
2	      0

-- 곱하기, 나누기  
SELECT 1+1*3 multiply, 7-4/2 divide
  FROM DUAL;  
=>
multiply     divide
4	     5

-- 괄호  
SELECT (1+1)*3 multiply, (7-4)/2 divide
  FROM DUAL;  
  
-- 문자열 결합
SELECT 'A' || 'B', 'C' || 'D' || 'F'
  FROM DUAL;  
=>
AB	CDF


-- 문자열 결합 사용 예
-- 컬럼 및 표현식 다음에 AS 별칭(Alias)을 기술하면 조회 결과가 별칭으로 보임
SELECT first_name || ' ' || last_name AS full_name
FROM EMPLOYEES;
-- 별칭에서 AS는 생략 가능
SELECT first_name || ' ' || last_name full_name
FROM employees;
=>
full_name
Ellen Abel
Sundar Ande
Mozhe Atkinson



-- 비교연산자
-- 동등연산자
SELECT *
  FROM employees
 WHERE salary = 2500;
 
-- 비동등연산자
SELECT *
  FROM employees
 WHERE salary != 2500;
 
 SELECT *
  FROM employees
 WHERE salary <> 2500;
 
-- 부등호 연산자1
 SELECT *
  FROM employees
 WHERE salary > 3000 
 ORDER BY salary;
 
--  부등호 연산자2
 SELECT *
  FROM employees
 WHERE salary >= 3000 
 ORDER BY salary; 
 
-- 부등호 연산자3
SELECT *
  FROM employees
 WHERE salary < 3000 
 ORDER BY salary desc; 
 
--  부등호 연산자4
SELECT *
  FROM employees
 WHERE salary <= 3000 
 ORDER BY salary desc;  
 
-- 부등호 연산자5
SELECT *
  FROM employees
 WHERE salary >= 3000 
   AND salary <= 5000
 ORDER BY salary;  
 
-- between and  연산자  
SELECT *
  FROM employees
 WHERE salary BETWEEN 3000 AND 5000
 ORDER BY salary;   
 
-- not 연산자   
SELECT *
  FROM employees
 WHERE NOT (salary = 2500 )
 ORDER BY salary; 
 
-- null 비교
-- NULL 연산자 : IS NULL, IS NOT NULL
-- col1 값이 NULL인지 체크
--     - col1 = NULL (X)
--     - col1 IS NULL (O)
-- NULL은 공백(' ')이 아님
-- 오라클에서는 NULL과 empty string('') 을 동일시 함 ( 다른 DBMS에서는 구별)
-- null 비교1
 SELECT *
  FROM employees
 WHERE commission_pct = NULL;
=>
아무것도 안나옴
 
-- null 비교2
SELECT *
  FROM employees
 WHERE commission_pct IS NULL;
=>
성과급 없는 사람 

-- null 비교3
SELECT *
  FROM employees
 WHERE commission_pct IS NOT NULL; 
 
-- LIKE 연산자
-- LIKE : 문자열 비교
--     - last_name like 'da%' : last_name이 da로 시작하는 모든 항목
--     - last_name like '%d‘ : last_name이 d로 끝나는 모든 항목
--     -'%' 는모든문자를의미

-- LIKE 연산자1
SELECT *
  FROM employees
 WHERE phone_number LIKE '011%';
 
-- 2-3-24. LIKE 연산자2
SELECT *
  FROM employees
 WHERE phone_number LIKE '%9'; 
 
-- LIKE 연산자3
SELECT *
  FROM employees
 WHERE phone_number LIKE '%124%';

-- IN 연산자
-- IN : 컬럼 IN (값1, 값2, 값3, ...) -> OR와 동일한 동작
-- 컬럼 의 값이 (값1, 값2, 값3, ...) 인 모든 항목

-- IN 연산자1
-- JOB_ID의 값이 'IT_PROG', 'AD_VP', 'FI_ACCOUNT' 인 모든 항목
SELECT *
  FROM employees
 WHERE JOB_ID IN ('IT_PROG', 'AD_VP', 'FI_ACCOUNT');
 
-- IN 연산자2
-- JOB_ID의 값이 'IT_PROG', 'AD_VP', 'FI_ACCOUNT' 이 아닌 모든 항목
SELECT *
  FROM employees
 WHERE JOB_ID NOT IN ('IT_PROG', 'AD_VP', 'FI_ACCOUNT');

-- 집합(SET) 연산자 : UNION, UNION ALL, INTERSECT, MINUS, ... · EXISTS

-- SQL 표현식

-- CASE 표현식
-- IF ~ THEN ~ ELSE 로직을 구현한 표현식
-- 여러 조건을 체크해 조건별 값을 반환하는 표현식
-- 단순형과 검색형이 있음
-- CASE expr WHEN 비교표현식1 THEN 값1 
--           WHEN 비교표현식2 THEN 값2
--           ....
--           ELSE 값n
-- END
-- expr 이 비교표현식1과 같으면 값1, 비교표현식2와 같으면 값2를 반환 어느 비교표현식과도 같지 않으면 ELSE 다음의 값n을 반환

SELECT *
FROM regions;

SELECT *
FROM countries;


-- 단순형 CASE 
SELECT country_id
      ,country_name
      ,CASE region_id WHEN 1 THEN '유럽'
                      WHEN 2 THEN '아메리카'
                      WHEN 3 THEN '아시아'
                      WHEN 4 THEN '중동 및 아프리카'
       END region_name
FROM countries;

=>
country_id    country_name  region_name
AR	      Argentina	       아메리카
AU	      Australia	       아시아
BE	      Belgium	       유럽
BR	      Brazil	       아메리카

-- 검색형 CASE1
SELECT employee_id, first_name, last_name, salary, job_id
      ,CASE WHEN salary BETWEEN 1     AND 5000  THEN '낮음'
            WHEN salary BETWEEN 5001  AND 10000 THEN '중간'
            WHEN salary BETWEEN 10000 AND 15000 THEN '높음'
            ELSE '최상위'
       END salary_rank     
FROM employees;
=>
employee_id   first_name    last_name     salary job_id
102	Lex	De Haan	17000	AD_VP	최상위
103	Alexander	Hunold	9000	IT_PROG	중간
104	Bruce	Ernst	6000	IT_PROG	중간
105	David	Austin	4800	IT_PROG	낮음

-- ???
SELECT employee_id, first_name, last_name, salary, job_id
      ,CASE WHEN salary BETWEEN 1     AND 5000  THEN '낮음'
            WHEN salary BETWEEN 5001  AND 10000 THEN '중간'
            WHEN salary BETWEEN 10000 AND 15000 THEN '높음'
            ELSE '최상위'
       END salary_rank     
FROM employees;
order by 6
-- 6번째에 있으므로 6번을 기준으로 정렬해라???


-- 검색형 CASE2
SELECT employee_id, first_name, last_name, salary, job_id
      ,CASE WHEN salary BETWEEN 1     AND 5000  THEN '낮음'
            WHEN salary BETWEEN 5001  AND 10000 THEN '중간'
            WHEN salary BETWEEN 10000 AND 15000 THEN '높음'
            ELSE 9
       END salary_rank     
FROM employees;
=>
오류
일관성 없는 데이터 유형(CHAR이 필요하지만 NUMBER임)

-- 검색형 CASE3
SELECT employee_id, first_name, last_name, salary, job_id
      ,CASE WHEN salary BETWEEN 1     AND 5000  THEN 1
            WHEN salary BETWEEN 5001  AND 10000 THEN 2
            WHEN salary BETWEEN 10000 AND 15000 THEN 3
            ELSE 9
       END salary_rank     
FROM employees;

-- 의사컬럼 (pseudocolumn)
-- 테이블에 있는 컬럼 처럼 동작하지만 실제 컬럼은 아닌 가상 컬럼
-- ROWNUM 의사컬럼
--     - 쿼리 수행 후 조회된 각 로우에 대해 ROWNUM 의사컬럼은 그 순서를 가리키는 수를 반환
--     - 첫 번째 선택된 로우는 1, 두 번째는 2, ... 순으로 증가됨
--     - 주로 where 절에서 쿼리 결과로 반환되는 로우 수를 제어할 때 사용
-- 이 외에도 계층형 쿼리, 시퀀스, XML 관련 의사컬럼이 있음

-- rownum 1
SELECT employee_id, first_name, last_name, rownum
FROM employees;

--  rownum 2
SELECT employee_id, first_name, last_name, rownum
FROM employees
WHERE rownum <= 5;
