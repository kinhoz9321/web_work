-- 어떤 이름으로 어떤 테이블과 시퀀스를 만들었는지 메모를 남기는 곳

-- 사용자(회원) 정보를 저장할 테이블
CREATE TABLE users(
	id VARCHAR2(100) PRIMARY KEY,
	pwd VARCHAR2(100) NOT NULL,
	email VARCHAR2(100),
	profile VARCHAR2(100), -- 프로필 이미지 경로를 저장할 칼럼
	regdate DATE -- 가입일
);

-- 게시글을 저장할 테이블
CREATE TABLE board_cafe(
	num NUMBER PRIMARY KEY, --글번호
	writer VARCHAR2(100) NOT NULL, --작성자 (로그인된 아이디)
	title VARCHAR2(100) NOT NULL, --제목
	content CLOB, --글 내용 (VARCHAR2로는 감당이 안됨으로 CLOB로 설계함)
	viewCount NUMBER, --조회수
	regdate DATE --글 작성일
);

-- 게시글의 번호를 얻어낼 시퀀스
CREATE SEQUENCE board_cafe_seq;

-- 업로드된 파일의 정보를 저장할 테이블
CREATE TABLE board-file(
	num NUMBER PRIMARY KEY,
	writer VARCHAR2(100) NOT NULL,
	title VARCHAR2(100)	NOT NULL,
	orgFileName VARCHAR2(100) NOT NULL, --원본 파일명
	saveFileName VARCHAR2(100) NOT NULL, --서버에 실제로 저장된 파일명
	fileSize NUMBER NOT NULL, --파일의 크기
	regdate DATE
);

-- 파일의 번호를 얻어낼 시퀀스
CREATE SEQUENCE board_file_seq;

-- 갤러리 테이블
CREATE TABLE board_gallery(
	num NUMBER PRIMARY KEY,
	writer VARCHAR2(100),
	caption VARCHAR2(100),
	imagePath VARCHAR2(100),
	regdate DATE
);

-- 갤러리 시퀀스
CREATE SEQUENCE board_gallery_seq;