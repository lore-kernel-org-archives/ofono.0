Content-Type: multipart/mixed; boundary="===============9169646340680253484=="
MIME-Version: 1.0
From: Pavel Machek <pavel@ucw.cz>
Subject: [rfc] Motorola Droid 4 voice: integrate into atmodem or completely
 separate?
Date: Mon, 12 Aug 2019 10:22:51 +0200
Message-ID: <20190812082251.GA6161@amd>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============9169646340680253484==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi!

Droid 4 has ... something similar to AT commands, but not quite. For
voice calls, I modified atmodem... but I guess there are so many
changes that creating separate motorolamodem/voicecall.c might be
an option? (send_clcc() changes make sense as a cleanup, and were sent
in separate mail.)

Any ideas?

Best regards,
									Pavel

diff --git a/drivers/atmodem/voicecall.c b/drivers/atmodem/voicecall.c
index d55cf00..e22d412 100644
--- a/drivers/atmodem/voicecall.c
+++ b/drivers/atmodem/voicecall.c
@@ -1,4 +1,4 @@
-/*
+/* -*- linux-c -*-
  *
  *  oFono - Open Source Telephony
  *
@@ -264,14 +264,18 @@ poll_again:
 						poll_clcc, vc);
 }
 =

+static void send_clcc(struct voicecall_data *vd, struct ofono_voicecall *v=
c)
+{
+	if (vd->vendor !=3D OFONO_VENDOR_MOTMDM)
+	g_at_chat_send(vd->chat, "AT+CLCC", clcc_prefix, clcc_poll_cb, vc, NULL);
+}
+
 static gboolean poll_clcc(gpointer user_data)
 {
 	struct ofono_voicecall *vc =3D user_data;
 	struct voicecall_data *vd =3D ofono_voicecall_get_data(vc);
 =

-	g_at_chat_send(vd->chat, "AT+CLCC", clcc_prefix,
-				clcc_poll_cb, vc, NULL);
-
+	send_clcc(vd, vc);
 	vd->clcc_source =3D 0;
 =

 	return FALSE;
@@ -297,8 +301,7 @@ static void generic_cb(gboolean ok, GAtResult *result, =
gpointer user_data)
 		}
 	}
 =

-	g_at_chat_send(vd->chat, "AT+CLCC", clcc_prefix,
-			clcc_poll_cb, req->vc, NULL);
+	send_clcc(vd, req->vc);
 =

 	/* We have to callback after we schedule a poll if required */
 	req->cb(&error, req->data);
@@ -316,8 +319,7 @@ static void release_id_cb(gboolean ok, GAtResult *resul=
t,
 	if (ok)
 		vd->local_release =3D 1 << req->id;
 =

-	g_at_chat_send(vd->chat, "AT+CLCC", clcc_prefix,
-			clcc_poll_cb, req->vc, NULL);
+	send_clcc(vd, req->vc);
 =

 	/* We have to callback after we schedule a poll if required */
 	req->cb(&error, req->data);
@@ -408,16 +410,17 @@ static void at_dial(struct ofono_voicecall *vc,
 =

 	switch (clir) {
 	case OFONO_CLIR_OPTION_INVOCATION:
-		strcat(buf, "I");
+		strcat(buf, (vd->vendor !=3D OFONO_VENDOR_MOTMDM) ? "I" : ",0");
 		break;
 	case OFONO_CLIR_OPTION_SUPPRESSION:
-		strcat(buf, "i");
+		strcat(buf, (vd->vendor !=3D OFONO_VENDOR_MOTMDM) ? "i" : ",1");
 		break;
 	default:
 		break;
 	}
 =

-	strcat(buf, ";");
+	if (vd->vendor !=3D OFONO_VENDOR_MOTMDM)
+		strcat(buf, ";");
 =

 	if (g_at_chat_send(vd->chat, buf, atd_prefix,
 				atd_cb, cbd, g_free) > 0)
@@ -462,8 +465,13 @@ static void at_answer(struct ofono_voicecall *vc,
 static void at_hangup(struct ofono_voicecall *vc,
 			ofono_voicecall_cb_t cb, void *data)
 {
+	struct voicecall_data *vd =3D ofono_voicecall_get_data(vc);
+
 	/* Hangup active call */
-	at_template("AT+CHUP", vc, generic_cb, 0x3f, cb, data);
+	if (vd->vendor !=3D OFONO_VENDOR_MOTMDM)
+		at_template("AT+CHUP", vc, generic_cb, 0x3f, cb, data);
+	else
+		at_template("ATH", vc, generic_cb, 0x3f, cb, data);
 }
 =

 static void clcc_cb(gboolean ok, GAtResult *result, gpointer user_data)
@@ -745,6 +753,8 @@ static void clip_notify(GAtResult *result, gpointer use=
r_data)
 	GSList *l;
 	struct ofono_call *call;
 =

+	printf("got clip, searching for incoming calls\n");
+
 	l =3D g_slist_find_custom(vd->calls,
 				GINT_TO_POINTER(CALL_STATUS_INCOMING),
 				at_util_call_compare_by_status);
@@ -759,7 +769,10 @@ static void clip_notify(GAtResult *result, gpointer us=
er_data)
 =

 	g_at_result_iter_init(&iter, result);
 =

-	if (!g_at_result_iter_next(&iter, "+CLIP:"))
+	printf("Got clip...\n");
+
+	if (/* !g_at_result_iter_next(&iter, "+CLIP:") && */
+	    !g_at_result_iter_next(&iter, "~+CLIP=3D"))
 		return;
 =

 	if (!g_at_result_iter_next_string(&iter, &num))
@@ -962,8 +975,7 @@ static void no_carrier_notify(GAtResult *result, gpoint=
er user_data)
 	struct ofono_voicecall *vc =3D user_data;
 	struct voicecall_data *vd =3D ofono_voicecall_get_data(vc);
 =

-	g_at_chat_send(vd->chat, "AT+CLCC", clcc_prefix,
-			clcc_poll_cb, vc, NULL);
+	send_clcc(vd, vc);
 }
 =

 static void no_answer_notify(GAtResult *result, gpointer user_data)
@@ -971,8 +983,7 @@ static void no_answer_notify(GAtResult *result, gpointe=
r user_data)
 	struct ofono_voicecall *vc =3D user_data;
 	struct voicecall_data *vd =3D ofono_voicecall_get_data(vc);
 =

-	g_at_chat_send(vd->chat, "AT+CLCC", clcc_prefix,
-			clcc_poll_cb, vc, NULL);
+	send_clcc(vd, vc);
 }
 =

 static void busy_notify(GAtResult *result, gpointer user_data)
@@ -984,8 +995,7 @@ static void busy_notify(GAtResult *result, gpointer use=
r_data)
 	 * or UDUB on the other side
 	 * TODO: Handle UDUB or other conditions somehow
 	 */
-	g_at_chat_send(vd->chat, "AT+CLCC", clcc_prefix,
-			clcc_poll_cb, vc, NULL);
+	send_clcc(vd, vc);
 }
 =

 static void cssi_notify(GAtResult *result, gpointer user_data)
@@ -1063,6 +1073,61 @@ static void vtd_query_cb(gboolean ok, GAtResult *res=
ult, gpointer user_data)
 		vd->tone_duration =3D duration * 100;
 }
 =

+
+static void ciev_notify(GAtResult *result, gpointer user_data)
+{
+  	struct ofono_voicecall *vc =3D user_data;
+	struct voicecall_data *vd =3D ofono_voicecall_get_data(vc);
+	int strength, ind;
+	GAtResultIter iter;
+	struct ofono_call *call;
+	enum ofono_disconnect_reason reason;
+
+	g_at_result_iter_init(&iter, result);
+
+	printf("Got ciev...\n");
+	if (!g_at_result_iter_next(&iter, "~+CIEV=3D"))
+		return;
+
+	if (!g_at_result_iter_next_number(&iter, &ind))
+		return;
+
+	if (ind !=3D 1)
+		return;
+
+	if (!g_at_result_iter_next_number(&iter, &strength))
+		return;
+
+	printf("Got ciev 1,%d...: \n", strength);
+
+	switch (strength) {
+	case 7: /* outgoing call starts */
+		printf("Outgoing notification, but ATD should have created it for us\n");
+		break;
+	case 4: /* call incoming ringing */
+		printf("Call ringing\n");
+		call =3D create_call(vc, 9, 1, CALL_STATUS_INCOMING, NULL, 128, 2);
+		if (call =3D=3D NULL) {
+			ofono_error("Couldn't create call, call management is fubar!");
+			return;
+		}
+		call->type =3D 0;
+		vd->flags =3D FLAG_NEED_CLIP;
+		/* FIXME: we should really do that at +CLIP callback .. when that works =
*/
+		//ofono_voicecall_notify(vc, call);
+		break;
+	case 0: /* call ends */
+		call =3D vd->calls->data;
+	  =

+		reason =3D OFONO_DISCONNECT_REASON_REMOTE_HANGUP;
+		if (!call->type)
+			ofono_voicecall_disconnected(vc, call->id, reason, NULL);
+
+		printf("Call ends\n"); break;
+	}	   =

+}
+
+
 static void at_voicecall_initialized(gboolean ok, GAtResult *result,
 					gpointer user_data)
 {
@@ -1074,6 +1139,9 @@ static void at_voicecall_initialized(gboolean ok, GAt=
Result *result,
 	g_at_chat_register(vd->chat, "RING", ring_notify, FALSE, vc, NULL);
 	g_at_chat_register(vd->chat, "+CRING:", cring_notify, FALSE, vc, NULL);
 	g_at_chat_register(vd->chat, "+CLIP:", clip_notify, FALSE, vc, NULL);
+	g_at_chat_register(vd->chat, "~+CLIP=3D", clip_notify, FALSE, vc, NULL);
+	g_at_chat_register(vd->chat, "~+CIEV=3D", ciev_notify, FALSE, vc, NULL);
+	=

 	g_at_chat_register(vd->chat, "+CDIP:", cdip_notify, FALSE, vc, NULL);
 	g_at_chat_register(vd->chat, "+CNAP:", cnap_notify, FALSE, vc, NULL);
 	g_at_chat_register(vd->chat, "+CCWA:", ccwa_notify, FALSE, vc, NULL);
@@ -1093,7 +1161,8 @@ static void at_voicecall_initialized(gboolean ok, GAt=
Result *result,
 	ofono_voicecall_register(vc);
 =

 	/* Populate the call list */
-	g_at_chat_send(vd->chat, "AT+CLCC", clcc_prefix, clcc_cb, vc, NULL);
+	if (vd->vendor !=3D OFONO_VENDOR_MOTMDM)
+		g_at_chat_send(vd->chat, "AT+CLCC", clcc_prefix, clcc_cb, vc, NULL);
 }
 =

 static int at_voicecall_probe(struct ofono_voicecall *vc, unsigned int ven=
dor,
@@ -1112,12 +1181,18 @@ static int at_voicecall_probe(struct ofono_voicecal=
l *vc, unsigned int vendor,
 =

 	ofono_voicecall_set_data(vc, vd);
 =

-	g_at_chat_send(vd->chat, "AT+CRC=3D1", NULL, NULL, NULL, NULL);
+	if (vd->vendor !=3D OFONO_VENDOR_MOTMDM) {
+		g_at_chat_send(vd->chat, "AT+CRC=3D1", NULL, NULL, NULL, NULL);
+	}
 	g_at_chat_send(vd->chat, "AT+CLIP=3D1", NULL, NULL, NULL, NULL);
-	g_at_chat_send(vd->chat, "AT+CDIP=3D1", NULL, NULL, NULL, NULL);
-	g_at_chat_send(vd->chat, "AT+CNAP=3D1", NULL, NULL, NULL, NULL);
+	if (vd->vendor !=3D OFONO_VENDOR_MOTMDM) {
+		g_at_chat_send(vd->chat, "AT+CDIP=3D1", NULL, NULL, NULL, NULL);
+		g_at_chat_send(vd->chat, "AT+CNAP=3D1", NULL, NULL, NULL, NULL);
+	}
 =

 	switch (vd->vendor) {
+	case OFONO_VENDOR_MOTMDM:
+		break;
 	case OFONO_VENDOR_QUALCOMM_MSM:
 	case OFONO_VENDOR_SIMCOM:
 		g_at_chat_send(vd->chat, "AT+COLP=3D0", NULL, NULL, NULL, NULL);
@@ -1127,9 +1202,11 @@ static int at_voicecall_probe(struct ofono_voicecall=
 *vc, unsigned int vendor,
 		break;
 	}
 =

-	g_at_chat_send(vd->chat, "AT+CSSN=3D1,1", NULL, NULL, NULL, NULL);
-	g_at_chat_send(vd->chat, "AT+VTD?", NULL,
-				vtd_query_cb, vc, NULL);
+	if (vd->vendor !=3D OFONO_VENDOR_MOTMDM) {
+		g_at_chat_send(vd->chat, "AT+CSSN=3D1,1", NULL, NULL, NULL, NULL);
+		g_at_chat_send(vd->chat, "AT+VTD?", NULL,
+			       vtd_query_cb, vc, NULL);
+	}
 	g_at_chat_send(vd->chat, "AT+CCWA=3D1", NULL,
 				at_voicecall_initialized, vc, NULL);
 =


-- =

(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--===============9169646340680253484==
Content-Type: application/pgp-signature
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="signature.asc"

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KVmVyc2lvbjogR251UEcgdjEKCmlFWUVBUkVD
QUFZRkFsMVJJZHNBQ2drUU1PZndhcFhiK3ZKOXlBQ2RHOGhqaTlzUFRXS1N4RDRFdGxXc1pEWFAK
Z3hzQW4zcDd6eitkdmt5MUlBNGYzdGVUTVN4TG1HSHQKPXNvUkoKLS0tLS1FTkQgUEdQIFNJR05B
VFVSRS0tLS0tCg==

--===============9169646340680253484==--

