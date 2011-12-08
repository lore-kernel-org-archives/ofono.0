Content-Type: multipart/mixed; boundary="===============0151957774316053783=="
MIME-Version: 1.0
From: Philippe Nunes <philippe.nunes@linux.intel.com>
Subject: [PATCH v2 10/12] huaweicdmamodem: Add 'serving_system' entry point to
 get SID
Date: Thu, 08 Dec 2011 15:50:01 +0100
Message-ID: <1323355803-22096-11-git-send-email-philippe.nunes@linux.intel.com>
In-Reply-To: <1323355803-22096-1-git-send-email-philippe.nunes@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0151957774316053783==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 drivers/huaweicdmamodem/network-registration.c |  141 ++++++++++++++++++++=
++++
 1 files changed, 141 insertions(+), 0 deletions(-)

diff --git a/drivers/huaweicdmamodem/network-registration.c b/drivers/huawe=
icdmamodem/network-registration.c
index 2432bf1..8b6378c 100644
--- a/drivers/huaweicdmamodem/network-registration.c
+++ b/drivers/huaweicdmamodem/network-registration.c
@@ -36,8 +36,10 @@
 #include "gatchat.h"
 =

 #include "huaweicdmamodem.h"
+#include <drivers/atmodem/atutil.h>
 =

 #define DIAG_CMD_VERSION_INFO	0	/* Version info */
+#define DIAG_CMD_STATUS		12	/* Station status */
 =

 static const char *sysinfo_prefix[] =3D { "^SYSINFO:", NULL };
 =

@@ -45,6 +47,8 @@ struct netreg_data {
 	GAtChat *chat;
 	GAtHDLC *diag;
 	guint8 cmd;
+	void *cb;
+	void *cb_data;
 };
 =

 struct version_info {
@@ -63,6 +67,32 @@ struct version_info {
 	guint8 unknown;
 } __attribute__ ((packed));
 =

+struct cdma_status {
+	guint8 code;
+	guint8 _unknown[3];
+	guint8 esn[4];
+	guint16 rf_mode;
+	guint8 min1_analog[4];
+	guint8 min1_cdma[4];
+	guint8 min2_analog[2];
+	guint8 min2_cdma[2];
+	guint8 _unknown1;
+	guint16 cdma_rx_state;
+	guint8 good_frames;
+	guint16 analog_corrected_frames;
+	guint16 analog_bad_frames;
+	guint16 analog_word_syncs;
+	guint16 entry_reason;
+	guint16 curr_chan;
+	guint8 cdma_code_chan;
+	guint16 pilot_base;
+	guint16 sid;
+	guint16 nid;
+	guint16 analog_locaid;
+	guint16 analog_rssi;
+	guint8 analog_power;
+} __attribute__ ((packed));
+
 static gboolean parse_sysinfo(GAtResult *result, gint *status)
 {
 	GAtResultIter iter;
@@ -133,6 +163,66 @@ static void sysinfo_cb(gboolean ok, GAtResult *result,=
 gpointer user_data)
 	ofono_cdma_netreg_status_notify(netreg, status);
 }
 =

+static gboolean parse_css(GAtResult *result, const char **sid)
+{
+	GAtResultIter iter;
+	/*
+	* According TIA/EIA/IS-707, CSS query returns <AB>,<SID> but
+	* according TIA/EIA/IS-707-A , it returns <Band_Class>,<Band>,<SID>.
+	* PREV field which has been added afterward is ignored
+	*/
+
+	g_at_result_iter_init(&iter, result);
+
+	g_at_result_iter_next(&iter, NULL);
+
+	/* Skip first field since we are not interested in this */
+	if (!g_at_result_iter_skip_next(&iter))
+		return FALSE;
+
+	if (!g_at_result_iter_next_unquoted_string(&iter, sid))
+		return FALSE;
+	/*
+	* As CSS answer may differ according which revision of TIA/EIA/IS-707
+	* the modem is compliant, we need to check if this field is Band or SID
+	*/
+	if ((*sid[0] >=3D 'A' && *sid[0] <=3D 'F') || (*sid[0] =3D=3D 'Z'))
+		/* This is the band field, the next field is the SID*/
+		if (!g_at_result_iter_next_unquoted_string(&iter, sid))
+			return FALSE;
+
+	if (!strcmp(*sid, "99999"))
+		/* The mobile station is not registered.*/
+		return FALSE;
+
+	return TRUE;
+}
+
+static void serving_system_cb(gboolean ok, GAtResult *result,
+				gpointer user_data)
+{
+	struct cb_data *cbd =3D user_data;
+	ofono_cdma_netreg_serving_system_cb_t cb =3D cbd->cb;
+	struct ofono_error error;
+	const char *sid;
+
+	decode_at_error(&error, g_at_result_final_response(result));
+
+	if (!ok) {
+		cb(&error, NULL, cbd->data);
+		return;
+	}
+
+	if (parse_css(result, &sid) =3D=3D FALSE) {
+		CALLBACK_WITH_FAILURE(cb, NULL, cbd->data);
+		return;
+	}
+
+	DBG("serving system: SID %s", sid);
+
+	cb(&error, sid, cbd->data);
+}
+
 static void send_command(GAtHDLC *hdlc, guint8 cmd)
 {
 	unsigned char cmdbuf[1];
@@ -172,6 +262,35 @@ static void hdlc_receive(const unsigned char *buf, gsi=
ze len, void *user_data)
 		snprintf(str, 9, "%s", verinfo->model);
 		DBG("Model: %s\n", str);
 		DBG("MSM version: %d\n", verinfo->msm_ver);
+	} else if (nd->cmd =3D=3D DIAG_CMD_STATUS) {
+		ofono_cdma_netreg_serving_system_cb_t cb =3D nd->cb;
+		struct cdma_status *status;
+		char str[6];
+
+		if (len < 1 || len > sizeof(struct cdma_status) ||
+				nd->cmd !=3D buf[0]) {
+			/* fall back to use +CSS */
+			if (g_at_chat_send(nd->chat, "AT+CSS=3D?", NULL,
+					serving_system_cb, netreg, NULL) > 0)
+			return;
+
+			CALLBACK_WITH_FAILURE(cb, NULL, nd->cb_data);
+			return;
+		}
+
+		DBG("Status command response\n");
+		status =3D (struct cdma_status *) (buf);
+		DBG("Serving Identification number: SID %d", status->sid);
+		DBG("Network Identification number NID: %d", status->nid);
+
+		/* check if network is registered */
+		if (status->cdma_rx_state =3D=3D 0) {
+			CALLBACK_WITH_FAILURE(cb, NULL, nd->cb_data);
+			return;
+		}
+
+		snprintf(str, 6, "%d", status->sid);
+		CALLBACK_WITH_SUCCESS(cb, str, nd->cb_data);
 	}
 =

 	return;
@@ -294,10 +413,32 @@ static void huaweicdma_netreg_remove(struct ofono_cdm=
a_netreg *netreg)
 	g_free(nd);
 }
 =

+static void huaweicdma_netreg_serving_system(struct ofono_cdma_netreg *net=
reg,
+		ofono_cdma_netreg_serving_system_cb_t cb, void *data)
+{
+	struct netreg_data *nd =3D ofono_cdma_netreg_get_data(netreg);
+
+	nd->cb =3D cb;
+	nd->cb_data =3D data;
+
+	/* First use QCDM port if any */
+	if (nd->diag) {
+		/* Request Station status */
+		nd->cmd =3D 0x0c;
+		send_command(nd->diag, nd->cmd);
+		return;
+	} else if (g_at_chat_send(nd->chat, "AT+CSS=3D?", NULL,
+					serving_system_cb, netreg, NULL) > 0)
+		return;
+
+	CALLBACK_WITH_FAILURE(cb, NULL, data);
+}
+
 static struct ofono_cdma_netreg_driver driver =3D {
 	.name	=3D "huaweicdmamodem",
 	.probe	=3D huaweicdma_netreg_probe,
 	.remove	=3D huaweicdma_netreg_remove,
+	.serving_system =3D huaweicdma_netreg_serving_system,
 };
 =

 void huaweicdma_netreg_init(void)
-- =

1.7.1


--===============0151957774316053783==--

