## DEMO WEBSERVER
# Base operating system image based on centos 7 
FROM	registry.access.redhat.com/rhel7

# Metadata information 
LABEL	maintainer=dockergiri@hotmail.com

# Enviornment variable
ENV TERM=xterm

# Argument for passing secure password 
# ARG password

# Copying Index file
COPY	index.html /var/www/html/index.html


# Demo to show ARG usage 
# RUN	echo "${password}"

# Package installation and configuration changes
RUN 	yum install -y httpd && yum clean all -y && \
    	sed -i 's/Listen 80/Listen 8080/' /etc/httpd/conf/httpd.conf && \
        useradd webuser && \
	echo webuser:redhat | chpasswd && \
#    	echo webuser:${password} | chpasswd && \
    	chmod -R a+rwx /run/httpd /etc/httpd/logs
# Working directory 
WORKDIR /

# Listen on below port
EXPOSE 8080

# User 
USER webuser 

# Always execute entry point
ENTRYPOINT	["/usr/sbin/httpd"]

# Run process in foregroud as a parameter
CMD		["-DFOREGROUND"] 
