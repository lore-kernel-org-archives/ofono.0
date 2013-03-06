Content-Type: multipart/mixed; boundary="===============5382829991927632418=="
MIME-Version: 1.0
From: =?unknown-8bit?q?Fr=C3=A9d=C3=A9ric?= Dalleau <frederic.dalleau@linux.intel.com>
Subject: [RFC v2 7/8] handsfree-audio: Link tool with SBC library
Date: Wed, 06 Mar 2013 10:25:33 +0100
Message-ID: <1362561934-24913-7-git-send-email-frederic.dalleau@linux.intel.com>
In-Reply-To: <1362561934-24913-1-git-send-email-frederic.dalleau@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5382829991927632418==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 Makefile.am |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile.am b/Makefile.am
index 1ab6c05..99ab1f7 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -725,7 +725,7 @@ tools_huawei_audio_SOURCES =3D $(gdbus_sources) tools/h=
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


--===============5382829991927632418==--

