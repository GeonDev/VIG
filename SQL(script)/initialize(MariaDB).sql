DROP DATABASE IF EXISTS VIG; 
 
CREATE DATABASE VIG; 

USE VIG;


CREATE TABLE users ( 
	user_code  			 VARCHAR(20) 		NOT NULL,
	user_name  			 VARCHAR(50) 		NOT NULL,
	password  			 VARCHAR(200),
	role  				 VARCHAR(10)  		DEFAULT 'user',	
	profile_img 		 VARCHAR(50)	    DEFAULT 'profile_img.jpg',
	self_introduce  	 VARCHAR(1024),	
	sex  				 VARCHAR(10),
	birth  				 INT(4),
	state  				 TINYINT(1),
	google_id  			 VARCHAR(100),
	account  			 VARCHAR(50),
	prime_count  		 INT(11),
	email 				 VARCHAR(50),
	reg_date  			 DATE,
	ban_date  			 DATE,
	PRIMARY KEY(user_code)
);

CREATE TABLE categories ( 
	category_id 			 INT(11)  		NOT NULL AUTO_INCREMENT,
	category_name 			 VARCHAR(100) 	NOT NULL,
	category_img 			 VARCHAR(100),
	UNIQUE (category_name),
	PRIMARY KEY(category_id)
);


CREATE TABLE feeds ( 
	feed_id  				 INT(11)  		NOT NULL AUTO_INCREMENT,
	feed_title  			 VARCHAR(100)  	NOT NULL,
	feed_explanation 		 VARCHAR(1024),
	user_code 		 		 VARCHAR(20)  	NOT NULL REFERENCES users(user_code),
	feed_reg_date 			 DATE, 
	feed_edit_date 			 DATE, 
	feed_view_count 		 INT(11)		DEFAULT 0, 
	feed_is_prime 			 TINYINT(1)		DEFAULT 0, 
	category_id  			 INT(11)   		REFERENCES categories(category_id),  	 	
	feed_use_gears 		 	 VARCHAR(1024), 
	feed_state 				 TINYINT(1) 	DEFAULT 0, 
	prime_feed_view_count 	 INT(11) 		DEFAULT 0, 
	comment_range 			 TINYINT(1), 
	PRIMARY KEY(feed_id)
);


CREATE TABLE images ( 
	image_id 				 INT(11)  		NOT NULL AUTO_INCREMENT,
	feed_id  				 INT(11) 		NOT NULL REFERENCES feeds(feed_id),
	feed_order  			 INT(11), 
	is_thumbnail 			 TINYINT(1)		DEFAULT 0, 	
	image_file  			 VARCHAR(100)  	NOT NULL,
	PRIMARY KEY(image_id)
);


CREATE TABLE colors ( 
	color_id 				 INT(11)   NOT NULL AUTO_INCREMENT,
	image_id 				 INT(11)   NOT NULL REFERENCES images(image_id),
	haxcode					 VARCHAR(7),
	color_r 				 TINYINT(4)  UNSIGNED,
	color_g 				 TINYINT(4)  UNSIGNED,
	color_b 				 TINYINT(4)  UNSIGNED,
	color_ratio				 FLOAT(5,5),
	PRIMARY KEY(color_id)
);

CREATE TABLE joiner ( 
	joiner_id 				INT(11)   	  NOT NULL AUTO_INCREMENT,
	user_code 				VARCHAR(20)   NOT NULL REFERENCES users(user_code),
	feed_id 				INT(11)   	  NOT NULL REFERENCES feeds(feed_id),
	is_like 				TINYINT(1),
	add_date  				DATE,
	PRIMARY KEY(joiner_id)
);


CREATE TABLE keywords ( 
	keyword_id 				 INT(11)  		NOT NULL AUTO_INCREMENT,
	image_id  				 INT(11) 		REFERENCES images(image_id),
	is_tag 					 TINYINT(1),
	user_code  				 VARCHAR(20)    REFERENCES users(user_code),			 
	keyword_en 				 VARCHAR(100), 
	keyword_origin 			 VARCHAR(100), 
	keyword_score 			 FLOAT(5,5), 	
	PRIMARY KEY(keyword_id)
);


CREATE TABLE comments ( 
	comment_id 				 INT(11)  		NOT NULL AUTO_INCREMENT,
	feed_id  				 INT(11) 		NOT NULL REFERENCES feeds(feed_id),
	comment_text 			 VARCHAR(1024) 	NOT NULL,
	user_code   			 VARCHAR(20) 	NOT NULL REFERENCES users(user_code),
	reg_date  			     DATE,
	edit_date  			     DATE,
	PRIMARY KEY(comment_id)
);

CREATE TABLE report ( 
	report_id 			 INT(11)  		NOT NULL AUTO_INCREMENT,
	reporter_code 		 VARCHAR(20) 	NOT NULL REFERENCES users(user_code),
	violator_code 		 VARCHAR(20) 	NOT NULL REFERENCES users(user_code),
	report_Type 	 	 TINYINT(1),
	report_feed_id  	 INT(11) 		NOT NULL REFERENCES feeds(feed_id),
	report_message 		 VARCHAR(1024), 
	report_date  		 DATE, 
	current_ban_type  	 TINYINT(1),
	current_ban_date   	 DATE, 
	PRIMARY KEY(report_id)
);

CREATE TABLE history ( 
	history_id 				INT(11)  		NOT NULL AUTO_INCREMENT,
	feed_id  				INT(11) 		NOT NULL REFERENCES feeds(feed_id),
	watch_user_code   		VARCHAR(20) 	REFERENCES users(user_code),
	show_date  			    DATE, 
	ip_address 				VARCHAR(20), 
	history_type 			TINYINT(1), 
	PRIMARY KEY(history_id)
);

CREATE TABLE follow ( 
	follower_id 		INT(11)  		NOT NULL AUTO_INCREMENT,	
	user_code   		VARCHAR(20) 	NOT NULL REFERENCES users(user_code),
	follower_code   	VARCHAR(20) 	NOT NULL REFERENCES users(user_code),
	PRIMARY KEY(follower_id)
);

CREATE TABLE alarm ( 
	alarm_id 			INT(11)  		NOT NULL AUTO_INCREMENT,	
	send_user_code   	VARCHAR(20) 	NOT NULL REFERENCES users(user_code),
	receive_user_code   VARCHAR(20) 	NOT NULL REFERENCES users(user_code),
	like_feed_id    	INT(11)    		REFERENCES feeds(feed_id),
	is_watch 			TINYINT(1),	
	alarm_type  		TINYINT(1),	
	add_date 			DATE, 
	PRIMARY KEY(alarm_id)
);

CREATE TABLE payment(
	payment_id VARCHAR(50) not NULL,
	buyer VARCHAR(20) NOT NULL REFERENCES users(user_code), 
	beneficiary VARCHAR(20) REFERENCES users(user_code),
	feed_id 	INT(11) REFERENCES feeds(feed_id),
	payment_option 	TINYINT(1), 
	product_type 	TINYINT(1),
	select_price 		INT(11),
	last_price  		INT(11),
	payment_date 	DATE,
	is_cancel 		TINYINT(1), 
	is_withdraw 	TINYINT(1), 
	PRIMARY KEY(payment_id)
);

CREATE TABLE withdraw ( 
	withdraw_id 	INT(11)  		NOT NULL AUTO_INCREMENT,
	user_code 		VARCHAR(20) 	NOT NULL REFERENCES users(user_code),
	acc_no 	 		VARCHAR(20),
	acc_holder 		VARCHAR(20),
	bank_code 		TINYINT(1),
	withdraw_date 	DATE,
	amount 	INT,
	PRIMARY KEY(withdraw_id)
);

CREATE TABLE event ( 
	event_id 			INT(11) 		NOT NULL AUTO_INCREMENT,	
	event_title 		VARCHAR(100),
	event_sub 			VARCHAR(1024),
	event_start 		DATE,
	event_end 			DATE,
	event_thumbnail 	VARCHAR(100),
	event_tag 			VARCHAR(100),
	event_image 		VARCHAR(100),
	event_type 			TINYINT(1),
	banner 				VARCHAR(100),
	PRIMARY KEY(event_id)
);

ALTER TABLE categories AUTO_INCREMENT  	 = 10000;
ALTER TABLE feeds AUTO_INCREMENT 		 = 20000;
ALTER TABLE images AUTO_INCREMENT 		 = 30000;
ALTER TABLE colors AUTO_INCREMENT		 = 40000;
ALTER TABLE joiner AUTO_INCREMENT 		 = 50000;
ALTER TABLE keywords AUTO_INCREMENT 	 = 60000;
ALTER TABLE comments AUTO_INCREMENT 	 = 70000;
ALTER TABLE report AUTO_INCREMENT 		 = 80000;
ALTER TABLE follow AUTO_INCREMENT 		 = 90000;
ALTER TABLE follow AUTO_INCREMENT 		 = 100000;
ALTER TABLE alarm AUTO_INCREMENT 		 = 110000;
ALTER TABLE payment AUTO_INCREMENT 		 = 120000;
ALTER TABLE withdraw AUTO_INCREMENT 	 = 130000;
ALTER TABLE event AUTO_INCREMENT 	 	 = 140000;
ALTER TABLE history AUTO_INCREMENT 	 	 = 150000;

INSERT
INTO categories (category_id, category_name, category_img)
VALUES (category_id, '일러스트레이션', 'category01.jpg');

INSERT
INTO categories (category_id, category_name, category_img)
VALUES (category_id, '그래픽디자인', 'category02.jpg');

INSERT
INTO categories (category_id, category_name, category_img)
VALUES (category_id, '건축', 'category03.jpg');

INSERT
INTO categories (category_id, category_name, category_img)
VALUES (category_id, '제품디자인', 'category04.jpg');

INSERT
INTO categories (category_id, category_name, category_img)
VALUES (category_id, '패션', 'category05.jpg');

INSERT
INTO categories (category_id, category_name, category_img)
VALUES (category_id, '광고', 'category06.jpg');

INSERT
INTO categories (category_id, category_name, category_img)
VALUES (category_id, '포토그래피', 'category07.jpg');

INSERT
INTO categories (category_id, category_name, category_img)
VALUES (category_id, '미술', 'category08.jpg');

INSERT
INTO categories (category_id, category_name, category_img)
VALUES (category_id, '게임디자인', 'category09.jpg');

INSERT
INTO categories (category_id, category_name, category_img)
VALUES (category_id, '공예', 'category10.jpg');

INSERT
INTO categories (category_id, category_name, category_img)
VALUES (category_id, '타이포그래피', 'category11.jpg');

INSERT
INTO categories (category_id, category_name, category_img)
VALUES (category_id, 'UI/UX', 'category12.jpg');

INSERT
INTO categories (category_id, category_name, category_img)
VALUES (category_id, 'RECOMMEND', 'recommend.jpg');


INSERT
INTO users (user_code, user_name, password, role, profile_img, state, reg_date)
VALUES ('admin', '관리자', '1234', 'admin', 'profile_img.jpg', 0, NOW());

INSERT
INTO users (user_code, user_name, password, role, profile_img, self_introduce, state, prime_count, reg_date)
VALUES ('user01', 'atom', '1111', 'business', 'profile_img.jpg', 'Hellow. my name is Atom!', 0, 1000, NOW());

INSERT
INTO users (user_code, user_name, password, role, profile_img, self_introduce, state, prime_count, reg_date)
VALUES ('user02', 'afternoon', '2222', 'user', 'profile_img.jpg', 'Hellow. my name is Atom!', 0, 0, NOW());

INSERT
INTO users (user_code, user_name, password, role, profile_img, self_introduce, state, prime_count, reg_date)
VALUES ('user03', 'bench', '3333', 'user', 'profile_img.jpg', 'Hellow. my name is Atom!', 0, 0, NOW());

INSERT
INTO users (user_code, user_name, password, role, profile_img, self_introduce, state, prime_count, reg_date)
VALUES ('user04', 'bus', '4444', 'user', 'profile_img.jpg', 'Hellow. my name is Atom!', 0, 0, NOW());

INSERT
INTO users (user_code, user_name, password, role, profile_img, self_introduce, state, prime_count, reg_date)
VALUES ('user05', 'cake', '5555', 'business', 'profile_img.jpg', 'Hellow. my name is Atom!', 0, 1000, NOW());

INSERT
INTO users (user_code, user_name, password, role, profile_img, self_introduce, state, prime_count, reg_date)
VALUES ('user06', 'cassette', '6666', 'business', 'profile_img.jpg', 'Hellow. my name is Atom!', 0, 1000, NOW());

INSERT
INTO users (user_code, user_name, password, role, profile_img, self_introduce, state, prime_count, reg_date)
VALUES ('user07', 'chopstick', '7777', 'user', 'profile_img.jpg', 'Hellow. my name is Atom!', 0, 0, NOW());

INSERT
INTO users (user_code, user_name, password, role, profile_img, self_introduce, state, prime_count, reg_date)
VALUES ('user08', 'diary', '8888', 'user', 'profile_img.jpg', 'Hellow. my name is Atom!', 0, 0, NOW());

INSERT
INTO users (user_code, user_name, password, role, profile_img, self_introduce, state, prime_count, reg_date)
VALUES ('user09', 'dish', '9999', 'user', 'profile_img.jpg', 'Hellow. my name is Atom!', 0, 0, NOW());

INSERT
INTO users (user_code, user_name, password, role, profile_img, self_introduce, state, prime_count, reg_date)
VALUES ('user10', 'door', '1010', 'business', 'profile_img.jpg', 'Hellow. my name is Atom!', 0, 1000, NOW());

INSERT
INTO users (user_code, user_name, password, role, profile_img, self_introduce, state, prime_count, reg_date)
VALUES ('user11', 'echo', '1111', 'user', 'profile_img.jpg', 'Hellow. my name is Atom!', 0, 0, NOW());

INSERT
INTO users (user_code, user_name, password, role, profile_img, self_introduce, state, prime_count, reg_date)
VALUES ('user12', 'farm', '1212', 'user', 'profile_img.jpg', 'Hellow. my name is Atom!', 0, 0, NOW());

INSERT
INTO users (user_code, user_name, password, role, profile_img, self_introduce, state, prime_count, reg_date)
VALUES ('user13', 'grass', '1313', 'user', 'profile_img.jpg', 'Hellow. my name is Atom!', 0, 0, NOW());

INSERT
INTO users (user_code, user_name, password, role, profile_img, self_introduce, state, prime_count, reg_date)
VALUES ('user14', 'atom14', '1414', 'business', 'profile_img.jpg', 'Hellow. my name is Atom!', 0, 1000, NOW());

INSERT
INTO users (user_code, user_name, password, role, profile_img, self_introduce, state, prime_count, reg_date)
VALUES ('user15', 'door', '1515', 'user', 'profile_img.jpg', 'Hellow. my name is Atom!', 0, 0, NOW());

INSERT
INTO users (user_code, user_name, password, role, profile_img, self_introduce, state, prime_count, reg_date)
VALUES ('user16', 'hat', '1616', 'user', 'profile_img.jpg', 'Hellow. my name is Atom!', 0, 0, NOW());

INSERT
INTO users (user_code, user_name, password, role, profile_img, self_introduce, state, prime_count, reg_date)
VALUES ('user17', 'jet', '1717', 'business', 'profile_img.jpg', 'Hellow. my name is Atom!', 0, 1000, NOW());

INSERT
INTO users (user_code, user_name, password, role, profile_img, self_introduce, state, prime_count, reg_date)
VALUES ('user18', 'kitchen', '1818', 'user', 'profile_img.jpg', 'Hellow. my name is Atom!', 0, 0, NOW());

INSERT
INTO users (user_code, user_name, password, role, profile_img, self_introduce, state, prime_count, reg_date)
VALUES ('user19', 'lion', '1919', 'user', 'profile_img.jpg', 'Hellow. my name is Atom!', 0, 0, NOW());

INSERT
INTO users (user_code, user_name, password, role, profile_img, self_introduce, state, prime_count, reg_date, ban_date)
VALUES ('user20', 'night', '2020', 'user', 'profile_img.jpg', 'Hellow. my name is night!', 2, 0, NOW(), NOW());










INSERT
INTO feeds (feed_id, feed_title, feed_explanation, user_code, feed_reg_date, feed_is_prime, category_id)
VALUES(20000, 'After Opportunity', 'After Opportunity centres on the curatorial concept of an exhibition on paper.', 'user01', NOW(), 1, 10003);

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20000, 0, 1,'feed01_thumbnail.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20000, 0, 0,'feed01_1.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20000, 1, 0,'feed01_2.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20000, 2, 0,'feed01_3.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20000, 3, 0,'feed01_4.jpg');

INSERT
INTO feeds (feed_id, feed_title, feed_explanation, user_code, feed_reg_date, feed_is_prime, category_id)
VALUES(20001, 'Art Direction', 'A mix of images I art directed across multiple studios.', 'user01', NOW(), 1, 10003);

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20001, 0, 1,'feed02_thumbnail.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20001, 0, 0,'feed02_1.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20001, 1, 0,'feed02_2.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20001, 2, 0,'feed02_3.jpg');

INSERT
INTO feeds (feed_id, feed_title, feed_explanation, user_code, feed_reg_date, feed_is_prime, category_id)
VALUES(20002, 'From the streets of Kathmandu', '', 'user02', NOW(), 1, 10006);

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20002, 0, 1,'feed03_thumbnail.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20002, 0, 0,'feed03_1.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20002, 1, 0,'feed03_2.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20002, 2, 0,'feed03_3.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20002, 3, 0,'feed03_4.jpg');

INSERT
INTO feeds (feed_id, feed_title, feed_explanation, user_code, feed_reg_date, feed_is_prime, category_id)
VALUES(20003, 'TOXIC FASHION', 'Our new series Toxic Fashion dramatizes how impacted we all are from poisonous substances used in the fast fashion textile industry.', 'user02', NOW(), 0, 10006);

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20003, 0, 1,'feed04_thumbnail.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20003, 0, 0,'feed04_1.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20003, 1, 0,'feed04_2.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20003, 2, 0,'feed04_3.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20003, 3, 0,'feed04_4.jpg');

INSERT
INTO feeds (feed_id, feed_title, feed_explanation, user_code, feed_reg_date, feed_is_prime, category_id)
VALUES(20004, 'Kiss me', ' ', 'user03', NOW(), 0, 10004);

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20004, 0, 1,'feed05_thumbnail.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20004, 0, 0,'feed05_1.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20004, 1, 0,'feed05_2.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20004, 2, 0,'feed05_3.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20004, 3, 0,'feed05_4.jpg');

INSERT
INTO feeds (feed_id, feed_title, feed_explanation, user_code, feed_reg_date, feed_is_prime, category_id)
VALUES(20005, 'Sheriff Colt', ' ', 'user04', NOW(), 0, 10008);

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20005, 0, 1,'feed06_thumbnail.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20005, 0, 0,'feed06_1.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20005, 1, 0,'feed06_2.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20005, 2, 0,'feed06_3.jpg');

INSERT
INTO feeds (feed_id, feed_title, feed_explanation, user_code, feed_reg_date, feed_is_prime, category_id)
VALUES(20006, 'House no. 337', 'House no. 337 Project and viz.: author', 'user04', NOW(), 0, 10002);

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20006, 0, 1,'feed07_thumbnail.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20006, 0, 0,'feed07_01.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20006, 1, 0,'feed07_02.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20006, 2, 0,'feed07_03.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20006, 3, 0,'feed07_04.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20006, 4, 0,'feed07_05.jpg');

INSERT
INTO feeds (feed_id, feed_title, feed_explanation, user_code, feed_reg_date, feed_is_prime, category_id)
VALUES(20007, 'Vanke Future Town Pavillion in Xuzhou', 'This is a personal project focus on the recreation of existing photos depict Vanke Future Town Pavillion in Xuzhou designed by Continuation Studio and photographed by SHIROMIO Studio.', 'user04', NOW(), 0, 10002);

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20007, 0, 1,'feed08_thumbnail.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20007, 0, 0,'feed08_01.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20007, 1, 0,'feed08_02.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20007, 2, 0,'feed08_03.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20007, 3, 0,'feed08_04.jpg');

INSERT
INTO feeds (feed_id, feed_title, feed_explanation, user_code, feed_reg_date, feed_is_prime, category_id)
VALUES(20008, 'MITI CHIVA', 'LANDSCAPE ARCHITECT : STUDIOJEDT', 'user04', NOW(), 0, 10002);

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20008, 0, 1,'feed09_thumbnail.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20008, 0, 0,'feed09_01.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20008, 0, 0,'feed09_02.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20008, 0, 0,'feed09_03.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20008, 0, 0,'feed09_04.jpg');

INSERT
INTO feeds (feed_id, feed_title, feed_explanation, user_code, feed_reg_date, feed_is_prime, category_id)
VALUES(20009, 'Modern Shipping Container Home', 'Modern Shipping Container Modular Home created by DEER Design', 'user04', NOW(), 0, 10002);

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20009, 0, 1,'feed10_thumbnail.jpg');	

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20009, 0, 0,'feed10_01.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20009, 1, 0,'feed10_02.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20009, 2, 0,'feed10_03.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20009, 3, 0,'feed10_04.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20009, 4, 0,'feed10_05.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20009, 5, 0,'feed10_06.jpg');

INSERT
INTO feeds (feed_id, feed_title, feed_explanation, user_code, feed_reg_date, feed_is_prime, category_id)
VALUES(20010, 'Extreme Sports', ' ', 'user05', NOW(), 0, 10000);

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20010, 0, 1,'feed11_thumbnail.jpg');	

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20010, 0, 0,'feed11_01.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20010, 1, 0,'feed11_02.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20010, 2, 0,'feed11_03.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20010, 3, 0,'feed11_04.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20010, 4, 0,'feed11_05.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20010, 4, 0,'feed11_06.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20010, 4, 0,'feed11_07.jpg');


INSERT
INTO feeds (feed_id, feed_title, feed_explanation, user_code, feed_reg_date, feed_is_prime, category_id)
VALUES(20011, 'The Lonely Astronaut', 'The Lonely Astronaut. Photos by photographer Karen Jerzyk from 2017-Present.', 'user05', NOW(), 0, 10006);

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20011, 0, 1,'feed12_thumbnail.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20011, 0, 0,'feed12_01.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20011, 1, 0,'feed12_02.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20011, 2, 0,'feed12_03.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20011, 3, 0,'feed12_04.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20011, 4, 0,'feed12_05.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20011, 5, 0,'feed12_06.jpg');

INSERT
INTO feeds (feed_id, feed_title, feed_explanation, user_code, feed_reg_date, feed_is_prime, category_id)
VALUES(20012, 'BB', 'Project is questioning our life in a simulation for 4 years. Since then it has been seen in Tokyo, Beijing...', 'user03', NOW(), 0, 10006);

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20012, 0, 1,'feed13_thumbnail.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20012, 0, 0,'feed13_01.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20012, 1, 0,'feed13_02.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20012, 2, 0,'feed13_03.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20012, 3, 0,'feed13_04.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20012, 4, 0,'feed13_05.jpg');

INSERT
INTO feeds (feed_id, feed_title, feed_explanation, user_code, feed_reg_date, feed_is_prime, category_id)
VALUES(20013, 'A LOVE LETTER TO ICELAND / Iceland From Above VII.', 'Dear Iceland, <br>you know how much I love you. You gave me so much in the last 5 years. A reason to believe, a new passion and new friendships. Every summer I just waited to touchdown in Keflavík to finally admire your natural beauty again.', 'user02', NOW(), 0, 10006);

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20013, 0, 1,'feed14_thumbnail.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20013, 0, 0,'feed14_01.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20013, 1, 0,'feed14_02.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20013, 2, 0,'feed14_03.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20013, 3, 0,'feed14_04.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20013, 4, 0,'feed14_05.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20013, 5, 0,'feed14_06.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20013, 6, 0,'feed14_07.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20013, 7, 0,'feed14_08.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20013, 8, 0,'feed14_09.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20013, 9, 0,'feed14_10.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20013, 10, 0,'feed14_11.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20013, 11, 0,'feed14_12.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20013, 12, 0,'feed14_13.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20013, 13, 0,'feed14_14.jpg');


INSERT
INTO feeds (feed_id, feed_title, feed_explanation, user_code, feed_reg_date, feed_is_prime, category_id)
VALUES(20014, 'INONICA MAGAZINE - ISSUE 01', 'Inonica is a virtual gallery on IG and this is the first issue of his new indipendent magazine about graphic design, photography,<br>illustration and fine arts. The aim of this project is to give visibility to the artists of the community and to support their works.', 'user01', NOW(), 0, 10001);

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20014, 0, 1,'feed15_thumbnail.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20014, 0, 0,'feed15_01.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20014, 1, 0,'feed15_02.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20014, 2, 0,'feed15_03.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20014, 3, 0,'feed15_04.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20014, 4, 0,'feed15_05.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20014, 5, 0,'feed15_06.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20014, 6, 0,'feed15_07.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20014, 7, 0,'feed15_08.jpg');

INSERT
INTO feeds (feed_id, feed_title, feed_explanation, user_code, feed_reg_date, feed_is_prime, category_id)
VALUES(20015, 'Mix Code', 'Mix Code混合編碼工作室   品牌識別更新設計', 'user03', NOW(), 0, 10001);

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20015, 0, 1,'feed16_thumbnail.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20015, 0, 0,'feed16_01.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20015, 1, 0,'feed16_02.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20015, 2, 0,'feed16_03.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20015, 3, 0,'feed16_04.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20015, 4, 0,'feed16_05.jpg');

INSERT
INTO feeds (feed_id, feed_title, feed_explanation, user_code, feed_reg_date, feed_is_prime, category_id)
VALUES(20016, 'NB Akademie Pro Test (MMXX Edition)', 'Four years after the successful release of NB Akademie™ Std Editon in 2016<br> the typeset got expanded with 12 additional typesets and an OpenType Pro Edition supporting 110+ latin based languages.', 'user02', NOW(), 0, 10010);

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20016, 0, 1,'feed17_thumbnail.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20016, 0, 0,'feed17_01.gif');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20016, 1, 0,'feed17_02.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20016, 2, 0,'feed17_03.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20016, 3, 0,'feed17_04.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20016, 4, 0,'feed17_05.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20016, 5, 0,'feed17_06.jpg');

INSERT
INTO feeds (feed_id, feed_title, feed_explanation, user_code, feed_reg_date, feed_is_prime, category_id)
VALUES(20017, 'HATSU BEYONDCOLOR', '', 'user01', NOW(), 0, 10005);

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20017, 0, 1,'feed18_thumbnail.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20017, 0, 0,'feed18_01.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20017, 1, 0,'feed18_02.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20017, 2, 0,'feed18_03.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20017, 3, 0,'feed18_04.jpg');

INSERT
INTO feeds (feed_id, feed_title, feed_explanation, user_code, feed_reg_date, feed_is_prime, category_id)
VALUES(20018, 'summer paintings01', '', 'user05', NOW(), 0, 10007);

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20018, 0, 1,'feed19_thumbnail.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20018, 0, 0,'feed19_01.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20018, 1, 0,'feed19_02.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20018, 2, 0,'feed19_03.jpg');

INSERT
INTO feeds (feed_id, feed_title, feed_explanation, user_code, feed_reg_date, feed_is_prime, category_id)
VALUES(20019, 'summer paintings02', '', 'user05', NOW(), 0, 10007);

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20019, 0, 1,'feed20_thumbnail.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20019, 0, 0,'feed20_01.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20019, 1, 0,'feed20_02.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20019, 2, 0,'feed20_03.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20019, 3, 0,'feed20_04.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20019, 4, 0,'feed20_05.jpg');


INSERT
INTO feeds (feed_id, feed_title, feed_explanation, user_code, feed_reg_date, feed_is_prime, category_id)
VALUES(20020, 'Neumorphism icons', '', 'user03', NOW(), 0, 10011);

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20020, 0, 1,'feed21_thumbnail.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20020, 0, 0,'feed21_01.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20020, 1, 0,'feed21_02.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20020, 2, 0,'feed21_03.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20020, 3, 0,'feed21_04.jpg');


INSERT
INTO feeds (feed_id, feed_title, feed_explanation, user_code, feed_reg_date, feed_is_prime, category_id)
VALUES(20021, '36 Days of Type 2017/18', 'I ve created some letters and numbers for a new round of awesome 36 Days of Type project, not a whole alphabet unfortunately :) ', 'user01', NOW(), 0, 10011);

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20021, 0, 1,'feed22_thumbnail.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20021, 0, 0,'feed22_01.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20021, 1, 0,'feed22_02.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20021, 2, 0,'feed22_03.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20021, 3, 0,'feed22_04.jpg');

INSERT
INTO feeds (feed_id, feed_title, feed_explanation, user_code, feed_reg_date, feed_is_prime, category_id)
VALUES(20022, 'The Atlantic – The Possibility Report', 'A series of illustrations I did for The Atlantic’s Possibility report titled ‘Build’.', 'user01', NOW(), 0, 10000);

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20022, 0, 1,'feed23_thumbnail.png');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20022, 0, 0,'feed23_01.png');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20022, 1, 0,'feed23_02.png');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20022, 2, 0,'feed23_03.png');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20022, 3, 0,'feed23_04.png');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20022, 4, 0,'feed23_05.png');


INSERT
INTO feeds (feed_id, feed_title, feed_explanation, user_code, feed_reg_date, feed_is_prime, category_id)
VALUES(20050, 'Flowers Decoration', 'Do not be silly in front of those flowers', 'user06', NOW(), 1, 10009);

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20050, 0, 1,'feed51_thumbnail.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20050,  0, 0,'feed51_1.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20050,  1, 0,'feed51_2.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20050,  2, 0,'feed51_3.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20050,  3, 0,'feed51_4.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20050, 4, 0,'feed51_5.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20050, 5, 0,'feed51_6.jpg');

INSERT
INTO feeds (feed_id, feed_title, feed_explanation, user_code, feed_reg_date, feed_is_prime, category_id)
VALUES(20051, 'Coffee and Desert', 'Spring desert', 'user06', NOW(), 0, 10006);

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20051, 0, 1,'feed52_thumbnail.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20051, 0, 0,'feed52_1.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20051, 1, 0,'feed52_2.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20051, 2, 0,'feed52_3.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20051, 3, 0,'feed52_4.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20051, 4, 0,'feed52_5.jpg');

INSERT
INTO feeds (feed_id, feed_title, feed_explanation, user_code, feed_reg_date, feed_is_prime, category_id)
VALUES(20052, 'Cameras', '촬영 장비들', 'user06', NOW(), 1, 10006);

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20052, 0, 1,'feed53_thumbnail.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20052, 0, 0,'feed53_1.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20052, 1, 0,'feed53_2.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20052, 2, 0,'feed53_3.jpg');

INSERT
INTO feeds (feed_id, feed_title, feed_explanation, user_code, feed_reg_date, feed_is_prime, category_id)
VALUES(20053, '영국 디저트 - 딸기', '봄에 제격인 딸기 디저트 모음', 'user06', NOW(), 0, 10006);

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20053, 0, 1,'feed54_thumbnail.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20053, 0, 0,'feed54_1.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20053, 1, 0,'feed54_2.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20053, 2, 0,'feed54_3.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20053, 3, 0,'feed54_4.jpg');

INSERT
INTO feeds (feed_id, feed_title, feed_explanation, user_code, feed_reg_date, feed_is_prime, category_id)
VALUES(20054, '세계의 술', 'the bottles', 'user06', NOW(), 0, 10006);

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20054, 0, 1,'feed55_thumbnail.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20054, 0, 0,'feed55_1.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20054, 1, 0,'feed55_2.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20054, 2, 0,'feed55_3.jpg');

INSERT
INTO feeds (feed_id, feed_title, feed_explanation, user_code, feed_reg_date, feed_is_prime, category_id)
VALUES(20055, '도시', 'cities light and dark', 'user06', NOW(), 0, 10006);

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20055, 0, 1,'feed56_thumbnail.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20055, 0, 0,'feed56_1.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20055, 1, 0,'feed56_2.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20055, 2, 0,'feed56_3.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20055, 3, 0,'feed56_4.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20055, 4, 0,'feed56_5.jpg');

INSERT
INTO feeds (feed_id, feed_title, feed_explanation, user_code, feed_reg_date, feed_is_prime, category_id)
VALUES(20056, 'In my studio', 'my treasure', 'user06', NOW(), 0, 10006);

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20056, 0, 1,'feed57_thumbnail.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES (image_id, 20056, 0, 0,'feed57_1.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES (image_id, 20056, 1, 0,'feed57_2.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20056, 2, 0,'feed57_3.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES (image_id, 20056, 3, 0,'feed57_4.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES (image_id, 20056, 4, 0,'feed57_5.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES (image_id, 20056, 5, 0,'feed57_6.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES (image_id, 20056, 6, 0,'feed57_7.jpg');

INSERT
INTO feeds(feed_id, feed_title, feed_explanation, user_code, feed_reg_date, feed_is_prime, category_id)
VALUES (20057, 'CityLife', 'Hello LA',	'User06', Now(), 1, 10000);

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES (	image_id,	20057, 0, 1, 'feed58_thumbnail.jpg' );			

INSERT	
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES (	image_id,	20057, 0,	0, 'feed58_01.jpg' );		

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES (	image_id,	20057, 1,	0, 'feed58_02.jpg' );	

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(	image_id,	20057, 2,	0, 'feed58_03.jpg'	);		

INSERT 
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(	image_id,	20057, 3,	0, 'feed58_04.jpg'	);			

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(	image_id,	20057, 4,	0, 'feed58_05.jpg'	);


INSERT
INTO	feeds(feed_id, feed_title, feed_explanation, user_code, feed_reg_date, feed_is_prime, category_id)
VALUES(	20058,	'ALICE',	'IN WONDERLAND',	'User06',	Now(),	1,	10007	);

INSERT
INTO	images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(	image_id,	20058,	0,	1,	'feed59_thumbnail.jpg'	);			

INSERT
INTO	images (image_id, feed_id, feed_order, is_thumbnail, image_file)	
VALUES(	image_id,	20058,	0,	0,	'feed59_01.jpg'	);			

INSERT
INTO	images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(	image_id,	20058,	1,	0,	'feed59_02.jpg'	);			

INSERT
INTO	images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(	image_id,	20058,	2,	0,	'feed59_03.jpg'	);


INSERT
INTO	feeds(feed_id, feed_title, feed_explanation, user_code, feed_reg_date, feed_is_prime, category_id)
VALUES(	20059,	'PORCHE 911',	'CONCEPT DESIGN',	'User06',	Now(),	1,	10003	)	;

INSERT
INTO	images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(	image_id,	20059,	0,	1,	'feed60_thumbnail.jpg'	);		

INSERT
INTO	images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(	image_id,	20059,	0,	0,	'feed60_01.jpg'	);		

INSERT	
INTO	images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(	image_id,	20059,	1,	0,	'feed60_02.jpg'	);			

INSERT
INTO	images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(	image_id,	20059,	2,	0,	'feed60_03.jpg'	);

INSERT	
INTO	images (image_id, feed_id, feed_order, is_thumbnail, image_file)	
VALUES(	image_id,	20059,	3,	0,	'feed60_04.jpg'	);		

INSERT
INTO	images (image_id, feed_id, feed_order, is_thumbnail, image_file)	
VALUES(	image_id,	20059,	4,	0,	'feed60_05.jpg'	);			

INSERT	
INTO	images (image_id, feed_id, feed_order, is_thumbnail, image_file)	
VALUES(	image_id,	20059,	5,	0,	'feed60_06.jpg'	);			

INSERT	
INTO	images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(	image_id,	20059,	6,	0,	'feed60_07.jpg'	);			

INSERT	
INTO	images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(	image_id,	20059,	7,	0,	'feed60_08.jpg'	);			


INSERT	
INTO	feeds(feed_id, feed_title, feed_explanation, user_code, feed_reg_date, feed_is_prime, category_id)
VALUES(	20060,	'BRAND NEW HOUSE',	'NEXT IN MORDERN APARTMENT',	'User07',	Now(),	1,	10002	)	;

INSERT
INTO	images (image_id, feed_id, feed_order, is_thumbnail, image_file)	
VALUES(	image_id,	20060,	0,	1,	'feed61_thumbnail.jpg'	);	

INSERT	
INTO	images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(	image_id,	20060,	0,	0,	'feed61_01.jpg'	);		

INSERT	
INTO	images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(	image_id,	20060,	1,	0,	'feed61_02.jpg'	);		

INSERT
INTO	images (image_id, feed_id, feed_order, is_thumbnail, image_file)	
VALUES(	image_id,	20060,	2,	0,	'feed61_03.jpg'	);	

INSERT	
INTO	images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(	image_id,	20060,	3,	0,	'feed61_04.jpg'	);	

INSERT	
INTO	images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(	image_id,	20060,	4,	0,	'feed61_05.jpg'	);	

INSERT
INTO	images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(	image_id,	20060,	5,	0,	'feed61_06.jpg'	);		

INSERT
INTO	images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(	image_id,	20060,	6,	0,	'feed61_07.jpg'	);			

INSERT
INTO	images (image_id, feed_id, feed_order, is_thumbnail, image_file)	
VALUES(	image_id,	20060,	7,	0,	'feed61_08.jpg'	);	

INSERT
INTO	images (image_id, feed_id, feed_order, is_thumbnail, image_file)	
VALUES(	image_id,	20060,	8,	0,	'feed61_09.jpg'	);	


INSERT	
INTO	feeds(feed_id, feed_title, feed_explanation, user_code, feed_reg_date, feed_is_prime, category_id)	
VALUES(	20061,	'Clay City Characters',	'Moodies',	'User07',	Now(),	1,	10000	);

INSERT	
INTO	images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(	image_id,	20061,	0,	1,	'feed62_thumbnail.jpg'	);			

INSERT
INTO	images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(	image_id,	20061,	0,	0,	'feed62_01.png'	);			

INSERT
INTO	images (image_id, feed_id, feed_order, is_thumbnail, image_file)	
VALUES(	image_id,	20061,	1,	0,	'feed62_02.png'	);	

INSERT
INTO	images (image_id, feed_id, feed_order, is_thumbnail, image_file)	
VALUES(	image_id,	20061,	2,	0,	'feed62_03.png'	);			

INSERT	
INTO	images (image_id, feed_id, feed_order, is_thumbnail, image_file)	
VALUES(	image_id,	20061,	3,	0,	'feed62_04.png'	);			

INSERT	
INTO	images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(	image_id,	20061,	4,	0,	'feed62_05.png'	);			

INSERT	
INTO	images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(	image_id,	20061,	5,	0,	'feed62_06.png'	);			

INSERT
INTO	images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(	image_id,	20061,	6,	0,	'feed62_07.png'	);	

INSERT	
INTO	images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(	image_id,	20061,	7,	0,	'feed62_08.png'	);			


INSERT
INTO	feeds(feed_id, feed_title, feed_explanation, user_code, feed_reg_date, feed_is_prime, category_id)
VALUES(	20062,	'BMW Urbanage',	'BMW series',	'User07',	Now(),	1,	10003	);

INSERT
INTO	images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(	image_id,	20062,	0,	1,	'feed63_thumbnail.jpg'	);			

INSERT	
INTO	images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(	image_id,	20062,	0,	0,	'feed63_01.jpg'	);			

INSERT	
INTO	images (image_id, feed_id, feed_order, is_thumbnail, image_file)	
VALUES(	image_id,	20062,	1,	0,	'feed63_02.jpg'	);			

INSERT
INTO	images (image_id, feed_id, feed_order, is_thumbnail, image_file)	
VALUES(	image_id,	20062,	2,	0,	'feed63_03.jpg'	);

INSERT	
INTO	images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(	image_id,	20062,	3,	0,	'feed63_04.jpg'	);			

INSERT	
INTO	images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(	image_id,	20062,	4,	0,	'feed63_05.jpg'	);		

INSERT	
INTO	images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(	image_id,	20062,	5,	0,	'feed63_06.jpg'	);			

INSERT	
INTO	images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(	image_id,	20062,	6,	0,	'feed63_07.jpg'	);		


INSERT	
INTO	feeds(feed_id, feed_title, feed_explanation, user_code, feed_reg_date, feed_is_prime, category_id)	
VALUES(	20063,	'노르웨이 아파트',	'노르웨이 모던 아파트 디자인',	'User07',	Now(),	1,	10002	)	;

INSERT	
INTO	images (image_id, feed_id, feed_order, is_thumbnail, image_file)	
VALUES(	image_id,	20063,	0,	1,	'feed64_thumbnail.jpg'	);			

INSERT
INTO	images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(	image_id,	20063,	0,	0,	'feed64_01.jpg'	);			

INSERT
INTO	images (image_id, feed_id, feed_order, is_thumbnail, image_file)	
VALUES(	image_id,	20063,	1,	0,	'feed64_02.jpg'	);			

INSERT	
INTO	images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(	image_id,	20063,	2,	0,	'feed64_03.jpg'	);			

INSERT	
INTO	images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(	image_id,	20063,	3,	0,	'feed64_04.jpg'	);			

INSERT	
INTO	images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(	image_id,	20063,	4,	0,	'feed64_05.jpg'	);			

INSERT	
INTO	images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(	image_id,	20063,	5,	0,	'feed64_06.jpg'	);



INSERT	
INTO	feeds(feed_id, feed_title, feed_explanation, user_code, feed_reg_date, feed_is_prime, category_id)	
VALUES(	20064,	'만드는 사람들',	'무언가를 만드는 사람들을 만났다',	'User07',	Now(),	1,	10009	);

INSERT	
INTO	images (image_id, feed_id, feed_order, is_thumbnail, image_file)	
VALUES(	image_id,	20064,	0,	1,	'feed65_thumbnail.jpg'	);			

INSERT
INTO	images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(	image_id,	20064,	0,	0,	'feed65_01.jpg'	);			

INSERT	
INTO	images (image_id, feed_id, feed_order, is_thumbnail, image_file)	
VALUES(	image_id,	20064,	1,	0,	'feed65_02.jpg'	);			

INSERT
INTO	images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(	image_id,	20064,	2,	0,	'feed65_03.jpg'	);			

INSERT
INTO	images (image_id, feed_id, feed_order, is_thumbnail, image_file)	
VALUES(	image_id,	20064,	3,	0,	'feed65_04.jpg'	);	

INSERT	
INTO	images (image_id, feed_id, feed_order, is_thumbnail, image_file)	
VALUES(	image_id,	20064,	4,	0,	'feed65_05.jpg'	);			

INSERT
INTO	images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(	image_id,	20064,	5,	0,	'feed65_06.jpg'	);			

INSERT
INTO	images (image_id, feed_id, feed_order, is_thumbnail, image_file)	
VALUES(	image_id,	20064,	6,	0,	'feed65_07.jpg'	);		

INSERT	
INTO	images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(	image_id,	20064,	7,	0,	'feed65_08.png'	);			

INSERT
INTO	images (image_id, feed_id, feed_order, is_thumbnail, image_file)	
VALUES(	image_id,	20064,	8,	0,	'feed65_09.png'	);		

INSERT
INTO	feeds(feed_id, feed_title, feed_explanation, user_code, feed_reg_date, feed_is_prime, category_id)	
VALUES(	20065,	'Under the moon',	'War and the girl sitting besides river',	'User07',	Now(),	1,	10007	);

INSERT	
INTO	images (image_id, feed_id, feed_order, is_thumbnail, image_file)	
VALUES(	image_id,	20065,	0,	1,	'feed66_thumbnail.jpg'	);			

INSERT
INTO	images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(	image_id,	20065,	0,	0,	'feed66_01.jpg'	);			

INSERT
INTO	images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(	image_id,	20065,	1,	0,	'feed66_02.jpg'	);	



INSERT	
INTO	feeds(feed_id, feed_title, feed_explanation, user_code, feed_reg_date, feed_is_prime, category_id)	
VALUES(	20066,	'Home sweet Home',	'oilpainting',	'User07',	Now(),	1,	10007	);

INSERT	
INTO	images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(	image_id,	20066,	0,	1,	'feed67_thumbnail.jpg'	);			

INSERT
INTO	images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(	image_id,	20066,	0,	0,	'feed67_01.jpg'	);		

INSERT	
INTO	images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(	image_id,	20066,	1,	0,	'feed67_02.jpg'	);	

INSERT
INTO	images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(	image_id,	20066,	2,	0,	'feed67_03.jpg'	);	

INSERT	
INTO	images (image_id, feed_id, feed_order, is_thumbnail, image_file)	
VALUES(	image_id,	20066,	3,	0,	'feed67_04.jpg'	);	

INSERT
INTO	images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(	image_id,	20066,	4,	0,	'feed67_05.jpg'	);	


INSERT	
INTO	feeds(feed_id, feed_title, feed_explanation, user_code, feed_reg_date, feed_is_prime, category_id)
VALUES(	20067,	'Amazing landscape',	'on the moon',	'User07',	Now(),	1,	10006	);

INSERT	
INTO	images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(	image_id,	20067,	0,	1,	'feed68_thumbnail.jpg'	);	

INSERT
INTO	images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(	image_id,	20067,	0,	0,	'feed68_01.jpg'	);	

INSERT	
INTO	images (image_id, feed_id, feed_order, is_thumbnail, image_file)	
VALUES(	image_id,	20067,	1,	0,	'feed68_02.jpg'	);	

INSERT	
INTO	images (image_id, feed_id, feed_order, is_thumbnail, image_file)	
VALUES(	image_id,	20067,	2,	0,	'feed68_03.jpg'	);	

INSERT	
INTO	images (image_id, feed_id, feed_order, is_thumbnail, image_file)	
VALUES(	image_id,	20067,	3,	0,	'feed68_04.jpg'	);	

INSERT	
INTO	images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(	image_id,	20067,	4,	0,	'feed68_05.jpg'	);	


INSERT
INTO feeds (feed_id, feed_title, feed_explanation, user_code, feed_reg_date, feed_is_prime, category_id)
VALUES(20100, '구조물', '물과구조물 ', 'user11', NOW(), 0, 10006);

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20100, 0, 1,'feed101_thumbnail.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20100, 0, 0,'feed101_1.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20100, 1, 0,'feed101_2.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20100, 2, 0,'feed101_3.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20100, 3, 0,'feed101_4.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20100, 4, 0,'feed101_5.jpg');


INSERT
INTO feeds (feed_id, feed_title, feed_explanation, user_code, feed_reg_date, feed_is_prime, category_id)
VALUES(20101, '물과여자', '물과사람 ', 'user12', NOW(), 0, 10006);

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20101, 0, 1,'feed102_thumbnail.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20101, 0, 0,'feed102_1.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20101, 1, 0,'feed102_2.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20101, 2, 0,'feed102_3.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20101, 3, 0,'feed102_4.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20101, 4, 0,'feed102_5.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20101, 5, 0,'feed102_6.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20101, 6, 0,'feed102_7.jpg');

INSERT
INTO feeds (feed_id, feed_title, feed_explanation, user_code, feed_reg_date, feed_is_prime, category_id)
VALUES(20102, '구조물', '물과구조물 ', 'user13', NOW(), 0, 10006);

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20102, 0, 1,'feed103_thumbnail.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20102, 0, 0,'feed103_1.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20102, 1, 0,'feed103_2.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20102, 2, 0,'feed103_3.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20102, 3, 0,'feed103_4.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20102, 4, 0,'feed103_5.jpg');


INSERT
INTO feeds (feed_id, feed_title, feed_explanation, user_code, feed_reg_date, feed_is_prime, category_id)
VALUES(20103, 'people inside', '인물사진 ', 'user14', NOW(), 0, 10006);

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20103, 0, 1,'feed104_thumbnail.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20103, 0, 0,'feed104_1.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20103, 1, 0,'feed104_2.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20103, 2, 0,'feed104_3.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20103, 3, 0,'feed104_4.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20103, 4, 0,'feed104_5.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20103, 5, 0,'feed104_6.jpg');


INSERT
INTO feeds (feed_id, feed_title, feed_explanation, user_code, feed_reg_date, feed_is_prime, category_id)
VALUES(20104, '노인', '노인과 담배 ', 'user15', NOW(), 0, 10006);

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20104, 0, 1,'feed105_thumbnail.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20104, 0, 0,'feed105_1.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20104, 1, 0,'feed105_2.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20104, 2, 0,'feed105_3.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20104, 3, 0,'feed105_4.jpg');

INSERT
INTO feeds (feed_id, feed_title, feed_explanation, user_code, feed_reg_date, feed_is_prime, category_id)
VALUES(20105, '보석', '보석과 여자 ', 'user15', NOW(), 0, 10006);

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20105, 0, 1,'feed106_thumbnail.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20105, 0, 0,'feed106_1.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20105, 1, 0,'feed106_2.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20105, 2, 0,'feed106_3.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20105, 3, 0,'feed106_4.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20105, 4, 0,'feed106_5.jpg');

INSERT
INTO feeds (feed_id, feed_title, feed_explanation, user_code, feed_reg_date, feed_is_prime, category_id)
VALUES(20149, 'THE Cars', ' ', 'user16', NOW(), 1, 10003);

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20149, 0, 1,'feed150_thumbnail.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20149, 0, 0,'feed150_1.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20149, 1, 0,'feed150_2.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20149, 2, 0,'feed150_3.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20149, 3, 0,'feed150_4.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20149, 4, 0,'feed150_5.jpg');

INSERT
INTO feeds (feed_id, feed_title, feed_explanation, user_code, feed_reg_date, feed_is_prime, category_id)
VALUES(20150, 'Cats', '나만없어 고양이', 'user16', NOW(), 1, 10006);

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20150, 0, 1,'feed151_thumbnail.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20150, 0, 0,'feed151_1.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20150, 1, 0,'feed151_2.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20150, 2, 0,'feed151_3.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20150, 3, 0,'feed151_4.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20150, 4, 0,'feed151_5.jpg');

INSERT
INTO feeds (feed_id, feed_title, feed_explanation, user_code, feed_reg_date, feed_is_prime, category_id)
VALUES(20151, '하늘', ' ', 'user16', NOW(), 1, 10006);

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20151, 0, 1,'feed152_thumbnail.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20151, 0, 0,'feed152_1.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20151, 1, 0,'feed152_2.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20151, 2, 0,'feed152_3.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20151, 3, 0,'feed152_4.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20151, 3, 0,'feed152_5.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20151, 3, 0,'feed152_6.jpg');

INSERT
INTO feeds (feed_id, feed_title, feed_explanation, user_code, feed_reg_date, feed_is_prime, category_id)
VALUES(20152, 'flowers', 'flowers have long been admired and used by humans to bring beauty to their environment, and also as objects of romance, ritual, religion, medicine and as a source of food.', 'user16', NOW(), 1, 10006);

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20152, 0, 1,'feed153_thumbnail.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20152, 0, 0,'feed153_1.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20152, 1, 0,'feed153_2.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20152, 2, 0,'feed153_3.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20152, 3, 0,'feed153_4.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20152, 4, 0,'feed153_5.jpg');

INSERT
INTO feeds (feed_id, feed_title, feed_explanation, user_code, feed_reg_date, feed_is_prime, category_id)
VALUES(20153, 'fasion', 'runway', 'user16', NOW(), 1, 10004);

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20153, 0, 1,'feed154_thumbnail.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20153, 0, 0,'feed154_1.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20153, 1, 0,'feed154_2.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20153, 2, 0,'feed154_3.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20153, 3, 0,'feed154_4.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20153, 4, 0,'feed154_5.jpg');

INSERT
INTO feeds (feed_id, feed_title, feed_explanation, user_code, feed_reg_date, feed_is_prime, category_id)
VALUES(20154, 'model', 'fasion', 'user16', NOW(), 1, 10004);

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20154, 0, 1,'feed155_thumbnail.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20154, 0, 0,'feed155_1.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20154, 1, 0,'feed155_2.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20154, 2, 0,'feed155_3.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20154, 3, 0,'feed155_4.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20154, 4, 0,'feed155_5.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20154, 5, 0,'feed155_6.jpg');

INSERT
INTO feeds (feed_id, feed_title, feed_explanation, user_code, feed_reg_date, feed_is_prime, category_id)
VALUES(20155, 'product', 'product', 'user16', NOW(), 1, 10003);

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20155, 0, 1,'feed156_thumbnail.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20155, 0, 0,'feed156_1.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20155, 1, 0,'feed156_2.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20155, 2, 0,'feed156_3.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20155, 3, 0,'feed156_4.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20155, 4, 0,'feed156_5.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20155, 5, 0,'feed156_6.jpg');

INSERT
INTO feeds (feed_id, feed_title, feed_explanation, user_code, feed_reg_date, feed_is_prime, category_id)
VALUES(20156, 'Modern architecture', 'architecture', 'user16', NOW(), 1, 10002);

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20156, 0, 1,'feed157_thumbnail.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20156, 0, 0,'feed157_1.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20156, 1, 0,'feed157_2.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20156, 2, 0,'feed157_3.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20156, 3, 0,'feed157_4.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20156, 4, 0,'feed157_5.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20156, 5, 0,'feed157_6.jpg');

INSERT
INTO feeds (feed_id, feed_title, feed_explanation, user_code, feed_reg_date, feed_is_prime, category_id)
VALUES(20157, 'Antoni Plàcid Guillem Gaudí i Cornet', 'Gaudí', 'user16', NOW(), 1, 10002);

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20157, 0, 1,'feed158_thumbnail.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20157, 0, 0,'feed158_1.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20157, 1, 0,'feed158_2.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20157, 2, 0,'feed158_3.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20157, 3, 0,'feed158_4.jpg');

INSERT
INTO feeds (feed_id, feed_title, feed_explanation, user_code, feed_reg_date, feed_is_prime, category_id)
VALUES(20158, 'Sagrada familia', 'sagrada familia', 'user16', NOW(), 1, 10002);

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20158, 0, 1,'feed159_thumbnail.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20158, 0, 0,'feed159_1.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20158, 1, 0,'feed159_2.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20158, 2, 0,'feed159_3.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20158, 3, 0,'feed159_4.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20158, 4, 0,'feed159_5.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20158, 5, 0,'feed159_6.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20158, 6, 0,'feed159_7.jpg');

INSERT
INTO feeds (feed_id, feed_title, feed_explanation, user_code, feed_reg_date, feed_is_prime, category_id)
VALUES(20159, 'Typography', 'typography', 'user16', NOW(), 0, 10010);

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20159, 0, 1,'feed160_thumbnail.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20159, 0, 0,'feed160_1.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20159, 1, 0,'feed160_2.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20159, 2, 0,'feed160_3.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20159, 3, 0,'feed160_4.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20159, 4, 0,'feed160_5.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20159, 5, 0,'feed160_6.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20159, 6, 0,'feed160_7.jpg');

INSERT
INTO feeds (feed_id, feed_title, feed_explanation, user_code, feed_reg_date, feed_is_prime, category_id)
VALUES(20160, 'Package design', 'package design', 'user17', NOW(), 0, 10003);

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20160, 0, 1,'feed161_thumbnail.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20160, 0, 0,'feed161_1.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20160, 1, 0,'feed161_2.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20160, 2, 0,'feed161_3.jpg');

INSERT
INTO feeds (feed_id, feed_title, feed_explanation, user_code, feed_reg_date, feed_is_prime, category_id)
VALUES(20161, 'Graphic design', 'graphic design', 'user17', NOW(), 0, 10001);

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20161, 0, 1,'feed162_thumbnail.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20161, 0, 0,'feed162_1.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20161, 1, 0,'feed162_2.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20161, 2, 0,'feed162_3.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20161, 3, 0,'feed162_4.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20161, 4, 0,'feed162_5.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20161, 5, 0,'feed162_6.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20161, 6, 0,'feed162_7.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20161, 7, 0,'feed162_8.jpg');

INSERT
INTO feeds (feed_id, feed_title, feed_explanation, user_code, feed_reg_date, feed_is_prime, category_id)
VALUES(20162, 'Product design', 'graphic design', 'user17', NOW(), 0, 10001);

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20162, 0, 1,'feed163_thumbnail.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20162, 0, 0,'feed163_1.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20162, 1, 0,'feed163_2.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20162, 2, 0,'feed163_3.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20162, 3, 0,'feed163_4.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20162, 4, 0,'feed163_5.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20162, 5, 0,'feed163_6.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20162, 6, 0,'feed163_7.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20162, 7, 0,'feed163_8.jpg');

INSERT
INTO feeds (feed_id, feed_title, feed_explanation, user_code, feed_reg_date, feed_is_prime, category_id)
VALUES(20163, 'Porcelain', 'porcelain', 'user17', NOW(), 0, 10009);

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20163, 0, 1,'feed164_thumbnail.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20163, 0, 0,'feed164_1.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20163, 1, 0,'feed164_2.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20163, 2, 0,'feed164_3.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20163, 3, 0,'feed164_4.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20163, 4, 0,'feed164_5.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20163, 5, 0,'feed164_6.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20163, 6, 0,'feed164_7.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20163, 7, 0,'feed164_8.jpg');

INSERT
INTO feeds (feed_id, feed_title, feed_explanation, user_code, feed_reg_date, feed_is_prime, category_id)
VALUES(20164, 'Graphic', '그래픽디자인 모음', 'user17', NOW(), 0, 10001);

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20164, 0, 1,'feed165_thumbnail.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20164, 0, 0,'feed165_1.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20164, 1, 0,'feed165_2.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20164, 2, 0,'feed165_3.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20164, 3, 0,'feed165_4.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20164, 4, 0,'feed165_5.jpg');

INSERT
INTO feeds (feed_id, feed_title, feed_explanation, user_code, feed_reg_date, feed_is_prime, category_id)
VALUES(20165, 'People', 'people', 'user17', NOW(), 0, 10006);

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20165, 0, 1,'feed166_thumbnail.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20165, 0, 0,'feed166_1.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20165, 1, 0,'feed166_2.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20165, 2, 0,'feed166_3.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20165, 3, 0,'feed166_4.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20165, 4, 0,'feed166_5.jpg');

INSERT
INTO feeds (feed_id, feed_title, feed_explanation, user_code, feed_reg_date, feed_is_prime, category_id)
VALUES(20166, 'Make up', 'make up', 'user17', NOW(), 0, 10006);

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20166, 0, 1,'feed167_thumbnail.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20166, 0, 0,'feed167_1.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20166, 1, 0,'feed167_2.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20166, 2, 0,'feed167_3.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20166, 3, 0,'feed167_4.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20166, 4, 0,'feed167_5.jpg');

INSERT
INTO feeds (feed_id, feed_title, feed_explanation, user_code, feed_reg_date, feed_is_prime, category_id)
VALUES(20167, 'Vacation', 'vacation', 'user17', NOW(), 0, 10006);

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20167, 0, 1,'feed168_thumbnail.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20167, 0, 0,'feed168_1.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20167, 1, 0,'feed168_2.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20167, 2, 0,'feed168_3.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20167, 3, 0,'feed168_4.jpg');

INSERT
INTO feeds (feed_id, feed_title, feed_explanation, user_code, feed_reg_date, feed_is_prime, category_id)
VALUES(20168, 'Vacances', 'vacances', 'user17', NOW(), 0, 10006);

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20168, 0, 1,'feed169_thumbnail.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20168, 0, 0,'feed169_1.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20168, 1, 0,'feed169_2.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20168, 2, 0,'feed169_3.jpg');

INSERT
INTO feeds (feed_id, feed_title, feed_explanation, user_code, feed_reg_date, feed_is_prime, category_id)
VALUES(20169, 'Retro Vitage Typography', 'Typography', 'user17', NOW(), 0, 10010);

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20169, 0, 1,'feed170_thumbnail.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20169, 0, 0,'feed170_1.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20169, 1, 0,'feed170_2.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20169, 2, 0,'feed170_3.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20169, 3, 0,'feed170_4.jpg');

INSERT
INTO feeds (feed_id, feed_title, feed_explanation, user_code, feed_reg_date, feed_is_prime, category_id)
VALUES(20170, 'Animals', 'Animals', 'user17', NOW(), 0, 10006);

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20170, 0, 1,'feed171_thumbnail.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20170, 0, 0,'feed171_1.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20170, 1, 0,'feed171_2.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20170, 2, 0,'feed171_3.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20170, 3, 0,'feed171_4.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20170, 4, 0,'feed171_5.jpg');

INSERT
INTO feeds (feed_id, feed_title, feed_explanation, user_code, feed_reg_date, feed_is_prime, category_id)
VALUES(20171, 'Cinema', 'cinema', 'user17', NOW(), 0, 10006);

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20171, 0, 1,'feed172_thumbnail.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20171, 0, 0,'feed172_1.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20171, 1, 0,'feed172_2.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20171, 2, 0,'feed172_3.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20171, 3, 0,'feed172_4.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20171, 4, 0,'feed172_5.jpg');


INSERT
INTO feeds (feed_id, feed_title, feed_explanation, user_code, feed_reg_date, feed_is_prime, category_id)
VALUES(20172, 'Illustration', 'illustration', 'user17', NOW(), 0, 10000);

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20172, 0, 1,'feed173_thumbnail.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20172, 0, 0,'feed173_1.png');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20172, 1, 0,'feed173_2.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20172, 2, 0,'feed173_3.png');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20172, 3, 0,'feed173_4.png');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20172, 4, 0,'feed173_5.png');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20172, 5, 0,'feed173_6.jpg');

INSERT
INTO feeds (feed_id, feed_title, feed_explanation, user_code, feed_reg_date, feed_is_prime, category_id)
VALUES(20173, 'Vodka!!', 'Half Vodka Fruit Soda', 'user18', NOW(), 0, 10003);

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20173, 0, 1,'feed174_thumbnail.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20173, 0, 0,'feed174_1.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20173, 1, 0,'feed174_2.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20173, 2, 0,'feed174_3.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20173, 3, 0,'feed174_4.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20173, 4, 0,'feed174_5.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20173, 5, 0,'feed174_6.jpg');

INSERT
INTO feeds (feed_id, feed_title, feed_explanation, user_code, feed_reg_date, feed_is_prime, category_id)
VALUES(20174, 'Mountain', '산 보는건 좋은데 등산은 싫어요', 'user18', NOW(), 0, 10006);

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20174, 0, 1,'feed175_thumbnail.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20174, 0, 0,'feed175_1.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20174, 1, 0,'feed175_2.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20174, 2, 0,'feed175_3.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20174, 3, 0,'feed175_4.jpg');


INSERT
INTO feeds (feed_id, feed_title, feed_explanation, user_code, feed_reg_date, feed_is_prime, category_id)
VALUES(20175, '강아지', '또 나만 없어 강아지', 'user18', NOW(), 0, 10006);

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20175, 0, 1,'feed176_thumbnail.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20175, 0, 0,'feed176_1.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20175, 1, 0,'feed176_2.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20175, 2, 0,'feed176_3.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20175, 3, 0,'feed176_4.jpg');

INSERT
INTO feeds (feed_id, feed_title, feed_explanation, user_code, feed_reg_date, feed_is_prime, category_id)
VALUES(20176, 'Doggy with style', 'good style', 'user18', NOW(), 1, 10004);

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20176, 0, 1,'feed177_thumbnail.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20176, 0, 0,'feed177_1.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20176, 1, 0,'feed177_2.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20176, 2, 0,'feed177_3.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20176, 3, 0,'feed177_4.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20176, 4, 0,'feed177_5.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20176, 5, 0,'feed177_6.jpg');

INSERT
INTO feeds (feed_id, feed_title, feed_explanation, user_code, feed_reg_date, feed_is_prime, category_id)
VALUES(20177, 'MacBook', 'MacBook', 'user18', NOW(), 0, 10003);

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20177, 0, 1,'feed178_thumbnail.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20177, 0, 0,'feed178_1.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20177, 1, 0,'feed178_2.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20177, 2, 0,'feed178_3.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20177, 3, 0,'feed178_4.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20177, 4, 0,'feed178_5.jpg');

INSERT
INTO feeds (feed_id, feed_title, feed_explanation, user_code, feed_reg_date, feed_is_prime, category_id)
VALUES(20178, 'carpet', 'Pattern of handmade carpet', 'user18', NOW(), 0, 10009);

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20178, 0, 1,'feed179_thumbnail.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20178, 0, 0,'feed179_1.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20178, 1, 0,'feed179_2.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20178, 2, 0,'feed179_3.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20178, 3, 0,'feed179_4.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20178, 4, 0,'feed179_5.jpg');

INSERT
INTO feeds (feed_id, feed_title, feed_explanation, user_code, feed_reg_date, feed_is_prime, category_id)
VALUES(20179, 'Stained glass', 'Stained glass', 'user18', NOW(), 0, 10002);

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20179, 0, 1,'feed180_thumbnail.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20179, 0, 0,'feed180_1.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20179, 1, 0,'feed180_2.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20179, 2, 0,'feed180_3.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20179, 3, 0,'feed180_4.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20179, 4, 0,'feed180_5.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20179, 5, 0,'feed180_6.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20179, 6, 0,'feed180_7.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20179, 7, 0,'feed180_8.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20179, 8, 0,'feed180_9.jpg');

INSERT
INTO feeds (feed_id, feed_title, feed_explanation, user_code, feed_reg_date, feed_is_prime, category_id)
VALUES(20180, 'Galaxy', 'Cause I’m a pilot anywhere Cause I’m a pilot anywhere Lighting star Shooting star 줄게 내 Galaxy', 'user19', NOW(), 0, 10006);

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20180, 0, 1,'feed181_thumbnail.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20180, 0, 0,'feed181_1.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20180, 1, 0,'feed181_2.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20180, 2, 0,'feed181_3.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20180, 3, 0,'feed181_4.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20180, 4, 0,'feed181_5.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20180, 5, 0,'feed181_6.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20180, 6, 0,'feed181_7.jpg');

INSERT
INTO feeds (feed_id, feed_title, feed_explanation, user_code, feed_reg_date, feed_is_prime, category_id)
VALUES(20181, 'NEON', 'neon', 'user19', NOW(), 0, 10006);

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20181, 0, 1,'feed182_thumbnail.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20181, 0, 0,'feed182_1.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20181, 1, 0,'feed182_2.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20181, 2, 0,'feed182_3.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20181, 3, 0,'feed182_4.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20181, 4, 0,'feed182_5.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20181, 5, 0,'feed182_6.jpg');

INSERT
INTO feeds (feed_id, feed_title, feed_explanation, user_code, feed_reg_date, feed_is_prime, category_id)
VALUES(20182, 'colorful', 'colorful', 'user15', NOW(), 0, 10001);

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20182, 0, 1,'feed183_thumbnail.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20182, 0, 0,'feed183_1.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20182, 1, 0,'feed183_2.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20182, 2, 0,'feed183_3.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20182, 3, 0,'feed183_4.jpg');

INSERT
INTO feeds (feed_id, feed_title, feed_explanation, user_code, feed_reg_date, feed_is_prime, category_id)
VALUES(20183, 'forest', 'o2', 'user19', NOW(), 1, 10006);

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20183, 0, 1,'feed184_thumbnail.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20183, 0, 0,'feed184_1.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20183, 1, 0,'feed184_2.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20183, 2, 0,'feed184_3.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20183, 3, 0,'feed184_4.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20183, 4, 0,'feed184_5.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20183, 5, 0,'feed184_6.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20183, 6, 0,'feed184_7.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20183, 7, 0,'feed184_8.jpg');

INSERT
INTO feeds (feed_id, feed_title, feed_explanation, user_code, feed_reg_date, feed_is_prime, category_id)
VALUES(20184, 'good', 'good', 'user17', NOW(), 1, 10004);

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20184, 0, 1,'feed185_thumbnail.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20184, 0, 0,'feed185_1.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20184, 1, 0,'feed185_2.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20184, 2, 0,'feed185_3.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20184, 3, 0,'feed185_4.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20184, 4, 0,'feed185_5.jpg');

INSERT
INTO feeds (feed_id, feed_title, feed_explanation, user_code, feed_reg_date, feed_is_prime, category_id)
VALUES(20185, 'long', '길어서 못 읽음', 'user18', NOW(), 0, 10001);

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20185, 0, 1,'feed186_thumbnail.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20185, 0, 0,'feed186_1.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20185, 1, 0,'feed186_2.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20185, 2, 0,'feed186_3.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20185, 3, 0,'feed186_4.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20185, 4, 0,'feed186_5.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20185, 5, 0,'feed186_6.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20185, 6, 0,'feed186_7.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20185, 7, 0,'feed186_8.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20185, 8, 0,'feed186_9.jpg');

INSERT
INTO feeds (feed_id, feed_title, feed_explanation, user_code, feed_reg_date, feed_is_prime, category_id)
VALUES(20186, 'Journey st', 'Journey재밌습니다 해보세요 PC버전도 있어요', 'user20', NOW(), 1, 10008);

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20186, 0, 1,'feed187_thumbnail.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20186, 0, 0,'feed187_1.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20186, 1, 0,'feed187_2.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20186, 2, 0,'feed187_3.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20186, 3, 0,'feed187_4.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20186, 4, 0,'feed187_5.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20186, 5, 0,'feed187_6.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20186, 6, 0,'feed187_7.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20186, 7, 0,'feed187_8.jpg');

INSERT
INTO feeds (feed_id, feed_title, feed_explanation, user_code, feed_reg_date, feed_is_prime, category_id)
VALUES(20187, 'flower', 'woman', 'user19', NOW(), 0, 10004);

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20187, 0, 1,'feed188_thumbnail.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20187, 0, 0,'feed188_1.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20187, 1, 0,'feed188_2.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20187, 2, 0,'feed188_3.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20187, 3, 0,'feed188_4.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20187, 4, 0,'feed188_5.jpg');

INSERT
INTO feeds (feed_id, feed_title, feed_explanation, user_code, feed_reg_date, feed_is_prime, category_id)
VALUES(20188, 'Nail polish', '팬톤컬러 느낌', 'user14', NOW(), 0, 10003);

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20188, 0, 1,'feed189_thumbnail.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20188, 0, 0,'feed189_1.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20188, 1, 0,'feed189_2.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20188, 2, 0,'feed189_3.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20188, 3, 0,'feed189_4.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20188, 4, 0,'feed189_5.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20188, 5, 0,'feed189_6.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20188, 6, 0,'feed189_7.jpg');

INSERT
INTO feeds (feed_id, feed_title, feed_explanation, user_code, feed_reg_date, feed_is_prime, category_id)
VALUES(20189, 'Lake', '여행가고싶다', 'user11', NOW(), 0, 10006);

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20189, 0, 1,'feed190_thumbnail.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20189, 0, 0,'feed190_1.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20189, 1, 0,'feed190_2.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20189, 2, 0,'feed190_3.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20189, 3, 0,'feed190_4.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20189, 4, 0,'feed190_5.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20189, 5, 0,'feed190_6.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20189, 6, 0,'feed190_7.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20189, 7, 0,'feed190_8.jpg');

INSERT
INTO feeds (feed_id, feed_title, feed_explanation, user_code, feed_reg_date, feed_is_prime, category_id)
VALUES(20190, 'milkne', 'ICE CREAM', 'user11', NOW(), 1, 10003);

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20190, 0, 1,'feed191_thumbnail.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20190, 0, 0,'feed191_1.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20190, 1, 0,'feed191_2.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20190, 2, 0,'feed191_3.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20190, 3, 0,'feed191_4.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20190, 4, 0,'feed191_5.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20190, 5, 0,'feed191_6.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20190, 6, 0,'feed191_7.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20190, 6, 0,'feed191_8.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20190, 6, 0,'feed191_9.jpg');

INSERT
INTO feeds (feed_id, feed_title, feed_explanation, user_code, feed_reg_date, feed_is_prime, category_id)
VALUES(20191, 'CREPE', 'yummy', 'user12', NOW(), 1, 10006);

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20191, 0, 1,'feed192_thumbnail.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20191, 0, 0,'feed192_1.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20191, 1, 0,'feed192_2.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20191, 2, 0,'feed192_3.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20191, 3, 0,'feed192_4.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20191, 4, 0,'feed192_5.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20191, 5, 0,'feed192_6.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20191, 6, 0,'feed192_7.jpg');

INSERT
INTO feeds (feed_id, feed_title, feed_explanation, user_code, feed_reg_date, feed_is_prime, category_id)
VALUES(20192, 'thailand', 'thailand', 'user12', NOW(), 1, 10006);

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20192, 0, 1,'feed193_thumbnail.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20192, 0, 0,'feed193_1.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20192, 1, 0,'feed193_2.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20192, 2, 0,'feed193_3.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20192, 3, 0,'feed193_4.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20192, 4, 0,'feed193_5.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20192, 5, 0,'feed193_6.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20192, 6, 0,'feed193_7.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20192, 7, 0,'feed193_8.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20192, 8, 0,'feed193_9.jpg');

INSERT
INTO feeds (feed_id, feed_title, feed_explanation, user_code, feed_reg_date, feed_is_prime, category_id)
VALUES(20193, 'collage', 'collage', 'user09', NOW(), 1, 10001);

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20193, 0, 1,'feed194_thumbnail.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20193, 0, 0,'feed194_1.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20193, 1, 0,'feed194_2.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20193, 2, 0,'feed194_3.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20193, 3, 0,'feed194_4.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20193, 4, 0,'feed194_5.jpg');

INSERT
INTO feeds (feed_id, feed_title, feed_explanation, user_code, feed_reg_date, feed_is_prime, category_id)
VALUES(20194, 'fasion', 'fasion', 'user12', NOW(), 1, 10004);

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20194, 0, 1,'feed195_thumbnail.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20194, 0, 0,'feed195_1.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20194, 1, 0,'feed195_2.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20194, 2, 0,'feed195_3.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20194, 3, 0,'feed195_4.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20194, 4, 0,'feed195_5.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20194, 5, 0,'feed195_6.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20194, 6, 0,'feed195_7.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20194, 7, 0,'feed195_8.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20194, 8, 0,'feed195_9.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20194, 9, 0,'feed195_10.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20194, 10, 0,'feed195_11.jpg');

INSERT
INTO feeds (feed_id, feed_title, feed_explanation, user_code, feed_reg_date, feed_is_prime, category_id)
VALUES(20195, 'GUNS.LOVE.AND.TENTACLES', 'game', 'user08', NOW(), 1, 10008);

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20195, 0, 1,'feed196_thumbnail.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20195, 0, 0,'feed196_1.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20195, 1, 0,'feed196_2.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20195, 2, 0,'feed196_3.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20195, 3, 0,'feed192_4.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20195, 4, 0,'feed196_5.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20195, 5, 0,'feed196_6.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20195, 6, 0,'feed196_7.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20195, 7, 0,'feed196_8.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20195, 8, 0,'feed196_9.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20195, 9, 0,'feed196_10.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20195, 10, 0,'feed196_11.jpg');

INSERT
INTO feeds (feed_id, feed_title, feed_explanation, user_code, feed_reg_date, feed_is_prime, category_id)
VALUES(20196, 'life is hard', '타이포디자인', 'user13', NOW(), 0, 10010);

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20196, 0, 1,'feed197_thumbnail.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20196, 0, 0,'feed197_1.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20196, 1, 0,'feed197_2.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20196, 2, 0,'feed197_3.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20196, 3, 0,'feed197_4.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20196, 4, 0,'feed197_5.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20196, 5, 0,'feed197_6.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20196, 6, 0,'feed197_7.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20196, 7, 0,'feed197_8.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20196, 8, 0,'feed197_9.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20196, 9, 0,'feed197_10.jpg');

INSERT
INTO feeds (feed_id, feed_title, feed_explanation, user_code, feed_reg_date, feed_is_prime, category_id)
VALUES(20197, 'HUMMER', 'HUMMER', 'user12', NOW(), 0, 10006);

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20197, 0, 1,'feed198_thumbnail.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20197, 0, 0,'feed198_1.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20197, 1, 0,'feed198_2.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20197, 2, 0,'feed198_3.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20197, 3, 0,'feed198_4.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20197, 4, 0,'feed198_5.jpg');

INSERT
INTO feeds (feed_id, feed_title, feed_explanation, user_code, feed_reg_date, feed_is_prime, category_id)
VALUES(20198, '패션 모델', '패션 모델 프로필', 'user11', NOW(), 0, 10004);

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20198, 0, 1,'feed199_thumbnail.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20198, 0, 0,'feed199_1.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20198, 1, 0,'feed199_2.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20198, 2, 0,'feed199_3.jpg');

INSERT
INTO feeds (feed_id, feed_title, feed_explanation, user_code, feed_reg_date, feed_is_prime, category_id)
VALUES(20199, 'game', 'game', 'user05', NOW(), 1, 10008);

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20199, 0, 1,'feed200_thumbnail.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20199, 0, 0,'feed200_1.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20199, 1, 0,'feed200_2.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20199, 2, 0,'feed200_3.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20199, 3, 0,'feed200_4.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20199, 4, 0,'feed200_5.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20199, 5, 0,'feed200_6.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20199, 6, 0,'feed200_7.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20199, 7, 0,'feed200_8.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20199, 8, 0,'feed200_9.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20199, 9, 0,'feed200_10.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20199, 10, 0,'feed200_11.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20199, 11, 0,'feed200_12.jpg');

INSERT
INTO feeds (feed_id, feed_title, feed_explanation, user_code, feed_reg_date, feed_is_prime, category_id)
VALUES(20200, '일러스트', '일러스트', 'user06', NOW(), 0, 10000);

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20200, 0, 1,'feed201_thumbnail.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20200, 0, 0,'feed201_1.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20200, 1, 0,'feed201_2.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20200, 2, 0,'feed201_3.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20200, 3, 0,'feed201_4.jpg');

INSERT
INTO feeds (feed_id, feed_title, feed_explanation, user_code, feed_reg_date, feed_is_prime, category_id)
VALUES(20201, 'Pacific Rim', 'JAEGER', 'user06', NOW(), 1, 10001);

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20201, 0, 1,'feed202_thumbnail.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20201, 0, 0,'feed202_1.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20201, 1, 0,'feed202_2.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20201, 2, 0,'feed202_3.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20201, 3, 0,'feed202_4.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20201, 4, 0,'feed202_5.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20201, 5, 0,'feed202_6.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20201, 6, 0,'feed202_7.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20201, 7, 0,'feed202_8.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20201, 8, 0,'feed202_9.jpg');












INSERT
INTO report (report_id, reporter_code, violator_code, report_Type, report_feed_id, report_date)
VALUES(report_id, 'user10', 'user02', 0, 20000, NOW());

INSERT
INTO report (report_id, reporter_code, violator_code, report_Type, report_feed_id, report_date)
VALUES(report_id, 'user10', 'user02', 0, 20000, NOW());

INSERT
INTO report (report_id, reporter_code, violator_code, report_Type, report_feed_id, report_date)
VALUES(report_id, 'user11', 'user02', 1, 20001, DATE_FORMAT('2010-01-03', '%Y-%m-%d'));

INSERT
INTO report (report_id, reporter_code, violator_code, report_Type, report_feed_id, report_date)
VALUES(report_id, 'user13', 'user02', 2, 20002, NOW());

INSERT
INTO report (report_id, reporter_code, violator_code, report_Type, report_feed_id, report_date)
VALUES(report_id, 'user14', 'user02', 2, 20003, NOW());

INSERT
INTO report (report_id, reporter_code, violator_code, report_Type, report_feed_id, report_date)
VALUES(report_id, 'user15', 'user03', 2, 20004, NOW());








INSERT
INTO history (history_id, feed_id, watch_user_code, show_date, history_type)
VALUES(history_id, 20174, 'user01', NOW(), 1);

INSERT
INTO history (history_id, feed_id, watch_user_code, show_date, history_type)
VALUES(history_id, 20170, 'user01', NOW(), 1);

INSERT
INTO history (history_id, feed_id, watch_user_code, show_date, history_type)
VALUES(history_id, 20168, 'user01', NOW(), 1);

INSERT
INTO history (history_id, feed_id, watch_user_code, show_date, history_type)
VALUES(history_id, 20166, 'user01', NOW(), 1);

INSERT
INTO history (history_id, feed_id, watch_user_code, show_date, history_type)
VALUES(history_id, 20160, 'user01', NOW(), 1);

INSERT
INTO history (history_id, feed_id, watch_user_code, show_date, history_type)
VALUES(history_id, 20174, 'user01', NOW(), 1);

INSERT
INTO history (history_id, feed_id, watch_user_code, show_date, history_type)
VALUES(history_id, 20003, 'user01', NOW(), 0);

INSERT
INTO history (history_id, feed_id, watch_user_code, show_date, history_type)
VALUES(history_id, 20054, 'user01', NOW(), 0);

INSERT
INTO history (history_id, feed_id, watch_user_code, show_date, history_type)
VALUES(history_id, 20011, 'user01', NOW(), 0);

INSERT
INTO history (history_id, feed_id, watch_user_code, show_date, history_type)
VALUES(history_id, 20013, 'user01', NOW(), 0);

INSERT
INTO history (history_id, feed_id, watch_user_code, show_date, history_type)
VALUES(history_id, 20012, 'user01', NOW(), 0);

INSERT
INTO history (history_id, feed_id, watch_user_code, show_date, history_type)
VALUES(history_id, 20169, 'user01', NOW(), 0);

INSERT INTO 
event(event_id, event_title, event_sub, event_start, event_end, event_thumbnail, event_tag, event_image, event_type, banner) 
VALUES( event_id, '로고 디자인 의뢰 특별 이벤트', 'LOGO BRAND에서 로고디자인을 공모합니다.' , '2020-07-29', '2020-09-29', 'Event02_thumbnail.jpg', 'LOGO&BRAND, 디자인의뢰, 특별이벤트', 'Event02_1.jpg', 0, 'Event02_banner.jpg');

INSERT INTO 
event(event_id, event_title, event_sub, event_start, event_end, event_thumbnail, event_tag, event_image, event_type, banner) 
VALUES( event_id, '더벤티 디자인 공모전', '더벤티에서 다양한 이야기가 담긴 디자인을 공모합니다.' , '2020-08-05', '2020-09-08', 'Event03_thumbnail.jpg', '더벤티공모전, 2020더벤티디자인, 2020더벤티공모전', 'Event03_1.jpg', 0, 'Event03_banner.jpg');

INSERT INTO 
event(event_id, event_title, event_sub, event_start, event_end, event_thumbnail, event_tag, event_image, event_type, banner) 
VALUES( event_id, '중국대표브랜드 펜 디자인 공모전', '중국 5대볼펜 브랜드 vience에서 드로잉펜 디자인 공모전을 진행합니다.' , '2020-09-28', '2020-10-26', 'Event04_thumbnail.jpg', 'Vience공모전, 2020Vience공모전, 2020드로잉펜공모전', 'Event04_1.jpg', 0, 'Event04_banner.jpg');

INSERT INTO 
event(event_id, event_title, event_sub, event_start, event_end, event_thumbnail, event_tag, event_image, event_type, banner) 
values( event_id, 'The Grand Tour', 'NASA SPACE POSTER DESIGN' , '2020-07-16', '2020-09-17', 'Event05_thumbnail.jpg', 'NASA, PORSTERDESIGN, NASADEGIN', 'Event05_1.jpg', 0, 'Event05_banner.jpg');
      
      
INSERT INTO 
event(event_id, event_title, event_sub, event_start, event_end, event_thumbnail, event_tag, event_image, event_type, banner) 
values( event_id, 'CULT', 'CAMBODIAs ULTIMATE LIFESTYLE TRADE.' , '2020-08-06', '2020-09-17', 'Event06_thumbnail.jpg', 'CAMBODIA, ULTIMATE LIFESTYLE, CULTTRADE', 'Event06_01.jpg', 0, 'Event06_banner.jpg');

INSERT INTO 
event(event_id, event_title, event_sub, event_start, event_end, event_thumbnail, event_tag, event_image, event_type, banner) 
values( event_id, 'FORGE', 'A Collective for car' , '2020-08-06', '2020-09-17', 'Event07_thumbnail.jpg', 'CAMBODIA, ULTIMATE LIFESTYLE, CULTTRADE', 'Event07_01.jpg', 0, 'Event07_banner.jpg');

INSERT INTO 
alarm(alarm_id, send_user_code, receive_user_code,  is_watch, alarm_type, add_date)
VALUES(alarm_id, 'user02', 'user01', 0,  2, DATE_FORMAT('2010-01-03', '%Y-%m-%d'));

INSERT INTO 
alarm(alarm_id, send_user_code, receive_user_code, is_watch, like_feed_id, alarm_type, add_date)
VALUES(alarm_id, 'user02', 'user01', 0, 20000, 0, DATE_FORMAT('2010-01-03', '%Y-%m-%d'));


commit;
