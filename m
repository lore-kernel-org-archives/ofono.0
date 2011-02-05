Content-Type: multipart/mixed; boundary="===============6595231413774728072=="
MIME-Version: 1.0
From: Jeevaka Badrappan <jeevaka.badrappan@elektrobit.com>
Subject: [PATCH] ifxmodem: refactor call status notifications
Date: Sat, 05 Feb 2011 10:24:39 -0800
Message-ID: <1296930279-28383-1-git-send-email-jeevaka.badrappan@elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6595231413774728072==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 drivers/ifxmodem/voicecall.c |  197 +++++++++++++++++++-------------------=
----
 1 files changed, 90 insertions(+), 107 deletions(-)

diff --git a/drivers/ifxmodem/voicecall.c b/drivers/ifxmodem/voicecall.c
index f66815a..c6e3878 100644
--- a/drivers/ifxmodem/voicecall.c
+++ b/drivers/ifxmodem/voicecall.c
@@ -120,7 +120,8 @@ static void xcallstat_notify(GAtResult *result, gpointe=
r user_data)
 	int id;
 	int status;
 	GSList *l;
-	struct ofono_call *call;
+	struct ofono_call *new_call;
+	struct ofono_call *existing_call =3D NULL;
 =

 	g_at_result_iter_init(&iter, result);
 =

@@ -136,53 +137,70 @@ static void xcallstat_notify(GAtResult *result, gpoin=
ter user_data)
 	l =3D g_slist_find_custom(vd->calls, GINT_TO_POINTER(id),
 				at_util_call_compare_by_id);
 =

-	if (l =3D=3D NULL) {
-		/*
-		 * We should only receive XCALLSTAT on waiting and incoming
-		 * In the case of waiting, we will get the rest of the info
-		 * from CCWA indication.
-		 * In the case of incoming, we will get the info from CLIP
-		 * indications.
-		 */
-		if (status !=3D CALL_STATUS_INCOMING &&
-				    status !=3D CALL_STATUS_WAITING) {
-			ofono_info("Received an XCALLSTAT for an untracked"
-					" call, this indicates a bug!");
-			return;
-		}
-
+	if (l =3D=3D NULL && status !=3D CALL_STATUS_INCOMING &&
+				status !=3D CALL_STATUS_WAITING) {
+		ofono_error("Received an XCALLSTAT for an untracked"
+				" call, this indicates a bug!");
 		return;
 	}
 =

-	call =3D l->data;
+	if (l)
+		existing_call =3D l->data;
 =

-	/* Check if call has been disconnected */
-	if (status =3D=3D CALL_STATUS_DISCONNECTED) {
-		enum ofono_disconnect_reason r;
+	switch (status) {
+	case CALL_STATUS_DISCONNECTED:
+	{
+		enum ofono_disconnect_reason reason;
 =

-		if (vd->local_release & (1 << call->id))
-			r =3D OFONO_DISCONNECT_REASON_LOCAL_HANGUP;
-		else
-			r =3D OFONO_DISCONNECT_REASON_REMOTE_HANGUP;
+		existing_call->status =3D status;
 =

-		if (call->type =3D=3D 0)
-			ofono_voicecall_disconnected(vc, call->id, r, NULL);
+		if (vd->local_release & (1 << existing_call->id))
+			reason =3D OFONO_DISCONNECT_REASON_LOCAL_HANGUP;
+		else
+			reason =3D OFONO_DISCONNECT_REASON_REMOTE_HANGUP;
 =

-		vd->local_release &=3D ~(1 << call->id);
-		vd->calls =3D g_slist_remove(vd->calls, call);
-		g_free(call);
+		ofono_voicecall_disconnected(vc, existing_call->id,
+						reason, NULL);
 =

-		return;
+		vd->local_release &=3D ~(1 << existing_call->id);
+		vd->calls =3D g_slist_remove(vd->calls, l->data);
+		g_free(existing_call);
+		break;
 	}
+	case CALL_STATUS_DIALING:
+	case CALL_STATUS_WAITING:
+	case CALL_STATUS_INCOMING:
+	{
+		int direction;
+
+		if (status =3D=3D CALL_STATUS_DIALING)
+			direction =3D CALL_DIRECTION_MOBILE_ORIGINATED;
+		else
+			direction =3D CALL_DIRECTION_MOBILE_TERMINATED;
 =

-	/* For connected status, simply reset back to active */
-	if (status =3D=3D 7)
-		status =3D 0;
+		new_call =3D create_call(vc, 0, direction, status,
+					NULL, 128, CLIP_VALIDITY_NOT_AVAILABLE);
+		if (new_call =3D=3D NULL) {
+			ofono_error("Unable to malloc. "
+					"Call management is fubar");
+			return;
+		}
 =

-	call->status =3D status;
+		new_call->id =3D id;
+		break;
+	}
+	case CALL_STATUS_ALERTING:
+	case CALL_STATUS_ACTIVE:
+	case CALL_STATUS_HELD:
+	default:
+		/* For connected status, simply reset back to active */
+		if (status =3D=3D 7)
+			status =3D 0;
 =

-	if (call->type =3D=3D 0)
-		ofono_voicecall_notify(vc, call);
+		existing_call->status =3D status;
+		ofono_voicecall_notify(vc, existing_call);
+		break;
+	}
 }
 =

 static void xem_notify(GAtResult *result, gpointer user_data)
@@ -253,51 +271,12 @@ static void release_id_cb(gboolean ok, GAtResult *res=
ult,
 static void atd_cb(gboolean ok, GAtResult *result, gpointer user_data)
 {
 	struct cb_data *cbd =3D user_data;
-	struct ofono_voicecall *vc =3D cbd->user;
 	ofono_voicecall_cb_t cb =3D cbd->cb;
-	GAtResultIter iter;
-	const char *num;
-	int type =3D 128;
-	int validity =3D 2;
 	struct ofono_error error;
-	struct ofono_call *call;
 =

 	decode_at_error(&error, g_at_result_final_response(result));
 =

-	if (!ok) {
-		cb(&error, cbd->data);
-		return;
-	}
-
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
-	/* Generate a voice call that was just dialed, we guess the ID */
-	call =3D create_call(vc, 0, 0, CALL_STATUS_DIALING, num, type, validity);
-	if (call =3D=3D NULL) {
-		ofono_error("Unable to malloc, call tracking will fail!");
-		return;
-	}
-
-	/* Let oFono core will generate a call with the dialed number
-	 * inside its dial callback.
-	 */
 	cb(&error, cbd->data);
-
-	/* If we got COLP information, then notify the core */
-	if (validity !=3D 2)
-		ofono_voicecall_notify(vc, call);
 }
 =

 static void ifx_dial(struct ofono_voicecall *vc,
@@ -531,52 +510,56 @@ error:
 	CALLBACK_WITH_FAILURE(cb, data);
 }
 =

-static void cring_notify(GAtResult *result, gpointer user_data)
+static void xcolp_notify(GAtResult *result, gpointer user_data)
 {
 	struct ofono_voicecall *vc =3D user_data;
 	struct voicecall_data *vd =3D ofono_voicecall_get_data(vc);
 	GAtResultIter iter;
-	const char *line;
-	int type;
-
-	/* Handle the following situation:
-	 * Active Call + Waiting Call.  Active Call is Released.  The Waiting
-	 * call becomes Incoming and RING/CRING indications are signaled.
-	 * Sometimes these arrive before we managed to poll CLCC to find about
-	 * the stage change.  If this happens, simply ignore the RING/CRING
-	 * when a waiting call exists (cannot have waiting + incoming in GSM)
-	 */
-	if (g_slist_find_custom(vd->calls,
-				GINT_TO_POINTER(CALL_STATUS_WAITING),
-				at_util_call_compare_by_status))
-		return;
+	const char *num;
+	int type, validity, call_id;
+	GSList *l;
+	struct ofono_call *call;
 =

-	/* CRING can repeat, ignore if we already have an incoming call */
-	if (g_slist_find_custom(vd->calls,
-				GINT_TO_POINTER(CALL_STATUS_INCOMING),
-				at_util_call_compare_by_status))
-		return;
+	DBG("");
 =

 	g_at_result_iter_init(&iter, result);
 =

-	if (!g_at_result_iter_next(&iter, "+CRING:"))
+	if (!g_at_result_iter_next(&iter, "+XCOLP:"))
+		return;
+
+	if (!g_at_result_iter_next_number(&iter, &call_id))
+		return;
+
+	if (!g_at_result_iter_next_string(&iter, &num))
 		return;
 =

-	line =3D g_at_result_iter_raw_line(&iter);
-	if (line =3D=3D NULL)
+	if (!g_at_result_iter_next_number(&iter, &type))
 		return;
 =

-	/* Ignore everything that is not voice for now */
-	if (!strcasecmp(line, "VOICE"))
-		type =3D 0;
+	if (strlen(num) > 0)
+		validity =3D 0;
 	else
-		type =3D 9;
+		validity =3D 2;
 =

-	/* Generate an incoming call */
-	create_call(vc, type, 1, CALL_STATUS_INCOMING, NULL, 128, 2);
+	DBG("xcolp_notify: %d %s %d %d", call_id, num, type, validity);
+
+	l =3D g_slist_find_custom(vd->calls,
+				GINT_TO_POINTER(call_id),
+				at_util_call_compare_by_id);
+	if (l =3D=3D NULL) {
+		ofono_error("XCOLP for unknown call");
+		return;
+	}
+
+	call =3D l->data;
+
+	strncpy(call->phone_number.number, num,
+		OFONO_MAX_PHONE_NUMBER_LENGTH);
+	call->phone_number.number[OFONO_MAX_PHONE_NUMBER_LENGTH] =3D '\0';
+	call->phone_number.type =3D type;
+	call->clip_validity =3D validity;
 =

-	/* Assume the CLIP always arrives, and we signal the call there */
-	DBG("cring_notify");
+	ofono_voicecall_notify(vc, call);
 }
 =

 static void clip_notify(GAtResult *result, gpointer user_data)
@@ -696,12 +679,12 @@ static void ifx_voicecall_initialized(gboolean ok, GA=
tResult *result,
 =

 	DBG("voicecall_init: registering to notifications");
 =

-	g_at_chat_register(vd->chat, "+CRING:", cring_notify, FALSE, vc, NULL);
 	g_at_chat_register(vd->chat, "+CLIP:", clip_notify, FALSE, vc, NULL);
 	g_at_chat_register(vd->chat, "+CCWA:", ccwa_notify, FALSE, vc, NULL);
 	g_at_chat_register(vd->chat, "+XEM:", xem_notify, FALSE, vc, NULL);
 	g_at_chat_register(vd->chat, "+XCALLSTAT:", xcallstat_notify,
 							FALSE, vc, NULL);
+	g_at_chat_register(vd->chat, "+XCOLP:", xcolp_notify, FALSE, vc, NULL);
 =

 	ofono_voicecall_register(vc);
 }
-- =

1.7.0.4


--===============6595231413774728072==--

