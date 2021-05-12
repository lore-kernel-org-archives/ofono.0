Content-Type: multipart/mixed; boundary="===============7945385512560800117=="
MIME-Version: 1.0
From: Bing Jupiter <jupiter.hce@gmail.com>
Subject: [PATCH v5 3/4] Detect SARA R4 QMI device
Date: Wed, 12 May 2021 17:40:52 +1000
Message-ID: <20210512074053.6718-4-jupiter.hce@gmail.com>
In-Reply-To: <20210512074053.6718-1-jupiter.hce@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7945385512560800117==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 drivers/qmimodem/gprs.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/qmimodem/gprs.c b/drivers/qmimodem/gprs.c
index 896a9e4c..fa20b809 100644
--- a/drivers/qmimodem/gprs.c
+++ b/drivers/qmimodem/gprs.c
@@ -26,6 +26,7 @@
 #include <ofono/log.h>
 #include <ofono/modem.h>
 #include <ofono/gprs.h>
+#include <drivers/atmodem/vendor.h>
 =

 #include "qmi.h"
 #include "nas.h"
@@ -35,6 +36,7 @@
 #include "qmimodem.h"
 =

 struct gprs_data {
+    unsigned int vendor;
 	struct qmi_device *dev;
 	struct qmi_service *nas;
 	struct qmi_service *wds;
@@ -284,6 +286,13 @@ static void qmi_set_attached(struct ofono_gprs *gprs, =
int attached,
 =

 	DBG("attached %d", attached);
 =

+    if (data->vendor =3D=3D OFONO_VENDOR_UBLOX_SARA_R4) {
+	    DBG("Debug vendor =3D OFONO_VENDOR_UBLOX_SARA_R4");
+        CALLBACK_WITH_SUCCESS(cb, cbd->data);
+        g_free(cbd);
+        return;
+    }
+    =

 	if (attached)
 		action =3D QMI_NAS_ATTACH_ACTION_ATTACH;
 	else
@@ -406,6 +415,7 @@ static int qmi_gprs_probe(struct ofono_gprs *gprs,
 	DBG("");
 =

 	data =3D g_new0(struct gprs_data, 1);
+    data->vendor =3D vendor;
 =

 	ofono_gprs_set_data(gprs, data);
 =

-- =

2.25.1

--===============7945385512560800117==--

