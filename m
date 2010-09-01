Content-Type: multipart/mixed; boundary="===============3208645962045264626=="
MIME-Version: 1.0
From: Jeevaka Badrappan <jeevaka.badrappan@elektrobit.com>
Subject: [PATCH 10/11] Changes done as per the changed driver API
Date: Wed, 01 Sep 2010 04:00:35 -0700
Message-ID: <1283338836-13572-10-git-send-email-jeevaka.badrappan@elektrobit.com>
In-Reply-To: <1283338836-13572-1-git-send-email-jeevaka.badrappan@elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3208645962045264626==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 drivers/isimodem/ussd.c |   56 ++++++++++++++++++++++++++++---------------=
---
 1 files changed, 34 insertions(+), 22 deletions(-)

diff --git a/drivers/isimodem/ussd.c b/drivers/isimodem/ussd.c
index d164d10..7ed81f5 100644
--- a/drivers/isimodem/ussd.c
+++ b/drivers/isimodem/ussd.c
@@ -74,7 +74,9 @@ static void ussd_parse(struct ofono_ussd *ussd, const voi=
d *restrict data,
 {
 	const unsigned char *msg =3D data;
 	int status =3D OFONO_USSD_STATUS_NOT_SUPPORTED;
-	char *converted =3D NULL;
+	int msg_len =3D 0;
+	int dcs =3D -1;
+	unsigned char *coded_msg =3D NULL;
 =

 	if (!msg || len < 4)
 		goto out;
@@ -84,14 +86,12 @@ static void ussd_parse(struct ofono_ussd *ussd, const v=
oid *restrict data,
 	if (msg[3] =3D=3D 0 || (size_t)(msg[3] + 4) > len)
 		goto out;
 =

-	converted =3D ussd_decode(msg[1], msg[3], msg + 4);
-
-	if (converted)
-		status =3D OFONO_USSD_STATUS_NOTIFY;
-
+	dcs =3D msg[1];
+	msg_len =3D msg[3];
+	coded_msg =3D g_memdup(msg+4, msg_len);
 out:
-	ofono_ussd_notify(ussd, status, converted);
-	g_free(converted);
+	ofono_ussd_notify(ussd, status, dcs, coded_msg, msg_len);
+	g_free(coded_msg);
 }
 =

 =

@@ -130,8 +130,8 @@ out:
 	return TRUE;
 }
 =

-static GIsiRequest *ussd_send_make(GIsiClient *client, uint8_t *str,
-					size_t len, void *data)
+static GIsiRequest *ussd_send_make(GIsiClient *client, int dcs, uint8_t *s=
tr,
+                    size_t len, void *data)
 {
 	const uint8_t msg[] =3D {
 		SS_GSM_USSD_SEND_REQ,
@@ -139,7 +139,7 @@ static GIsiRequest *ussd_send_make(GIsiClient *client, =
uint8_t *str,
 		0x01,		/* subblock count */
 		SS_GSM_USSD_STRING,
 		4 + len + 3,	/* subblock length */
-		0x0f,		/* DCS */
+		dcs,		/* DCS */
 		len,		/* string length */
 		/* USSD string goes here */
 	};
@@ -153,8 +153,9 @@ static GIsiRequest *ussd_send_make(GIsiClient *client, =
uint8_t *str,
 					ussd_send_resp_cb, data);
 }
 =

-static void isi_request(struct ofono_ussd *ussd, const char *str,
-				ofono_ussd_cb_t cb, void *data)
+static void isi_request(struct ofono_ussd *ussd, int dcs,
+                        const unsigned char *str, int str_len,
+                        ofono_ussd_cb_t cb, void *data)
 {
 	struct ussd_data *ud =3D ofono_ussd_get_data(ussd);
 	struct isi_cb_data *cbd =3D isi_cb_data_new(ussd, cb, data);
@@ -163,24 +164,35 @@ static void isi_request(struct ofono_ussd *ussd, cons=
t char *str,
 	unsigned char *converted =3D NULL;
 	long num_packed;
 	long written;
+	int dcs_value =3D 0x0f; // GSM 7 bit default alphabet
 =

 	if (!cbd)
 		goto error;
 =

-	converted =3D convert_utf8_to_gsm(str, strlen(str), NULL, &written, 0);
-	if (!converted)
-		goto error;
+	if (dcs =3D=3D -1){
+		converted =3D convert_utf8_to_gsm((const char *) str, str_len, NULL, &wr=
itten, 0);
 =

-	packed =3D pack_7bit_own_buf(converted, written, 0, TRUE,
-					&num_packed, 0, buf);
+		if (!converted)
+			goto error;
 =

-	g_free(converted);
+		packed =3D pack_7bit_own_buf(converted, written, 0, TRUE,
+				&num_packed, 0, buf);
 =

-	if (written > SS_MAX_USSD_LENGTH)
+		g_free(converted);
+
+		if (written > SS_MAX_USSD_LENGTH)
 		goto error;
 =

-	if (ussd_send_make(ud->client, packed, num_packed, cbd))
-		return;
+		if (ussd_send_make(ud->client, dcs_value, packed, num_packed, cbd))
+			return;
+	}else{
+		dcs_value =3D dcs;
+		if (str_len > SS_MAX_USSD_LENGTH)
+			goto error;
+
+		if (ussd_send_make(ud->client, dcs_value, (guint8 *) str, str_len, cbd))
+			return;
+    	}
 =

 error:
 	CALLBACK_WITH_FAILURE(cb, data);
-- =

1.7.0.4



----------------------------------------------------------------
Please note: This e-mail may contain confidential information
intended solely for the addressee. If you have received this
e-mail in error, please do not disclose it to anyone, notify
the sender promptly, and delete the message from your system.
Thank you.



----------------------------------------------------------------
Please note: This e-mail may contain confidential information
intended solely for the addressee. If you have received this
e-mail in error, please do not disclose it to anyone, notify
the sender promptly, and delete the message from your system.
Thank you.


--===============3208645962045264626==--

