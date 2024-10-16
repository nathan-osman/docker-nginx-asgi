FROM ubuntu:latest

ENV HTTP_HOST=localhost

# This is the directory where the user is expected to place their code
WORKDIR /usr/src/app

# Install Nginx, Python 3 (and pip) and supervisor
RUN apt-get update && apt-get install -y \
  curl \
  nginx \
  python-is-python3 \
  python3-pip \
  supervisor \
  && rm -rf /var/lib/apt/lists/*

# Copy the pip configuration (to prevent errors when installing global packages)
COPY pip/pip.conf /root/.config/pip/pip.conf

# Install Daphne (ASGI server)
RUN pip install --no-cache-dir Daphne

# Overwrite the default Nginx site config
COPY nginx/default /etc/nginx/sites-available/

# Create the directory used for configuring the default site
RUN mkdir -p /etc/nginx/asgi.d

# Copy the daphne site config
COPY nginx/daphne.conf /etc/nginx/asgi.d/

# Copy the supervisor config
COPY supervisor/supervisord.conf /etc/supervisor/conf.d/

# Run supervisord when started
CMD ["/usr/bin/supervisord"]

# Application is up and running when it responds to HTTP requests
HEALTHCHECK CMD \
  curl -s -o /dev/null -H "Host: $HTTP_HOST" http://localhost || exit 1
