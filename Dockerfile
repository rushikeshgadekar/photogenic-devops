# Use Ubuntu as the base image
FROM ubuntu:latest

# Install necessary tools
RUN apt-get update && \
    apt-get install -y apache2 wget unzip && \
    apt-get clean

# Define variables
ENV ZIP_URL=https://www.free-css.com/assets/files/free-css-templates/download/page254/photogenic.zip

WORKDIR /var/www/html

# Download the zip file and extract it to the destination directory
RUN wget  $ZIP_URL && \
    unzip photogenic.zip -d /var/www/html/ && \
    rm -f photogenic.zip && \
    mv photogenic/* .

# Set up Apache to run in the foreground
RUN echo "ServerName localhost" >> /etc/apache2/apache2.conf

# Set working directory
EXPOSE 80 22
# Start Apache in the foreground
CMD ["/usr/sbin/apache2ctl", "-D", "FOREGROUND"]
