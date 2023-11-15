
MAIN=upetusb
TSR=upetusbdrv
LOADER=upetusbloader

DRIVER_O65=../../drivers/host/max3421e.o65 ../../drivers/spi/upetspi.o65
HOST_O65=../../host/usb.o65 ../../host/hostmsg.o65
COMMON_O65=../../common/debug.o65 

MAIN_O65=petusb4.o65
TSR_O65=petusbdrv.o65


FILES=$(COMMON_FILES) $(DRIVER_FILES)

##LINK=reloc65 -bt 1023 -bz 17 -X -v
#XAX=xa -R -U -c -bt 24576 -bz 192 -XC -XMASM -I../../common -I../../drivers
#LINK=reloc65 -bt 1023 -bz 66 -X 


all: ${MAIN} ${LOADER}

${DRIVER_O65}:
	make -C ../../drivers

${HOST_O65}:
	make -C ../../host

${COMMON_O65}:
	make -C ../../common

%.o65: %.a65
	xa -R -U -bt 1023 -I../../common -P $*.lst -I../../host -DSPIADDR=2 -o $@ $<

petusbdrv.o65: petusbdrv.a65
	xa -R -U -bt 24576 -I../../common -P $*.lst -I../../host -DSPIADDR=2 -o $@ $<

${MAIN}.o65: ${MAIN_O65} ${DRIVER_O65} ${HOST_O65}
	ldo65 -G -v -v -o $@ $^

${MAIN}: ${MAIN}.o65
	reloc65 -X -bt 1023 -bz 66 -o $@ $<

${TSR}.o65: ${TSR_O65} ${DRIVER_O65} ${HOST_O65} ${COMMON_O65}
	ldo65 -G -v -v -bt 24576 -o $@ $^

${TSR}: ${TSR}.o65
	reloc65 -X -bt 24576 -bz 192 -o $@ $<

${LOADER}: petusbloader.o65 ${TSR}
	reloc65 -X -bt 1023 -o $@ $<
	cat ${TSR} >> $@

clean:
	rm -f *.o65

