Content-Type: multipart/mixed; boundary="===============5726548163444075872=="
MIME-Version: 1.0
From: Samrat Guha Niyogi <samrat.guha.niyogi@intel.com>
Subject: [PATCH] rilmodem: Add sms bearer set and bearer query func
Date: Tue, 22 Mar 2016 16:17:56 +0530
Message-ID: <1458643676-18248-1-git-send-email-samrat.guha.niyogi@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5726548163444075872==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Anirudh Gargi <anirudh.gargi@intel.com>

---
 drivers/rilmodem/sms.c    | 148 ++++++++++++++++++++++++++++++++++++++++++=
++--
 drivers/rilmodem/vendor.h |   3 +-
 2 files changed, 144 insertions(+), 7 deletions(-)

diff --git a/drivers/rilmodem/sms.c b/drivers/rilmodem/sms.c
index ea57b84..4b8d07c 100644
--- a/drivers/rilmodem/sms.c
+++ b/drivers/rilmodem/sms.c
@@ -185,6 +185,146 @@ static void ril_submit_sms_cb(struct ril_msg *message=
, gpointer user_data)
 	CALLBACK_WITH_SUCCESS(cb, mr, cbd->data);
 }
 =

+static void imc_sms_bearer_query_cb(struct ril_msg *message,
+					gpointer user_data)
+{
+	struct cb_data *cbd =3D user_data;
+	ofono_sms_bearer_query_cb_t cb =3D cbd->cb;
+	struct parcel rilp;
+	int bearer;
+	char **strv =3D NULL;
+	char *endptr;
+
+	DBG("");
+
+	if (message->error !=3D RIL_E_SUCCESS) {
+		ofono_error("Reply failure: %s",
+				ril_error_to_string(message->error));
+		goto error;
+	}
+
+	/*
+	 * OEM_HOOK_STRINGS response is a char**, representing
+	 * an array of null-terminated UTF-8 strings.
+	 */
+	g_ril_init_parcel(message, &rilp);
+	strv =3D parcel_r_strv(&rilp);
+
+	if (strv =3D=3D NULL){
+		ofono_error("%s: malformed parcel", __func__);
+		goto error;
+	}
+
+	bearer =3D strtoul(strv[0], &endptr, 10);	/* convert to int */
+
+	if (endptr =3D=3D strv[0] || *endptr !=3D '\0') {
+		ofono_error("Convert to Int failed");
+		goto error;
+	}
+
+	g_strfreev(strv);
+
+	CALLBACK_WITH_SUCCESS(cb, bearer, cbd->data);
+	return;
+error:
+
+	if(strv !=3D NULL)
+		g_strfreev(strv);
+
+	CALLBACK_WITH_FAILURE(cb, -1, cbd->data);
+}
+
+static void ril_sms_bearer_query(struct ofono_sms *sms,
+				ofono_sms_bearer_query_cb_t cb, void *user_data)
+{
+	struct sms_data *sd =3D ofono_sms_get_data(sms);
+	struct cb_data *cbd =3D cb_data_new(cb, user_data, sd);
+	struct parcel rilp;
+	int cmd_id;
+	char buf[4];
+
+	DBG("");
+
+	if (sd->vendor =3D=3D OFONO_RIL_VENDOR_IMC_SOFIA3GR) {
+		/*
+		 * OEM_HOOK_STRINGS request is a char **, representing an array
+		 * of null-terminated UTF-8 strings. Here just cmd_id as string.
+		 */
+		parcel_init(&rilp);
+		parcel_w_int32(&rilp, 1);	/* No. of strings */
+
+		/* RIL_OEM_HOOK_STRING_GET_SMS_TRANSPORT_MODE =3D 0x000000A9 */
+		cmd_id =3D 0x000000A9;
+		sprintf(buf, "%d", cmd_id);
+		parcel_w_string(&rilp, buf);
+
+		if (g_ril_send(sd->ril, RIL_REQUEST_OEM_HOOK_STRINGS, &rilp,
+					imc_sms_bearer_query_cb,
+					cbd, g_free) > 0)
+			return;
+	}
+
+	g_free(cbd);
+	CALLBACK_WITH_FAILURE(cb, -1, user_data);
+}
+
+static void imc_set_domain_pref_cb(struct ril_msg *message, void *user_dat=
a)
+{
+	struct cb_data *cbd =3D user_data;
+	ofono_sms_bearer_set_cb_t cb =3D cbd->cb;
+	struct sms_data *sd =3D cbd->user;
+
+	DBG("");
+
+	if (message->error !=3D RIL_E_SUCCESS) {
+		ofono_error("%s RILD reply failure: %s",
+				g_ril_request_id_to_string(sd->ril, message->req),
+				ril_error_to_string(message->error));
+		CALLBACK_WITH_FAILURE(cb, cbd->data);
+		return;
+	}
+
+	CALLBACK_WITH_SUCCESS(cb, cbd->data);
+}
+
+static void ril_sms_bearer_set(struct ofono_sms *sms, int bearer,
+				ofono_sms_bearer_set_cb_t cb, void *user_data)
+{
+	struct sms_data *sd =3D ofono_sms_get_data(sms);
+	struct cb_data *cbd =3D cb_data_new(cb, user_data, sd);
+	struct parcel rilp;
+	int cmd_id;
+	char buf1[4];
+	char buf2[4];
+
+	DBG("Bearer: %d", bearer);
+
+	if (sd->vendor =3D=3D OFONO_RIL_VENDOR_IMC_SOFIA3GR) {
+		/*
+		 * OEM_HOOK_STRINGS request is a char **, representing an array
+		 * of null-terminated UTF-8 strings. Here cmd_id and domain
+		 * to be sent as strings.
+		 */
+		parcel_init(&rilp);
+		parcel_w_int32(&rilp, 2);	/* no. of strings */
+
+		/* RIL_OEM_HOOK_STRING_SET_SMS_TRANSPORT_MODE =3D 0x000000AA */
+		cmd_id =3D 0x000000AA;
+		sprintf(buf1, "%d", cmd_id);
+		parcel_w_string(&rilp, buf1);
+		sprintf(buf2, "%d", bearer);
+		parcel_w_string(&rilp, buf2);
+
+		if (g_ril_send(sd->ril, RIL_REQUEST_OEM_HOOK_STRINGS, &rilp,
+					imc_set_domain_pref_cb,
+					cbd, g_free) > 0)
+			return;
+	}
+
+	g_free(cbd);
+	CALLBACK_WITH_FAILURE(cb, user_data);
+}
+
 static void ril_cmgs(struct ofono_sms *sms, const unsigned char *pdu,
 			int pdu_len, int tpdu_len, int mms,
 			ofono_sms_submit_cb_t cb, void *user_data)
@@ -370,12 +510,8 @@ static struct ofono_sms_driver driver =3D {
 	.sca_set	=3D ril_csca_set,
 	.remove		=3D ril_sms_remove,
 	.submit		=3D ril_cmgs,
-
-	/*
-	 * TODO: investigate/implement:
-	 * .bearer_query  =3D NULL,
-	 * .bearer_set	  =3D NULL,
-	 */
+	.bearer_query   =3D ril_sms_bearer_query,
+	.bearer_set	=3D ril_sms_bearer_set
 };
 =

 void ril_sms_init(void)
diff --git a/drivers/rilmodem/vendor.h b/drivers/rilmodem/vendor.h
index 83cc939..82f6ceb 100644
--- a/drivers/rilmodem/vendor.h
+++ b/drivers/rilmodem/vendor.h
@@ -26,7 +26,8 @@ enum ofono_ril_vendor {
 	OFONO_RIL_VENDOR_AOSP =3D 0,
 	OFONO_RIL_VENDOR_MTK,
 	OFONO_RIL_VENDOR_INFINEON,
-	OFONO_RIL_VENDOR_QCOM_MSIM
+	OFONO_RIL_VENDOR_QCOM_MSIM,
+	OFONO_RIL_VENDOR_IMC_SOFIA3GR
 };
 =

 #endif /* RILMODEM_VENDOR_H */
-- =

1.9.1


--===============5726548163444075872==--

