# utilisation d'images au format Xpm
XPM = -DXPM

GCC = gcc

CCOPTS = $(XPM)

%.o: %.c
	$(GCC) -c -g -Wall $(CCOPTS) $<

%.o: %.c %.h
	$(GCC) -c -g -Wall $(CCOPTS) $<

all: libgraphlib_w2.a

libgraphlib_w2.a: graphlib_w2.o
	ar rc libgraphlib_w2.a graphlib_w2.o

clean:
	/bin/rm -fR *.o *.a *.ps *~ b~* *.ali

cleanall: clean
	/bin/rm -fR $(INCDESTDIR)/* $(LIBDESTDIR)/*
