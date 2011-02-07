Content-Type: multipart/mixed; boundary="===============1354688764224434845=="
MIME-Version: 1.0
From: Jeevaka Badrappan <jeevaka.badrappan@elektrobit.com>
Subject: [PATCH v3 3/4] ifxmodem: remove colp handling done inside atd_cb
Date: Mon, 07 Feb 2011 13:07:37 -0800
Message-ID: <1297112858-12002-4-git-send-email-jeevaka.badrappan@elektrobit.com>
In-Reply-To: <1297112858-12002-1-git-send-email-jeevaka.badrappan@elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1354688764224434845==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 drivers/ifxmodem/voicecall.c |   30 ++----------------------------
 1 files changed, 2 insertions(+), 28 deletions(-)

diff --git a/drivers/ifxmodem/voicecall.c b/drivers/ifxmodem/voicecall.c
index 772280a..648f46b 100644
--- a/drivers/ifxmodem/voicecall.c
+++ b/drivers/ifxmodem/voicecall.c
@@ -43,9 +43,6 @@
 =

 static const char *none_prefix[] =3D { NULL };
 =

-/* According to 27.007 COLP is an intermediate status for ATD */
-static const char *atd_prefix[] =3D { "+COLP:", NULL };
-
 struct voicecall_data {
 	GSList *calls;
 	unsigned int local_release;
@@ -255,10 +252,6 @@ static void atd_cb(gboolean ok, GAtResult *result, gpo=
inter user_data)
 	struct cb_data *cbd =3D user_data;
 	struct ofono_voicecall *vc =3D cbd->user;
 	ofono_voicecall_cb_t cb =3D cbd->cb;
-	GAtResultIter iter;
-	const char *num;
-	int type =3D 128;
-	int validity =3D 2;
 	struct ofono_error error;
 	struct ofono_call *call;
 =

@@ -269,22 +262,8 @@ static void atd_cb(gboolean ok, GAtResult *result, gpo=
inter user_data)
 		return;
 	}
 =

-	g_at_result_iter_init(&iter, result);
-
-	if (g_at_result_iter_next(&iter, "+COLP:")) {
-		g_at_result_iter_next_string(&iter, &num);
-		g_at_result_iter_next_number(&iter, &type);
-
-		if (strlen(num) > 0)
-			validity =3D 0;
-		else
-			validity =3D 2;
-
-		DBG("colp_notify: %s %d %d", num, type, validity);
-	}
-
 	/* Generate a voice call that was just dialed, we guess the ID */
-	call =3D create_call(vc, 0, 0, CALL_STATUS_DIALING, num, type, validity);
+	call =3D create_call(vc, 0, 0, CALL_STATUS_DIALING, NULL, 128, 2);
 	if (call =3D=3D NULL) {
 		ofono_error("Unable to malloc, call tracking will fail!");
 		return;
@@ -294,10 +273,6 @@ static void atd_cb(gboolean ok, GAtResult *result, gpo=
inter user_data)
 	 * inside its dial callback.
 	 */
 	cb(&error, cbd->data);
-
-	/* If we got COLP information, then notify the core */
-	if (validity !=3D 2)
-		ofono_voicecall_notify(vc, call);
 }
 =

 static void ifx_dial(struct ofono_voicecall *vc,
@@ -329,7 +304,7 @@ static void ifx_dial(struct ofono_voicecall *vc,
 =

 	strcat(buf, ";");
 =

-	if (g_at_chat_send(vd->chat, buf, atd_prefix,
+	if (g_at_chat_send(vd->chat, buf, none_prefix,
 				atd_cb, cbd, g_free) > 0)
 		return;
 =

@@ -776,7 +751,6 @@ static int ifx_voicecall_probe(struct ofono_voicecall *=
vc, unsigned int vendor,
 =

 	g_at_chat_send(vd->chat, "AT+CRC=3D1", none_prefix, NULL, NULL, NULL);
 	g_at_chat_send(vd->chat, "AT+CLIP=3D1", none_prefix, NULL, NULL, NULL);
-	g_at_chat_send(vd->chat, "AT+COLP=3D1", none_prefix, NULL, NULL, NULL);
 	g_at_chat_send(vd->chat, "AT+CNAP=3D1", none_prefix, NULL, NULL, NULL);
 	g_at_chat_send(vd->chat, "AT+CCWA=3D1", none_prefix,
 				ifx_voicecall_initialized, vc, NULL);
-- =

1.7.0.4


--===============1354688764224434845==--

