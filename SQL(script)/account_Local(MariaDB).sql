use mysql;

create user 'WIN98'@localhost identified by 'WIN98';
create user 'WIN98'@'%' identified by 'WIN98';

GRANT USAGE ON *.* TO 'WIN98'@'localhost' IDENTIFIED BY PASSWORD 'WIN98';
GRANT ALL PRIVILEGES ON 'vig'.* TO 'WIN98'@'localhost';


SHOW GRANTS FOR 'WIN98'@'%';
SHOW GRANTS FOR 'WIN98'@localhost;

flush privileges;