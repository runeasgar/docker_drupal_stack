# docker_drupal_stack

## About
This repository is a WORK IN PROGRESS. It is intended to launch a set of Docker containers that comprise all the basics of Drupal 8 hosting: Varnish, Web (Apache), MySQL. It also includes, vim, git, drush, and Drupal console.

## Using this repo
1. Install [docker](https://docs.docker.com/engine/installation/) and [docker compose](https://docs.docker.com/compose/install/), clone this repository, and change into the repository directory.
2. (OPTIONAL) Load your Drupal codebase into `web/www/html` (e.g. web/www/html/index.php).
3. Run `export MYSQL_ROOT_PASSWORD=whatever`, replacing 'whatever' with the MySQL root password you want. This variable will also be required for rebuilds.
4. While in the newly cloned repo directory, run `docker-compose --x-networking up -d`.

When this is finished running, you will have 3 networked containers, each running a service: Varnish (port 80 on host), Web (Apache, port 8080 on host), and MySQL. If you opted out of step 4, you'll just get a simple message indicating successful set up.

## Next steps
Once your containers are all running, you can:
* Manage your Apache virtual hosts in the repository directory at `web/sites-enabled`.
* Manage the contents of `/var/www` on your web in the repository directory at `web/www`. The default site is in `web/www/html`.
* Create MySQL databases needed by your Drupal site(s).

## Improvements for the future
* webmin to manage your sites, databases, etc..
  * Maybe phpmyadmin if it ends up being warranted.

## Known problems
* Loading the MySQL root password into a variable on the Docker host is not ideal, but docker-compose doesn't support passing environment variables over the CLI.
* Loading Apache's apache2.conf and 000-default.conf files into the web from the repo decouples it from potential (albeit unlikely) apache2 updates.
