#!/bin/bash
/usr/bin/curl http://localhost/secret_trigger/ >> /var/log/trigger.log 2>&1
while true
do
 current_epoch=$(date +%s)
 target_epoch=$(date -d '+1 day 1AM' +%s)
 sleep_seconds=$(( $target_epoch - $current_epoch ))
 sleep $sleep_seconds
 /usr/bin/curl http://localhost/secret_trigger/ >> /var/log/trigger.log 2>&1
done