Content-Type: multipart/mixed; boundary="===============6156880553755715014=="
MIME-Version: 1.0
From: Bing Jupiter <jupiter.hce@gmail.com>
Subject: [PATCH v2 4/4] Make SARA R4 vendor ID conditional being attach and
 detach
Date: Wed, 24 Feb 2021 19:39:24 +1100
Message-ID: <20210224083924.3480-5-jupiter.hce@gmail.com>
In-Reply-To: <20210224083924.3480-1-jupiter.hce@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6156880553755715014==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 drivers/qmimodem/gprs.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/qmimodem/gprs.c b/drivers/qmimodem/gprs.c
index 896a9e4c..90203dd3 100644
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
+	unsigned int vendor;
 	struct qmi_device *dev;
 	struct qmi_service *nas;
 	struct qmi_service *wds;
@@ -284,6 +286,18 @@ static void qmi_set_attached(struct ofono_gprs *gprs, =
int attached,
 =

 	DBG("attached %d", attached);
 =

+	if (data->vendor =3D=3D OFONO_VENDOR_UBLOX_SARA_R4) {
+	/* This assumes neither 'attach' nor 'detach' are
+	 * necessary... if 'attach' is required, then you'll
+	 * need to make this section conditional on the action
+	 * being 'detach'
+	 */
+		DBG("Debug vendor =3D OFONO_VENDOR_UBLOX_SARA_R4");
+		CALLBACK_WITH_SUCCESS(cb, cbd->data);
+		g_free(cbd);
+		return;
+	}
+    =

 	if (attached)
 		action =3D QMI_NAS_ATTACH_ACTION_ATTACH;
 	else
@@ -406,6 +420,7 @@ static int qmi_gprs_probe(struct ofono_gprs *gprs,
 	DBG("");
 =

 	data =3D g_new0(struct gprs_data, 1);
+	data->vendor =3D vendor;
 =

 	ofono_gprs_set_data(gprs, data);
 =

-- =

2.25.1

--===============6156880553755715014==--

