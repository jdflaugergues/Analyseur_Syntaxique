# repertoire contenant les sources de graphlib_w2
GRAPHLIBDIR = ../graphlib_w2

# utilisation d'images au format Xpm
XPM = -DXPM

GCC = gcc
GNATCC = /opt/gnu/ada/bin/gcc

CCOPTS = -I $(GRAPHLIBDIR) $(XPM)
GNATCCOPTS = 

%.o: $(GRAPHLIBDIR)/%.c $(GRAPHLIBDIR)/%.h
	$(GCC) -c -g -Wall $(CCOPTS) $<

%.ali: $(GRAPHLIBDIR)/%.ads
	ADA_INCLUDE_PATH=$(GRAPHLIBDIR) $(GNATCC) -c -g $(GNATCCOPTS) $<
	/bin/rm -f `basename $@ .ali`.o

%.o: %.adb
	ADA_INCLUDE_PATH=$(GRAPHLIBDIR) $(GNATCC) -c -g $(GNATCCOPTS) $<

all: libgraphsimple.a

libgraphsimple.a: graphsimple.o graphlib_w2.ali graphlib_w2.o
	ar rc libgraphsimple.a graphsimple.o graphlib_w2.o

clean:
	/bin/rm -fR *.o *.a *.ps *~ b~* *.ali

cleanall: clean
	/bin/rm -fR $(INCDESTDIR)/* $(LIBDESTDIR)/*
