Content-Type: multipart/mixed; boundary="===============7021200037768054476=="
MIME-Version: 1.0
From: Giacinto Cifelli <gciofono@gmail.com>
Subject: [PATCH 2/2] gemaltomodem: added gprs-context-wwan.c in the makefile
Date: Thu, 20 Sep 2018 05:50:14 +0200
Message-ID: <1537415414-3859-2-git-send-email-gciofono@gmail.com>
In-Reply-To: <1537415414-3859-1-git-send-email-gciofono@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7021200037768054476==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 Makefile.am | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Makefile.am b/Makefile.am
index e2363e2..fabda0a 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -397,6 +397,7 @@ builtin_modules +=3D gemaltomodem
 builtin_sources +=3D drivers/atmodem/atutil.h \
 			drivers/gemaltomodem/gemaltomodem.h \
 			drivers/gemaltomodem/gemaltomodem.c \
+			drivers/gemaltomodem/gprs-context-wwan.c \
 			drivers/gemaltomodem/voicecall.c \
 			drivers/gemaltomodem/location-reporting.c
 =

-- =

1.9.1


--===============7021200037768054476==--

