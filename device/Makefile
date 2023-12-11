
all: usbdev.o65 devmsg.o65 kbddev.o65


%.o65: %.a65
	xa -R -U -P $*.lst -I../common -XC -XMASM -o $@ $<

clean:
	rm -f *.o65 *.lst

