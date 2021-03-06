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

--5. covid19 테이블을 사용해 2020년 한국의 월별 검사수, 확진자수, 확진율을 구하는 쿼리를 작성하시오.
SELECT TO_CHAR(dates, 'MM') months,
    NVL(SUM(new_tests),0) 검사수,
    NVL(SUM(new_cases),0) 확진자수,
    ROUND(NVL(SUM(new_cases),0) / NVL(SUM(new_tests),0) * 100,2) 확진율
  FROM covid19_test
 WHERE ISO_CODE = 'KOR'
  AND TO_CHAR(dates, 'YYYY') = '2020'
 GROUP BY TO_CHAR(dates, 'MM')
 ORDER BY 1;

--6-2
--1. Covid19_test 테이블에서 2020년 전체 가장 많은 확진자가 나온 상위 5개 국가를 구하는 쿼리를 작성하시오.
SELECT *
  FROM ( SELECT country,
          NVL(SUM(new_cases),0) cases
        FROM covid19_test
       WHERE to_char(dates, 'YYYY') = '2020'
        AND country <> 'World'
       GROUP BY country
      )
  ORDER BY cases DESC
  FETCH FIRST 5 ROWS ONLY;
  
-- 2. Covid19_test 테이블에서 2020년 인구대비 사망률이 가장 많은 상위 20개 국가를 구하는 쿼리를 작성하시오.
SELECT *
  FROM ( SELECT country,
          NVL(MAX(population),0) popu,
          NVL(SUM(new_deaths),0) death,
          DECODE(NVL(MAX(population),0),0,0,ROUND(NVL(SUM(new_deaths),0) / NVL(MAX(population),0) * 100,5)) rates
        FROM covid19_test
       WHERE 1=1
         AND TO_CHAR(dates, 'YYYY') = '2020'
       GROUP BY country
       )
  WHERE rates <> 0
  ORDER BY rates desc
  FETCH FIRST 20 ROWS ONLY;

-- 6-3
-- 1. Covid19_test 테이블에서 2020년 각 대륙별 확진자 수를 분기별로 다음과 같이 조회하는 쿼리를 작성하시오.

SELECT continent,
    SUM(CASE WHEN quarter = '1' THEN cases else 0 end) Q1,
    SUM(CASE WHEN quarter = '2' THEN cases else 0 end) Q2,
    SUM(CASE WHEN quarter = '3' THEN cases else 0 end) Q3,
    SUM(CASE WHEN quarter = '4' THEN cases else 0 end) Q4
  FROM ( SELECT TO_CHAR(dates, 'q') quarter,
        continent,
        NVL(SUM(new_cases),0) cases,
        NVL(SUM(new_deaths),0) death_num
    FROM covid19_test
  WHERE TO_CHAR(dates, 'YYYY') = '2020'
    AND continent IS NOT NULL
  GROUP BY TO_CHAR(dates, 'q'), continent
  )
  GROUP BY continent
  ORDER BY 1;
  
  -- 2. products 테이블에는 mode_year라는 연식 컬럼이 있습니다. 다음과 같이 주문년도별 모델연식별 판매금액을 구하는 쿼리를 PIVOT 절을 사용해 작성해 보세요. (orders, order_items, products 테이블 조인)

SELECT sale_year
    ,nvl(model_2016,0) as model_2016 
    ,nvl(model_2017,0) as model_2017 
    ,nvl(model_2018,0) as model_2018
  FROM ( SELECT TO_CHAR(a.order_date, 'YYYY') sale_year 
        ,c.model_year
        ,NVL(SUM(b.list_price * quantity),0) amt 
      FROM orders a
        ,order_items b
        ,products c 
      WHERE 1=1
        AND a.order_id = b.order_id
        AND b.product_id = c.product_id
      GROUP BY TO_CHAR(a.order_date, 'YYYY')
        ,c.model_year 
      ) PIVOT
      ( SUM(amt) for model_year in ('2016' AS model_2016,'2017' AS model_2017, '2018' AS model_2018) )
   ORDER BY 1;
