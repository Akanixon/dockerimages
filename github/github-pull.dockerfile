# Use the official Node.js image
FROM node:21

# Set the working directory
WORKDIR /app

# Install git
RUN apt-get update && \
    apt-get install -y git

# Authorize SSH Host
RUN ssh-keyscan github.com > /root/.ssh/known_hosts

COPY /root/key /root/.ssh/id_rsa

# Add the SSH key and set permissions
RUN chmod 600 /root/.ssh/id_rsa

# Clone your GitHub repository
ARG G_USERNAME
ARG G_REPOSITORY
RUN GIT_SSH_COMMAND="ssh -i /root/.ssh/id_rsa" git clone git@github.com:$G_USERNAME/$G_REPOSITORY.git

# Set the working directory to the cloned repository
WORKDIR /app/repository

# Install project dependencies
RUN npm install

# Start the application
CMD ["npm", "start"]
