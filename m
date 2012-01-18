Content-Type: multipart/mixed; boundary="===============2915799556086241963=="
MIME-Version: 1.0
From: Philippe Nunes <philippe.nunes@linux.intel.com>
Subject: [PATCH v4 5/6] huaweimodem: Add 'serving_system' entry point to get
 SID
Date: Wed, 18 Jan 2012 18:05:16 +0100
Message-ID: <1326906317-11601-6-git-send-email-philippe.nunes@linux.intel.com>
In-Reply-To: <1326906317-11601-1-git-send-email-philippe.nunes@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2915799556086241963==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 drivers/huaweimodem/cdma-netreg.c |  108 +++++++++++++++++++++++++++++++++=
++++
 1 files changed, 108 insertions(+), 0 deletions(-)

diff --git a/drivers/huaweimodem/cdma-netreg.c b/drivers/huaweimodem/cdma-n=
etreg.c
index bf48b53..e9dd3e2 100644
--- a/drivers/huaweimodem/cdma-netreg.c
+++ b/drivers/huaweimodem/cdma-netreg.c
@@ -117,6 +117,66 @@ static void sysinfo_cb(gboolean ok, GAtResult *result,=
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
 static void version_info_cb(const unsigned char *buf, gsize len,
 							gpointer user_data)
 {
@@ -139,6 +199,32 @@ static void version_info_cb(const unsigned char *buf, =
gsize len,
 	DBG("Model: %s\n", verinfo.model);
 	DBG("MSM version: %d\n", verinfo.msm_ver);
 }
+
+static void status_cb(const unsigned char *buf, gsize len, gpointer user_d=
ata)
+{
+	struct ofono_cdma_netreg *netreg =3D user_data;
+	struct netreg_data *nd =3D ofono_cdma_netreg_get_data(netreg);
+	ofono_cdma_netreg_serving_system_cb_t cb =3D nd->cb;
+	char str[6];
+	guint16 sid;
+
+	if (!g_at_qcdm_result_parse_status(buf, len, &sid)) {
+		/* fall back to use +CSS */
+		if (g_at_chat_send(nd->chat, "AT+CSS=3D?", NULL,
+				serving_system_cb, netreg, NULL) > 0)
+			return;
+
+		CALLBACK_WITH_FAILURE(cb, NULL, nd->cb_data);
+		return;
+	}
+
+	snprintf(str, 6, "%d", sid);
+	DBG("Status command response\n");
+	DBG("Serving Identification number: SID %s", str);
+
+	CALLBACK_WITH_SUCCESS(cb, str, nd->cb_data);
+}
+
 static void mode_notify(GAtResult *result, gpointer user_data)
 {
 	struct ofono_cdma_netreg *netreg =3D user_data;
@@ -254,10 +340,32 @@ static void huawei_cdma_netreg_remove(struct ofono_cd=
ma_netreg *netreg)
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
+		if (g_at_qcdm_send(nd->diag, G_AT_QCDM_CMD_STATUS,
+				status_cb, netreg) > 0)
+			return;
+	} else if (g_at_chat_send(nd->chat, "AT+CSS=3D?", NULL,
+					serving_system_cb, netreg, NULL) > 0)
+		return;
+
+	CALLBACK_WITH_FAILURE(cb, NULL, data);
+}
+
 static struct ofono_cdma_netreg_driver driver =3D {
 	.name	=3D "huaweimodem",
 	.probe	=3D huawei_cdma_netreg_probe,
 	.remove	=3D huawei_cdma_netreg_remove,
+	.serving_system =3D huaweicdma_netreg_serving_system,
 };
 =

 void huawei_cdma_netreg_init(void)
-- =

1.7.1


--===============2915799556086241963==--

