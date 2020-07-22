DROP DATABASE IF EXISTS VIG; 
 
CREATE DATABASE VIG; 

USE VIG;


CREATE TABLE users ( 
	user_code  			 VARCHAR(20) 		NOT NULL,
	user_name  			 VARCHAR(50) 		NOT NULL,
	password  			 VARCHAR(10),
	role  				 VARCHAR(10)  		DEFAULT 'user',	
	profile_img 		 VARCHAR(50),
	self_introduce  	 VARCHAR(1024),	
	sex  				 VARCHAR(10),
	birth  				 INT(4),
	state  				 TINYINT(1),
	google_id  			 VARCHAR(50),
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
	ban_history 	 	 TINYINT(1), 
	current_ban_date   	 DATE, 
	PRIMARY KEY(report_id)
);

CREATE TABLE history ( 
	history_id 				INT(11)  		NOT NULL AUTO_INCREMENT,
	feed_id  				INT(11) 		NOT NULL REFERENCES feeds(feed_id),
	watch_user_code   		VARCHAR(20) 	NOT NULL REFERENCES users(user_code),
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
	alarm_id 		INT(11)  		NOT NULL AUTO_INCREMENT,	
	user_code   	VARCHAR(20) 	NOT NULL REFERENCES users(user_code),
	message 		VARCHAR(1024) 	NOT NULL,
	is_watch 		TINYINT(1),	 
	show_date 		DATE, 
	PRIMARY KEY(alarm_id)
);


CREATE TABLE payment ( 
	payment_id 		INT(11)  		NOT NULL AUTO_INCREMENT,
	sponser 		VARCHAR(20) 	NOT NULL REFERENCES users(user_code), 
	beneficlal 		VARCHAR(20) 	NOT NULL REFERENCES users(user_code), 
	payment_option 	TINYINT(1), 
	product_type 	TINYINT(1), 
	product_name 	VARCHAR(100), 
	price 			INT(11), 
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
	bank_name 		VARCHAR(20),
	whthdrow_date 	DATE,
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
VALUES (category_id, '인터랙션', 'category12.jpg');

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
INTO users (user_code, user_name, password, role, profile_img, self_introduce, state, prime_count, reg_date)
VALUES ('user20', 'night', '2020', 'user', 'profile_img.jpg', 'Hellow. my name is Atom!', 0, 0, NOW());

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
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20009, 5, 0,'feed10_06.jpg');

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
VALUES(image_id, 20056, 0, 0,'feed57_1.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20056, 1, 0,'feed57_2.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20056, 2, 0,'feed57_3.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20056, 3, 0,'feed57_4.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20056, 4, 0,'feed57_5.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20056, 5, 0,'feed57_6.jpg');

INSERT
INTO images (image_id, feed_id, feed_order, is_thumbnail, image_file)
VALUES(image_id, 20056, 6, 0,'feed57_7.jpg');

INSERT
INTO feeds (feed_id, feed_title, feed_explanation, user_code, feed_reg_date, feed_is_prime, category_id)
VALUES(20149, 'cars', ' ', 'user16', NOW(), 1, 10003);

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
VALUES(20158, 'sagrada familia', 'sagrada familia', 'user16', NOW(), 1, 10002);

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
VALUES(20159, 'typography', 'typography', 'user16', NOW(), 0, 10010);

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
VALUES(20160, 'package design', 'package design', 'user17', NOW(), 0, 10003);

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
VALUES(20161, 'graphic design', 'graphic design', 'user17', NOW(), 0, 10001);

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
VALUES(20162, 'graphic design', 'graphic design', 'user17', NOW(), 0, 10001);

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
VALUES(20163, 'porcelain', 'porcelain', 'user17', NOW(), 0, 10009);

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
VALUES(20164, 'graphic', '그래픽디자인 모음', 'user17', NOW(), 0, 10001);

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
VALUES(20165, 'people', 'people', 'user17', NOW(), 0, 10006);

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
VALUES(20166, 'make up', 'make up', 'user17', NOW(), 0, 10006);

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
VALUES(20167, 'vacation', 'vacation', 'user17', NOW(), 0, 10006);

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
VALUES(20168, 'vacances', 'vacances', 'user17', NOW(), 0, 10006);

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

commit;
