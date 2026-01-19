
MAIN=upetusb
ROM=petrom4ldr

MAIN_O65=petusb4.o65 
TSR_O65=petusbdrv.o65 overlayscreen.o65

MXTSR=mxdrvtsr
MXLOADER=mxdrv
MXDRIVER_O65=../../drivers/host/max3421e.o65 ../../drivers/spi/upetspi.o65 
MXBIND_O65=bind_upet_max3421e.o65
MXOBJ_O65=${MXDRIVER_O65} ${MXBIND_O65}

SLTSR=sldrvtsr
SLLOADER=sldrv
SLDRIVER_O65=../../drivers/host/sl811_host.o65 
SLBIND_O65=bind_upet_csa_sl811hs.o65 
SLOBJ_O65=${SLDRIVER_O65} ${SLBIND_O65}

HOST_O65=../../host/usb.o65 ../../host/hostmsg.o65
COMMON_O65=../../common/debug.o65 

all: ${MAIN} ${MXLOADER} ${SLLOADER} ${ROM}

###############################################
# base

${MXDRIVER_O65} ${SLDRIVER_O65}:
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
# Using MAX3421 driver

${MAIN}.o65: ${MAIN_O65} ${HOST_O65} ${COMMON_O65} ${MXOBJ_O65}
	ldo65 -G -v -v -o $@ $^

${MAIN}: ${MAIN}.o65
	reloc65 -X -bt 1023 -bz 66 -o $@ $<

###############################################
# MAX3421 

${MXTSR}: ${TSR_O65} ${HOST_O65} ${COMMON_O65} ${MXOBJ_O65}
	ldo65 -G -v -v -o $@.o65 $^
	reloc65 -X -bt 24576 -bz 192 -o $@ $@.o65

${MXLOADER}: petusbloader.o65 ${MXTSR}
	reloc65 -X -bt 1023 -o $@ $<
	cat ${MXTSR} >> $@

###############################################
# SL811HS

${SLTSR}: ${TSR_O65} ${HOST_O65} ${COMMON_O65} ${SLOBJ_O65}
	ldo65 -G -v -v -o $@.o65 $^
	reloc65 -X -bt 24576 -bz 192 -o $@ $@.o65

${SLLOADER}: petusbloader.o65 ${SLTSR}
	reloc65 -X -bt 1023 -o $@ $<
	cat ${SLTSR} >> $@

###############################################
# binding patched into ROM, driver in bank 7

virtscreen.o65: virtscreen.a65 
	xa -w -R -XMASM -bt 57088 -P $(patsubst %.o65,%.lst,$@) -o $@ $<

petrom4_comp: petrom4_comp.o65 
	# patched into $$df**
	reloc65 -X -bt 57088 -o $@ $<

petrom: usbrom.o65 virtscreen.o65 ${HOST_O65} ${COMMON_O65} ${MXDRIVER_O65} ${MXBIND_O65}
	# loaded to $$1000 in USB bank (7)
	ldo65 -o $@.o65 $^
	reloc65 -v -X -bt 4096 -bz 32 -o $@ $@.o65

petrom4ldr: petrom4ldr.a65 petrom4_comp.a65 petrom4_install.a65 petrom
	xa -w -XMASM -P $@.lst -o $@ $<

###############################################

clean:
	rm -f *.o65 *.lst 
	rm -f ${MAIN}
	rm -f ${MXTSR} ${MXLOADER}
	rm -f ${SLTSR} ${SLLOADER}
	rm -f ${ROM} usbrom petromcomp petrom


