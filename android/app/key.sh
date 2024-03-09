# /usr/bin/sh

rm keystore.jks
keytool -genkey -v -keystore keystore.jks -alias terminal_flutter -keyalg RSA -keysize 2048 -validity 10000 -storepass koswo121130 -keypass koswo121130