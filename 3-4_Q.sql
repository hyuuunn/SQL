-- 3-1

-- Q1. locations 테이블에는 전 세계에 있는 지역 사무소 주소 정보가 나와 있습니다. 각 국가별로 지역사무소가 몇 개나 되는지 찾는 쿼리를 작성해 보세요.

SELECT country_id, COUNT(*)
  FROM locations
 GROUP BY country_id
 ORDER BY country_id;
 
-- Q-2. employees 테이블에서 년도에 상관 없이 분기별로 몇 명의 사원이 입사했는지 구하는 쿼리를 작성해 보세요.

SELECT TO_CHAR(hire_date, 'Q'), COUNT(*)
  FROM employees
 GROUP BY TO_CHAR(hire_date, 'Q')
 ORDER BY 1;
