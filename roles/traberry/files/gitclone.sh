#!/bin/bash

NOW=`date +%Y%m%d-%H%M%S`
cd /opt
mv VisaCreator VisaCreator.$NOW
GIT_SSH=/tmp/gitssh.sh git clone git@github.com:shohey1226/VisaCreator.git
rm /tmp/jenkins
