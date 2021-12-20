-- 내부조인 

-- 1-0. 내부조인
SELECT  a.employee_id, 
        a.first_name, 
        a.department_id, 
        b.department_name
   FROM employees a, departments b
    WHERE a.department_id = b.department_id
    ORDER BY a.employee_id;
    
SELECT  a.employee_id, 
        a.first_name, a.last_name,
        a.department_id
   FROM employees a
    WHERE a.department_id IS NULL
    ORDER BY a.employee_id;    

-- 1-1. 내부조인
SELECT a.employee_id, a.first_name || ' ' || a.last_name emp_names, 
       a.job_id, b.job_id, b.job_title
  FROM employees a,
       jobs b
 WHERE a.job_id = b.job_id
 ORDER BY 1;
 
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
 

-- ANSI 조인 
-- 1.ANSI 내부조인
SELECT  a.employee_id    emp_id, 
        a.department_id  a_dept_id, 
        b.department_id   b_dept_id,
        b.department_name dept_name
   FROM employees a
  INNER JOIN departments b
     ON a.department_id = b.department_id 
  ORDER BY a.employee_id;

-- 2.ANSI 외부조인(LEFT)
SELECT a.employee_id    emp_id, 
       a.department_id  a_dept_id, 
       b.department_id b_dept_id,
       b.department_name dept_name
  FROM employees a
  LEFT OUTER JOIN departments b
    ON a.department_id = b.department_id 
 ORDER BY a.employee_id;

-- 3.ANSI 외부조인(RIGHT)
SELECT a.employee_id    emp_id, 
       a.department_id  a_dept_id, 
       b.department_id b_dept_id,
       b.department_name dept_name
  FROM employees a
 RIGHT OUTER JOIN departments b
    ON a.department_id = b.department_id 
 ORDER BY a.employee_id, b.department_id;

-- 4.오라클 외부조인 오류 문장 
SELECT a.employee_id    emp_id, 
       a.department_id  a_dept_id, 
       b.department_id b_dept_id,
       b.department_name dept_name
  FROM employees a, departments b
 WHERE a.department_id(+) = b.department_id(+)
 ORDER BY b.department_id;

-- 5. ANSI FULL OUTER 조인 
SELECT a.employee_id    emp_id, 
       a.department_id  a_dept_id, 
       b.department_id b_dept_id,
       b.department_name dept_name
  FROM employees a
  FULL OUTER JOIN departments b
    ON a.department_id = b.department_id 
 ORDER BY a.employee_id,
          b.department_id;

-- 6. ANSI 내부조인 
SELECT a.employee_id, 
       a.first_name || ' ' || a.last_name emp_names, 
       a.job_id, b.job_id, b.job_title
  FROM employees a
  INNER JOIN jobs b
    ON a.job_id = b.job_id
 ORDER BY 1;

-- 7. ANSI 내부조인 
SELECT a.employee_id, a.first_name || ' ' || a.last_name emp_names, 
       b.job_title
      ,c.department_id ,c.department_name
  FROM employees a
  INNER JOIN jobs b
    ON a.job_id        = b.job_id
  INNER JOIN departments c
    ON a.department_id = c.department_id
 ORDER BY 1; 

-- 8. ANSI 내부조인과 WHERE 조건 
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
 
 
-- ANSI 외부조인
-- 1.ANSI 외부조인과 내부조인 
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
 
 
-- 2. ANSI LEFT 조인 
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


-- 3. Cartesian product
SELECT a.region_name, b.department_id, b.department_name 
  FROM regions a
      ,departments b
  WHERE 1=1;

-- CROSS JOIN
SELECT a.region_name, b.department_id, b.department_name 
FROM REGIONS a 
CROSS JOIN DEPARTMENTS b
where 1=1;
 

-- 4. 셀프조인
SELECT a.employee_id
      ,a.first_name || ' ' || a.last_name emp_name
      ,a.manager_id
      ,b.first_name || ' ' || b.last_name manager_name
 FROM employees a
     ,employees b
WHERE a.manager_id = b.employee_id
ORDER BY 1;

-- 5. ANSI 셀프조인
SELECT a.employee_id
      ,a.first_name || ' ' || a.last_name emp_name
      ,a.manager_id
      ,b.first_name || ' ' || b.last_name manager_name
 FROM employees a
 INNER JOIN employees b
    ON a.manager_id = b.employee_id
ORDER BY 1;

-- 분석 함수
-- 1.부서별로 사원의 급여 순 순번
SELECT b.department_id, b.department_name,
       a.first_name || ' ' || a.last_name as emp_name,
       ROW_NUMBER() OVER (PARTITION BY b.department_id
                              ORDER BY a.salary ) dept_sal_seq,
       a.salary                              
  FROM employees a,
       departments b
 WHERE a.department_id = b.department_id
 ORDER BY 2, 4 ;
 
-- 2.부서별로 사원의 급여가 높은 순 순번
SELECT b.department_id, b.department_name,
       a.first_name || ' ' || a.last_name as emp_name,
       ROW_NUMBER() OVER (PARTITION BY b.department_id
                              ORDER BY a.salary desc ) dept_sal_seq,
       a.salary                              
  FROM employees a,
       departments b
 WHERE a.department_id = b.department_id
 ORDER BY 2, 4 ;
 
-- 3.전 사원의 급여가 높은 순으로 순번을 구하라
SELECT b.department_id, b.department_name,
       a.first_name || ' ' || a.last_name as emp_name,
       ROW_NUMBER() OVER ( ORDER BY a.salary desc ) dept_sal_seq,
       a.salary                              
  FROM employees a,
       departments b
 WHERE a.department_id = b.department_id
 ORDER BY 4 ; 
 
-- 4.부서별로 사원의 급여가 높은 순 순위
SELECT b.department_id, b.department_name,
       a.first_name || ' ' || a.last_name as emp_name,
       RANK() OVER (PARTITION BY b.department_id
                        ORDER BY a.salary desc ) dept_sal_seq,
       a.salary                              
  FROM employees a,
       departments b
 WHERE a.department_id = b.department_id
 ORDER BY 2, 4 ;
 
 
-- 5. 부서별로 사원의 급여가 높은 순 누적순위
SELECT b.department_id, b.department_name,
       a.first_name || ' ' || a.last_name as emp_name,
       DENSE_RANK() OVER (PARTITION BY b.department_id
                              ORDER BY a.salary desc ) dept_sal_seq,
       a.salary                              
  FROM employees a,
       departments b
 WHERE a.department_id = b.department_id
 ORDER BY 2, 4 ;
 
-- 6.부서별, 입사일자 순, 직후 사원의 급여
SELECT b.department_id, b.department_name,
       a.first_name || ' ' || a.last_name as emp_name,
       a.hire_date,
       a.salary ,
       LEAD(salary) OVER (PARTITION BY b.department_id
                              ORDER BY a.hire_date ) lead_salary
  FROM employees a,
       departments b
 WHERE a.department_id = b.department_id
 ORDER BY 2, 4 ;
 
 
-- 7.부서별, 입사일자 순, 직후 사원의 급여
SELECT b.department_id, b.department_name,
       a.first_name || ' ' || a.last_name as emp_name,
       a.hire_date,
       a.salary ,
       LEAD(salary, 1, 0) OVER (PARTITION BY b.department_id
                                    ORDER BY a.hire_date ) lead_salary
  FROM employees a,
       departments b
 WHERE a.department_id = b.department_id
 ORDER BY 2, 4 ; 
 
 
 -- 8.부서별, 입사일자 순, 2 로우 후 사원의 급여
SELECT b.department_id, b.department_name,
       a.first_name || ' ' || a.last_name as emp_name,
       a.hire_date,
       a.salary ,
       LEAD(salary, 2, 0) OVER (PARTITION BY b.department_id
                                    ORDER BY a.hire_date ) lead_salary
  FROM employees a,
       departments b
 WHERE a.department_id = b.department_id
 ORDER BY 2, 4 ; 
 
 
-- 9.부서별, 입사일자 순, 직전 사원의 급여
SELECT b.department_id, b.department_name,
       a.first_name || ' ' || a.last_name as emp_name,
       a.hire_date,
       a.salary ,
       LAG(salary, 1, 0) OVER (PARTITION BY b.department_id
                                    ORDER BY a.hire_date ) lag_salary
  FROM employees a,
       departments b
 WHERE a.department_id = b.department_id
 ORDER BY 2, 4 ;  
 
 
-- 10. LAG와 LEAD 함수 사용 
SELECT b.department_id, b.department_name,
       a.first_name || ' ' || a.last_name as emp_name,
       a.hire_date,
       LAG(salary, 1, 0) OVER (PARTITION BY b.department_id
                                    ORDER BY a.hire_date ) PrevSal,
       a.salary ,
       LEAD(salary, 1, 0) OVER (PARTITION BY b.department_id
                                    ORDER BY a.hire_date ) NextSal
  FROM employees a,
       departments b
 WHERE a.department_id = b.department_id
 ORDER BY 2, 4 ;   
 
 
-- 11.부서별 평균 급여와 사원 급여를 동시에 조회
SELECT b.department_id, b.department_name,
       a.first_name || ' ' || a.last_name as emp_name,
       a.salary , 
       ROUND(AVG(a.salary) OVER ( PARTITION BY b.department_id
                                  ORDER BY b.department_id),0) dept_avg_sal
  FROM employees a,
       departments b
 WHERE a.department_id = b.department_id
 ORDER BY 2, 3;


-- 12.사원의 급여와 부서별 누적 급여 조회
SELECT b.department_id, b.department_name,
       a.first_name || ' ' || a.last_name as emp_name,
       a.salary , 
       ROUND(SUM(a.salary) OVER (
                      PARTITION BY b.department_id
                      ORDER BY a.salary  ),0) dept_cum_sum
  FROM employees a,
       departments b
 WHERE a.department_id = b.department_id
 ORDER BY 2, 4;


-- 13. 부서별 사원 급여의 비율
SELECT b.department_id, b.department_name,
       a.first_name || ' ' || a.last_name as emp_name,
       a.salary , 
       ROUND(RATIO_TO_REPORT(a.salary) 
             OVER (PARTITION BY b.department_id ),2) rates
  FROM employees a,
       departments b
 WHERE a.department_id = b.department_id
 ORDER BY 2, 4 DESC;
