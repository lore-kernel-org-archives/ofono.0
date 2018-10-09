Content-Type: multipart/mixed; boundary="===============4713939250383438815=="
MIME-Version: 1.0
From: Antara Borwankar <antara.borwankar@intel.com>
Subject: [PATCH 2/2] netmon: Enabled netmon atom for xmm7modem plugin
Date: Tue, 09 Oct 2018 16:56:14 +0530
Message-ID: <1539084374-2449-1-git-send-email-antara.borwankar@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4713939250383438815==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Antara <antara.borwankar@intel.com>

enabling netmon atom to report current serving cell measurements
for xmm7modem
---
 Makefile.am       | 3 ++-
 plugins/xmm7xxx.c | 2 ++
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/Makefile.am b/Makefile.am
index 6dee4ce..e4ea2ae 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -404,7 +404,8 @@ builtin_sources +=3D drivers/atmodem/atutil.h \
 			drivers/xmm7modem/xmm7modem.h \
 			drivers/xmm7modem/xmm7modem.c \
 			drivers/xmm7modem/radio-settings.c \
-			drivers/xmm7modem/ims.c
+			drivers/xmm7modem/ims.c \
+			drivers/xmm7modem/netmon.c
 =

 if PHONESIM
 builtin_modules +=3D phonesim
diff --git a/plugins/xmm7xxx.c b/plugins/xmm7xxx.c
index 9db87ad..6008cf9 100644
--- a/plugins/xmm7xxx.c
+++ b/plugins/xmm7xxx.c
@@ -50,6 +50,7 @@
 #include <ofono/lte.h>
 #include <ofono/ims.h>
 #include <ofono/sim-auth.h>
+#include <ofono/netmon.h>
 =

 #include <drivers/atmodem/atutil.h>
 #include <drivers/atmodem/vendor.h>
@@ -347,6 +348,7 @@ static void xmm7xxx_post_online(struct ofono_modem *mod=
em)
 		ofono_gprs_add_context(gprs, gc);
 =

 	ofono_ims_create(modem, "xmm7modem", data->chat);
+	ofono_netmon_create(modem, 0, "xmm7modem", data->chat);
 }
 =

 static int xmm7xxx_probe(struct ofono_modem *modem)
-- =

1.9.1


--===============4713939250383438815==--

