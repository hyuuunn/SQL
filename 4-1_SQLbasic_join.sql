-- 1. 조인 (Join)
--      ·RDBMS 특징 : 중복 데이터 저장 회피 목적으로 데이터 성격에 따라 테이블 분리
--       (예, 사원 테이블, 부서 테이블, ... )
--      · 한 테이블만 읽어서는 필요한 정보가 부족
--      · employees 테이블에는 부서번호(department_id) 컬럼만 있어 부서명을 알 수 없음
--      · 부서명을 가져오려면 departments 테이블과 연결 필요
--      · 이런 테이블 간 연결 작업을 조인(Join)이라 함
--      · 테이블 간 연결(조인)을 위해서는 연결고리 역할을 하는 컬럼이 필요
--      · 조인에 참여하는 테이블 간 같은 값을 가진 컬럼조인 컬럼
--       (예, employees와 departments 테이블 조인 컬럼 : department_id )
--      · 각 테이블의 조인 컬럼 명이 같을 필요는 없으나 동일하게 만드는 것이 좋음
--      · 조인 컬럼은 한 개 이상으로 구성될 수 있고, 뷰(View)도 조인 가능
--      · 조인 방식에 따라 크게 내부조인, 외부조인 으로 구분

-- 2. 내부 조인 (Inner Join)
--      ·가장 기본적인 조인 방식
--      ·조인 참여 테이블 간 조인 컬럼 값이 같은 건을 가져옴
--      ·WHERE 절에서 각 테이블의 조인 컬럼과 연산자를 사용해 조건 명시 -> 조인 조건
--      ·일반적으로 조인 조건에 동등 연산자(=) 사용 -> 조인 컬럼 값이 같은 건이 조회됨
--       (예, where a.seq_id = b.seq_id)
--      ·조인 조건을 만족한 데이터만 조회됨

-- 내부조인 

-- 2-0. 내부조인
SELECT  a.employee_id, 
        a.first_name, 
        a.department_id, 
        b.department_name
   FROM employees a,
        departments b
    WHERE a.department_id = b.department_id
    ORDER BY a.employee_id;
--  ·FROM 절에 조인에 참여할 테이블 명시 (콤마로 구분)
--  ·각 테이블에 Alias를 주는 것이 좋음
--  ·모든 컬럼은 테이블명.컬럼명 혹은 테이블, alias명.컬럼명 형태로 사용
--  ·WHERE 절에서는 조인 조건과 일반 조건 함께 사용
--  ·조인 조건을 만족하는 데이터만 조회됨
-- ※ 178번 사원이 빠져 있음

SELECT  a.employee_id, 
        a.first_name, a.last_name,
        a.department_id
   FROM employees a
    WHERE a.department_id IS NULL
    ORDER BY a.employee_id;    
-- -> 사번이 178번인 Kimberely Grant는 department_id 값이 NULL 이어서 조회가 되지 않음 
-- -> WHERE a.department_id = b.department_id 조건 불만족

-- 2-1. 내부조인
SELECT a.employee_id, a.first_name || ' ' || a.last_name emp_names, 
       a.job_id, b.job_id, b.job_title
  FROM employees a,
       jobs b
 WHERE a.job_id = b.job_id
 ORDER BY 1;
-- -> job_id 컬럼은 두 테이블 모두 존재, 어느 테이블의 job_id를 가져올 것인지 명시해야 함
 
-- 2-2.내부조인 
SELECT a.employee_id, a.first_name || ' ' || a.last_name emp_names, 
       job_id, b.job_title
  FROM employees a,
       jobs b
 WHERE a.job_id = b.job_id
 ORDER BY 1; 
 
-- 2-3.내부조인
SELECT a.employee_id, a.first_name || ' ' || a.last_name emp_names, 
       a.job_id, b.job_id, job_title
  FROM employees a,
       jobs b
 WHERE a.job_id = b.job_id
 ORDER BY 1;  
-- -> job_title은 jobs 테이블에만 존재, 별칭이 없어도 오류 없으나 붙여 주는 것이 좋다
-- job_title => b.job_title
 
-- 2-4.내부조인
SELECT a.employee_id, a.first_name || ' ' || a.last_name emp_names, 
       b.job_title,
       c.department_id ,c.department_name
  FROM employees a,
       jobs b,
       departments c
 WHERE a.job_id        = b.job_id
   AND a.department_id = c.department_id
 ORDER BY 1; 
 
-- 2-5.내부조인
SELECT a.employee_id, 
       a.first_name || ' ' || a.last_name emp_names, 
       b.job_title, c.department_name,
       d.location_id, d.street_address, d.city, d.state_province
  FROM employees a,
       jobs b,
       departments c,
       locations d
 WHERE a.job_id        = b.job_id
   AND a.department_id = c.department_id
   AND c.location_id   = d.location_id 
 ORDER BY 1;  
 
-- 2-6.내부조인
SELECT a.employee_id 
      ,a.first_name || ' ' || a.last_name emp_names
      ,b.job_title ,c.department_name
      ,d.street_address, d.city
      ,e.country_name
  FROM employees a,
       jobs b,
       departments c,
       locations d,
       countries e
 WHERE a.job_id        = b.job_id
   AND a.department_id = c.department_id
   AND c.location_id   = d.location_id 
   AND d.country_id    = e.country_id
 ORDER BY 1;   
 
-- 2-7.내부조인
SELECT a.employee_id 
      ,a.first_name || ' ' || a.last_name emp_names
      ,b.job_title ,c.department_name
      ,d.street_address, d.city
      ,e.country_name ,f.region_name
  FROM employees a,
       jobs b,
       departments c,
       locations d,
       countries e,
       regions f
 WHERE a.job_id        = b.job_id
   AND a.department_id = c.department_id
   AND c.location_id   = d.location_id 
   AND d.country_id    = e.country_id
   AND e.region_id     = f.region_id
 ORDER BY 1;    
 
-- 2-8. 내부 조인 
SELECT a.employee_id
       , a.first_name || ' ' || a.last_name emp_names
       , b.job_title
       , c.department_id ,c.department_name
 FROM employees a,
      jobs b,
      departments c
WHERE a.job_id = b.job_id
 AND a.department_id = c.department_id
 AND c.department_id = 30
ORDER BY 1;
 
-- 3. 외부 조인 (Outer Join)
--      · 조인 조건을 만족하는 것은 물론 만족하지 않는 데이터(로우) 까지 포함해 조회
--      · A, B 두 테이블 기준, 조인조건에 부합하지 않는 상대방 테이블 데이터도 조회됨
--         -> 조인 조건에 (+)를 붙여야 함
--      · 조인조건을 만족하지 않는 a 테이블의 데이터까지 가져옴
--         -> WHERE a.department_id = b.department_id (+)
--      · 조인조건을 만족하지 않는 b 테이블의 데이터까지 가져옴
--         -> WHERE a.department_id(+) = b.department_id
--      · 외부조인 시 조인조건에 (+)를 붙이는 것은 오라클 전용 문법임
--      · 다른 DBMS에서는 (+) 기호 붙이면 오류 발생
 
-- 외부조인
-- 3-0
SELECT a.employee_id emp_id,
       a.department_id a_dept_id,
       b.department_id b_dept_id,
       b.department_name dept_name
 FROM employees a, departments b
WHERE a.department_id = b.department_id (+)
ORDER BY a.department_id;
--> Employees 테이블에서 사번이 178번인 사원의 부서번호는 Null

SELECT a.employee_id emp_id,
       a.department_id a_dept_id,
       b.department_id b_dept_id,
       b.department_name dept_name
 FROM employees a, departments b
WHERE a.department_id(+) = b.department_id
ORDER BY a.department_id;
--> 부서번호가 120번 이상인 부서는 employees 테이블의 department_id에 할당된 건이 없음

-- · (+) 기호를 사용하는 오라클 외부 조인 제약사항
--      - 조인 컬럼이 여러 개일 경우, 조인조건에서 (+) 기호를 모두 붙여야 제대로 조회됨
           예) .....
               where a.col1 = b.col1(+)
                and a.col2 = b.col2(+)
               ...
--      - 조인 조건 양쪽에 (+) 기호 붙일 수 없음

-- 3-1.외부조인
SELECT a.employee_id, 
       a.first_name || ' ' || a.last_name emp_names, 
       b.department_id, b.department_name
  FROM employees a,
       departments b
 WHERE a.department_id = b.department_id(+)
 ORDER BY 1; 
 
-- 3-2.외부조인
SELECT a.employee_id, 
       a.first_name || ' ' || a.last_name emp_names, 
       b.department_id, b.department_name
  FROM employees a,
       departments b
 WHERE a.department_id(+) = b.department_id
 ORDER BY 1; 
 
-- 3-3.외부조인
SELECT a.employee_id, 
       a.first_name || ' ' || a.last_name emp_names, 
       c.department_id, c.department_name,
       d.location_id, d.street_address, d.city
  FROM employees a,
       departments c,
       locations d
 WHERE a.department_id = c.department_id(+)
   AND c.location_id   = d.location_id
 ORDER BY 1;
--> a.department_id = c.department_id(+)
-- ※ 외부조인을 했으므로 178번인 Kimberely Grant가 조회되어야 하지만,
-- 외부조인한 결과 178번의 department_id는 null.
-- 결국 locations 테이블과 내부조인을 했기 때문에 조회되지 않음
 
 
-- 3-4.외부조인
SELECT a.employee_id, 
       a.first_name || ' ' || a.last_name emp_names, 
       c.department_id, c.department_name,
       d.location_id, d.street_address, d.city
  FROM employees a,
       departments c,
       locations d
 WHERE a.department_id = c.department_id(+)
   AND c.location_id   = d.location_id(+)
 ORDER BY 1;
--> a.department_id = c.department_id(+)
--> c.location_id   = d.location_id(+)
-- ※ 178번의 department_id는 null, departments 테이블도 null 이지만
-- locations와 외부조인을 했기 때문에 Kimberely Grant가 조회됨
 
-- ※ 외부 조인은 왜 사용할까?
--      ·테이블 설계가 제대로 되어 있고, 데이터가 정확히 입력되어 있다면 굳이 외부 조인을 사용할 필요가 없음
--      ·하지만 현실은 그렇지 않음
--              - 테이블 설계를 완벽히 할 수 없음
--              - 애초에 제대로 설계했더라도 업무가 변경되면 로직 수정이 필요
--              - 설계가 제대로 되어 있더라도, 데이터 입력 시 오류로 인해 잘못된 데이터 입력, 누락 데이터 발생
--                예) 178번 Kimberely Grant는 부서번호가 없음
--                   부서가 없는 사원이 존재할까?
--                   설사 부서 발령이 안되더라도 미발령부서 정보를 부서테이블에 등록하는 것이 정상적
