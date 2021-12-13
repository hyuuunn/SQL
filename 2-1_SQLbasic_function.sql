-- 숫자형 함수
-- ABS
SELECT ABS(-7), ABS(0), ABS(7.8)
  FROM DUAL;
  
-- CEIL, FLOOR  
SELECT CEIL(7.6), FLOOR(7.6)
  FROM DUAL;  
  
-- EXP, LN, LOG
SELECT EXP(5), LN(148.413159102576603421115580040552279624), LOG(10, 10000)
FROM DUAL; 

SELECT EXP(LN(5))
FROM DUAL; 


-- MOD, SIGN
SELECT MOD(17, 3), SIGN(-19), SIGN(0)
  FROM DUAL;
  
-- POWER, SQRT
SELECT POWER(2,3), SQRT(3)
  FROM DUAL;
  
-- ROUND, TRUNC
SELECT ROUND(3.545, 2), ROUND(3.545, 1), TRUNC(3.545, 2), TRUNC(3.545, 1)
  FROM DUAL; 
   
-------------------------------------------------------------------------------------------

-- 문자형 함수

-- CONCAT
-- CONCAT( chr1, chr2 ) : chr1과 chr2 문자를 결합한 결과 반환, || 연산자와 같은 기능

SELECT CONCAT('A', 'B'), 'A' || 'B' || 'C'
  FROM DUAL;
  
-- INITCAP, UPPER, LOWER
-- INITCAP ( chr ) : chr의 첫 번째 문자를 대문자로 변환
-- LOWER ( chr ) : chr을 소문자로 변환
-- UPPER ( chr ) : chr을 대문자로 변환
SELECT INITCAP('abc'), UPPER('abc'), LOWER('A나bC'), INITCAP('홍gildong')
  FROM DUAL;  
  
SELECT *
FROM employees
WHERE first_name = 'steven';  

SELECT *
FROM employees
WHERE UPPER(first_name) = 'STEVEN';

-- LPAD, RPAD
-- LPAD ( expr1, n, expr2 ) : expr1을 반환하는데, expr2를 (n - expr1 길이)만큼 왼쪽을 채워 반환
-- RPAD ( expr1, n, expr2 ) : expr1을 반환하는데, expr2를 (n - expr1 길 이) 만큼 오른쪽을 채워 반환
SELECT LPAD( 'SQL', 5, '*' ), RPAD('SQL', 5, '*')
  FROM DUAL;
  
SELECT employee_id, 
       phone_number,
       LPAD(phone_number, 20, ' ') phone_number2
FROM employees
ORDER BY 1;  
  
-- LTRIM, RTRIM
-- LTRIM ( expr1, expr2 ) : expr1의 왼쪽에서 expr2를 제거한 결과를 반환
-- RTRIM ( expr1, expr2 ) : expr1의 오른쪽에서 expr2를 제거한 결과를 반환
SELECT LTRIM('**SQL**', '*'), RTRIM('**SQL**', '*')
  FROM DUAL;  
  
-- SUBSTR
-- SUBSTR ( chr, n1, n2 )
--    - chr에서 n1에서 시작해 n2 만큼 잘라낸 결과를 반환
--    - n1을 0으로 명시하면 1이 적용
--    - n1이 음수이면 chr 오른쪽 끝에서부터 거꾸로 세 어 가져옴
--    - n2를 생략하면 n1부터 끝까지 반환
SELECT SUBSTR('ABCDEFG', 1, 2) FIRSTS
      ,SUBSTR('ABCDEFG', 0, 2) SECONDS
      ,SUBSTR('ABCDEFG', 3, 2) THIRDS
      ,SUBSTR('ABCDEFG', 3 )   FOURTHS
      ,SUBSTR('ABCDEFG', -3)   FIFTHS
      ,SUBSTR('ABCDEFG', -3, 2)  SIXTHS
  FROM DUAL;    
  
-- TRIM, ASCII, LENGTH, LENGTHB
-- TRIM ( chr ) : chr의 양쪽 끝 공백을 제거한 결과를 반환
-- ASCII ( chr ) : chr문자의 ASCII 코드 값을 반환
-- LENGTH ( chr ) : chr 문자의 글자 수를 반환
-- LENGTHB(chr) : chr 문자의 바이트수 반환
SELECT TRIM(' AB C D '), ASCII('a'), LENGTH('A B C'), LENGTHB('A B 강')
  FROM DUAL;  
  
-- REPLACE
-- REPLACE ( chr, serch_str, rep_str ) : Chr에서 serch_str을 찾아 rep_str로 대체
SELECT REPLACE('산은 산이요 물은 물이다', '산', '언덕')
  FROM DUAL;  
  
SELECT TRIM(' AB C D '), REPLACE(' AB C D ', ' ', '')
  FROM DUAL;    
  
-- INSTR
-- INSTR ( chr1,chr2, n1, n2 )
-- - chr1에서 chr2 문자를 찾아 그 시작 위치 반환
-- - n1은 chr1에서 몇 번째 문자부터 찾을 것인지를 나타냄. 생략 시 1이 적용
-- - n2는 chr1에서 chr2 문자를 찾을 때 일치하는 문 자의 몇번째 위치를 반환할지를 나타냄. 생략 시 1 이 적용됨
SELECT INSTR('ABCABCABC', 'C')
      ,INSTR('ABCABCABC', 'c')
      ,INSTR('ABCABCABC', 'C', 2)
      ,INSTR('ABCABCABC', 'C', 2, 2)
FROM DUAL;

-------------------------------------------------------------------------------------------

-- 날짜형 함수

-- SYSDATE
-- SYSDATE : 현재 일자와 시간을 반환 (오라클 설치된 서버시간)
SELECT SYSDATE
  FROM DUAL;
  
-- ADD_MONTHS
-- ADD_MONTHS ( date, n ) : date 날짜에 n개월을 더한 날짜를 반환
SELECT ADD_MONTHS(SYSDATE, 1), ADD_MONTHS(SYSDATE, -1), ADD_MONTHS(SYSDATE, 0)
  FROM DUAL;  
  
-- MONTHS_BETWEEN
-- MONTHS_BETWE EN ( date1, date2 ) : date1과 date2 두 날짜 사이의 개월 수를 반환. ate1 > date2 이면 양수, 반대면 음수
SELECT SYSDATE + 31
      ,SYSDATE - 31
      ,MONTHS_BETWEEN(SYSDATE + 31, SYSDATE )
      ,MONTHS_BETWEEN(SYSDATE - 31, SYSDATE )
FROM DUAL;
  
-- LAST_DAY, NEXT_DAY
-- LAST_DAY ( date ) : date가 속한 월의 마지막 일자를 반환
-- NEXT_DAY ( date, expr ) : date 날짜를 기준으로 expr에 명시한 날짜 반환.
--                           - expr: ‘월요일’...or1~7형태로쓸수도있 고 1~7까지 숫자를 쓸 수도 있음(1은 일요일, 7은 토요일)
SELECT LAST_DAY(SYSDATE)
      ,NEXT_DAY(SYSDATE, '금')
FROM DUAL ;  

-- ROUND
-- ROUND ( date, format ) : date를 format 기준으로 반올림한 날짜 반환. format은 YYYY, MM, DD, HH, HH24, MI 등 사용 가능, 생략 시 DD
SELECT SYSDATE 
      ,ROUND(SYSDATE, 'YYYY') YEARS
      ,ROUND(SYSDATE, 'MM') MONTHS
      ,ROUND(SYSDATE, 'DD')   DAYS
      ,ROUND(SYSDATE, 'HH24')  HOURS24
      ,ROUND(SYSDATE, 'MI')    MINUTES
      ,ROUND(SYSDATE)          DEFAULTS
FROM DUAL ;  


-- TRUNC
-- TRUNC ( date, format ) : date를 format 기준으로 잘라낸 날짜 반환. format은 ROUND 함수와 동일하게 사용 가 능
SELECT SYSDATE 
      ,TRUNC(SYSDATE, 'YYYY') YEARS
      ,TRUNC(SYSDATE, 'MM') MONTHS
      ,TRUNC(SYSDATE, 'DD')   DAYS
      ,TRUNC(SYSDATE, 'HH24')  HOURS24
      ,TRUNC(SYSDATE, 'MI')    MINUTES
      ,TRUNC(SYSDATE)          DEFAULTS
FROM DUAL ;  

SELECT SYSDATE,
       SYSDATE + 1 nextday,
       SYSDATE - 1 previousday
  FROM DUAL;

