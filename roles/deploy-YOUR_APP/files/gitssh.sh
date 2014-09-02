#!/bin/sh
exec ssh -i /tmp/jenkins -o StrictHostKeyChecking=no "$@"

