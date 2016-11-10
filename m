Content-Type: multipart/mixed; boundary="===============4179401557986946668=="
MIME-Version: 1.0
From: Dragos Tatulea <dragos@endocode.com>
Subject: [PATCH 8/9] build: add support for ublox lte atom driver
Date: Thu, 10 Nov 2016 17:55:55 +0100
Message-ID: <1478796956-22500-9-git-send-email-dragos@endocode.com>
In-Reply-To: <1478796956-22500-1-git-send-email-dragos@endocode.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4179401557986946668==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 Makefile.am | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Makefile.am b/Makefile.am
index 9d22365..08c7395 100644
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


--===============4179401557986946668==--

