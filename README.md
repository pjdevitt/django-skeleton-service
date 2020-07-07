# Django Skeleton Service

## Description

The Django Skeleton Service Development Environment was created in order to simplify the creation of a standard portable Django development environment. 

## Installation & Usage

### Install from repository
First you need to clone a copy of this repository into a directory of your choice:

```git clone https://github.com/pjdevitt/django-skeleton-service.git <your-app-name>```

### Start development server environment
At this point you should have a complete copy of the skeleton application.  You can start the development environment using docker-compose.

```$ cd <your-app-name>
$ docker-compose up -d
$ docker-compose exec web python manage.py makemigrations
$ docker-compose exec web python manage.py migrate
```
