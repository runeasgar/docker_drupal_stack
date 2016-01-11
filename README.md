# drupal_stack

**WORK IN PROGRESS**

## Todo 
* Drupal service
  * Apache allow override
  * Move sites-enabled to a volume
  * Change var-www to just www (silly me)
  * webmin
  * phpmyadmin?
* MySQL service 
  * allow user to specify root password as part of composer up command

## About
This repo is for building docker images that include all the basics of Drupal 8 hosting: Varnish, Apache, MySQL. It also includes phpmyadmin, webmin, git, drush, and Drupal console.

To use this:

1. Install docker and docker compose.
2. Clone this repository.
3. While in the newly cloned repo directory, run: docker-compose --x-networking up -d

You can then access the default site on port 80 (Varnish) or port 8080 (Apache) on the host machine.

You can manage files in Apache's /var/www directory by going to the var-www directory in the repo.
