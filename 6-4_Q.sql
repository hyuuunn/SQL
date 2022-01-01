-- 7-2

-- 1. 부서 테이블에서 부서명이 IT 부서 정보를 이용해 새로운 부서를 입력해 보세요. 새로운 부서의 부서번호는 500, 부서명이 IT2이고 manager_id와 location_id 값은 IT 부서와 동일합니다.

INSERT INTO departments
SELECT 500, 'IT2', manager_id, location_id
 FROM departments
 WHERE department_name = 'IT';
     
