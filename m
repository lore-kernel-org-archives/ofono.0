Content-Type: multipart/mixed; boundary="===============0860268872783767881=="
MIME-Version: 1.0
From: Pekka.Pessi@nokia.com
Subject: [PATCH] isimodem/sms: do not try to save SCA to SIM
Date: Wed, 13 Oct 2010 12:00:27 +0300
Message-ID: <1286960427-2267-1-git-send-email-Pekka.Pessi@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0860268872783767881==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Pekka Pessi <Pekka.Pessi@nokia.com>

It does not make sense to overwrite the SCA on SIM card, especially with
random bytes from the stack.

AT command +CSCA does not write to SIM either, rather it saves the SCA
address to be used with further text mode SMSs.
---
 drivers/isimodem/sms.c |   87 ++++++++++++++++++++------------------------=
----
 1 files changed, 36 insertions(+), 51 deletions(-)

diff --git a/drivers/isimodem/sms.c b/drivers/isimodem/sms.c
index 1d69dbb..aa994bf 100644
--- a/drivers/isimodem/sms.c
+++ b/drivers/isimodem/sms.c
@@ -49,6 +49,8 @@
 struct sms_data {
 	GIsiClient *client;
 	GIsiClient *sim;
+	guint cached_source;
+	struct ofono_phone_number sca;
 };
 =

 static gboolean sca_query_resp_cb(GIsiClient *client,
@@ -57,6 +59,8 @@ static gboolean sca_query_resp_cb(GIsiClient *client,
 {
 	const uint8_t *msg =3D data;
 	struct isi_cb_data *cbd =3D opaque;
+	struct ofono_sms *sms =3D cbd->user;
+	struct sms_data *sd =3D ofono_sms_get_data(sms);
 	ofono_sms_sca_query_cb_t cb =3D cbd->cb;
 =

 	struct ofono_phone_number sca;
@@ -86,7 +90,9 @@ static gboolean sca_query_resp_cb(GIsiClient *client,
 		goto error;
 =

 	extract_bcd_number(bcd + 2, bcd_len - 1, sca.number);
-	sca.type =3D bcd[1];
+	sca.type =3D bcd[1] | 128;
+
+	sd->sca =3D sca;
 =

 	CALLBACK_WITH_SUCCESS(cb, &sca, cbd->data);
 	goto out;
@@ -99,6 +105,21 @@ out:
 	return TRUE;
 }
 =

+static gboolean sca_query_cached_cb(void *opaque)
+{
+	struct isi_cb_data *cbd =3D opaque;
+	struct ofono_sms *sms =3D cbd->user;
+	struct sms_data *sd =3D ofono_sms_get_data(sms);
+	ofono_sms_sca_query_cb_t cb =3D cbd->cb;
+	struct ofono_phone_number sca =3D sd->sca;
+
+	CALLBACK_WITH_SUCCESS(cb, &sca, cbd->data);
+
+	g_free(cbd);
+
+	return FALSE;
+}
+
 static void isi_sca_query(struct ofono_sms *sms,
 				ofono_sms_sca_query_cb_t cb, void *data)
 {
@@ -114,6 +135,11 @@ static void isi_sca_query(struct ofono_sms *sms,
 	if (!cbd)
 		goto error;
 =

+	if (sd->sca.type !=3D 0) {
+		sd->cached_source =3D g_timeout_add(0, sca_query_cached_cb, cbd);
+		return;
+	}
+
 	if (g_isi_request_make(sd->sim, msg, sizeof(msg), SIM_TIMEOUT,
 				sca_query_resp_cb, cbd))
 		return;
@@ -123,34 +149,16 @@ error:
 	g_free(cbd);
 }
 =

-static gboolean sca_set_resp_cb(GIsiClient *client,
-				const void *restrict data, size_t len,
-				uint16_t object, void *opaque)
+static gboolean sca_set_cached_cb(void *opaque)
 {
-	const uint8_t *msg =3D data;
 	struct isi_cb_data *cbd =3D opaque;
 	ofono_sms_sca_set_cb_t cb =3D cbd->cb;
 =

-	if (!msg) {
-		DBG("ISI client error: %d", g_isi_client_error(client));
-		goto error;
-	}
-
-	if (len < 3 || msg[0] !=3D SIM_SMS_RESP || msg[1] !=3D UPDATE_PARAMETER)
-		return FALSE;
-
-	if (msg[2] !=3D SIM_SERV_OK)
-		goto error;
-
 	CALLBACK_WITH_SUCCESS(cb, cbd->data);
-	goto out;
 =

-error:
-	CALLBACK_WITH_FAILURE(cb, cbd->data);
-
-out:
 	g_free(cbd);
-	return TRUE;
+
+	return FALSE;
 }
 =

 static void isi_sca_set(struct ofono_sms *sms,
@@ -160,37 +168,11 @@ static void isi_sca_set(struct ofono_sms *sms,
 	struct sms_data *sd =3D ofono_sms_get_data(sms);
 	struct isi_cb_data *cbd =3D isi_cb_data_new(sms, cb, data);
 =

-	uint8_t msg[] =3D {
-		SIM_SMS_REQ,
-		UPDATE_PARAMETER,
-		1,	/* Location, default is 1 */
-		0xFD,	/* Params present, only SCA */
-	};
-
-	uint8_t filler[40];
-	uint8_t bcd[12];
+	sd->sca =3D *sca;
 =

-	struct iovec iov[4] =3D {
-		{ msg, sizeof(msg) },
-		{ filler, 15 },
-		{ bcd, sizeof(bcd) },
-		{ filler, 38 },
-	};
-
-	if (!cbd)
-		goto error;
+	sd->cached_source =3D g_timeout_add(0, sca_set_cached_cb, cbd);
 =

-	encode_bcd_number(sca->number, bcd + 2);
-	bcd[0] =3D 1 + (strlen(sca->number) + 1) / 2;
-	bcd[1] =3D sca->type;
-
-	if (g_isi_request_vmake(sd->sim, iov, 4, SIM_TIMEOUT,
-				sca_set_resp_cb, cbd))
-		return;
-
-error:
-	CALLBACK_WITH_FAILURE(cb, data);
-	g_free(cbd);
+	return;
 }
 =

 static gboolean submit_resp_cb(GIsiClient *client,
@@ -564,6 +546,9 @@ static void isi_sms_remove(struct ofono_sms *sms)
 	if (!data)
 		return;
 =

+	if (data->cached_source)
+		g_source_remove(data->cached_source);
+
 	if (data->client) {
 		/* Send a promiscuous routing release, so as not to
 		 * hog resources unnecessarily after being removed */
-- =

1.7.0.4


--===============0860268872783767881==--

