# FROM ubuntu:18.04

# # Set the locale
# ENV LANG=C.UTF-8

# # Update package lists and upgrade existing packages
# RUN apt-get update && apt-get upgrade -y

# # Install Python 3.7 (or any later version available)
# RUN apt-get install -y python3.7 python3.7-dev python3-pip

# # Remove the existing symbolic link for python3 if it exists
# RUN rm -f /usr/bin/python3

# # Create a new symbolic link for python3.7 to python3
# RUN ln -s /usr/bin/python3.7 /usr/bin/python3

# # Update pip
# RUN python3 -m pip install --upgrade pip

# # Set the locale for Python
# RUN apt-get install -y locales \
#     && locale-gen en_US.UTF-8 \
#     && dpkg-reconfigure --frontend=noninteractive locales \
#     && update-locale LANG=en_US.UTF-8

# # Create and set working directory
# WORKDIR /app

# # Copy requirements file
# COPY requirements.txt .

# # Install Python dependencies
# RUN pip3 install --no-cache-dir -r requirements.txt

# # Copy the rest of the application files
# COPY . /app

# EXPOSE 5000

# # Set the command to run the Flask application
# CMD ["python3", "-m", "flask", "run", "--host=0.0.0.0"]



# Use a Python base image
FROM python:3.11

# Set the working directory in the container
WORKDIR /app

# Copy requirements file
COPY requirements.txt .

# Install Python dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Copy the rest of the application files
COPY . /app

# Expose port 5000
EXPOSE 5000

# Set the command to run the Flask application
CMD ["gunicorn", "-w", "4", "-t", "30", "--max-requests", "1000", "--access-logfile", "-", "--error-logfile", "-", "--log-level", "debug", "-b", "0.0.0.0:5000", "app:app"]
