Content-Type: multipart/mixed; boundary="===============9098050221470550364=="
MIME-Version: 1.0
From: Marko Saukko <marko.saukko@gmail.com>
Subject: [PATCH] bluez version 4.99 is required.
Date: Mon, 14 May 2012 22:52:57 +0300
Message-ID: <1337025177-16039-1-git-send-email-marko.saukko@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============9098050221470550364==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

bluez 4.99 introduced key_size to bt_security struct that is used in
ofono, thus the requirement needs to be higher.

Signed-off-by: Marko Saukko <marko.saukko@gmail.com>
---
 configure.ac |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/configure.ac b/configure.ac
index 251a726..9f77a3c 100644
--- a/configure.ac
+++ b/configure.ac
@@ -177,8 +177,8 @@ AC_ARG_ENABLE(bluetooth, AC_HELP_STRING([--disable-blue=
tooth],
 				[disable Bluetooth modem support]),
 					[enable_bluetooth=3D${enableval}])
 if (test "${enable_bluetooth}" !=3D "no"); then
-	PKG_CHECK_MODULES(BLUEZ, bluez >=3D 4.30, dummy=3Dyes,
-			AC_MSG_ERROR(Bluetooth library >=3D 4.30 is required))
+	PKG_CHECK_MODULES(BLUEZ, bluez >=3D 4.99, dummy=3Dyes,
+			AC_MSG_ERROR(Bluetooth library >=3D 4.99 is required))
 fi
 AC_SUBST(BLUEZ_CFLAGS)
 AC_SUBST(BLUEZ_LIBS)
-- =

1.7.7


--===============9098050221470550364==--

