Content-Type: multipart/mixed; boundary="===============2953304763368056571=="
MIME-Version: 1.0
From: Alfonso Sanchez-Beato <alfonso.sanchez-beato@canonical.com>
Subject: [PATCH 7/7] build: Add mtkmodem driver and mtk plugin
Date: Fri, 13 Nov 2015 13:25:10 +0100
Message-ID: <1447417510-9368-8-git-send-email-alfonso.sanchez-beato@canonical.com>
In-Reply-To: <1447417510-9368-1-git-send-email-alfonso.sanchez-beato@canonical.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2953304763368056571==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 Makefile.am | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/Makefile.am b/Makefile.am
index fba25ba..6a2acf2 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -126,9 +126,28 @@ builtin_sources +=3D plugins/rildev.c
 builtin_modules +=3D ril
 builtin_sources +=3D plugins/ril.c plugins/ril.h
 =

+builtin_modules +=3D mtk
+builtin_sources +=3D plugins/mtk.c
+
 builtin_modules +=3D infineon
 builtin_sources +=3D plugins/infineon.c
 =

+builtin_modules +=3D mtkmodem
+builtin_sources +=3D drivers/mtkmodem/mtkmodem.h \
+			drivers/mtkmodem/mtkmodem.c \
+			drivers/mtkmodem/mtkutil.h \
+			drivers/mtkmodem/mtkutil.c \
+			drivers/mtkmodem/mtkrequest.h \
+			drivers/mtkmodem/mtkrequest.c \
+			drivers/mtkmodem/mtkunsol.h \
+			drivers/mtkmodem/mtkunsol.c \
+			drivers/mtkmodem/mtkreply.h \
+			drivers/mtkmodem/mtkreply.c \
+			drivers/mtkmodem/voicecall.c \
+			drivers/mtkmodem/gprs.c \
+			drivers/mtkmodem/radio-settings.c \
+			drivers/mtkmodem/mtksettings.c
+
 builtin_modules +=3D rilmodem
 builtin_sources +=3D drivers/rilmodem/rilmodem.h \
 			drivers/rilmodem/vendor.h \
-- =

2.5.0


--===============2953304763368056571==--

