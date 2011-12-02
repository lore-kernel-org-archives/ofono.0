Content-Type: multipart/mixed; boundary="===============2352008857541899289=="
MIME-Version: 1.0
From: Guillaume Zajac <guillaume.zajac@linux.intel.com>
Subject: [PATCH_v0 4/5] cdmamodem: Add bearer recovery into connman driver
Date: Fri, 02 Dec 2011 15:00:53 +0100
Message-ID: <1322834454-451-5-git-send-email-guillaume.zajac@linux.intel.com>
In-Reply-To: <1322834454-451-1-git-send-email-guillaume.zajac@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2352008857541899289==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 drivers/cdmamodem/connman.c |   45 +++++++++++++++++++++++++++++++++++++++=
++++
 1 files changed, 45 insertions(+), 0 deletions(-)

diff --git a/drivers/cdmamodem/connman.c b/drivers/cdmamodem/connman.c
index ec17e96..b5f3d29 100644
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

@@ -66,6 +67,7 @@ struct connman_data {
 		ofono_cdma_connman_up_cb_t up_cb;	/* Up callback */
 	};
 	void *cb_data;					/* Callback data */
+	unsigned int vendor;
 };
 =

 static void ppp_debug(const char *str, void *data)
@@ -220,9 +222,42 @@ static void cdma_connman_deactivate(struct ofono_cdma_=
connman *cm,
 	g_at_ppp_shutdown(cd->ppp);
 }
 =

+static void huawei_mode_notify(GAtResult *result, gpointer user_data)
+{
+	struct ofono_cdma_connman *cm =3D user_data;
+	GAtResultIter iter;
+	int mode;
+	gint bearer;
+
+	g_at_result_iter_init(&iter, result);
+
+	if (!g_at_result_iter_next(&iter, "^MODE:"))
+		return;
+
+	if (!g_at_result_iter_next_number(&iter, &mode))
+		return;
+
+	switch (mode) {
+	case 2:
+		bearer =3D 1;	/* CDMA 1x mode */
+		break;
+	case 4:
+		bearer =3D 2;	/* CDMA EV-DO */
+		break;
+	case 8:
+		bearer =3D 3;	/* CDMA SVDO */
+	default:
+		bearer =3D 0;
+		break;
+	}
+
+	ofono_cdma_connman_bearer_notify(cm, bearer);
+}
+
 static void at_c0_cb(gboolean ok, GAtResult *result, gpointer user_data)
 {
 	struct ofono_cdma_connman *cm =3D user_data;
+	struct connman_data *cd =3D ofono_cdma_connman_get_data(cm);
 =

 	DBG("ok %d", ok);
 =

@@ -232,6 +267,15 @@ static void at_c0_cb(gboolean ok, GAtResult *result, g=
pointer user_data)
 		return;
 	}
 =

+	switch (cd->vendor) {
+	case OFONO_VENDOR_HUAWEI:
+		g_at_chat_register(cd->chat, "^MODE:", huawei_mode_notify,
+						FALSE, cm, NULL);
+		break;
+	default:
+		break;
+	}
+
 	ofono_cdma_connman_register(cm);
 }
 =

@@ -254,6 +298,7 @@ static int cdma_connman_probe(struct ofono_cdma_connman=
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


--===============2352008857541899289==--

