Content-Type: multipart/mixed; boundary="===============7666533473389645452=="
MIME-Version: 1.0
From: Pekka.Pessi@nokia.com
Subject: [PATCH] isi: fix SMS
Date: Wed, 20 Oct 2010 22:39:36 +0300
Message-ID: <1287603576-7031-1-git-send-email-Pekka.Pessi@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7666533473389645452==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Pekka Pessi <Pekka.Pessi@nokia.com>

Align read-params with update-params properly.

Align and fill tpdu sub block in submit.
---
 drivers/isimodem/sms.c |   91 +++++++++++++++++++++++++++++++-------------=
---
 1 files changed, 60 insertions(+), 31 deletions(-)

diff --git a/drivers/isimodem/sms.c b/drivers/isimodem/sms.c
index 89cd7d9..319eb54 100644
--- a/drivers/isimodem/sms.c
+++ b/drivers/isimodem/sms.c
@@ -74,9 +74,22 @@ static gboolean sca_query_resp_cb(GIsiClient *client,
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
@@ -88,31 +101,40 @@ static gboolean sca_query_resp_cb(GIsiClient *client,
 	if (msg[3] !=3D SIM_SERV_OK)
 		goto error;
 =

-	if (len  > 3 + sizeof(sd->params))
-		len =3D 3 + sizeof(sd->params);
-	memcpy(&sd->params, msg + 3, len - 3);
-
-	if (sd->params.alphalen > 17)
-		sd->params.alphalen =3D 17;
-	else if (sd->params.alphalen < 1)
-		sd->params.alphalen =3D 1;
-	sd->params.alpha[sd->params.alphalen - 1] =3D '\0';
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
 =

 	/*
 	 * Bitmask indicating absense of parameters --
 	 * If second bit is set it indicates that the SCA is absent
 	 */
-	if (sd->params.absent & 0x2)
+	if (params.absent & 0x2)
 		goto error;
 =

-	bcd =3D sd->params.sca;
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
 	return TRUE;
@@ -285,14 +307,13 @@ static void isi_submit(struct ofono_sms *sms, unsigne=
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
@@ -303,35 +324,43 @@ static void isi_submit(struct ofono_sms *sms, unsigne=
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

-	if (g_isi_vsend(sd->client, iov, use_default ? 2 : 4, SMS_TIMEOUT,
+	if (use_sca) {
+		sca_sb[3] =3D pdu_len - tpdu_len;
+		memcpy(sca_sb + 4, pdu, sca_sb[3]);
+	}
+
+	/* Modem seems to time out SMS_MESSAGE_SEND_REQ in 5 seconds */
+	/* Wait normal timeout plus the modem timeout */
+	if (g_isi_vsend(sd->client, iov, G_N_ELEMENTS(iov), SMS_TIMEOUT + 5,
 			submit_resp_cb, cbd, g_free))
 		return;
 =

-- =

1.7.1


--===============7666533473389645452==--

