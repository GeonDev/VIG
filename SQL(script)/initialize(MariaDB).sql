DROP DATABASE IF EXISTS MVCSHOP; 
 
CREATE DATABASE MVCSHOP; 

USE MVCSHOP;

DROP TABLE IF EXISTS images;
DROP TABLE IF EXISTS transaction;
DROP TABLE IF EXISTS discount;

DROP TABLE IF EXISTS product CASCADE;
DROP TABLE IF EXISTS users CASCADE;
DROP TABLE IF EXISTS coupon CASCADE;



CREATE TABLE users ( 
	user_id 			 VARCHAR(20)		NOT NULL,
	user_name 			 VARCHAR(50)		NOT NULL,
	password 			 VARCHAR(10)		NOT NULL,
	role 				 VARCHAR(5) 		DEFAULT 'user',
	ssn 				 VARCHAR(13),
	cell_phone			 VARCHAR(14),
	addr 				 VARCHAR(100),
	email 				 VARCHAR(50),
	reg_date 			 DATE,
	PRIMARY KEY(user_id)
);


CREATE TABLE product ( 
	prod_no 				 INT(11) 		NOT NULL AUTO_INCREMENT,
	prod_name 				 VARCHAR(100) 	NOT NULL,
	prod_detail 			 VARCHAR(200),
	manufacture_day			 VARCHAR(8),
	price 					 INT(11),
	reg_date 				 DATE,
	PRIMARY KEY(prod_no)
);


CREATE TABLE images ( 
	image_no				 INT(11) 		NOT NULL AUTO_INCREMENT,
	prod_no 				 INT(11)			NOT NULL REFERENCES product(prod_no),
	image_file 				 VARCHAR(100) 	NOT NULL,
	PRIMARY KEY(image_no)
);


CREATE TABLE transaction ( 
	tran_no 				 INT(11) 		NOT NULL AUTO_INCREMENT,
	prod_no 				 INT(11)			NOT NULL REFERENCES product(prod_no),
	buyer_id 				 VARCHAR(20)		NOT NULL REFERENCES users(user_id),
	payment_option			 VARCHAR(3),
	receiver_name 			 VARCHAR(20),
	receiver_phone			 VARCHAR(14),
	dlvy_addr 				 VARCHAR(100),
	dlvy_request 			 VARCHAR(100),
	tran_status_code		 VARCHAR(3),
	order_date 				 DATE,
	dlvy_date 				 DATE,
	PRIMARY KEY(tran_no)
);


CREATE TABLE coupon(
	coupon_no				 INT(11) 		NOT NULL AUTO_INCREMENT,
	coupon_name				 VARCHAR(100) 	NOT NULL,
	discount_ratio			 INT(11)		 	NOT NULL,	
	maximum_discount_price	 INT(11),
	minimum_price			 INT(11),
	PRIMARY KEY(coupon_no)
);


CREATE TABLE discount(
	discount_no			 	 INT(11) 		NOT NULL AUTO_INCREMENT,
	owner_id				 VARCHAR(20) 	NOT NULL REFERENCES users(user_id),
	coupon_no				 INT(11)			NOT NULL REFERENCES coupon(coupon_no),
	product_no				 INT(11)			REFERENCES product(prod_no),	
	issued_date				 DATE,
	expiration_date			 DATE,
	purchase_date			 DATE,
	PRIMARY KEY(discount_no)
);


ALTER TABLE product AUTO_INCREMENT = 1000;
ALTER TABLE images AUTO_INCREMENT = 2000;
ALTER TABLE transaction AUTO_INCREMENT = 3000;
ALTER TABLE coupon AUTO_INCREMENT = 4000;
ALTER TABLE discount AUTO_INCREMENT = 5000;


INSERT 
INTO users (user_id, user_name, password, role, cell_phone, addr, email, reg_date) 
VALUES ( 'admin', 'admin', '1234', 'admin',  '010-1111-2222', '서울시 서초구', 'admin@mvc.com',DATE_FORMAT('2012/01/14', '%Y/%M/%D')); 

INSERT INTO users (user_id, user_name, password, role, cell_phone, addr, email, reg_date)
VALUES ( 'user01', '손건', '1111', 'user', '010-1111-2222', '서울시 서초구', 'USER@mvc.com', NOW()); 

INSERT INTO users (user_id, user_name, password, role, cell_phone, addr, email, reg_date)
VALUES ( 'user02', 'user02', '2222', 'user', '010-1111-2222', '서울시 서초구', 'USER@mvc.com', NOW()); 


INSERT INTO users (user_id, user_name, password, role, cell_phone, addr, email, reg_date)
VALUES ( 'user03', 'user03', '3333', 'user', '010-1111-2222', '서울시 서초구', 'USER@mvc.com', NOW()); 


INSERT INTO users (user_id, user_name, password, role, cell_phone, addr, email, reg_date)
VALUES ( 'user04', 'user04', '4444', 'user', '010-1111-2222', '서울시 서초구', 'USER@mvc.com', NOW()); 

INSERT INTO users (user_id, user_name, password, role, cell_phone, addr, email, reg_date)
VALUES ( 'user05', 'user05', '5555', 'user', '010-1111-2222', '서울시 서초구', 'USER@mvc.com', NOW()); 

INSERT INTO users (user_id, user_name, password, role, cell_phone, addr, email, reg_date)
VALUES ( 'user06', 'user06', '6666', 'user', '010-1111-2222', '서울시 서초구', 'USER@mvc.com', NOW()); 

INSERT INTO users (user_id, user_name, password, role, cell_phone, addr, email, reg_date)
VALUES ( 'user07', 'user07', '7777', 'user', '010-1111-2222', '서울시 서초구', 'USER@mvc.com', NOW()); 

INSERT INTO users (user_id, user_name, password, role, cell_phone, addr, email, reg_date)
VALUES ( 'user08', 'user08', '8888', 'user', '010-1111-2222', '서울시 서초구', 'USER@mvc.com', NOW()); 

INSERT INTO users (user_id, user_name, password, role, cell_phone, addr, email, reg_date)
VALUES ( 'user09', 'user09', '9999', 'user', '010-1111-2222', '서울시 서초구', 'USER@mvc.com', NOW()); 



insert into product values (prod_no,'소니 A7R3','고화질 미러리스','20190312',3200000, NOW());
insert into images values(image_no, 1000, 'Q4GH4H580A7R3.jpg');
insert into images values(image_no, 1000,'4sxi6wsu.png');
insert into images values(image_no, 1000,'asdfga235sg.jpg');
insert into images values(image_no, 1000,'dyfd6egt55g4.jpg');

insert into product values (prod_no,'소니 RM100','컴팩트 미러리스','20150425',430000, NOW());
insert into images values(image_no, 1001,'17369039962142.jpg');
insert into images values(image_no, 1001,'wdqwfgqg234.jpg');

insert into product values (prod_no,'후지 X-pro3','클래식 미러리스','20190317',1350000, NOW());
insert into images values(image_no, 1002,'2016243376werth321106.jpg');

insert into product values (prod_no,'후지 100f','클래식 컴팩트 카메라','20180228',630000, NOW());
insert into images values(image_no, 1003,'20181384765947qqw52.jpg');

insert into product values (prod_no,'후지 X-T3','클래식 미러리스 카메라','20180520',829000, NOW());
insert into images values(image_no, 1004,'201825733wrth453311.jpg');

insert into product values (prod_no,'소니 RM102','컴팩트 미러리스','20160425',550000, NOW());
insert into images values(image_no, 1005,'23467fhyg4hh.jpg');

insert into product values (prod_no,'후지 X-T2','클래식 미러리스 카메라','20140425',350000, NOW());
insert into images values(image_no, 1006,'2346902GQ3G34.jpg');

insert into product values (prod_no,'즉석카메라','일회용 필름 카메라','20120425',350000, NOW());
insert into images values(image_no, 1007,'234UYWERH467G.jpg');

insert into product values (prod_no,'캐논 R5','전문가용 미러리스 카메라','20180605',350000, NOW());
insert into images values(image_no, 1008,'33570_63794_817.jpg');

insert into product values (prod_no,'니콘 D780','전문가용 DSLR 카메라','20200205',350000, NOW());
insert into images values(image_no, 1009,'82705_53723_2834.jpg');

insert into product values (prod_no,'올림푸스 el10','컴팩트 미러리스 카메라','20191225',350000, NOW());
insert into images values(image_no, 1010,'997B20355C15B67E10.png');

insert into product values (prod_no,'삼성 NX200','컴팩트 미러리스 카메라','20160125',150000, NOW());
insert into images values(image_no, 1011,'asdfah34h348i.jpg');

insert into product values (prod_no,'라이카 폴라로이드','컴팩트 미러리스 카메라','20140125',1850000, NOW());
insert into images values(image_no, 1012,'fqg3g.jpg');

insert into product values (prod_no,'토이카메라','컴팩트 카메라','20140425',50000, NOW());
insert into images values(image_no, 1013,'G6T34HY.jpg');

insert into product values (prod_no,'캐논 5Ds','전문가용 DSLR 카메라','20140425',9580000, NOW());
insert into images values(image_no, 1014,'gasgqh.jpg');

insert into product values (prod_no,'후지 X100 pro','컴팩트 미러리스 카메라','20140425',50000, NOW());
insert into images values(image_no, 1015,'gqrghsgqerg.jpg');

insert into product values (prod_no,'올림푸스 펜F','컴팩트 미러리스 카메라','20170425',590000, NOW());
insert into images values(image_no, 1016,'gwergh.jpg');

insert into product values (prod_no,'종이 카메라','일회용 카메라','20150425',90000, NOW());
insert into images values(image_no, 1017,'qweh3hA87943.jpg');

insert into product values (prod_no,'올림푸스 EM5','전문가용 미러리스 카메라','20190425',1290000, NOW());
insert into images values(image_no, 1018,'qwergwg453.jpg');

insert into product values (prod_no,'라이카 C-Lux','컴팩트 카메라','20170521',4570000, NOW());
insert into images values(image_no, 1019,'unfjkhjk8768.jpg');

insert into product values (prod_no,'캐논 200D','DSLR 카메라','20150521',5570000, NOW());
insert into images values(image_no, 1020,'u7n46naas5me6d.jpg');

insert into product values (prod_no,'라이카 D-Lux ','컴팩트 카메라','20140521',550000, NOW());
insert into images values(image_no, 1021,'unnaasdfmedfjhfh6.jpg');

insert into product values (prod_no,'소니 A5100','컴팩트 카메라','20130521',892000, NOW());
insert into images values(image_no, 1022,'asfeginneasdfasgasfd03.jpg');

insert into product values (prod_no,'캐논 200D 화이트','DSLR 카메라','20180521',132000, NOW());
insert into images values(image_no, 1023,'asdfasdfefff2345ffa.jpg');

insert into product values (prod_no,'리코 GR','컴팩트 카메라','20170521',9900, NOW());
insert into images values(image_no, 1024,'ferh476hf335g3.jpg');

insert into product values (prod_no,'오즈모 포켓','컴팩트 카메라','20180521',19900, NOW());
insert into images values(image_no, 1025,'sdf572g46j2gj7oqht.jpg');

insert into product values (prod_no,'올림푸스 EM1','전문가용 미러리스 카메라','20200325',259900, NOW());
insert into images values(image_no, 1026,'1fhqw23qwe4qwqw.jpg');
insert into images values(image_no, 1026,'34793w12e5315221980.jpg');
insert into images values(image_no, 1026,'qwevt20qwru000_4.jpg');

insert into product values (prod_no,'후지 X-T4','전문가용 미러리스 카메라','20200517',859500, NOW());
insert into images values(image_no, 1027,'gho45t58095jh69g.jpg');
insert into images values(image_no, 1027,'q5we408gh74qrg4.PNG');
insert into images values(image_no, 1027,'ret42uer.PNG');
insert into images values(image_no, 1027,'12g75nogwg3.jpg');
insert into images values(image_no, 1027,'234y42uqwt.PNG');

insert into product values (prod_no,'고프로 히어로8','컴팩트 카메라','20190711',39900, NOW());
insert into images values(image_no, 1028,'fsh5372836.jpg');

insert into product values (prod_no,'고프로 히어로4','컴팩트 카메라','20140711',19900, NOW());
insert into images values(image_no, 1029,'ASDF234523F23.jpg');

insert into product values (prod_no,'소니 FDR-X3000','컴팩트 카메라','20170711',22900, NOW());
insert into images values(image_no, 1030,'62324uqt43w8e.jpg');

insert into coupon values (coupon_no,'신규 가입자 쿠폰', 10, 10000,100000);
insert into coupon values (coupon_no, '이달의 VIP 쿠폰', 40, 200000, 500000);
insert into coupon values (coupon_no, '이달의 이벤트 쿠폰', 30, 15000, 10000);
insert into coupon values (coupon_no, '누구나 이벤트 쿠폰', 10, 5000, 10000);

commit;
