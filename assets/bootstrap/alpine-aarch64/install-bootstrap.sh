#!/system/bin/sh

chmod -R 777 ../
chmod -R +rx ../
# unpack alpine bootstrap
mkdir bootstrap
cd bootstrap
cat ../rootfs.tar.xz | ../root/bin/minitar
cd ..

# include resolv.conf
echo "nameserver 8.8.8.8 \n \
nameserver 8.8.4.4" > bootstrap/etc/resolv.conf

echo "bootstrap ready, run with run-bootstrap.sh"
