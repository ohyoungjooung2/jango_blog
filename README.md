# jango_blog
 Jango-blog dockerized.

```
Requirements:docker and linux distro.(Centos7, or Ubuntu 18.04)
oyj@controller:~/jango_blog$ docker --version
Docker version 19.03.5, build 633a0ea838

```

1. Docker based build and deploy.
```
oyj@controller:~$ git clone https://github.com/ohyoungjooung2/jango_blog.git
Cloning into 'jango_blog'...
remote: Enumerating objects: 8413, done.
remote: Counting objects: 100% (8413/8413), done.
remote: Compressing objects: 100% (5095/5095), done.
remote: Total 8413 (delta 2303), reused 8395 (delta 2296), pack-reused 0
Receiving objects: 100% (8413/8413), 12.79 MiB | 5.66 MiB/s, done.
Resolving deltas: 100% (2303/2303), done.

oyj@controller:~/jango_blog$ docker build . -t jang-blog:1.3
Sending build context to Docker daemon  116.7MB
Step 1/17 : FROM centos:7
 ---> 5e35e350aded
Step 2/17 : RUN mkdir /app
 ---> Using cache
...

oyj@controller:~/jango_blog$ docker image ls | grep 1.3
jang-blog           1.3                 0e0721a6ce49        About a minute ago   604MB


oyj@controller:~/jango_blog$ docker run -d -p 8000:80 jang-blog:1.3
1d103ad5ad83fa08b934211762e273c4fcd0636a827b7f4edc8cda39b1fa7b3d
oyj@controller:~/jango_blog$ docker ps
CONTAINER ID        IMAGE               COMMAND                  CREATED             STATUS              PORTS                  NAMES
1d103ad5ad83        jang-blog:1.3       "/usr/sbin/httpd -D …"   5 seconds ago       Up 3 seconds        0.0.0.0:8000->80/tcp   modest_galileo
oyj@controller:~/jango_blog$ curl http://localhost:8000

<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
    <link rel="stylesheet" type="text/css" href="/static/blog/main.css">
  
     <title>Django Blog</title>

```
