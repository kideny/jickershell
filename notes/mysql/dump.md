# go to /mysql/bin ，and use mysqldump to backup database
cd /mysql/bin
mysqldump -u root -p database-name > /www/backup/mysql/test.sql