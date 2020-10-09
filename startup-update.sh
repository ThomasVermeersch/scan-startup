#!/bin/bash
wd = "/home/scan"
git_repo="https://github.com/ThomasVermeersch/scan-startup.git"
cd ${cwd}

if [$(ls | grep startup-update) = "startup-update"]
    then cd startup-update
    git pull
else
    git clone git_repo
    cp scan-startup/ /opt/
fi