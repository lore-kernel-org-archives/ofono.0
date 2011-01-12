Content-Type: multipart/mixed; boundary="===============5466604717040343923=="
MIME-Version: 1.0
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: [PATCH 3/9] atmodem: add cdip to voicecall
Date: Wed, 12 Jan 2011 09:27:41 -0200
Message-ID: <1294831667-7447-4-git-send-email-lucas.demarchi@profusion.mobi>
In-Reply-To: <1294831667-7447-1-git-send-email-lucas.demarchi@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5466604717040343923==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 drivers/atmodem/voicecall.c |   61 +++++++++++++++++++++++++++++++++++++++=
++-
 1 files changed, 59 insertions(+), 2 deletions(-)

diff --git a/drivers/atmodem/voicecall.c b/drivers/atmodem/voicecall.c
index 75e0c93..43989f2 100644
--- a/drivers/atmodem/voicecall.c
+++ b/drivers/atmodem/voicecall.c
@@ -60,6 +60,7 @@ static const char *atd_prefix[] =3D { "+COLP:", NULL };
 =

 #define FLAG_NEED_CLIP 1
 #define FLAG_NEED_CNAP 2
+#define FLAG_NEED_CDIP 4
 =

 struct voicecall_data {
 	GSList *calls;
@@ -202,6 +203,12 @@ static void clcc_poll_cb(gboolean ok, GAtResult *resul=
t, gpointer user_data)
 			nc->cnap_validity =3D oc->cnap_validity;
 =

 			/*
+			 * CDIP doesn't arrive as part of CLCC, always
+			 * re-use from the old call
+			 */
+			nc->called_number =3D oc->called_number;
+
+			/*
 			 * If the CLIP is not provided and the CLIP never
 			 * arrives, or RING is used, then signal the call
 			 * here
@@ -654,7 +661,7 @@ static void ring_notify(GAtResult *result, gpointer use=
r_data)
 =

 	/* We don't know the call type, we must run clcc */
 	vd->clcc_source =3D g_timeout_add(CLIP_INTERVAL, poll_clcc, vc);
-	vd->flags =3D FLAG_NEED_CLIP | FLAG_NEED_CNAP;
+	vd->flags =3D FLAG_NEED_CLIP | FLAG_NEED_CNAP | FLAG_NEED_CDIP;
 }
 =

 static void cring_notify(GAtResult *result, gpointer user_data)
@@ -705,7 +712,7 @@ static void cring_notify(GAtResult *result, gpointer us=
er_data)
 	 * earlier, we announce the call there
 	 */
 	vd->clcc_source =3D g_timeout_add(CLIP_INTERVAL, poll_clcc, vc);
-	vd->flags =3D FLAG_NEED_CLIP | FLAG_NEED_CNAP;
+	vd->flags =3D FLAG_NEED_CLIP | FLAG_NEED_CNAP | FLAG_NEED_CDIP;
 =

 	DBG("");
 }
@@ -771,6 +778,54 @@ static void clip_notify(GAtResult *result, gpointer us=
er_data)
 	vd->flags &=3D ~FLAG_NEED_CLIP;
 }
 =

+static void cdip_notify(GAtResult *result, gpointer user_data)
+{
+	struct ofono_voicecall *vc =3D user_data;
+	struct voicecall_data *vd =3D ofono_voicecall_get_data(vc);
+	GAtResultIter iter;
+	const char *num;
+	int type;
+	GSList *l;
+	struct ofono_call *call;
+
+	l =3D g_slist_find_custom(vd->calls, GINT_TO_POINTER(4),
+				at_util_call_compare_by_status);
+	if (l =3D=3D NULL) {
+		ofono_error("CDIP for unknown call");
+		return;
+	}
+
+	/* We have already saw a CDIP for this call, no need to parse again */
+	if ((vd->flags & FLAG_NEED_CDIP) =3D=3D 0)
+		return;
+
+	g_at_result_iter_init(&iter, result);
+
+	if (!g_at_result_iter_next(&iter, "+CDIP:"))
+		return;
+
+	if (!g_at_result_iter_next_string(&iter, &num))
+		return;
+
+	if (!g_at_result_iter_next_number(&iter, &type))
+		return;
+
+	DBG("%s %d", num, type);
+
+	call =3D l->data;
+
+	strncpy(call->called_number.number, num,
+		OFONO_MAX_PHONE_NUMBER_LENGTH);
+	call->called_number.number[OFONO_MAX_PHONE_NUMBER_LENGTH] =3D '\0';
+	call->called_number.type =3D type;
+
+	/* Only signal the call here if we already signaled it to the core */
+	if (call->type =3D=3D 0 && (vd->flags & FLAG_NEED_CLIP) =3D=3D 0)
+		ofono_voicecall_notify(vc, call);
+
+	vd->flags &=3D ~FLAG_NEED_CDIP;
+}
+
 static void cnap_notify(GAtResult *result, gpointer user_data)
 {
 	struct ofono_voicecall *vc =3D user_data;
@@ -942,6 +997,7 @@ static void at_voicecall_initialized(gboolean ok, GAtRe=
sult *result,
 	g_at_chat_register(vd->chat, "RING", ring_notify, FALSE, vc, NULL);
 	g_at_chat_register(vd->chat, "+CRING:", cring_notify, FALSE, vc, NULL);
 	g_at_chat_register(vd->chat, "+CLIP:", clip_notify, FALSE, vc, NULL);
+	g_at_chat_register(vd->chat, "+CDIP:", cdip_notify, FALSE, vc, NULL);
 	g_at_chat_register(vd->chat, "+CNAP:", cnap_notify, FALSE, vc, NULL);
 	g_at_chat_register(vd->chat, "+CCWA:", ccwa_notify, FALSE, vc, NULL);
 =

@@ -978,6 +1034,7 @@ static int at_voicecall_probe(struct ofono_voicecall *=
vc, unsigned int vendor,
 =

 	g_at_chat_send(vd->chat, "AT+CRC=3D1", NULL, NULL, NULL, NULL);
 	g_at_chat_send(vd->chat, "AT+CLIP=3D1", NULL, NULL, NULL, NULL);
+	g_at_chat_send(vd->chat, "AT+CDIP=3D1", NULL, NULL, NULL, NULL);
 	g_at_chat_send(vd->chat, "AT+CNAP=3D1", NULL, NULL, NULL, NULL);
 	g_at_chat_send(vd->chat, "AT+COLP=3D1", NULL, NULL, NULL, NULL);
 	g_at_chat_send(vd->chat, "AT+VTD?", NULL,
-- =

1.7.3.5


--===============5466604717040343923==--

