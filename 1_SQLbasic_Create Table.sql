-- 테이블 생성
CREATE TABLE  EMP (
       emp_no      VARCHAR2(30)  NOT NULL,
       emp_name    VARCHAR2(80)  NOT NULL,
       salary      NUMBER            NULL,
       hire_date   DATE              NULL
);


-- emp 테이블 내역 조회
DESC EMP;

--emp_name 컬럼 크기를  80에서 100으로 변경 
ALTER TABLE emp 
MODIFY EMP_NAME VARCHAR2(100);

-- 컬럼 추가 
ALTER TABLE emp
ADD EMP_NAME2  VARCHAR2(80);

-- 컬럼명 변경
ALTER TABLE emp
RENAME COLUMN EMP_NAME2 TO EMP_NAME3;

-- 컬럼 삭제 
ALTER TABLE emp
DROP COLUMN EMP_NAME3;

-- emp 테이블 내역 조회
DESC EMP;

-- emp 테이블 삭제 
DROP TABLE emp;

-- emp 테이블 삭제 확인 
DESC EMP;

-- 테이블 생성 시 PK 생성1
CREATE TABLE  EMP (
       emp_no      VARCHAR2(30)  PRIMARY KEY, 
       emp_name    VARCHAR2(80)  NOT NULL,
       salary      NUMBER            NULL,
       hire_date   DATE              NULL
);

-- 테이블 생성 시 PK 생성2
CREATE TABLE  EMP2 (
       emp_no      VARCHAR2(30)  , 
       emp_name    VARCHAR2(80)  NOT NULL,
       salary      NUMBER            NULL,
       hire_date   DATE              NULL,
       PRIMARY KEY (emp_no)
);


-- alter table 문 사용  
 CREATE TABLE  EMP3 (
       emp_no      VARCHAR2(30)  ,
       emp_name    VARCHAR2(80)  NOT NULL,
       salary      NUMBER            NULL,
       hire_date   DATE              NULL
       );


ALTER TABLE EMP3
ADD CONSTRAINTS EMP3_PK PRIMARY KEY ( EMP_NO );

-- 생성, 수정, 삭제 실습
CREATE TABLE DEPT_TEST (
       dept_no      NUMBER        NOT NULL,
       dept_name    VARCHAR2(50)  NOT NULL,
       dept_desc    VARCHAR2(100)     NULL,
       create_date  DATE 
);

-- 테이블 생성 확인
DESC DEPT_TEST;

-- DEPT_DESC1 컬럼 추가
ALTER TABLE DEPT_TEST
ADD  DEPT_DESC1 VARCHAR2(80);

-- DEPT_DESC1 컬럼 삭제
ALTER TABLE DEPT_TEST
DROP COLUMN DEPT_DESC1 ;

-- DEPT_TEST_PK 란 이름으로 PK 생성
ALTER TABLE DEPT_TEST
ADD CONSTRAINTS DEP_TEST_PK PRIMARY KEY ( DEPT_NO);


-- DEPT_TEST 테이블 삭제 
DROP TABLE DEPT_TEST;

-----------------------------------------------------------------------------------------------------
