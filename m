Content-Type: multipart/mixed; boundary="===============6137924070163248555=="
MIME-Version: 1.0
From: Bing Jupiter <jupiter.hce@gmail.com>
Subject: [PATCH v1 5/5] Use tabs as Denis required
Date: Tue, 23 Feb 2021 15:46:53 +1100
Message-ID: <20210223044653.4933-6-jupiter.hce@gmail.com>
In-Reply-To: <20210223044653.4933-1-jupiter.hce@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6137924070163248555==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Jupiter <jupiter.hce@gmail.com>

---
 drivers/atmodem/vendor.h |  2 +-
 drivers/qmimodem/gprs.c  | 26 +++++++++++++-------------
 plugins/gobi.c           | 14 +++++++-------
 plugins/udevng.c         |  6 +++---
 4 files changed, 24 insertions(+), 24 deletions(-)

diff --git a/drivers/atmodem/vendor.h b/drivers/atmodem/vendor.h
index 38613679..db9fa263 100644
--- a/drivers/atmodem/vendor.h
+++ b/drivers/atmodem/vendor.h
@@ -48,7 +48,7 @@ enum ofono_vendor {
 	OFONO_VENDOR_QUECTEL_EC2X,
 	OFONO_VENDOR_QUECTEL_SERIAL,
 	OFONO_VENDOR_UBLOX,
-    OFONO_VENDOR_UBLOX_SARA_R4,
+	OFONO_VENDOR_UBLOX_SARA_R4,
 	OFONO_VENDOR_XMM,
 	OFONO_VENDOR_GEMALTO,
 };
diff --git a/drivers/qmimodem/gprs.c b/drivers/qmimodem/gprs.c
index 64d90257..90203dd3 100644
--- a/drivers/qmimodem/gprs.c
+++ b/drivers/qmimodem/gprs.c
@@ -36,7 +36,7 @@
 #include "qmimodem.h"
 =

 struct gprs_data {
-    unsigned int vendor;
+	unsigned int vendor;
 	struct qmi_device *dev;
 	struct qmi_service *nas;
 	struct qmi_service *wds;
@@ -286,17 +286,17 @@ static void qmi_set_attached(struct ofono_gprs *gprs,=
 int attached,
 =

 	DBG("attached %d", attached);
 =

-    if (data->vendor =3D=3D OFONO_VENDOR_UBLOX_SARA_R4) {
-        /* This assumes neither 'attach' nor 'detach' are
-         * necessary... if 'attach' is required, then you'll
-         * need to make this section conditional on the action
-         * being 'detach'
-         */
-	    DBG("Debug vendor =3D OFONO_VENDOR_UBLOX_SARA_R4");
-        CALLBACK_WITH_SUCCESS(cb, cbd->data);
-        g_free(cbd);
-        return;
-    }
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
     =

 	if (attached)
 		action =3D QMI_NAS_ATTACH_ACTION_ATTACH;
@@ -420,7 +420,7 @@ static int qmi_gprs_probe(struct ofono_gprs *gprs,
 	DBG("");
 =

 	data =3D g_new0(struct gprs_data, 1);
-    data->vendor =3D vendor;
+	data->vendor =3D vendor;
 =

 	ofono_gprs_set_data(gprs, data);
 =

diff --git a/plugins/gobi.c b/plugins/gobi.c
index 5472dd83..3ca739d6 100644
--- a/plugins/gobi.c
+++ b/plugins/gobi.c
@@ -497,16 +497,16 @@ static void gobi_post_online(struct ofono_modem *mode=
m)
 	struct gobi_data *data =3D ofono_modem_get_data(modem);
 	struct ofono_gprs *gprs;
 	struct ofono_gprs_context *gc;
-    const char* quirk;
-    unsigned int vendor =3D 0;
+	const char* quirk;
+	unsigned int vendor =3D 0;
 =

 	DBG("%p", modem);
 =

-    quirk =3D ofono_modem_get_string(modem, "Quirk");
-    if (quirk) {
-	    DBG("Debug: vendor =3D OFONO_VENDOR_UBLOX_SARA_R4");
-        vendor =3D OFONO_VENDOR_UBLOX_SARA_R4;
-    }
+	quirk =3D ofono_modem_get_string(modem, "Quirk");
+	if (quirk) {
+		DBG("Debug: vendor =3D OFONO_VENDOR_UBLOX_SARA_R4");
+		vendor =3D OFONO_VENDOR_UBLOX_SARA_R4;
+	}
 =

 	if (data->features & GOBI_NAS) {
 		ofono_netreg_create(modem, 0, "qmimodem", data->device);
diff --git a/plugins/udevng.c b/plugins/udevng.c
index 63d95055..9941145f 100644
--- a/plugins/udevng.c
+++ b/plugins/udevng.c
@@ -1224,7 +1224,7 @@ static gboolean setup_ubloxqmi(struct modem_info *mod=
em) {
 =

 	ofono_modem_set_string(modem->modem, "Device", qmi);
 	ofono_modem_set_string(modem->modem, "NetworkInterface", net);
-    ofono_modem_set_string(modem->modem, "Quirk", "SARAR4");
+	ofono_modem_set_string(modem->modem, "Quirk", "SARAR4");
 =

 	DBG("gps=3D%s aux=3D%s", gps, aux);
 =

@@ -1480,7 +1480,7 @@ static struct {
 	{ "quectel",	setup_quectel	},
 	{ "quectelqmi",	setup_quectelqmi},
 	{ "ublox",	setup_ublox	},
-    { "ubloxqmi",   setup_ubloxqmi  },
+	{ "ubloxqmi",   setup_ubloxqmi  },
 	{ "gemalto",	setup_gemalto	},
 	{ "xmm7xxx",	setup_xmm7xxx	},
 	{ "mbim",	setup_mbim	},
@@ -1890,7 +1890,7 @@ static struct {
 	{ "ublox",	"cdc_ncm",	"1546", "110a"	},
 	{ "ublox",	"rndis_host",	"1546", "1146"	},
 	{ "ublox",	"cdc_acm",	"1546", "1146"	},
-    { "ubloxqmi",   "qmi_wwan", "05c6", "90b2"  },
+	{ "ubloxqmi",   "qmi_wwan", "05c6", "90b2"  },
 	{ "gemalto",	"option",	"1e2d",	"0053"	},
 	{ "gemalto",	"cdc_wdm",	"1e2d",	"0053"	},
 	{ "gemalto",	"qmi_wwan",	"1e2d",	"0053"	},
-- =

2.25.1

--===============6137924070163248555==--

