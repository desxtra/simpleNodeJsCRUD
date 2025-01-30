#!/bin/bash -xe

# update
sudo yum update -y
sudo yum install git -y
sudo yum install nginx -y

# configuring the proxy
cat <<EOF > /etc/nginx/sites-available/myapp
server {
    listen 80;
    server_name localhost;

    location / {
        proxy_pass http://localhost:3000;
        proxy_http_version 1.1;
        proxy_set_header Upgrade \$http_upgrade;
        proxy_set_header Connection 'upgrade';
        proxy_set_header Host \$host;
        proxy_cache_bypass \$http_upgrade;
    }
}
EOF

ln -s /etc/nginx/sites-available/myapp /etc/nginx/sites-enabled/
nginx -t
systemctl restart nginx

# preparing the project
git clone https://github.com/desxtra/simpleNodeJsCRUD.git
cd simpleNodeJsCRUD

# installing nodejs 18
curl -fsSL https://rpm.nodesource.com/setup_18.x | sudo bash -

# install dependencies
npm install --yes

# start the CRUD
npm start