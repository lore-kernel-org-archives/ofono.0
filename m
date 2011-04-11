Content-Type: multipart/mixed; boundary="===============4961448793203058867=="
MIME-Version: 1.0
From: Vijay Nayani <vijay.nayani@elektrobit.com>
Subject: [RFC PATCH 02/20] build: add generalised packet headers
Date: Mon, 11 Apr 2011 13:20:00 +0300
Message-ID: <1302517218-2147-3-git-send-email-vijay.nayani@elektrobit.com>
In-Reply-To: <1302517218-2147-1-git-send-email-vijay.nayani@elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4961448793203058867==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 Makefile.am |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/Makefile.am b/Makefile.am
index 2886b5d..ac65d4d 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -10,13 +10,14 @@ pkginclude_HEADERS =3D include/log.h include/plugin.h i=
nclude/history.h \
 			include/netreg.h include/voicecall.h include/devinfo.h \
 			include/cbs.h include/call-volume.h \
 			include/gprs.h include/gprs-context.h \
+			include/packet-service.h include/packet-context.h \
 			include/radio-settings.h include/stk.h \
 			include/audio-settings.h include/nettime.h \
 			include/ctm.h include/cdma-voicecall.h \
 			include/cdma-sms.h include/sim-auth.h \
 			include/gprs-provision.h include/emulator.h \
 			include/location-reporting.h \
-			include/cdma-connman.h \
+			include/cdma-connman.h  include/ps-provision.h \
 			include/gnss.h
 =

 nodist_pkginclude_HEADERS =3D include/version.h
-- =

1.7.0.4


--===============4961448793203058867==--

