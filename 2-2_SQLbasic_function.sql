-- 형변환 함수

-- TO_NUMBER 함수 - 문자를 숫자로 변환
-- TO_NUMBER ( char ) : char을 숫자로 변환
SELECT TO_NUMBER('12345.6789'), TO_NUMBER(-12.0)
FROM DUAL;

SELECT TO_NUMBER(1234)
FROM DUAL;

SELECT TO_NUMBER('ABC')
FROM DUAL;

-- TO_CHAR 함수 - 숫자를 문자로 변환
-- TO_CHAR ( n, number_format ) : 숫자인 n을 number_format에 맞게 문자로 변환, number_format은 생략 가능
SELECT TO_CHAR(123456.78912), TO_CHAR(123456.78912, '999,999.99999')
FROM DUAL;

SELECT TO_CHAR(123456.78912, '999.99999')
FROM DUAL;
==> ########## -> 숫자 포맷을 지정할 때는, 자리수를 넉넉하게

-- TO_CHAR 함수 - 날짜를 문자로 변환
-- TO_CHAR ( date, date_format ) : 날짜인 date를 date_format에 맞게 문자로 변환, date_format은 생략 가능
SELECT TO_CHAR(SYSDATE) D1,
       TO_CHAR(SYSDATE, 'YYYY-MM-DD HH24:MI:SS') D2
FROM DUAL;

SELECT TO_CHAR(SYSDATE, 'DD') D1, 
       TO_CHAR(SYSDATE, 'DAY') D2, 
       TO_CHAR(SYSDATE, 'DDD') D3
 FROM DUAL;
 ==> 13 월요일 347


SELECT SYSDATE D1, 
       TO_CHAR(SYSDATE, 'W') D2,
       TO_CHAR(SYSDATE, 'WW') D3,
       TO_CHAR(TO_DATE('2021-12-13','YYYY-MM-DD'), 'W') D4, 
       TO_CHAR(TO_DATE('2021-12-13','YYYY-MM-DD'), 'WW') D5
FROM DUAL;



-- TO_DATE 함수 - 문자를 날짜로 변환
-- TO_DATE ( char, date_format ) : 문자 char을 date_format에 맞게 날짜로 변환, date_format은 생략 가능
SELECT TO_DATE('2021-12-13 17:10:15', 'YYYY-MM-DD HH24:MI:SS')
FROM DUAL;

SELECT TO_DATE('2021-12-13', 'YYYY-MM-DD HH24:MI:SS')
FROM DUAL;

SELECT TO_DATE('20211213', 'YYYY-MM-DD HH24:MI:SS')
FROM DUAL;

SELECT TO_DATE('2021-12-13', 'YYYYMMDD HH24:MI:SS')
FROM DUAL;

-----------------------------------------------------------------------------------
-- Null 처리 함수

-- NULL 처리
-- NVL 함수
-- NVL( expr1, expr2 ) : expr1 값이 NULL이면 expr2를 반환
SELECT NVL(NULL, 'A'), NVL(NULL, 1), NVL(2, 3)
FROM DUAL;

-- NVL2 함수
-- NVL2 ( expr1, expr2, expr3 ) : expr1 값이 NULL이면 expr3을, NULL이 아니면 expr2를 반환
SELECT NVL2(NULL, 'A', 'B'), NVL2('A', 'B', 'C')
FROM DUAL;

-- COALESCE 함수
-- COALESCE ( expr1, expr2, ... ) : expr1, expr2, expr3, .... 에서 첫 번째 로 NULL이 아닌 값 반환
SELECT COALESCE(NULL, NULL, NULL, 'A', NULL, 'B')
FROM DUAL;

SELECT COALESCE(NULL, NULL, NULL, NULL, NULL, NULL)
FROM DUAL;

-- NULLIF 함수
-- NULLIF ( expr1, expr2 ) : expr1과 expr2 값이 같으면 NULL을, 같지 않으면 expr1 반환
SELECT NULLIF(100, 100), NULLIF(100, 200)
FROM DUAL;

------------------------------------------------------------------------
-- 기타 함수

-- DECODE 함수 (오라클에만 있는 함수)
-- DECODE ( expr, val1, result1, val2, result2, ..., default_value )
--     · expr값이 value1이면 result1, value2와 같으면 result2를 반환
--     · 일치하는 값이 없으면 default_value 반환
--     · 이 경우 default_value 생략시 Null 반환
--     · 단순형 CASE 표현식과 동작 방식 동일
-- DECODE 사용
--     · CASE 표현식 제공 전에는 DECODE 함수를 많이 사용
--     · CASE 표현식 등장 후 사용빈도가 줄어드는 추세
--     · DECODE 가 CASE 표현식에 비해 코드 양은 적으나 가독성이 떨어짐

SELECT  DECODE(1, 2, 3, 4, 5, 1, 7, 9)
       ,DECODE(1, 2, 3, 4, 5, 6, 7, 9)
       ,DECODE(1, 2, 3, 4, 5, 6, 7)
 FROM DUAL;


-- 재미있는 문제 풀이 
--1. 서기 1년 1월 1일부터 오늘까지 1조원을 쓰려면 매일 얼마를 써야 하는지 구하시오. 
--   최종 결과는 소수점 첫 째 자리에서 반올림 할 것 
SELECT TO_NUMBER(TO_CHAR(SYSDATE, 'YYYY')) - 1 LAST_YEAR
      ,TO_NUMBER(TO_CHAR(SYSDATE, 'DDD')) DAYS
      ,( ( TO_NUMBER(TO_CHAR(SYSDATE, 'YYYY')) - 1) * 365 ) + TO_NUMBER(TO_CHAR(SYSDATE, 'DDD')) DAYS_ALL
      , ROUND(1000000000000 / ( (( TO_NUMBER(TO_CHAR(SYSDATE, 'YYYY')) - 1) * 365 ) + TO_NUMBER(TO_CHAR(SYSDATE, 'DDD'))),0) TRILLIONS
FROM DUAL;

--2. 2021년 10월 26일 애인과 처음 만났다. 100일, 500일, 1000일 기념파티를 하고 싶은데, 언제인지 계산하기가 힘드네...  
SELECT TO_DATE('2021-10-26', 'YYYY-MM-DD') + 100 AS "100일"
      ,TO_DATE('2021-10-26', 'YYYY-MM-DD') + 500 AS "500일"
      ,TO_DATE('2021-10-26', 'YYYY-MM-DD') + 1000 AS "1000일"
FROM DUAL ;

-- 3. 524288 이란 숫자가 있다. 이 수는 2의 몇 승일까? 
SELECT log(2, 524288)
  FROM DUAL;

-- 4. 2050년 2월의 마지막 날은 무슨 요일일까?
SELECT TO_CHAR(LAST_DAY(TO_DATE('20500201', 'YYYYMMDD')), 'DAY')
FROM DUAL;

-- 5. 
SELECT ROUND(TO_DATE('2021-06-30 23:59:59', 'YYYY-MM-DD HH24:MI:SS'), 'YYYY') 
               AS THIS_YEAR
             ,ROUND(TO_DATE('2021-07-01 00:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'YYYY') 
              AS NEXT_YEAR
  FROM DUAL;
