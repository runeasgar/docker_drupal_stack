# Docker Drupal Stack

## About
This repository is a work in progress, but I feel it is working well enough for beta! It is intended to launch a set of Docker containers that comprise all the basics of Drupal 8 hosting: Varnish, Web (Apache), MySQL. It also includes, vim, git, drush, and Drupal console.

## Using this repo
1. Install [docker](https://docs.docker.com/engine/installation/) and [docker compose](https://docs.docker.com/compose/install/), clone this repository, and change into the repository directory.
2. Run `export MYSQL_ROOT_PASSWORD=whatever`. 
  * It's important to note that MySQL will store this password as a part of its database(s), in a docker volume (mysql/data on the host). Hence, rebuilding or recreating the MySQL container will not affect this password - not even if you change this environment variable.
3. While in the newly cloned repo directory, run `docker-compose --x-networking up -d`.

When this is finished running, you will have 3 networked containers, each running a service: 
* Varnish with the hostname `drupal_varnish`, accessible via port 80 on docker host. 
  * If you opted out of step 3 above, you'll just get a simple message indicating successful set up.
* Apache with the hostname `drupal_web`, accessible via port 8080 on the docker host.
* MySQL with the hostname `drupal_mysql`, accessible via port 3306 to the other two containers.
  * `drupal_mysql` is also the MySQL server address you'll supply to Drupal installations.

## Next steps
Once your containers are all running, you can:
* Set up Drupal 8, which is pre-installed for you. The code is at /var/www/drupal, and is served as the default site.
* Don't forget to [create MySQL databases](https://www.drupal.org/documentation/install/create-database#mysql_commands) needed by your Drupal sites (including the pre-installed site). You'll need to create MySQL users `@'%'` because Drupal will connect from the IP of the web, not MySQL. The MySQL host will be `drupal_mysql`.
* [Manage](https://help.ubuntu.com/lts/serverguide/httpd.html) your Apache server to create additional sites.

## Improvements for the future
* webmin to manage your sites, databases, etc..
  * Maybe phpmyadmin if it ends up being warranted.

## Known problems
* MAJOR: Recreating the web or MySQL containers blows away things like Drupal's settings.php file and MySQL's databases. I'm currently unaware of a solution to this problem that wouldn't involve making Drupal a part of the repository.
* MODERATE: Because I'm explicitly naming containers (e.g., to enable Varnish to talk to Apache), you can't spin up more than one of these stacks on a docker host. Aside from being an inconvenience to end-users, it's also annoying for my testing purposes.
* MODERATE: Evidently the way I have Apache/PHP set up [prevents the settings.php file from being created automatically](https://www.drupal.org/documentation/install/settings-file). I'm creating the settings.php file and giving it write permissions as a part of my web build. Users have to fix its permissions after the Drupal install.
