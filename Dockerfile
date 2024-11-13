# Choose a base image (change as needed)
FROM ubuntu:20.04

# Set environment variables to avoid interactive prompts during installation
ENV DEBIAN_FRONTEND=noninteractive

# Install necessary packages based on OS (Ubuntu or CentOS)
RUN if [ -f /etc/debian_version ]; then \
      apt-get update && \
      apt-get install -y nginx mysql-server && \
      apt-get clean; \
    elif [ -f /etc/redhat-release ]; then \
      yum install -y epel-release && \
      yum install -y nginx mysql-server && \
      yum clean all; \
    else \
      echo "Unsupported OS"; \
      exit 1; \
    fi

# Expose the ports for the web server (nginx) and the MySQL database
EXPOSE 80 3306

# Copy a sample configuration or website to the container (optional)
# COPY ./my-website /usr/share/nginx/html/

# Start nginx and MySQL services (this will be the default command)
CMD service nginx start && service mysql start && tail -f /dev/null

