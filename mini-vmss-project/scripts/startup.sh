#!/bin/bash
set -euxo pipefail

# ------------------------------------------------------------
# Update system
# ------------------------------------------------------------
apt-get update -y

# ------------------------------------------------------------
# Install Apache
# ------------------------------------------------------------
DEBIAN_FRONTEND=noninteractive apt-get install -y apache2

# ------------------------------------------------------------
# Disable all local firewalls (VERY IMPORTANT)
# ------------------------------------------------------------
systemctl stop ufw || true
systemctl disable ufw || true

iptables -F || true
iptables -X || true
iptables -t nat -F || true
iptables -t nat -X || true
iptables -P INPUT ACCEPT
iptables -P FORWARD ACCEPT
iptables -P OUTPUT ACCEPT

# ------------------------------------------------------------
# Force Apache to listen on all interfaces
# ------------------------------------------------------------
sed -i 's/^Listen .*/Listen 0.0.0.0:80/' /etc/apache2/ports.conf
sed -i 's/<VirtualHost .*>/<VirtualHost *:80>/' /etc/apache2/sites-available/000-default.conf

# ------------------------------------------------------------
# Start Apache
# ------------------------------------------------------------
systemctl daemon-reexec
systemctl enable apache2
systemctl restart apache2
systemctl is-active --quiet apache2

# ------------------------------------------------------------
# Simple static page
# ------------------------------------------------------------
cat <<EOF > /var/www/html/index.html
<!DOCTYPE html>
<html>
<body style="background:#020617;color:#22c55e;font-family:Arial;text-align:center;margin-top:80px">
  <h1>✅ VMSS + Azure Load Balancer WORKING</h1>
  <p>Hostname: $(hostname)</p>
</body>
</html>
EOF

chown -R www-data:www-data /var/www
chmod -R 755 /var/www

# ------------------------------------------------------------
# Final local test
# ------------------------------------------------------------
curl -f http://localhost
