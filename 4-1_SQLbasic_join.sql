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

-- 1-0. 내부조인
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

-- 1-1. 내부조인
SELECT a.employee_id, a.first_name || ' ' || a.last_name emp_names, 
       a.job_id, b.job_id, b.job_title
  FROM employees a,
       jobs b
 WHERE a.job_id = b.job_id
 ORDER BY 1;
-- -> job_id 컬럼은 두 테이블 모두 존재, 어느 테이블의 job_id를 가져올 것인지 명시해야 함
 
-- 1-2.내부조인 
SELECT a.employee_id, a.first_name || ' ' || a.last_name emp_names, 
       job_id, b.job_title
  FROM employees a,
       jobs b
 WHERE a.job_id = b.job_id
 ORDER BY 1; 
 
-- 1-3.내부조인
SELECT a.employee_id, a.first_name || ' ' || a.last_name emp_names, 
       a.job_id, b.job_id, job_title
  FROM employees a,
       jobs b
 WHERE a.job_id = b.job_id
 ORDER BY 1;  
-- -> job_title은 jobs 테이블에만 존재, 별칭이 없어도 오류 없으나 붙여 주는 것이 좋다
-- job_title => b.job_title
 
-- 2.내부조인
SELECT a.employee_id, a.first_name || ' ' || a.last_name emp_names, 
       b.job_title,
       c.department_id ,c.department_name
  FROM employees a,
       jobs b,
       departments c
 WHERE a.job_id        = b.job_id
   AND a.department_id = c.department_id
 ORDER BY 1; 
 
-- 3.내부조인
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
 
-- 4.내부조인
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
 
-- 5.내부조인
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
 
-- 6. 내부 조인 
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
 

 
-- 외부조인
-- 1.외부조인
SELECT a.employee_id, 
       a.first_name || ' ' || a.last_name emp_names, 
       b.department_id, b.department_name
  FROM employees a,
       departments b
 WHERE a.department_id = b.department_id(+)
 ORDER BY 1; 
 
-- 2.외부조인
SELECT a.employee_id, 
       a.first_name || ' ' || a.last_name emp_names, 
       b.department_id, b.department_name
  FROM employees a,
       departments b
 WHERE a.department_id(+) = b.department_id
 ORDER BY 1; 
 
-- 3.외부조인
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
 
 
-- 4.외부조인
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
 
