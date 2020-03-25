
#Install elastic search

brew install elasticsearch nginx

# your preference on /opt or not
mkdir /opt
sudo chown $USER /opt

# unpack logstash and very valuable contrib tarballs
cd /opt
tar xzf ~/Downloads/logstash-*2.tar.gz

# put kibana in nginx
cd /usr/local/var/www
tar xzf ~/Downloads/kibana-*.tar.gz
mv kibana-* kibana

# edit config.js with your hostname
vi kibana/config.js

# line 32 - read the comments on why you might not want localhost here
# for dev box only
# echo "elasticsearch: 'http://localhost:9200'",

# the services command is from the brew/tap at the top, love it
$ brew services restart elasticsearch
