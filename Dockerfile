FROM ubuntu:latest

# This is the directory where the user is expected to place their code
WORKDIR /usr/src/app

# Install Nginx, Python 3 (and pip) and supervisor
RUN apt-get update && apt-get install -y \
  nginx \
  python-is-python3 \
  python3-pip \
  supervisor \
  && rm -rf /var/lib/apt/lists/*

# Copy the pip configuration (to prevent errors when installing global packages)
COPY pip.conf /root/.config/pip/pip.conf
