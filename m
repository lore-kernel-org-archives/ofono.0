Content-Type: multipart/mixed; boundary="===============0402657701366090632=="
MIME-Version: 1.0
From: Guillaume Zajac <guillaume.zajac@linux.intel.com>
Subject: [PATCH_v0 5/6] cdmamodem: Add dormant notification and dormant
 interval setting
Date: Wed, 07 Dec 2011 17:05:50 +0100
Message-ID: <1323273951-24162-6-git-send-email-guillaume.zajac@linux.intel.com>
In-Reply-To: <1323273951-24162-1-git-send-email-guillaume.zajac@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0402657701366090632==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 drivers/cdmamodem/connman.c |   83 +++++++++++++++++++++++++++++++++++++++=
++++
 1 files changed, 83 insertions(+), 0 deletions(-)

diff --git a/drivers/cdmamodem/connman.c b/drivers/cdmamodem/connman.c
index ec17e96..dade3f2 100644
--- a/drivers/cdmamodem/connman.c
+++ b/drivers/cdmamodem/connman.c
@@ -41,6 +41,7 @@
 #include "gatppp.h"
 =

 #include "cdmamodem.h"
+#include "drivers/atmodem/vendor.h"
 =

 #define TUN_SYSFS_DIR "/sys/devices/virtual/misc/tun"
 =

@@ -58,10 +59,12 @@ enum state {
 struct connman_data {
 	GAtChat *chat;
 	GAtPPP *ppp;
+	unsigned int vendor;
 	enum state state;
 	char username[OFONO_CDMA_CONNMAN_MAX_USERNAME_LENGTH + 1];
 	char password[OFONO_CDMA_CONNMAN_MAX_PASSWORD_LENGTH + 1];
 	union {
+		ofono_cdma_connman_cb_t dormant_interval_cb;
 		ofono_cdma_connman_cb_t down_cb;	/* Down callback */
 		ofono_cdma_connman_up_cb_t up_cb;	/* Up callback */
 	};
@@ -220,9 +223,77 @@ static void cdma_connman_deactivate(struct ofono_cdma_=
connman *cm,
 	g_at_ppp_shutdown(cd->ppp);
 }
 =

+static void cdma_cta_cb(gboolean ok, GAtResult *result, gpointer user_data)
+{
+	struct ofono_cdma_connman *cm =3D user_data;
+	struct connman_data *cd =3D ofono_cdma_connman_get_data(cm);
+	struct ofono_error error;
+
+	decode_at_error(&error, g_at_result_final_response(result));
+
+	if (!ok) {
+		CALLBACK_WITH_FAILURE(cd->dormant_interval_cb, cd->cb_data);
+		return;
+	}
+
+	CALLBACK_WITH_SUCCESS(cd->dormant_interval_cb, cd->cb_data);
+}
+
+static void cdma_connman_set_dormant_interval(struct ofono_cdma_connman *c=
m,
+					int dormant_interval,
+					ofono_cdma_connman_cb_t cb,
+					void *data)
+{
+	struct connman_data *cd =3D ofono_cdma_connman_get_data(cm);
+	GAtChat *chat =3D g_at_chat_get_slave(cd->chat);
+	char buf[256];
+
+	DBG("");
+
+	cd->dormant_interval_cb =3D cb;
+	cd->cb_data =3D data;
+
+	snprintf(buf, sizeof(buf), "AT+CTA=3D%d", dormant_interval);
+
+	if (g_at_chat_send(chat, buf, none_prefix, cdma_cta_cb,
+			cm, NULL) > 0)
+		return;
+
+	CALLBACK_WITH_FAILURE(cb, data);
+}
+
+static void dsdormant_notify(GAtResult *result, gpointer user_data)
+{
+	struct ofono_cdma_connman *cm =3D user_data;
+	int dormant_state;
+	GAtResultIter iter;
+
+	g_at_result_iter_init(&iter, result);
+
+	if (!g_at_result_iter_next(&iter, "^DSDORMANT:"))
+		goto error;
+
+	if (!g_at_result_iter_next_number(&iter, &dormant_state))
+		goto error;
+
+	if (dormant_state =3D=3D 1)
+		ofono_cdma_connman_dormant_state_notify(cm, TRUE);
+	else if (dormant_state =3D=3D 0)
+		ofono_cdma_connman_dormant_state_notify(cm, FALSE);
+	else
+		goto error;
+
+	return;
+
+error:
+	ofono_error("Invalid DSDORMANT value");
+}
+
 static void at_c0_cb(gboolean ok, GAtResult *result, gpointer user_data)
 {
 	struct ofono_cdma_connman *cm =3D user_data;
+	struct connman_data *cd =3D ofono_cdma_connman_get_data(cm);
+	GAtChat *chat;
 =

 	DBG("ok %d", ok);
 =

@@ -232,6 +303,16 @@ static void at_c0_cb(gboolean ok, GAtResult *result, g=
pointer user_data)
 		return;
 	}
 =

+	switch (cd->vendor) {
+	case OFONO_VENDOR_HUAWEI:
+		chat =3D g_at_chat_get_slave(cd->chat);
+		g_at_chat_register(chat, "^DSDORMANT",
+					dsdormant_notify, FALSE, cm, NULL);
+		break;
+	default:
+		break;
+	}
+
 	ofono_cdma_connman_register(cm);
 }
 =

@@ -254,6 +335,7 @@ static int cdma_connman_probe(struct ofono_cdma_connman=
 *cm,
 		return -ENOMEM;
 =

 	cd->chat =3D g_at_chat_clone(chat);
+	cd->vendor =3D vendor;
 =

 	ofono_cdma_connman_set_data(cm, cd);
 =

@@ -285,6 +367,7 @@ static struct ofono_cdma_connman_driver driver =3D {
 	.remove			=3D cdma_connman_remove,
 	.activate		=3D cdma_connman_activate,
 	.deactivate		=3D cdma_connman_deactivate,
+	.set_dormant_interval	=3D cdma_connman_set_dormant_interval,
 };
 =

 void cdma_connman_init(void)
-- =

1.7.1


--===============0402657701366090632==--

