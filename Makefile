# chemin d'acces a graphlib
GRAPHLIBINCDIR = ./graphlib_w2

# chemins d'acces a graphsimple
GRAPHSIMPLEINCDIR = ./graphsimple

# chemin d'acces aux librairies (sources)
INCDIR = $(GRAPHSIMPLEINCDIR):$(GRAPHLIBINCDIR)

# chemin d'acces aux librairies (binaires)
LIBDIR = 

GNATINSTALLDIR = /opt/gnu/ada/bin
GNATMAKE = $(GNATINSTALLDIR)/gnatmake
GDB = $(GNATINSTALLDIR)/gdb

GNATLDOPTS = -L$(GRAPHSIMPLEINCDIR) -lgraphsimple \
             -L/usr/X11R6/lib -lX11 -lrt -lXpm

%: %.o

CIBLE = test_analyseur_syntaxique

all: $(CIBLE)

$(CIBLE): test
test:
	ADA_INCLUDE_PATH=$(INCDIR) \
	ADA_OBJECTS_PATH=$(LIBDIR) \
	$(GNATMAKE) $(CIBLE) -g -largs $(GNATLDOPTS)

gdb:
	$(GDB) $(CIBLE)

clean:
	/bin/rm -fR $(CIBLE) *.o *.ps *~ *.ali b~*
