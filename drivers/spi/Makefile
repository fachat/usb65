
all: cbmusb_pet.o65 spi65b.o65 upetspi.o65 

%.o65: %.a65
	xa -R -XC -P $*.lst -I../../common -o $@ $<

clean:
	rm -f *.o65 *.lst
