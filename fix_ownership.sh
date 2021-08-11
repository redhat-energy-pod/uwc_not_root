#!/bin/sh

# Get a list of the input devices on the system
printf "\n This will list the current usb devices: \n"

for sysdevpath in $(find /sys/bus/usb/devices/usb*/ -name dev); do
    (
        syspath="${sysdevpath%/dev}"
        devname="$(udevadm info -q name -p $syspath)"
        [[ "$devname" == "bus/"* ]] && exit
        eval "$(udevadm info -q property --export -p $syspath)"
        [[ -z "$ID_SERIAL" ]] && exit
        echo "/dev/$devname - $ID_SERIAL"
    )
done

# What is the podman user?
echo "What user do you run podman as?"
read podman_user

#What device should we change to the podman user
echo "Which device listed above would you like to change to the podman user?"
read device

#chown the device to the podman user
echo "you will be prompted for your sudo password"
sudo chown ${podman_user} ${device} 
