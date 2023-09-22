PREFIX = /usr/local
MANPREFIX = ${PREFIX}/man

SRC = uhm.c
OBJ = ${SRC:.c=.o}

all: uhm

.c.o:
	${CC} -c ${FLAGS} $<

uhm: ${OBJ}
	${CC} -o $@ ${OBJ} ${LDFLAGS}

clean:
	rm -f uhm ${OBJ}

install: all
	mkdir -p ${DESTDIR}${PREFIX}/bin
	cp -f uhm ${DESTDIR}${PREFIX}/bin
	chmod 755 ${DESTDIR}${PREFIX}/bin/uhm

uninstall:
	rm -f ${DESTDIR}${PREFIX}/bin/uhm

.PHONY: all clean install uninstall
