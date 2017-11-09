Content-Type: multipart/mixed; boundary="===============4505459981509571226=="
MIME-Version: 1.0
From: James Prestwood <james.prestwood@linux.intel.com>
Subject: [PATCH 2/6] make: remove atmodem simauth driver
Date: Thu, 09 Nov 2017 09:17:08 -0800
Message-ID: <1510247832-19632-2-git-send-email-james.prestwood@linux.intel.com>
In-Reply-To: <1510247832-19632-1-git-send-email-james.prestwood@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4505459981509571226==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 Makefile.am | 1 -
 1 file changed, 1 deletion(-)

diff --git a/Makefile.am b/Makefile.am
index 7a5e6ce..53f1972 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -264,7 +264,6 @@ builtin_sources +=3D 	drivers/atmodem/atmodem.h \
 			drivers/atmodem/atutil.c \
 			drivers/atmodem/gprs.c \
 			drivers/atmodem/gprs-context.c \
-			drivers/atmodem/sim-auth.c \
 			drivers/atmodem/gnss.c \
 			drivers/atmodem/lte.c
 =

-- =

2.7.4


--===============4505459981509571226==--

