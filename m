Content-Type: multipart/mixed; boundary="===============8937941466641506015=="
MIME-Version: 1.0
From: Tony Espy <espy@canonical.com>
Subject: [PATCH 2/2 v3] build: add support for upower plugin
Date: Wed, 16 Dec 2015 15:00:43 -0500
Message-ID: <1450296043-4083-2-git-send-email-espy@canonical.com>
In-Reply-To: <1450296043-4083-1-git-send-email-espy@canonical.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8937941466641506015==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 Makefile.am  | 5 +++++
 configure.ac | 5 +++++
 2 files changed, 10 insertions(+)

diff --git a/Makefile.am b/Makefile.am
index b22c04b..dd8cb6c 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -512,6 +512,11 @@ builtin_sources +=3D plugins/hfp_ag_bluez5.c plugins/b=
luez5.h
 builtin_modules +=3D dun_gw_bluez5
 builtin_sources +=3D plugins/dun_gw_bluez5.c plugins/bluez5.h
 endif
+
+if UPOWER
+builtin_modules +=3D upower
+builtin_sources +=3D plugins/upower.c
+endif
 endif
 endif
 =

diff --git a/configure.ac b/configure.ac
index b8d42c8..f6253e5 100644
--- a/configure.ac
+++ b/configure.ac
@@ -213,6 +213,11 @@ if (test "${enable_provision}" !=3D "no"); then
 fi
 AM_CONDITIONAL(PROVISION, test "${enable_provision}" !=3D "no")
 =

+AC_ARG_ENABLE(upower, AC_HELP_STRING([--disable-upower],
+			[disable UPower plugin]),
+					[enable_upower=3D${enableval}])
+AM_CONDITIONAL(UPOWER, test "${enable_power}" !=3D "no")
+
 AC_ARG_ENABLE(datafiles, AC_HELP_STRING([--disable-datafiles],
 			[do not install configuration and data files]),
 					[enable_datafiles=3D${enableval}])
-- =

2.1.4


--===============8937941466641506015==--

