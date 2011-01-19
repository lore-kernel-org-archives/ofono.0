Content-Type: multipart/mixed; boundary="===============4720691184197364114=="
MIME-Version: 1.0
From: =?unknown-8bit?q?R=C3=A9mi?= Denis-Courmont <remi.denis-courmont@nokia.com>
Subject: [PATCH 1/2] Use standard pkginclude directory
Date: Wed, 19 Jan 2011 12:30:56 +0200
Message-ID: <1295433056-26470-1-git-send-email-remi.denis-courmont@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4720691184197364114==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

automake automatically defines includedir to the base include directory
and pkgincludedir to ./@PACKAGE@ from there. So lets use the later one
instead of overriding automake.
---
 Makefile.am |    9 ++++-----
 1 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/Makefile.am b/Makefile.am
index da59be7..c1c34ca 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -1,9 +1,7 @@
 =

 AM_MAKEFLAGS =3D --no-print-directory
 =

-includedir =3D @includedir@/ofono
-
-include_HEADERS =3D include/log.h include/plugin.h include/history.h \
+pkginclude_HEADERS =3D include/log.h include/plugin.h include/history.h \
 			include/dbus.h include/modem.h include/types.h \
 			include/call-barring.h include/call-forwarding.h \
 			include/call-meter.h include/call-settings.h \
@@ -17,9 +15,10 @@ include_HEADERS =3D include/log.h include/plugin.h inclu=
de/history.h \
 			include/ctm.h include/cdma-voicecall.h \
 			include/cdma-sms.h
 =

-nodist_include_HEADERS =3D include/version.h
+nodist_pkginclude_HEADERS =3D include/version.h
 =

-local_headers =3D $(foreach file,$(include_HEADERS) $(nodist_include_HEADE=
RS), \
+local_headers =3D $(foreach file,$(pkginclude_HEADERS) \
+				$(nodist_pkginclude_HEADERS), \
 					include/ofono/$(notdir $(file)))
 =

 =

-- =

1.7.1


--===============4720691184197364114==--

