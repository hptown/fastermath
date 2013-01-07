
AR=ar
ARFLAGS=rcsv

ifeq ($(ARCH),)
default:
	@echo
	@echo need to define ARCH
	@echo
	@exit 1
else

include ../config/$(ARCH).inc
default: all

endif

DEFS=-I../include -I. -D_FM_INTERNAL
CFLAGS= $(CPPFLAGS) $(DEFS) $(ARCHFLAGS) $(GENFLAGS) $(OPTFLAGS) $(WARNFLAGS)
LIBSRC=exp.c exp_alt.c log.c
LIBOBJ=$(LIBSRC:.c=.o)
TESTSRC=tester.c
TESTOBJ=$(TESTSRC:.c=.o)

vpath %.c ../src
vpath %.h ../include

all: libfastermath.so libfastermath.a tester

tester: $(TESTOBJ) libfastermath.a
	$(LD) $(ARCHFLAGS) -o $@ $^ $(LDLIBS) $(TESTLIBS)

libfastermath.so: $(LIBOBJ)
	$(LD) $(LDFLAGS) -o $@ $(LIBOBJ)

libfastermath.a: $(LIBOBJ)
	$(AR) $(ARFLAGS) $@ $(LIBOBJ)

config.c: config-template.c
	sed -e 's,@ARCH@,$(ARCH),' 		\
		-e 's,@CPPFLAGS@,$(CPPFLAGS),'	\
		-e 's,@DEFS@,$(DEFS),'		\
		-e 's,@ARCHFLAGS@,$(ARCHFLAGS),'\
		-e 's,@GENFLAGS@,$(GENFLAGS),'	\
		-e 's,@OPTFLAGS@,$(OPTFLAGS),'	\
		-e 's,@WARNFLAGS@,$(WARNFLAGS),'\
		$< > $@

.depend: $(LIBSRC) $(TESTSRC) config.c
	$(CC) $(DEFS) $(CPPFLAGS) -MM $^ > $@

.PHONY: all default
.SUFFIX:
.SUFFIX: .c .o

.c.o:
	$(CC) -o $@ -c $(CFLAGS) $<

sinclude .depend