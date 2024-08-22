# Use the official Node.js image
FROM node:21

# Set the working directory
WORKDIR /app

# Install git
RUN apt-get update && \
    apt-get install -y git

# Authorize SSH Host
RUN mkdir -p /root/.ssh && \
    chmod 0700 /root/.ssh && \
    ssh-keyscan github.com > /root/.ssh/known_hosts

# Add the SSH key and set permissions
COPY "$G_KEY" | base64 --decode /root/.ssh/id_rsa
RUN chmod 600 /root/.ssh/id_rsa

# Clone your GitHub repository
RUN git clone git@github.com:"$G_USERNAME"/"$G_REPOSITORY".git

# Set the working directory to the cloned repository
WORKDIR /app/repository

# Install project dependencies
RUN npm install

# Start the application
CMD ["npm", "start"]
