Content-Type: multipart/mixed; boundary="===============1966504381578805006=="
MIME-Version: 1.0
From: =?unknown-8bit?q?Fr=C3=A9d=C3=A9ric?= Dalleau <frederic.dalleau@linux.intel.com>
Subject: [PATCH v5 5/7] handsfree-audio: Add SBC dependency
Date: Tue, 27 Aug 2013 18:59:41 +0200
Message-ID: <1377622783-22845-6-git-send-email-frederic.dalleau@linux.intel.com>
In-Reply-To: <1377622783-22845-1-git-send-email-frederic.dalleau@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1966504381578805006==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

mSBC codec is used in HFP 1.6 Wideband Speech.
---
 Makefile.am  |    4 ++--
 configure.ac |    5 +++++
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/Makefile.am b/Makefile.am
index fff6c3d..41a4fa3 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -538,7 +538,7 @@ else
 build_plugindir =3D $(plugindir)
 endif
 =

-AM_CFLAGS =3D @DBUS_CFLAGS@ @GLIB_CFLAGS@ @USB_CFLAGS@ \
+AM_CFLAGS =3D @DBUS_CFLAGS@ @GLIB_CFLAGS@ @USB_CFLAGS@ @SBC_CFLAGS@ \
 					$(builtin_cflags) \
 					-DOFONO_PLUGIN_BUILTIN \
 					-DPLUGINDIR=3D\""$(build_plugindir)"\"
@@ -736,7 +736,7 @@ tools_huawei_audio_LDADD =3D gdbus/libgdbus-internal.la=
 @GLIB_LIBS@ @DBUS_LIBS@
 =

 tools_handsfree_audio_SOURCES =3D tools/handsfree-audio.c
 tools_handsfree_audio_LDADD =3D gdbus/libgdbus-internal.la -lpthread \
-				@GLIB_LIBS@ @DBUS_LIBS@ @ALSA_LIBS@
+				@GLIB_LIBS@ @DBUS_LIBS@ @ALSA_LIBS@ @SBC_LIBS@
 =

 tools_auto_enable_SOURCES =3D tools/auto-enable.c
 tools_auto_enable_LDADD =3D gdbus/libgdbus-internal.la @GLIB_LIBS@ @DBUS_L=
IBS@
diff --git a/configure.ac b/configure.ac
index 2778dcb..f200eb6 100644
--- a/configure.ac
+++ b/configure.ac
@@ -126,6 +126,11 @@ if (test "${enable_tools}" =3D "yes"); then
 				AC_MSG_ERROR(Alsa library is required))
 	AC_SUBST(ALSA_CFLAGS)
 	AC_SUBST(ALSA_LIBS)
+
+	PKG_CHECK_MODULES(SBC, sbc >=3D 1.1, dummy=3Dyes,
+				AC_MSG_ERROR(SBC library v. 1.1 is required))
+	AC_SUBST(SBC_CFLAGS)
+	AC_SUBST(SBC_LIBS)
 fi
 AM_CONDITIONAL(TOOLS, test "${enable_tools}" =3D "yes")
 =

-- =

1.7.9.5


--===============1966504381578805006==--

