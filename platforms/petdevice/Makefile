
MAIN=petusbkbd

MAIN_O65=petusbkbd.o65

MXDRIVER_O65=../../drivers/device/max3420e.o65 ../../drivers/spi/cbmusb_pet.o65
MXBIND_O65=bind_petup_max3420e.o65

DEVICE_O65=../../device/usbdev.o65 ../../device/devmsg.o65 ../../device/kbddev.o65
COMMON_O65=../../common/debug.o65

all: ${MAIN}

###############################################
# base

${MXDRIVER_O65}:
	make -C ../../drivers

${DEVICE_O65}:
	make -C ../../device

${COMMON_O65}:
	make -C ../../common

%.o65: %.a65
	xa -R -U -XMASM -bt 1023 -I../../device -I../../common -P $*.lst -I../../host -o $@ $<

###############################################
# Main using max3420e driver

${MAIN}: ${MAIN_O65} ${DEVICE_O65} ${COMMON_O65} ${MXDRIVER_O65} ${MXBIND_O65}
	ldo65 -G -v -v -o $@.tmp $^
	reloc65 -bt 1023 -bz 66 -X -o $@ $@.tmp


###############################################
#
#
#FILES=$(COMMON_FILES) $(DRIVER_FILES)
#
#XA=xa -R -U -c -bt 1023 -bz 66 -XC -XMASM -I../../common -I../../drivers
#LINK=reloc65 -bt 1023 -bz 66 -X 
#
#all: csausbkbd_sl811 csausbkbd_max3420 
#
#
#petusbkbd: petusbkbd.a65 $(FILES) $(DEVICE_FILES)
#	$(XA) -I../../device -DMAX3420_DEV -DPET=1 -XC -XMASM $< -o $@.o65 -l $@.lab
#	$(LINK) -o $@ $@.o65 
#
#csausbkbd_sl811: petusbkbd.a65 $(FILES) $(DEVICE_FILES)
#	$(XA) -I../../device -DSL811_DEV -XC -XMASM $< -P$@.lst -o $@.o65 -l $@.lab
#	$(LINK) -o $@ $@.o65 
#
#csausbkbd_max3420: petusbkbd.a65 $(FILES) $(DEVICE_FILES)
#	$(XA) -I../../device -DMAX3420_DEV -XC -XMASM $< -P$@.lst -o $@.o65 -l $@.lab
#	$(LINK) -o $@ $@.o65 
#

clean:
	rm -f *.o65 *.lst *.lab *.tmp
	rm -f ${MAIN}


