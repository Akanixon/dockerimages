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

# Set the working directory
WORKDIR /app

# Clone your GitHub repository
RUN mkdir -p /run/secrets
RUN GIT_SSH_COMMAND="ssh -i /run/secrets/key" git clone git@github.com:Akanixon/Wishbot.git

# Set the working directory to the cloned repository
WORKDIR /app/$G_REPOSITORY

# Install project dependencies
RUN npm install

# Start the application
CMD ["npm", "start"]
