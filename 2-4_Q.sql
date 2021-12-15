-- 2-1

-- Q1. INITCAP, UPPER, LOWER는 영문자를 대소문자로 변환하는 함수입니다. 다음 문장처럼 매개변수로 한글이 입력되면 그 결과는 어떻게 될까요?
SELECT UPPER('홍길동')
FROM DUAL;

-- => 오류가 나지 않고 아무런 변환 없이 홍길동이 그대로 반환됩니다.

-- Q2. 다음 문자열은 보헤미안 렙소디 가사 첫 부분입니다. 이 중에서 'fantasy?' 만 반환하도록 SUBSTR 함수를 작성해 보세요.
'Is this the real life? Is this just fantasy?'

SELECT SUBSTR('Is this the real life? Is this just fantasy?', -8)
 FROM dual;

SELECT SUBSTR('Is this the real life? Is this just fantasy?',
       INSTR('Is this the real life? Is this just fantasy?', 'fant')) results
 FROM dual;
 
-- Q3. 현재 일자 기준 익월 1일을 반환하는 select 문을 작성해 보세요.

SELECT LAST_DAY(SYSDATE) + 1
 FROM dual;

-- Q4. EMPLOYEES 테이블에서 사번이 110번 이하인 사원의 입사일자가 현재일자 기준으로 몇 개월이나 지났는지 구하는 문장을 작성해 보세요

SELECT employee_id, first_name, last_name, hire_date,
       ROUND(MONTHS_BETWEEN(SYSDATE, hire_date))
  FROM employees
 WHERE employee_id <= 110;
 
-- Q5. EMPLOYEES 테이블의 PHONE_NUMBER 컬럼에는 사원의 전화번호가 111.111.1111 형태로 저장되어 있는데, 이를 111-111-1111로 바꿔 조회하는 문장을 작성하시오

SELECT employee_id, first_name, last_name,
       REPLACE(phone_number, '.', '-') phone2
 FROM employees;

-- Q.6 LOCATIONS 테이블에서 location_id가 2400보다 작거나 같은 건의 street_address 컬럼을 조회한 결과에서
-- 이 컬럼 앞부분에 있는 숫자형식을 제거하고 조회하는 문장을 작성하시오.

SELECT location_id,
       substr(street_address, instr(street_address,' ')+ 1) street_address2
  FROM locations
 WHERE location_id <= 2400;
 
-------------------------------------------------------
-- 2-2
 
-- Q1. 2023년 8월 20일을 기준으로 그 달의 마지막 날짜의 요일을 구하는 쿼리를 작성해 보세요.
--    ( to_date, last_day, to_char 함수 사용)

SELECT TO_CHAR(LAST_DAY(TO_DATE('2023-08-20', 'YYYY-MM-DD')), 'DAY')
 FROM DUAL;

-- Q2. 다음 문장에서 CASE 표현식 부분을 NVL 함수로 변환해 보세요
SELECT employee_id, first_name, last_name, salary, commission_pct
      ,CASE WHEN commission_pct IS NULL THEN salary
            ELSE salary + (salary * commission_pct)
       END real_salary
 FROM employees;

SELECT employee_id, first_name, last_name, salary, commission_pct
   ,salary + salary * nvl(commission_pct, 0) real_salary
 FROM employees;

-- Q3. Quiz 2번의 문제에 있는 CASE 표현식을 이번에는 decode 함수를 사용해 동일한 결과를 반환하도록 만들어 보세요.

SELECT employee_id, first_name, last_name, salary, commission_pct
       ,salary + salary * DECODE(commission_pct, null, 0, commission_pct) real_salary
 FROM employees;

-- Q4. 현재 일자 기준 1년 후의 날짜를 조회해 보세요.

SELECT SYSDATE + 365, ADD_MONTHS(SYSDATE, 12)
 FROM DUAL;
 
-- Q5. 현재 일자 기준 3년 후의 날짜를 조회해 보세요.

SELECT SYSDATE + 365 * 3, ADD_MONTHS(SYSDATE, 12 * 3)
 FROM DUAL;
 
-- Q6. 2021년 10월 31일은 서기가 시작된 후 몇 일이나 지났는지 계산하는 문장을 작성하시오.

SELECT TO_DATE('2021-10-31','YYYY-MM-DD') - TO_DATE('0001-01-01','YYYY-MM-DD')
FROM DUAL;
