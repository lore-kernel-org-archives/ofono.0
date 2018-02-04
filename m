Content-Type: multipart/mixed; boundary="===============4374141268261378097=="
MIME-Version: 1.0
From: Jonas Bonn <jonas@southpole.se>
Subject: [PATCH 1/4] build: Install DBus policy in /usr/share/dbus-1/system.d
Date: Sun, 04 Feb 2018 23:55:47 +0100
Message-ID: <20180204225550.10977-1-jonas@southpole.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4374141268261378097==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The default location for DBus policy files should be
/usr/share/dbus-1/system.d and the corresponding directory under /etc
should be reserved for administrative changes to default/packaged
settings.  This removes a dependency of ofono on a populated /etc.
---
 configure.ac | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/configure.ac b/configure.ac
index f3148a40..79436adc 100644
--- a/configure.ac
+++ b/configure.ac
@@ -83,9 +83,9 @@ AC_SUBST(DBUS_LIBS)
 =

 AC_ARG_WITH(dbusconfdir, AC_HELP_STRING([--with-dbusconfdir=3DPATH],
 	[path to D-Bus config directory]), [path_dbusconf=3D${withval}],
-		[path_dbusconf=3D"`$PKG_CONFIG --variable=3Dsysconfdir dbus-1`"])
+		[path_dbusconf=3D"`$PKG_CONFIG --variable=3Ddatadir dbus-1`"])
 if (test -z "${path_dbusconf}"); then
-	DBUS_CONFDIR=3D"${sysconfdir}/dbus-1/system.d"
+	DBUS_CONFDIR=3D"${datadir}/dbus-1/system.d"
 else
 	DBUS_CONFDIR=3D"${path_dbusconf}/dbus-1/system.d"
 fi
-- =

2.14.1


--===============4374141268261378097==--

