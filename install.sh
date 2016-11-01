sudo apt-get --no-install-recommends -y install \
    build-essential pkg-config erlang \
    libicu-dev libmozjs185-dev libcurl4-openssl-dev

sudo adduser --system \
        --shell /bin/bash \
        --group --gecos \
        "CouchDB Administrator" couchdb

./configure
make release

sudo cp -R ./rel/couchdb /home/couchdb
sudo chown -R couchdb:couchdb /home/couchdb/couchdb
sudo find /home/couchdb/couchdb -type d -exec chmod 0770 {} \;
sudo chmod 0644 /home/couchdb/couchdb/etc/*

sudo cat <<EOT >> /usr/local/bin/couchdb
#!/bin/bash
sudo -i -u couchdb /home/couchdb/couchdb/bin/couchdb
EOT

sudo chmod 777 /usr/local/bin/couchdb