# syntax=docker/dockerfile:1
FROM debian:bullseye-slim
RUN <<EOF
# using noninteractive
sed -i 's/Value: Dialog/Value: Noninteractive/' /var/cache/debconf/config.dat
# disabling autorestart
mkdir -p /etc/needrestart/conf.d
echo "\$nrconf{restart} = 'l';" | tee /etc/needrestart/conf.d/50-autorestart.conf 1>/dev/null
# adding ca-certificates
apt update
apt install -y ca-certificates
apt-get clean
rm -rf /var/lib/apt/lists/*
sed -i "s#http://#https://#g" /etc/apt/sources.list
EOF

# vim: set filetype=dockerfile :
