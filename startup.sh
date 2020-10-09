#!/bin/bash
GVMSTATE=""
restart_counter=0

if [$(ping -c 1 google.com | grep loss | awk '{print $6}') == "0%"]
    then 
        echo "updating the gvm vulnrability tests "
        gvm-feed-update
else
    echo "no internet detected, not updating"
fi

while [restart_counter <=1]
do
    if [$(systemctl status gvmd | grep Active | awk '{print $2}') == "inactive"]
        then $(gvm-start)
        restart_counter = restart_counter + 1
        GVMSTATE=$(systemctl status gvmd | grep Active | awk '{print $2}')
    else
        $(gvm-stop)
        GVMSTATE=$(systemctl status gvmd | grep Active | awk '{print $2}')
    fi
done

if [GVMSTATE = "inactive"]
    then
        echo "error starting gvmd"
        exit 1
else
    python3 /opt/scanner/flask/app.py
fi








