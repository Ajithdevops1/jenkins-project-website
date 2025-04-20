# Use a base image with system tools
FROM ubuntu:22.04

# Set environment variables
ENV DEBIAN_FRONTEND=noninteractive

# Update and install required tools
RUN apt-get update && apt-get install -y \
    curl \
    gnupg2 \
    openjdk-11-jdk \
    python3 \
    python3-pip \
    git \
    sudo

# Install Python dependencies
COPY requirements.txt .
RUN pip3 install -r requirements.txt

# Install Jenkins
RUN curl -fsSL https://pkg.jenkins.io/debian/jenkins.io-2023.key | tee \
    /usr/share/keyrings/jenkins-keyring.asc > /dev/null && \
    echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] \
    https://pkg.jenkins.io/debian binary/ | tee \
    /etc/apt/sources.list.d/jenkins.list > /dev/null && \
    apt-get update && apt-get install -y jenkins

# Copy Flask app
COPY app.py /app/app.py
WORKDIR /app

# Expose ports
EXPOSE 5000 8080

# Run Jenkins and Flask in the same container
CMD ["sh", "-c", "service jenkins start && python3 /app/app.py"]
