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
   
-- 3. departments 테이블에서 department_id 값이 280번 이상인 건을 삭제하는 문장을 작성해 보세요.

DELETE departments
 WHERE department_id >= 280;
    
-- 4. covid19_test 테이블에서 한국의 2020년 5월부터 10월까지 데이터를 covid19_kor 이라는 테이블을 생성해 데이터까지 입력해 보세요.

CREATE TABLE covid19_kor AS
SELECT *
  FROM covid19_test
 WHERE iso_code = 'KOR'
  AND dates BETWEEN TO_DATE('20200501','YYYYMMDD')
    AND TO_DATE('20201031','YYYYMMDD');

-- 7-3
-- 1. 특정 테이블에 데이터를 INSERT 한 다음, 다시 특정 조건에 따라 어느 컬럼 값을 UPDATE 해야 하는데, 올바른 트랜잭션 처리를 하려면 INSERT 문 실행 후 COMMIT 을 실행하고 다시 UPDATE 문을 실행하고 COMMIT 문을 실행해야 합니다.

-- 아니오
-- 트랜잭션 처리는 논리적인 하나의 거래 단위로 수행하는 것이 맞습니다. INSERT  UPDATE 작업이 논리적인 한 개의 작업에 속한다면 INSERT->UPDATE->COMMIT 순으로 실행하는 것이 맞습니다. 즉, COMMIT은 한 번만 수행합니다.
-- 만약 INSERT는 성공했는데 UPDATE가 실패할 경우에는 ROLLBACK 문을 실행해 INSERT 작업 이전 상태로 돌아가는 것이 맞습니다.

-- 2. 복잡하게 만들어진 쿼리를 수행하는 것보다 이 쿼리를 기준으로 뷰를 만들고 이 뷰를 조회하는 것이 조회 성능 상 더 유리합니다. 이 말이 맞을까요?

-- 아니오
-- 복잡한 쿼리를 뷰로 만든다고 해서 해당 쿼리의 성능이 향상되는 것은 아닙니다. 단지 뷰는 복잡한 쿼리를 숨기고 재사용 하기 쉽게 할 목적으로 만든 데이터베이스 객체일 뿐입니다.
