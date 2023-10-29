# docker-nginx-asgi
This Docker image provides an Nginx installation that is configured for running ASGI applications.

## Using the Image
This image is designed to be very easy to use in your Dockerfile:

    FROM nathanosman/nginx-asgi

    # Copy the 'app' folder (uses /usr/src/app by default)
    COPY . .

    # Specify the path to your ASGI application
    ENV ASGI_APPLICATION=path.to.asgi:application

It's that easy!

## Customizing Nginx

If you need to add extra Nginx configuration (to serve static files, for example), simply put it in a .conf file:

    location /static/ {
        root /usr/src/app/static;
    }

...and copy it into `/etc/nginx/asgi.d` in your Dockerfile:

    COPY static.conf /etc/nginx/asgi.d/
