Content-Type: multipart/mixed; boundary="===============4850656814841622836=="
MIME-Version: 1.0
From: joey@joeyhewitt.com
Subject: [PATCH] build: require dbus >= 1.6
Date: Wed, 04 Mar 2020 07:16:24 +0000
Message-ID: <20200304071624.2640.47136@ml01.vlan13.01.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4850656814841622836==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

dbus_validate_path() is used several times. dbus's NEWS says it was
added in 1.5.12.
---
 configure.ac | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/configure.ac b/configure.ac
index b17bfb5e..3655a112 100644
--- a/configure.ac
+++ b/configure.ac
@@ -67,8 +67,8 @@ PKG_CHECK_MODULES(GLIB, glib-2.0 >=3D 2.32, dummy=3Dyes,
 AC_SUBST(GLIB_CFLAGS)
 AC_SUBST(GLIB_LIBS)
 =

-PKG_CHECK_MODULES(DBUS, dbus-1 >=3D 1.4, dummy=3Dyes,
-				AC_MSG_ERROR(D-Bus >=3D 1.4 is required))
+PKG_CHECK_MODULES(DBUS, dbus-1 >=3D 1.6, dummy=3Dyes,
+				AC_MSG_ERROR(D-Bus >=3D 1.6 is required))
 AC_SUBST(DBUS_CFLAGS)
 AC_SUBST(DBUS_LIBS)
 =

-- =

2.17.1
--===============4850656814841622836==--

