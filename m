Content-Type: multipart/mixed; boundary="===============6515203572405454906=="
MIME-Version: 1.0
From: Arun Ravindran <arunlee@gmail.com>
Subject: Ofono 0.20 compilation failed.
Date: Fri, 21 May 2010 17:04:31 +0300
Message-ID: <AANLkTincL_xVyyAMyfedgO2kag5Ifh5kAOJtfE9kasFE@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6515203572405454906==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi All,

I am trying to compile and install ofono to my unbuntu 9.10.
I get the following error...

root(a)arun-laptop:/home/arun/ofono-0.20# ./configure --prefix=3D/usr
--mandir=3D/usr/share/man --sysconfdir=3D/etc --localstatedir=3D/var

...........................................................................=
........
...........................................................................=
........
...........................................................................=
........
checking whether to build shared libraries... yes
checking whether to build static libraries... no
checking for BSD- or MS-compatible name lister (nm)... (cached) /usr/bin/nm
-B
checking the name lister (/usr/bin/nm -B) interface... (cached) BSD nm
checking for signalfd in -lc... yes
checking for dlopen in -ldl... yes
checking for GLIB... yes
checking for DBUS... no
configure: error: D-Bus >=3D 1.0 is required
---------------------------------------------------------------------------=
--------------------------------

i checked the dbus version
...........................................................................=
..............................
root(a)arun-laptop:/home/arun/ofono-0.20# dbus-daemon --version
D-Bus Message Bus Daemon 1.2.16
Copyright (C) 2002, 2003 Red Hat, Inc., CodeFactory AB, and others
This is free software; see the source for copying conditions.
There is NO warranty; not even for MERCHANTABILITY or FITNESS FOR A
PARTICULAR PURPOSE.

Could any help me?

Regards
Arun

--===============6515203572405454906==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

SGkgQWxsLDxicj48YnI+SSBhbSB0cnlpbmcgdG8gY29tcGlsZSBhbmQgaW5zdGFsbCBvZm9ubyB0
byBteSB1bmJ1bnR1IDkuMTAuIDxicj5JIGdldCB0aGUgZm9sbG93aW5nIGVycm9yLi4uPGJyPjxi
cj5yb290QGFydW4tbGFwdG9wOi9ob21lL2FydW4vb2Zvbm8tMC4yMCMgLi9jb25maWd1cmUgLS1w
cmVmaXg9L3VzciAtLW1hbmRpcj0vdXNyL3NoYXJlL21hbiAtLXN5c2NvbmZkaXI9L2V0YyAtLWxv
Y2Fsc3RhdGVkaXI9L3Zhcjxicj4KPGJyPi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4u
Li4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uPGJyPi4u
Li4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4u
Li4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uPGJyPi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4u
Li4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uPGJy
PgpjaGVja2luZyB3aGV0aGVyIHRvIGJ1aWxkIHNoYXJlZCBsaWJyYXJpZXMuLi4geWVzPGJyPmNo
ZWNraW5nIHdoZXRoZXIgdG8gYnVpbGQgc3RhdGljIGxpYnJhcmllcy4uLiBubzxicj5jaGVja2lu
ZyBmb3IgQlNELSBvciBNUy1jb21wYXRpYmxlIG5hbWUgbGlzdGVyIChubSkuLi4gKGNhY2hlZCkg
L3Vzci9iaW4vbm0gLUI8YnI+Y2hlY2tpbmcgdGhlIG5hbWUgbGlzdGVyICgvdXNyL2Jpbi9ubSAt
QikgaW50ZXJmYWNlLi4uIChjYWNoZWQpIEJTRCBubTxicj4KY2hlY2tpbmcgZm9yIHNpZ25hbGZk
IGluIC1sYy4uLiB5ZXM8YnI+Y2hlY2tpbmcgZm9yIGRsb3BlbiBpbiAtbGRsLi4uIHllczxicj5j
aGVja2luZyBmb3IgR0xJQi4uLiB5ZXM8YnI+Y2hlY2tpbmcgZm9yIERCVVMuLi4gbm88YnI+Y29u
ZmlndXJlOiBlcnJvcjogRC1CdXMgJmd0Oz0gMS4wIGlzIHJlcXVpcmVkPGJyPi0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tPGJyPgo8YnI+aSBjaGVja2Vk
IHRoZSBkYnVzIHZlcnNpb248YnI+Li4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4u
Li4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4u
Li4uLi4uLi4uLi4uPGJyPnJvb3RAYXJ1bi1sYXB0b3A6L2hvbWUvYXJ1bi9vZm9uby0wLjIwIyBk
YnVzLWRhZW1vbiAtLXZlcnNpb248YnI+RC1CdXMgTWVzc2FnZSBCdXMgRGFlbW9uIDEuMi4xNjxi
cj4KQ29weXJpZ2h0IChDKSAyMDAyLCAyMDAzIFJlZCBIYXQsIEluYy4sIENvZGVGYWN0b3J5IEFC
LCBhbmQgb3RoZXJzPGJyPlRoaXMgaXMgZnJlZSBzb2Z0d2FyZTsgc2VlIHRoZSBzb3VyY2UgZm9y
IGNvcHlpbmcgY29uZGl0aW9ucy48YnI+VGhlcmUgaXMgTk8gd2FycmFudHk7IG5vdCBldmVuIGZv
ciBNRVJDSEFOVEFCSUxJVFkgb3IgRklUTkVTUyBGT1IgQSBQQVJUSUNVTEFSIFBVUlBPU0UuPGJy
Pgo8YnI+Q291bGQgYW55IGhlbHAgbWU/PGJyPjxicj5SZWdhcmRzPGJyPkFydW48YnI+PGJyPgo=

--===============6515203572405454906==--

