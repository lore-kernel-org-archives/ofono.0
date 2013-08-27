Content-Type: multipart/mixed; boundary="===============2586471972656365726=="
MIME-Version: 1.0
From: =?unknown-8bit?q?Fr=C3=A9d=C3=A9ric?= Dalleau <frederic.dalleau@linux.intel.com>
Subject: [PATCH v5 2/7] handsfree-audio: Build handsfree-audio command line
 tool
Date: Tue, 27 Aug 2013 18:59:38 +0200
Message-ID: <1377622783-22845-3-git-send-email-frederic.dalleau@linux.intel.com>
In-Reply-To: <1377622783-22845-1-git-send-email-frederic.dalleau@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2586471972656365726==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Add tools/hands-audio to build and update .gitignore
---
 .gitignore  |    1 +
 Makefile.am |    7 ++++++-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/.gitignore b/.gitignore
index b9c23a0..a5afafc 100644
--- a/.gitignore
+++ b/.gitignore
@@ -48,6 +48,7 @@ unit/test-*.log
 unit/test-*.trs
 =

 tools/huawei-audio
+tools/handsfree-audio
 tools/auto-enable
 tools/get-location
 tools/lookup-apn
diff --git a/Makefile.am b/Makefile.am
index f045107..03eed20 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -728,11 +728,16 @@ TESTS =3D $(unit_tests)
 if TOOLS
 noinst_PROGRAMS +=3D tools/huawei-audio tools/auto-enable \
 			tools/get-location tools/lookup-apn \
-			tools/lookup-provider-name tools/tty-redirector
+			tools/lookup-provider-name tools/tty-redirector \
+			tools/handsfree-audio
 =

 tools_huawei_audio_SOURCES =3D tools/huawei-audio.c
 tools_huawei_audio_LDADD =3D gdbus/libgdbus-internal.la @GLIB_LIBS@ @DBUS_=
LIBS@
 =

+tools_handsfree_audio_SOURCES =3D tools/handsfree-audio.c
+tools_handsfree_audio_LDADD =3D gdbus/libgdbus-internal.la -lpthread \
+				@GLIB_LIBS@ @DBUS_LIBS@
+
 tools_auto_enable_SOURCES =3D tools/auto-enable.c
 tools_auto_enable_LDADD =3D gdbus/libgdbus-internal.la @GLIB_LIBS@ @DBUS_L=
IBS@
 =

-- =

1.7.9.5


--===============2586471972656365726==--

