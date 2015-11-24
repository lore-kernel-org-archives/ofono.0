Content-Type: multipart/mixed; boundary="===============1370152046535653280=="
MIME-Version: 1.0
From: Tony Espy <espy@canonical.com>
Subject: [PATCH 2/2] unit: add new test-rilmodem-sms test cases
Date: Tue, 24 Nov 2015 14:38:52 -0500
Message-ID: <1448393932-16043-3-git-send-email-espy@canonical.com>
In-Reply-To: <1448393932-16043-1-git-send-email-espy@canonical.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1370152046535653280==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Add new test-rilmodem-sms test cases for the remaining
untested atom functions, including two tests for incoming
SMS unsolicited responses. Also updated test-rilmodem-cs
due to rilmodem-test-server changes.
---
 unit/test-rilmodem-cs.c  |   6 +-
 unit/test-rilmodem-sms.c | 356 +++++++++++++++++++++++++++++++++++++++++++=
++--
 2 files changed, 346 insertions(+), 16 deletions(-)

diff --git a/unit/test-rilmodem-cs.c b/unit/test-rilmodem-cs.c
index e325033..bfa2a72 100644
--- a/unit/test-rilmodem-cs.c
+++ b/unit/test-rilmodem-cs.c
@@ -51,6 +51,7 @@ struct rilmodem_cs_data {
 	struct ofono_modem *modem;
 	gconstpointer test_data;
 	struct ofono_call_settings *cs;
+	struct server_data *serverd;
 };
 =

 typedef gboolean (*StartFunc)(gpointer data);
@@ -476,7 +477,8 @@ static void test_cs_func(gconstpointer data)
 =

 	rcd->test_data =3D csd;
 =

-	rilmodem_test_server_create(&server_connect_cb, &csd->rtd, rcd);
+	rcd->serverd =3D rilmodem_test_server_create(&server_connect_cb,
+							&csd->rtd, rcd);
 =

 	rcd->ril =3D g_ril_new("/tmp/unittestril", OFONO_RIL_VENDOR_AOSP);
 	g_assert(rcd->ril !=3D NULL);
@@ -490,7 +492,7 @@ static void test_cs_func(gconstpointer data)
 	g_ril_unref(rcd->ril);
 	g_free(rcd);
 =

-	rilmodem_test_server_close();
+	rilmodem_test_server_close(rcd->serverd);
 =

 	ril_call_settings_exit();
 }
diff --git a/unit/test-rilmodem-sms.c b/unit/test-rilmodem-sms.c
index 34b6737..ae3b1b3 100644
--- a/unit/test-rilmodem-sms.c
+++ b/unit/test-rilmodem-sms.c
@@ -51,20 +51,24 @@ struct rilmodem_sms_data {
 	struct ofono_modem *modem;
 	gconstpointer test_data;
 	struct ofono_sms *sms;
+	struct server_data *serverd;
 };
 =

 typedef gboolean (*StartFunc)(gpointer data);
 =

 struct sms_data {
 	StartFunc start_func;
-	const struct ofono_phone_number ph;
-	gint param_int1;
-	gint param_int2;
+
+	const unsigned char *pdu;
+	gint pdu_len;
+	gint tpdu_len;
+	gint mms;
 =

 	struct rilmodem_test_data rtd;
 	enum ofono_error_type error_type;
-	gint cb_int1;
-	gint cb_int2;
+
+	const struct ofono_phone_number ph;
+	gint mr;
 };
 =

 static void sca_query_callback(const struct ofono_error *error,
@@ -84,6 +88,28 @@ static void sca_query_callback(const struct ofono_error =
*error,
 	g_main_loop_quit(mainloop);
 }
 =

+static void sca_set_callback(const struct ofono_error *error, gpointer dat=
a)
+{
+	struct rilmodem_sms_data *rsd =3D data;
+	const struct sms_data *sd =3D rsd->test_data;
+
+	g_assert(error->type =3D=3D sd->error_type);
+
+	g_main_loop_quit(mainloop);
+}
+
+static void submit_callback(const struct ofono_error *error, int mr,
+								gpointer data)
+{
+	struct rilmodem_sms_data *rsd =3D data;
+	const struct sms_data *sd =3D rsd->test_data;
+
+	g_assert(error->type =3D=3D sd->error_type);
+	g_assert(mr =3D=3D sd->mr);
+
+	g_main_loop_quit(mainloop);
+}
+
 static gboolean trigger_sca_query(gpointer data)
 {
 	struct rilmodem_sms_data *rsd =3D data;
@@ -94,6 +120,41 @@ static gboolean trigger_sca_query(gpointer data)
 	return FALSE;
 }
 =

+static gboolean trigger_sca_set(gpointer data)
+{
+	struct rilmodem_sms_data *rsd =3D data;
+	const struct sms_data *sd =3D rsd->test_data;
+
+	g_assert(smsdriver->sca_set !=3D NULL);
+	smsdriver->sca_set(rsd->sms, &sd->ph, sca_set_callback, rsd);
+
+	return FALSE;
+}
+
+static gboolean trigger_submit(gpointer data)
+{
+	struct rilmodem_sms_data *rsd =3D data;
+	const struct sms_data *sd =3D rsd->test_data;
+
+	g_assert(smsdriver->submit !=3D NULL);
+
+	smsdriver->submit(rsd->sms, sd->pdu, sd->pdu_len, sd->tpdu_len,
+						sd->mms, submit_callback, rsd);
+
+	return FALSE;
+}
+
+static gboolean trigger_new_sms(gpointer data)
+{
+	struct rilmodem_sms_data *rsd =3D data;
+	const struct sms_data *sd =3D rsd->test_data;
+
+	rilmodem_test_server_write(rsd->serverd, sd->rtd.req_data,
+							sd->rtd.req_size);
+
+	return FALSE;
+}
+
 /* RIL_REQUEST_GET_SMSC_ADDRESS */
 static const guchar req_get_smsc_address_parcel_1[] =3D {
 	0x00, 0x00, 0x00, 0x08, 0x64, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
@@ -103,18 +164,16 @@ static const guchar req_get_smsc_address_parcel_1[] =
=3D {
 /*
  * RIL_REQUEST_GET_SMSC_ADDRESS reply with the following data:
  *
- * {type=3D145,number=3D34607003110}
+ * {number=3D"+34607003110"}
  */
 static const guchar rsp_get_smsc_address_data_1[] =3D {
-	0x12, 0x00, 0x00, 0x00, 0x22, 0x00, 0x2b, 0x00, 0x33, 0x00, 0x34, 0x00,
+	0x0d, 0x00, 0x00, 0x00, 0x22, 0x00, 0x2b, 0x00, 0x33, 0x00, 0x34, 0x00,
 	0x36, 0x00, 0x30, 0x00, 0x37, 0x00, 0x30, 0x00, 0x30, 0x00, 0x33, 0x00,
-	0x31, 0x00, 0x31, 0x00, 0x30, 0x00, 0x22, 0x00, 0x2c, 0x00, 0x31, 0x00,
-	0x34, 0x00, 0x35, 0x00, 0x00, 0x00, 0x00, 0x00
+	0x31, 0x00, 0x31, 0x00, 0x30, 0x00, 0x22, 0x00, 0x00, 0x00, 0x00, 0x00
 };
 =

 static const struct sms_data testdata_sca_query_valid_1 =3D {
 	.start_func =3D trigger_sca_query,
-	.ph =3D { .number =3D "34607003110", .type =3D 145 },
 	.rtd =3D {
 		.req_data =3D req_get_smsc_address_parcel_1,
 		.req_size =3D sizeof(req_get_smsc_address_parcel_1),
@@ -122,16 +181,246 @@ static const struct sms_data testdata_sca_query_vali=
d_1 =3D {
 		.rsp_size =3D sizeof(rsp_get_smsc_address_data_1),
 		.rsp_error =3D RIL_E_SUCCESS,
 	},
-	.cb_int1 =3D 1,
+	.ph =3D { .number =3D "34607003110", .type =3D 145 },
 	.error_type =3D OFONO_ERROR_TYPE_NO_ERROR,
 };
 =

+/*
+ * RIL_REQUEST_GET_SMSC_ADDRESS reply with no data, which should
+ * trigger a callback failure.
+ */
+static const struct sms_data testdata_sca_query_invalid_1 =3D {
+	.start_func =3D trigger_sca_query,
+	.rtd =3D {
+		.req_data =3D req_get_smsc_address_parcel_1,
+		.req_size =3D sizeof(req_get_smsc_address_parcel_1),
+		.rsp_error =3D RIL_E_SUCCESS,
+	},
+	.error_type =3D OFONO_ERROR_TYPE_FAILURE,
+};
+
+/*
+ * RIL_REQUEST_GET_SMSC_ADDRESS reply with no quotes found which
+ * should trigger a callback failure.
+ */
+static const guchar rsp_get_smsc_address_data_3[] =3D {
+	0x02, 0x00, 0x00, 0x00, 0x22, 0x00, 0x22, 0x00, 0x00, 0x00, 0x00, 0x00
+};
+
+static const struct sms_data testdata_sca_query_invalid_2 =3D {
+	.start_func =3D trigger_sca_query,
+	.ph =3D { .number =3D "34607003110", .type =3D 145 },
+	.rtd =3D {
+		.req_data =3D req_get_smsc_address_parcel_1,
+		.req_size =3D sizeof(req_get_smsc_address_parcel_1),
+		.rsp_data =3D rsp_get_smsc_address_data_3,
+		.rsp_size =3D sizeof(rsp_get_smsc_address_data_3),
+		.rsp_error =3D RIL_E_SUCCESS,
+	},
+	.error_type =3D OFONO_ERROR_TYPE_FAILURE,
+};
+
+/* GENERIC_FAILURE returned in RIL reply */
+static const struct sms_data testdata_sca_query_invalid_3 =3D {
+	.start_func =3D trigger_sca_query,
+	.rtd =3D {
+		.req_data =3D req_get_smsc_address_parcel_1,
+		.req_size =3D sizeof(req_get_smsc_address_parcel_1),
+		.rsp_error =3D RIL_E_GENERIC_FAILURE,
+	},
+	.error_type =3D OFONO_ERROR_TYPE_FAILURE,
+};
+
+/*
+ * RIL_REQUEST_SET_SMSC_ADDRESS with the following data:
+ *
+ * {number=3D"+34607003110"}
+ */
+static const guchar req_set_smsc_address_parcel_1[] =3D {
+	0x00, 0x00, 0x00, 0x28, 0x65, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+	0x0c, 0x00, 0x00, 0x00, 0x2b, 0x00, 0x33, 0x00, 0x34, 0x00, 0x36, 0x00,
+	0x30, 0x00, 0x37, 0x00, 0x30, 0x00, 0x30, 0x00, 0x33, 0x00, 0x31, 0x00,
+	0x31, 0x00, 0x30, 0x00, 0x00, 0x00, 0x00, 0x00
+};
+
+static const struct sms_data testdata_sca_set_valid_1 =3D {
+	.start_func =3D trigger_sca_set,
+	.ph =3D { .number =3D "34607003110", .type =3D 145 },
+	.rtd =3D {
+		.req_data =3D req_set_smsc_address_parcel_1,
+		.req_size =3D sizeof(req_set_smsc_address_parcel_1),
+		.rsp_error =3D RIL_E_SUCCESS,
+	},
+	.error_type =3D OFONO_ERROR_TYPE_NO_ERROR,
+};
+
+/* GENERIC_FAILURE returned in RIL reply */
+static const struct sms_data testdata_sca_set_invalid_1 =3D {
+	.start_func =3D trigger_sca_set,
+	.ph =3D { .number =3D "34607003110", .type =3D 145 },
+	.rtd =3D {
+		.req_data =3D req_set_smsc_address_parcel_1,
+		.req_size =3D sizeof(req_set_smsc_address_parcel_1),
+		.rsp_error =3D RIL_E_GENERIC_FAILURE,
+	},
+	.error_type =3D OFONO_ERROR_TYPE_FAILURE,
+};
+
+static const unsigned char req_send_sms_pdu_valid_1[] =3D {
+	0x00, 0x11, 0x00, 0x09, 0x81, 0x36, 0x54, 0x39, 0x80, 0xf5, 0x00, 0x00,
+	0xa7, 0x0a, 0xc8, 0x37, 0x3b, 0x0c, 0x6a, 0xd7, 0xdd, 0xe4, 0x37
+};
+
+static const guchar req_send_sms_parcel_1[] =3D {
+	0x00, 0x00, 0x00, 0x70, 0x19, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+	0x02, 0x00, 0x00, 0x00, 0xff, 0xff, 0xff, 0xff, 0x2c, 0x00, 0x00, 0x00,
+	0x31, 0x00, 0x31, 0x00, 0x30, 0x00, 0x30, 0x00, 0x30, 0x00, 0x39, 0x00,
+	0x38, 0x00, 0x31, 0x00, 0x33, 0x00, 0x36, 0x00, 0x35, 0x00, 0x34, 0x00,
+	0x33, 0x00, 0x39, 0x00, 0x38, 0x00, 0x30, 0x00, 0x46, 0x00, 0x35, 0x00,
+	0x30, 0x00, 0x30, 0x00, 0x30, 0x00, 0x30, 0x00, 0x41, 0x00, 0x37, 0x00,
+	0x30, 0x00, 0x41, 0x00, 0x43, 0x00, 0x38, 0x00, 0x33, 0x00, 0x37, 0x00,
+	0x33, 0x00, 0x42, 0x00, 0x30, 0x00, 0x43, 0x00, 0x36, 0x00, 0x41, 0x00,
+	0x44, 0x00, 0x37, 0x00, 0x44, 0x00, 0x44, 0x00, 0x45, 0x00, 0x34, 0x00,
+	0x33, 0x00, 0x37, 0x00, 0x00, 0x00, 0x00, 0x00
+};
+
+/*
+ * SEND_SMS reply with the following data:
+ *
+ * messageRef=3D1
+ * ackPDU=3DNULL
+ * errorCode=3D0
+ */
+static const guchar rsp_send_sms_valid_1[] =3D {
+	0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,	0x00, 0x00, 0x00, 0x00
+};
+
+static const struct sms_data testdata_submit_valid_1 =3D {
+	.start_func =3D trigger_submit,
+	.pdu =3D req_send_sms_pdu_valid_1,
+	.pdu_len =3D sizeof(req_send_sms_pdu_valid_1),
+	.tpdu_len =3D sizeof(req_send_sms_pdu_valid_1) - 1,
+	.mms =3D 0,
+	.rtd =3D {
+		.req_data =3D req_send_sms_parcel_1,
+		.req_size =3D sizeof(req_send_sms_parcel_1),
+		.rsp_data =3D rsp_send_sms_valid_1,
+		.rsp_size =3D sizeof(rsp_send_sms_valid_1),
+		.rsp_error =3D RIL_E_SUCCESS,
+	},
+	.mr =3D 1,
+	.error_type =3D OFONO_ERROR_TYPE_NO_ERROR,
+};
+
+/*
+ * SEND_SMS reply with failure indicated
+ */
+static const struct sms_data testdata_submit_invalid_1 =3D {
+	.start_func =3D trigger_submit,
+	.pdu =3D req_send_sms_pdu_valid_1,
+	.pdu_len =3D sizeof(req_send_sms_pdu_valid_1),
+	.tpdu_len =3D sizeof(req_send_sms_pdu_valid_1) - 1,
+	.mms =3D 0,
+	.rtd =3D {
+		.req_data =3D req_send_sms_parcel_1,
+		.req_size =3D sizeof(req_send_sms_parcel_1),
+		.rsp_error =3D RIL_E_GENERIC_FAILURE,
+	},
+	.error_type =3D OFONO_ERROR_TYPE_FAILURE,
+};
+
+/*
+ * The following hexadecimal data represents a serialized Binder parcel
+ * instance containing a valid RIL_UNSOL_RESPONSE_NEW_SMS message
+ * with the following parameter (SMSC address length is 7):
+ *
+ * {07914306073011F0040B914336543980F50000310113212002400AC8373B0C6AD7DDE4=
37}
+ * {069143060730F0040B914336543980F50000310113212002400AC8373B0C6AD7DDE437}
+ */
+static const guchar unsol_response_new_sms_parcel_1[] =3D {
+	0x00, 0x00, 0x00, 0xA0, 0x01, 0x00, 0x00, 0x00, 0xEB, 0x03, 0x00, 0x00,
+	0x48, 0x00, 0x00, 0x00, 0x30, 0x00, 0x37, 0x00, 0x39, 0x00, 0x31, 0x00,
+	0x34, 0x00, 0x33, 0x00, 0x30, 0x00, 0x36, 0x00, 0x30, 0x00, 0x37, 0x00,
+	0x33, 0x00, 0x30, 0x00, 0x31, 0x00, 0x31, 0x00, 0x46, 0x00, 0x30, 0x00,
+	0x30, 0x00, 0x34, 0x00, 0x30, 0x00, 0x42, 0x00, 0x39, 0x00, 0x31, 0x00,
+	0x34, 0x00, 0x33, 0x00, 0x33, 0x00, 0x36, 0x00, 0x35, 0x00, 0x34, 0x00,
+	0x33, 0x00, 0x39, 0x00, 0x38, 0x00, 0x30, 0x00, 0x46, 0x00, 0x35, 0x00,
+	0x30, 0x00, 0x30, 0x00, 0x30, 0x00, 0x30, 0x00, 0x33, 0x00, 0x31, 0x00,
+	0x30, 0x00, 0x31, 0x00, 0x31, 0x00, 0x33, 0x00, 0x32, 0x00, 0x31, 0x00,
+	0x32, 0x00, 0x30, 0x00, 0x30, 0x00, 0x32, 0x00, 0x34, 0x00, 0x30, 0x00,
+	0x30, 0x00, 0x41, 0x00, 0x43, 0x00, 0x38, 0x00, 0x33, 0x00, 0x37, 0x00,
+	0x33, 0x00, 0x42, 0x00, 0x30, 0x00, 0x43, 0x00, 0x36, 0x00, 0x41, 0x00,
+	0x44, 0x00, 0x37, 0x00, 0x44, 0x00, 0x44, 0x00, 0x45, 0x00, 0x34, 0x00,
+	0x33, 0x00, 0x37, 0x00, 0x00, 0x00, 0x00, 0x00
+};
+
+const unsigned char new_sms_pdu_valid_1[] =3D {
+	0x07, 0x91, 0x43, 0x06, 0x07, 0x30, 0x11, 0xf0, 0x04, 0x0b, 0x91, 0x43,
+	0x36, 0x54, 0x39, 0x80, 0xf5, 0x00, 0x00, 0x31, 0x01, 0x13, 0x21, 0x20,
+	0x02, 0x40, 0x0a, 0xc8, 0x37, 0x3b, 0x0c, 0x6a, 0xd7, 0xdd, 0xe4, 0x37
+};
+
+static const struct sms_data testdata_new_sms_valid_1 =3D {
+	.start_func =3D trigger_new_sms,
+	.rtd =3D {
+		.req_data =3D unsol_response_new_sms_parcel_1,
+		.req_size =3D sizeof(unsol_response_new_sms_parcel_1),
+		.unsol_test =3D TRUE,
+	},
+	.pdu =3D new_sms_pdu_valid_1,
+	.pdu_len =3D sizeof(new_sms_pdu_valid_1),
+	.tpdu_len =3D 28,
+};
+
+/*
+ * The following hexadecimal data represents a serialized Binder parcel
+ * instance containing a valid UNSOL_RESPONSE_NEW_SMS_STATUS_REPORT message
+ * with the following parameter (SMSC address length is 6):
+ *
+ * {069143060730F0040B914336543980F50000310113212002400AC8373B0C6AD7DDE437}
+ */
+static const guchar unsol_response_new_sms_parcel_2[] =3D {
+	0x00, 0x00, 0x00, 0x9C, 0x01, 0x00, 0x00, 0x00, 0xEC, 0x03, 0x00, 0x00,
+	0x46, 0x00, 0x00, 0x00, 0x30, 0x00, 0x36, 0x00, 0x39, 0x00, 0x31, 0x00,
+	0x34, 0x00, 0x33, 0x00, 0x30, 0x00, 0x36, 0x00, 0x30, 0x00, 0x37, 0x00,
+	0x33, 0x00, 0x30, 0x00, 0x46, 0x00, 0x30, 0x00,	0x30, 0x00, 0x34, 0x00,
+	0x30, 0x00, 0x42, 0x00, 0x39, 0x00, 0x31, 0x00,	0x34, 0x00, 0x33, 0x00,
+	0x33, 0x00, 0x36, 0x00, 0x35, 0x00, 0x34, 0x00,	0x33, 0x00, 0x39, 0x00,
+	0x38, 0x00, 0x30, 0x00, 0x46, 0x00, 0x35, 0x00,	0x30, 0x00, 0x30, 0x00,
+	0x30, 0x00, 0x30, 0x00, 0x33, 0x00, 0x31, 0x00,	0x30, 0x00, 0x31, 0x00,
+	0x31, 0x00, 0x33, 0x00, 0x32, 0x00, 0x31, 0x00,	0x32, 0x00, 0x30, 0x00,
+	0x30, 0x00, 0x32, 0x00, 0x34, 0x00, 0x30, 0x00,	0x30, 0x00, 0x41, 0x00,
+	0x43, 0x00, 0x38, 0x00, 0x33, 0x00, 0x37, 0x00,	0x33, 0x00, 0x42, 0x00,
+	0x30, 0x00, 0x43, 0x00, 0x36, 0x00, 0x41, 0x00,	0x44, 0x00, 0x37, 0x00,
+	0x44, 0x00, 0x44, 0x00, 0x45, 0x00, 0x34, 0x00,	0x33, 0x00, 0x37, 0x00,
+	0x00, 0x00, 0x00, 0x00
+};
+
+const unsigned char new_sms_pdu_valid_2[] =3D {
+	0x06, 0x91, 0x43, 0x06, 0x07, 0x30, 0xf0, 0x04, 0x0b, 0x91, 0x43, 0x36,
+	0x54, 0x39, 0x80, 0xf5, 0x00, 0x00, 0x31, 0x01, 0x13, 0x21, 0x20, 0x02,
+	0x40, 0x0a, 0xc8, 0x37, 0x3b, 0x0c, 0x6a, 0xd7, 0xdd, 0xe4, 0x37
+};
+
+static const struct sms_data testdata_new_sms_valid_2 =3D {
+	.start_func =3D trigger_new_sms,
+	.rtd =3D {
+		.req_data =3D unsol_response_new_sms_parcel_2,
+		.req_size =3D sizeof(unsol_response_new_sms_parcel_2),
+		.unsol_test =3D TRUE,
+	},
+	.pdu =3D new_sms_pdu_valid_2,
+	.pdu_len =3D sizeof(new_sms_pdu_valid_2),
+	.tpdu_len =3D 28,
+};
+
 /* Declarations && Re-implementations of core functions. */
 void ril_sms_exit(void);
 void ril_sms_init(void);
 =

 struct ofono_sms {
 	void *driver_data;
+	const struct sms_data *sd;
 };
 =

 struct ofono_sms *ofono_sms_create(struct ofono_modem *modem,
@@ -178,11 +467,17 @@ void ofono_sms_driver_unregister(const struct ofono_s=
ms_driver *d)
 void ofono_sms_deliver_notify(struct ofono_sms *sms, const unsigned char *=
pdu,
 							int len, int tpdu_len)
 {
+	g_assert(sms->sd->pdu_len =3D=3D len);
+	g_assert(sms->sd->tpdu_len =3D=3D tpdu_len);
+	g_assert(!memcmp(pdu, sms->sd->pdu, len));
+
+	g_main_loop_quit(mainloop);
 }
 =

 void ofono_sms_status_notify(struct ofono_sms *sms, const unsigned char *p=
du,
 							int len, int tpdu_len)
 {
+	ofono_sms_deliver_notify(sms, pdu, len, tpdu_len);
 }
 =

 static void server_connect_cb(gpointer data)
@@ -193,9 +488,14 @@ static void server_connect_cb(gpointer data)
 	/* This causes local impl of _create() to call driver's probe func. */
 	rsd->sms =3D ofono_sms_create(NULL, OFONO_RIL_VENDOR_AOSP,
 							"rilmodem", rsd);
+	rsd->sms->sd =3D sd;
 =

 	/* add_idle doesn't work, read blocks main loop!!! */
-	g_assert(sd->start_func(rsd) =3D=3D FALSE);
+
+	if (sd->rtd.unsol_test)
+		g_idle_add(sd->start_func, (void *) rsd);
+	else
+		g_assert(sd->start_func(rsd) =3D=3D FALSE);
 }
 =

 #if BYTE_ORDER =3D=3D LITTLE_ENDIAN
@@ -220,7 +520,8 @@ static void test_sms_func(gconstpointer data)
 =

 	rsd->test_data =3D sd;
 =

-	rilmodem_test_server_create(&server_connect_cb, &sd->rtd, rsd);
+	rsd->serverd =3D rilmodem_test_server_create(&server_connect_cb,
+								&sd->rtd, rsd);
 =

 	rsd->ril =3D g_ril_new(RIL_SERVER_SOCK_PATH, OFONO_RIL_VENDOR_AOSP);
 	g_assert(rsd->ril !=3D NULL);
@@ -234,7 +535,7 @@ static void test_sms_func(gconstpointer data)
 	g_ril_unref(rsd->ril);
 	g_free(rsd);
 =

-	rilmodem_test_server_close();
+	rilmodem_test_server_close(rsd->serverd);
 =

 	ril_sms_exit();
 }
@@ -255,6 +556,33 @@ int main(int argc, char **argv)
 	g_test_add_data_func("/testrilmodemsms/sca_query/valid/1",
 					&testdata_sca_query_valid_1,
 					test_sms_func);
+	g_test_add_data_func("/testrilmodemsms/sca_query/invalid/1",
+					&testdata_sca_query_invalid_1,
+					test_sms_func);
+	g_test_add_data_func("/testrilmodemsms/sca_query/invalid/2",
+					&testdata_sca_query_invalid_2,
+					test_sms_func);
+	g_test_add_data_func("/testrilmodemsms/sca_query/invalid/3",
+					&testdata_sca_query_invalid_3,
+					test_sms_func);
+	g_test_add_data_func("/testrilmodemsms/sca_set/valid/1",
+					&testdata_sca_set_valid_1,
+					test_sms_func);
+	g_test_add_data_func("/testrilmodemsms/sca_set/invalid/1",
+					&testdata_sca_set_invalid_1,
+					test_sms_func);
+	g_test_add_data_func("/testrilmodemsms/submit/valid/1",
+					&testdata_submit_valid_1,
+					test_sms_func);
+	g_test_add_data_func("/testrilmodemsms/submit/invalid/1",
+					&testdata_submit_invalid_1,
+					test_sms_func);
+	g_test_add_data_func("/testrilmodemsms/new_sms/valid/1",
+					&testdata_new_sms_valid_1,
+					test_sms_func);
+	g_test_add_data_func("/testrilmodemsms/new_sms/valid/2",
+					&testdata_new_sms_valid_2,
+					test_sms_func);
 =

 #endif
 	return g_test_run();
-- =

2.1.4


--===============1370152046535653280==--

