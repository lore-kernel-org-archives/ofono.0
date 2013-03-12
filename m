Content-Type: multipart/mixed; boundary="===============2840563681515307281=="
MIME-Version: 1.0
From: =?unknown-8bit?q?Fr=C3=A9d=C3=A9ric?= Dalleau <frederic.dalleau@linux.intel.com>
Subject: [RFC v3 3/8] handsfree-audio: Add Alsa dependancy
Date: Tue, 12 Mar 2013 19:00:43 +0100
Message-ID: <1363111248-1694-4-git-send-email-frederic.dalleau@linux.intel.com>
In-Reply-To: <1363111248-1694-1-git-send-email-frederic.dalleau@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2840563681515307281==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 configure.ac |    5 +++++
 1 file changed, 5 insertions(+)

diff --git a/configure.ac b/configure.ac
index a4a350f..9be3ebf 100644
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


--===============2840563681515307281==--

