
all:
	#make -C platforms

clean:
	make -C platforms clean
	make -C drivers clean
	make -C host clean
	make -C common clean
	make -C device clean

