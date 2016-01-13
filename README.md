# docker_drupal_stack

**WORK IN PROGRESS**

## About
This repo is for building docker images that include all the basics of Drupal 8 hosting: Varnish, Web (Apache), MySQL. It also includes, vim, git, drush, and Drupal console.

To use this:

1. Install [docker](https://docs.docker.com/engine/installation/) and [docker compose](https://docs.docker.com/compose/install/).
2. Clone this repository.
3. Change directory to the repo.
4. (OPTIONAL) Load your Drupal codebase into `./web/www/html` (e.g. ./www/html/index.php).
4. Run `echo 'MYSQL_ROOT_PASSWORD=whatever' > .env`, replacing 'whatever' with the MySQL root password you want.
5. While in the newly cloned repo directory, run `docker-compose --x-networking up -d`.

When this is finished running, you will have 3 containers, each running a server: Varnish, Web (Apache), and MySQL. They are all networked together. Varnish will be exposed over port 80 on your host (e.g., http://localhost), Apache over port 8080 (e.g., http://localhost:8080).

* If you opted out of step 4, the stack will serve a simple PHP script that will output the message "Apache and PHP set up.". 
* MySQL will not have any databases set up - you'll need to do that yourself. 
* You can manage all your website code from the repository's web/www directory (which corresponds to /var/www in the web container).

## Improvements for the future
* Web service
  * Apache will allow .htaccess overrides in /var/www.
  * The web's sites-enabled directory will be mapped to a volume so it is preserved when the web is recreated.
  * webmin to manage your sites, databases, etc..
    * Maybe phpmyadmin if it ends up being warranted.
* MySQL service
  * allow user to specify root password as part of composer up command
