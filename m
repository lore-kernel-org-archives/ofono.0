Content-Type: multipart/mixed; boundary="===============1644338757049251295=="
MIME-Version: 1.0
From: Pekka.Pessi@nokia.com
Subject: [g_isi_send RFC 3/3] isimodem/ussd: use g_isi_send()
Date: Mon, 30 Aug 2010 19:42:39 +0300
Message-ID: <1283186559-4548-4-git-send-email-Pekka.Pessi@nokia.com>
In-Reply-To: <1283186559-4548-3-git-send-email-Pekka.Pessi@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1644338757049251295==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Pekka Pessi <Pekka.Pessi@nokia.com>

---
 drivers/isimodem/ussd.c |   38 ++++++++++++++------------------------
 1 files changed, 14 insertions(+), 24 deletions(-)

diff --git a/drivers/isimodem/ussd.c b/drivers/isimodem/ussd.c
index 7002d09..7c62e5e 100644
--- a/drivers/isimodem/ussd.c
+++ b/drivers/isimodem/ussd.c
@@ -120,18 +120,17 @@ static gboolean ussd_send_resp_cb(GIsiClient *client,
 	CALLBACK_WITH_SUCCESS(cb, cbd->data);
 =

 	ussd_parse(cbd->user, data, len);
-	goto out;
+	return TRUE;
 =

 error:
 	CALLBACK_WITH_FAILURE(cb, cbd->data);
-
-out:
-	g_free(cbd);
 	return TRUE;
+
 }
 =

-static GIsiRequest *ussd_send_make(GIsiClient *client, uint8_t *str,
-					size_t len, void *data)
+static GIsiRequest *ussd_send(GIsiClient *client,
+				uint8_t *str, size_t len,
+				void *data, GDestroyNotify notify)
 {
 	const uint8_t msg[] =3D {
 		SS_GSM_USSD_SEND_REQ,
@@ -149,23 +148,20 @@ static GIsiRequest *ussd_send_make(GIsiClient *client=
, uint8_t *str,
 		{ str, len }
 	};
 =

-	return g_isi_request_vmake(client, iov, 2, SS_TIMEOUT,
-					ussd_send_resp_cb, data);
+	return g_isi_send(client, iov, 2, SS_TIMEOUT,
+				ussd_send_resp_cb, data, notify);
 }
 =

 static void isi_request(struct ofono_ussd *ussd, const char *str,
 				ofono_ussd_cb_t cb, void *data)
 {
 	struct ussd_data *ud =3D ofono_ussd_get_data(ussd);
-	struct isi_cb_data *cbd =3D isi_cb_data_new(ussd, cb, data);
 	unsigned char buf[256];
 	unsigned char *packed =3D NULL;
 	unsigned char *converted =3D NULL;
 	long num_packed;
 	long written;
-
-	if (!cbd)
-		goto error;
+	struct isi_cb_data *cbd;
 =

 	converted =3D convert_utf8_to_gsm(str, strlen(str), NULL, &written, 0);
 	if (!converted)
@@ -179,12 +175,13 @@ static void isi_request(struct ofono_ussd *ussd, cons=
t char *str,
 	if (written > SS_MAX_USSD_LENGTH)
 		goto error;
 =

-	if (ussd_send_make(ud->client, packed, num_packed, cbd))
+	cbd =3D isi_cb_data_new(ussd, cb, data);
+
+	if (ussd_send(ud->client, packed, num_packed, cbd, g_free))
 		return;
 =

 error:
 	CALLBACK_WITH_FAILURE(cb, data);
-	g_free(cbd);
 }
 =

 static void isi_cancel(struct ofono_ussd *ussd,
@@ -199,16 +196,9 @@ static void isi_cancel(struct ofono_ussd *ussd,
 		0x00 /* subblock count */
 	};
 =

-	if (!cbd)
-		goto error;
-
-	if (g_isi_request_make(ud->client, msg, sizeof(msg), SS_TIMEOUT,
-				ussd_send_resp_cb, cbd))
-		return;
-
-error:
-	CALLBACK_WITH_FAILURE(cb, data);
-	g_free(cbd);
+	if (!g_isi_send(ud->client, msg, sizeof(msg), SS_TIMEOUT,
+			ussd_send_resp_cb, cbd, g_free))
+		CALLBACK_WITH_FAILURE(cb, data);
 }
 =

 static void ussd_ind_cb(GIsiClient *client,
-- =

1.7.0.4


--===============1644338757049251295==--

