Content-Type: multipart/mixed; boundary="===============1209218370478149054=="
MIME-Version: 1.0
From: Philippe Nunes <philippe.nunes@linux.intel.com>
Subject: [PATCH 1/7] Huaweicdmamodem: remove this specific driver
Date: Thu, 24 Nov 2011 18:46:18 +0100
Message-ID: <1322156784-10402-2-git-send-email-philippe.nunes@linux.intel.com>
In-Reply-To: <1322156784-10402-1-git-send-email-philippe.nunes@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1209218370478149054==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 Makefile.am |    6 ------
 1 files changed, 0 insertions(+), 6 deletions(-)

diff --git a/Makefile.am b/Makefile.am
index 337aeb7..4c3ca84 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -274,12 +274,6 @@ builtin_sources +=3D drivers/cdmamodem/cdmamodem.h \
 			drivers/cdmamodem/voicecall.c \
 			drivers/cdmamodem/devinfo.c \
 			drivers/cdmamodem/connman.c
-
-builtin_modules +=3D huaweicdmamodem
-builtin_sources +=3D drivers/huaweicdmamodem/huaweicdmamodem.h \
-			drivers/huaweicdmamodem/huaweicdmamodem.c \
-			drivers/huaweicdmamodem/network-registration.c
-
 endif
 =

 builtin_modules +=3D g1
-- =

1.7.1


--===============1209218370478149054==--

