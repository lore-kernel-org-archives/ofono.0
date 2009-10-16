Content-Type: multipart/mixed; boundary="===============4034661983321483621=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH] Parse +CUSD responses.
Date: Fri, 16 Oct 2009 20:12:47 +0200
Message-ID: <1255716767-3807-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4034661983321483621==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Register for "+CUSD:" unsolicited responses, also parse +CUSD
lines appearing as part of response to AT+CUSD (this form is still
used on Nokia phones that emulate AT when connected to a PC, and
both forms are allowed by the spec).  The latter form is treated
differently to make sure the Initiate callback happens before
ofono_ussd_notify is called.

USSD.Initiate still returns a string, this may be wrong because
when the network returns data coded in 8-bits we have no information
on the character set used, everything is "user-specified" for the
8-bit coding in the 23.038 and technically we should return an array
of bytes.  I only handle 7-bit and 8-bit responses, other codings
are not specified and I didn't manage to make the network send me
anything other than 7-bit coded string, although I managed to send a
UCS2-coded USSD string -- the network still only responded with DCS
=3D 15 (but the response content didn't make any sense).  The responses
from my network were always in the local language but with non-ASCII
characters stripped, regardless of the language set in the DCS by me.

I removed the "TODO: be able to send UCS2 string" because the string
we send is first checked to be a valid USSD string so we already know
it can be encoded with GSM 7-bits.
---
 drivers/atmodem/ussd.c |  110 ++++++++++++++++++++++++++++++++++++++++++--=
----
 src/ussd.c             |    3 +
 2 files changed, 100 insertions(+), 13 deletions(-)

diff --git a/drivers/atmodem/ussd.c b/drivers/atmodem/ussd.c
index 1d819a3..e35cf72 100644
--- a/drivers/atmodem/ussd.c
+++ b/drivers/atmodem/ussd.c
@@ -40,39 +40,103 @@
 =

 #include "atmodem.h"
 =

+struct cusd_req {
+	ofono_ussd_cb_t cb;
+	void *data;
+	struct ofono_ussd *ussd;
+};
+
+static const char *cusd_prefix[] =3D { "+CUSD:", NULL };
 static const char *none_prefix[] =3D { NULL };
 =

+static void cusd_parse(GAtResult *result, struct ofono_ussd *ussd)
+{
+	GAtResultIter iter;
+	int status;
+	int dcs;
+	const guint8 *content;
+	int length;
+	char *converted =3D NULL;
+
+	g_at_result_iter_init(&iter, result);
+
+	if (!g_at_result_iter_next(&iter, "+CUSD:"))
+		return;
+
+	if (!g_at_result_iter_next_number(&iter, &status))
+		return;
+
+	if (!g_at_result_iter_next_hexstring(&iter, &content, &length))
+		goto out;
+
+	if (!g_at_result_iter_next_number(&iter, &dcs))
+		goto out;
+
+	/* All 7-bit coding schemes - there's no need to distinguish
+	 * between the different schemes because the modem is tasked
+	 * with presenting us with only raw 7-bit characters.
+	 */
+	if ((dcs & 0xf0) =3D=3D 0x00 || dcs =3D=3D 0x10 || (dcs & 0xf0) =3D=3D 0x=
20 ||
+			(dcs & 0xf0) =3D=3D 0x30 || (dcs & 0xcc) =3D=3D 0x40 ||
+			(dcs & 0xfc) =3D=3D 0x90 || (dcs & 0xf4) =3D=3D 0xf0)
+		converted =3D convert_gsm_to_utf8(content, length,
+						NULL, NULL, 0);
+
+	/* All 8-bit coding schemes - again we can treat all of them
+	 * the same, however we have no information about the character
+	 * set used, for the moment return raw (upper layer will assume
+	 * what we sent it is UTF-8 which may be wrong).
+	 */
+	else if ((dcs & 0xcc) =3D=3D 0x44 || (dcs & 0xfc) =3D=3D 0x94 ||
+			(dcs & 0xf4) =3D=3D 0xf4)
+		converted =3D g_strndup((char *) content, length);
+
+	/* No other encoding is mentioned in TS27007 7.15 */
+	else
+		ofono_error("Unsupported USSD data coding scheme (%02x)", dcs);
+
+out:
+	ofono_ussd_notify(ussd, status, converted);
+
+	if (converted)
+		g_free(converted);
+}
+
 static void cusd_request_cb(gboolean ok, GAtResult *result, gpointer user_=
data)
 {
-	struct cb_data *cbd =3D user_data;
-	ofono_ussd_cb_t cb =3D cbd->cb;
+	struct cusd_req *cbd =3D user_data;
 	struct ofono_error error;
 =

 	dump_response("cusd_request_cb", ok, result);
 	decode_at_error(&error, g_at_result_final_response(result));
 =

-	cb(&error, cbd->data);
+	cbd->cb(&error, cbd->data);
+
+	cusd_parse(result, cbd->ussd);
 }
 =

 static void at_ussd_request(struct ofono_ussd *ussd, const char *str,
 				ofono_ussd_cb_t cb, void *data)
 {
 	GAtChat *chat =3D ofono_ussd_get_data(ussd);
-	struct cb_data *cbd =3D cb_data_new(cb, data);
+	struct cusd_req *cbd =3D g_try_new0(struct cusd_req, 1);
 	unsigned char *converted =3D NULL;
 	int dcs;
 	int max_len;
+	int i;
+	int len;
 	long written;
 	char buf[256];
 =

 	if (!cbd)
 		goto error;
 =

+	cbd->cb =3D cb;
+	cbd->data =3D data;
+	cbd->ussd =3D ussd;
+
 	converted =3D convert_utf8_to_gsm(str, strlen(str), NULL, &written, 0);
 =

-	/* TODO: Be able to convert to UCS2, although the standard does not
-	 * indicate that this is actually possible
-	 */
 	if (!converted)
 		goto error;
 	else {
@@ -83,12 +147,15 @@ static void at_ussd_request(struct ofono_ussd *ussd, c=
onst char *str,
 	if (written > max_len)
 		goto error;
 =

-	sprintf(buf, "AT+CUSD=3D1,\"%*s\",%d", (int) written, converted, dcs);
+	len =3D sprintf(buf, "AT+CUSD=3D1,\"");
+	for (i =3D 0; i < written; i ++)
+		len +=3D sprintf(buf + len, "%02hhx", converted[i]);
+	sprintf(buf + len, "\",%d", dcs);
 =

 	g_free(converted);
 	converted =3D NULL;
 =

-	if (g_at_chat_send(chat, buf, none_prefix,
+	if (g_at_chat_send(chat, buf, cusd_prefix,
 				cusd_request_cb, cbd, g_free) > 0)
 		return;
 =

@@ -133,13 +200,28 @@ error:
 	CALLBACK_WITH_FAILURE(cb, data);
 }
 =

-static gboolean at_ussd_register(gpointer user)
+static void cusd_notify(GAtResult *result, gpointer user_data)
+{
+	struct ofono_ussd *ussd =3D user_data;
+
+	dump_response("cssu_notify", TRUE, result);
+
+	cusd_parse(result, ussd);
+}
+
+static void at_ussd_register(gboolean ok, GAtResult *result, gpointer user)
 {
 	struct ofono_ussd *ussd =3D user;
+	GAtChat *chat =3D ofono_ussd_get_data(ussd);
 =

-	ofono_ussd_register(ussd);
+	if (!ok) {
+		ofono_error("Could not enable CUSD notifications");
+		return;
+	}
+
+	g_at_chat_register(chat, "+CUSD:", cusd_notify, FALSE, ussd, NULL);
 =

-	return FALSE;
+	ofono_ussd_register(ussd);
 }
 =

 static int at_ussd_probe(struct ofono_ussd *ussd, unsigned int vendor,
@@ -148,7 +230,9 @@ static int at_ussd_probe(struct ofono_ussd *ussd, unsig=
ned int vendor,
 	GAtChat *chat =3D data;
 =

 	ofono_ussd_set_data(ussd, chat);
-	g_idle_add(at_ussd_register, ussd);
+
+	g_at_chat_send(chat, "AT+CSCS=3D\"HEX\"", NULL, NULL, NULL, NULL);
+	g_at_chat_send(chat, "AT+CUSD=3D1", NULL, at_ussd_register, ussd, NULL);
 =

 	return 0;
 }
diff --git a/src/ussd.c b/src/ussd.c
index be50296..2bf378d 100644
--- a/src/ussd.c
+++ b/src/ussd.c
@@ -313,6 +313,9 @@ void ofono_ussd_notify(struct ofono_ussd *ussd, int sta=
tus, const char *str)
 =

 		reply =3D dbus_message_new_method_return(ussd->pending);
 =

+		if (!str)
+			str =3D "";
+
 		dbus_message_iter_init_append(reply, &iter);
 =

 		dbus_message_iter_append_basic(&iter, DBUS_TYPE_STRING,
-- =

1.6.1


--===============4034661983321483621==--

