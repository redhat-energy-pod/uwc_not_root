# Run UWC Containers as a user instead of root

Create a fix for the root containers in current UWC implementation [here.](https://github.com/open-edge-insights/uwc)

## Problem

Current UWC implementation runs the container that needs to access the devices as root

## Goal

Create a process to identify devices and change ownership to podman

