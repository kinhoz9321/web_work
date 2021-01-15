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

-- SELECT 문으로 목록의 이전, 다음 번호 알아내기
SELECT num, writer,
	LAG(num, 1, 0) OVER (ORDER BY num DESC) AS prevNum,
	LEAD(num, 1, 0) OVER (ORDER BY num DESC) AS nextNum
FROM board_gallery;
-- SELECT 문의 결과도 하나의 테이블이다. 임의의 테이블.

-- 갤러리 이전글 번호 구현하기 (rs.getInt(prevNum)) 다음글 번호 구현하기 (rs.getInt(nextNum))
SELECT *
FROM
	(SELECT num, writer, caption,
	LAG(num, 1, 0) OVER (ORDER BY num DESC) AS prevNum, -- 별칭두기 LAG 번호에 대해서 하나 뒤처진 것 (자주쓰임)
	LEAD(num, 1, 0) OVER (ORDER BY num DESC) AS nextNum -- LEAD 번호에 대해서 하나 앞선 것 (자주쓰임)
	FROM board_gallery
	ORDER BY num DESC) --1 결과 (전체 목록 SELECT)
WHERE num=191; --번호가 191번인 결과를 읽어내겠다.
-- LAG LEAD 오라클에서만 사용할 수 있는 함수

-- 갤러리 시퀀스
CREATE SEQUENCE board_gallery_seq;