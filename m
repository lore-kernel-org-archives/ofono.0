Content-Type: multipart/mixed; boundary="===============4906948265609486860=="
MIME-Version: 1.0
From: =?unknown-8bit?q?Fr=C3=A9d=C3=A9ric?= Dalleau <frederic.dalleau@linux.intel.com>
Subject: [RFC v3 4/8] handsfree-audio: Link tool with Alsa
Date: Tue, 12 Mar 2013 19:00:44 +0100
Message-ID: <1363111248-1694-5-git-send-email-frederic.dalleau@linux.intel.com>
In-Reply-To: <1363111248-1694-1-git-send-email-frederic.dalleau@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4906948265609486860==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 Makefile.am |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile.am b/Makefile.am
index 17617f9..1ab6c05 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -725,7 +725,7 @@ tools_huawei_audio_SOURCES =3D $(gdbus_sources) tools/h=
uawei-audio.c
 tools_huawei_audio_LDADD =3D @GLIB_LIBS@ @DBUS_LIBS@
 =

 tools_handsfree_audio_SOURCES =3D $(gdbus_sources) tools/handsfree-audio.c
-tools_handsfree_audio_LDADD =3D @GLIB_LIBS@ @DBUS_LIBS@
+tools_handsfree_audio_LDADD =3D @GLIB_LIBS@ @DBUS_LIBS@ @ALSA_LIBS@ -lpthr=
ead
 =

 tools_auto_enable_SOURCES =3D $(gdbus_sources) tools/auto-enable.c
 tools_auto_enable_LDADD =3D @GLIB_LIBS@ @DBUS_LIBS@
-- =

1.7.9.5


--===============4906948265609486860==--

