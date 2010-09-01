Content-Type: multipart/mixed; boundary="===============5205125743287487484=="
MIME-Version: 1.0
From: Pekka.Pessi@nokia.com
Subject: [g_isi_send PATCH 2/3] isimodem/gprs: use g_isi_send()
Date: Wed, 01 Sep 2010 14:47:47 +0300
Message-ID: <1283341668-18356-2-git-send-email-Pekka.Pessi@nokia.com>
In-Reply-To: <1283341668-18356-1-git-send-email-Pekka.Pessi@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5205125743287487484==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Pekka Pessi <Pekka.Pessi@nokia.com>

---
 drivers/isimodem/gprs.c |   48 ++++++++++++++++++++-----------------------=
---
 1 files changed, 21 insertions(+), 27 deletions(-)

diff --git a/drivers/isimodem/gprs.c b/drivers/isimodem/gprs.c
index 7c6a806..6f4f686 100644
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
@@ -243,9 +239,9 @@ static void isi_gprs_set_attached(struct ofono_gprs *gp=
rs, int attached,
 		goto error;
 =

 	if (attached)
-		req =3D attach_request_make(gd->client, cbd);
+		req =3D attach_request_send(gd->client, cbd);
 	else
-		req =3D detach_request_make(gd->client, cbd);
+		req =3D detach_request_send(gd->client, cbd);
 =

 	if (req)
 		return;
@@ -287,13 +283,11 @@ static gboolean status_resp_cb(GIsiClient *client,
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

@@ -311,8 +305,8 @@ static void isi_gprs_attached_status(struct ofono_gprs =
*gprs,
 	if (!cbd)
 		goto error;
 =

-	if (g_isi_request_make(gd->client, msg, sizeof(msg), GPDS_TIMEOUT,
-					status_resp_cb, cbd))
+	if (g_isi_send(gd->client, msg, sizeof(msg), GPDS_TIMEOUT,
+			status_resp_cb, cbd, g_free))
 		return;
 =

 error:
-- =

1.7.0.4


--===============5205125743287487484==--

