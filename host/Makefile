
all: usb.o65 hostmsg.o65


%.o65: %.a65
	xa -R -U -P $*.lst -I../common -XC -XMASM -o $@ $<

clean:
	rm -f *.o65 *.lst

