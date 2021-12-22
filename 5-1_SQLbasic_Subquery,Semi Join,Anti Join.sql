-- 스칼라 서브쿼리 

-- 1
SELECT a.employee_id,
       a.first_name || ' ' || a.last_name emp_name,
       a.department_id, 
       ( SELECT b.department_name
           FROM departments b
          WHERE a.department_id = b.department_id ) dept_name
  FROM employees a
 ORDER BY 1;
 
-- 2
SELECT a.employee_id,
       a.first_name || ' ' || a.last_name emp_name,
       a.department_id, 
       ( SELECT b.department_name
           FROM departments b
       ) dept_name
  FROM employees a
 ORDER BY 1;
 

-- 3
SELECT a.employee_id,
       a.first_name || ' ' || a.last_name emp_name,
       a.department_id, 
       ( SELECT b.department_name, b.location_id
           FROM departments b
          WHERE a.department_id = b.department_id ) dept_name
  FROM employees a
 ORDER BY 1; 
 
-- 4
SELECT a.employee_id, 
       a.first_name || ' ' || a.last_name emp_names, a.job_id
      ,( SELECT b.job_title || '(' || b.job_id || ')'
           FROM jobs b
          WHERE a.job_id = b.job_id ) job_names
FROM employees a
ORDER BY 1;

-- 5-1
SELECT a.employee_id,
       a.first_name || ' ' || a.last_name emp_name,
       a.department_id, 
       b.department_name
  FROM employees a,
       departments b
 WHERE a.department_id = b.department_id   
 ORDER BY 1;

-- 5-2
SELECT a.employee_id,
       a.first_name || ' ' || a.last_name emp_name,
       a.department_id, 
       ( SELECT b.department_name
           FROM departments b
          WHERE a.department_id = b.department_id ) dept_name
  FROM employees a
 ORDER BY 1;
 
-- 6
SELECT a.employee_id,
       a.first_name || ' ' || a.last_name emp_name,
       a.department_id, 
       ( SELECT b.department_name
           FROM departments b
          WHERE a.department_id = b.department_id 
       ) dept_name,
       ( SELECT d.country_name
           FROM departments b
               ,locations c
               ,countries d
          WHERE a.department_id = b.department_id 
            AND b.location_id = c.location_id
            AND c.country_id = d.country_id
        ) country_name
             
  FROM employees a
 ORDER BY 1;

 
-- 인라인 뷰
-- 1
SELECT a.employee_id,
       a.first_name || a.last_name emp_name,
       a.department_id, 
       c.dept_name
FROM employees a,
    ( SELECT b.department_id, 
             b.department_name  dept_name
        FROM departments b 
    ) c
WHERE a.department_id = c.department_id
ORDER BY 1;
 
-- 2 
SELECT a.employee_id,
       a.first_name || a.last_name emp_name,
       a.department_id, 
       c.dept_name
FROM employees a,
    ( SELECT b.department_id, 
             b.department_name  dept_name
        FROM departments b
       WHERE a.department_id = b.department_id
    ) c
ORDER BY 1; 
  
-- 3 
SELECT a.employee_id,
       a.first_name || a.last_name emp_name,
       a.department_id, 
       c.dept_name
FROM employees a,
     LATERAL ( SELECT b.department_id, 
                      b.department_name  dept_name
                FROM departments b
               WHERE a.department_id = b.department_id
             ) c
  ORDER BY 1;   

-- 4
SELECT a.employee_id,
       a.first_name || ' ' || a.last_name emp_name,
       dept.department_name,
       loc.street_address, loc.city, loc.country_name
FROM employees a
   ,( SELECT *
        FROM departments b ) dept
   ,( SELECT l.location_id, l.street_address, 
             l.city, c.country_name
        FROM locations l,
             countries c
       WHERE l.country_id = c.country_id 
     ) loc
 WHERE a.department_id = dept.department_id
   AND dept.location_id = loc.location_id
 ORDER BY 1;   
             
             
-- 5
SELECT a.employee_id,
       a.first_name || ' ' || a.last_name emp_name,
       dept_loc.department_name,
       dept_loc.street_address, dept_loc.city, 
       reg.country_name, reg.region_name
FROM employees a
   ,( SELECT b.department_id, b.department_name,
             l.street_address, l.city, l.country_id
        FROM departments b,
             locations l
       WHERE b.location_id = l.location_id
     ) dept_loc
   ,( SELECT c.country_id, c.country_name,
             r.region_name
        FROM countries c,
             regions r
       WHERE c.region_id = r.region_id 
         AND c.country_id = dept_loc.country_id
     ) reg
 WHERE a.department_id = dept_loc.department_id
 ORDER BY 1;
 
 
-- 6
SELECT a.employee_id,
       a.first_name || ' ' || a.last_name emp_name,
       dept_loc.department_name,
       dept_loc.street_address, dept_loc.city, 
       reg.country_name, reg.region_name
FROM employees a
   ,( SELECT b.department_id, b.department_name,
             l.street_address, l.city, l.country_id
        FROM departments b,
             locations l
       WHERE b.location_id = l.location_id
     ) dept_loc
   ,LATERAL ( SELECT c.country_id, c.country_name,
             r.region_name
        FROM countries c,
             regions r
       WHERE c.region_id = r.region_id 
         AND c.country_id = dept_loc.country_id
     ) reg
 WHERE a.department_id = dept_loc.department_id
 ORDER BY 1; 
          
-- 7
SELECT a.department_id, a.last_name, a.salary,
       k.department_id second_dept_id,
       k.avg_salary 
  FROM employees a,
      ( SELECT b.department_id, AVG(b.salary) avg_salary
          FROM employees b
         GROUP BY b.department_id
      ) k
 WHERE a.department_id = k.department_id     
ORDER BY a.department_id;       
          
-- 중첩 서브쿼리
-- 1
SELECT *
  FROM departments 
 WHERE department_id IN ( SELECT department_id
                            FROM employees
                        ) ;

-- 2
SELECT *
  FROM departments a
 WHERE EXISTS ( SELECT  1
                  FROM employees b
                 WHERE a.department_id = b.department_id 
              ) ;

-- 3
SELECT *
  FROM departments a
 WHERE EXISTS ( SELECT 'A'
                  FROM employees b
                 WHERE a.department_id = b.department_id
                   AND b.salary > 10000 );

-- 4                   
SELECT employee_id,
       first_name || ' ' || last_name emp_name,
       job_id, 
       salary
  FROM employees 
 WHERE (job_id, salary ) IN ( SELECT job_id, min_salary
                                FROM jobs)
ORDER BY 1;                            

-- 5
SELECT last_name, employee_id
      ,salary + NVL(commission_pct, 0) tot_salary
      ,job_id, e.department_id
  FROM employees e
      ,departments d
WHERE e.department_id = d.department_id
  AND salary + NVL(commission_pct,0) > ( SELECT salary + NVL(commission_pct,0)
                                           FROM employees
                                          WHERE last_name = 'Pataballa')
ORDER BY last_name, employee_id;

-- 6
SELECT department_id, employee_id, last_name, salary
  FROM employees a
 WHERE salary > (SELECT AVG(salary)
                   FROM employees b
                  WHERE a.department_id = b.department_id)
ORDER BY department_id;



SELECT department_id, employee_id, last_name, salary
  FROM employees a
ORDER BY department_id;

SELECT department_id, AVG(salary)
  FROM employees b
 GROUP BY department_id
 ORDER BY 1;



------------------------------------------------------------

-- 세미조인
-- 2. Exists 연산자 사용                            
SELECT *
  FROM employees a
 WHERE EXISTS ( SELECT 0
                 FROM job_history  b
                WHERE a.employee_id = b.employee_id)
 ORDER BY 1;                                           

-- 안티조인
SELECT a.employee_id, 
       a.first_name || ' ' || a.last_name
  FROM employees a
 WHERE a.employee_id NOT IN ( SELECT employee_id
                                FROM job_history )
 ORDER BY 1;

SELECT a.employee_id, 
       a.first_name || ' ' || a.last_name
  FROM employees a
 WHERE NOT EXISTS ( SELECT 0
                      FROM job_history  b
                     WHERE a.employee_id = b.employee_id)
 ORDER BY 1; 
