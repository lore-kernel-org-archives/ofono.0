Content-Type: multipart/mixed; boundary="===============1988866613746665304=="
MIME-Version: 1.0
From: Guillaume Zajac <guillaume.zajac@linux.intel.com>
Subject: [PATCH] speedupcdma: Create cdma-netreg atom
Date: Thu, 15 Dec 2011 15:13:33 +0100
Message-ID: <1323958413-3921-1-git-send-email-guillaume.zajac@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1988866613746665304==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

According to SpeedUp 7300 specifications, SpeedUp uses
same AT command as Huawei so we can create cdma-netreg atom
using huaweicdma drivers.
---
 plugins/speedupcdma.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/plugins/speedupcdma.c b/plugins/speedupcdma.c
index fbf516c..8e5f324 100644
--- a/plugins/speedupcdma.c
+++ b/plugins/speedupcdma.c
@@ -34,6 +34,7 @@
 #include <ofono/plugin.h>
 #include <ofono/modem.h>
 #include <ofono/devinfo.h>
+#include <ofono/cdma-netreg.h>
 #include <ofono/cdma-connman.h>
 #include <ofono/log.h>
 =

@@ -214,6 +215,8 @@ static void speedupcdma_post_online(struct ofono_modem =
*modem)
 =

 	DBG("%p", modem);
 =

+	ofono_cdma_netreg_create(modem, 0, "huaweicdmamodem", data->aux);
+
 	ofono_cdma_connman_create(modem, OFONO_VENDOR_HUAWEI, "cdmamodem",
 					data->modem);
 }
-- =

1.7.1


--===============1988866613746665304==--

