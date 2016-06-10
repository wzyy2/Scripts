# /bin/bash

export CROSS_COMPILE=arm-linux-gnueabihf-
export DISCIMAGE=/home/jacob/workbench/crossCompiling/build

compiled_all()
{
	sudo apt-get install jhbuild groff zlib1g-dev libfreetype6-dev libxml2-dev docbook gperf flex bison libssl-dev
	sudo apt-get build-dep mesa
	sudo apt-get build-dep xorg-server

	mkdir  ~/sources

	cd ~/sources

	apt-get source zlib
	cd zlib*
	AR=${CROSS_COMPILE}ar CC=${CROSS_COMPILE}gcc RANLIB=${CROSS_COMPILE}ranlib ./configure --prefix=$DISCIMAGE/usr/local/
	make
	make install

	cd ..

	apt-get source libpng
	cd libpng*
	LDFLAGS="-L$DISCIMAGE/usr/local/lib" CPPFLAGS="-I$DISCIMAGE/usr/local/include" ./configure --prefix=$DISCIMAGE/usr  --host=${CROSS_COMPILE%-}
	make
	make install

	cd ..

	apt-get source expat
	cd expat*
	AR=${CROSS_COMPILE}ar CC=${CROSS_COMPILE}gcc ./configure --prefix=$DISCIMAGE/usr/local/ --host=${CROSS_COMPILE%-}
	make
	make install

	cd ..

	cd ~/sources
	wget http://www.openssl.org/source/openssl-0.9.8h.tar.gz
	tar -zxvf openssl-0.9.8h.tar.gz
	cd openssl*
	./Configure dist --prefix=$DISCIMAGE/usr/local
	make CC="${CROSS_COMPILE}gcc" AR="${CROSS_COMPILE}ar r" RANLIB="${CROSS_COMPILE}ranlib"
	make CC="${CROSS_COMPILE}gcc" AR="${CROSS_COMPILE}ar r" RANLIB="${CROSS_COMPILE}ranlib" install

	cd ..
	
	jhbuild build xserver --ignore-suggests
}

compiled_xserver()
{
	# jhbuild build xserver --skip=mesa-mesa
	jhbuild build  xserver  --no-network --start-at=xserver
}

case "$1" in
    build_all)
        compiled_all
	compiled_xserver
        ;;
    build_xserver)
	compiled_xserver
        ;;
    *)
        echo "Usage: $0 build_all | build_xserver"
        exit 3
esac
