
all: max3421e.o65 sl811_host.o65

%.o65: %.a65
	xa -R -XC -XMASM -U -P $*.lst -I../../common -I../../host -o $@ $<

clean:
	rm -f *.o65 *.lst
