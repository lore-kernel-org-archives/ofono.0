Content-Type: multipart/mixed; boundary="===============3851384352111676342=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH] Use GET RESPONSE sim command to retrieve EF length.
Date: Thu, 18 Jun 2009 05:44:28 +0200
Message-ID: <1245296668-15210-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3851384352111676342==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Also accept 0x9f as a success status word 1 for READ BINARY (GSM specific).

Note that GET RESPONSE doesn't seem to work on on the TI Calypso modems
in OpenMoko phones.  They return the 0x9f status which ETSI says is what
the SIM shall return if GET RESPONSE is not issued immediately after
the command generating the response, which would be the case if the
modem sends some command between SELECT and the GET RESPONSE.  These
modems don't support AT+CSIM either in case we wanted to manually send
the SELECT and the GET RESPONSE.
---
 drivers/atmodem/sim.c |   17 ++++++++++-------
 1 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/drivers/atmodem/sim.c b/drivers/atmodem/sim.c
index 7b41c76..a2aebb8 100644
--- a/drivers/atmodem/sim.c
+++ b/drivers/atmodem/sim.c
@@ -46,8 +46,9 @@ static void at_crsm_len_cb(gboolean ok, GAtResult *result=
, gpointer user_data)
 	struct cb_data *cbd =3D user_data;
 	GAtResultIter iter;
 	ofono_sim_file_len_cb_t cb =3D cbd->cb;
-	gint sw1, len;
 	struct ofono_error error;
+	const guint8 *response;
+	gint sw1, sw2, len;
 =

 	dump_response("at_crsm_len_cb", ok, result);
 	decode_at_error(&error, g_at_result_final_response(result));
@@ -69,16 +70,18 @@ static void at_crsm_len_cb(gboolean ok, GAtResult *resu=
lt, gpointer user_data)
 	g_at_result_iter_next_number(&iter, &sw1);
 	g_at_result_iter_next_number(&iter, &len);
 =

-	ofono_debug("crsm_len_cb: %i, %i", sw1, len);
-
-	if (sw1 !=3D 0x67) {
+	if (!g_at_result_iter_next_hexstring(&iter, &response, &len) ||
+		(sw1 !=3D 0x90 && sw1 !=3D 0x91 && sw1 !=3D 0x92) ||
+		(sw1 =3D=3D 0x90 && sw2 !=3D 0x00) || len < 14) {
 		DECLARE_FAILURE(e);
 =

 		cb(&e, -1, cbd->data);
 		return;
 	}
 =

-	cb(&error, len, cbd->data);
+	ofono_debug("crsm_len_cb: %02x, %02x, %i", sw1, sw2, len);
+
+	cb(&error, (response[2] << 8) | response[3], cbd->data);
 }
 =

 static void at_sim_read_file_len(struct ofono_modem *modem, int fileid,
@@ -92,7 +95,7 @@ static void at_sim_read_file_len(struct ofono_modem *mode=
m, int fileid,
 	if (!cbd)
 		goto error;
 =

-	snprintf(buf, sizeof(buf), "AT+CRSM=3D176,%i,0,0,0", fileid);
+	snprintf(buf, sizeof(buf), "AT+CRSM=3D192,%i,0,0,15", fileid);
 	if (g_at_chat_send(at->parser, buf, crsm_prefix,
 				at_crsm_len_cb, cbd, g_free) > 0)
 		return;
@@ -136,7 +139,7 @@ static void at_crsm_cb(gboolean ok, GAtResult *result, =
gpointer user_data)
 	g_at_result_iter_next_number(&iter, &sw1);
 	g_at_result_iter_next_number(&iter, &sw2);
 	if (!g_at_result_iter_next_hexstring(&iter, &response, &len) ||
-		(sw1 !=3D 0x90 && sw1 !=3D 0x91 && sw1 !=3D 0x92) ||
+		(sw1 !=3D 0x90 && sw1 !=3D 0x91 && sw1 !=3D 0x92 && sw1 !=3D 0x9f) ||
 		(sw1 =3D=3D 0x90 && sw2 !=3D 0x00)) {
 		DECLARE_FAILURE(e);
 =

-- =

1.6.0


--===============3851384352111676342==--

