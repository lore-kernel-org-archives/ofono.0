Content-Type: multipart/mixed; boundary="===============6046228572406905166=="
MIME-Version: 1.0
From: Dragos Tatulea <dragos@endocode.com>
Subject: [PATCH 4/5] build: add support for ublox lte atom driver
Date: Tue, 15 Nov 2016 15:08:19 +0100
Message-ID: <1479218900-9870-5-git-send-email-dragos@endocode.com>
In-Reply-To: <1479218900-9870-1-git-send-email-dragos@endocode.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6046228572406905166==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 Makefile.am | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Makefile.am b/Makefile.am
index af0f1ab..3d7774b 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -382,7 +382,9 @@ builtin_modules +=3D ubloxmodem
 builtin_sources +=3D drivers/atmodem/atutil.h \
 			drivers/ubloxmodem/ubloxmodem.h \
 			drivers/ubloxmodem/ubloxmodem.c \
-			drivers/ubloxmodem/gprs-context.c
+			drivers/ubloxmodem/gprs-context.c \
+			drivers/ubloxmodem/lte.c
+
 =

 =

 if PHONESIM
-- =

2.7.4


--===============6046228572406905166==--

