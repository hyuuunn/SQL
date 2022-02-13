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

-- 4. covid19 테이블을 사용해 월별, 대륙별, 국가별 감염수와 각 국가가 속한 대륙을 기준으로 감염수 비율을 구하는 쿼리를 작성하시오.

SELECT a.months, a.continent, a.country, a.new_cases, b.continent_cases
       ,DECODE(b.continent_cases, 0, 0, ROUND(a.new_cases / b.continent_cases * 100,2)) rates
      FROM ( SELECT country, continent
            ,TO_CHAR(dates, 'yyyy-mm') months
            ,SUM(new_cases) new_cases
          FROM COVID19_TEST
        GROUP BY TO_CHAR(dates, 'yyyy-mm'), country, continent )a
          ,( SELECT continent
               ,TO_CHAR(dates, 'yyyy-mm') months
               ,SUM(new_cases) continent_cases
             FROM COVID19_TEST
            GROUP BY TO_CHAR(dates, 'yyyy-mm'), continent
           )b
 WHERE a.months = b.months
  AND a.continent = b.continent
  AND a.new_cases > 0
 ORDER BY 1, 2, 4 DESC ;
