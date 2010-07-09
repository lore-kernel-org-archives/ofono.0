Content-Type: multipart/mixed; boundary="===============1245490120895889315=="
MIME-Version: 1.0
From: Arun Ravindran <arunlee@gmail.com>
Subject: Ofono in Maemo scratchbox--compilation failed.
Date: Fri, 09 Jul 2010 16:51:02 +0300
Message-ID: <AANLkTimBx-_UnBayGYpPV8OcoW4o5IUbtB_Gm32qoCSt@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1245490120895889315==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi All,

I am trying to compile Ofono in Maemo Scratchbox SDK enviornment.

Here is the bootstrap-configure output:
---------------------------------------------------------------------------=
--------------------------------------------------------------------
[sbox-FREMANTLE_X86: ~/ofono] > ./bootstrap-configure
configure.ac: installing `./install-sh'
configure.ac: installing `./missing'
Makefile.am: installing `./compile'
Makefile.am: installing `./depcomp'
checking for a BSD-compatible install... /scratchbox/tools/bin/install -c
checking whether build environment is sane... yes
checking for gawk... gawk
checking whether make sets $(MAKE)... yes
checking whether to enable maintainer-specific portions of Makefiles... yes
checking for pkg-config... /scratchbox/tools/bin/pkg-config
checking pkg-config is at least version 0.9.0... yes
checking for style of include used by make... GNU
checking for gcc... gcc
checking for C compiler default output file name... a.out
checking whether the C compiler works... yes
checking whether we are cross compiling... no
checking for suffix of executables...
checking for suffix of object files... o
checking whether we are using the GNU C compiler... yes
checking whether gcc accepts -g... yes
checking for gcc option to accept ISO C89... none needed
checking dependency style of gcc... gcc3
checking for C/C++ restrict keyword... no
checking for gcc... (cached) gcc
checking whether we are using the GNU C compiler... (cached) yes
checking whether gcc accepts -g... (cached) yes
checking for gcc option to accept ISO C89... (cached) none needed
checking dependency style of gcc... (cached) gcc3
checking whether gcc and cc understand -c and -o together... yes
checking whether gcc accepts -fPIE... yes
checking for a BSD-compatible install... /scratchbox/tools/bin/install -c
checking for a sed that does not truncate output...
/scratchbox/tools/bin/sed
checking for gawk... (cached) gawk
checking build system type... i486-pc-linux-gnu
checking host system type... i486-pc-linux-gnu
checking for a sed that does not truncate output...
/scratchbox/tools/bin/sed
checking for grep that handles long lines and -e...
/scratchbox/tools/bin/grep
checking for egrep... /scratchbox/tools/bin/grep -E
checking for ld used by gcc...
/scratchbox/compilers/cs2007q3-glibc2.5-i486/i486-pc-linux-gnu/bin/ld
checking if the linker
(/scratchbox/compilers/cs2007q3-glibc2.5-i486/i486-pc-linux-gnu/bin/ld) is
GNU ld... yes
checking for
/scratchbox/compilers/cs2007q3-glibc2.5-i486/i486-pc-linux-gnu/bin/ld option
to reload object files... -r
checking for BSD-compatible nm... /scratchbox/compilers/bin/nm -B
checking whether ln -s works... yes
checking how to recognize dependent libraries... pass_all
checking how to run the C preprocessor... gcc -E
checking for ANSI C header files... yes
checking for sys/types.h... yes
checking for sys/stat.h... yes
checking for stdlib.h... yes
checking for string.h... yes
checking for memory.h... yes
checking for strings.h... yes
checking for inttypes.h... yes
checking for stdint.h... yes
checking for unistd.h... yes
checking dlfcn.h usability... yes
checking dlfcn.h presence... yes
checking for dlfcn.h... yes
checking the maximum length of command line arguments... 98304
checking command to parse /scratchbox/compilers/bin/nm -B output from gcc
object... failed
checking for objdir... .libs
checking for ar... ar
checking for ranlib... ranlib
checking for strip... strip
checking if gcc supports -fno-rtti -fno-exceptions... no
checking for gcc option to produce PIC... -fPIC
checking if gcc PIC flag -fPIC works... yes
checking if gcc static flag -static works... yes
checking if gcc supports -c -o file.o... yes
checking whether the gcc linker
(/scratchbox/compilers/cs2007q3-glibc2.5-i486/i486-pc-linux-gnu/bin/ld)
supports shared libraries... yes
checking whether -lc should be explicitly linked in... no
checking dynamic linker characteristics... GNU/Linux ld.so
checking how to hardcode library paths into programs... immediate
checking whether stripping libraries is possible... yes
checking if libtool supports shared libraries... yes
checking whether to build shared libraries... yes
checking whether to build static libraries... no
configure: creating libtool
checking for BSD-compatible nm... (cached) /scratchbox/compilers/bin/nm -B
checking for signalfd in -lc... yes
checking for dlopen in -ldl... yes
checking for GLIB... yes
checking for DBUS... yes
checking for dbus_watch_get_unix_fd in -ldbus-1... yes
checking for dbus_connection_can_send_type in -ldbus-1... no
checking for UDEV... yes
checking for CAPNG... yes
configure: creating ./config.status
config.status: creating Makefile
config.status: creating include/version.h
config.status: creating config.h
config.status: executing depfiles commands
-------------------------------------------------------------------


But while running make, i get the following error.

[sbox-FREMANTLE_X86: ~/ofono] > make
make --no-print-directory all-am
include/ofono
make[1]: include/ofono: Command not found
make[1]: *** [include/ofono/log.h] Error 127
make: *** [all] Error 2
----------------------------------------------------------------------------

What could be the reason? Could anyone help?

Regards
Arun

--===============1245490120895889315==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

SGkgQWxsLDxicj48YnI+SSBhbSB0cnlpbmcgdG8gY29tcGlsZSBPZm9ubyBpbiBNYWVtbyBTY3Jh
dGNoYm94IFNESyBlbnZpb3JubWVudC4gPGJyPjxicj5IZXJlIGlzIHRoZSBib290c3RyYXAtY29u
ZmlndXJlIG91dHB1dDo8YnI+LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS08YnI+CltzYm94
LUZSRU1BTlRMRV9YODY6IH4vb2Zvbm9dICZndDsgLi9ib290c3RyYXAtY29uZmlndXJlIDxicj48
YSBocmVmPSJodHRwOi8vY29uZmlndXJlLmFjIj5jb25maWd1cmUuYWM8L2E+OiBpbnN0YWxsaW5n
IGAuL2luc3RhbGwtc2gmIzM5Ozxicj48YSBocmVmPSJodHRwOi8vY29uZmlndXJlLmFjIj5jb25m
aWd1cmUuYWM8L2E+OiBpbnN0YWxsaW5nIGAuL21pc3NpbmcmIzM5Ozxicj5NYWtlZmlsZS5hbTog
aW5zdGFsbGluZyBgLi9jb21waWxlJiMzOTs8YnI+Ck1ha2VmaWxlLmFtOiBpbnN0YWxsaW5nIGAu
L2RlcGNvbXAmIzM5Ozxicj5jaGVja2luZyBmb3IgYSBCU0QtY29tcGF0aWJsZSBpbnN0YWxsLi4u
IC9zY3JhdGNoYm94L3Rvb2xzL2Jpbi9pbnN0YWxsIC1jPGJyPmNoZWNraW5nIHdoZXRoZXIgYnVp
bGQgZW52aXJvbm1lbnQgaXMgc2FuZS4uLiB5ZXM8YnI+Y2hlY2tpbmcgZm9yIGdhd2suLi4gZ2F3
azxicj5jaGVja2luZyB3aGV0aGVyIG1ha2Ugc2V0cyAkKE1BS0UpLi4uIHllczxicj4KY2hlY2tp
bmcgd2hldGhlciB0byBlbmFibGUgbWFpbnRhaW5lci1zcGVjaWZpYyBwb3J0aW9ucyBvZiBNYWtl
ZmlsZXMuLi4geWVzPGJyPmNoZWNraW5nIGZvciBwa2ctY29uZmlnLi4uIC9zY3JhdGNoYm94L3Rv
b2xzL2Jpbi9wa2ctY29uZmlnPGJyPmNoZWNraW5nIHBrZy1jb25maWcgaXMgYXQgbGVhc3QgdmVy
c2lvbiAwLjkuMC4uLiB5ZXM8YnI+Y2hlY2tpbmcgZm9yIHN0eWxlIG9mIGluY2x1ZGUgdXNlZCBi
eSBtYWtlLi4uIEdOVTxicj4KY2hlY2tpbmcgZm9yIGdjYy4uLiBnY2M8YnI+Y2hlY2tpbmcgZm9y
IEMgY29tcGlsZXIgZGVmYXVsdCBvdXRwdXQgZmlsZSBuYW1lLi4uIGEub3V0PGJyPmNoZWNraW5n
IHdoZXRoZXIgdGhlIEMgY29tcGlsZXIgd29ya3MuLi4geWVzPGJyPmNoZWNraW5nIHdoZXRoZXIg
d2UgYXJlIGNyb3NzIGNvbXBpbGluZy4uLiBubzxicj5jaGVja2luZyBmb3Igc3VmZml4IG9mIGV4
ZWN1dGFibGVzLi4uIDxicj4KY2hlY2tpbmcgZm9yIHN1ZmZpeCBvZiBvYmplY3QgZmlsZXMuLi4g
bzxicj5jaGVja2luZyB3aGV0aGVyIHdlIGFyZSB1c2luZyB0aGUgR05VIEMgY29tcGlsZXIuLi4g
eWVzPGJyPmNoZWNraW5nIHdoZXRoZXIgZ2NjIGFjY2VwdHMgLWcuLi4geWVzPGJyPmNoZWNraW5n
IGZvciBnY2Mgb3B0aW9uIHRvIGFjY2VwdCBJU08gQzg5Li4uIG5vbmUgbmVlZGVkPGJyPmNoZWNr
aW5nIGRlcGVuZGVuY3kgc3R5bGUgb2YgZ2NjLi4uIGdjYzM8YnI+CmNoZWNraW5nIGZvciBDL0Mr
KyByZXN0cmljdCBrZXl3b3JkLi4uIG5vPGJyPmNoZWNraW5nIGZvciBnY2MuLi4gKGNhY2hlZCkg
Z2NjPGJyPmNoZWNraW5nIHdoZXRoZXIgd2UgYXJlIHVzaW5nIHRoZSBHTlUgQyBjb21waWxlci4u
LiAoY2FjaGVkKSB5ZXM8YnI+Y2hlY2tpbmcgd2hldGhlciBnY2MgYWNjZXB0cyAtZy4uLiAoY2Fj
aGVkKSB5ZXM8YnI+Y2hlY2tpbmcgZm9yIGdjYyBvcHRpb24gdG8gYWNjZXB0IElTTyBDODkuLi4g
KGNhY2hlZCkgbm9uZSBuZWVkZWQ8YnI+CmNoZWNraW5nIGRlcGVuZGVuY3kgc3R5bGUgb2YgZ2Nj
Li4uIChjYWNoZWQpIGdjYzM8YnI+Y2hlY2tpbmcgd2hldGhlciBnY2MgYW5kIGNjIHVuZGVyc3Rh
bmQgLWMgYW5kIC1vIHRvZ2V0aGVyLi4uIHllczxicj5jaGVja2luZyB3aGV0aGVyIGdjYyBhY2Nl
cHRzIC1mUElFLi4uIHllczxicj5jaGVja2luZyBmb3IgYSBCU0QtY29tcGF0aWJsZSBpbnN0YWxs
Li4uIC9zY3JhdGNoYm94L3Rvb2xzL2Jpbi9pbnN0YWxsIC1jPGJyPgpjaGVja2luZyBmb3IgYSBz
ZWQgdGhhdCBkb2VzIG5vdCB0cnVuY2F0ZSBvdXRwdXQuLi4gL3NjcmF0Y2hib3gvdG9vbHMvYmlu
L3NlZDxicj5jaGVja2luZyBmb3IgZ2F3ay4uLiAoY2FjaGVkKSBnYXdrPGJyPmNoZWNraW5nIGJ1
aWxkIHN5c3RlbSB0eXBlLi4uIGk0ODYtcGMtbGludXgtZ251PGJyPmNoZWNraW5nIGhvc3Qgc3lz
dGVtIHR5cGUuLi4gaTQ4Ni1wYy1saW51eC1nbnU8YnI+Y2hlY2tpbmcgZm9yIGEgc2VkIHRoYXQg
ZG9lcyBub3QgdHJ1bmNhdGUgb3V0cHV0Li4uIC9zY3JhdGNoYm94L3Rvb2xzL2Jpbi9zZWQ8YnI+
CmNoZWNraW5nIGZvciBncmVwIHRoYXQgaGFuZGxlcyBsb25nIGxpbmVzIGFuZCAtZS4uLiAvc2Ny
YXRjaGJveC90b29scy9iaW4vZ3JlcDxicj5jaGVja2luZyBmb3IgZWdyZXAuLi4gL3NjcmF0Y2hi
b3gvdG9vbHMvYmluL2dyZXAgLUU8YnI+Y2hlY2tpbmcgZm9yIGxkIHVzZWQgYnkgZ2NjLi4uIC9z
Y3JhdGNoYm94L2NvbXBpbGVycy9jczIwMDdxMy1nbGliYzIuNS1pNDg2L2k0ODYtcGMtbGludXgt
Z251L2Jpbi9sZDxicj4KY2hlY2tpbmcgaWYgdGhlIGxpbmtlciAoL3NjcmF0Y2hib3gvY29tcGls
ZXJzL2NzMjAwN3EzLWdsaWJjMi41LWk0ODYvaTQ4Ni1wYy1saW51eC1nbnUvYmluL2xkKSBpcyBH
TlUgbGQuLi4geWVzPGJyPmNoZWNraW5nIGZvciAvc2NyYXRjaGJveC9jb21waWxlcnMvY3MyMDA3
cTMtZ2xpYmMyLjUtaTQ4Ni9pNDg2LXBjLWxpbnV4LWdudS9iaW4vbGQgb3B0aW9uIHRvIHJlbG9h
ZCBvYmplY3QgZmlsZXMuLi4gLXI8YnI+CmNoZWNraW5nIGZvciBCU0QtY29tcGF0aWJsZSBubS4u
LiAvc2NyYXRjaGJveC9jb21waWxlcnMvYmluL25tIC1CPGJyPmNoZWNraW5nIHdoZXRoZXIgbG4g
LXMgd29ya3MuLi4geWVzPGJyPmNoZWNraW5nIGhvdyB0byByZWNvZ25pemUgZGVwZW5kZW50IGxp
YnJhcmllcy4uLiBwYXNzX2FsbDxicj5jaGVja2luZyBob3cgdG8gcnVuIHRoZSBDIHByZXByb2Nl
c3Nvci4uLiBnY2MgLUU8YnI+CmNoZWNraW5nIGZvciBBTlNJIEMgaGVhZGVyIGZpbGVzLi4uIHll
czxicj5jaGVja2luZyBmb3Igc3lzL3R5cGVzLmguLi4geWVzPGJyPmNoZWNraW5nIGZvciBzeXMv
c3RhdC5oLi4uIHllczxicj5jaGVja2luZyBmb3Igc3RkbGliLmguLi4geWVzPGJyPmNoZWNraW5n
IGZvciBzdHJpbmcuaC4uLiB5ZXM8YnI+Y2hlY2tpbmcgZm9yIG1lbW9yeS5oLi4uIHllczxicj5j
aGVja2luZyBmb3Igc3RyaW5ncy5oLi4uIHllczxicj4KY2hlY2tpbmcgZm9yIGludHR5cGVzLmgu
Li4geWVzPGJyPmNoZWNraW5nIGZvciBzdGRpbnQuaC4uLiB5ZXM8YnI+Y2hlY2tpbmcgZm9yIHVu
aXN0ZC5oLi4uIHllczxicj5jaGVja2luZyBkbGZjbi5oIHVzYWJpbGl0eS4uLiB5ZXM8YnI+Y2hl
Y2tpbmcgZGxmY24uaCBwcmVzZW5jZS4uLiB5ZXM8YnI+Y2hlY2tpbmcgZm9yIGRsZmNuLmguLi4g
eWVzPGJyPmNoZWNraW5nIHRoZSBtYXhpbXVtIGxlbmd0aCBvZiBjb21tYW5kIGxpbmUgYXJndW1l
bnRzLi4uIDk4MzA0PGJyPgpjaGVja2luZyBjb21tYW5kIHRvIHBhcnNlIC9zY3JhdGNoYm94L2Nv
bXBpbGVycy9iaW4vbm0gLUIgb3V0cHV0IGZyb20gZ2NjIG9iamVjdC4uLiBmYWlsZWQ8YnI+Y2hl
Y2tpbmcgZm9yIG9iamRpci4uLiAubGliczxicj5jaGVja2luZyBmb3IgYXIuLi4gYXI8YnI+Y2hl
Y2tpbmcgZm9yIHJhbmxpYi4uLiByYW5saWI8YnI+Y2hlY2tpbmcgZm9yIHN0cmlwLi4uIHN0cmlw
PGJyPmNoZWNraW5nIGlmIGdjYyBzdXBwb3J0cyAtZm5vLXJ0dGkgLWZuby1leGNlcHRpb25zLi4u
IG5vPGJyPgpjaGVja2luZyBmb3IgZ2NjIG9wdGlvbiB0byBwcm9kdWNlIFBJQy4uLiAtZlBJQzxi
cj5jaGVja2luZyBpZiBnY2MgUElDIGZsYWcgLWZQSUMgd29ya3MuLi4geWVzPGJyPmNoZWNraW5n
IGlmIGdjYyBzdGF0aWMgZmxhZyAtc3RhdGljIHdvcmtzLi4uIHllczxicj5jaGVja2luZyBpZiBn
Y2Mgc3VwcG9ydHMgLWMgLW8gZmlsZS5vLi4uIHllczxicj5jaGVja2luZyB3aGV0aGVyIHRoZSBn
Y2MgbGlua2VyICgvc2NyYXRjaGJveC9jb21waWxlcnMvY3MyMDA3cTMtZ2xpYmMyLjUtaTQ4Ni9p
NDg2LXBjLWxpbnV4LWdudS9iaW4vbGQpIHN1cHBvcnRzIHNoYXJlZCBsaWJyYXJpZXMuLi4geWVz
PGJyPgpjaGVja2luZyB3aGV0aGVyIC1sYyBzaG91bGQgYmUgZXhwbGljaXRseSBsaW5rZWQgaW4u
Li4gbm88YnI+Y2hlY2tpbmcgZHluYW1pYyBsaW5rZXIgY2hhcmFjdGVyaXN0aWNzLi4uIEdOVS9M
aW51eCBsZC5zbzxicj5jaGVja2luZyBob3cgdG8gaGFyZGNvZGUgbGlicmFyeSBwYXRocyBpbnRv
IHByb2dyYW1zLi4uIGltbWVkaWF0ZTxicj5jaGVja2luZyB3aGV0aGVyIHN0cmlwcGluZyBsaWJy
YXJpZXMgaXMgcG9zc2libGUuLi4geWVzPGJyPgpjaGVja2luZyBpZiBsaWJ0b29sIHN1cHBvcnRz
IHNoYXJlZCBsaWJyYXJpZXMuLi4geWVzPGJyPmNoZWNraW5nIHdoZXRoZXIgdG8gYnVpbGQgc2hh
cmVkIGxpYnJhcmllcy4uLiB5ZXM8YnI+Y2hlY2tpbmcgd2hldGhlciB0byBidWlsZCBzdGF0aWMg
bGlicmFyaWVzLi4uIG5vPGJyPmNvbmZpZ3VyZTogY3JlYXRpbmcgbGlidG9vbDxicj5jaGVja2lu
ZyBmb3IgQlNELWNvbXBhdGlibGUgbm0uLi4gKGNhY2hlZCkgL3NjcmF0Y2hib3gvY29tcGlsZXJz
L2Jpbi9ubSAtQjxicj4KY2hlY2tpbmcgZm9yIHNpZ25hbGZkIGluIC1sYy4uLiB5ZXM8YnI+Y2hl
Y2tpbmcgZm9yIGRsb3BlbiBpbiAtbGRsLi4uIHllczxicj5jaGVja2luZyBmb3IgR0xJQi4uLiB5
ZXM8YnI+Y2hlY2tpbmcgZm9yIERCVVMuLi4geWVzPGJyPmNoZWNraW5nIGZvciBkYnVzX3dhdGNo
X2dldF91bml4X2ZkIGluIC1sZGJ1cy0xLi4uIHllczxicj5jaGVja2luZyBmb3IgZGJ1c19jb25u
ZWN0aW9uX2Nhbl9zZW5kX3R5cGUgaW4gLWxkYnVzLTEuLi4gbm88YnI+CmNoZWNraW5nIGZvciBV
REVWLi4uIHllczxicj5jaGVja2luZyBmb3IgQ0FQTkcuLi4geWVzPGJyPmNvbmZpZ3VyZTogY3Jl
YXRpbmcgLi9jb25maWcuc3RhdHVzPGJyPmNvbmZpZy5zdGF0dXM6IGNyZWF0aW5nIE1ha2VmaWxl
PGJyPmNvbmZpZy5zdGF0dXM6IGNyZWF0aW5nIGluY2x1ZGUvdmVyc2lvbi5oPGJyPmNvbmZpZy5z
dGF0dXM6IGNyZWF0aW5nIGNvbmZpZy5oPGJyPmNvbmZpZy5zdGF0dXM6IGV4ZWN1dGluZyBkZXBm
aWxlcyBjb21tYW5kczxicj4KLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLTxicj48YnI+PGJyPkJ1dCB3aGlsZSBydW5uaW5n
IG1ha2UsIGkgZ2V0IHRoZSBmb2xsb3dpbmcgZXJyb3IuIDxicj48YnI+W3Nib3gtRlJFTUFOVExF
X1g4Njogfi9vZm9ub10gJmd0OyBtYWtlPGJyPm1ha2UgLS1uby1wcmludC1kaXJlY3RvcnkgYWxs
LWFtPGJyPmluY2x1ZGUvb2Zvbm88YnI+Cm1ha2VbMV06IGluY2x1ZGUvb2Zvbm86IENvbW1hbmQg
bm90IGZvdW5kPGJyPm1ha2VbMV06ICoqKiBbaW5jbHVkZS9vZm9uby9sb2cuaF0gRXJyb3IgMTI3
PGJyPm1ha2U6ICoqKiBbYWxsXSBFcnJvciAyPGJyPi0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS08YnI+PGJy
PldoYXQgY291bGQgYmUgdGhlIHJlYXNvbj8gQ291bGQgYW55b25lIGhlbHA/PGJyPgo8YnI+UmVn
YXJkczxicj5BcnVuPGJyPjxicj48YnI+Cg==

--===============1245490120895889315==--

