Content-Type: multipart/mixed; boundary="===============1779709055096362498=="
MIME-Version: 1.0
From: Kalle Valo <kalle.valo@canonical.com>
Subject: [PATCH 3/3] huawei: add gprs context
Date: Fri, 23 Apr 2010 16:40:26 +0300
Message-ID: <20100423134026.2107.49200.stgit@potku.valot.fi>
In-Reply-To: <20100423133926.2107.66535.stgit@potku.valot.fi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1779709055096362498==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Tested with Huawei E1552 HSDPA USB stick using a finnish Saunalahti prepaid
SIM.
---

 plugins/huawei.c |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/plugins/huawei.c b/plugins/huawei.c
index 90fdcf0..fd1528f 100644
--- a/plugins/huawei.c
+++ b/plugins/huawei.c
@@ -41,6 +41,8 @@
 #include <ofono/gprs.h>
 #include <ofono/voicecall.h>
 #include <ofono/log.h>
+#include <ofono/gprs.h>
+#include <ofono/gprs-context.h>
 =

 #include <drivers/atmodem/vendor.h>
 =

@@ -178,11 +180,19 @@ static void huawei_pre_sim(struct ofono_modem *modem)
 static void huawei_post_sim(struct ofono_modem *modem)
 {
 	struct huawei_data *data =3D ofono_modem_get_data(modem);
+	struct ofono_gprs_context *gc;
+	struct ofono_gprs *gprs;
 =

 	DBG("%p", modem);
 =

 	ofono_netreg_create(modem, OFONO_VENDOR_HUAWEI, "atmodem", data->chat);
 	ofono_sms_create(modem, OFONO_VENDOR_QUALCOMM_MSM, "atmodem", data->chat);
+
+	gprs =3D ofono_gprs_create(modem, 0, "atmodem", data->chat);
+	gc =3D ofono_gprs_context_create(modem, 0, "atmodem", data->chat);
+
+	if (gprs && gc)
+		ofono_gprs_add_context(gprs, gc);
 }
 =

 static struct ofono_modem_driver huawei_driver =3D {


--===============1779709055096362498==--

