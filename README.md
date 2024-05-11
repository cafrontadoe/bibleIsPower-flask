**Flask BibleIsPower Backend**
This Flask application serves as the backend for the BibleIsPower project. It provides a REST API for interacting with the database containing multilingual Bible data.

**Dependencies**
Flask==2.0.2
mysql-connector-python==8.0.28

**Getting Started**
**Prerequisites**
**Docker installed on your system (installation guide)**


**Build the Docker image:**
`docker build -t cfrontado/flask-bibleispower-back:1.0 -f flask.dockerfile .`
not neccesary

**pull image**
`docker pull cfrontado/flask-bibleispower-back:1.0`

**List images in your machine**
`docker images`

**Create a Network**
`docker network create --driver bridge isolate_network`

**Running the Docker Container**
Once the Docker image is built, you can run a container from it using the following command:
`docker container run -d --net=isolate_network -p 5000:5000 --name flask-backend cfrontado/flask-bibleispower-back:1.0`

**Docker logs**
`docker logs container_id`

**Delete all images**
`docker rmi -f $(docker images -aq)`
¨
**Delete all containers**
`docker rm -f $(docker ps -aq)`


**show all containers**
`docker ps -a`




**Background Execution:** 
The -d flag in the docker run command indicates that the container should be run in detached mode, meaning it runs in the background. This allows you to continue using the terminal while the container runs in the background.

**Port Mapping:**
The -p 5000:5000 flag in the docker run command maps port 5000 on the host to port 5000 inside the container. This enables you to access your Flask application running inside the container through port 5000 on your host machine.

**Remove image**
`docker rmi c3d`
add the first three characters of the container's id to remove it

**Listing containers**
`docker ps --all`

**Remove a container**
`docker rm -f container_id/container_name`

This command starts a Docker container named flask-backend from the cfrontado/flask-bibleispower-back image. It maps port 5000 on the host to port 5000 inside the container, allowing you to access the Flask app running inside the container.

Accessing the REST API
You can access the REST API at http://localhost:5000. Make sure the Docker container is running before making requests to the API.