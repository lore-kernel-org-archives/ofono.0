Content-Type: multipart/mixed; boundary="===============3301292725698107740=="
MIME-Version: 1.0
From: Guillaume Zajac <guillaume.zajac@linux.intel.com>
Subject: [PATCH_v1 4/4] cdmamodem: Register dormant state callback for huawei
 modems
Date: Thu, 08 Dec 2011 12:00:30 +0100
Message-ID: <1323342030-9175-5-git-send-email-guillaume.zajac@linux.intel.com>
In-Reply-To: <1323342030-9175-1-git-send-email-guillaume.zajac@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3301292725698107740==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 drivers/cdmamodem/connman.c |   42 +++++++++++++++++++++++++++++++++++++++=
+++
 1 files changed, 42 insertions(+), 0 deletions(-)

diff --git a/drivers/cdmamodem/connman.c b/drivers/cdmamodem/connman.c
index ec17e96..f27161b 100644
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

@@ -58,6 +59,7 @@ enum state {
 struct connman_data {
 	GAtChat *chat;
 	GAtPPP *ppp;
+	unsigned int vendor;
 	enum state state;
 	char username[OFONO_CDMA_CONNMAN_MAX_USERNAME_LENGTH + 1];
 	char password[OFONO_CDMA_CONNMAN_MAX_PASSWORD_LENGTH + 1];
@@ -220,9 +222,38 @@ static void cdma_connman_deactivate(struct ofono_cdma_=
connman *cm,
 	g_at_ppp_shutdown(cd->ppp);
 }
 =

+static void huawei_dsdormant_notify(GAtResult *result, gpointer user_data)
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

@@ -232,6 +263,16 @@ static void at_c0_cb(gboolean ok, GAtResult *result, g=
pointer user_data)
 		return;
 	}
 =

+	switch (cd->vendor) {
+	case OFONO_VENDOR_HUAWEI:
+		chat =3D g_at_chat_get_slave(cd->chat);
+		g_at_chat_register(chat, "^DSDORMANT", huawei_dsdormant_notify,
+					FALSE, cm, NULL);
+		break;
+	default:
+		break;
+	}
+
 	ofono_cdma_connman_register(cm);
 }
 =

@@ -254,6 +295,7 @@ static int cdma_connman_probe(struct ofono_cdma_connman=
 *cm,
 		return -ENOMEM;
 =

 	cd->chat =3D g_at_chat_clone(chat);
+	cd->vendor =3D vendor;
 =

 	ofono_cdma_connman_set_data(cm, cd);
 =

-- =

1.7.1


--===============3301292725698107740==--

