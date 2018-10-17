Content-Type: multipart/mixed; boundary="===============8061729810431857521=="
MIME-Version: 1.0
From: Jonas Bonn <jonas@norrbonn.se>
Subject: [PATCH 1/2] build: Install DBus policy in /usr/share/dbus-1/system.d
Date: Wed, 17 Oct 2018 15:52:24 +0200
Message-ID: <20181017135225.26573-2-jonas@norrbonn.se>
In-Reply-To: <20181017135225.26573-1-jonas@norrbonn.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8061729810431857521==
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
index 5a8fb6f5..5680d65b 100644
--- a/configure.ac
+++ b/configure.ac
@@ -72,9 +72,9 @@ AC_SUBST(DBUS_LIBS)
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

2.17.1


--===============8061729810431857521==--

