Content-Type: multipart/mixed; boundary="===============0338274531765053362=="
MIME-Version: 1.0
From: Oleg Zhurakivskyy <oleg.zhurakivskyy@intel.com>
Subject: [PATCH 2/3] Mobile broadband provider info plugin autoconf support
Date: Fri, 15 Jul 2011 18:12:16 +0300
Message-ID: <1310742737-5254-3-git-send-email-oleg.zhurakivskyy@intel.com>
In-Reply-To: <1310742737-5254-1-git-send-email-oleg.zhurakivskyy@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0338274531765053362==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 configure.ac |   19 +++++++++++++------
 1 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/configure.ac b/configure.ac
index a6b4094..966237c 100644
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

1.7.1


--===============0338274531765053362==--

