SET SESSION FOREIGN_KEY_CHECKS=0;

/* Drop Tables */

DROP TABLE IF EXISTS reply;
DROP TABLE IF EXISTS board;
DROP TABLE IF EXISTS user;




/* Create Tables */

-- 게시물정보
CREATE TABLE board
(
	bno int NOT NULL AUTO_INCREMENT COMMENT '게시물번호',
	btitle varchar(200) COMMENT '제목',
	bkind varchar(20) COMMENT '구분',
	bnote text COMMENT '내용',
	bfname varchar(255) COMMENT '첨부파일명',
	bpname varchar(255) COMMENT '저장된파일명',
	bwdate datetime DEFAULT now() COMMENT '작성일',
	bhit int DEFAULT 0 COMMENT '조회수',
	thead varchar(20) COMMENT '말머리',
	saveflag varchar(10) DEFAULT 'T' COMMENT '저장위치',
	userno int NOT NULL COMMENT 'userno',
	PRIMARY KEY (bno)
) COMMENT = '게시물정보';


-- 댓글정보
CREATE TABLE reply
(
	rno int NOT NULL AUTO_INCREMENT COMMENT '댓글번호',
	ruserno int COMMENT '댓글작성자번호',
	rnote text COMMENT '댓글내용',
	rwdate datetime DEFAULT now() COMMENT '댓글작성일',
	bno int NOT NULL COMMENT '게시물번호',
	PRIMARY KEY (rno)
) COMMENT = '댓글정보';


-- 회원정보
CREATE TABLE user
(
	userno int NOT NULL AUTO_INCREMENT COMMENT 'userno',
	id varchar(50) COMMENT '아이디',
	pw varchar(200) COMMENT '비밀번호',
	name varchar(200) COMMENT '이름',
	gender varchar(2) COMMENT '성별',
	joindate datetime DEFAULT now() COMMENT '가입일자',
	isretire varchar(2) DEFAULT 'N' COMMENT '탈퇴여부',
	email varchar(200) COMMENT '이메일',
	isadmin varchar(2) DEFAULT 'N' NOT NULL COMMENT '관리자여부',
	PRIMARY KEY (userno)
) COMMENT = '회원정보';



/* Create Foreign Keys */

ALTER TABLE reply
	ADD FOREIGN KEY (bno)
	REFERENCES board (bno)
	ON UPDATE RESTRICT
	ON DELETE RESTRICT
;


ALTER TABLE board
	ADD FOREIGN KEY (userno)
	REFERENCES user (userno)
	ON UPDATE RESTRICT
	ON DELETE RESTRICT
;



