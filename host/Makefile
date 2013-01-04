
FILES=hub.a65 sl811_host.a65 sl811_host.i65 usb.a65 usb.i65 msg.i65 msg.a65 \
debug.i65 debug.a65 usbgen.a65 kbd.a65 detect.a65 max3421e.a65 max3421e.i65 \
spi65b.a65 spi65b.i65

XA=xa -R -U -c -bt 1023 -bz 17 -XC -XMASM
LINK=reloc65 -bt 1023 -bz 17 -X -v

all: CSAUSB_SL811H CSAUSB_MAX3421 

CSAUSB_SL811H: petusb3.a65 $(FILES)
	$(XA) -DSL811_HOST petusb3.a65 -o $@.o65 -l $@.l -P $@.lst
	$(LINK) -o $@ $@.o65 

CSAUSB_MAX3421: petusb3.a65 $(FILES)
	$(XA) -DMAX3421_HOST petusb3.a65 -o $@.o65 -l $@.l -P $@.lst
	$(LINK) -o $@ $@.o65 

#PETUSBDRV: petusbdrv.a65 $(FILES)
#	$(XA) -DPET=1 -M petusbdrv.a65 -o $@ -l $@.l
#
#CSAUSBDRV: petusbdrv.a65 $(FILES)
#	$(XA) -M petusbdrv.a65 -o $@ -l $@.l

clean:
	rm -f CSAUSB_SL811H CSAUSB_SL811H.l CSAUSB_SL811H.o65 CSAUSB_SL811H.lst
	rm -f CSAUSB_MAX3421 CSAUSB_MAX3421.l CSAUSB_MAX3421.o65 CSAUSB_MAX3421.lst

