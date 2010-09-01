Content-Type: multipart/mixed; boundary="===============8739869456804826728=="
MIME-Version: 1.0
From: Jeevaka Badrappan <jeevaka.badrappan@elektrobit.com>
Subject: [PATCH 02/11] Changes done as per the changed driver API
Date: Wed, 01 Sep 2010 04:00:27 -0700
Message-ID: <1283338836-13572-2-git-send-email-jeevaka.badrappan@elektrobit.com>
In-Reply-To: <1283338836-13572-1-git-send-email-jeevaka.badrappan@elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8739869456804826728==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 drivers/atmodem/ussd.c |   87 +++++++++++++++++++++++++++++---------------=
---
 1 files changed, 54 insertions(+), 33 deletions(-)

diff --git a/drivers/atmodem/ussd.c b/drivers/atmodem/ussd.c
index 1e1fc25..c386fcd 100644
--- a/drivers/atmodem/ussd.c
+++ b/drivers/atmodem/ussd.c
@@ -56,11 +56,12 @@ static void cusd_parse(GAtResult *result, struct ofono_=
ussd *ussd)
 	int status;
 	int dcs;
 	const char *content;
-	char *converted =3D NULL;
 	gboolean udhi;
 	enum sms_charset charset;
 	gboolean compressed;
 	gboolean iso639;
+	unsigned char *msg =3D NULL;
+	int msg_len =3D 0;
 =

 	g_at_result_iter_init(&iter, result);
 =

@@ -83,24 +84,15 @@ static void cusd_parse(GAtResult *result, struct ofono_=
ussd *ussd)
 	} else
 		charset =3D SMS_CHARSET_7BIT;
 =

-	if (charset =3D=3D SMS_CHARSET_7BIT)
-		converted =3D convert_gsm_to_utf8((const guint8 *) content,
-						strlen(content), NULL, NULL, 0);
-
-	else if (charset =3D=3D SMS_CHARSET_8BIT) {
-		/* TODO: Figure out what to do with 8 bit data */
-		ofono_error("8-bit coded USSD response received");
-		status =3D 4; /* Not supported */
-	} else {
-		/* No other encoding is mentioned in TS27007 7.15 */
-		ofono_error("Unsupported USSD data coding scheme (%02x)", dcs);
-		status =3D 4; /* Not supported */
+ out:
+	if (content){
+		msg =3D g_memdup(content, strlen(content));
+		msg_len =3D strlen(content);
 	}
 =

-out:
-	ofono_ussd_notify(ussd, status, converted);
+	ofono_ussd_notify(ussd, status, dcs, msg, msg_len);
 =

-	g_free(converted);
+	g_free(msg);
 }
 =

 static void cusd_request_cb(gboolean ok, GAtResult *result, gpointer user_=
data)
@@ -117,47 +109,76 @@ static void cusd_request_cb(gboolean ok, GAtResult *r=
esult, gpointer user_data)
 	cusd_parse(result, ussd);
 }
 =

-static void at_ussd_request(struct ofono_ussd *ussd, const char *str,
-				ofono_ussd_cb_t cb, void *user_data)
+static void at_ussd_request(struct ofono_ussd *ussd, int dcs,
+                            const unsigned char *str, int str_len,
+                            ofono_ussd_cb_t cb, void *user_data)
 {
 	struct ussd_data *data =3D ofono_ussd_get_data(ussd);
 	struct cb_data *cbd =3D cb_data_new(cb, user_data);
+	int dcs_value =3D 0x0f;  // GSM 7 bit default alphabet
 	unsigned char *converted =3D NULL;
-	int dcs;
-	int max_len;
+	unsigned char *coded_str =3D NULL;
+	long coded_str_len;
+	long num_packed;
 	long written;
 	char buf[256];
+	char *encoded_data =3D NULL;
 =

 	if (!cbd)
 		goto error;
 =

 	cbd->user =3D ussd;
 =

-	converted =3D convert_utf8_to_gsm(str, strlen(str), NULL, &written, 0);
+	if (dcs =3D=3D -1){
+		converted =3D convert_utf8_to_gsm((const char *) str, str_len, NULL, &wr=
itten, 0);
+	=

+		if (!converted)
+			goto error;
+
+		/* As per 3GPP TS 23.038, When this character set is used,
+		 * the characters of the message are packed in octets as shown in sectio=
n 6.1.2.1.1,
+		 * and the message can consist of up to 160 characters.
+		 */
+
+		coded_str =3D pack_7bit(converted, written, 0, TRUE,
+		                      &num_packed, 0);
+
+		g_free(converted);
+		converted =3D NULL;
+		coded_str_len =3D written;
+	}else{
+		coded_str =3D g_memdup(str, str_len);
+		coded_str_len =3D str_len;
+		dcs_value =3D dcs;
+	}
 =

-	if (!converted)
+	if (!coded_str)
 		goto error;
-	else {
-		dcs =3D 15;
-		max_len =3D 182;
-	}
 =

-	if (written > max_len)
+	if (coded_str_len > OFONO_MAX_USSD_LENGTH)
+		goto error;
+
+	encoded_data =3D encode_hex(coded_str, coded_str_len, 0 );
+
+	if (!encoded_data)
 		goto error;
 =

 	snprintf(buf, sizeof(buf), "AT+CUSD=3D1,\"%.*s\",%d",
-			(int) written, converted, dcs);
+        	 strlen(encoded_data), encoded_data, dcs_value);
+
+	g_free(encoded_data);
+	encoded_data =3D NULL;
 =

-	g_free(converted);
-	converted =3D NULL;
+	g_free(coded_str);
+	coded_str =3D NULL;
 =

 	if (data->vendor =3D=3D OFONO_VENDOR_QUALCOMM_MSM) {
 		/* Ensure that the modem is using GSM character set. It
-		 * seems it defaults to IRA and then umlauts are not
+ 		 * seems it defaults to IRA and then umlauts are not
 		 * properly encoded. The modem returns some weird from
 		 * of Latin-1, but it is not really Latin-1 either. */
 		g_at_chat_send(data->chat, "AT+CSCS=3D\"GSM\"", none_prefix,
-							NULL, NULL, NULL);
+					NULL, NULL, NULL);
 	}
 =

 	if (g_at_chat_send(data->chat, buf, cusd_prefix,
@@ -166,7 +187,7 @@ static void at_ussd_request(struct ofono_ussd *ussd, co=
nst char *str,
 =

 error:
 	g_free(cbd);
-	g_free(converted);
+	g_free(coded_str);
 =

 	CALLBACK_WITH_FAILURE(cb, user_data);
 }
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


--===============8739869456804826728==--

