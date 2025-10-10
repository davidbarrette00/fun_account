@echo off

call flutter pub get
call flutter build web
call docker build -t "davidbarrette00/fun_account-website:master" .
call docker push "davidbarrette00/fun_account-website:master"