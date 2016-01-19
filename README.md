# Docker Drupal Stack

## About
This repository is a work in progress, but I feel it is working well enough for beta! It is intended to launch a set of Docker containers that comprise all the basics of Drupal 8 hosting: Varnish, Web (Apache), PHP (FPM), and MySQL. It also includes, vim, git, drush, and Drupal console.

## Using this repo
1. Install [docker](https://docs.docker.com/engine/installation/) and [docker compose](https://docs.docker.com/compose/install/), clone this repository, and change into the repository directory.
2. Run `export MYSQL_ROOT_PASSWORD=whatever`.
  * It's important to note that MySQL will store this password as a part of its database(s), in a docker volume (mysql/data on the host). Hence, rebuilding or recreating the MySQL container will not affect this password - not even if you change this environment variable.
3. While in the newly cloned repo directory, run `docker-compose --x-networking up -d`.

When this is finished running, you will have 4 networked containers, each running a service: 
* Varnish with the hostname `drupal_varnish_1`, accessible via port 80 on docker host. 
* Apache with the hostname `drupal_web_1`, accessible via port 8080 on the docker host.
* PHP-FPM with the hostname `drupal_php_fpm_1`, accessible via port 9000 to the other two containers.
* MySQL with the hostname `drupal_mysql_1`, accessible via port 3306 to the other two containers.
  * `drupal_mysql_1` is also the MySQL server address you'll supply to Drupal installations.

## Next steps
Once your containers are all running, you can:
* Set up Drupal 8, which is pre-installed for you. The code is at /var/www/, and is served as the default site.
* Don't forget to [create MySQL databases](https://www.drupal.org/documentation/install/create-database#mysql_commands) needed by your Drupal sites (including the pre-installed site).
  * You'll need to create MySQL users `@'%'` because Drupal will connect from the IP of the web, not MySQL.
* [Manage](https://help.ubuntu.com/lts/serverguide/httpd.html) your Apache server to create additional sites.
  * If you want to disable the default site, move /etc/apache2/sites-enabled/0000-default.conf to sites-available. Do NOT remove /var/www/html - it will mess up the entrypoint.sh script.

See the "Issues" tab for a list of known issues and future improvements.
