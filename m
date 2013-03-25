Content-Type: multipart/mixed; boundary="===============6975820388770505002=="
MIME-Version: 1.0
From: =?unknown-8bit?q?Fr=C3=A9d=C3=A9ric?= Dalleau <frederic.dalleau@linux.intel.com>
Subject: [PATCH v4 7/9] handsfree-audio: Link tool with SBC library
Date: Mon, 25 Mar 2013 18:16:33 +0100
Message-ID: <1364231795-13787-8-git-send-email-frederic.dalleau@linux.intel.com>
In-Reply-To: <1364231795-13787-1-git-send-email-frederic.dalleau@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6975820388770505002==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 Makefile.am |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile.am b/Makefile.am
index 2e5fa4c..917ad38 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -728,7 +728,7 @@ tools_huawei_audio_SOURCES =3D $(gdbus_sources) tools/h=
uawei-audio.c
 tools_huawei_audio_LDADD =3D @GLIB_LIBS@ @DBUS_LIBS@
 =

 tools_handsfree_audio_SOURCES =3D $(gdbus_sources) tools/handsfree-audio.c
-tools_handsfree_audio_LDADD =3D @GLIB_LIBS@ @DBUS_LIBS@ @ALSA_LIBS@ -lpthr=
ead
+tools_handsfree_audio_LDADD =3D @GLIB_LIBS@ @DBUS_LIBS@ @ALSA_LIBS@ @SBC_L=
IBS@ -lpthread
 =

 tools_auto_enable_SOURCES =3D $(gdbus_sources) tools/auto-enable.c
 tools_auto_enable_LDADD =3D @GLIB_LIBS@ @DBUS_LIBS@
-- =

1.7.9.5


--===============6975820388770505002==--

