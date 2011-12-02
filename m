Content-Type: multipart/mixed; boundary="===============6165270134396632597=="
MIME-Version: 1.0
From: Guillaume Zajac <guillaume.zajac@linux.intel.com>
Subject: [PATCH_v0 5/5] huaweicdma: Specify vendor ID while creating
 cdma-connman atom
Date: Fri, 02 Dec 2011 15:00:54 +0100
Message-ID: <1322834454-451-6-git-send-email-guillaume.zajac@linux.intel.com>
In-Reply-To: <1322834454-451-1-git-send-email-guillaume.zajac@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6165270134396632597==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 plugins/huaweicdma.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/plugins/huaweicdma.c b/plugins/huaweicdma.c
index 4c83114..b54262c 100644
--- a/plugins/huaweicdma.c
+++ b/plugins/huaweicdma.c
@@ -38,6 +38,8 @@
 #include <ofono/cdma-connman.h>
 #include <ofono/log.h>
 =

+#include "drivers/atmodem/vendor.h"
+
 struct huaweicdma_data {
 	GAtChat *modem;
 	GAtChat *pcui;
@@ -213,7 +215,8 @@ static void huaweicdma_post_online(struct ofono_modem *=
modem)
 =

 	ofono_cdma_netreg_create(modem, 0, "huaweicdmamodem", data->modem);
 =

-	ofono_cdma_connman_create(modem, 0, "cdmamodem", data->modem);
+	ofono_cdma_connman_create(modem, OFONO_VENDOR_HUAWEI, "cdmamodem",
+					data->modem);
 }
 =

 static struct ofono_modem_driver huaweicdma_driver =3D {
-- =

1.7.1


--===============6165270134396632597==--

