FROM ubuntu:20.04

# Avoid prompts during install
ENV DEBIAN_FRONTEND=noninteractive

# Install dependencies
RUN apt update && \
    apt install -y python3 python3-pip openjdk-11-jdk curl wget supervisor && \
    pip3 install flask

# Install Jenkins
RUN mkdir -p /usr/share/jenkins && \
    wget https://get.jenkins.io/war-stable/2.426.1/jenkins.war -O /usr/share/jenkins/jenkins.war

# Create app directory and copy Flask app
RUN mkdir /app
COPY app.py /app/

# Copy supervisord config
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# Expose Flask (5000) and Jenkins (8080) ports
EXPOSE 5000 8080

# Start both services
CMD ["/usr/bin/supervisord", "-n"]
