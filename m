Content-Type: multipart/mixed; boundary="===============6985093457035406017=="
MIME-Version: 1.0
From: Jupiter <jupiter.hce@gmail.com>
Subject: [PATCH v3 3/4] Change 3: Check SARA R4 vendor ID,
 need to make it conditional on the actions being attach and detach
Date: Mon, 22 Feb 2021 20:08:58 +1100
Message-ID: <20210222090859.2883-4-jupiter.hce@gmail.com>
In-Reply-To: <20210222090859.2883-1-jupiter.hce@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6985093457035406017==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: jupiter <jupiter.hce@gmail.com>

---
 drivers/qmimodem/gprs.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/qmimodem/gprs.c b/drivers/qmimodem/gprs.c
index 896a9e4c..64d90257 100644
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
@@ -284,6 +286,18 @@ static void qmi_set_attached(struct ofono_gprs *gprs, =
int attached,
 =

 	DBG("attached %d", attached);
 =

+    if (data->vendor =3D=3D OFONO_VENDOR_UBLOX_SARA_R4) {
+        /* This assumes neither 'attach' nor 'detach' are
+         * necessary... if 'attach' is required, then you'll
+         * need to make this section conditional on the action
+         * being 'detach'
+         */
+	    DBG("Debug vendor =3D OFONO_VENDOR_UBLOX_SARA_R4");
+        CALLBACK_WITH_SUCCESS(cb, cbd->data);
+        g_free(cbd);
+        return;
+    }
+    =

 	if (attached)
 		action =3D QMI_NAS_ATTACH_ACTION_ATTACH;
 	else
@@ -406,6 +420,7 @@ static int qmi_gprs_probe(struct ofono_gprs *gprs,
 	DBG("");
 =

 	data =3D g_new0(struct gprs_data, 1);
+    data->vendor =3D vendor;
 =

 	ofono_gprs_set_data(gprs, data);
 =

-- =

2.17.1

--===============6985093457035406017==--

