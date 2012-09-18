Content-Type: multipart/mixed; boundary="===============6975379880433584094=="
MIME-Version: 1.0
From: Simon Busch <morphis@gravedo.de>
Subject: [PATCH 02/11] build: add dependency for samsung-ipc library
Date: Tue, 18 Sep 2012 20:18:46 +0200
Message-ID: <1347992335-9016-3-git-send-email-morphis@gravedo.de>
In-Reply-To: <1347992335-9016-1-git-send-email-morphis@gravedo.de>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6975379880433584094==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 Makefile.am  |    2 ++
 configure.ac |    6 ++++++
 2 files changed, 8 insertions(+)

diff --git a/Makefile.am b/Makefile.am
index 4cfec6b..a7d2d6e 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -186,6 +186,8 @@ builtin_modules +=3D samsungipcmodem
 builtin_sources +=3D \
 	drivers/samsungipcmodem/samsungipcmodem.c \
 	drivers/samsungipcmodem/samsungipcmodem.h
+builtin_cflags +=3D @SAMSUNGIPC_CFLAGS@
+builtin_libadd +=3D @SAMSUNGIPC_LIBS@
 endif
 =

 if ATMODEM
diff --git a/configure.ac b/configure.ac
index 3835d35..87850b7 100644
--- a/configure.ac
+++ b/configure.ac
@@ -175,6 +175,12 @@ AM_CONDITIONAL(QMIMODEM, test "${enable_qmimodem}" !=
=3D "no")
 AC_ARG_ENABLE(samsungipc, AC_HELP_STRING([--disable-samsungipcmodem],
 				[disable Samsung IPC modem support]),
 					[enable_samsungipc=3D${enableval}])
+if (test "${enable_samsungipc}" !=3D "no"); then
+	PKG_CHECK_MODULES(SAMSUNGIPC, samsung-ipc-1.0 >=3D 0.2, dummy=3Dyes,
+			AC_MSG_ERROR(Samsung IPC library >=3D 0.2 is required))
+fi
+AC_SUBST(SAMSUNGIPC_CFLAGS)
+AC_SUBST(SAMSUNGIPC_LIBS)
 AM_CONDITIONAL(SAMSUNGIPCMODEM, test "${enable_samsungipc}" !=3D "no")
 =

 AC_ARG_ENABLE(bluetooth, AC_HELP_STRING([--disable-bluetooth],
-- =

1.7.9.5


--===============6975379880433584094==--

