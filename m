Content-Type: multipart/mixed; boundary="===============0131626330370462618=="
MIME-Version: 1.0
From: Bing Jupiter <jupiter.hce@gmail.com>
Subject: [PATCH v1 4/5] Change 4: Add SARA R4 vendor and enable vendor in gprs
 create
Date: Tue, 23 Feb 2021 15:46:52 +1100
Message-ID: <20210223044653.4933-5-jupiter.hce@gmail.com>
In-Reply-To: <20210223044653.4933-1-jupiter.hce@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0131626330370462618==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: jupiter <jupiter.hce@gmail.com>

---
 plugins/gobi.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/plugins/gobi.c b/plugins/gobi.c
index 9b5d7cff..5472dd83 100644
--- a/plugins/gobi.c
+++ b/plugins/gobi.c
@@ -47,6 +47,7 @@
 #include <ofono/location-reporting.h>
 #include <ofono/log.h>
 #include <ofono/message-waiting.h>
+#include <drivers/atmodem/vendor.h>
 =

 #include <drivers/qmimodem/qmi.h>
 #include <drivers/qmimodem/dms.h>
@@ -496,9 +497,17 @@ static void gobi_post_online(struct ofono_modem *modem)
 	struct gobi_data *data =3D ofono_modem_get_data(modem);
 	struct ofono_gprs *gprs;
 	struct ofono_gprs_context *gc;
+    const char* quirk;
+    unsigned int vendor =3D 0;
 =

 	DBG("%p", modem);
 =

+    quirk =3D ofono_modem_get_string(modem, "Quirk");
+    if (quirk) {
+	    DBG("Debug: vendor =3D OFONO_VENDOR_UBLOX_SARA_R4");
+        vendor =3D OFONO_VENDOR_UBLOX_SARA_R4;
+    }
+
 	if (data->features & GOBI_NAS) {
 		ofono_netreg_create(modem, 0, "qmimodem", data->device);
 		ofono_netmon_create(modem, 0, "qmimodem", data->device);
@@ -508,7 +517,7 @@ static void gobi_post_online(struct ofono_modem *modem)
 		ofono_ussd_create(modem, 0, "qmimodem", data->device);
 =

 	if (data->features & GOBI_WDS) {
-		gprs =3D ofono_gprs_create(modem, 0, "qmimodem", data->device);
+		gprs =3D ofono_gprs_create(modem, vendor, "qmimodem", data->device);
 		gc =3D ofono_gprs_context_create(modem, 0, "qmimodem",
 							data->device);
 =

-- =

2.25.1

--===============0131626330370462618==--

