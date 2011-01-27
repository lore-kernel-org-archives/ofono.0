Content-Type: multipart/mixed; boundary="===============4742652458145594499=="
MIME-Version: 1.0
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: [PATCH] build: Do not fail when systemd is not installed
Date: Thu, 27 Jan 2011 17:28:34 -0200
Message-ID: <1296156514-18685-1-git-send-email-lucas.demarchi@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4742652458145594499==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Use --with-systemdsystemunitdir instead of --enabled-systemd so it's
possible to enable systemd even if systemd is not installed.
---
 configure.ac |   18 +++++++-----------
 1 files changed, 7 insertions(+), 11 deletions(-)

diff --git a/configure.ac b/configure.ac
index b034ff0..20a1fc6 100644
--- a/configure.ac
+++ b/configure.ac
@@ -112,18 +112,14 @@ else
 fi
 AC_SUBST(DBUS_DATADIR)
 =

-AC_ARG_ENABLE(systemd, AC_HELP_STRING([--enable-systemd],
-		[enable systemd support]), [enable_systemd=3D${enableval}])
-if (test "${enable_systemd}" =3D "yes"); then
-	PKG_CHECK_MODULES(SYSTEMD, systemd, dummy=3Dyes,
-				AC_MSG_ERROR(systemd is required))
-	SYSTEMD_UNITDIR=3D"`$PKG_CONFIG --variable=3Dsystemdsystemunitdir systemd=
`"
-	if (test -z "${SYSTEM_UNITDIR}"); then
-		SYSTEMD_UNITDIR=3D"/lib/systemd/system"
-	fi
-	AC_SUBST(SYSTEMD_UNITDIR)
+AC_ARG_WITH([systemdsystemunitdir],
+	AS_HELP_STRING([--with-systemdsystemunitdir=3DPATH],
+		       [path to systemd service directory]),
+	[], [with_systemdsystemunitdir=3D$($PKG_CONFIG --variable=3Dsystemdsystem=
unitdir systemd)])
+if test "x$with_systemdsystemunitdir" !=3D xno; then
+    AC_SUBST([SYSTEMD_UNITDIR], [$with_systemdsystemunitdir])
 fi
-AM_CONDITIONAL(SYSTEMD, test "${enable_systemd}" =3D "yes")
+AM_CONDITIONAL(SYSTEMD, [test -n "$with_systemdsystemunitdir" -a "x$with_s=
ystemdsystemunitdir" !=3D xno ])
 =

 AC_ARG_ENABLE(capng, AC_HELP_STRING([--enable-capng],
 		[enable capabilities support]), [enable_capng=3D${enableval}])
-- =

1.7.3.5


--===============4742652458145594499==--

