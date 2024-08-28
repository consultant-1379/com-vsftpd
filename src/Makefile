# Makefile for systems with GNU tools
CC 	=gcc
INSTALL	=install
IFLAGS  = -idirafter dummyinc
CFLAGS	=-O2 -fPIE -fstack-protector --param=ssp-buffer-size=4 \
	-Wall -W -Wshadow -Wformat-security \
	-D_FORTIFY_SOURCE=2 -std=gnu99
LINK	=-Wl,-s
LDFLAGS	=-fPIE -pie -Wl,-z,relro -Wl,-z,now,-ldl,-lssl,-lcrypto

ifeq ($(COMVSFTPD_THUNK),ON)
CFLAGS += -mindirect-branch=thunk
endif

# If these environment variables are not set,
# we are building and install in current directory
ifeq ($(VSFTPD_BUILDDIR),)
VSFTPD_BUILDDIR :=.
endif
ifeq ($(VSFTPD_DESTDIR),)
VSFTPD_DESTDIR :=.
endif

LIBS	=`./vsf_findlibs.sh $(VSFTPD_BUILDDIR)`

OBJS	:= \
	$(VSFTPD_BUILDDIR)/main.o \
	$(VSFTPD_BUILDDIR)/utility.o \
	$(VSFTPD_BUILDDIR)/prelogin.o \
	$(VSFTPD_BUILDDIR)/ftpcmdio.o \
	$(VSFTPD_BUILDDIR)/postlogin.o \
	$(VSFTPD_BUILDDIR)/privsock.o \
	$(VSFTPD_BUILDDIR)/tunables.o \
	$(VSFTPD_BUILDDIR)/ftpdataio.o \
	$(VSFTPD_BUILDDIR)/secbuf.o \
	$(VSFTPD_BUILDDIR)/ls.o \
	$(VSFTPD_BUILDDIR)/postprivparent.o \
	$(VSFTPD_BUILDDIR)/logging.o \
	$(VSFTPD_BUILDDIR)/str.o \
	$(VSFTPD_BUILDDIR)/netstr.o \
	$(VSFTPD_BUILDDIR)/sysstr.o \
	$(VSFTPD_BUILDDIR)/strlist.o \
	$(VSFTPD_BUILDDIR)/banner.o \
	$(VSFTPD_BUILDDIR)/filestr.o \
	$(VSFTPD_BUILDDIR)/parseconf.o \
	$(VSFTPD_BUILDDIR)/secutil.o \
	$(VSFTPD_BUILDDIR)/ascii.o \
	$(VSFTPD_BUILDDIR)/oneprocess.o \
	$(VSFTPD_BUILDDIR)/twoprocess.o \
	$(VSFTPD_BUILDDIR)/privops.o \
	$(VSFTPD_BUILDDIR)/standalone.o \
	$(VSFTPD_BUILDDIR)/hash.o \
	$(VSFTPD_BUILDDIR)/tcpwrap.o \
	$(VSFTPD_BUILDDIR)/ipaddrparse.o \
	$(VSFTPD_BUILDDIR)/access.o \
	$(VSFTPD_BUILDDIR)/features.o \
	$(VSFTPD_BUILDDIR)/readwrite.o \
	$(VSFTPD_BUILDDIR)/opts.o \
	$(VSFTPD_BUILDDIR)/ssl.o \
	$(VSFTPD_BUILDDIR)/sslslave.o \
	$(VSFTPD_BUILDDIR)/ptracesandbox.o \
	$(VSFTPD_BUILDDIR)/ftppolicy.o \
	$(VSFTPD_BUILDDIR)/sysutil.o \
        $(VSFTPD_BUILDDIR)/sysdeputil.o \
	$(VSFTPD_BUILDDIR)/seccompsandbox.o

$(VSFTPD_BUILDDIR)/%.o: %.c
	$(CC) -c $*.c $(CFLAGS) $(IFLAGS) -o $@

com-vsftpd: $(OBJS)
	$(CC) -o $(VSFTPD_BUILDDIR)/com-vsftpd $(OBJS) $(LINK) $(LDFLAGS) $(LIBS)


# N.B. We are installing to a place that later on will be used for building RPM.
# This is not the file-system of the CBA-cluster.
install_cba_build:
	mkdir -p $(VSFTPD_DESTDIR)/opt;\
	mkdir -p $(VSFTPD_DESTDIR)/$(COM_VSFTPD_INSTALL_PREFIX);\
	mkdir -p $(VSFTPD_DESTDIR)/$(COM_VSFTPD_INSTALL_PREFIX)/bin;\
	mkdir -p $(VSFTPD_DESTDIR)/$(COM_VSFTPD_INSTALL_PREFIX)/etc;\
	mkdir -p $(VSFTPD_DESTDIR)/$(COM_VSFTPD_INSTALL_PREFIX)/etc/pam.d;\
	$(INSTALL) -m 755 $(VSFTPD_BUILDDIR)/com-vsftpd $(VSFTPD_DESTDIR)/$(COM_VSFTPD_INSTALL_PREFIX)/bin;\
	$(INSTALL) -m 644 com-vsftpd.conf $(VSFTPD_DESTDIR)/$(COM_VSFTPD_INSTALL_PREFIX)/etc/com-vsftpd.conf;\
	$(INSTALL) -m 644 ./pam.d/com-vsftpd $(VSFTPD_DESTDIR)/$(COM_VSFTPD_INSTALL_PREFIX)/etc/pam.d/com-vsftpd;\
	$(INSTALL) -m 755 $(VSFTPD_BUILDDIR)/tmp/com-vsftpd.sh $(VSFTPD_DESTDIR)/$(COM_VSFTPD_INSTALL_PREFIX)/bin;\

clean:
	rm -f $(VSFTPD_BUILDDIR)/*.o $(VSFTPD_BUILDDIR)/*.a $(VSFTPD_BUILDDIR)/*.swp $(VSFTPD_BUILDDIR)/com-vsftpd
