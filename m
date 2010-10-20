Content-Type: multipart/mixed; boundary="===============4525481767704690023=="
MIME-Version: 1.0
From: Pekka.Pessi@nokia.com
Subject: [PATCHv2] isi: fix SMS
Date: Wed, 20 Oct 2010 22:29:54 +0300
Message-ID: <1287602994-6574-1-git-send-email-Pekka.Pessi@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4525481767704690023==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Pekka Pessi <Pekka.Pessi@nokia.com>

Try to avoid overwriting other SMS parameters but SCA address.

Align submit request subblocks.

Use g_isi_(v)send().
---
 drivers/isimodem/sms.c |  162 +++++++++++++++++++++++++++++++-------------=
----
 1 files changed, 105 insertions(+), 57 deletions(-)

diff --git a/drivers/isimodem/sms.c b/drivers/isimodem/sms.c
index d8c617f..e6cf725 100644
--- a/drivers/isimodem/sms.c
+++ b/drivers/isimodem/sms.c
@@ -49,6 +49,18 @@
 struct sms_data {
 	GIsiClient *client;
 	GIsiClient *sim;
+	/* This is a straightforward copy of the EF_smsp structure */
+	struct sim_parameters {
+		uint8_t      absent;
+		uint8_t      tp_pid;
+		uint8_t      tp_dcs;
+		uint8_t      tp_vp;
+		uint8_t      dst[12];
+		uint8_t      sca[12];
+		uint8_t      alphalen;
+		uint8_t      filler[3];
+		uint16_t     alpha[17];
+	} params;
 };
 =

 static gboolean sca_query_resp_cb(GIsiClient *client,
@@ -57,12 +69,27 @@ static gboolean sca_query_resp_cb(GIsiClient *client,
 {
 	const uint8_t *msg =3D data;
 	struct isi_cb_data *cbd =3D opaque;
+	struct ofono_sms *sms =3D cbd->user;
+	struct sms_data *sd =3D ofono_sms_get_data(sms);
 	ofono_sms_sca_query_cb_t cb =3D cbd->cb;
 =

 	struct ofono_phone_number sca;
-	const uint8_t *bcd;
 	uint8_t bcd_len;
 =

+	/* Nicely aligned. */
+	struct {
+		uint8_t      status;
+		uint8_t      absent;
+		uint8_t      tp_pid;
+		uint8_t      tp_dcs;
+		uint8_t      dst[12];
+		uint8_t      sca[12];
+		uint8_t      tp_vp;
+		uint8_t      alphalen;
+		uint8_t      filler[2];
+		uint16_t     alpha[17];
+	} params;
+
 	if (!msg) {
 		DBG("ISI client error: %d", g_isi_client_error(client));
 		goto error;
@@ -74,28 +101,46 @@ static gboolean sca_query_resp_cb(GIsiClient *client,
 	if (msg[3] !=3D SIM_SERV_OK)
 		goto error;
 =

-	/* Bitmask indicating presence of parameters -- second flag
-	 * set is an indicator that the SCA is absent */
-	if (msg[4] & 0x2)
+	memset(&params, 0, sizeof(params));
+	if (len  > 3 + sizeof(params))
+		len =3D 3 + sizeof(params);
+	memcpy(&params, msg + 3, len - 3);
+
+	if (params.alphalen > 17)
+		params.alphalen =3D 17;
+	else if (params.alphalen < 1)
+		params.alphalen =3D 1;
+	params.alpha[params.alphalen - 1] =3D '\0';
+
+	sd->params.absent =3D params.absent;
+	sd->params.tp_pid =3D params.tp_pid;
+	sd->params.tp_dcs =3D params.tp_dcs;
+	sd->params.tp_vp =3D params.tp_vp;
+	memcpy(sd->params.dst, params.dst, sizeof(sd->params.dst));
+	memcpy(sd->params.sca, params.sca, sizeof(sd->params.sca));
+	sd->params.alphalen =3D params.alphalen;
+	memcpy(sd->params.alpha, params.alpha, sizeof(sd->params.alpha));
+
+	/*
+	 * Bitmask indicating absense of parameters --
+	 * If second bit is set it indicates that the SCA is absent
+	 */
+	if (params.absent & 0x2)
 		goto error;
 =

-	bcd =3D msg + 19;
-	bcd_len =3D bcd[0];
+	bcd_len =3D params.sca[0];
 =

 	if (bcd_len <=3D 1 || bcd_len > 12)
 		goto error;
 =

-	extract_bcd_number(bcd + 2, bcd_len - 1, sca.number);
-	sca.type =3D bcd[1];
+	extract_bcd_number(params.sca + 2, bcd_len - 1, sca.number);
+	sca.type =3D 0x80 | params.sca[1];
 =

 	CALLBACK_WITH_SUCCESS(cb, &sca, cbd->data);
-	goto out;
+	return TRUE;
 =

 error:
 	CALLBACK_WITH_FAILURE(cb, NULL, cbd->data);
-
-out:
-	g_free(cbd);
 	return TRUE;
 }
 =

@@ -114,8 +159,8 @@ static void isi_sca_query(struct ofono_sms *sms,
 	if (!cbd || !sd)
 		goto error;
 =

-	if (g_isi_request_make(sd->sim, msg, sizeof(msg), SIM_TIMEOUT,
-				sca_query_resp_cb, cbd))
+	if (g_isi_send(sd->sim, msg, sizeof(msg), SIM_TIMEOUT,
+			sca_query_resp_cb, cbd, g_free))
 		return;
 =

 error:
@@ -143,13 +188,10 @@ static gboolean sca_set_resp_cb(GIsiClient *client,
 		goto error;
 =

 	CALLBACK_WITH_SUCCESS(cb, cbd->data);
-	goto out;
+	return TRUE;
 =

 error:
 	CALLBACK_WITH_FAILURE(cb, cbd->data);
-
-out:
-	g_free(cbd);
 	return TRUE;
 }
 =

@@ -159,33 +201,31 @@ static void isi_sca_set(struct ofono_sms *sms,
 {
 	struct sms_data *sd =3D ofono_sms_get_data(sms);
 	struct isi_cb_data *cbd =3D isi_cb_data_new(sms, cb, data);
+	uint8_t *bcd;
 =

 	uint8_t msg[] =3D {
 		SIM_SMS_REQ,
 		UPDATE_PARAMETER,
 		1,	/* Location, default is 1 */
-		0xFD,	/* Params present, only SCA */
 	};
 =

-	uint8_t filler[40] =3D { 0 };
-	uint8_t bcd[12];
-
-	struct iovec iov[4] =3D {
+	struct iovec iov[] =3D {
 		{ msg, sizeof(msg) },
-		{ filler, 15 },
-		{ bcd, sizeof(bcd) },
-		{ filler, 38 },
+		{ &sd->params, sizeof(sd->params) },
 	};
 =

 	if (!cbd || !sd)
 		goto error;
 =

+	bcd =3D sd->params.sca;
+	sd->params.absent &=3D ~0x02;
+
 	encode_bcd_number(sca->number, bcd + 2);
 	bcd[0] =3D 1 + (strlen(sca->number) + 1) / 2;
-	bcd[1] =3D sca->type & 0xFF;
+	bcd[1] =3D sca->type;
 =

-	if (g_isi_request_vmake(sd->sim, iov, 4, SIM_TIMEOUT,
-				sca_set_resp_cb, cbd))
+	if (g_isi_vsend(sd->sim, iov, G_N_ELEMENTS(iov), SIM_TIMEOUT,
+			sca_set_resp_cb, cbd, g_free))
 		return;
 =

 error:
@@ -253,13 +293,10 @@ static gboolean submit_resp_cb(GIsiClient *client,
 		goto error;
 =

 	CALLBACK_WITH_SUCCESS(cb, mr, cbd->data);
-	goto out;
+	return TRUE;
 =

 error:
 	CALLBACK_WITH_FAILURE(cb, -1, cbd->data);
-
-out:
-	g_free(cbd);
 	return TRUE;
 }
 =

@@ -270,14 +307,13 @@ static void isi_submit(struct ofono_sms *sms, unsigne=
d char *pdu,
 	struct sms_data *sd =3D ofono_sms_get_data(sms);
 	struct isi_cb_data *cbd =3D isi_cb_data_new(sms, cb, data);
 =

-	uint8_t *sca =3D pdu;
-	uint8_t sca_len =3D pdu_len - tpdu_len;
-	uint8_t sca_sb_len =3D 4 + sca_len;
+	uint8_t use_sca =3D pdu_len - tpdu_len !=3D 1 || pdu[0] =3D=3D 0;
 =

-	uint8_t *tpdu =3D pdu + sca_len;
-	uint8_t ud_sb_len =3D 4 + tpdu_len;
+	uint8_t *tpdu =3D pdu + pdu_len - tpdu_len;
+	uint8_t filler_len =3D (-tpdu_len) & 3;
+	uint8_t tpdu_sb_len =3D 4 + tpdu_len + filler_len;
 =

-	uint8_t use_default =3D sca_len =3D=3D 1 && sca[0] =3D=3D 0;
+	uint8_t sca_sb_len =3D use_sca ? 16 : 0;
 =

 	uint8_t msg[] =3D {
 		SMS_MESSAGE_SEND_REQ,
@@ -288,36 +324,44 @@ static void isi_submit(struct ofono_sms *sms, unsigne=
d char *pdu,
 		SMS_TYPE_TEXT_MESSAGE,
 		1,	/* Sub blocks */
 		SMS_GSM_TPDU,
-		4 + ud_sb_len + (use_default ? 0 : sca_sb_len),
+		4 + tpdu_sb_len + sca_sb_len,
 		0,	/* Filler */
-		1 + (use_default ? 0 : 1), /* Sub blocks */
+		use_sca ? 2 : 1,	/* Sub-sub blocks */
 		SMS_COMMON_DATA,
-		ud_sb_len,
+		tpdu_sb_len,
 		tpdu_len,
 		0,	/* Packing required? */
 		/* TPDU */
 	};
 =

-	uint8_t scaddr[] =3D {
+	static uint8_t filler[4];
+
+	uint8_t sca_sb[16] =3D {
 		SMS_ADDRESS,
-		sca_sb_len,
+		16,
 		SMS_GSM_0411_ADDRESS,
-		sca_len,
-		/* SCA */
+		0,
 	};
 =

 	struct iovec iov[4] =3D {
 		{ msg, sizeof(msg) },
 		{ tpdu, tpdu_len },
-		{ scaddr, sizeof(scaddr) },
-		{ sca, sca_len },
+		{ filler, filler_len },
+		{ sca_sb, sca_sb_len },
 	};
 =

 	if (!cbd || !sd)
 		goto error;
 =

-	if (g_isi_request_vmake(sd->client, iov, use_default ? 2 : 4, SMS_TIMEOUT,
-				submit_resp_cb, cbd))
+	if (use_sca) {
+		sca_sb[3] =3D pdu_len - tpdu_len;
+		memcpy(sca_sb + 4, pdu, sca_sb[3]);
+	}
+
+	/* Modem seems to time out SMS_MESSAGE_SEND_REQ in 5 seconds */
+	/* Wait normal timeout plus the modem timeout */
+	if (g_isi_vsend(sd->client, iov, G_N_ELEMENTS(iov), SMS_TIMEOUT + 5,
+			submit_resp_cb, cbd, g_free))
 		return;
 =

 error:
@@ -356,6 +400,7 @@ static gboolean report_resp_cb(GIsiClient *client,
 		return FALSE;
 =

 	DBG("Report resp cause=3D0x%"PRIx8, msg[1]);
+
 	return TRUE;
 }
 =

@@ -378,8 +423,8 @@ static gboolean send_deliver_report(GIsiClient *client,=
 gboolean success)
 		0,		/* Sub blocks */
 	};
 =

-	return g_isi_request_make(client, msg, sizeof(msg), SMS_TIMEOUT,
-					report_resp_cb, NULL) !=3D NULL;
+	return g_isi_send(client, msg, sizeof(msg), SMS_TIMEOUT,
+				report_resp_cb, NULL, NULL) !=3D NULL;
 }
 =

 static void routing_ntf_cb(GIsiClient *client,
@@ -518,13 +563,16 @@ static int isi_sms_probe(struct ofono_sms *sms, unsig=
ned int vendor,
 	if (!data)
 		return -ENOMEM;
 =

+	data->params.absent =3D 0xff;
+	data->params.alphalen =3D 1; /* Includes final UCS2-coded NUL */
+
 	data->client =3D g_isi_client_create(idx, PN_SMS);
 	if (!data->client)
 		return -ENOMEM;
 =

 	data->sim =3D g_isi_client_create(idx, PN_SIM);
 	if (!data->sim) {
-		g_free(data->client);
+		g_isi_client_destroy(data->client);
 		return -ENOMEM;
 	}
 =

@@ -538,8 +586,8 @@ static int isi_sms_probe(struct ofono_sms *sms, unsigne=
d int vendor,
 =

 	g_isi_subscribe(data->client, SMS_MESSAGE_SEND_STATUS_IND,
 			send_status_ind_cb, sms);
-	if (!g_isi_request_make(data->client, msg, sizeof(msg), SMS_TIMEOUT,
-				routing_resp_cb, sms))
+	if (!g_isi_send(data->client, msg, sizeof(msg), SMS_TIMEOUT,
+			routing_resp_cb, sms, NULL))
 		DBG("Failed to set SMS routing.");
 =

 	return 0;
@@ -570,8 +618,8 @@ static void isi_sms_remove(struct ofono_sms *sms)
 	 * Send a promiscuous routing release, so as not to
 	 * hog resources unnecessarily after being removed
 	 */
-	g_isi_request_make(data->client, msg, sizeof(msg),
-				SMS_TIMEOUT, NULL, NULL);
+	g_isi_send(data->client, msg, sizeof(msg),
+			SMS_TIMEOUT, NULL, NULL, NULL);
 	g_isi_client_destroy(data->client);
 	g_isi_client_destroy(data->sim);
 	g_free(data);
-- =

1.7.1


--===============4525481767704690023==--

