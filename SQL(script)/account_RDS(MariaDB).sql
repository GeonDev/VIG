use mysql;

create user 'vig'@'54.180.131.236' identified by 'vig';
create user 'vig'@'%' identified by 'vig';

GRANT SELECT,INSERT,DELETE,CREATE,UPDATE,ALTER,DROP ON *.* TO 'vig'@'54.180.131.236';
GRANT SELECT,INSERT,DELETE,CREATE,UPDATE,ALTER,DROP ON *.* TO 'vig'@'%';

flush privileges;