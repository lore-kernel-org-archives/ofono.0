Content-Type: multipart/mixed; boundary="===============0925641507312732465=="
MIME-Version: 1.0
From: Timo Mueller <mail@timomueller.eu>
Subject: [PATCHv4 2/8] hfpmodem: Add vendor header to makefile
Date: Thu, 28 Mar 2013 14:36:56 +0100
Message-ID: <9bde6a432e213f194801663767ac4d3aa6cfa45c.1364477353.git.timo.mueller@bmw-carit.de>
In-Reply-To: <1d65943189c7e91e69bd00b20436479753e360d9.1364477353.git.timo.mueller@bmw-carit.de>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0925641507312732465==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Timo Mueller <timo.mueller@bmw-carit.de>

---
 Makefile.am | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Makefile.am b/Makefile.am
index 3524098..27bb7d7 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -310,7 +310,8 @@ builtin_sources +=3D drivers/atmodem/atutil.h \
 			drivers/hfpmodem/network-registration.c \
 			drivers/hfpmodem/call-volume.c \
 			drivers/hfpmodem/devinfo.c \
-			drivers/hfpmodem/handsfree.c
+			drivers/hfpmodem/handsfree.c \
+			drivers/hfpmodem/vendor.h
 =

 builtin_modules +=3D speedupmodem
 builtin_sources +=3D drivers/atmodem/atutil.h \
-- =

1.7.11.7


--===============0925641507312732465==--

