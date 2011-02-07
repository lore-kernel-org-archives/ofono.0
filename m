Content-Type: multipart/mixed; boundary="===============4268139765266638458=="
MIME-Version: 1.0
From: =?unknown-8bit?q?R=C3=A9mi?= Denis-Courmont <remi.denis-courmont@nokia.com>
Subject: [PATCH 7/7] isi: implement set_attach_policy
Date: Mon, 07 Feb 2011 16:03:12 +0200
Message-ID: <1297087392-31030-7-git-send-email-remi.denis-courmont@nokia.com>
In-Reply-To: <201102071602.20179.remi.denis-courmont@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4268139765266638458==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 drivers/isimodem/gprs.c |  131 ++++++++-----------------------------------=
---
 1 files changed, 23 insertions(+), 108 deletions(-)

diff --git a/drivers/isimodem/gprs.c b/drivers/isimodem/gprs.c
index ea90704..ad5a768 100644
--- a/drivers/isimodem/gprs.c
+++ b/drivers/isimodem/gprs.c
@@ -62,6 +62,8 @@ struct gprs_data {
 =

 static void configure_resp_cb(const GIsiMessage *msg, void *opaque)
 {
+	struct isi_cb_data *cbd =3D opaque;
+	ofono_gprs_cb_t cb =3D cbd->cb;
 	const uint8_t *data =3D g_isi_msg_data(msg);
 =

 	if (g_isi_msg_error(msg) < 0) {
@@ -75,26 +77,13 @@ static void configure_resp_cb(const GIsiMessage *msg, v=
oid *opaque)
 	if (g_isi_msg_data_len(msg) < 1)
 		return;
 =

-	if (data[0] !=3D GPDS_OK)
+	if (data[0] !=3D GPDS_OK) {
 		DBG("GPDS configure failed: %s", gpds_status_name(data[0]));
-}
-
-static void set_attach_mode(struct ofono_gprs *gprs, int attached)
-{
-	struct gprs_data *gd =3D ofono_gprs_get_data(gprs);
-
-	const unsigned char msg[] =3D {
-		GPDS_CONFIGURE_REQ,
-		attached ? GPDS_ATTACH_MODE_AUTOMATIC : GPDS_ATTACH_MODE_MANUAL,
-		GPDS_MT_ACT_MODE_REJECT,
-		GPDS_CLASSC_MODE_DEFAULT,
-		GPDS_AOL_CTX_DEFAULT,
-		0x00,
-		0x00
-	};
+		CALLBACK_WITH_FAILURE(cb, cbd->data);
+		return;
+	}
 =

-	g_isi_client_send(gd->client, msg, sizeof(msg),
-				configure_resp_cb, gprs, NULL);
+	CALLBACK_WITH_SUCCESS(cb, cbd->data);
 }
 =

 static void detach_ind_cb(const GIsiMessage *msg, void *opaque)
@@ -114,8 +103,6 @@ static void detach_ind_cb(const GIsiMessage *msg, void =
*opaque)
 	DBG("detached: %s (0x%02"PRIx8")",
 		gpds_isi_cause_name(data[0]), data[0]);
 =

-	set_attach_mode(gprs, FALSE);
-
 	ofono_gprs_detached_notify(gprs);
 }
 =

@@ -324,101 +311,29 @@ static void isi_gprs_remove(struct ofono_gprs *gprs)
 	g_free(gd);
 }
 =

-static void attach_resp_cb(const GIsiMessage *msg, void *opaque)
-{
-	struct isi_cb_data *cbd =3D opaque;
-	ofono_gprs_cb_t cb =3D cbd->cb;
-	const uint8_t *data =3D g_isi_msg_data(msg);
-
-	if (g_isi_msg_error(msg) < 0) {
-		DBG("ISI message error: %d", g_isi_msg_error(msg));
-		goto error;
-	}
-
-	if (g_isi_msg_id(msg) !=3D GPDS_ATTACH_RESP)
-		return;
-
-	if (g_isi_msg_data_len(msg) < 2)
-		goto error;
-
-	if (data[0] !=3D GPDS_OK) {
-		DBG("attach failed: %s", gpds_status_name(data[0]));
-		goto error;
-	}
-
-	set_attach_mode(cbd->user, TRUE);
-
-	CALLBACK_WITH_SUCCESS(cb, cbd->data);
-	return;
-
-error:
-	CALLBACK_WITH_FAILURE(cb, cbd->data);
-}
-
-static void detach_resp_cb(const GIsiMessage *msg, void *opaque)
-{
-	struct isi_cb_data *cbd =3D opaque;
-	ofono_gprs_cb_t cb =3D cbd->cb;
-	const uint8_t *data =3D g_isi_msg_data(msg);
-
-	if (g_isi_msg_error(msg) < 0) {
-		DBG("ISI client error: %d", g_isi_msg_error(msg));
-		goto error;
-	}
-
-	if (g_isi_msg_id(msg) !=3D GPDS_DETACH_RESP)
-		return;
-
-	if (g_isi_msg_data_len(msg) < 2)
-		goto error;
-
-	if (data[0] !=3D GPDS_OK) {
-		DBG("detach failed: %s", gpds_status_name(data[0]));
-		goto error;
-	}
-
-	set_attach_mode(cbd->user, FALSE);
-
-	CALLBACK_WITH_SUCCESS(cb, cbd->data);
-	return;
-
-error:
-	CALLBACK_WITH_FAILURE(cb, cbd->data);
-}
-
-static void isi_gprs_set_attached(struct ofono_gprs *gprs, int attached,
+static void isi_gprs_set_attach_policy(struct ofono_gprs *gprs,
+					ofono_bool_t always_on,
 					ofono_gprs_cb_t cb, void *data)
 {
 	struct gprs_data *gd =3D ofono_gprs_get_data(gprs);
 	struct isi_cb_data *cbd =3D isi_cb_data_new(gprs, cb, data);
+	const unsigned char msg[] =3D {
+		GPDS_CONFIGURE_REQ,
+		always_on ? GPDS_ATTACH_MODE_AUTOMATIC
+				: GPDS_ATTACH_MODE_MANUAL,
+		GPDS_MT_ACT_MODE_REJECT,
+		GPDS_CLASSC_MODE_DEFAULT,
+		GPDS_AOL_CTX_DEFAULT,
+		0x00,
+		0x00
+	};
 =

 	if (cbd =3D=3D NULL || gd =3D=3D NULL)
 		goto error;
 =

-	if (attached) {
-		const unsigned char msg[] =3D {
-			GPDS_ATTACH_REQ,
-			GPDS_FOLLOW_OFF
-		};
-
-		if (g_isi_client_send_with_timeout(gd->client,
-				msg, sizeof(msg),
-				GPDS_ATTACH_TIMEOUT, attach_resp_cb,
-				cbd, g_free))
-			return;
-	} else {
-		const unsigned char msg[] =3D {
-			GPDS_DETACH_REQ,
-			0x00, /* filler */
-			0x00  /* sub-blocks */
-		};
-
-		if (g_isi_client_send_with_timeout(gd->client,
-				msg, sizeof(msg),
-				GPDS_DETACH_TIMEOUT, detach_resp_cb,
-				cbd, g_free))
-			return;
-	}
+	if (g_isi_client_send(gd->client, msg, sizeof(msg),
+				configure_resp_cb, cbd, g_free))
+		return;
 =

 error:
 	CALLBACK_WITH_FAILURE(cb, data);
@@ -493,7 +408,7 @@ static struct ofono_gprs_driver driver =3D {
 	.name			=3D "isimodem",
 	.probe			=3D isi_gprs_probe,
 	.remove			=3D isi_gprs_remove,
-	.set_attached		=3D isi_gprs_set_attached,
+	.set_attach_policy	=3D isi_gprs_set_attach_policy,
 	.attached_status	=3D isi_gprs_attached_status,
 };
 =

-- =

1.7.1


--===============4268139765266638458==--

