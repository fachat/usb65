
# UPET USB driver variants

## PET BASIC4

### run the driver in the foreground

- petusb:
	- petusb4.a65
	- ../../host/usb.o65
	- ../../host/hostmsg.o65
	- ../../common/debug.o65
	- ../../drivers/host/...
	- ../../drivers/spi/...
	- bind_petup_max3421e.o65

### Install a resident driver and terminate

- mxdrv / sldrv:
	- petusbloader.o65
	- mxdrvtsr / sldrvtsr:
		- petusbdrv.o65
		- overlayscreen.o65
		- ../../host/usb.o65
		- ../../host/hostmsg.o65
		- ../../common/debug.o65
		- ../../drivers/host/...
		- ../../drivers/spi/...
		- bind_petup_max3421e.o65
	
## UPET

### run the driver in the foreground

- upetusb:
	- petusb4.a65
	- ../../host/usb.o65
	- ../../host/hostmsg.o65
	- ../../common/debug.o65
	- ../../drivers/host/...
	- ../../drivers/spi/...
	- bind_upet_max3421e.o65


### install the resident driver 

- mxdrv / sldrv:
	- petusbloader.o65
	- mxdrvtsr / sldrvtsr:
		- petusbdrv.o65
		- overlayscreen.o65
		- ../../host/usb.o65
		- ../../host/hostmsg.o65
		- ../../common/debug.o65
		- ../../drivers/host/...
		- ../../drivers/spi/...
		- bind_petup_max3421e.o65

### Patch into ROM

The code that is being put into a separate bank (for all setups)

- petrom: 
	- usbrom.o65
	- virtscreen.o65
	- ../../host/usb.o65
	- ../../host/hostmsg.o65
	- ../../common/debug.o65
	- ../../drivers/host/...
	- ../../drivers/spi/...
	- bind_petup_max3421e.o65
	
- petrom4_comp: companion patched into the BASIC4 ROM
- petrom4_install: code that installs the patch and inits USB

Install the core code into separate bank and patch it in

- petrom4ldr:
	petrom4ldr.a65
	petrom4_install.a65
	petrom4_comp.a65
	petrom

