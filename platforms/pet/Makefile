

DEVICE_FILES=	../../device/usbdev.a65 ../../device/usbdev.i65 \
	../../device/devmsg.a65 ../../device/devmsg.i65
HOST_FILES=../../host/hub.a65 ../../host/usb.a65 \
	../../host/usbgen.a65 ../../host/kbd.a65 ../../host/detect.a65 \
	../../host/hostmsg.a65 ../../host/hostmsg.i65
DRIVER_FILES=../../drivers/sl811_host.a65 ../../drivers/sl811_host.i65 \
	../../drivers/max3421e.a65 ../../drivers/max3421e.i65 \
	../../drivers/max3420e.a65 ../../drivers/max3420e.i65 \
	../../drivers/spi65b.a65 ../../drivers/spi65b.i65 \
	../../drivers/sl811_dev.a65 ../../drivers/sl811_dev.i65 \
	../../drivers/viaspi.a65
COMMON_FILES=../../common/debug.i65 ../../common/debug.a65 ../../common/usb.i65 \
	../../common/via6522.i65

FILES=$(COMMON_FILES) $(DRIVER_FILES)

XA=xa -R -U -c -bt 1023 -bz 17 -XC -XMASM -I../../common -I../../drivers
LINK=reloc65 -bt 1023 -bz 17 -X -v

all: CSAUSB_SL811H CSAUSB_MAX3421 CSAUSBDRV PETUSBDRV CSAUSBKBD_SL811 CSAUSBKBD_MAX3420

CSAUSB_SL811H: petusb3.a65 $(FILES) $(HOST_FILES)
	$(XA) -I../../host -DSL811_HOST petusb3.a65 -o $@.o65 -l $@.l -P $@.lst
	$(LINK) -o $@ $@.o65 

CSAUSB_MAX3421: petusb3.a65 $(FILES) $(HOST_FILES)
	$(XA) -I../../host -DMAX3421_HOST petusb3.a65 -o $@.o65 -l $@.l -P $@.lst
	$(LINK) -o $@ $@.o65 

PETUSBDRV: petusbdrv.a65 $(FILES) $(HOST_FILES)
	$(XA) -I../../host -DPET=1 petusbdrv.a65 -o $@ -l $@.l
	$(LINK) -o $@ $@.o65 

CSAUSBDRV: petusbdrv.a65 $(FILES)
	$(XA) -I../../host petusbdrv.a65 -o $@ -l $@.l
	$(LINK) -o $@ $@.o65 


PETUSBKBD: petusbkbd.a65 $(FILES) $(DEVICE_FILES)
	$(XA) -I../../device -DMAX3420_DEV -DPET=1 -XC -XMASM $< -o $@.o65 -l $@.l
	$(LINK) -o $@ $@.o65 

CSAUSBKBD_SL811: petusbkbd.a65 $(FILES) $(DEVICE_FILES)
	$(XA) -I../../device -DSL811_DEV -XC -XMASM $< -P$@.lst -o $@.o65 -l $@.l
	$(LINK) -o $@ $@.o65 

CSAUSBKBD_MAX3420: petusbkbd.a65 $(FILES) $(DEVICE_FILES)
	$(XA) -I../../device -DMAX3420_DEV -XC -XMASM $< -P$@.lst -o $@.o65 -l $@.l
	$(LINK) -o $@ $@.o65 

clean:
	rm -f CSAUSBKBD CSAUSBKBD.o65 CSAUSBKBD.l CSAUSBKBD.lst
	rm -f PETUSBKBD PETUSBKBD.o65 PETUSBKBD.l PETUSBKBD.lst
	rm -f CSAUSBKBD_SL811 CSAUSBKBD_SL811.o65 CSAUSBKBD_SL811.l CSAUSBKBD_SL811.lst
	rm -f CSAUSBKBD_MAX3420 CSAUSBKBD_MAX3420.o65 CSAUSBKBD_MAX3420.l CSAUSBKBD_MAX3420.lst
	rm -f CSAUSB_SL811H CSAUSB_SL811H.l CSAUSB_SL811H.o65 CSAUSB_SL811H.lst
	rm -f CSAUSB_MAX3421 CSAUSB_MAX3421.l CSAUSB_MAX3421.o65 CSAUSB_MAX3421.lst
	rm -f CSAUSBDRV CSAUSBDRV.l
	rm -f PETUSBDRV PETUSBDRV.l

