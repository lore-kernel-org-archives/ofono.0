Content-Type: multipart/mixed; boundary="===============0683959387537270756=="
MIME-Version: 1.0
From: Pekka.Pessi@nokia.com
Subject: [g_isi_send RFC 2/3] isimodem/gprs: use g_isi_send()
Date: Mon, 30 Aug 2010 19:42:38 +0300
Message-ID: <1283186559-4548-3-git-send-email-Pekka.Pessi@nokia.com>
In-Reply-To: <1283186559-4548-2-git-send-email-Pekka.Pessi@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0683959387537270756==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Pekka Pessi <Pekka.Pessi@nokia.com>

---
 drivers/isimodem/gprs.c |   71 ++++++++++++++++---------------------------=
---
 1 files changed, 25 insertions(+), 46 deletions(-)

diff --git a/drivers/isimodem/gprs.c b/drivers/isimodem/gprs.c
index 7c6a806..ca51f85 100644
--- a/drivers/isimodem/gprs.c
+++ b/drivers/isimodem/gprs.c
@@ -160,19 +160,17 @@ static gboolean attach_resp_cb(GIsiClient *client,
 	if (len !=3D 4 || msg[0] !=3D GPDS_ATTACH_RESP)
 		return FALSE;
 =

-	if (msg[1] !=3D GPDS_OK) {
-		DBG("attach failed: %s", gpds_status_name(msg[1]));
-		goto error;
+	if (msg[1] =3D=3D GPDS_OK) {
+		CALLBACK_WITH_SUCCESS(cb, cbd->data);
+
+		return TRUE;
 	}
 =

-	CALLBACK_WITH_SUCCESS(cb, cbd->data);
-	goto out;
+	DBG("attach failed: %s", gpds_status_name(msg[1]));
 =

 error:
 	CALLBACK_WITH_FAILURE(cb, cbd->data);
 =

-out:
-	g_free(cbd);
 	return TRUE;
 }
 =

@@ -192,34 +190,32 @@ static gboolean detach_resp_cb(GIsiClient *client,
 	if (len !=3D 3 || msg[0] !=3D GPDS_DETACH_RESP)
 		return FALSE;
 =

-	if (msg[1] !=3D GPDS_OK) {
-		DBG("detach failed: %s", gpds_status_name(msg[1]));
-		goto error;
+	if (msg[1] =3D=3D GPDS_OK) {
+		CALLBACK_WITH_SUCCESS(cb, cbd->data);
+
+		return TRUE;
 	}
 =

-	CALLBACK_WITH_SUCCESS(cb, cbd->data);
-	goto out;
+	DBG("detach failed: %s", gpds_status_name(msg[1]));
 =

 error:
 	CALLBACK_WITH_FAILURE(cb, cbd->data);
 =

-out:
-	g_free(cbd);
 	return TRUE;
 }
 =

-static GIsiRequest *attach_request_make(GIsiClient *client, void *data)
+static GIsiRequest *attach_request_send(GIsiClient *client, void *data)
 {
 	const unsigned char msg[] =3D {
 		GPDS_ATTACH_REQ,
 		GPDS_FOLLOW_OFF
 	};
 =

-	return g_isi_request_make(client, msg, sizeof(msg), GPDS_TIMEOUT,
-					attach_resp_cb, data);
+	return g_isi_send(client, msg, sizeof(msg), GPDS_TIMEOUT,
+				attach_resp_cb, data, g_free);
 }
 =

-static GIsiRequest *detach_request_make(GIsiClient *client, void *data)
+static GIsiRequest *detach_request_send(GIsiClient *client, void *data)
 {
 	const unsigned char msg[] =3D {
 		GPDS_DETACH_REQ,
@@ -227,8 +223,8 @@ static GIsiRequest *detach_request_make(GIsiClient *cli=
ent, void *data)
 		0x00  /* sub-blocks */
 	};
 =

-	return g_isi_request_make(client, msg, sizeof(msg), GPDS_TIMEOUT,
-					detach_resp_cb, data);
+	return g_isi_send(client, msg, sizeof(msg), GPDS_TIMEOUT,
+				detach_resp_cb, data, g_free);
 }
 =

 static void isi_gprs_set_attached(struct ofono_gprs *gprs, int attached,
@@ -239,20 +235,13 @@ static void isi_gprs_set_attached(struct ofono_gprs *=
gprs, int attached,
 =

 	GIsiRequest *req;
 =

-	if (!cbd)
-		goto error;
-
 	if (attached)
-		req =3D attach_request_make(gd->client, cbd);
+		req =3D attach_request_send(gd->client, cbd);
 	else
-		req =3D detach_request_make(gd->client, cbd);
-
-	if (req)
-		return;
+		req =3D detach_request_send(gd->client, cbd);
 =

-error:
-	CALLBACK_WITH_FAILURE(cb, data);
-	g_free(cbd);
+	if (!req)
+		CALLBACK_WITH_FAILURE(cb, data);
 }
 =

 static gboolean status_resp_cb(GIsiClient *client,
@@ -287,13 +276,11 @@ static gboolean status_resp_cb(GIsiClient *client,
 =

 	CALLBACK_WITH_SUCCESS(cb, status, cbd->data);
 =

-	goto out;
+	return TRUE;
 =

 error:
 	CALLBACK_WITH_FAILURE(cb, -1, cbd->data);
 =

-out:
-	g_free(cbd);
 	return TRUE;
 }
 =

@@ -302,23 +289,15 @@ static void isi_gprs_attached_status(struct ofono_gpr=
s *gprs,
 						void *data)
 {
 	struct gprs_data *gd =3D ofono_gprs_get_data(gprs);
-	struct isi_cb_data *cbd =3D isi_cb_data_new(NULL, cb, data);
 =

 	const unsigned char msg[] =3D {
 		GPDS_STATUS_REQ,
 	};
 =

-	if (!cbd)
-		goto error;
-
-	if (g_isi_request_make(gd->client, msg, sizeof(msg), GPDS_TIMEOUT,
-					status_resp_cb, cbd))
-		return;
-
-error:
-	CALLBACK_WITH_FAILURE(cb, -1, data);
-	g_free(cbd);
-
+	if (!g_isi_send(gd->client, msg, sizeof(msg), GPDS_TIMEOUT,
+			status_resp_cb,
+			isi_cb_data_new(NULL, cb, data), g_free))
+		CALLBACK_WITH_FAILURE(cb, -1, data);
 }
 =

 static struct ofono_gprs_driver driver =3D {
-- =

1.7.0.4


--===============0683959387537270756==--

