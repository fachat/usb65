
6502 USB Host Driver
====================
(C) 2011 A.Fachat

This is the USB Host driver for a 6502 CPU. It currently implements the following
features:

- support for low and full speed devices
- USB Hub support, i.e. multiple devices on a single USB port using a hub
- SL811(HS) hardware driver
- hardware and logic driver separated, so other hardware can easily be integrated.
- sample mouse and keyboard driver for a Commodore PET included

The driver is originally modeled after the code from Microusb.org but I found the 
sample (Base HID) code there too simple, and also only using low speed devices, and 
not supporting hubs at all (the site has a different focus, so all that's ok). After playing around
(and not managing to get it working in my setup), I completely rewrote the driver,
in fact this is the second rewrite, thus the "3" in the "petusb3.a65" name below.
In this process I also removed any possibly lurking microusb.org copyright.

Copyright
---------

The code is distributed under Lesser GNU Public License (LGPL) V3. Please see
the lgpl.txt and gpl.txt files for more information.

    This file is part of the 6502 USB Host Driver.

    The 6502 USB Host Driver is free software: you can redistribute it and/or modify
    it under the terms of the Lesser GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    The 6502 USB Host Driver is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    Lesser GNU General Public License for more details.

    You should have received a copy of the Lesser GNU General Public License
    along with the 6502 USB Host Driver. If not, see <http://www.gnu.org/licenses/>.


Caveats
-------
USB is a completely host-controlled protocol. For a host to handle the protocol, it has to 
"baby-sit" the bus, contacting each device in turns, handling timing requirements and managing
power requirements.

    This driver does NOT implement power management! You have to watch out for yourself
    for over-power situations!

Also the code does not handle correct timing requirements. For example each device can request
to be queried every N milliseconds - the driver does not handle that.

Instead the driver uses a very simple approach, in that it simply queries each device in turn
when the "usb_polldev" function is called.


Code Description
----------------

The device driver interface is quite simple. As a first step you have to call "usb_init".
(Note the complete interface description is in usb.a65). This call gives you the information
whether the hardware was found and which version. Then you just have to call "usb_polldev"
in turn. This call does all the USB-internal work and calls back into the application, 
namely the global callbacks usb_cb_attach when a device has been attached, usb_cb_detected with 
the device descriptor of a new device, and usb_cb_disable when a device has been disabled.

The usb_cb_detected is most important. This callback (as currently implemented in detect.a65)
analyses the device descriptor, and the configuration requested from the device, to register
further callbacks for each device. When registering a device callback, a tranparent data byte
can be given, which is given back to the callback - you can for example transfer an index in
a hub table. Each device callback is also executed during the usb_polldev.

In fact the USB hub functionality works exactly like any other device. During usb_polldev the
hub is detected. The usb_cb_detected finds the hub and registers a hub callback. During the
hub device callback, the hub driver queries the hub for devices and when a new device is found,
calls into the usb core for usb_init_device, which in turn calls usb_cb_detected - which 
allows to register further devices.

In the interfaces there is the concept of "slot". A USB bus can have a number of devices
attached to a single root hub. Thus the USB core must be able to handle multiple devices. It
does this by holding a table with the data for all the devices. Each table entry is called
a "slot". So a slot number is used address a device in the USB core driver.


File Descriptions
-----------------

petusb3.a65
	Main program, Commodore PET (BASIC) executable, that
	loads the USB driver, and shows debug messages for attached
	devices etc.
petusbdrv.a65
	Resident keyboard driver for Commodore PET. Loads the 
	driver into RAM at $6800. Driver runs in the interrupt
	and uses the keyboard and mouse USB drivers to use a
	USB keyboard and mouse on a Commodore PET
usb.a65
usb.i65
	USB core
usbgen.a65
	Some generic USB code (handling of config descriptor)
detect.a65
	Descriptor analysis. Analyses the device and config descriptors
	and initializes hub, keyboard and mouse drivers.
debug.a65
debug.i65
	Debug code 
hub.a65
hub.i65
	USB Hub support. Registered as any other device with the
	usb core, but calls into the usb core back to initialize
	new devices.
kbd.a65
	keyboard driver (single keyboard only)
mouse.a65
	Mouse driver (single mouse only)
msg.a65
msg.i65
	Debug and error messages 
README
	This readme file
sl811_host.a65
sl811_host.i65
	SL811HS host hardware driver

Bugs still to fix:
------------------

- there is no explicit usb_put (as counterpart to usb_get) yet, but should be
	easy now that outbound control works

- data transfers larger than $e8 bytes don't work, from e8-f0 will even bug out
	on control sends, without error. Needs fixing anyway, as I expect to 
	need to do larger transfers for disk drive support

- should we call the attach/detach callback for devices attached to the hub?
	if not, rename it to root_attach, root_detach

- does not handle "dumb" boot-protocol-only keyboards. They need to at least
	provide their device descriptor and configuration on request.
	Linux seems to just ignore when an error occurs and assume a HID boot proto
	keyboard/mouse?

Some comments on bugs fixed:

- some devices check the toggle bit on the ACK packet, some don't. 

- Fixed: found while developing my device stack: when ACK is not received for a control
 	send (e.g. set address), loops indefinitely (receiving NAKs all the way). Needs timeout
	When receiving more data from the device, loops indefinitely (receiving NAKs). Needs timeout


