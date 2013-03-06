Content-Type: multipart/mixed; boundary="===============4433154238125484646=="
MIME-Version: 1.0
From: =?unknown-8bit?q?Fr=C3=A9d=C3=A9ric?= Dalleau <frederic.dalleau@linux.intel.com>
Subject: [RFC v2 2/8] handsfree-audio: Build handsfree-audio command line tool
Date: Wed, 06 Mar 2013 10:25:28 +0100
Message-ID: <1362561934-24913-2-git-send-email-frederic.dalleau@linux.intel.com>
In-Reply-To: <1362561934-24913-1-git-send-email-frederic.dalleau@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4433154238125484646==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 Makefile.am |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/Makefile.am b/Makefile.am
index 3b998af..17617f9 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -718,11 +718,15 @@ TESTS =3D $(unit_tests)
 if TOOLS
 noinst_PROGRAMS +=3D tools/huawei-audio tools/auto-enable \
 			tools/get-location tools/lookup-apn \
-			tools/lookup-provider-name tools/tty-redirector
+			tools/lookup-provider-name tools/tty-redirector \
+			tools/handsfree-audio
 =

 tools_huawei_audio_SOURCES =3D $(gdbus_sources) tools/huawei-audio.c
 tools_huawei_audio_LDADD =3D @GLIB_LIBS@ @DBUS_LIBS@
 =

+tools_handsfree_audio_SOURCES =3D $(gdbus_sources) tools/handsfree-audio.c
+tools_handsfree_audio_LDADD =3D @GLIB_LIBS@ @DBUS_LIBS@
+
 tools_auto_enable_SOURCES =3D $(gdbus_sources) tools/auto-enable.c
 tools_auto_enable_LDADD =3D @GLIB_LIBS@ @DBUS_LIBS@
 =

-- =

1.7.9.5


--===============4433154238125484646==--

