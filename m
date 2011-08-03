Content-Type: multipart/mixed; boundary="===============4035186989514930196=="
MIME-Version: 1.0
From: iiro.kaihlaniemi@nokia.com
Subject: [PATCH 1/5] isimodem: Add functionality to UICC
Date: Wed, 03 Aug 2011 10:41:12 +0000
Message-ID: <6B9DA0A3415B234191A1ADFA6275C51CB240D5@008-AM1MPN1-041.mgdnok.nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4035186989514930196==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

diff --git a/Makefile.am b/Makefile.am
index cef9892..f3343a2 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -141,7 +141,8 @@ builtin_sources +=3D $(gisi_sources) \
 				drivers/isimodem/gpds.h \
 				drivers/isimodem/audio-settings.c \
 				drivers/isimodem/uicc.h \
-				drivers/isimodem/uicc.c
+				drivers/isimodem/uicc.c \
+				drivers/isimodem/uicc-util.c
 =

 =

 builtin_modules +=3D isiusb


--===============4035186989514930196==--

