@echo off
setlocal EnableDelayedExpansion

where git >nul 2>&1 || (echo git not found && exit /b 1)
where docker >nul 2>&1 || (echo docker not found && exit /b 1)

git clone https://github.com/drlolwat/BotBuddyWeb
cd BotBuddyWeb

docker run --rm -it ^
    -v %cd%:/var/www/html ^
    -w /var/www/html ^
    laravelsail/php84-composer:latest ^
    composer install --ignore-platform-reqs

git clone https://github.com/drlolwat/GoMaster
git clone https://github.com/drlolwat/GoAgent
git clone https://github.com/drlolwat/ScriptWrapper

copy .env.example .env

set /p MYSQL_PASSWORD=Enter a password for the MySQL database:

powershell -Command "(Get-Content .env) -replace '^DB_PASSWORD=.*', 'DB_PASSWORD=%MYSQL_PASSWORD%' | Set-Content .env"

docker compose up -d

docker compose exec php sh -c "cd /var/www/html/scriptwrapper && MAVEN_OPTS='-Dmaven.repo.local=/tmp/.m2/repository' mvn clean package && mv /var/www/html/scriptwrapper/DreamBot/Scripts/BotBuddyWrapper-2.0-nodist.jar /var/www/html/public/BotBuddyWrapper-2.0-dist.jar"

docker compose exec php php artisan key:generate
docker compose exec php npm install
docker compose exec php npm run build
docker compose exec php php artisan migrate
docker compose exec php php artisan db:seed

echo Setup complete. Visit http://localhost to access BotBuddy
pause
