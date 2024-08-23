# Use the official Node.js image
FROM node:21

# Install git
RUN apt-get update && \
    apt-get install -y git
WORKDIR /home/node
# Authorize SSH Host
RUN mkdir -p .ssh && \
    chmod 0700 .ssh && \
    ssh-keyscan github.com >> .ssh/known_hosts

# Add the SSH key and set permissions
COPY key .ssh/id_rsa 
RUN chmod 600 .ssh/id_rsa

# Set the working directory
WORKDIR /app

# Clone your GitHub repository
ARG G_USERNAME
ARG G_REPOSITORY
RUN GIT_SSH_COMMAND="ssh -i /../.ssh/id_rsa" git clone git@github.com:$G_USERNAME/$G_REPOSITORY.git

# Set the working directory to the cloned repository
WORKDIR /app/$G_REPOSITORY

# Install project dependencies
RUN npm install

# Start the application
CMD ["npm", "start"]
