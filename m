Content-Type: multipart/mixed; boundary="===============4482514368681942277=="
MIME-Version: 1.0
From: Slava Monich <slava.monich@jolla.com>
Subject: [PATCH 05/12] ifxmodem: Use new voicecall enums
Date: Thu, 21 Jun 2018 20:20:54 +0300
Message-ID: <1529601661-4856-5-git-send-email-slava.monich@jolla.com>
In-Reply-To: <1529601661-4856-1-git-send-email-slava.monich@jolla.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4482514368681942277==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 drivers/ifxmodem/voicecall.c | 59 ++++++++++++++++++++++++----------------=
----
 1 file changed, 32 insertions(+), 27 deletions(-)

diff --git a/drivers/ifxmodem/voicecall.c b/drivers/ifxmodem/voicecall.c
index 45b5ca4..9055b2d 100644
--- a/drivers/ifxmodem/voicecall.c
+++ b/drivers/ifxmodem/voicecall.c
@@ -80,7 +80,8 @@ static int class_to_call_type(int cls)
 }
 =

 static struct ofono_call *create_call(struct ofono_voicecall *vc, int type,
-					int direction, int status,
+					enum ofono_call_direction direction,
+					enum ofono_call_status status,
 					const char *num, int num_type,
 					int clip, int id)
 {
@@ -137,9 +138,9 @@ static void xcallstat_notify(GAtResult *result, gpointe=
r user_data)
 	l =3D g_slist_find_custom(vd->calls, GINT_TO_POINTER(id),
 				at_util_call_compare_by_id);
 =

-	if (l =3D=3D NULL && status !=3D CALL_STATUS_DIALING &&
-				status !=3D CALL_STATUS_INCOMING &&
-				status !=3D CALL_STATUS_WAITING) {
+	if (l =3D=3D NULL && status !=3D OFONO_CALL_STATUS_DIALING &&
+				status !=3D OFONO_CALL_STATUS_INCOMING &&
+				status !=3D OFONO_CALL_STATUS_WAITING) {
 		ofono_error("Received XCALLSTAT for an untracked"
 				" call, this indicates a bug!");
 		return;
@@ -149,7 +150,7 @@ static void xcallstat_notify(GAtResult *result, gpointe=
r user_data)
 		existing_call =3D l->data;
 =

 	switch (status) {
-	case CALL_STATUS_DISCONNECTED:
+	case OFONO_CALL_STATUS_DISCONNECTED:
 	{
 		enum ofono_disconnect_reason reason;
 =

@@ -168,10 +169,11 @@ static void xcallstat_notify(GAtResult *result, gpoin=
ter user_data)
 		g_free(existing_call);
 		break;
 	}
-	case CALL_STATUS_DIALING:
-		new_call =3D create_call(vc, 0, CALL_DIRECTION_MOBILE_ORIGINATED,
+	case OFONO_CALL_STATUS_DIALING:
+		new_call =3D create_call(vc, 0,
+					OFONO_CALL_DIRECTION_MOBILE_ORIGINATED,
 					status, NULL, 128,
-					CLIP_VALIDITY_NOT_AVAILABLE, id);
+					OFONO_CLIP_VALIDITY_NOT_AVAILABLE, id);
 		if (new_call =3D=3D NULL) {
 			ofono_error("Unable to malloc. "
 					"Call management is fubar");
@@ -180,8 +182,8 @@ static void xcallstat_notify(GAtResult *result, gpointe=
r user_data)
 =

 		ofono_voicecall_notify(vc, new_call);
 		break;
-	case CALL_STATUS_WAITING:
-	case CALL_STATUS_INCOMING:
+	case OFONO_CALL_STATUS_WAITING:
+	case OFONO_CALL_STATUS_INCOMING:
 		/* Handle the following situation:
 		 * Active Call + Waiting Call. Active Call is Released.
 		 * The Waiting call becomes Incoming. In this case, no
@@ -193,9 +195,10 @@ static void xcallstat_notify(GAtResult *result, gpoint=
er user_data)
 			return;
 		}
 =

-		new_call =3D create_call(vc, 0, CALL_DIRECTION_MOBILE_TERMINATED,
+		new_call =3D create_call(vc, 0,
+					OFONO_CALL_DIRECTION_MOBILE_TERMINATED,
 					status, NULL, 128,
-					CLIP_VALIDITY_NOT_AVAILABLE, id);
+					OFONO_CLIP_VALIDITY_NOT_AVAILABLE, id);
 		if (new_call =3D=3D NULL) {
 			ofono_error("Unable to malloc. "
 					"Call management is fubar");
@@ -203,13 +206,13 @@ static void xcallstat_notify(GAtResult *result, gpoin=
ter user_data)
 		}
 =

 		break;
-	case CALL_STATUS_ALERTING:
-	case CALL_STATUS_ACTIVE:
-	case CALL_STATUS_HELD:
+	case OFONO_CALL_STATUS_ALERTING:
+	case OFONO_CALL_STATUS_ACTIVE:
+	case OFONO_CALL_STATUS_HELD:
 	default:
 		/* For connected status, simply reset back to active */
 		if (status =3D=3D 7)
-			status =3D CALL_STATUS_ACTIVE;
+			status =3D OFONO_CALL_STATUS_ACTIVE;
 =

 		existing_call->status =3D status;
 		ofono_voicecall_notify(vc, existing_call);
@@ -388,7 +391,7 @@ static void ifx_hold_all_active(struct ofono_voicecall =
*vc,
 static void ifx_release_all_held(struct ofono_voicecall *vc,
 				ofono_voicecall_cb_t cb, void *data)
 {
-	unsigned int held_status =3D 1 << CALL_STATUS_HELD;
+	unsigned int held_status =3D 1 << OFONO_CALL_STATUS_HELD;
 	ifx_template("AT+CHLD=3D0", vc, generic_cb, held_status, cb, data);
 }
 =

@@ -396,7 +399,8 @@ static void ifx_set_udub(struct ofono_voicecall *vc,
 			ofono_voicecall_cb_t cb, void *data)
 {
 	unsigned int incoming_or_waiting =3D
-		(1 << CALL_STATUS_INCOMING) | (1 << CALL_STATUS_WAITING);
+		(1 << OFONO_CALL_STATUS_INCOMING) |
+		(1 << OFONO_CALL_STATUS_WAITING);
 =

 	ifx_template("AT+CHLD=3D0", vc, generic_cb, incoming_or_waiting,
 			cb, data);
@@ -471,7 +475,8 @@ static void ifx_deflect(struct ofono_voicecall *vc,
 {
 	char buf[128];
 	unsigned int incoming_or_waiting =3D
-		(1 << CALL_STATUS_INCOMING) | (1 << CALL_STATUS_WAITING);
+		(1 << OFONO_CALL_STATUS_INCOMING) |
+		(1 << OFONO_CALL_STATUS_WAITING);
 =

 	snprintf(buf, sizeof(buf), "AT+CTFR=3D%s,%d", ph->number, ph->type);
 	ifx_template(buf, vc, generic_cb, incoming_or_waiting, cb, data);
@@ -544,12 +549,12 @@ static void cring_notify(GAtResult *result, gpointer =
user_data)
 	 * exists (cannot have waiting + incoming in GSM)
 	 */
 	if (g_slist_find_custom(vd->calls,
-				GINT_TO_POINTER(CALL_STATUS_WAITING),
+				GINT_TO_POINTER(OFONO_CALL_STATUS_WAITING),
 				at_util_call_compare_by_status))
 		return;
 =

 	l =3D g_slist_find_custom(vd->calls,
-				GINT_TO_POINTER(CALL_STATUS_INCOMING),
+				GINT_TO_POINTER(OFONO_CALL_STATUS_INCOMING),
 				at_util_call_compare_by_status);
 	if (l =3D=3D NULL) {
 		ofono_error("CRING received before XCALLSTAT!!!");
@@ -588,7 +593,7 @@ static void clip_notify(GAtResult *result, gpointer use=
r_data)
 	struct ofono_call *call;
 =

 	l =3D g_slist_find_custom(vd->calls,
-				GINT_TO_POINTER(CALL_STATUS_INCOMING),
+				GINT_TO_POINTER(OFONO_CALL_STATUS_INCOMING),
 				at_util_call_compare_by_status);
 	if (l =3D=3D NULL) {
 		ofono_error("CLIP for unknown call");
@@ -648,7 +653,7 @@ static void cnap_notify(GAtResult *result, gpointer use=
r_data)
 	 * calling party name for the waiting call.
 	 */
 	l =3D g_slist_find_custom(vd->calls,
-				GINT_TO_POINTER(CALL_STATUS_INCOMING),
+				GINT_TO_POINTER(OFONO_CALL_STATUS_INCOMING),
 				at_util_call_compare_by_status);
 	if (l =3D=3D NULL) {
 		ofono_error("CNAP for unknown call");
@@ -664,9 +669,9 @@ static void cnap_notify(GAtResult *result, gpointer use=
r_data)
 		return;
 =

 	if (strlen(name) > 0)
-		validity =3D CNAP_VALIDITY_VALID;
+		validity =3D OFONO_CNAP_VALIDITY_VALID;
 	else
-		validity =3D CNAP_VALIDITY_NOT_AVAILABLE;
+		validity =3D OFONO_CNAP_VALIDITY_NOT_AVAILABLE;
 =

 	/* If we have CNI validity field, override our guessed value */
 	g_at_result_iter_next_number(&iter, &validity);
@@ -694,7 +699,7 @@ static void ccwa_notify(GAtResult *result, gpointer use=
r_data)
 	struct ofono_call *call;
 =

 	l =3D g_slist_find_custom(vd->calls,
-				GINT_TO_POINTER(CALL_STATUS_WAITING),
+				GINT_TO_POINTER(OFONO_CALL_STATUS_WAITING),
 				at_util_call_compare_by_status);
 	if (l =3D=3D NULL) {
 		ofono_error("CCWA received before XCALLSTAT!!!");
@@ -784,7 +789,7 @@ static void xcolp_notify(GAtResult *result, gpointer us=
er_data)
 	strncpy(call->phone_number.number, num,	OFONO_MAX_PHONE_NUMBER_LENGTH);
 	call->phone_number.number[OFONO_MAX_PHONE_NUMBER_LENGTH] =3D '\0';
 	call->phone_number.type =3D type;
-	call->clip_validity =3D CLIP_VALIDITY_VALID;
+	call->clip_validity =3D OFONO_CLIP_VALIDITY_VALID;
 =

 	ofono_voicecall_notify(vc, call);
 }
-- =

1.9.1


--===============4482514368681942277==--

