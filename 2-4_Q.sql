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
