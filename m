Content-Type: multipart/mixed; boundary="===============5872466983793634582=="
MIME-Version: 1.0
From: Philippe Nunes <philippe.nunes@linux.intel.com>
Subject: [PATCH 4/6] build: Add error-mapping utility to build
Date: Tue, 29 May 2012 18:38:35 +0200
Message-ID: <1338309517-14808-5-git-send-email-philippe.nunes@linux.intel.com>
In-Reply-To: <1338309517-14808-1-git-send-email-philippe.nunes@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5872466983793634582==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 Makefile.am |    1 +
 1 file changed, 1 insertion(+)

diff --git a/Makefile.am b/Makefile.am
index 19844d9..e1051a2 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -445,6 +445,7 @@ src_ofonod_SOURCES =3D $(gdbus_sources) $(builtin_sourc=
es) src/ofono.ver \
 			src/modem.c src/common.h src/common.c \
 			src/manager.c src/dbus.c src/util.h src/util.c \
 			src/network.c src/voicecall.c src/ussd.c src/sms.c \
+			src/error-mapping.h src/error-mapping.c \
 			src/call-settings.c src/call-forwarding.c \
 			src/call-meter.c src/smsutil.h src/smsutil.c \
 			src/call-barring.c src/sim.c src/stk.c \
-- =

1.7.9.5


--===============5872466983793634582==--

