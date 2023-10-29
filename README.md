# docker-nginx-asgi
This Docker image provides an Nginx installation that is configured for running ASGI applications.

## Using the Image
This image is designed to be customized:

    FROM nathanosman/nginx-asgi

    # Specify the path to your ASGI application
    ENV ASGI_APPLICATION=path.to.asgi:application

    # Copy the 'app' folder
    COPY app .

    # Install any packages
    RUN pip install --no-cache-dir -r requirements.txt
