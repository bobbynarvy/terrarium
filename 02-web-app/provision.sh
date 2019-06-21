apt update

# install node and npm
apt install -y nodejs npm

# check node version
nodejs -v

# install unzip
apt install -y unzip

# add github to ssh known_hosts
ssh-keyscan github.com >> ~/.ssh/known_hosts

# download node app git repo and run it
wget https://github.com/heroku/node-js-sample/archive/master.zip
unzip master.zip
cd node-js-sample-master
npm install
npm install forever -g

# run app in the background
forever start index.js
echo "App running at localhost:5000"