-- 2019.01.08
-- MYSQL에서는 DATABASE라는 클래스를 생성해야 하나는데
-- 오라클에서 TABLESPACE의 개념으로 보면된다.

-- DATABASE : SCHEMAS라고 부른다.
-- 모든 데이터의 물리적인 저장 공간
-- 생성한다 : CREATE
CREATE DATABASE userDB;

-- userDB 스키마를 사용하기 위해서 OPEN
USE userDB;

-- TABLE
-- ID 칼럼은 자동증가 옵션을 사용하며
-- 실제 저장되는 레코드의 개수와 밀접한 관계가 있다.
-- 기본값으로 int형을 지정하면 이론상 11자리까지 저장이 되는데
-- int형은 	-2147483648 ~ 2147483647 범위이다
-- UNSIGNED로 키워 설정하면 0 ~ 4294967295
-- 일방적은 int형으로만 설정을 하면
-- 저장할수 있는 데이터의 개수가 절반으로 되는 현상이
-- 발생할 수 있다.
CREATE TABLE tbl_score(
	id INT PRIMARY KEY AUTO_INCREMENT,
    sc_num CHAR(5) NOT NULL,
    sc_name nVARCHAR(30),
    sc_value INT(3)
);
INSERT INTO tbl_score
VALUES(0,'001','국어',80);

INSERT INTO tbl_score
VALUES(0,'001','수학',CAST(RAND() * 100 AS SIGNED ) + 50 );
SELECT * FROM tbl_score;

INSERT INTO tbl_score
VALUES(0,'001','영어',CAST(RAND() * (100-50+1) AS SIGNED ) + 50 );

INSERT INTO tbl_score
VALUES(0,'002','국어',CAST(RAND() * (100-50+1) AS SIGNED ) + 50 );
INSERT INTO tbl_score
VALUES(0,'002','수학',CAST(RAND() * (100-50+1) AS SIGNED ) + 50 );
INSERT INTO tbl_score
VALUES(0,'002','영어',CAST(RAND() * (100-50+1) AS SIGNED ) + 50 );

SELECT sc_num , COUNT(*) , SUM(sc_value)
FROM tbl_score
GROUP BY sc_num ;

-- 오라클 코드
SELECT sc_num, 
	SUM(DECODE(sc_name, '국어', sc_value)) AS 국어,
    SUM(DECODE(sc_name, '수학', sc_value)) AS 수학,
    SUM(DECODE(sc_name, '영어', sc_value)) AS 영어
FROM tbl_score
GROUP BY sc_num ;

-- MYSQL
SELECT sc_num,
	SUM(IF(sc_name = '국어', sc_value,0)) AS 국어,
    SUM(IF(sc_name = '수학', sc_value,0)) AS 수학,
    SUM(IF(sc_name = '영어', sc_value,0)) AS 영어
FROM tbl_score
GROUP BY sc_num ;

-- 현재 성적처리에서 국어, 영어, 수학만을 사용했는데
-- 과학과목이 추가 되었다.
-- 그런상황에서 TABLE의 구조를 변경할 필요 없이
-- 해당하는 과목을 INSERT만 해주면 얼마든지 과목정보를 추가 할 수 있다.
INSERT INTO tbl_score
VALUES(0,'001','과학',88) ;
INSERT INTO tbl_score
VALUES(0,'002','과학',73) ;

CREATE VIEW view_score
AS
SELECT sc_num,
	SUM(IF(sc_name = '국어', sc_value, 0)) AS 국어,
    SUM(IF(sc_name = '영어', sc_value, 0)) AS 영어,
    SUM(IF(sc_name = '수학', sc_value, 0)) AS 수학,
    SUM(IF(sc_name = '과학', sc_value, 0)) AS 과학
FROM tbl_score
GROUP BY sc_num;

SELECT * FROM view_score;

DROP TABLE tbl_student;
CREATE TABLE tbl_student (
	st_num CHAR(5) PRIMARY KEY,
    st_name nVARCHAR(30) NOT NULL,
    st_tel nVARCHAR(30)
);

INSERT INTO tbl_student
VALUES('001','홍길동','001');

SELECT SC.sc_num, ST.st_name, SC.sc_name, SC.sc_value
FROM tbl_score AS SC
	LEFT JOIN tbl_student AS ST
		ON sc.sc_num = st.st_num;
