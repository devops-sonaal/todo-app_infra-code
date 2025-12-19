apt update && apt install -y nginx
echo "<h1>Welcome to Nginx Server</h1>" > /var/www/html/index.html
systemctl enable nginx
systemctl start nginx   