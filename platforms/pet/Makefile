

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
	../../drivers/viaspi.a65 ../../drivers/cbmspi.i65 ../../drivers/cbmusb_pet.a65
COMMON_FILES=../../common/debug.i65 ../../common/debug.a65 ../../common/usb.i65 \
	../../common/via6522.i65

FILES=$(COMMON_FILES) $(DRIVER_FILES)

#XA=xa -R -U -c -bt 1023 -bz 17 -XC -XMASM -I../../common -I../../drivers
#LINK=reloc65 -bt 1023 -bz 17 -X -v
XA=xa -R -U -c -bt 1023 -bz 66 -XC -XMASM -I../../common -I../../drivers
XAX=xa -R -U -c -bt 24576 -bz 192 -XC -XMASM -I../../common -I../../drivers
#LINK=reloc65 -bt 1023 -bz 66 -X -v
LINK=reloc65 -bt 1023 -bz 66 -X 
#LINKX=reloc65 -X -v
LINKX=reloc65 -X 

all: csausb_sl811h csausb_max3421 csausbkbd_sl811 csausbkbd_max3420 petusb_cbmusb petusbdrv_cbmusb

csausb_sl811h: petusb3.a65 $(FILES) $(HOST_FILES)
	$(XA) -I../../host -DSL811_HOST petusb3.a65 -o $@.o65 -l $@.l -P $@.lst
	$(LINK) -o $@ $@.o65 

csausb_max3421: petusb3.a65 $(FILES) $(HOST_FILES)
	$(XA) -I../../host -DMAX3421_HOST -DSPI65_SPI petusb3.a65 -o $@.o65 -l $@.l -P $@.lst
	$(LINK) -o $@ $@.o65 

petusb_cbmusb: petusb3.a65 $(FILES) $(HOST_FILES)
	$(XA) -I../../host -DMAX3421_HOST -DCBMSPI_SPI petusb3.a65 -o $@.o65 -l $@.l -P $@.lst
	$(LINK) -o $@ $@.o65 

#PETUSBDRV: petusbdrv.a65 $(FILES) $(HOST_FILES)
#	$(XA) -I../../host -DPET=1 petusbdrv.a65 -o $@.o65 -l $@.l
#	$(LINK) -o $@ $@.o65 

petusbdrv_cbmusb: petusbdrv.a65 $(FILES) $(HOST_FILES)
	$(XA) -I../../host -DLOADER -DPET=1 -DMAX3421_HOST -DCBMSPI_SPI petusbdrv.a65 -o $@_l.o65 -l $@_l.l
	$(XAX) -I../../host -DDRIVER -DPET=1 -DMAX3421_HOST -DCBMSPI_SPI petusbdrv.a65 -o $@_d.o65 -l $@_d.l
	$(LINKX) -o $@_l $@_l.o65 
	$(LINKX) -o $@_d $@_d.o65 
	cat $@_l $@_d > $@
	rm $@_l $@_d

#CSAUSBDRV: petusbdrv.a65 $(FILES)
#	$(XA) -I../../host petusbdrv.a65 -o $@.o65 -l $@.l
#	$(LINK) -o $@ $@.o65 


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
	rm -f petusb_cbmusb petusb_cbmusb.o65 petusb_cbmusb.l petusb_cbmusb.lst
	rm -f csausbkbd_sl811 csausbkbd_sl811.o65 csausbkbd_sl811.l csausbkbd_sl811.lst
	rm -f csausbkbd_max3420 csausbkbd_max3420.o65 csausbkbd_max3420.l csausbkbd_max3420.lst
	rm -f csausb_sl811h csausb_sl811h.l csausb_sl811h.o65 csausb_sl811h.lst
	rm -f csausb_max3421 csausb_max3421.l csausb_max3421.o65 csausb_max3421.lst
	rm -f petusbdrv_cbmusb petusbdrv_cbmusb.l
	rm -f petusbdrv_cbmusb_l petusbdrv_cbmusb_l.l petusbdrv_cbmusb_l.o65
	rm -f petusbdrv_cbmusb_d petusbdrv_cbmusb_d.l petusbdrv_cbmusb_d.o65

