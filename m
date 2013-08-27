Content-Type: multipart/mixed; boundary="===============4050960707232622473=="
MIME-Version: 1.0
From: =?unknown-8bit?q?Fr=C3=A9d=C3=A9ric?= Dalleau <frederic.dalleau@linux.intel.com>
Subject: [PATCH v5 3/7] handsfree-audio: Add Alsa dependancy
Date: Tue, 27 Aug 2013 18:59:39 +0200
Message-ID: <1377622783-22845-4-git-send-email-frederic.dalleau@linux.intel.com>
In-Reply-To: <1377622783-22845-1-git-send-email-frederic.dalleau@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4050960707232622473==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Alsa will be used in order to playback sound received over SCO.
---
 Makefile.am  |    2 +-
 configure.ac |    5 +++++
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/Makefile.am b/Makefile.am
index 03eed20..fff6c3d 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -736,7 +736,7 @@ tools_huawei_audio_LDADD =3D gdbus/libgdbus-internal.la=
 @GLIB_LIBS@ @DBUS_LIBS@
 =

 tools_handsfree_audio_SOURCES =3D tools/handsfree-audio.c
 tools_handsfree_audio_LDADD =3D gdbus/libgdbus-internal.la -lpthread \
-				@GLIB_LIBS@ @DBUS_LIBS@
+				@GLIB_LIBS@ @DBUS_LIBS@ @ALSA_LIBS@
 =

 tools_auto_enable_SOURCES =3D tools/auto-enable.c
 tools_auto_enable_LDADD =3D gdbus/libgdbus-internal.la @GLIB_LIBS@ @DBUS_L=
IBS@
diff --git a/configure.ac b/configure.ac
index aa1ae3b..2778dcb 100644
--- a/configure.ac
+++ b/configure.ac
@@ -121,6 +121,11 @@ if (test "${enable_tools}" =3D "yes"); then
 				AC_MSG_ERROR(USB library is required))
 	AC_SUBST(USB_CFLAGS)
 	AC_SUBST(USB_LIBS)
+
+	PKG_CHECK_MODULES(ALSA, alsa >=3D 1.0.0, dummy=3Dyes,
+				AC_MSG_ERROR(Alsa library is required))
+	AC_SUBST(ALSA_CFLAGS)
+	AC_SUBST(ALSA_LIBS)
 fi
 AM_CONDITIONAL(TOOLS, test "${enable_tools}" =3D "yes")
 =

-- =

1.7.9.5


--===============4050960707232622473==--

