Content-Type: multipart/mixed; boundary="===============0082803780643265751=="
MIME-Version: 1.0
From: Oleg Zhurakivskyy <oleg.zhurakivskyy@intel.com>
Subject: [PATCHv6 2/3] Mobile broadband provider info plugin autoconf support
Date: Wed, 14 Sep 2011 16:16:43 +0300
Message-ID: <1316006204-11390-3-git-send-email-oleg.zhurakivskyy@intel.com>
In-Reply-To: <1316006204-11390-1-git-send-email-oleg.zhurakivskyy@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0082803780643265751==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 configure.ac |   19 +++++++++++++------
 1 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/configure.ac b/configure.ac
index 9e62066..a224c8b 100644
--- a/configure.ac
+++ b/configure.ac
@@ -197,14 +197,21 @@ AC_SUBST(BLUEZ_CFLAGS)
 AC_SUBST(BLUEZ_LIBS)
 AM_CONDITIONAL(BLUETOOTH, test "${enable_bluetooth}" !=3D "no")
 =

-AC_MSG_CHECKING([for mobile-broadband-provider-info])
-PKG_CHECK_EXISTS(mobile-broadband-provider-info,
-	_PKG_CONFIG(PROVIDER_DATABASE, [variable=3Ddatabase],
+AC_ARG_ENABLE(provider-info, AC_HELP_STRING([--enable-provider-info],
+				[enable mobile provider database support]),
+					[enable_provider_info=3D${enableval}])
+if (test "${enable_provider_info}" =3D=3D "yes"); then
+	AC_MSG_CHECKING([for mobile-broadband-provider-info])
+	PKG_CHECK_EXISTS(mobile-broadband-provider-info,
+			_PKG_CONFIG(PROVIDER_DATABASE, [variable=3Ddatabase],
 					[mobile-broadband-provider-info])
-	AC_DEFINE_UNQUOTED(PROVIDER_DATABASE, "$pkg_cv_PROVIDER_DATABASE",
+		AC_DEFINE_UNQUOTED(PROVIDER_DATABASE,
+					"$pkg_cv_PROVIDER_DATABASE",
 					[Mobile provider database])
-	AC_MSG_RESULT([yes]),
-	AC_MSG_RESULT([no]))
+		AC_MSG_RESULT([yes]),
+		AC_MSG_ERROR(mobile-broadband-provider-info package is required))
+fi
+AM_CONDITIONAL(PROVIDER_INFO, test "${enable_provider_info}" =3D=3D "yes")
 =

 AC_ARG_ENABLE(datafiles, AC_HELP_STRING([--disable-datafiles],
 			[don't install configuration and data files]),
-- =

1.7.4.1


--===============0082803780643265751==--

