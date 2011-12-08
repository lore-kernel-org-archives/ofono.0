Content-Type: multipart/mixed; boundary="===============4700849858303802143=="
MIME-Version: 1.0
From: Guillaume Zajac <guillaume.zajac@linux.intel.com>
Subject: [PATCH_v1 3/4] huaweicdma: Tweak plugin to notify dormant state
Date: Thu, 08 Dec 2011 12:00:29 +0100
Message-ID: <1323342030-9175-4-git-send-email-guillaume.zajac@linux.intel.com>
In-Reply-To: <1323342030-9175-1-git-send-email-guillaume.zajac@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4700849858303802143==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Specify vendor in creating cdma-connman atom.
Set PCUI interface as slave of MODEM interface to receive dormant
state notification during data call.
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


--===============4700849858303802143==--

