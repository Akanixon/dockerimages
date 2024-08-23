# Use the official Node.js image
FROM node:21

# Install git
RUN apt-get update && \
    apt-get install -y git

# Authorize SSH Host
RUN mkdir -p /root/.ssh && \
    chmod 0700 /root/.ssh && \
    ssh-keyscan github.com >> /root/.ssh/known_hosts

# Add the SSH key and set permissions
COPY id_rsa /root/.ssh/id_rsa /root/key /root/.ssh/id_rsa 
RUN chmod 600 /root/.ssh/id_rsa

# Set the working directory
WORKDIR /app

# Clone your GitHub repository
ARG G_USERNAME
ARG G_REPOSITORY
RUN GIT_SSH_COMMAND="ssh -i /root/.ssh/id_rsa" git clone git@github.com:$G_USERNAME/$G_REPOSITORY.git

# Set the working directory to the cloned repository
WORKDIR /app/$G_REPOSITORY

# Install project dependencies
RUN npm install

# Start the application
CMD ["npm", "start"]
