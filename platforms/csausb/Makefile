
MAIN=csausb

MAIN_O65=petusb4.o65 
TSR_O65=petusbdrv.o65 overlayscreen.o65

SLTSR=sldrvtsr
SLLOADER=sldrv
SLDRIVER_O65=../../drivers/host/sl811_host.o65 
SLBIND_O65=bind_csa_sl811hs.o65 
SLOBJ_O65=${SLDRIVER_O65} ${SLBIND_O65}

HOST_O65=../../host/usb.o65 ../../host/hostmsg.o65
COMMON_O65=../../common/debug.o65 

all: ${MAIN} ${SLLOADER} 

###############################################
# base

${SLDRIVER_O65}:
	make -C ../../drivers

${HOST_O65}:
	make -C ../../host

${COMMON_O65}:
	make -C ../../common

%.o65: %.a65
	xa -R -U -XMASM -bt 1023 -I../../common -P $*.lst -I../../host -o $@ $<

# for listing with correct address
petusbdrv.o65: petusbdrv.a65
	xa -R -U -XMASM -bt 24576 -I../../common -P $(patsubst %.o65,%.lst,$@) -I../../host -DSPIADDR=2 -o $@ $<

###############################################
# Using SL811HS driver

${MAIN}.o65: ${MAIN_O65} ${HOST_O65} ${COMMON_O65} ${SLOBJ_O65}
	ldo65 -G -v -v -o $@ $^

${MAIN}: ${MAIN}.o65
	reloc65 -X -bt 1023 -bz 66 -o $@ $<

###############################################
# SL811HS

${SLTSR}: ${TSR_O65} ${HOST_O65} ${COMMON_O65} ${SLOBJ_O65}
	ldo65 -G -v -v -o $@.o65 $^
	reloc65 -X -bt 24576 -bz 192 -o $@ $@.o65

${SLLOADER}: ${SLTSR} petusbloader.o65 
	reloc65 -X -bt 1023 -o $@ petusbloader.o65

###############################################

clean:
	rm -f *.o65 *.lst 
	rm -f ${MAIN}
	rm -f ${SLTSR} ${SLLOADER}


