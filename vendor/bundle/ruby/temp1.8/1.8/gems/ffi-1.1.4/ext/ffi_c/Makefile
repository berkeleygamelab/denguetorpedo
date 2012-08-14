
SHELL = /bin/sh

#### Start of system configuration section. ####

srcdir = .
topdir = /usr/lib/ruby/1.8/x86_64-linux
hdrdir = $(topdir)
VPATH = $(srcdir):$(topdir):$(hdrdir)
exec_prefix = $(prefix)
prefix = $(DESTDIR)/usr
archdir = $(rubylibdir)/$(arch)
libexecdir = $(prefix)/lib/ruby1.8
sbindir = $(exec_prefix)/sbin
dvidir = $(docdir)
bindir = $(exec_prefix)/bin
rubylibdir = $(libdir)/ruby/$(ruby_version)
infodir = $(prefix)/share/info
sharedstatedir = $(prefix)/com
pdfdir = $(docdir)
mandir = $(prefix)/share/man
localedir = $(datarootdir)/locale
psdir = $(docdir)
sitelibdir = $(sitedir)/$(ruby_version)
sysconfdir = $(DESTDIR)/etc
vendorlibdir = $(vendordir)/$(ruby_version)
sitearchdir = $(sitelibdir)/$(sitearch)
sitedir = $(DESTDIR)/usr/local/lib/site_ruby
datarootdir = $(prefix)/share
datadir = $(datarootdir)
localstatedir = $(DESTDIR)/var
docdir = $(datarootdir)/doc/$(PACKAGE)
includedir = $(prefix)/include
libdir = $(exec_prefix)/lib
vendorarchdir = $(vendorlibdir)/$(sitearch)
vendordir = $(libdir)/ruby/vendor_ruby
htmldir = $(docdir)
oldincludedir = $(DESTDIR)/usr/include

CC = gcc
LIBRUBY = $(LIBRUBY_SO)
LIBRUBY_A = lib$(RUBY_SO_NAME)-static.a
LIBRUBYARG_SHARED = -l$(RUBY_SO_NAME)
LIBRUBYARG_STATIC = -l$(RUBY_SO_NAME)-static

RUBY_EXTCONF_H = extconf.h
CFLAGS   =  -fPIC -fno-strict-aliasing -g -g -O2  -fPIC $(cflags) 
INCFLAGS = -I. -I. -I/usr/lib/ruby/1.8/x86_64-linux -I.
DEFS     = 
CPPFLAGS = -DRUBY_EXTCONF_H=\"$(RUBY_EXTCONF_H)\" -D_FORTIFY_SOURCE=2  -D_FORTIFY_SOURCE=2
CXXFLAGS = $(CFLAGS) 
ldflags  = -L. -Wl,-Bsymbolic-functions -Wl,-z,relro -rdynamic -Wl,-export-dynamic
dldflags = 
archflag = 
DLDFLAGS = $(ldflags) $(dldflags) $(archflag)
LDSHARED = $(CC) -shared
AR = ar
EXEEXT = 

RUBY_INSTALL_NAME = ruby1.8
RUBY_SO_NAME = ruby1.8
arch = x86_64-linux
sitearch = x86_64-linux
ruby_version = 1.8
ruby = /usr/bin/ruby1.8
RUBY = $(ruby)
RM = rm -f
MAKEDIRS = mkdir -p
INSTALL = /usr/bin/install -c
INSTALL_PROG = $(INSTALL) -m 0755
INSTALL_DATA = $(INSTALL) -m 644
COPY = cp

#### End of system configuration section. ####

preload = 

libpath = . $(libdir)
LIBPATH =  -L. -L$(libdir)
DEFFILE = 

CLEANFILES = mkmf.log
DISTCLEANFILES = 

extout = 
extout_prefix = 
target_prefix = 
LOCAL_LIBS = 
LIBS = $(LIBRUBYARG_SHARED)  -lpthread -lrt -ldl -lcrypt -lm   -lc
SRCS = DataConverter.c ArrayType.c DynamicLibrary.c Thread.c LastError.c Platform.c Types.c MappedType.c FunctionInfo.c Type.c Pointer.c StructLayout.c StructByValue.c Call.c ClosurePool.c MethodHandle.c MemoryPointer.c Struct.c Buffer.c Function.c StructByReference.c Variadic.c ffi.c LongDouble.c AbstractMemory.c
OBJS = DataConverter.o ArrayType.o DynamicLibrary.o Thread.o LastError.o Platform.o Types.o MappedType.o FunctionInfo.o Type.o Pointer.o StructLayout.o StructByValue.o Call.o ClosurePool.o MethodHandle.o MemoryPointer.o Struct.o Buffer.o Function.o StructByReference.o Variadic.o ffi.o LongDouble.o AbstractMemory.o
TARGET = ffi_c
DLLIB = $(TARGET).so
EXTSTATIC = 
STATIC_LIB = 

BINDIR        = $(bindir)
RUBYCOMMONDIR = $(sitedir)$(target_prefix)
RUBYLIBDIR = /home/matt/Documents/Projects/reportdengue/vendor/bundle/ruby/1.8/gems/ffi-1.1.4/lib$(target_prefix)
RUBYARCHDIR = /home/matt/Documents/Projects/reportdengue/vendor/bundle/ruby/1.8/gems/ffi-1.1.4/lib$(target_prefix)

TARGET_SO     = $(DLLIB)
CLEANLIBS     = $(TARGET).so $(TARGET).il? $(TARGET).tds $(TARGET).map
CLEANOBJS     = *.o *.a *.s[ol] *.pdb *.exp *.bak

all:		$(DLLIB)
static:		$(STATIC_LIB)

clean:
		@-$(RM) $(CLEANLIBS) $(CLEANOBJS) $(CLEANFILES)

distclean:	clean
		@-$(RM) Makefile $(RUBY_EXTCONF_H) conftest.* mkmf.log
		@-$(RM) core ruby$(EXEEXT) *~ $(DISTCLEANFILES)

realclean:	distclean
install: install-so install-rb

install-so: $(RUBYARCHDIR)
install-so: $(RUBYARCHDIR)/$(DLLIB)
$(RUBYARCHDIR)/$(DLLIB): $(DLLIB)
	$(INSTALL_PROG) $(DLLIB) $(RUBYARCHDIR)
install-rb: pre-install-rb install-rb-default
install-rb-default: pre-install-rb-default
pre-install-rb: Makefile
pre-install-rb-default: Makefile
$(RUBYARCHDIR):
	$(MAKEDIRS) $@

site-install: site-install-so site-install-rb
site-install-so: install-so
site-install-rb: install-rb

.SUFFIXES: .c .m .cc .cxx .cpp .C .o

.cc.o:
	$(CXX) $(INCFLAGS) $(CPPFLAGS) $(CXXFLAGS) -c $<

.cxx.o:
	$(CXX) $(INCFLAGS) $(CPPFLAGS) $(CXXFLAGS) -c $<

.cpp.o:
	$(CXX) $(INCFLAGS) $(CPPFLAGS) $(CXXFLAGS) -c $<

.C.o:
	$(CXX) $(INCFLAGS) $(CPPFLAGS) $(CXXFLAGS) -c $<

.c.o:
	$(CC) $(INCFLAGS) $(CPPFLAGS) $(CFLAGS) -c $<

$(DLLIB): $(OBJS) Makefile
	@-$(RM) $@
	$(LDSHARED) -o $@ $(OBJS) $(LIBPATH) $(DLDFLAGS) $(LOCAL_LIBS) $(LIBS)



$(OBJS): ruby.h defines.h $(RUBY_EXTCONF_H)
LIBFFI_HOST=--host=
include ${srcdir}/libffi.mk
