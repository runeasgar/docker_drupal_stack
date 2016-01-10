# drupal_stack

**WORK IN PROGRESS - CURRENTLY ONLY SPINS UP WEB SERVER**

## Todo 
* Composer networking
* Drupal service
* * Apache allow override
* * webmin
* * phpmyadmin?
* MySQL service 
* * create
* * allow user to specify root password
* Varnish service
* * create
* * set default backend with varnish.vcl file in repo?

## About
This repo is for building docker images that include all the basics of Drupal 8 hosting: Varnish, Apache, MySQL. It also includes phpmyadmin, webmin, git, drush, and Drupal console.

To use this:
1. Install docker and docker compose.
2. Clone this repository.
3. While in the newly cloned repo directory, run: docker-compose up

You can then access the default site on port 80 (Varnish) or port 8080 (Apache) on the host machine.

You can manage files in Apache's /var/www directory by going to the var-www directory in the repo.
