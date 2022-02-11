-- 5-1

-- 1. 사번, 사원명, 급여, 직급(job_id), 직급별 평균 급여 구하기 – 스칼라 서브쿼리 사용

SELECT a.employee_id,
  a.first_name || ' ' || a.last_name emp_name, 
  a.job_id,
  a.salary,
  ( SELECT ROUND(AVG(salary))
    FROM employees b
    WHERE a.job_id = b.job_id ) avg_salary
 FROM employees a
 ORDER BY a.employee_id;

-- 2. 사번, 사원명, 급여, 직급(job_id), 직급별 평균 급여 구하기 – 인라인 뷰 사용

SELECT a.employee_id,
  a.first_name || ' ' || a.last_name emp_name,
  a.job_id,
  a.salary,
  b.avg_salary
 FROM employees a,
  ( SELECT job_id,
      ROUND(AVG(salary)) avg_salary
    FROM employees
   GROUP BY job_id) b
  WHERE a.job_id = b.job_id
  ORDER BY a.employee_id;

-- 3. 다음 문장을 IN 대신 EXISTS 연산자를 사용해 같은 결과를 조회하도록 변경해 보세요.
SELECT employee_id, job_id, salary
  FROM employees
 WHERE (job_id, salary ) IN ( SELECT job_id, min_salary
                              FROM jobs);

SELECT employee_id, job_id, salary
  FROM employees a
 WHERE EXISTS ( SELECT 1
                  FROM jobs b
                WHERE a.job_id = b.job_id
                  AND a.salary = b.min_salary );
