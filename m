Content-Type: multipart/mixed; boundary="===============6390621698205984619=="
MIME-Version: 1.0
From: Djalal Harouni <djalal@endocode.com>
Subject: [PATCH v3 6/7] build: build the ublox netmon driver
Date: Wed, 30 Nov 2016 13:31:44 +0100
Message-ID: <1480509105-17934-7-git-send-email-djalal@endocode.com>
In-Reply-To: <1480509105-17934-1-git-send-email-djalal@endocode.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6390621698205984619==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 Makefile.am | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Makefile.am b/Makefile.am
index 3d7774b..07adeab 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -383,6 +383,7 @@ builtin_sources +=3D drivers/atmodem/atutil.h \
 			drivers/ubloxmodem/ubloxmodem.h \
 			drivers/ubloxmodem/ubloxmodem.c \
 			drivers/ubloxmodem/gprs-context.c \
+			drivers/ubloxmodem/netmon.c \
 			drivers/ubloxmodem/lte.c
 =

 =

-- =

2.5.5


--===============6390621698205984619==--

