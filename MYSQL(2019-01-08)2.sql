-- MSSQL Excel Import

use userDB;
SHOW TABLES;
DROP TABLE tbl_score;

CREATE TABLE tbl_score (
	g_id INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    g_stname nVARCHAR(50) NOT NULL,
    g_subject nVARCHAR(10) NOT NULL,
    g_score INT(3)
);

SELECT * FROM tbl_score;

SELECT g_stname,
	SUM(IF(g_subject = '국어', g_score,0)) AS 국어,
    SUM(IF(g_subject = '영어', g_score,0)) AS 영어,
    SUM(IF(g_subject = '수학', g_score,0)) AS 수학,
    SUM(IF(g_subject = '과학', g_score,0)) AS 과학
FROM tbl_score
GROUP BY g_stname;