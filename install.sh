#!/bin/bash
set -e

command -v git >/dev/null || { echo "git not found"; exit 1; }
command -v docker >/dev/null || { echo "docker not found"; exit 1; }

git clone https://gitlab.botbuddy.net/botbuddy/web
cd web

docker run --rm -it \
    -u "$(id -u):$(id -g)" \
    -v "$(pwd)":/var/www/html \
    -w /var/www/html \
    laravelsail/php84-composer:latest \
    composer install --ignore-platform-reqs

git clone http://gitlab.botbuddy.net/botbuddy/gomaster
git clone http://gitlab.botbuddy.net/botbuddy/goagent
git clone http://gitlab.botbuddy.net/botbuddy/scriptwrapper

cp .env.example .env
read -p "Enter a password for the MySQL database: " MYSQL_PASSWORD
echo

sed -i '' "s/^DB_PASSWORD=.*/DB_PASSWORD=${MYSQL_PASSWORD}/" .env 2>/dev/null || \
sed -i "s/^DB_PASSWORD=.*/DB_PASSWORD=${MYSQL_PASSWORD}/" .env

docker compose up -d

docker compose exec php sh -c "cd /var/www/html/scriptwrapper && MAVEN_OPTS=\"-Dmaven.repo.local=/tmp/.m2/repository\" mvn clean package && mv /var/www/html/scriptwrapper/DreamBot/Scripts/BotBuddyWrapper-2.0-nodist.jar /var/www/html/public/BotBuddyWrapper-2.0-dist.jar"

docker compose exec php php artisan key:generate

docker compose exec php npm install
docker compose exec php npm run build

docker compose exec php php artisan migrate
docker compose exec php php artisan db:seed

echo "Setup complete. Visit http://localhost to access BotBuddy"
