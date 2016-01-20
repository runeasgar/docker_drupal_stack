# Docker Drupal Stack

## About
This repository is a work in progress, but I feel it is working well enough for beta! It is intended to launch a set of Docker containers that comprise all the basics of Drupal 8 hosting: Varnish, Web (Apache), PHP (FPM), and MySQL. It also includes, vim, git, drush, and Drupal console.

## Quick Start
1. Install [docker](https://docs.docker.com/engine/installation/) and [docker compose](https://docs.docker.com/compose/install/), clone this repository, and change into the repository directory.
2. `git clone git@github.com:runeasgar/docker_drupal_stack.git && cd docker_drupal_stack`
3. `export MYSQL_ROOT_PASSWORD=whatever`.
  * It's important to note that MySQL will store this password as a part of its database(s), in a docker volume (mysql/data on the host). Hence, rebuilding or recreating the MySQL container will not affect this password - not even if you change this environment variable.
4. `docker-compose -p drupal --x-networking up -d`.
  * You may have to run this more than once, because Docker Compose does not spin up containers in a pre-determined order.

## What you get
When this is finished running, you will have 4 networked containers, each running a service: 
| Service | Hostname | Network Port | Host Port |
| --- | --- |:---:|:---:|
|Varnish|drupal_varnish_1|80|80|
|Apache|drupal-web_1|80|8080|
|PHP-FPM|drupal_php_fpm_1| |9000|
|MySQL|drupal_mysql_1| |3306|

| First Header  | Second Header |
| ------------- | ------------- |
| Content Cell  | Content Cell  |
| Content Cell  | Content Cell  |

## Next steps
Once your containers are all running, you can:
* Set up Drupal 8, which is pre-installed for you. The code is at /var/www/, and is served as the default site.
* Don't forget to [create MySQL databases](https://www.drupal.org/documentation/install/create-database#mysql_commands) needed by your Drupal sites (including the pre-installed site).
  * You'll need to create MySQL users `@'%'` because Drupal will connect from the IP of the web, not MySQL.
* [Manage](https://help.ubuntu.com/lts/serverguide/httpd.html) your Apache server to create additional sites.
  * If you want to disable the default site, move /etc/apache2/sites-enabled/0000-default.conf to sites-available. Do NOT remove /var/www/html - it will mess up the entrypoint.sh script.

See the "Issues" tab for a list of known issues and future improvements.
