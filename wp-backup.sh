# Simple Wordpress backup script to be run regularly.  I found this script online.  I have tested it several times and used it to clone
# the contents of the production server over to the development server.

#!/bin/bash
NOW=$(date +"%Y-%m-%d-%H%M")
FILE="filename.$NOW.tar"
BACKUP_DIR="/home"
WWW_DIR="/var/www/wordpress/"

DB_USER="user"
DB_PASS="password"
DB_NAME="database"
DB_FILE="wordpress.$NOW.sql"

WWW_TRANSFORM='s,^home/www/wordpress,www,'
DB_TRANSFORM='s,^home/backups,database,'

tar -cvf $BACKUP_DIR/$FILE --transform $WWW_TRANSFORM $WWW_DIR
mysqldump -u$DB_USER -p$DB_PASS $DB_NAME > $BACKUP_DIR/$DB_FILE

tar --append --file=$BACKUP_DIR/$FILE --transform $DB_TRANSFORM $BACKUP_DIR/$DB_FILE
rm $BACKUP_DIR/$DB_FILE
gzip -9 $BACKUP_DIR/$FILE
