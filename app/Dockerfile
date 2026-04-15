# Use official Apache image
FROM httpd:2.4

# Remove default Apache welcome page
RUN rm -rf /usr/local/apache2/htdocs/*

# Copy site files into Apache web root
COPY ./index.html /usr/local/apache2/htdocs/index.html
COPY ./upload.html /usr/local/apache2/htdocs/upload.html
COPY ./index.js /usr/local/apache2/htdocs/index.js
COPY ./upload.js /usr/local/apache2/htdocs/upload.js

# Expose port 80
EXPOSE 80