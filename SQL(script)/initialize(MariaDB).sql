DROP DATABASE IF EXISTS VIG; 
 
CREATE DATABASE VIG; 

USE VIG;

DROP TABLE IF EXISTS images;
DROP TABLE IF EXISTS keywords;
DROP TABLE IF EXISTS comments;
DROP TABLE IF EXISTS colors;
DROP TABLE IF EXISTS coworkers;

DROP TABLE IF EXISTS categories CASCADE;
DROP TABLE IF EXISTS feeds CASCADE;
DROP TABLE IF EXISTS users CASCADE;


CREATE TABLE users ( 
	user_id 			 INT(11) 			NOT NULL AUTO_INCREMENT,
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
	varied_code			 VARCHAR(20),
	reg_date 			 DATE,
	PRIMARY KEY(user_id)
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
	user_id		 		     INT(11) 	 	NOT NULL REFERENCES users(user_id),
	feed_reg_date			 VARCHAR(20),
	feed_edit_date			 VARCHAR(20),
	feed_likes				 INT(11),
	feed_view_count			 INT(11),
	feed_is_prime			 TINYINT(1),
	category_id			     INT(11) 	 	NOT NULL REFERENCES categories(category_id),
	feed_use_gears		 	 VARCHAR(1024),
	feed_is_temp			 TINYINT(1),
	prime_feed_view_count	 INT(11),
	comment_range			 TINYINT(1),
	PRIMARY KEY(feed_id)
);



CREATE TABLE coworkers ( 
	coworker_id				 INT(11) 		NOT NULL AUTO_INCREMENT,
	feed_id 				 INT(11)		NOT NULL REFERENCES feeds(feed_id),
	user_id					 INT(11)		NOT NULL REFERENCES users(user_id),		
	PRIMARY KEY(coworker_id)
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


CREATE TABLE keywords ( 
	keyword_id				 INT(11) 		NOT NULL AUTO_INCREMENT,
	image_id 				 INT(11)		NOT NULL REFERENCES images(image_no),
	is_tag					 TINYINT(1),
	user_id					 INT(11)		REFERENCES users(user_id),			 
	keyword_en				 VARCHAR(100),
	keyword_origin			 VARCHAR(100),
	keyword_score			 FLOAT(5,5),	
	PRIMARY KEY(keyword_id)
);


CREATE TABLE comments ( 
	comment_id				 INT(11) 		NOT NULL AUTO_INCREMENT,
	feed_id 				 INT(11)		NOT NULL REFERENCES feeds(feed_id),
	comment_text			 VARCHAR(1024)	NOT NULL,
	user_id  				 INT(11)		NOT NULL REFERENCES users(user_id ),
	reg_date 			     DATE,
	edit_date 			     DATE,
	PRIMARY KEY(comment_id)
);


ALTER TABLE users AUTO_INCREMENT = 1000;


INSERT 
INTO users (user_id, user_name, password, role, cell_phone, addr, email, reg_date) 
VALUES ( 'admin', 'admin', '1234', 'admin',  '010-1111-2222', '����� ���ʱ�', 'admin@mvc.com',DATE_FORMAT('2012/01/14', '%Y/%M/%D')); 

INSERT INTO users (user_id, user_name, password, role, cell_phone, addr, email, reg_date)
VALUES ( 'user01', '�հ�', '1111', 'user', '010-1111-2222', '����� ���ʱ�', 'USER@mvc.com', NOW()); 



commit;
