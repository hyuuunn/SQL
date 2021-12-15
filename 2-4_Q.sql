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
