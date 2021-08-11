# Run UWC Containers as a user instead of root

Create a fix for the root containers in current UWC implementation [here.](https://github.com/open-edge-insights/uwc)
This is a Proof of concept that should be automated via ansible for large deployments.

## Problem

Current UWC implementation runs the container that needs to access the devices as root

## Goal

Create a process to identify devices and change ownership to podman.

## How to run this script

```shell
./fix_ownership.sh
```

Example:

```shell
[cferman@chadora uwc_not_root]$ ./fix_ownership.sh 

 This will list the current usb devices: 
/dev/snd/controlC5 - 046d_0825_4AE6BF10
/dev/video1 - 046d_0825_4AE6BF10
/dev/video0 - 046d_0825_4AE6BF10
/dev/input/event14 - 046d_0825_4AE6BF10
/dev/snd/controlC4 - 0d8c_USB_Sound_Device
/dev/input/event11 - 0d8c_USB_Sound_Device
/dev/input/event3 - SONiX_USB_DEVICE
/dev/input/event5 - SONiX_USB_DEVICE
/dev/input/event4 - SONiX_USB_DEVICE

What user do you run podman as? 
podman

Which device listed above would you like to change to the podman user? 
/dev/input/event3

crw-rw----. 1 root input 13, 67 Aug 10 14:37 /dev/input/event3
This will execute chown cferman /dev/input/event3 exit now if you do not wish to do this.
 You may be prompted for your sudo password 
printf: usage: printf [-v var] format [arguments]
crw-rw----. 1 cferman input 13, 67 Aug 10 14:37 /dev/input/event3
[cferman@chadora uwc_not_root]$ chown root /dev/input/event3
chown: changing ownership of '/dev/input/event3': Operation not permitted
[cferman@chadora uwc_not_root]$ sudo chown root /dev/input/event3
[cferman@chadora uwc_not_root]$ ./fix_ownership.sh 

 This will list the current usb devices: 
/dev/snd/controlC5 - 046d_0825_4AE6BF10
/dev/video1 - 046d_0825_4AE6BF10
/dev/video0 - 046d_0825_4AE6BF10
/dev/input/event14 - 046d_0825_4AE6BF10
/dev/input/event6 - Yubico_YubiKey_OTP+FIDO+CCID

/dev/snd/controlC4 - 0d8c_USB_Sound_Device
/dev/input/event11 - 0d8c_USB_Sound_Device
/dev/input/event3 - SONiX_USB_DEVICE
/dev/input/event5 - SONiX_USB_DEVICE
/dev/input/event4 - SONiX_USB_DEVICE
/dev/sdc - ST2000LM007
/dev/sdc1 - ST2000LM007
What user do you run podman as? 
podman
Which device listed above would you like to change to the podman user? 
/dev/input/event3
Original device ownership: 
 crw-rw----. 1 root input 13, 67 Aug 10 14:37 /dev/input/event3 
This will execute chown cferman /dev/input/event3 exit now if you do not wish to do this.
 You may be prompted for your sudo password 
New ownership of device 
crw-rw----. 1 cferman input 13, 67 Aug 10 14:37 /dev/input/event3
```
