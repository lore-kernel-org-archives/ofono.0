Content-Type: multipart/mixed; boundary="===============9156886145975003635=="
MIME-Version: 1.0
From: Yuvaraj Ragupathi <yuvaraj.addu@gmail.com>
Subject: Ofono cross compiling for ARM
Date: Wed, 04 May 2011 14:37:10 +0530
Message-ID: <BANLkTink6D45Lz6iAEmOnoeMtJu2bMkZ_Q@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============9156886145975003635==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Guys,


I want to cross compile the ofono for ARM target.

So i executed configure file with following arguments


#./configure --host=3Darm
--libdir=3D/usr/lib/madde/linux-i686/sysroots/meego-core-armv7l-madde-sysro=
ot-1.1.2-fs/usr/lib
--prefix=3D/home/$myname/Desktop/ofono_For_ARM/binaries
--includedir=3D/usr/lib/madde/linux-i686/sysroots/meego-core-armv7l-madde-s=
ysroot-1.1.2-fs/usr/include


It is giving config related error message

configure: error: signalfd support is required


What it does mean?

To cross compile the ofono for ARM. What are the dependencies are required



Thanks

Addu T.R

--===============9156886145975003635==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

SGkgR3V5cyw8YnI+PGJyPjxicj5JIHdhbnQgdG8gY3Jvc3MgY29tcGlsZSB0aGUgb2Zvbm8gZm9y
IEFSTSB0YXJnZXQuPGJyPjxicj5TbyBpIGV4ZWN1dGVkIGNvbmZpZ3VyZSBmaWxlIHdpdGggZm9s
bG93aW5nIGFyZ3VtZW50czxicj48YnI+PGJyPiMuL2NvbmZpZ3VyZSAtLWhvc3Q9YXJtIC0tbGli
ZGlyPS91c3IvbGliL21hZGRlL2xpbnV4LWk2ODYvc3lzcm9vdHMvbWVlZ28tY29yZS1hcm12N2wt
bWFkZGUtc3lzcm9vdC0xLjEuMi1mcy91c3IvbGliIC0tcHJlZml4PS9ob21lLyRteW5hbWUvRGVz
a3RvcC9vZm9ub19Gb3JfQVJNL2JpbmFyaWVzoCAtLWluY2x1ZGVkaXI9L3Vzci9saWIvbWFkZGUv
bGludXgtaTY4Ni9zeXNyb290cy9tZWVnby1jb3JlLWFybXY3bC1tYWRkZS1zeXNyb290LTEuMS4y
LWZzL3Vzci9pbmNsdWRlPGJyPgo8YnI+PGJyPkl0IGlzIGdpdmluZyBjb25maWcgcmVsYXRlZCBl
cnJvciBtZXNzYWdlIDxicj48YnI+PHNwYW4gc3R5bGU9ImNvbG9yOiByZ2IoMjU1LCAwLCAwKTsi
PmNvbmZpZ3VyZTogZXJyb3I6IHNpZ25hbGZkIHN1cHBvcnQgaXMgcmVxdWlyZWQ8L3NwYW4+PGJy
Pjxicj48YnI+V2hhdCBpdCBkb2VzIG1lYW4/IDxicj48YnI+VG8gY3Jvc3MgY29tcGlsZSB0aGUg
b2Zvbm8gZm9yIEFSTS4gV2hhdCBhcmUgdGhlIGRlcGVuZGVuY2llcyBhcmUgcmVxdWlyZWQ8YnI+
Cjxicj48YnI+PGJyPlRoYW5rczxicj48YnI+QWRkdSBULlI8YnI+PGJyPgo=

--===============9156886145975003635==--

