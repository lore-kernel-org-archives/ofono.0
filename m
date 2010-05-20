Content-Type: multipart/mixed; boundary="===============0907699566439494870=="
MIME-Version: 1.0
From: Kalle Valo <kalle.valo@canonical.com>
Subject: [PATCH v4 3/3] huawei: add gprs context
Date: Thu, 20 May 2010 11:04:21 +0300
Message-ID: <20100520080421.17288.40627.stgit@potku.valot.fi>
In-Reply-To: <20100520080214.17288.7485.stgit@potku.valot.fi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0907699566439494870==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Tested with Huawei E1552 HSDPA USB stick using a finnish Saunalahti prepaid
SIM.
---

 drivers/atmodem/network-registration.c |    4 ++
 plugins/huawei.c                       |   63 ++++++++++++++++++++++++++++=
+++-
 2 files changed, 65 insertions(+), 2 deletions(-)

diff --git a/drivers/atmodem/network-registration.c b/drivers/atmodem/netwo=
rk-registration.c
index ff94160..777b3ee 100644
--- a/drivers/atmodem/network-registration.c
+++ b/drivers/atmodem/network-registration.c
@@ -916,6 +916,10 @@ static void at_creg_set_cb(gboolean ok, GAtResult *res=
ult, gpointer user_data)
 				cind_support_cb, netreg, NULL);
 =

 		break;
+	case OFONO_VENDOR_HUAWEI:
+		/* huawei doesn't support CIND */
+		ofono_netreg_register(netreg);
+		break;
 	default:
 		g_at_chat_send(nd->chat, "AT+CIND=3D?", cind_prefix,
 				cind_support_cb, netreg, NULL);
diff --git a/plugins/huawei.c b/plugins/huawei.c
index 2a95cf6..07e043d 100644
--- a/plugins/huawei.c
+++ b/plugins/huawei.c
@@ -41,7 +41,10 @@
 #include <ofono/gprs.h>
 #include <ofono/voicecall.h>
 #include <ofono/log.h>
+#include <ofono/gprs.h>
+#include <ofono/gprs-context.h>
 =

+#include <drivers/atmodem/atutil.h>
 #include <drivers/atmodem/vendor.h>
 =

 struct huawei_data {
@@ -140,7 +143,7 @@ static int huawei_enable(struct ofono_modem *modem)
 	if (getenv("OFONO_AT_DEBUG"))
 		g_at_chat_set_debug(data->chat, huawei_debug, NULL);
 =

-	data->event =3D create_port(modem_device);
+	data->event =3D create_port(event_device);
 =

 	if (data->event =3D=3D NULL) {
 		g_at_chat_unref(data->chat);
@@ -216,14 +219,70 @@ static void huawei_pre_sim(struct ofono_modem *modem)
 		ofono_sim_inserted_notify(sim, TRUE);
 }
 =

+static void huawei_cgreg_notify(GAtResult *result, gpointer user_data)
+{
+	struct ofono_gprs *gprs =3D user_data;
+	gboolean ret;
+	int status;
+
+	DBG("");
+
+	ret =3D at_util_parse_reg_unsolicited(result, "+CGREG:", &status,
+						NULL, NULL, NULL,
+						OFONO_VENDOR_HUAWEI);
+
+	if (ret =3D=3D FALSE)
+		return;
+
+	ofono_gprs_status_notify(gprs, status);
+}
+
+static void huawei_rssi_notify(GAtResult *result, gpointer user_data)
+{
+	struct ofono_netreg *netreg =3D user_data;
+	GAtResultIter iter;
+	int strength;
+
+	g_at_result_iter_init(&iter, result);
+
+	if (!g_at_result_iter_next(&iter, "^RSSI:"))
+		return;
+
+	if (!g_at_result_iter_next_number(&iter, &strength))
+		return;
+
+	ofono_netreg_strength_notify(netreg,
+				at_util_convert_signal_strength(strength));
+}
+
 static void huawei_post_sim(struct ofono_modem *modem)
 {
 	struct huawei_data *data =3D ofono_modem_get_data(modem);
+	struct ofono_gprs_context *gc;
+	struct ofono_netreg *netreg;
+	struct ofono_gprs *gprs;
 =

 	DBG("%p", modem);
 =

-	ofono_netreg_create(modem, OFONO_VENDOR_HUAWEI, "atmodem", data->chat);
+	netreg =3D ofono_netreg_create(modem, OFONO_VENDOR_HUAWEI, "atmodem",
+					data->chat);
 	ofono_sms_create(modem, OFONO_VENDOR_QUALCOMM_MSM, "atmodem", data->chat);
+
+	gprs =3D ofono_gprs_create(modem, OFONO_VENDOR_HUAWEI, "atmodem",
+					data->chat);
+	gc =3D ofono_gprs_context_create(modem, 0, "atmodem", data->chat);
+
+	if (gprs && gc) {
+		ofono_gprs_add_context(gprs, gc);
+
+		/* huawei has a separate channel for CGREG notifications */
+		g_at_chat_register(data->event, "+CGREG:",
+				huawei_cgreg_notify, FALSE, gprs, NULL);
+
+		/* huawei uses non-standard "^RSSI:18" strings */
+		g_at_chat_register(data->event, "^RSSI:",
+				huawei_rssi_notify, FALSE, netreg, NULL);
+	}
 }
 =

 static struct ofono_modem_driver huawei_driver =3D {


--===============0907699566439494870==--

