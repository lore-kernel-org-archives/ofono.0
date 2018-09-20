Content-Type: multipart/mixed; boundary="===============3802138873037481944=="
MIME-Version: 1.0
From: Giacinto Cifelli <gciofono@gmail.com>
Subject: [PATCH 2/2] gemaltomodem: added voicecall.c in the makefile
Date: Thu, 20 Sep 2018 05:32:23 +0200
Message-ID: <1537414343-3705-2-git-send-email-gciofono@gmail.com>
In-Reply-To: <1537414343-3705-1-git-send-email-gciofono@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3802138873037481944==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 Makefile.am | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Makefile.am b/Makefile.am
index 6dee4ce..e2363e2 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -397,6 +397,7 @@ builtin_modules +=3D gemaltomodem
 builtin_sources +=3D drivers/atmodem/atutil.h \
 			drivers/gemaltomodem/gemaltomodem.h \
 			drivers/gemaltomodem/gemaltomodem.c \
+			drivers/gemaltomodem/voicecall.c \
 			drivers/gemaltomodem/location-reporting.c
 =

 builtin_modules +=3D xmm7modem
-- =

1.9.1


--===============3802138873037481944==--

