
all: max3420e.o65 sl811_dev.o65

%.o65: %.a65
	xa -R -XC -XMASM -U -P $*.lst -I../../common -I../../device -o $@ $<

clean:
	rm -f *.o65 *.lst
