Content-Type: multipart/mixed; boundary="===============6228229810999983466=="
MIME-Version: 1.0
From: Guillaume Zajac <guillaume.zajac@linux.intel.com>
Subject: [PATCH_v0 4/6] huaweicdma: Specify vendor in creating cdma-connman
 atom
Date: Wed, 07 Dec 2011 17:05:49 +0100
Message-ID: <1323273951-24162-5-git-send-email-guillaume.zajac@linux.intel.com>
In-Reply-To: <1323273951-24162-1-git-send-email-guillaume.zajac@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6228229810999983466==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 plugins/huaweicdma.c |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/plugins/huaweicdma.c b/plugins/huaweicdma.c
index 4c83114..50b4761 100644
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
@@ -147,6 +149,8 @@ static int huaweicdma_enable(struct ofono_modem *modem)
 		return -EIO;
 	}
 =

+	g_at_chat_set_slave(data->modem, data->pcui);
+
 	g_at_chat_send(data->modem, "ATE0 &C0 +CMEE=3D1", NULL, NULL, NULL, NULL);
 	g_at_chat_send(data->pcui, "ATE0 &C0 +CMEE=3D1", NULL, NULL, NULL, NULL);
 =

@@ -213,7 +217,8 @@ static void huaweicdma_post_online(struct ofono_modem *=
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


--===============6228229810999983466==--

