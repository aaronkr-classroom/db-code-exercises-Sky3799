-- User,Game, Item, Play, UserItem

create table users(
    user_id int primary key ,
    name varchar(30) not null,
    nickname varchar(30) not null,
    level int,
    join_data date
);

create table games(
  game_id int primary key,
  game_name varchar(50) not null,
  genre varchar(20),
  release_date date  
);

create table items (
	item_id int primary key,
	item_name varchar(30),
	price int,
	grade char -- 'S'
);


create table plays (
	user_id int,
	game_id int,
	start_date date,
	play_time int, -- 시작: Time.now(), 현재: Time.now()
	-- Time.now() = ...
	primary key (user_id, game_id),
	foreign key (user_id) references users(user_id),
    foreign key (game_id) references games(game_id)
);


create table user_items(
	user_id int,
	item_id int,
	acquired_date date,
	quantity int,
	primary key (user_id, item_id),
	foreign key (user_id) references users(user_id),
	foreign key (item_id) references items(item_id)
);

-- insert values
insert into users values
(1, '김민준', 'DragonKing', 15, '2024-03-01'),
(2, '이서연', 'StarMage', 22, '2024-03-15'),
(3, '박지훈', 'DarkKnight', 8, '2024-04-05'),
(4, '최유진', 'HealerQueen', 34, '2024-06-11'),
(5, '정도윤', 'FastArcher', 17, '2024-11-11');

insert into games values
(101, 'Super Mario RPG', 'RPG', '2021-01-01'),
(102, 'Gran Turismo', 'Racing', '2019-12-31'),
(103, 'Puzzle Bobble', 'Puzzle', '2022-07-14');

insert into items values
(1001, '강철검', 5000, 'B'),
(1002, '마법지팡이', 12000, 'A'),
(1003, '회복포션', 500, 'C'),
(1004, '황금방패', 20000, 'S'),
(1005, '불꽃활', 15000, 'S');

insert into plays values
(1, 101, '2024-03-23', 120),
(2, 101, '2024-03-21', 97),
(3, 102, '2024-05-05', 500),
(4, 101, '2024-03-21', 140),
(5, 103, '2019-12-31', 1000);

insert into user_items values
(1, 1001, '2024-03-23', 1),
(2, 1003, '2021-03-21', 2),
(3, 1002, '2024-05-05', 5),
(4, 1004, '2024-03-21', 4),
(5, 1005, '2019-12-31', 10);

-- 기본 조회 연습
-- 1. 전체 유저 조회
select * from users;

-- 2. 레벨 높은 수서로 조회
select * from users
order by level DESC;

-- 3. 레벨이 10 이상인 유저 조회
select * from users
where level >=10

-- 4. 's' 등급 이상인 유저 조회
select * from items
where grade = 'S';

-- 테이블 수정할 때 (ALTER TABLE)
-- 1. 게임 회사에서 유저의 이메일도 저장하기로 했다.
alter table users
add column email varchar(50);
table users;

-- 2. 유저에게 현재 접속 상태를 저장해야 한다.
alter table users
add column status varchar(10) default 'offline';
table users;

-- 3. 아이템 테이블의 판매 가능 여부를 추가해야 한다.
alter table items
add column is_sellable boolean default true;
table items;
-- 4. 게임 테이블에 게임 등급 정보를 추가해야 한다.
alter table games
add column age_rating varchar(10);
table games;

-- 테이블에 있는 값이 변경할 때 (update)
-- 1. 김민준 유저의 이메일을 추가합니다.
update users
set email = 'minjun@email.com'
where user_id = 1;

-- 2. 이서연 유저의 레벨이 25로 올랐다.
update users
set level =25
where user_id = 2;

-- 3. 모든 유저의 기본 접속 상태를 online으로 설정한다.
update users
set status = 'online';

-- 4. DragonKing 유저가 현재 접속 중이다.
update users
set status = 'connection'
where nickname = 'DragonKing';

-- 5. 회복포션의 가격을 700으로 변경한다.
update items
set price = 700
where item_name = '회복포션';

-- 6. Gran Turismo의 이용 가능 연령을 12세 이상으로 설정한다.
update games
set age_rating = '12+'
where game_id = 102;

-- 주의 설명
-- delete는 데이터를 삭제한다.
-- drop table은 테이블 자체를 삭제한다.
-- alter table은 테이블 구조를 변경한다.
-- update는 기존 데이터를 수정한다.