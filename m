Content-Type: multipart/mixed; boundary="===============7199932139830548232=="
MIME-Version: 1.0
From: Shane Bryan <shane.bryan@linux.intel.com>
Subject: Re: [PATCH] Add dbus .service file to auto start ofonod
Date: Tue, 26 May 2009 14:58:30 -0700
Message-ID: <20090526145830.5edb497e@cyclone>
In-Reply-To: <1243078511.13042.1.camel@localhost.localdomain>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7199932139830548232==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Sat, 23 May 2009 13:35:11 +0200
marcel at holtmann.org (Marcel Holtmann) wrote:

> actually it would be better if we just do ofono.service.in (drop the
> org in front of it) and then let autoconf fixup the actually
> configured prefix.
> =


Ok, new patch attached, this time taking ofono.service.in and
generating org.ofono.service by autoconf/automake rules that define
the .service file name as well as the "Name" and "Exec" values in the
generated file =


Shane...

From ce040278b6f2f58a97f69e0c67e4339f0e67f398 Mon Sep 17 00:00:00 2001
From: Shane Bryan <shane.bryan@linux.intel.com>
Date: Tue, 26 May 2009 14:22:41 -0700
Subject: [PATCH] Install auto generated dbus system-service file

Signed-off-by: Shane Bryan <shane.bryan@linux.intel.com>
---
 configure.ac         |    9 +++++++++
 src/Makefile.am      |   16 ++++++++++++++--
 src/ofono.service.in |    4 ++++
 3 files changed, 27 insertions(+), 2 deletions(-)
 create mode 100644 src/ofono.service.in

diff --git a/configure.ac b/configure.ac
index 36fec5f..023f2ab 100644
--- a/configure.ac
+++ b/configure.ac
@@ -73,6 +73,15 @@ else
 fi
 AC_SUBST(DBUS_DATADIR)
 =

+DBUS_SYSTEM_SERVICEDIR=3D"${datadir}/dbus-1/system-services"
+AC_SUBST(DBUS_SYSTEM_SERVICEDIR)
+
+DBUS_SERVICE_PREFIX=3D"org"
+AC_SUBST(DBUS_SERVICE_PREFIX)
+
+DBUS_SERVICE_NAME=3D"$DBUS_SERVICE_PREFIX.$PACKAGE"
+AC_SUBST(DBUS_SERVICE_NAME)
+
 AC_SUBST([GDBUS_CFLAGS], ['$(DBUS_CFLAGS) -I$(top_srcdir)/gdbus'])
 AC_SUBST([GDBUS_LIBS], ['$(top_builddir)/gdbus/libgdbus.la $(DBUS_LIBS)'])
 =

diff --git a/src/Makefile.am b/src/Makefile.am
index 38c97bd..b6688bd 100644
--- a/src/Makefile.am
+++ b/src/Makefile.am
@@ -3,6 +3,18 @@ if DATAFILES
 dbusdir =3D @DBUS_DATADIR@
 =

 dbus_DATA =3D ofono.conf
+
+servicedir =3D @DBUS_SYSTEM_SERVICEDIR@
+service_in_files =3D ofono.service.in
+service_DATA =3D @DBUS_SERVICE_NAME(a).service
+
+$(service_DATA): $(service_in_files) Makefile
+	$(edit) $< >$@
+
+edit =3D sed \
+	-e 's|@sbindir[@]|$(sbindir)|g' \
+	-e 's|@sbin_PROGRAMS[@]|$(sbin_PROGRAMS)|g' \
+	-e 's|@DBUS_SERVICE_NAME[@]|$(DBUS_SERVICE_NAME)|g'
 endif
 =

 sbin_PROGRAMS =3D ofonod
@@ -22,7 +34,7 @@ ofonod_LDFLAGS =3D -Wl,--export-dynamic -Wl,--version-scr=
ipt=3Dofono.ver
 =

 ofonod_DEPENDENCIES =3D ofono.ver
 =

-CLEANFILES =3D ofono.ver ofono.exp
+CLEANFILES =3D ofono.ver ofono.exp $(service_DATA)
 =

 if MAINTAINER_MODE
 plugindir =3D $(abs_top_srcdir)/plugins/.libs
@@ -35,7 +47,7 @@ AM_CFLAGS =3D @GTHREAD_CFLAGS@ @GLIB_CFLAGS@ @GDBUS_CFLAG=
S@ @GATCHAT_CFLAGS@ \
 =

 INCLUDES =3D -I$(top_builddir)/include -I$(top_builddir)
 =

-EXTRA_DIST =3D ofono.conf
+EXTRA_DIST =3D $(dbus_DATA) $(service_DATA) $(service_in_files)
 =

 MAINTAINERCLEANFILES =3D Makefile.in
 =

diff --git a/src/ofono.service.in b/src/ofono.service.in
new file mode 100644
index 0000000..16c9bd6
--- /dev/null
+++ b/src/ofono.service.in
@@ -0,0 +1,4 @@
+[D-BUS Service]
+Name=3D@DBUS_SERVICE_NAME@
+Exec=3D@sbindir@/@sbin_PROGRAMS@
+User=3Droot
-- =

1.6.0.4



--===============7199932139830548232==
Content-Type: text/x-patch
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="0001-Install-auto-generated-dbus-system-service-file.patch"

PkZyb20gY2UwNDAyNzhiNmYyZjU4YTk3ZjY5ZTBjNjdlNDMzOWYwZTY3ZjM5OCBNb24gU2VwIDE3
IDAwOjAwOjAwIDIwMDEKRnJvbTogU2hhbmUgQnJ5YW4gPHNoYW5lLmJyeWFuQGxpbnV4LmludGVs
LmNvbT4KRGF0ZTogVHVlLCAyNiBNYXkgMjAwOSAxNDoyMjo0MSAtMDcwMApTdWJqZWN0OiBbUEFU
Q0hdIEluc3RhbGwgYXV0byBnZW5lcmF0ZWQgZGJ1cyBzeXN0ZW0tc2VydmljZSBmaWxlCgpTaWdu
ZWQtb2ZmLWJ5OiBTaGFuZSBCcnlhbiA8c2hhbmUuYnJ5YW5AbGludXguaW50ZWwuY29tPgotLS0K
IGNvbmZpZ3VyZS5hYyAgICAgICAgIHwgICAgOSArKysrKysrKysKIHNyYy9NYWtlZmlsZS5hbSAg
ICAgIHwgICAxNiArKysrKysrKysrKysrKy0tCiBzcmMvb2Zvbm8uc2VydmljZS5pbiB8ICAgIDQg
KysrKwogMyBmaWxlcyBjaGFuZ2VkLCAyNyBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQog
Y3JlYXRlIG1vZGUgMTAwNjQ0IHNyYy9vZm9uby5zZXJ2aWNlLmluCgpkaWZmIC0tZ2l0IGEvY29u
ZmlndXJlLmFjIGIvY29uZmlndXJlLmFjCmluZGV4IDM2ZmVjNWYuLjAyM2YyYWIgMTAwNjQ0Ci0t
LSBhL2NvbmZpZ3VyZS5hYworKysgYi9jb25maWd1cmUuYWMKQEAgLTczLDYgKzczLDE1IEBAIGVs
c2UKIGZpCiBBQ19TVUJTVChEQlVTX0RBVEFESVIpCiAKK0RCVVNfU1lTVEVNX1NFUlZJQ0VESVI9
IiR7ZGF0YWRpcn0vZGJ1cy0xL3N5c3RlbS1zZXJ2aWNlcyIKK0FDX1NVQlNUKERCVVNfU1lTVEVN
X1NFUlZJQ0VESVIpCisKK0RCVVNfU0VSVklDRV9QUkVGSVg9Im9yZyIKK0FDX1NVQlNUKERCVVNf
U0VSVklDRV9QUkVGSVgpCisKK0RCVVNfU0VSVklDRV9OQU1FPSIkREJVU19TRVJWSUNFX1BSRUZJ
WC4kUEFDS0FHRSIKK0FDX1NVQlNUKERCVVNfU0VSVklDRV9OQU1FKQorCiBBQ19TVUJTVChbR0RC
VVNfQ0ZMQUdTXSwgWyckKERCVVNfQ0ZMQUdTKSAtSSQodG9wX3NyY2RpcikvZ2RidXMnXSkKIEFD
X1NVQlNUKFtHREJVU19MSUJTXSwgWyckKHRvcF9idWlsZGRpcikvZ2RidXMvbGliZ2RidXMubGEg
JChEQlVTX0xJQlMpJ10pCiAKZGlmZiAtLWdpdCBhL3NyYy9NYWtlZmlsZS5hbSBiL3NyYy9NYWtl
ZmlsZS5hbQppbmRleCAzOGM5N2JkLi5iNjY4OGJkIDEwMDY0NAotLS0gYS9zcmMvTWFrZWZpbGUu
YW0KKysrIGIvc3JjL01ha2VmaWxlLmFtCkBAIC0zLDYgKzMsMTggQEAgaWYgREFUQUZJTEVTCiBk
YnVzZGlyID0gQERCVVNfREFUQURJUkAKIAogZGJ1c19EQVRBID0gb2Zvbm8uY29uZgorCitzZXJ2
aWNlZGlyID0gQERCVVNfU1lTVEVNX1NFUlZJQ0VESVJACitzZXJ2aWNlX2luX2ZpbGVzID0gb2Zv
bm8uc2VydmljZS5pbgorc2VydmljZV9EQVRBID0gQERCVVNfU0VSVklDRV9OQU1FQC5zZXJ2aWNl
CisKKyQoc2VydmljZV9EQVRBKTogJChzZXJ2aWNlX2luX2ZpbGVzKSBNYWtlZmlsZQorCSQoZWRp
dCkgJDwgPiRACisKK2VkaXQgPSBzZWQgXAorCS1lICdzfEBzYmluZGlyW0BdfCQoc2JpbmRpcil8
ZycgXAorCS1lICdzfEBzYmluX1BST0dSQU1TW0BdfCQoc2Jpbl9QUk9HUkFNUyl8ZycgXAorCS1l
ICdzfEBEQlVTX1NFUlZJQ0VfTkFNRVtAXXwkKERCVVNfU0VSVklDRV9OQU1FKXxnJwogZW5kaWYK
IAogc2Jpbl9QUk9HUkFNUyA9IG9mb25vZApAQCAtMjIsNyArMzQsNyBAQCBvZm9ub2RfTERGTEFH
UyA9IC1XbCwtLWV4cG9ydC1keW5hbWljIC1XbCwtLXZlcnNpb24tc2NyaXB0PW9mb25vLnZlcgog
CiBvZm9ub2RfREVQRU5ERU5DSUVTID0gb2Zvbm8udmVyCiAKLUNMRUFORklMRVMgPSBvZm9uby52
ZXIgb2Zvbm8uZXhwCitDTEVBTkZJTEVTID0gb2Zvbm8udmVyIG9mb25vLmV4cCAkKHNlcnZpY2Vf
REFUQSkKIAogaWYgTUFJTlRBSU5FUl9NT0RFCiBwbHVnaW5kaXIgPSAkKGFic190b3Bfc3JjZGly
KS9wbHVnaW5zLy5saWJzCkBAIC0zNSw3ICs0Nyw3IEBAIEFNX0NGTEFHUyA9IEBHVEhSRUFEX0NG
TEFHU0AgQEdMSUJfQ0ZMQUdTQCBAR0RCVVNfQ0ZMQUdTQCBAR0FUQ0hBVF9DRkxBR1NAIFwKIAog
SU5DTFVERVMgPSAtSSQodG9wX2J1aWxkZGlyKS9pbmNsdWRlIC1JJCh0b3BfYnVpbGRkaXIpCiAK
LUVYVFJBX0RJU1QgPSBvZm9uby5jb25mCitFWFRSQV9ESVNUID0gJChkYnVzX0RBVEEpICQoc2Vy
dmljZV9EQVRBKSAkKHNlcnZpY2VfaW5fZmlsZXMpCiAKIE1BSU5UQUlORVJDTEVBTkZJTEVTID0g
TWFrZWZpbGUuaW4KIApkaWZmIC0tZ2l0IGEvc3JjL29mb25vLnNlcnZpY2UuaW4gYi9zcmMvb2Zv
bm8uc2VydmljZS5pbgpuZXcgZmlsZSBtb2RlIDEwMDY0NAppbmRleCAwMDAwMDAwLi4xNmM5YmQ2
Ci0tLSAvZGV2L251bGwKKysrIGIvc3JjL29mb25vLnNlcnZpY2UuaW4KQEAgLTAsMCArMSw0IEBA
CitbRC1CVVMgU2VydmljZV0KK05hbWU9QERCVVNfU0VSVklDRV9OQU1FQAorRXhlYz1Ac2JpbmRp
ckAvQHNiaW5fUFJPR1JBTVNACitVc2VyPXJvb3QKLS0gCjEuNi4wLjQKCg==

--===============7199932139830548232==--

