FROM centos:7
RUN mkdir /app
#Repo for mod_wsgi and recent httpd(2.4.41 01.15.2020)
RUN yum -y install  \
    https://repo.ius.io/ius-release-el7.rpm \ 
    https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm

#Install apache2.4 python 3.6 mod_wsgi
RUN yum -y install httpd24u python36 python36-mod_wsgi python3-pip
WORKDIR /app
COPY requirements.txt /app/
RUN pip3 install -r requirements.txt
ADD httpd_blog.conf /etc/httpd/conf.d/
COPY . /app/
RUN chgrp apache db.sqlite3
RUN chgrp apache /app
RUN chgrp -R apache /app/media
RUN chmod 775 /app
RUN chmod 775 /app/media
RUN python3 manage.py collectstatic
EXPOSE 80
ENTRYPOINT ["/usr/sbin/httpd","-D","FOREGROUND"]
