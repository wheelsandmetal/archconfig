#!/bin/bash
ip link set dev enp0s25 down
ip link set dev enp0s25 address 24:df:6a:f3:86:61
ip link set dev enp0s25 up
ip link set dev wls3 down
ip link set dev wls3 address 24:df:6a:f3:86:61
ip link set dev wls3 up
