use mysql;

create user 'vig'@'13.125.196.55' identified by 'vig';
create user 'vig'@'%' identified by 'vig';

GRANT SELECT,INSERT,DELETE,CREATE,UPDATE,ALTER,DROP ON *.* TO 'vig'@'13.125.196.55';
GRANT SELECT,INSERT,DELETE,CREATE,UPDATE,ALTER,DROP ON *.* TO 'vig'@'%';

flush privileges;