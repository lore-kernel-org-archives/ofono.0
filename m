Content-Type: multipart/mixed; boundary="===============6946656284313597708=="
MIME-Version: 1.0
From: Jeevaka Badrappan <jeevaka.badrappan@elektrobit.com>
Subject: [PATCH v4 1/1] ifxmodem: move call creation to xcallstat_notify
Date: Tue, 08 Feb 2011 09:04:14 -0800
Message-ID: <1297184654-23800-2-git-send-email-jeevaka.badrappan@elektrobit.com>
In-Reply-To: <1297184654-23800-1-git-send-email-jeevaka.badrappan@elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6946656284313597708==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 drivers/ifxmodem/voicecall.c |  172 ++++++++++++++++++++++++--------------=
----
 1 files changed, 98 insertions(+), 74 deletions(-)

diff --git a/drivers/ifxmodem/voicecall.c b/drivers/ifxmodem/voicecall.c
index 648f46b..30e6991 100644
--- a/drivers/ifxmodem/voicecall.c
+++ b/drivers/ifxmodem/voicecall.c
@@ -79,7 +79,8 @@ static int class_to_call_type(int cls)
 =

 static struct ofono_call *create_call(struct ofono_voicecall *vc, int type,
 					int direction, int status,
-					const char *num, int num_type, int clip)
+					const char *num, int num_type,
+					int clip, int id)
 {
 	struct voicecall_data *d =3D ofono_voicecall_get_data(vc);
 	struct ofono_call *call;
@@ -91,7 +92,7 @@ static struct ofono_call *create_call(struct ofono_voicec=
all *vc, int type,
 =

 	ofono_call_init(call);
 =

-	call->id =3D ofono_voicecall_get_next_callid(vc);
+	call->id =3D id;
 	call->type =3D type;
 	call->direction =3D direction;
 	call->status =3D status;
@@ -117,7 +118,8 @@ static void xcallstat_notify(GAtResult *result, gpointe=
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

@@ -133,53 +135,83 @@ static void xcallstat_notify(GAtResult *result, gpoin=
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
+	if (l =3D=3D NULL && status !=3D CALL_STATUS_DIALING &&
+				status !=3D CALL_STATUS_INCOMING &&
+				status !=3D CALL_STATUS_WAITING) {
+		ofono_error("Received XCALLSTAT for an untracked"
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
+		/* Handle the following situation:
+		 * Active Call + Waiting Call. Active Call is Released.
+		 * The Waiting call becomes Incoming. In this case, no
+		 * need to create a new call. Call status change will be
+		 * triggered from clip_notify.
+		 */
+		if (existing_call) {
+			existing_call->status =3D status;
+			return;
+		}
 =

-	/* For connected status, simply reset back to active */
-	if (status =3D=3D 7)
-		status =3D 0;
+		if (status =3D=3D CALL_STATUS_DIALING)
+			direction =3D CALL_DIRECTION_MOBILE_ORIGINATED;
+		else
+			direction =3D CALL_DIRECTION_MOBILE_TERMINATED;
+
+		new_call =3D create_call(vc, 0, direction, status,
+					NULL, 128,
+					CLIP_VALIDITY_NOT_AVAILABLE, id);
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
+			status =3D CALL_STATUS_ACTIVE;
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
@@ -250,25 +282,11 @@ static void release_id_cb(gboolean ok, GAtResult *res=
ult,
 static void atd_cb(gboolean ok, GAtResult *result, gpointer user_data)
 {
 	struct cb_data *cbd =3D user_data;
-	struct ofono_voicecall *vc =3D cbd->user;
 	ofono_voicecall_cb_t cb =3D cbd->cb;
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
-	/* Generate a voice call that was just dialed, we guess the ID */
-	call =3D create_call(vc, 0, 0, CALL_STATUS_DIALING, NULL, 128, 2);
-	if (call =3D=3D NULL) {
-		ofono_error("Unable to malloc, call tracking will fail!");
-		return;
-	}
-
 	/* Let oFono core will generate a call with the dialed number
 	 * inside its dial callback.
 	 */
@@ -512,25 +530,28 @@ static void cring_notify(GAtResult *result, gpointer =
user_data)
 	struct voicecall_data *vd =3D ofono_voicecall_get_data(vc);
 	GAtResultIter iter;
 	const char *line;
-	int type;
+	GSList *l;
+	struct ofono_call *call;
 =

 	/* Handle the following situation:
 	 * Active Call + Waiting Call.  Active Call is Released.  The Waiting
-	 * call becomes Incoming and RING/CRING indications are signaled.
-	 * Sometimes these arrive before we managed to poll CLCC to find about
-	 * the stage change.  If this happens, simply ignore the RING/CRING
-	 * when a waiting call exists (cannot have waiting + incoming in GSM)
+	 * call becomes Incoming and CRING indications are signaled.
+	 * Sometimes these arrive before the actual state change notification.
+	 * If this happens, simply ignore the CRING when a waiting call
+	 * exists (cannot have waiting + incoming in GSM)
 	 */
 	if (g_slist_find_custom(vd->calls,
 				GINT_TO_POINTER(CALL_STATUS_WAITING),
 				at_util_call_compare_by_status))
 		return;
 =

-	/* CRING can repeat, ignore if we already have an incoming call */
-	if (g_slist_find_custom(vd->calls,
+	l =3D g_slist_find_custom(vd->calls,
 				GINT_TO_POINTER(CALL_STATUS_INCOMING),
-				at_util_call_compare_by_status))
+				at_util_call_compare_by_status);
+	if (l =3D=3D NULL) {
+		ofono_error("CRING received before XCALLSTAT!!!");
 		return;
+	}
 =

 	g_at_result_iter_init(&iter, result);
 =

@@ -541,14 +562,13 @@ static void cring_notify(GAtResult *result, gpointer =
user_data)
 	if (line =3D=3D NULL)
 		return;
 =

+	call =3D l->data;
+
 	/* Ignore everything that is not voice for now */
 	if (!strcasecmp(line, "VOICE"))
-		type =3D 0;
+		call->type =3D 0;
 	else
-		type =3D 9;
-
-	/* Generate an incoming call */
-	create_call(vc, type, 1, CALL_STATUS_INCOMING, NULL, 128, 2);
+		call->type =3D 9;
 =

 	/* Assume the CLIP always arrives, and we signal the call there */
 	DBG("cring_notify");
@@ -617,13 +637,16 @@ static void ccwa_notify(GAtResult *result, gpointer u=
ser_data)
 	GAtResultIter iter;
 	const char *num;
 	int num_type, validity, cls;
+	GSList *l;
 	struct ofono_call *call;
 =

-	/* Some modems resend CCWA, ignore it the second time around */
-	if (g_slist_find_custom(vd->calls,
+	l =3D g_slist_find_custom(vd->calls,
 				GINT_TO_POINTER(CALL_STATUS_WAITING),
-				at_util_call_compare_by_status))
+				at_util_call_compare_by_status);
+	if (l =3D=3D NULL) {
+		ofono_error("CCWA received before XCALLSTAT!!!");
 		return;
+	}
 =

 	g_at_result_iter_init(&iter, result);
 =

@@ -652,12 +675,13 @@ static void ccwa_notify(GAtResult *result, gpointer u=
ser_data)
 =

 	DBG("ccwa_notify: %s %d %d %d", num, num_type, cls, validity);
 =

-	call =3D create_call(vc, class_to_call_type(cls), 1, CALL_STATUS_WAITING,
-				num, num_type, validity);
-	if (call =3D=3D NULL) {
-		ofono_error("Unable to malloc. Call management is fubar");
-		return;
-	}
+	call =3D l->data;
+
+	call->type =3D class_to_call_type(cls);
+	strncpy(call->phone_number.number, num, OFONO_MAX_PHONE_NUMBER_LENGTH);
+	call->phone_number.number[OFONO_MAX_PHONE_NUMBER_LENGTH] =3D '\0';
+	call->phone_number.type =3D num_type;
+	call->clip_validity =3D validity;
 =

 	if (call->type =3D=3D 0) /* Only notify voice calls */
 		ofono_voicecall_notify(vc, call);
-- =

1.7.0.4


--===============6946656284313597708==--

