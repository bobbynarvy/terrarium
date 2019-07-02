# install MongoDB
apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 9DA31620334BD75D9DCB49F368818C72E52529D4
echo "deb [ arch=amd64 ] https://repo.mongodb.org/apt/ubuntu bionic/mongodb-org/4.0 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-4.0.list
apt update
apt install -y mongodb-org

# create directory for MongoDB storage
mkdir /data
mkdir /data/db

# start MongoDB process by making it accessible publicly
# and by setting the replica set name
# WARNING: This is configuration is highly insecure. 
# Done only for demonstration purposes.
mongod --replSet "replicaTest" --bind_ip 0.0.0.0 --fork --logpath /var/log/mongod.log