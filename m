Content-Type: multipart/mixed; boundary="===============1017316843452844210=="
MIME-Version: 1.0
From: Oleg Zhurakivskyy <oleg.zhurakivskyy@intel.com>
Subject: [PATCHv8 1/6] plugins: Provisioning plugin autoconf support
Date: Fri, 30 Sep 2011 16:31:09 +0300
Message-ID: <1317389474-16566-2-git-send-email-oleg.zhurakivskyy@intel.com>
In-Reply-To: <1317389474-16566-1-git-send-email-oleg.zhurakivskyy@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1017316843452844210==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 configure.ac |   23 ++++++++++++++++-------
 1 files changed, 16 insertions(+), 7 deletions(-)

diff --git a/configure.ac b/configure.ac
index 9e62066..36a6b73 100644
--- a/configure.ac
+++ b/configure.ac
@@ -197,14 +197,23 @@ AC_SUBST(BLUEZ_CFLAGS)
 AC_SUBST(BLUEZ_LIBS)
 AM_CONDITIONAL(BLUETOOTH, test "${enable_bluetooth}" !=3D "no")
 =

-AC_MSG_CHECKING([for mobile-broadband-provider-info])
-PKG_CHECK_EXISTS(mobile-broadband-provider-info,
-	_PKG_CONFIG(PROVIDER_DATABASE, [variable=3Ddatabase],
+AC_ARG_ENABLE(provision, AC_HELP_STRING([--enable-provision],
+				[enable GPRS context settings provisioning]),
+					[enable_provision=3D${enableval}])
+if (test "${enable_provision}" =3D=3D "yes"); then
+	AC_MSG_CHECKING([for mobile-broadband-provider-info])
+	PKG_CHECK_EXISTS(mobile-broadband-provider-info,
+			_PKG_CONFIG(MBPI_DATABASE, [variable=3Ddatabase],
 					[mobile-broadband-provider-info])
-	AC_DEFINE_UNQUOTED(PROVIDER_DATABASE, "$pkg_cv_PROVIDER_DATABASE",
-					[Mobile provider database])
-	AC_MSG_RESULT([yes]),
-	AC_MSG_RESULT([no]))
+		AC_DEFINE_UNQUOTED(MBPI_DATABASE,
+					"$pkg_cv_MBPI_DATABASE",
+					[Provisioning database =

+					(mobile-broadband-provider-info =

+					package)])
+		AC_MSG_RESULT([yes]),
+		AC_MSG_ERROR(mobile-broadband-provider-info package is required))
+fi
+AM_CONDITIONAL(PROVISION, test "${enable_provision}" =3D=3D "yes")
 =

 AC_ARG_ENABLE(datafiles, AC_HELP_STRING([--disable-datafiles],
 			[don't install configuration and data files]),
-- =

1.7.4.1


--===============1017316843452844210==--

