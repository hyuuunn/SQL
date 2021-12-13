-- 문제 풀이 
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
