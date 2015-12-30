FROM ubuntu:latest

RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 7F0CEB10
RUN echo "deb http://repo.mongodb.org/apt/ubuntu "$(lsb_release -sc)"/mongodb-org/3.0 multiverse" | tee /etc/apt/sources.list.d/mongodb-org-3.0.list

# Update apt-get sources AND install MongoDB
RUN apt-get update && apt-get install -y mongodb-org

# Create the MongoDB data directory
RUN mkdir -p /data/db

# Install node
RUN apt-get install -y nodejs-legacy
RUN apt-get install -y npm

# Copy restful-booker across
RUN mkdir /restful-booker

COPY ./ /restful-booker/

RUN cd /restful-booker && npm install

CMD mongod & cd /restful-booker && npm start