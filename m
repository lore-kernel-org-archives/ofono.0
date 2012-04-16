Content-Type: multipart/mixed; boundary="===============8927769142289008229=="
MIME-Version: 1.0
From: Nicolas Bertrand <nicolas.bertrand@linux.intel.com>
Subject: [PATCH 3/3] Makefile: Add speedup modem target
Date: Mon, 16 Apr 2012 17:10:23 +0200
Message-ID: <1334589023-3633-4-git-send-email-nicolas.bertrand@linux.intel.com>
In-Reply-To: <1334589023-3633-1-git-send-email-nicolas.bertrand@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8927769142289008229==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 Makefile.am |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/Makefile.am b/Makefile.am
index a28198b..b80f501 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -272,6 +272,12 @@ builtin_sources +=3D drivers/atmodem/atutil.h \
 			drivers/hfpmodem/devinfo.c \
 			drivers/hfpmodem/handsfree.c
 =

+builtin_modules +=3D speedupmodem
+builtin_sources +=3D drivers/atmodem/atutil.h \
+			drivers/speedupmodem/speedupmodem.h \
+			drivers/speedupmodem/speedupmodem.c \
+			drivers/speedupmodem/ussd.c
+
 if PHONESIM
 builtin_modules +=3D phonesim
 builtin_sources +=3D plugins/phonesim.c
-- =

1.7.5.4


--===============8927769142289008229==--

