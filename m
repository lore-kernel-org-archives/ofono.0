Content-Type: multipart/mixed; boundary="===============6387700005039701135=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH] configure: Check for bluez >= 4.30.
Date: Tue, 15 Feb 2011 09:55:51 +0100
Message-ID: <1297760152-19815-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6387700005039701135==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Earlier versions lack struct sockaddr_l2::l2_cid and/or
struct bt_security.
---
 configure.ac |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/configure.ac b/configure.ac
index 4f0348d..810b9f2 100644
--- a/configure.ac
+++ b/configure.ac
@@ -184,8 +184,8 @@ AC_ARG_ENABLE(bluetooth, AC_HELP_STRING([--disable-blue=
tooth],
 				[disable Bluetooth modem support]),
 					[enable_bluetooth=3D${enableval}])
 if (test "${enable_bluetooth}" !=3D "no"); then
-	PKG_CHECK_MODULES(BLUEZ, bluez, dummy=3Dyes,
-				AC_MSG_ERROR(Bluetooth library is required))
+	PKG_CHECK_MODULES(BLUEZ, bluez >=3D 4.30, dummy=3Dyes,
+			AC_MSG_ERROR(Bluez >=3D 4.30 is required without --disable-bluetooth))
 fi
 AC_SUBST(BLUEZ_CFLAGS)
 AC_SUBST(BLUEZ_LIBS)
-- =

1.7.1.86.g0e460.dirty


--===============6387700005039701135==--

