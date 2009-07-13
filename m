Content-Type: multipart/mixed; boundary="===============5551787907508982835=="
MIME-Version: 1.0
From: Marko Saukko <marko.saukko@gmail.com>
Subject: Compiler errors.
Date: Mon, 13 Jul 2009 08:46:52 +0300
Message-ID: <4A5ACA4C.2000802@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5551787907508982835==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

with the latest oFono git version I'm getting the following compiler
errors when using gcc (Ubuntu 4.3.3-5ubuntu4) 4.3.3.

----

gcc -DHAVE_CONFIG_H -I. -I.. -I../include -I../src
-I/usr/include/glib-2.0 -I/usr/lib/glib-2.0/include   -g -O2 -Werror
-Wextra -Wno-unused-parameter -Wno-missing-field-initializers
-Wdeclaration-after-statement -Wmissing-declarations -Wredundant-decls
-Wcast-align -MT smsutil.o -MD -MP -MF .deps/smsutil.Tpo -c -o smsutil.o
`test -f '../src/smsutil.c' || echo './'`../src/smsutil.c
cc1: warnings being treated as errors
../src/smsutil.c: In function =E2=80=98sms_extract_common=E2=80=99:
../src/smsutil.c:1442: error: =E2=80=98dcs=E2=80=99 may be used uninitializ=
ed in this
function
../src/smsutil.c:1441: error: =E2=80=98udhi=E2=80=99 may be used uninitiali=
zed in this
function
../src/smsutil.c:1440: error: =E2=80=98max=E2=80=99 may be used uninitializ=
ed in this
function
../src/smsutil.c:1439: error: =E2=80=98udl=E2=80=99 may be used uninitializ=
ed in this
function
../src/smsutil.c: In function =E2=80=98extract_app_port_common=E2=80=99:
../src/smsutil.c:1756: error: =E2=80=98is_addr_8bit=E2=80=99 may be used un=
initialized
in this function
../src/smsutil.c: In function =E2=80=98sms_extract_concatenation=E2=80=99:
../src/smsutil.c:1843: error: =E2=80=98seq=E2=80=99 may be used uninitializ=
ed in this
function
../src/smsutil.c:1843: error: =E2=80=98max=E2=80=99 may be used uninitializ=
ed in this
function
../src/smsutil.c:1842: error: =E2=80=98rn=E2=80=99 may be used uninitialize=
d in this
function
../src/smsutil.c: In function =E2=80=98cbs_decode_text=E2=80=99:
../src/smsutil.c:2706: error: =E2=80=98iso639=E2=80=99 may be used uninitia=
lized in this
function
../src/smsutil.c:2704: error: =E2=80=98charset=E2=80=99 may be used uniniti=
alized in
this function
make[2]: *** [smsutil.o] Error 1
make[2]: Leaving directory `/home/muk/software/ofono/ofono/unit'

----

Regards,
Marko

--===============5551787907508982835==--

