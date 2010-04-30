Content-Type: multipart/mixed; boundary="===============5818385189236442332=="
MIME-Version: 1.0
From: Kalle Valo <kalle.valo@canonical.com>
Subject: [PATCH v2 6/6] huawei: add gprs context
Date: Fri, 30 Apr 2010 15:55:30 +0300
Message-ID: <20100430125530.30019.39966.stgit@potku.valot.fi>
In-Reply-To: <20100430124405.30019.86945.stgit@potku.valot.fi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5818385189236442332==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Tested with Huawei E1552 HSDPA USB stick using a finnish Saunalahti prepaid
SIM.
---

 plugins/huawei.c |   17 +++++++++++++++++
 1 files changed, 17 insertions(+), 0 deletions(-)

diff --git a/plugins/huawei.c b/plugins/huawei.c
index 30e98f9..e188394 100644
--- a/plugins/huawei.c
+++ b/plugins/huawei.c
@@ -42,7 +42,10 @@
 #include <ofono/gprs.h>
 #include <ofono/voicecall.h>
 #include <ofono/log.h>
+#include <ofono/gprs.h>
+#include <ofono/gprs-context.h>
 =

+#include <drivers/atmodem/gprs.h>
 #include <drivers/atmodem/network-registration.h>
 #include <drivers/atmodem/vendor.h>
 =

@@ -217,6 +220,9 @@ static void huawei_post_sim(struct ofono_modem *modem)
 {
 	struct huawei_data *data =3D ofono_modem_get_data(modem);
 	struct atmodem_network_registration atmodem_netreg;
+ 	struct atmodem_gprs atmodem_gprs;
+	struct ofono_gprs_context *gc;
+	struct ofono_gprs *gprs;
 =

 	DBG("%p", modem);
 =

@@ -227,6 +233,17 @@ static void huawei_post_sim(struct ofono_modem *modem)
 	ofono_netreg_create(modem, OFONO_VENDOR_HUAWEI, "atmodem",
 			    &atmodem_netreg);
 	ofono_sms_create(modem, OFONO_VENDOR_QUALCOMM_MSM, "atmodem", data->chat);
+
+	memset(&atmodem_gprs, 0, sizeof(atmodem_gprs));
+	atmodem_gprs.chat =3D data->chat;
+	atmodem_gprs.event =3D data->event;
+
+	gprs =3D ofono_gprs_create(modem, OFONO_VENDOR_HUAWEI, "atmodem",
+				 &atmodem_gprs);
+	gc =3D ofono_gprs_context_create(modem, 0, "atmodem", data->chat);
+
+	if (gprs && gc)
+		ofono_gprs_add_context(gprs, gc);
 }
 =

 static struct ofono_modem_driver huawei_driver =3D {


--===============5818385189236442332==--

