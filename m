Content-Type: multipart/mixed; boundary="===============5249192921629652115=="
MIME-Version: 1.0
From: Pekka.Pessi@nokia.com
Subject: [g_isi_send PATCH 3/3] isimodem/ussd: use g_isi_send()
Date: Wed, 01 Sep 2010 14:47:48 +0300
Message-ID: <1283341668-18356-3-git-send-email-Pekka.Pessi@nokia.com>
In-Reply-To: <1283341668-18356-2-git-send-email-Pekka.Pessi@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5249192921629652115==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Pekka Pessi <Pekka.Pessi@nokia.com>

---
 drivers/isimodem/ussd.c |   21 ++++++++++-----------
 1 files changed, 10 insertions(+), 11 deletions(-)

diff --git a/drivers/isimodem/ussd.c b/drivers/isimodem/ussd.c
index 7002d09..0462d57 100644
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
@@ -149,8 +148,8 @@ static GIsiRequest *ussd_send_make(GIsiClient *client, =
uint8_t *str,
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
@@ -179,7 +178,7 @@ static void isi_request(struct ofono_ussd *ussd, const =
char *str,
 	if (written > SS_MAX_USSD_LENGTH)
 		goto error;
 =

-	if (ussd_send_make(ud->client, packed, num_packed, cbd))
+	if (ussd_send(ud->client, packed, num_packed, cbd, g_free))
 		return;
 =

 error:
@@ -202,8 +201,8 @@ static void isi_cancel(struct ofono_ussd *ussd,
 	if (!cbd)
 		goto error;
 =

-	if (g_isi_request_make(ud->client, msg, sizeof(msg), SS_TIMEOUT,
-				ussd_send_resp_cb, cbd))
+	if (g_isi_send(ud->client, msg, sizeof(msg), SS_TIMEOUT,
+			ussd_send_resp_cb, cbd, g_free))
 		return;
 =

 error:
-- =

1.7.0.4


--===============5249192921629652115==--

