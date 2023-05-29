# Base image
FROM jenkins/jenkins:lts

# Switch to the root user
USER root

# Install necessary packages and dependencies
RUN apt-get update \
    && apt-get install -y python3 python3-pip \
    && rm -rf /var/lib/apt/lists/*

# Install required Python packages
RUN pip3 install --upgrade pip \
    && pip3 install virtualenv

# Limpa arquivos baixados com apt-get
RUN apt-get clean

# Switch back to the Jenkins user
USER jenkins

# Expose Jenkins port
EXPOSE 8080

# Set the entrypoint command to start Jenkins
ENTRYPOINT ["/sbin/tini", "--", "/usr/local/bin/jenkins.sh"]

USER jenkins