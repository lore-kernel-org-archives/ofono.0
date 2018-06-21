Content-Type: multipart/mixed; boundary="===============4763366923629704502=="
MIME-Version: 1.0
From: Slava Monich <slava.monich@jolla.com>
Subject: [PATCH 02/12] atmodem: Use new voicecall enums
Date: Thu, 21 Jun 2018 20:20:51 +0300
Message-ID: <1529601661-4856-2-git-send-email-slava.monich@jolla.com>
In-Reply-To: <1529601661-4856-1-git-send-email-slava.monich@jolla.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4763366923629704502==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 drivers/atmodem/voicecall.c | 64 +++++++++++++++++++++++++----------------=
----
 1 file changed, 36 insertions(+), 28 deletions(-)

diff --git a/drivers/atmodem/voicecall.c b/drivers/atmodem/voicecall.c
index aa56f1e..6aa1fd5 100644
--- a/drivers/atmodem/voicecall.c
+++ b/drivers/atmodem/voicecall.c
@@ -105,7 +105,8 @@ static int class_to_call_type(int cls)
 }
 =

 static struct ofono_call *create_call(struct ofono_voicecall *vc, int type,
-					int direction, int status,
+					enum ofono_call_direction direction,
+					enum ofono_call_status status,
 					const char *num, int num_type, int clip)
 {
 	struct voicecall_data *d =3D ofono_voicecall_get_data(vc);
@@ -130,7 +131,7 @@ static struct ofono_call *create_call(struct ofono_voic=
ecall *vc, int type,
 	}
 =

 	call->clip_validity =3D clip;
-	call->cnap_validity =3D CNAP_VALIDITY_NOT_AVAILABLE;
+	call->cnap_validity =3D OFONO_CNAP_VALIDITY_NOT_AVAILABLE;
 =

 	d->calls =3D g_slist_insert_sorted(d->calls, call, at_util_call_compare);
 =

@@ -181,8 +182,8 @@ static void clcc_poll_cb(gboolean ok, GAtResult *result=
, gpointer user_data)
 			poll_again =3D TRUE;
 			break;
 		default:
-			if (nc && nc->status >=3D CALL_STATUS_DIALING &&
-					nc->status <=3D CALL_STATUS_WAITING)
+			if (nc && nc->status >=3D OFONO_CALL_STATUS_DIALING &&
+					nc->status <=3D OFONO_CALL_STATUS_WAITING)
 				poll_again =3D TRUE;
 			break;
 		}
@@ -239,7 +240,7 @@ static void clcc_poll_cb(gboolean ok, GAtResult *result=
, gpointer user_data)
 			 * arrives, or RING is used, then signal the call
 			 * here
 			 */
-			if (nc->status =3D=3D CALL_STATUS_INCOMING &&
+			if (nc->status =3D=3D OFONO_CALL_STATUS_INCOMING &&
 					(vd->flags & FLAG_NEED_CLIP)) {
 				if (nc->type =3D=3D 0)
 					ofono_voicecall_notify(vc, nc);
@@ -347,10 +348,10 @@ static void atd_cb(gboolean ok, GAtResult *result, gp=
ointer user_data)
 	for (l =3D vd->calls; l; l =3D l->next) {
 		call =3D l->data;
 =

-		if (call->status !=3D CALL_STATUS_ACTIVE)
+		if (call->status !=3D OFONO_CALL_STATUS_ACTIVE)
 			continue;
 =

-		call->status =3D CALL_STATUS_HELD;
+		call->status =3D OFONO_CALL_STATUS_HELD;
 		ofono_voicecall_notify(vc, call);
 	}
 =

@@ -369,7 +370,8 @@ static void atd_cb(gboolean ok, GAtResult *result, gpoi=
nter user_data)
 	}
 =

 	/* Generate a voice call that was just dialed, we guess the ID */
-	call =3D create_call(vc, 0, 0, CALL_STATUS_DIALING, num, type, validity);
+	call =3D create_call(vc, 0, OFONO_CALL_DIRECTION_MOBILE_ORIGINATED,
+			OFONO_CALL_STATUS_DIALING, num, type, validity);
 	if (call =3D=3D NULL) {
 		ofono_error("Unable to malloc, call tracking will fail!");
 		return;
@@ -491,7 +493,7 @@ static void at_hold_all_active(struct ofono_voicecall *=
vc,
 static void at_release_all_held(struct ofono_voicecall *vc,
 				ofono_voicecall_cb_t cb, void *data)
 {
-	unsigned int held_status =3D 1 << CALL_STATUS_HELD;
+	unsigned int held_status =3D 1 << OFONO_CALL_STATUS_HELD;
 	at_template("AT+CHLD=3D0", vc, generic_cb, held_status, cb, data);
 }
 =

@@ -499,7 +501,8 @@ static void at_set_udub(struct ofono_voicecall *vc,
 			ofono_voicecall_cb_t cb, void *data)
 {
 	unsigned int incoming_or_waiting =3D
-		(1 << CALL_STATUS_INCOMING) | (1 << CALL_STATUS_WAITING);
+		(1 << OFONO_CALL_STATUS_INCOMING) |
+		(1 << OFONO_CALL_STATUS_WAITING);
 =

 	at_template("AT+CHLD=3D0", vc, generic_cb, incoming_or_waiting,
 			cb, data);
@@ -574,7 +577,8 @@ static void at_deflect(struct ofono_voicecall *vc,
 {
 	char buf[128];
 	unsigned int incoming_or_waiting =3D
-		(1 << CALL_STATUS_INCOMING) | (1 << CALL_STATUS_WAITING);
+		(1 << OFONO_CALL_STATUS_INCOMING) |
+		(1 << OFONO_CALL_STATUS_WAITING);
 =

 	snprintf(buf, sizeof(buf), "AT+CTFR=3D%s,%d", ph->number, ph->type);
 	at_template(buf, vc, generic_cb, incoming_or_waiting, cb, data);
@@ -659,18 +663,19 @@ static void ring_notify(GAtResult *result, gpointer u=
ser_data)
 =

 	/* See comment in CRING */
 	if (g_slist_find_custom(vd->calls,
-				GINT_TO_POINTER(CALL_STATUS_WAITING),
+				GINT_TO_POINTER(OFONO_CALL_STATUS_WAITING),
 				at_util_call_compare_by_status))
 		return;
 =

 	/* RING can repeat, ignore if we already have an incoming call */
 	if (g_slist_find_custom(vd->calls,
-				GINT_TO_POINTER(CALL_STATUS_INCOMING),
+				GINT_TO_POINTER(OFONO_CALL_STATUS_INCOMING),
 				at_util_call_compare_by_status))
 		return;
 =

 	/* Generate an incoming call of unknown type */
-	call =3D create_call(vc, 9, 1, CALL_STATUS_INCOMING, NULL, 128, 2);
+	call =3D create_call(vc, 9, OFONO_CALL_DIRECTION_MOBILE_TERMINATED,
+			OFONO_CALL_STATUS_INCOMING, NULL, 128, 2);
 	if (call =3D=3D NULL) {
 		ofono_error("Couldn't create call, call management is fubar!");
 		return;
@@ -697,13 +702,13 @@ static void cring_notify(GAtResult *result, gpointer =
user_data)
 	 * when a waiting call exists (cannot have waiting + incoming in GSM)
 	 */
 	if (g_slist_find_custom(vd->calls,
-				GINT_TO_POINTER(CALL_STATUS_WAITING),
+				GINT_TO_POINTER(OFONO_CALL_STATUS_WAITING),
 				at_util_call_compare_by_status))
 		return;
 =

 	/* CRING can repeat, ignore if we already have an incoming call */
 	if (g_slist_find_custom(vd->calls,
-				GINT_TO_POINTER(CALL_STATUS_INCOMING),
+				GINT_TO_POINTER(OFONO_CALL_STATUS_INCOMING),
 				at_util_call_compare_by_status))
 		return;
 =

@@ -723,7 +728,8 @@ static void cring_notify(GAtResult *result, gpointer us=
er_data)
 		type =3D 9;
 =

 	/* Generate an incoming call */
-	create_call(vc, type, 1, CALL_STATUS_INCOMING, NULL, 128, 2);
+	create_call(vc, type, OFONO_CALL_DIRECTION_MOBILE_TERMINATED,
+				OFONO_CALL_STATUS_INCOMING, NULL, 128, 2);
 =

 	/* We have a call, and call type but don't know the number and
 	 * must wait for the CLIP to arrive before announcing the call.
@@ -742,12 +748,13 @@ static void clip_notify(GAtResult *result, gpointer u=
ser_data)
 	struct voicecall_data *vd =3D ofono_voicecall_get_data(vc);
 	GAtResultIter iter;
 	const char *num;
-	int type, validity;
+	int type;
+	int validity;
 	GSList *l;
 	struct ofono_call *call;
 =

 	l =3D g_slist_find_custom(vd->calls,
-				GINT_TO_POINTER(CALL_STATUS_INCOMING),
+				GINT_TO_POINTER(OFONO_CALL_STATUS_INCOMING),
 				at_util_call_compare_by_status);
 	if (l =3D=3D NULL) {
 		ofono_error("CLIP for unknown call");
@@ -770,9 +777,9 @@ static void clip_notify(GAtResult *result, gpointer use=
r_data)
 		return;
 =

 	if (strlen(num) > 0)
-		validity =3D CLIP_VALIDITY_VALID;
+		validity =3D OFONO_CLIP_VALIDITY_VALID;
 	else
-		validity =3D CLIP_VALIDITY_NOT_AVAILABLE;
+		validity =3D OFONO_CLIP_VALIDITY_NOT_AVAILABLE;
 =

 	/* Skip subaddr, satype and alpha */
 	g_at_result_iter_skip_next(&iter);
@@ -809,7 +816,7 @@ static void cdip_notify(GAtResult *result, gpointer use=
r_data)
 	struct ofono_call *call;
 =

 	l =3D g_slist_find_custom(vd->calls,
-				GINT_TO_POINTER(CALL_STATUS_INCOMING),
+				GINT_TO_POINTER(OFONO_CALL_STATUS_INCOMING),
 				at_util_call_compare_by_status);
 	if (l =3D=3D NULL) {
 		ofono_error("CDIP for unknown call");
@@ -858,7 +865,7 @@ static void cnap_notify(GAtResult *result, gpointer use=
r_data)
 	struct ofono_call *call;
 =

 	l =3D g_slist_find_custom(vd->calls,
-				GINT_TO_POINTER(CALL_STATUS_INCOMING),
+				GINT_TO_POINTER(OFONO_CALL_STATUS_INCOMING),
 				at_util_call_compare_by_status);
 	if (l =3D=3D NULL) {
 		ofono_error("CNAP for unknown call");
@@ -878,9 +885,9 @@ static void cnap_notify(GAtResult *result, gpointer use=
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
@@ -912,7 +919,7 @@ static void ccwa_notify(GAtResult *result, gpointer use=
r_data)
 =

 	/* Some modems resend CCWA, ignore it the second time around */
 	if (g_slist_find_custom(vd->calls,
-				GINT_TO_POINTER(CALL_STATUS_WAITING),
+				GINT_TO_POINTER(OFONO_CALL_STATUS_WAITING),
 				at_util_call_compare_by_status))
 		return;
 =

@@ -943,8 +950,9 @@ static void ccwa_notify(GAtResult *result, gpointer use=
r_data)
 =

 	DBG("%s %d %d %d", num, num_type, cls, validity);
 =

-	call =3D create_call(vc, class_to_call_type(cls), 1, CALL_STATUS_WAITING,
-				num, num_type, validity);
+	call =3D create_call(vc, class_to_call_type(cls),
+			OFONO_CALL_DIRECTION_MOBILE_TERMINATED,
+			OFONO_CALL_STATUS_WAITING, num, num_type, validity);
 	if (call =3D=3D NULL) {
 		ofono_error("Unable to malloc. Call management is fubar");
 		return;
-- =

1.9.1


--===============4763366923629704502==--

