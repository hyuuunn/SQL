-- 1. 분석함수 (Analytic Function)
--     · 로우별 그룹을 지정해서 값을 집계하는 함수
--     · GROUP BY 절과는 다름
--     · GROUP BY 절 사용 시, 집계 대상에 따라 로우 수가 줄어들지만, 분석함수는 그렇지 않음
--       -> 로우 수는 그대로, 집계 값 산출이 가능
--     · 분석함수에서 말하는 로우별 그룹 -> 윈도우(Window)절
--     · 분석 함수와 윈도우 절이 같이 사용됨
--     · 일반 집계 함수(SUM, MAX, MIN, AVG 등)를 분석 함수로 사용 가능
--     · 그 외에 ROW_NUMBER, RANK, DENSE_RANK, LAG, LEAD 함수가 있음
--     ·분석 함수 구문
--     분석 함수 OVER ( PARTITION BY col1, col2, ...
                      ORDER BY col1, col2...)
--     ·PARTITION BY : 분석 함수 집계 대상이 되는 로우 값의 범위, 그룹
--     ·PARTITION BY 절 생략 시, 전체 로우가 분석 함수 집계 대상이 됨
--     ·ORDER BY : 분석 함수 계산 시, 고려되는 로우 순서
 

-- 분석 함수 – row_number() : 일련번호
-- 1-1.부서별로 사원의 급여 순 순번
SELECT b.department_id, b.department_name,
       a.first_name || ' ' || a.last_name as emp_name,
       ROW_NUMBER() OVER (PARTITION BY b.department_id
                              ORDER BY a.salary ) dept_sal_seq,
       a.salary                              
  FROM employees a,
       departments b
 WHERE a.department_id = b.department_id
 ORDER BY 2, 4 ;
 
-- 1-2.부서별로 사원의 급여가 높은 순 순번
SELECT b.department_id, b.department_name,
       a.first_name || ' ' || a.last_name as emp_name,
       ROW_NUMBER() OVER (PARTITION BY b.department_id
                              ORDER BY a.salary desc ) dept_sal_seq,
       a.salary                              
  FROM employees a,
       departments b
 WHERE a.department_id = b.department_id
 ORDER BY 2, 4 ;
 
-- 1-3.전 사원의 급여가 높은 순으로 순번을 구하라
SELECT b.department_id, b.department_name,
       a.first_name || ' ' || a.last_name as emp_name,
       ROW_NUMBER() OVER ( ORDER BY a.salary desc ) dept_sal_seq,
       a.salary                              
  FROM employees a,
       departments b
 WHERE a.department_id = b.department_id
 ORDER BY 4 ; 
--> PARTITION BY 
 
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
