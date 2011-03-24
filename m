Content-Type: multipart/mixed; boundary="===============1681194483172968694=="
MIME-Version: 1.0
From: Aki Niemi <aki.niemi@nokia.com>
Subject: [PATCH] build: Add gatchat to core sources
Date: Thu, 24 Mar 2011 17:36:19 +0200
Message-ID: <1300980979-5892-1-git-send-email-aki.niemi@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1681194483172968694==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Otherwise, --disable-atmodem breaks build.
---
 Makefile.am |    9 ++++-----
 1 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/Makefile.am b/Makefile.am
index b0cbcd7..39d8962 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -154,8 +154,7 @@ endif
 =

 if ATMODEM
 builtin_modules +=3D atmodem
-builtin_sources +=3D $(gatchat_sources) \
-				drivers/atmodem/atmodem.h \
+builtin_sources +=3D drivers/atmodem/atmodem.h \
 				drivers/atmodem/atmodem.c \
 				drivers/atmodem/call-settings.c \
 				drivers/atmodem/sms.c \
@@ -365,9 +364,9 @@ builtin_sources +=3D plugins/push-notification.c
 =

 sbin_PROGRAMS =3D src/ofonod
 =

-src_ofonod_SOURCES =3D $(gdbus_sources) $(builtin_sources) src/ofono.ver \
-			src/main.c src/ofono.h src/log.c src/plugin.c \
-			src/modem.c src/common.h src/common.c \
+src_ofonod_SOURCES =3D $(gdbus_sources) $(builtin_sources) $(gatchat_sourc=
es) \
+			src/ofono.ver src/main.c src/ofono.h src/log.c \
+			src/plugin.c src/modem.c src/common.h src/common.c \
 			src/manager.c src/dbus.c src/util.h src/util.c \
 			src/network.c src/voicecall.c src/ussd.c src/sms.c \
 			src/call-settings.c src/call-forwarding.c \
-- =

1.7.1


--===============1681194483172968694==--

