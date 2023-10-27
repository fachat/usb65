
all: usb.o65


usb.o65: *.a65
	xa -R -U -I../common -XMASM -o usb.o65 usb.a65

clean:
	rm -f *.o65

