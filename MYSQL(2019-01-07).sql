-- mysql 시작
-- root로 접속한 상태

CREATE DATABASE myDB;
-- myDB를 open
USE myDB;

CREATE TABLE tbl_test (
	id INT(11) PRIMARY KEY auto_increment,
    stname VARCHAR(30) NOT NULL,
    sttel VARCHAR(20),
    staddr VARCHAR(125)
);
-- 데이터 추가
INSERT INTO tbl_test
VALUES (0, '홍길동', '12345', '서울');

SELECT * FROM tbl_test 
GROUP BY stname;
DESC tbl_test;

SELECT 30 * 50 ;
SELECT '가나다라마바사' ;

-- 기존에 한글문제 발생한 테이블
-- 한글세팅 변경
ALTER TABLE tbl_test CONVERT TO charset utf8;