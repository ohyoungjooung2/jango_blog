FROM centos:7
RUN mkdir /app
#Repo for mod_wsgi and recent httpd(2.4.41 01.15.2020)
RUN yum -y install  \
    https://repo.ius.io/ius-release-el7.rpm \ 
    https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
RUN yum -y install gcc make

#Install apache2.4 python 3.6 mod_wsgi
RUN yum -y install httpd24u python36 python36-mod_wsgi python3-pip

#Sqlite upgrade for django 2.2.x
RUN curl -o sqlite329.tar.gz https://www.sqlite.org/2019/sqlite-autoconf-3290000.tar.gz
RUN tar xvzf sqlite329.tar.gz
WORKDIR /sqlite-autoconf-3290000 
RUN    ./configure --prefix=/opt/sqlite 
RUN make  
RUN make install 
RUN echo "export PATH=/opt/sqlite/bin:$PATH" >> /root/.bashrc
RUN export PATH=/opt/sqlite/bin:$PATH
RUN echo "export LD_LIBRARY_PATH=/opt/sqlite/lib" >> /root/.bashrc
RUN export LD_LIBRARY_PATH=/opt/sqlite/lib
RUN echo "export LD_RUN_PATH=/opt/sqlite/lib" >> /root/.bashrc
RUN export LD_RUN_PATH=/opt/sqlite/lib
RUN echo $PATH
RUN mv /usr/bin/sqlite3 /usr/bin/sqlite3.old 
RUN ln -s /opt/sqlite/bin/sqlite3 /usr/bin/sqlite3


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
RUN ["/bin/bash","-c","source /root/.bashrc"]
RUN ["/bin/sh","-c", "python3 manage.py collectstatic"]
EXPOSE 80
ENTRYPOINT ["/usr/sbin/httpd","-D","FOREGROUND"]
