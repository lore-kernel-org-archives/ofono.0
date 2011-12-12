Content-Type: multipart/mixed; boundary="===============5925074339948647707=="
MIME-Version: 1.0
From: Guillaume Zajac <guillaume.zajac@linux.intel.com>
Subject: [PATCH] speedupcdma: Tweak plugin to notify dormant state
Date: Mon, 12 Dec 2011 17:13:32 +0100
Message-ID: <1323706412-3207-1-git-send-email-guillaume.zajac@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5925074339948647707==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 plugins/speedupcdma.c |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/plugins/speedupcdma.c b/plugins/speedupcdma.c
index 3b398aa..fbf516c 100644
--- a/plugins/speedupcdma.c
+++ b/plugins/speedupcdma.c
@@ -37,6 +37,8 @@
 #include <ofono/cdma-connman.h>
 #include <ofono/log.h>
 =

+#include "drivers/atmodem/vendor.h"
+
 struct speedupcdma_data {
 	GAtChat *modem;
 	GAtChat *aux;
@@ -146,6 +148,8 @@ static int speedupcdma_enable(struct ofono_modem *modem)
 		return -EIO;
 	}
 =

+	g_at_chat_set_slave(data->modem, data->aux);
+
 	g_at_chat_send(data->modem, "ATE0 &C0 +CMEE=3D1", NULL, NULL, NULL, NULL);
 	g_at_chat_send(data->aux, "ATE0 &C0 +CMEE=3D1", NULL, NULL, NULL, NULL);
 =

@@ -210,7 +214,8 @@ static void speedupcdma_post_online(struct ofono_modem =
*modem)
 =

 	DBG("%p", modem);
 =

-	ofono_cdma_connman_create(modem, 0, "cdmamodem", data->modem);
+	ofono_cdma_connman_create(modem, OFONO_VENDOR_HUAWEI, "cdmamodem",
+					data->modem);
 }
 =

 static struct ofono_modem_driver speedupcdma_driver =3D {
-- =

1.7.1


--===============5925074339948647707==--

