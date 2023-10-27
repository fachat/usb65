

DRIVER_O65=../../drivers/host/max3421e.o65 ../../drivers/spi/cbmusb_pet.a65
HOST_O65=../../host/usb.o65 
MAIN_O65=petusb4.o65

FILES=$(COMMON_FILES) $(DRIVER_FILES)

#XA=xa -R -U -c -bt 1023 -bz 17 -XC -XMASM -I../../common -I../../drivers
#LINK=reloc65 -bt 1023 -bz 17 -X -v
XA=xa -R -U -c -bt 1023 -bz 66 -XC -XMASM -I../../common -I../../drivers
XAX=xa -R -U -c -bt 24576 -bz 192 -XC -XMASM -I../../common -I../../drivers
#LINK=reloc65 -bt 1023 -bz 66 -X -v
LINK=reloc65 -bt 1023 -bz 66 -X 
#LINKX=reloc65 -X -v
LINKX=reloc65 -X 

#all: csausb_sl811h csausb_max3421 csausbkbd_sl811 csausbkbd_max3420 petusb_cbmusb petusbdrv_cbmusb upet_usb upet_usbdrv

all: petusb

${DRIVER_O65}:
	make -C ../../drivers

${HOST_O65}:
	make -C ../../host

%.o65: %.a65
	xa -R -U -I../../common -I../../host -o $@ $<

petusb.o65: ${DRIVER_O65} ${HOST_O65} ${MAIN_O65}
	ldo65 -o $@ $^

petusb: petusb.o65
	reloc65 -bt 1023 -bz 66 -o $@ $<


#csausb_sl811h: petusb3.a65 $(FILES) $(HOST_FILES)
#	$(XA) -I../../host -DSL811_HOST petusb3.a65 -o $@.o65 -l $@.l -P $@.lst
#	$(LINK) -o $@ $@.o65 
#
#csausb_max3421: petusb3.a65 $(FILES) $(HOST_FILES)
#	$(XA) -I../../host -DMAX3421_HOST -DSPI65_SPI petusb3.a65 -o $@.o65 -l $@.l -P $@.lst
#	$(LINK) -o $@ $@.o65 
#
#csausbkbd_sl811: petusbkbd.a65 $(FILES) $(DEVICE_FILES)
#	$(XA) -I../../device -DSL811_DEV -XC -XMASM $< -P$@.lst -o $@.o65 -l $@.l
#	$(LINK) -o $@ $@.o65 
#
#csausbkbd_max3420: petusbkbd.a65 $(FILES) $(DEVICE_FILES)
#	$(XA) -I../../device -DMAX3420_DEV -XC -XMASM $< -P$@.lst -o $@.o65 -l $@.l
#	$(LINK) -o $@ $@.o65 


clean:
	rm -f *.o65

