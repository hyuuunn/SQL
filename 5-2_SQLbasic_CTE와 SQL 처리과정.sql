-- 1. WITH 절 or CTE (Common Table Expression)
--    · 서브쿼리의 일종
--    · WITH 절(clause)이라고도 하고 CTE 라고도 함
--    · 하나의 서브쿼리를 또 다른 서브쿼리에서 참조하여 재 사용 가능한 구문
--    · 오라클 11g 까지는 하나의 서브쿼리에서 다른 서브쿼리 참조 못했음
--          ->W ITH 절 사용
--          -> 오라클 12c 부터는 LATERAL 키워드 사용해 가능
--    · WITH절 구문
            WITH alias1 AS ( SELECT ...
                                FROM ... ),
                 alias2 AS ( SELECT ...
                                FROM ... ),
                 ....
                 alias_last AS (SELECT ...
                                FROM... )
            SELECT ...
               FROM alias_last
            ...;
--    · WITH 별칭 AS 다음에 서브쿼리 형태
--    · WITH은 한 번만 명시, 서브쿼리는 여러 개 사용 가능
--    · 최종 반환 결과는 마지막에 있는 메인 쿼리
--    · 서브쿼리 내에서 다른 서브쿼리 참조 가능
--          ->서브쿼리 내의 FROM 절에서 다른 서브쿼리 별칭을 기술해 인라인 뷰처럼 사용 가능
--    · 메인 쿼리에서는 FROM 절에서 서브쿼리 한 개, 혹은 여러 개의 서브쿼리 조인해 결과 조회 가능

-- 2. WITH 절 특징
--    · WITH 절은 내부적으로 TEMP 테이블 스페이스를 사용함
--          -> TEMP 테이블스페이스에 각 서브쿼리 결과를 담아두고 있음
--    · TEMP 테이블스페이스는 정렬 용도로 사용
--    · 과도한 WITH 절 사용 시, TEMP 테이블스페이스 공간을 점유해 성능에 좋지 않음
--    · 일반적인 경우에는 서브쿼리를 사용하고, 서브쿼리 사용이 수월치 않은 경우 WITH 절 사용

-- 다양한 유형의 서브쿼리 

SELECT last_name, employee_id
      ,salary + NVL(commission_pct, 0)
      ,job_id, e.department_id
  FROM employees e
      ,departments d
WHERE e.department_id = d.department_id
  AND salary + NVL(commission_pct,0) > ( SELECT salary + NVL(commission_pct,0)
                                           FROM employees
                                          WHERE last_name = 'Pataballa')
ORDER BY last_name, employee_id;


-- WITH 절
-- 1
WITH dept AS (
SELECT department_id, 
       department_name  dept_name
  FROM departments 
)
SELECT a.employee_id
      ,a.first_name || ' ' || a.last_name
  FROM employees a,
       dept b
 WHERE a.department_id = b.department_id
ORDER BY 1;       

 
-- 2
WITH dept_loc AS (
SELECT a.department_id, a.department_name dept_name,
       b.location_id, b.street_address, 
       b.city, b.country_id
  FROM departments a,
       locations b 
 WHERE a.location_id = b.location_id
),
cont AS (
SELECT b.department_id, b.dept_name, 
       b.street_address, b.city, a.country_name
  FROM countries a,
       dept_loc b
 WHERE a.country_id = b.country_id
)
SELECT a.employee_id,
       a.first_name || ' ' || a.last_name emp_name,
       b.dept_name, b.street_address,
       b.country_name
  FROM employees a,
       cont b
 WHERE a.department_id = b.department_id
 ORDER BY 1;       
        

-- 3
WITH emp_info AS (
SELECT a.employee_id,
       a.first_name || ' ' || a.last_name emp_name,
       b.department_id, b.department_name dept_name,
       c.street_address, c.city,
       d.country_name, e.region_name
  FROM employees a,
       departments b,
       locations c,
       countries d,
       regions e 
 WHERE a.department_id = b.department_id
   AND b.location_id   = c.location_id
   AND c.country_id    = d.country_id
   AND d.region_id     = e.region_id
)
SELECT *
  FROM emp_info
 ORDER BY 1;   


-- 4
WITH coun_sal AS (
SELECT c.country_id, SUM(a.salary) sal_amt
  FROM employees a,
       departments b,
       locations c
 WHERE a.department_id = b.department_id 
   AND b.location_id = c.location_id
GROUP BY c.country_id ),
mains AS (
SELECT b.country_name, a.sal_amt
  FROM coun_sal a,
       countries b
 WHERE a.country_id = b.country_id       
)
SELECT *
  FROM mains
 ORDER BY 1;     




-- Top N Query
-- 1 
SELECT *
FROM ( SELECT a.employee_id,
              a.first_name || ' ' || a.last_name emp_name,
              a.salary
         FROM employees a
        ORDER BY a.salary DESC
     ) b
WHERE ROWNUM <= 5; 

-- 2
SELECT *
FROM ( SELECT a.employee_id,
              a.first_name || ' ' || a.last_name emp_name,
              a.salary,
              ROW_NUMBER() OVER (ORDER BY a.salary DESC) ROW_SEQ
         FROM employees a
     ) b
WHERE ROW_SEQ <= 5;

-- 3
SELECT a.employee_id,
       a.first_name || ' ' || a.last_name emp_name,
       a.salary
  FROM employees a
 ORDER BY a.salary DESC
 FETCH FIRST 5 ROWS ONLY;
 
 
-- 4
SELECT a.employee_id,
       a.first_name || ' ' || a.last_name emp_name,
       a.salary
  FROM employees a
 FETCH FIRST 5 ROWS ONLY;
 
             
-- 5
SELECT a.employee_id,
       a.first_name || ' ' || a.last_name emp_name,
       a.salary
  FROM employees a
 ORDER BY a.salary DESC  
 FETCH FIRST 5 PERCENT ROWS ONLY;
 
 
-- 6
SELECT a.employee_id,
       a.first_name || ' ' || a.last_name emp_name,
       a.salary
  FROM employees a
 ORDER BY a.salary   
 FETCH FIRST 5 PERCENT ROWS ONLY;
 
-- 7
SELECT a.employee_id,
       a.first_name || ' ' || a.last_name emp_name,
       a.salary
  FROM employees a
 ORDER BY a.salary   
 FETCH FIRST 5 PERCENT ROWS WITH TIES;


-- 3. SQL 처리과정
--    · SQL 문장을 작성해 실행하면 오라클 내부에서 어떻게 처리될까?
--    · SQL 내부 처리 프로세스
--          - SQL Syntax Check
--          - SQL Semantic Check
--          - 가능한 여러 개의 실행계획(Execution Plan) 수립
--          - 최적의 실행계획을 선택 해 SQL 실행
--          - 실행 결과 반환

--    · Syntax Check : SQL 문장 검사 (오타 등)
--          예) select * form employees;
--             ORA-00923: FROM keyword not found where expected
--    · Semantic Check : 의미 검사, 객체 권한 검사
--          예) select * from hong;
--             ORA-00942: table or view does not exist
--    · Shared Pool Check : SQL문장에 ID 부여 등
--    · Optimization
--          - SQL 문장을 최적화 해 재작성
--          - 여러 개의 실행계획 생성
--    · Row Source Generation : 최적의 실행계획 선정
--    · Execution : 실행

--    · 최적의 실행계획이란 ?
--    · 내비게이션 시스템과 비슷함
--    · 여러 개의 실행계획을 세우고 그 중 가장 비용(Cost)이 낮은 계획을 선택해 실행
--          -> 가장 빨리 결과를 내는 실행계획을 선택

--    · 최적의 실행계획을 위해서는 테이블의 통계정보를 최신으로 갱신
--    · 통계정보 : 테이블의 로우 수, 블록 수 등 실행계획을 세우기 위한 기초 정보
--    · 같은 테이블에 100건, 10000건, 백만 건 있을 경우에 따라 통계정보 달라짐
--          - 조인 시, 어떤 테이블을 먼저 읽느냐에 따라 성능 차이 발생
--    · 내비게이션에서 현재 교통상황을 반영하면 경로가 달라지는 것과 유사

--    · 오라클 버전이 올라갈수록 실행계획을 잘 세우고 있음
--    · 실행계획을 잘 못 세웠을 경우, SQL 실행 계획을 조정해 성능을 향상 -> SQL 튜닝 (힌트 사용)
--    · 대부분의 경우, 튜닝 시 조인 방식과 순서를 변경

--    · 실행했던 SQL 이력 조회 (ORAUSER로 접속해 실행)
            SELECT *
              FROM V$SQL;
    
     
 
-- SQL 처리과정 
-- 1
WITH coun_sal AS ( /*+ gather_plan_statistics */
SELECT c.country_id, SUM(a.salary) sal_amt
  FROM employees a,
       departments b,
       locations c
 WHERE a.department_id = b.department_id 
   AND b.location_id = c.location_id
GROUP BY c.country_id ),
mains AS (
SELECT b.country_name, a.sal_amt
  FROM coun_sal a,
       countries b
 WHERE a.country_id = b.country_id       
)
SELECT *
  FROM mains
 ORDER BY 1;
 
 
-- 2
SELECT /*+ gather_plan_statistics */
       d.country_name, SUM(a.salary) sal_amt
  FROM employees a,
       departments b,
       locations c, 
       countries d
 WHERE a.department_id = b.department_id 
   AND b.location_id = c.location_id
   AND c.country_id = d.country_id
GROUP BY d.country_name
ORDER BY 1;

 
SELECT *
FROM V$SQL 
WHERE sql_text LIKE '%gather%'
;


select *
from table(dbms_xplan.display_cursor ( 'gx8yap8azwk86', null, 'ADVANCED ALLSTATS LAST'));


-- 3
SELECT /*+ gather_plan_statistics */
       -- hong123
       a.employee_id, 
       a.first_name || ' ' || a.last_name emp_name,
       b.department_id, b.department_name dept_name
  FROM employees a,
       departments b
 WHERE a.department_id = b.department_id      
 ORDER BY 1; 
 
SELECT * -- 9f725pnmu4zcq
FROM V$SQL 
WHERE sql_text LIKE '%hong123%'
; 
 
 
select *
from table(dbms_xplan.display_cursor ( '9f725pnmu4zcq', null, 'ADVANCED ALLSTATS LAST'));
 
 
-- 로우를 컬럼으로 
CREATE TABLE score_table (
       YEARS     VARCHAR2(4),   -- 연도
       GUBUN     VARCHAR2(30),  -- 구분(중간/기말)
    SUBJECTS     VARCHAR2(30),  -- 과목
       SCORE     NUMBER );      -- 점수 
       
       
INSERT INTO score_table VALUES('2020','중간고사','국어',92);
INSERT INTO score_table VALUES('2020','중간고사','영어',87);
INSERT INTO score_table VALUES('2020','중간고사','수학',67);
INSERT INTO score_table VALUES('2020','중간고사','과학',80);
INSERT INTO score_table VALUES('2020','중간고사','지리',93);
INSERT INTO score_table VALUES('2020','중간고사','독일어',82);
INSERT INTO score_table VALUES('2020','기말고사','국어',88);
INSERT INTO score_table VALUES('2020','기말고사','영어',80);
INSERT INTO score_table VALUES('2020','기말고사','수학',93);
INSERT INTO score_table VALUES('2020','기말고사','과학',91);
INSERT INTO score_table VALUES('2020','기말고사','지리',89);
INSERT INTO score_table VALUES('2020','기말고사','독일어',83);
COMMIT;       


SELECT *
  FROM score_table;
  
  
SELECT years,
       gubun,
       CASE WHEN subjects = '국어'   THEN score ELSE 0 END "국어",
       CASE WHEN subjects = '영어'   THEN score ELSE 0 END "영어",
       CASE WHEN subjects = '수학'   THEN score ELSE 0 END "수학",
       CASE WHEN subjects = '과학'   THEN score ELSE 0 END "과학",
       CASE WHEN subjects = '지리'   THEN score ELSE 0 END "지리",
       CASE WHEN subjects = '독일어' THEN score ELSE 0 END "독일어"
 FROM score_table a;  
 
 
 
SELECT years, gubun,
       SUM(국어) AS 국어, SUM(영어) AS 영어, SUM(수학) AS 수학,
       SUM(과학) AS 과학, SUM(지리) AS 지리, SUM(독일어) AS 독일어
 FROM (
       SELECT years, gubun,       
              CASE WHEN subjects = '국어'   THEN score ELSE 0 END "국어",
              CASE WHEN subjects = '영어'   THEN score ELSE 0 END "영어",
              CASE WHEN subjects = '수학'   THEN score ELSE 0 END "수학",
              CASE WHEN subjects = '과학'   THEN score ELSE 0 END "과학",
              CASE WHEN subjects = '지리'   THEN score ELSE 0 END "지리",
              CASE WHEN subjects = '독일어' THEN score ELSE 0 END "독일어"
        FROM score_table a
     )
  GROUP BY years, gubun;
  
  
SELECT years, gubun,
       SUM(국어) AS 국어, SUM(영어) AS 영어, SUM(수학) AS 수학,
       SUM(과학) AS 과학, SUM(지리) AS 지리, SUM(독일어) AS 독일어
 FROM (
       SELECT years, gubun,       
              DECODE(subjects,'국어',score,0) "국어",
              DECODE(subjects,'영어',score,0) "영어",
              DECODE(subjects,'수학',score,0) "수학",
              DECODE(subjects,'과학',score,0) "과학",
              DECODE(subjects,'지리',score,0) "지리",
              DECODE(subjects,'독일어',score,0) "독일어"
        FROM score_table a
     )
  GROUP BY years, gubun;  
  
  
WITH mains AS ( SELECT years, gubun,
                       CASE WHEN subjects = '국어'   THEN score ELSE 0 END "국어",
                       CASE WHEN subjects = '영어'   THEN score ELSE 0 END "영어",
                       CASE WHEN subjects = '수학'   THEN score ELSE 0 END "수학",
                       CASE WHEN subjects = '과학'   THEN score ELSE 0 END "과학",
                       CASE WHEN subjects = '지리'   THEN score ELSE 0 END "지리",
                       CASE WHEN subjects = '독일어' THEN score ELSE 0 END "독일어"
                  FROM score_table a
               )
SELECT years, gubun,
       SUM(국어) AS 국어, SUM(영어) AS 영어, SUM(수학) AS 수학,
       SUM(과학) AS 과학, SUM(지리) AS 지리, SUM(독일어) AS 독일어
 FROM mains
GROUP BY years, gubun;  


SELECT *
  FROM ( SELECT years, gubun, subjects, score
          FROM score_table )
 PIVOT ( SUM(score)
          FOR subjects IN ( '국어', '영어', '수학', '과학', '지리', '독일어')
        );
        
-- 컬럼을 로우로 
CREATE TABLE score_col_table  (
    YEARS     VARCHAR2(4),   -- 연도
    GUBUN     VARCHAR2(30),  -- 구분(중간/기말)
    KOREAN    NUMBER,        -- 국어점수
    ENGLISH   NUMBER,        -- 영어점수
    MATH      NUMBER,        -- 수학점수
    SCIENCE   NUMBER,        -- 과학점수
    GEOLOGY   NUMBER,        -- 지리점수
    GERMAN    NUMBER         -- 독일어점수
    );        
    
    
INSERT INTO score_col_table
VALUES ('2020', '중간고사', 92, 87, 67, 80, 93, 82 );

INSERT INTO score_col_table
VALUES ('2020', '기말고사', 88, 80, 93, 91, 89, 83 );

COMMIT;

SELECT *
  FROM score_col_table;
    
    
SELECT YEARS, GUBUN, '국어' AS SUBJECT, KOREAN AS SCORE
  FROM score_col_table
 UNION ALL
SELECT YEARS, GUBUN, '영어' AS SUBJECT, ENGLISH AS SCORE
  FROM score_col_table
 UNION ALL
SELECT YEARS, GUBUN, '수학' AS SUBJECT, MATH AS SCORE
  FROM score_col_table
 UNION ALL
SELECT YEARS, GUBUN, '과학' AS SUBJECT, SCIENCE AS SCORE
  FROM score_col_table
 UNION ALL
SELECT YEARS, GUBUN, '지리' AS SUBJECT, GEOLOGY AS SCORE
  FROM score_col_table
 UNION ALL
SELECT YEARS, GUBUN, '독일어' AS SUBJECT, GERMAN AS SCORE
  FROM score_col_table
 ORDER BY 1, 2 DESC;    
 
 
 
SELECT *
  FROM score_col_table
UNPIVOT ( score
            FOR subjects IN ( KOREAN   AS '국어',
                              ENGLISH  AS '영어',
                              MATH     AS '수학',
                              SCIENCE  AS '과학',
                              GEOLOGY  AS '지리',
                              GERMAN   AS '독일어'
                            )
        ); 
        
        
CREATE OR REPLACE TYPE obj_subject AS OBJECT (
      YEARS     VARCHAR2(4),   -- 연도
      GUBUN     VARCHAR2(30),  -- 구분(중간/기말)
      SUBJECTS  VARCHAR2(30),  -- 과목
      SCORE     NUMBER         -- 점수
     );        
     
     
CREATE OR REPLACE TYPE subject_nt IS TABLE OF obj_subject;     



CREATE OR REPLACE FUNCTION fn_pipe_table_ex
  RETURN subject_nt
  PIPELINED
IS

  vp_cur  SYS_REFCURSOR;
  v_cur   score_col_table%ROWTYPE;

  -- 반환할 컬렉션 변수 선언 (컬렉션 타입이므로 초기화를 한다)
  vnt_return  subject_nt :=  subject_nt();
BEGIN
  -- SYS_REFCURSOR 변수로 ch14_score_col_table 테이블을 선택해 커서를 오픈
  OPEN vp_cur FOR SELECT * FROM score_col_table ;

  -- 루프를 돌며 입력 매개변수 vp_cur를 v_cur로 패치
  LOOP
    FETCH vp_cur INTO v_cur;
    EXIT WHEN vp_cur%NOTFOUND;

    -- 컬렉션 타입이므로 EXTEND 메소드를 사용해 한 로우씩 신규 삽입
    vnt_return.EXTEND();
    -- 컬렉션 요소인 OBJECT 타입에 대한 초기화
    vnt_return(vnt_return.LAST) := obj_subject(null, null, null, null);

    -- 컬렉션 변수에 커서 변수의 값 할당
    vnt_return(vnt_return.LAST).YEARS     := v_cur.YEARS;
    vnt_return(vnt_return.LAST).GUBUN     := v_cur.GUBUN;
    vnt_return(vnt_return.LAST).SUBJECTS  := '국어';
    vnt_return(vnt_return.LAST).SCORE     := v_cur.KOREAN;
    PIPE ROW ( vnt_return(vnt_return.LAST));                 -- 국어 반환

    vnt_return(vnt_return.LAST).SUBJECTS  := '영어';
    vnt_return(vnt_return.LAST).SCORE     := v_cur.ENGLISH;
    PIPE ROW ( vnt_return(vnt_return.LAST));                 -- 영어 반환

    vnt_return(vnt_return.LAST).SUBJECTS  := '수학';
    vnt_return(vnt_return.LAST).SCORE     := v_cur.MATH;
    PIPE ROW ( vnt_return(vnt_return.LAST));                 -- 수학 반환

    vnt_return(vnt_return.LAST).SUBJECTS  := '과학';
    vnt_return(vnt_return.LAST).SCORE     := v_cur.SCIENCE;
    PIPE ROW ( vnt_return(vnt_return.LAST));                 -- 과학 반환

    vnt_return(vnt_return.LAST).SUBJECTS  := '지리';
    vnt_return(vnt_return.LAST).SCORE     := v_cur.GEOLOGY;
    PIPE ROW ( vnt_return(vnt_return.LAST));                 -- 지리 반환

    vnt_return(vnt_return.LAST).SUBJECTS  := '독일어';
    vnt_return(vnt_return.LAST).SCORE     := v_cur.GERMAN;
    PIPE ROW ( vnt_return(vnt_return.LAST));                 -- 독일어 반환

  END LOOP;
  RETURN;
END;


SELECT *
  FROM TABLE ( fn_pipe_table_ex );
