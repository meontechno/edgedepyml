## Setting up Nvidia Jetson Device
This document provides step-by-step instructions for setting up a Nvidia Jetson device for DigitKart.

### Requirements
- Ubuntu 20.04 Laptop/computer with the latest [Nvidia SDK Manager](https://developer.nvidia.com/drive/sdk-manager) installed
- Nvidia Jetson Orin 32G (shipped along with digitkart device)
- USB type C to USB type A [cable](https://www.amazon.com/AmazonBasics-Type-C-USB-Male-Cable/dp/B01GGKYLW0/ref=asc_df_B01GGKYLW0/?tag=hyprod-20&linkCode=df0&hvadid=167151358503&hvpos=&hvnetw=g&hvrand=10287814468522926347&hvpone=&hvptwo=&hvqmt=&hvdev=c&hvdvcmdl=&hvlocint=&hvlocphy=9026839&hvtargid=pla-300436575537&th=1) for serial connection
- USB type C ot USB type A [adapter](https://www.amazon.com/Thunderbolt-Compatible-Chromebook-Pixelbook-Microsoft/dp/B07KR45LJW/ref=asc_df_B07KR45LJW/?tag=hyprod-20&linkCode=df0&hvadid=312780390407&hvpos=&hvnetw=g&hvrand=2152410768133120389&hvpone=&hvptwo=&hvqmt=&hvdev=c&hvdvcmdl=&hvlocint=&hvlocphy=9026839&hvtargid=pla-636721944170&th=1)

### Installation Steps
1. Connect the Nvidia Jetson device to the laptop using a serial cable.
2. Put the Nvidia Jetson device in recovery mode by pressing and holding the center button, then press the first button and let go of both buttons together.
3. Launch the Nvidia SDK Manager on the laptop and establish a serial connection with the Nvidia Jetson device using the c-port on the front side of the device (with just 2 USB ports).
4. Choose to the option JetPack 5.1 (rev. 1) to install.
5. Choose the "Manually install the 32GB Developer kit Orin Jetson" option and configure the user name and password.

Once the installation is successful, ssh into the device using the following steps:
1. Open a terminal window on the computer, run the following command: `sudo screen /dev/ttyACM0 115200`
2. Login with the credentials provided during the installation process
3. Run the following command to get the IP address of the device: `hostname -I`
4. Copy the first IP address and exit the session by pressing Ctrl+A, then Ctrl+K, then Y
5. Unplug the serial cable from the laptop and Nvidia Jetson device
6. Open a new terminal session on the computer and run the following command to ssh into the device: `ssh <username>@<IP>`

### Install Vision Service
SSH into the device and execute below commands in a sequence:
1. `wget https://raw.githubusercontent.com/meontechno/edgedepyml/main/digitkart/install.sh`
2. `sudo chmod 777 install.sh`
3. `sudo ./install.sh`
4. `sudo groupadd docker`
5. `sudo usermod -aG docker $USER`
6. `newgrp docker`

Reboot the device twice (Wait for 5min after each reboot) for the services to be functional. 

To check status of the services, execute: `docker ps`
