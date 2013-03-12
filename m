Content-Type: multipart/mixed; boundary="===============4369210307983377373=="
MIME-Version: 1.0
From: =?unknown-8bit?q?Fr=C3=A9d=C3=A9ric?= Dalleau <frederic.dalleau@linux.intel.com>
Subject: [RFC v3 6/8] handsfree-audio: Add SBC dependency
Date: Tue, 12 Mar 2013 19:00:46 +0100
Message-ID: <1363111248-1694-7-git-send-email-frederic.dalleau@linux.intel.com>
In-Reply-To: <1363111248-1694-1-git-send-email-frederic.dalleau@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4369210307983377373==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 configure.ac |    5 +++++
 1 file changed, 5 insertions(+)

diff --git a/configure.ac b/configure.ac
index 9be3ebf..8b9d78a 100644
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


--===============4369210307983377373==--

