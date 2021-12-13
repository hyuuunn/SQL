-- Q1. CREATE TABLE 문을 사용해 테이블을 생성한 후 테이블에 있는 컬럼의 데이터 형을 수정하려면 ALTER COLUMN 문을 사용해야 한다.
-- => X
-- 만들어진 테이블의 컬럼에 대한 속성을 변경하려면 ALTER TABLE 문을 사용해야 한다. 즉, ALTER TABLE ... MODIFY ... 문을 사용한다.
-- ALTER COLUMN 문은 존재하지 않는다.

--Q2. 다음 내용을 보고 country_test 란 테이블을 만들어 보세요
컬럼명 설명  데이터형  NULL 허용여부 PK 여부
COUNTRY_ID  국가번호  NUMBER  N Y
COUNTRY_NAME  국가명 VARCHAR2(100) N

CREATE TABLE COUNTRY_TEST (
  COUNTRY_ID NUMBER NOT NULL,
  COUNTRY_NAME VARCHAR2(100) NOT NULL,
 PRIMARY KEY (COUNTRY_ID)
 );
 
 --Q3.
