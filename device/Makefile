
FILES=sl811_dev.a65 sl811_dev.i65 usbdev.a65 usbdev.i65 usb.i65 \
	kbddev.a65 max3420e.a65 max3420e.i65 debug.i65 debug.a65 \
	spi65b.a65 spi65b.i65 msg.a65

#HW=SL811_DEV
#HW=MAX3420_DEV

XA=xa -R -U -c -bt 1023 -bz 17
LINK=reloc65 -bt 1023 -bz 17 -X -v

#all: PETUSBKBD CSAUSBKBD
all: CSAUSB_SL811 CSAUSB_MAX3420 PETUSBKBD

PETUSBKBD: petusbkbd.a65 $(FILES)
	$(XA) -DMAX3420_DEV -DPET=1 -XC -XMASM $< -o $@.o65 -l $@.l
	$(LINK) -o $@ $@.o65 

CSAUSB_SL811: petusbkbd.a65 $(FILES)
	$(XA) -DSL811_DEV -XC -XMASM $< -P$@.lst -o $@.o65 -l $@.l
	$(LINK) -o $@ $@.o65 

CSAUSB_MAX3420: petusbkbd.a65 $(FILES)
	$(XA) -DMAX3420_DEV -XC -XMASM $< -P$@.lst -o $@.o65 -l $@.l
	$(LINK) -o $@ $@.o65 

clean:
	rm -f CSAUSBKBD CSAUSBKBD.o65 CSAUSBKBD.l CSAUSBKBD.lst
	rm -f PETUSBKBD PETUSBKBD.o65 PETUSBKBD.l PETUSBKBD.lst
	rm -f CSAUSB_SL811 CSAUSB_SL811.o65 CSAUSB_SL811.l CSAUSB_SL811.lst
	rm -f CSAUSB_MAX3420 CSAUSB_MAX3420.o65 CSAUSB_MAX3420.l CSAUSB_MAX3420.lst

