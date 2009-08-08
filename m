Content-Type: multipart/mixed; boundary="===============5548419373022212597=="
MIME-Version: 1.0
From: Andres Salomon <dilinger@collabora.co.uk>
Subject: [PATCH] fix build error in latest git (unsigned/signed comparison)
Date: Sat, 08 Aug 2009 19:57:58 -0400
Message-ID: <20090808195758.411a002c@mycelium.queued.net>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5548419373022212597==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From 67e49b800a14363c93eeab362e202e68362b7775 Mon Sep 17 00:00:00 2001
From: Andres Salomon <dilinger@collabora.co.uk>
Date: Sat, 8 Aug 2009 19:54:35 -0400
Subject: [PATCH] Fix signed/unsigned comparison build error
MIME-Version: 1.0
Content-Type: text/plain; charset=3Dutf-8
Content-Transfer-Encoding: 8bit

Latest git has the following issue when building:

cc -DHAVE_CONFIG_H -I. -I.. -I../include -I..   -I/usr/include/glib-2.0 -I/=
usr/lib/glib-2.0/include   -I/usr/include/dbus-1.0 -I/usr/lib/dbus-1.0/incl=
ude   -I../gdbus -I../gatchat -I.. -DPLUGINDIR=3D\""/home/dilinger/ofono/pl=
ugins/.libs"\" -g -O2 -g -Werror -Wextra -Wno-unused-parameter -Wno-missing=
-field-initializers -Wdeclaration-after-statement -Wmissing-declarations -W=
redundant-decls -Wcast-align -MT sim.o -MD -MP -MF .deps/sim.Tpo -c -o sim.=
o sim.c
cc1: warnings being treated as errors
sim.c: In function =E2=80=98sim_op_check_cached=E2=80=99:
sim.c:795: error: comparison between signed and unsigned

The code in question is:
        if (TFR(read(fd, buffer, file_length)) < file_length)

The fix for this is to simply cast the result to unsigned after ensuring
that it's not negative.
---
 src/sim.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/src/sim.c b/src/sim.c
index 1271ded..2c3b41b 100644
--- a/src/sim.c
+++ b/src/sim.c
@@ -792,7 +792,8 @@ static gboolean sim_op_check_cached(struct ofono_modem =
*modem)
 =

 	buffer =3D g_malloc(file_length);
 =

-	if (TFR(read(fd, buffer, file_length)) < file_length)
+	len =3D TFR(read(fd, buffer, file_length));
+	if (len < 0 || ((unsigned int) len < file_length))
 		goto cleanup;
 =

 	for (record =3D 0; record < file_length / record_length; record++) {
-- =

1.6.3.3


--===============5548419373022212597==--

