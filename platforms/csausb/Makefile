

DRIVER_O65=../../drivers/host/max3421e.o65 ../../drivers/spi/cbmusb_pet.o65
HOST_O65=../../host/usb.o65 
MAIN_O65=petusb4.o65

FILES=$(COMMON_FILES) $(DRIVER_FILES)

##LINK=reloc65 -bt 1023 -bz 17 -X -v
#XAX=xa -R -U -c -bt 24576 -bz 192 -XC -XMASM -I../../common -I../../drivers
#LINK=reloc65 -bt 1023 -bz 66 -X 


all: petusb

${DRIVER_O65}:
	make -C ../../drivers

${HOST_O65}:
	make -C ../../host

%.o65: %.a65
	xa -R -U -I../../common -I../../host -o $@ $<

petusb.o65: ${MAIN_O65} ${DRIVER_O65} ${HOST_O65}
	ldo65 -G -o $@ $^

petusb: petusb.o65
	reloc65 -X -bt 1023 -bz 66 -o $@ $<

clean:
	rm -f *.o65

