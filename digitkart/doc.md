## Setting up Nvidia Jetson Device
This document provides step-by-step instructions for setting up a Nvidia Jetson device for DigitKart.

### Requirements
- Ubuntu 20.04 Laptop/computer with the latest Nvidia SDK Manager installed
- Nvidia Jetson Orin 32G (shipped along with digitkart device)
- USB type C to USB type A cable for serial connection
- USB type C ot USB type A adapter

### Installation Steps
1. Connect the Nvidia Jetson device to the laptop using a serial cable.

2. Put the Nvidia Jetson device in recovery mode by pressing and holding the center button, then press the first button and let go of both buttons together.

3. Launch the Nvidia SDK Manager on the laptop and establish a serial connection with the Nvidia Jetson device using the c-port on the front side of the device (with just 2 USB ports).

4. Choose the "Manually install the 32GB Developer kit Orin Jetson" option and configure the user name and password.

5. Install JetPack 5.1 (rev. 1) using the SDK Manager.

Once the installation is successful, ssh into the device using the following steps:
1. Open a terminal window on the computer, run the following command: `sudo screen /dev/ttyACM0 115200`
2. Login with the credentials provided during the installation process
3. Run the following command to get the IP address of the device: `hostname -I`
4. Copy the first IP address and exit the session by pressing Ctrl+A, then Ctrl+K, then Y
5. Unplug the serial cable from the laptop and Nvidia Jetson device
6. Open a new terminal session on the computer and run the following command to ssh into the device: `ssh <username>@<IP>`


Congratulations! You have successfully set up the Nvidia Jetson device and can now start working with it.
