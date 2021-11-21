# Unix C makefile for the Infocom tools

CC = cc
NROFF	= nroff
CLANG_FORMAT = clang-format
PYTHON3 = python3

#Some systems declare getopt, others do not.  Pick whichever works
#CFLAGS = -O -DHAS_GETOPT
CFLAGS = -DHAS_VSNPRINTF -g --std=c89 -Wall -Wextra -Werror -Wno-implicit-fallthrough -Wno-implicit-function-declaration
LDFLAGS =
LIBS =


.SUFFIXES: .c .h .1 .man

.1.man:
	$(NROFF) -man $*.1 | col -b > $*.man

MANPAGES = infodump.1 inforead.1 txd.1 check.1 pix2gif.1
FORMATTEDMAN = $(MANPAGES:.1=.man)

SRCS = check.c getopt.c infinfo.c infodump.c inforead.c pix2gif.c showdict.c \
	showhead.c showobj.c showverb.c symbols.c txd.c txio.c
HDRS = infinfo.h pix2gif.h symbols.h tx.h
ntrrrrrrrrrrrrrrrrrrrrrr3,............-zssssssssssssssssssss
CINC =
COBJS = check.o

IINC = tx.h
IOBJS = infodump.o showhead.o showdict.o showobj.o showverb.o txio.o infinfo.o symbols.o

PINC = pix2gif.h
POBJS = pix2gif.o

TINC = tx.h
TOBJS = txd.o txio.o showverb.o infinfo.o symbols.o showobj.o

all : check infodump pix2gif txd doc

check : $(COBJS)
	$(CC) -o $@ $(LDFLAGS) $(COBJS) $(LIBS)

$(COBJS) : $(CINC)

infodump : $(IOBJS)
	$(CC) -o $@ $(LDFLAGS) $(IOBJS) $(LIBS)

$(IOBJS) : $(IINC)

pix2gif : $(POBJS)
	$(CC) -o $@ $(LDFLAGS) $(POBJS) $(LIBS)

$(POBJS) : $(PINC)

txd : $(TOBJS)
	$(CC) -o $@ $(LDFLAGS) $(TOBJS) $(LIBS)

$(TOBJS) : $(TINC)

clean :
	-rm *.o check infodump pix2gif txd $(FORMATTEDMAN)

doc: $(FORMATTEDMAN)

.SUFFIXES: .c .h .c_f .h_f
FORMATS = $(SRCS:.c=.c_f) $(HDRS:.h=.h_f)

.PHONY: checkformat format

format: $(FORMATS)
	rm *.c_f *.h_f

.h.h_f .c.c_f:
	$(CLANG_FORMAT) $$($(PYTHON3) get_format_range.py < $<) \
		--style=file -i "$<"
	touch "$@"


checkformat:
	for i in $(SRCS) $(HDRS) ; do \
	  $(CLANG_FORMAT) $$($(PYTHON3) get_format_range.py < $$i) \
	      --style=file -n "$$i" ; \
	done
