DROP DATABASE IF EXISTS VIG; 
 
CREATE DATABASE VIG; 

USE VIG;

DROP TABLE IF EXISTS images;
DROP TABLE IF EXISTS keywords;
DROP TABLE IF EXISTS comments;
DROP TABLE IF EXISTS colors;
DROP TABLE IF EXISTS joiner;
DROP TABLE IF EXISTS report;
DROP TABLE IF EXISTS follow;
DROP TABLE IF EXISTS alarm;


DROP TABLE IF EXISTS categories CASCADE;
DROP TABLE IF EXISTS feeds CASCADE;
DROP TABLE IF EXISTS users CASCADE;


CREATE TABLE users ( 
	user_code 			 VARCHAR(20)		NOT NULL,
	user_name 			 VARCHAR(50)		NOT NULL,
	password 			 VARCHAR(10),
	role 				 VARCHAR(10) 		DEFAULT 'user',	
	profile_img			 VARCHAR(50),
	self_introduce 		 VARCHAR(1024),	
	sex 				 VARCHAR(10),
	birth 				 INT(4),
	state 				 VARCHAR(50),
	google_id 			 VARCHAR(50),
	account 			 VARCHAR(50),
	prime_count 		 INT(11),
	email				 VARCHAR(50),
	reg_date 			 DATE,
	PRIMARY KEY(user_code)
);

CREATE TABLE categories ( 
	category_id				 INT(11) 		NOT NULL AUTO_INCREMENT,
	category_name			 VARCHAR(100)	NOT NULL,
	category_img			 VARCHAR(100),
	PRIMARY KEY(category_id)
);


CREATE TABLE feeds ( 
	feed_id 				 INT(11) 		NOT NULL AUTO_INCREMENT,
	feed_title 				 VARCHAR(100) 	NOT NULL,
	feed_explanation		 VARCHAR(1024),
	user_code		 		 VARCHAR(20) 	NOT NULL REFERENCES users(user_code),
	feed_reg_date			 VARCHAR(20),
	feed_edit_date			 VARCHAR(20),
	feed_view_count			 INT(11),
	feed_is_prime			 TINYINT(1),
	category			     VARCHAR(20), 	 	
	feed_use_gears		 	 VARCHAR(1024),
	feed_is_temp			 TINYINT(1),
	prime_feed_view_count	 INT(11),
	comment_range			 TINYINT(1),
	PRIMARY KEY(feed_id)
);


CREATE TABLE images ( 
	image_id				 INT(11) 		NOT NULL AUTO_INCREMENT,
	feed_id 				 INT(11)		NOT NULL REFERENCES feeds(feed_id),
	feed_order 				 INT(11),
	is_thumbnail			 TINYINT(1),	
	image_file 				 VARCHAR(100) 	NOT NULL,
	PRIMARY KEY(image_id)
);


CREATE TABLE colors ( 
	color_id				 INT(11)  NOT NULL AUTO_INCREMENT,
	image_id				 INT(11)  NOT NULL REFERENCES images(image_id),
	color_r					 TINYINT(4) UNSIGNED,
	color_g					 TINYINT(4) UNSIGNED,
	color_b					 TINYINT(4) UNSIGNED,
	color_ratio				 FLOAT(5,5),
	PRIMARY KEY(color_id)
);

CREATE TABLE joiner ( 
	joiner_id				INT(11)  	  NOT NULL AUTO_INCREMENT,
	user_code					VARCHAR(20)  NOT NULL REFERENCES users(user_code),
	feed_id					INT(11)  	  NOT NULL REFERENCES feeds(feed_id),
	is_like					TINYINT(1),
	add_date 				DATE,
	PRIMARY KEY(joiner_id)
);


CREATE TABLE keywords ( 
	keyword_id				 INT(11) 		NOT NULL AUTO_INCREMENT,
	image_id 				 INT(11)		NOT NULL REFERENCES images(image_no),
	is_tag					 TINYINT(1),
	user_code				 VARCHAR(20)	REFERENCES users(user_code),			 
	keyword_en				 VARCHAR(100),
	keyword_origin			 VARCHAR(100),
	keyword_score			 FLOAT(5,5),	
	PRIMARY KEY(keyword_id)
);


CREATE TABLE comments ( 
	comment_id				 INT(11) 		NOT NULL AUTO_INCREMENT,
	feed_id 				 INT(11)		NOT NULL REFERENCES feeds(feed_id),
	comment_text			 VARCHAR(1024)	NOT NULL,
	user_code  				 VARCHAR(20)	NOT NULL REFERENCES users(user_code),
	reg_date 			     DATE,
	edit_date 			     DATE,
	PRIMARY KEY(comment_id)
);

CREATE TABLE report ( 
	report_id			 INT(11) 		NOT NULL AUTO_INCREMENT,
	repoter_code		 VARCHAR(20)	REFERENCES users(user_code),
	violator_code		 VARCHAR(20)	REFERENCES users(user_code),
	report_Type			 INT(11),
	report_feed_id 		 INT(11)		NOT NULL REFERENCES feeds(feed_id),
	report_message		 VARCHAR(1024),
	report_date 		 DATE,
	ban_type			 INT(11),
	ban_date 			 DATE,
	PRIMARY KEY(report_id)
);

CREATE TABLE history ( 
	history_id				INT(11) 		NOT NULL AUTO_INCREMENT,
	feed_id 				INT(11)			NOT NULL REFERENCES feeds(feed_id),
	watch_user_code  		VARCHAR(20)		NOT NULL REFERENCES users(user_code),
	show_date 			    DATE,
	ip_address				VARCHAR(20),
	history_type			TINYINT(1),
	PRIMARY KEY(history_id)
);

CREATE TABLE follow ( 
	follower_id		INT(11) 		NOT NULL AUTO_INCREMENT,	
	user_code  		VARCHAR(20)		NOT NULL REFERENCES users(user_code),
	follower_code  	VARCHAR(20)		NOT NULL REFERENCES users(user_code),
	PRIMARY KEY(follower_id)
);

CREATE TABLE alarm ( 
	alarm_id		INT(11) 		NOT NULL AUTO_INCREMENT,	
	user_code  		VARCHAR(20)		NOT NULL REFERENCES users(user_code),
	message		  	VARCHAR(1024)	NOT NULL,
	is_watch		TINYINT(1),	
	show_date		DATE,
	PRIMARY KEY(alarm_id)
);


CREATE TABLE payment ( 
	payment_id		INT(11) 		NOT NULL AUTO_INCREMENT,
	sponser			VARCHAR(20)		NOT NULL REFERENCES users(user_code),
	beneficlal		VARCHAR(20)		NOT NULL REFERENCES users(user_code),
	payment_option	TINYINT(1),
	product_type	TINYINT(1),
	product_name	VARCHAR(100),
	price			INT(11),
	payment_date	DATE,
	is_cancel		TINYINT(1),
	is_withdraw		TINYINT(1),
	PRIMARY KEY(payment_id)
);

CREATE TABLE withdraw ( 
	withdraw_id		INT(11) 		NOT NULL AUTO_INCREMENT,
	user_code		VARCHAR(20)		NOT NULL REFERENCES users(user_code),
	acc_no			VARCHAR(20),
	acc_holder		VARCHAR(20),
	bank_name		VARCHAR(20),
	whthdrow_date	DATE,
	PRIMARY KEY(withdraw_id)
);

CREATE TABLE event ( 
	event_id			INT(11) 		NOT NULL AUTO_INCREMENT,	
	event_title			VARCHAR(100),
	event_sub			VARCHAR(1024),
	event_start			DATE,
	event_end			DATE,
	event_thumbnail		VARCHAR(100),
	event_tag			VARCHAR(100),
	event_image			VARCHAR(100),
	event_type			TINYINT(1),
	banner				VARCHAR(100),
	PRIMARY KEY(event_id)
);


ALTER TABLE categories AUTO_INCREMENT  	 = 10000000;
ALTER TABLE feeds AUTO_INCREMENT 		 = 20000000;
ALTER TABLE images AUTO_INCREMENT 		 = 30000000;
ALTER TABLE colors AUTO_INCREMENT		 = 40000000;
ALTER TABLE joiner AUTO_INCREMENT 		 = 50000000;
ALTER TABLE keywords AUTO_INCREMENT 	 = 60000000;
ALTER TABLE comments AUTO_INCREMENT 	 = 70000000;
ALTER TABLE report AUTO_INCREMENT 		 = 80000000;
ALTER TABLE follow AUTO_INCREMENT 		 = 90000000;
ALTER TABLE follow AUTO_INCREMENT 		 = 100000000;
ALTER TABLE alarm AUTO_INCREMENT 		 = 110000000;
ALTER TABLE payment AUTO_INCREMENT 		 = 120000000;
ALTER TABLE withdraw AUTO_INCREMENT 	 = 130000000;
ALTER TABLE event AUTO_INCREMENT 	 	 = 140000000;


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
VALUES ('user01', 'atom11', '1111', 'business', 'profile_img.jpg', 'Hellow. my name is Atom!', 0, 1000, NOW());

INSERT
INTO users (user_code, user_name, password, role, profile_img, self_introduce, state, prime_count, reg_date)
VALUES ('user02', 'atom22', '2222', 'user', 'profile_img.jpg', 'Hellow. my name is Atom!', 0, 0, NOW());


commit;
