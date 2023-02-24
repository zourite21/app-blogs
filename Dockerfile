# Use an official Alpine image as the base image
FROM python:3.11-alpine

# Set the working directory to /app

WORKDIR /app
RUN mkdir log

# Copy the current directory contents into the container at /app
COPY . /app

# Install necessary packages and dependencies
RUN apk add --no-cache --virtual .build-deps \
    build-base \
    libffi-dev \
    openssl-dev \
    && apk add --no-cache \
    libpq

# Install the Python packages specified in requirements.txt
RUN pip install --no-cache-dir -r requirements.txt

# Set the environment variables for Flask
ENV FLASK_APP=app.py
ENV FLASK_ENV=development

# Expose port 5000 to allow connections to the Flask application
EXPOSE 5000

# Define the command to run the Flask application
CMD ["flask", "run", "--host=0.0.0.0"]
