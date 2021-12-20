-- 1. ANSI 조인 (ANSI Join) ·ANSI 표준 문법으로 작성한 조인 방법
--      · 내부조인, 외부조인을 ANSI 문법에 맞게 작성한 쿼리
--      · 내부조인 : INNER JOIN
--      · 외부조인 : LEFT OUTER JOIN, RIGHT OUTER JOIN, FULL OUTER JOIN · FULL OUTER JOIN은 ANSI 문법으로만 구현 가능
--      · ANSI 문법은 다른 DBMS에서도 사용 가능 -> (+) 기호는 오라클에서만 사용
--      · ANSI 조인 문법의 특징
--              - 조인 조건 절을 WHERE 절이 아닌 FROM 절에 기술
--              - 조인 조건은 ON 다음에 기술
--              - 조인 조건이 여러 개이면 AND 연산자 사용해 조건 기술
--              - 조인 조건 외에 다른 조건은 WHERE 절에서 기술

-- ANSI 조인 
-- 1-1.ANSI 내부조인
SELECT  a.employee_id    emp_id, 
        a.department_id  a_dept_id, 
        b.department_id   b_dept_id,
        b.department_name dept_name
   FROM employees a
  INNER JOIN departments b
     ON a.department_id = b.department_id 
  ORDER BY a.employee_id;
--> * INNER 생략 가능
-- (기존 문법)
SELECT  a.employee_id    emp_id, 
        a.department_id  a_dept_id, 
        b.department_id   b_dept_id,
        b.department_name dept_name
   FROM employees a, departments b
 WHERE a.department_id = b.department_id
 ORDER BY a.department_id;

-- 1-2.ANSI 외부조인(LEFT) – Left outer join
SELECT a.employee_id    emp_id, 
       a.department_id  a_dept_id, 
       b.department_id b_dept_id,
       b.department_name dept_name
  FROM employees a
  LEFT OUTER JOIN departments b
    ON a.department_id = b.department_id 
 ORDER BY a.employee_id;
--> * OUTER 생략 가능
-- (기존문법)
SELECT a.employee_id    emp_id, 
       a.department_id  a_dept_id, 
       b.department_id b_dept_id,
       b.department_name dept_name
  FROM employees a, departments b
 WHERE a.department_id = b.department_id(+)
 ORDER BY a.employee_id;

-- 1-3.ANSI 외부조인(RIGHT) – Right outer join
SELECT a.employee_id    emp_id, 
       a.department_id  a_dept_id, 
       b.department_id b_dept_id,
       b.department_name dept_name
  FROM employees a
 RIGHT OUTER JOIN departments b
    ON a.department_id = b.department_id 
 ORDER BY a.employee_id, b.department_id;
--> * OUTER 생략 가능
-- (기존문법)
SELECT a.employee_id    emp_id, 
       a.department_id  a_dept_id, 
       b.department_id b_dept_id,
       b.department_name dept_name
  FROM employees a, departments b
 WHERE a.department_id(+) = b.department_id
 ORDER BY a.employee_id;
 

-- 1-4.오라클 외부조인 오류 문장 - ANSI FULL OUTER 조인
-- (기존문법)
SELECT a.employee_id    emp_id, 
       a.department_id  a_dept_id, 
       b.department_id b_dept_id,
       b.department_name dept_name
  FROM employees a, departments b
 WHERE a.department_id(+) = b.department_id(+)
 ORDER BY b.department_id;
-- (ANSI 문법) 
SELECT a.employee_id    emp_id, 
       a.department_id  a_dept_id, 
       b.department_id b_dept_id,
       b.department_name dept_name
  FROM employees a
  FULL OUTER JOIN departments b
    ON a.department_id = b.department_id 
 ORDER BY a.employee_id,
          b.department_id;

------------


-- 1-5. ANSI 내부조인 
SELECT a.employee_id, 
       a.first_name || ' ' || a.last_name emp_names, 
       a.job_id, b.job_id, b.job_title
  FROM employees a
  INNER JOIN jobs b
    ON a.job_id = b.job_id
 ORDER BY 1;

-- 1-6. ANSI 내부조인 
SELECT a.employee_id, a.first_name || ' ' || a.last_name emp_names, 
       b.job_title
      ,c.department_id ,c.department_name
  FROM employees a
  INNER JOIN jobs b
    ON a.job_id        = b.job_id
  INNER JOIN departments c
    ON a.department_id = c.department_id
 ORDER BY 1; 

-- 1-7. ANSI 내부조인과 WHERE 조건 
SELECT a.employee_id, 
       a.first_name || ' ' || a.last_name emp_names, 
       a.job_id, b.job_id, b.job_title
      ,c.department_id ,c.department_name
  FROM employees a
  INNER JOIN jobs b
    ON a.job_id        = b.job_id
  INNER JOIN departments c
    ON a.department_id = c.department_id
 WHERE b.job_id = 'SH_CLERK'   
 ORDER BY 1;  
--> * ANSI 외부조인 시 조인조건 외 추가 조건은 WHERE 절에 기술
 
-- 1-8.ANSI 외부조인과 내부조인 
SELECT a.employee_id, 
       a.first_name || ' ' || a.last_name emp_names, 
       c.department_id, c.department_name,
       d.location_id, d.street_address, d.city
  FROM employees a
  LEFT JOIN departments c
    ON a.department_id = c.department_id
 INNER JOIN locations d
    ON c.location_id   = d.location_id
 ORDER BY 1;
 --> * LEFT JOIN을 해서 178번 사원이 나와야 하지만,
 -->   departments와 locations을 내부 조인 했으므로 178번 사원이 조회되지 않음
 
 
-- 1-9. ANSI LEFT 조인 
SELECT a.employee_id, 
       a.first_name || ' ' || a.last_name emp_names, 
       c.department_id, c.department_name,
       d.location_id, d.street_address, d.city
  FROM employees a
  LEFT JOIN departments c
    ON a.department_id = c.department_id
  LEFT JOIN locations d
    ON c.location_id   = d.location_id
 ORDER BY 1;
 --> * departments와 locations 간에 외부 조인을 했으므로 178번 사원이 조회됨

-- 2. 일반 조인과 ANSI 조인 문법
--      · 일반 조인을 사용해야 할까? 아니면 ANSI 조인을 써야 할까?
--      ·내부 조인
--              - 일반 조인 문법 ( WHERE 절에 조인 조건 기술)
--              - 가독성 측면에서 좋음
--      ·외부 조인
--              - ANSI 문법 사용
--              - (+)는 오라클 고유의 문법다른 DBMS에서 사용 불가
--              - ANSI 외부조인 문법이 가독성이 더 좋음
--              - FULL OUTER JOIN은 ANSI 문법만 가능

-- 3. Cartesian Product
--      ·조인 조건이 없는 조인
--      ·조인 참여 테이블을 FROM 절에 기술하고 WHERE 절에 조인 조건 기술하지 않음
--      · 조인 조건이 없으므로, 두 테이블 기준 모든 조합(경우의 수)의 로우가 조회됨
--              - A 테이블(3건), B 테이블(5건) -> 3 * 5 = 15건이 조회됨
--      ·거의 사용되지 않음
--      ·ANSI 문법 -> CROSS JOIN
--      ·조인이라고는 하지만 엄밀히 말하면 조인은 아님 -> 조인조건이 없으므로...
--      ·실제 사용되는 경우는 거의 없음
--      ·만약 이런 조인 결과를 보게 되면 -> 아, 조인 조건이 누락됐구나!

-- 3. Cartesian product
SELECT a.region_name, b.department_id, b.department_name 
  FROM regions a
      ,departments b
  WHERE 1=1;
--> -- 4 * 24 = 104

-- CROSS JOIN
SELECT a.region_name, b.department_id, b.department_name 
FROM REGIONS a 
CROSS JOIN DEPARTMENTS b
where 1=1;
 
-- 4. 셀프 조인 (Self Join)
--      ·자기 자신과 조인
--      ·동일한 테이블 끼리 조인
-- 4. 셀프조인
SELECT a.employee_id
      ,a.first_name || ' ' || a.last_name emp_name
      ,a.manager_id
      ,b.first_name || ' ' || b.last_name manager_name
 FROM employees a
     ,employees b
WHERE a.manager_id = b.employee_id
ORDER BY 1;
--> * manager_id에 해당하는 사원명을 가져오기 위해 셀프 조인을 했음

-- 5. ANSI 셀프조인
SELECT a.employee_id
      ,a.first_name || ' ' || a.last_name emp_name
      ,a.manager_id
      ,b.first_name || ' ' || b.last_name manager_name
 FROM employees a
 INNER JOIN employees b
    ON a.manager_id = b.employee_id
ORDER BY 1;
