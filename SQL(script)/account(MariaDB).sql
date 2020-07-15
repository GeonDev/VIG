create user 'WIN98'@localhost identified by 'WIN98';
create user 'WIN98'@'%' identified by 'WIN98';

grant all privileges on VIG.* to 'WIN98'@localhost identified by 'WIN98' ;
grant all privileges on VIG.* to 'WIN98'@'%' identified by 'WIN98' ;

SHOW GRANTS FOR 'WIN98'@'%';
SHOW GRANTS FOR 'WIN98'@localhost;

flush privileges;