# Openstf
OpenSTF Docker deploy

# How to setup OpenSTF in Mac? 

Prerequisites ..

 ```bash
install docker
install docker-compose
Clone this repo https://github.com/nikosch86/stf-poc 
 ```
# Deployment

Note:Update .env file with Ip of your host.

Run docker-compose up -d --build
Point your browser to the IP you chose,
login by providing any username and valid e-mail.

# On mac machine

On Mac , /dev/bus/usb are not hanlde in way that in linux and windows.dev us  are not available on containers running on mac docker desktop.

Following these steps, you should be able to connect to your Android Device, through adb within a Docker Container on a Mac host machine.

You can connect wirelessly to your device through adb.

The way to achieve it is :

Connect your Android device to your host machine with a USB cable.

On your host machine run :
 ```bash
 adb devices
 ```
You should see your device as connected . On your host machine run, to connect wirelessly to your device :
 ```bash
adb tcpip 5555
adb connect 192.168.0.5:5555 (replace the ip address with your android devices)
adb devices
```
You should see your device connected through USB and wirelessly
Disconnect the USB cable, run adb devices and check that the wireless connection is still active
Launch your Docker container

On your Docker Container, run the following commands :
 ```bash
adb connect 192.168.0.5:5555
adb devices
```

If you see and unauthorized device, try these commands to fix the issue :
 ```bash
adb kill-server
adb connect 192.168.0.5:5555
adb devices
```
Refference 
https://medium.com/@nikosch86/getting-started-with-automated-in-house-testing-on-android-smartphones-using-stf-dafecee4a8ee

