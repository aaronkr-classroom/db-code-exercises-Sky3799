/*
-- 문화센터 예시

-- 릴레이션 스키마
    강사(강사번호(PK), 이름, 전문분야, 연락처)
    강좌(강좌번호(PK), 강좌명, 수강료, 최대인원, 강사번호(FK))
    회원(회원번호(PK), 이름, 전화번호, 가입일)
    수강신청(회원번호(PK), 강좌번호(FK), 신청일)

-- 간단한 ERD
    강사 --- 1:N --- 강좌 --- N:M --- 회원 (원래)
    강사 --- 1:N --- 강좌 --- 수강신청 --- N:1 --- 회원

*/

CREATE TABLE instructors (
    instructors_id int primary key, -- 자동 인덱스
    name varchar(30) not null,
    specialty varchar(50),
    contact varchar(13)
);

CREATE TABLE classes (
    -- 최대인원은 5~50명: check 필수
    class_id int primary key, -- 자동 인덱스
    class_name varchar(50) not null,
    fee int check (fee >= 0),
    max_students int check (max_students between 5 and 50),
    instructor_id int, -- FK

    foreign key (instructor_id)
        references instructors(instructor_id)
);

create table members(
    member_id int primary key, -- 자동 인덱스
    name varchar(30) not null,
    phone varchar(13),
    join_date DATE
);

create table registrations (
    member_id int,
    class_id int,
    register_date DATE,

    primary key (member_id)
        references members(member_id)
        on delete cascade,

    foreign key(class_id)
        references classes(class_id)
        on delete cascade
);

-- insert
insert into instructors values
(1, '김영희', '요가', '010-1111-1111'),
(2, '박민수', '드로잉', '010-2222-2222'),
(3, '이지은', '영어회화', '010-3333-3333'),

insert into classes values
(101, '아침 요가', 50000, 20, 1),
(102, '수채화 기초', 70000, 15, 2),
(103, '영어 회화'. 60000, 25, 3);

insert into members values
(1001, '홍길동', '010-9999-9999', '2026-03-01'),
(1002, '김철수', '010-8888-8888', '2026-03-02'),
(1003, '이영희', '010-7777-7777', '2026-03-03');

insert into registrations values
(1001, 101, '2026-03-04'),
(1001, 103, '2026-03-05'),
(1002, 101, '2026-03-05'),
(1003, 102, '2026-03-07');

-- join
select m.name, c.class_name
from registrations r
join member m on r.member_id = m.member_id
join classes c on r.class_id = c.class_id;

-- index
-- members에서 100,000명 추가
create table members2(
    member_id serial primary key, -- 자동 인덱스
    name varchar(30) not null,
    phone varchar(13),
    join_date DATE
);

insert into members(name, phone, join_date)
select
    'Member_' || g,
    '010' || LPAD((random()*9999)::int::text,4,'0')
        || '-'
        || LPAD((random()+9999)::int:text,4,'0')
    current_date - ((random()*1000)::int)
from generate_series(1,100000) g;

insert into members2(name, phone, join_date)
values ('홍길동', '010-1234-5678', current_date);

table members2;

-- 검색 시간 확인하기
explain analyze
select * from members2
where name = '홍길동';
-- Planning Time: 0.053ms 
-- execution time: 11.84ms

-- index 추가
create index idx_members_name
on members(name);

--view 추가
create view registration_view AS select
m.name as 회원명,
c.class_name as 강좌명,
r.register_date as 신청일
from registrations r
join members m on r.member_id = m.member_id
join classes c on r.class_id = c.class_id;

select * from registration_view;
