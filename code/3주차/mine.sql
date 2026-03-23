/*
온라인 쇼핑몰
유저 엔티티

[Entities / 개체]
- Users

[Properties / 속성]
- id (BIGSERIAL)
- name (TEXT)
- nickname (TEXT)
- email (VARCHAR(50))
- phone (VARCHAR(20))
- address (VARCHAR(50))
*/

CREATE TABLE users (
	id bigserial,
	name text,
	nickname text,
	email varchar(50),
	phone varchar(20),
	address varchar(50)
);

TABLE users;

-- 데이터  삽입하기
INSERT INTO users (name, nickname, email, phone, address)
VALUES
	('김정운', 'kj', 'kim@naver.com', '01011112222', '서울특별시'),
	('박지선', 'pj', 'park@naver.com', '01033334444', '인천광역시'),
	('이재석', 'lj', 'lee@gmail.com', '01055556666', '대구광역시'),
	('류현지', 'yh', 'ryu@gmail.com', '01012345678', '부산특별시'),
	('양정호', 'yj', 'yang@gmail.com', '01098765432', '대전광역시');

-- 데이터 검색하기
SELECT * FROM users;
SELECT name, email FROM users ORDER BY address ASC;
SELECT name, email FROM users WHERE name LIKE '김%';
