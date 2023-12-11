
MAIN=petusb

MAIN_O65=petusb4.o65 
TSR_O65=petusbdrv.o65 overlayscreen.o65

MXTSR=mxdrvtsr
MXLOADER=mxdrv
MXDRIVER_O65=../../drivers/host/max3421e.o65 ../../drivers/spi/cbmusb_pet.o65
MXBIND_O65=bind_petup_max3421e.o65 
MXOBJ_O65=${MXDRIVER_O65} ${MXBIND_O65}

HOST_O65=../../host/usb.o65 ../../host/hostmsg.o65
COMMON_O65=../../common/debug.o65 

all: ${MAIN} ${MXLOADER} 

###############################################
# base

${MXDRIVER_O65}:
	make -C ../../drivers

${HOST_O65}:
	make -C ../../host

${COMMON_O65}:
	make -C ../../common

%.o65: %.a65
	xa -R -U -XMASM -bt 1023 -I../../common -P $*.lst -I../../host -o $@ $<

# for listing with correct address
petusbdrv.o65: petusbdrv.a65
	xa -R -U -XMASM -bt 24576 -I../../common -P $(patsubst %.o65,%.lst,$@) -I../../host -o $@ $<

###############################################
# Using MAX3421E driver

${MAIN}.o65: ${MAIN_O65} ${HOST_O65} ${COMMON_O65} ${MXOBJ_O65}
	ldo65 -G -v -v -o $@ $^

${MAIN}: ${MAIN}.o65
	reloc65 -X -bt 1023 -bz 66 -o $@ $<

###############################################
# MAX3421E

${MXTSR}: ${TSR_O65} ${HOST_O65} ${COMMON_O65} ${MXOBJ_O65}
	ldo65 -G -v -v -o $@.o65 $^
	reloc65 -X -bt 24576 -bz 192 -o $@ $@.o65

${MXLOADER}: ${MXTSR} petusbloader.o65 
	reloc65 -X -bt 1023 -o $@ petusbloader.o65
	cat ${MXTSR} >> $@

###############################################

clean:
	rm -f *.o65 *.lst 
	rm -f ${MAIN}
	rm -f ${MXTSR} ${MXLOADER}


