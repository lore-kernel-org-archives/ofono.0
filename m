Content-Type: multipart/mixed; boundary="===============5085543447712304159=="
MIME-Version: 1.0
From: Giacinto Cifelli <gciofono@gmail.com>
Subject: [PATCH 6/7] extended support for LTE and NR. Some minor fixes. part 6
 of 7
Date: Wed, 19 Sep 2018 07:37:32 +0200
Message-ID: <1537335453-21498-6-git-send-email-gciofono@gmail.com>
In-Reply-To: <1537335453-21498-1-git-send-email-gciofono@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5085543447712304159==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 Makefile.am | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Makefile.am b/Makefile.am
index 6dee4ce..fabda0a 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -397,6 +397,8 @@ builtin_modules +=3D gemaltomodem
 builtin_sources +=3D drivers/atmodem/atutil.h \
 			drivers/gemaltomodem/gemaltomodem.h \
 			drivers/gemaltomodem/gemaltomodem.c \
+			drivers/gemaltomodem/gprs-context-wwan.c \
+			drivers/gemaltomodem/voicecall.c \
 			drivers/gemaltomodem/location-reporting.c
 =

 builtin_modules +=3D xmm7modem
-- =

1.9.1


--===============5085543447712304159==--

