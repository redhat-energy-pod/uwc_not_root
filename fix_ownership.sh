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
printf "What user do you run podman as? \n"
read podman_user

#What device should we change to the podman user
printf "Which device listed above would you like to change to the podman user? \n"
read device

# Get current device ownership in case we need to change it back
before=`ls -ltrha ${device}`
printf "Original device ownership: \n ${before} \n"

#chown the device to the podman user
printf "This will execute chown ${podman_user} ${device} exit now if you do not wish to do this.\n You may be prompted for your sudo password \n"
sudo chown ${podman_user} ${device} 

# Show output post change
printf "New ownership of device \n"
ls -ltrha ${device}