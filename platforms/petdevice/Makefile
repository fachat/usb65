

DEVICE_FILES=	../../device/usbdev.a65 ../../device/usbdev.i65 \
	../../device/devmsg.a65 ../../device/devmsg.i65
DRIVER_FILES= ../../drivers/device/max3420e.a65 ../../drivers/device/max3420e.i65 \
	../../drivers/spi/spi65b.a65 ../../drivers/spi/spi65b.i65 \
	../../drivers/device/sl811_dev.a65 ../../drivers/device/sl811_dev.i65 \
	../../drivers/spi/cbmspi.i65 ../../drivers/spi/cbmusb_pet.a65 \
COMMON_FILES=../../common/debug.i65 ../../common/debug.a65 ../../common/usb.i65 \
	../../common/via6522.i65

FILES=$(COMMON_FILES) $(DRIVER_FILES)

XA=xa -R -U -c -bt 1023 -bz 66 -XC -XMASM -I../../common -I../../drivers
XAX=xa -R -U -c -bt 24576 -bz 192 -XC -XMASM -I../../common -I../../drivers
#LINK=reloc65 -bt 1023 -bz 66 -X -v
LINK=reloc65 -bt 1023 -bz 66 -X 
#LINKX=reloc65 -X -v
LINKX=reloc65 -X 

all: csausbkbd_sl811 csausbkbd_max3420 


petusbkbd: petusbkbd.a65 $(FILES) $(DEVICE_FILES)
	$(XA) -I../../device -DMAX3420_DEV -DPET=1 -XC -XMASM $< -o $@.o65 -l $@.l
	$(LINK) -o $@ $@.o65 

csausbkbd_sl811: petusbkbd.a65 $(FILES) $(DEVICE_FILES)
	$(XA) -I../../device -DSL811_DEV -XC -XMASM $< -P$@.lst -o $@.o65 -l $@.l
	$(LINK) -o $@ $@.o65 

csausbkbd_max3420: petusbkbd.a65 $(FILES) $(DEVICE_FILES)
	$(XA) -I../../device -DMAX3420_DEV -XC -XMASM $< -P$@.lst -o $@.o65 -l $@.l
	$(LINK) -o $@ $@.o65 

clean:
	rm -f *.o65 *.lst

