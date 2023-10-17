PREFIX = /usr/local
MANPREFIX = ${PREFIX}/share/man

# OpenBSD
#MANPREFIX = ${PREFIX}/man

SRC = uhm.c
OBJ = ${SRC:.c=.o}

all: uhm

.c.o:
	${CC} -c ${FLAGS} $<

uhm: ${OBJ}
	${CC} -o $@ ${OBJ} ${LDFLAGS}

clean:
	rm -rf uhm ${OBJ} uhm.tar.gz

dist: clean
	mkdir uhm
	cp LICENSE Makefile README getopt.diff\
		uhm.1 uhm.c uhm.rc uhm
	tar -cf uhm.tar uhm
	gzip uhm.tar
	rm -rf uhm

install: all
	mkdir -p ${DESTDIR}${PREFIX}/bin
	cp -f uhm ${DESTDIR}${PREFIX}/bin
	chmod 755 ${DESTDIR}${PREFIX}/bin/uhm
	mkdir -p ${DESTDIR}${MANPREFIX}/man1
	cp -f uhm.1 ${DESTDIR}${MANPREFIX}/man1
	chmod 644 ${DESTDIR}${MANPREFIX}/man1/uhm.1

uninstall:
	rm -f ${DESTDIR}${PREFIX}/bin/uhm\
		${DESTDIR}${MANPREFIX}/man1/uhm.1

.PHONY: all clean dist install uninstall
