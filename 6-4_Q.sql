-- 7-2

-- 1. 부서 테이블에서 부서명이 IT 부서 정보를 이용해 새로운 부서를 입력해 보세요. 새로운 부서의 부서번호는 500, 부서명이 IT2이고 manager_id와 location_id 값은 IT 부서와 동일합니다.

INSERT INTO departments
SELECT 500, 'IT2', manager_id, location_id
 FROM departments
 WHERE department_name = 'IT';
     
-- 2. 부서테이블에서 deparment_id 값이 280이상인 건 중 manager_id 값이 null인 건은 100, 아닌 건은 110으로 변경하는 문장을 작성해 보세요.

UPDATE departments
SET manager_id = CASE WHEN manager_id IS NULL THEN 100
                      ELSE 110 
                 END
WHERE department_id >= 280;
