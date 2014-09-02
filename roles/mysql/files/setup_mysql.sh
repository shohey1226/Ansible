#!/bin/bash

echo "/usr/bin/mysqladmin -u root password $MYSQL_ROOT_PASS"
/usr/bin/mysqladmin -u root -h localhost password $MYSQL_ROOT_PASS

