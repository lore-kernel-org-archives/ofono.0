Content-Type: multipart/mixed; boundary="===============7848219853817159872=="
MIME-Version: 1.0
From: Jeevaka Badrappan <jeevaka.badrappan@elektrobit.com>
Subject: [PATCH v2 1/5] atmodem: use defined call_status enum
Date: Sat, 05 Feb 2011 05:02:59 -0800
Message-ID: <1296910983-20402-2-git-send-email-jeevaka.badrappan@elektrobit.com>
In-Reply-To: <1296910983-20402-1-git-send-email-jeevaka.badrappan@elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7848219853817159872==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 drivers/atmodem/voicecall.c |   51 +++++++++++++++++++++++++++------------=
----
 1 files changed, 32 insertions(+), 19 deletions(-)

diff --git a/drivers/atmodem/voicecall.c b/drivers/atmodem/voicecall.c
index 583e037..56fd858 100644
--- a/drivers/atmodem/voicecall.c
+++ b/drivers/atmodem/voicecall.c
@@ -161,7 +161,8 @@ static void clcc_poll_cb(gboolean ok, GAtResult *result=
, gpointer user_data)
 		nc =3D n ? n->data : NULL;
 		oc =3D o ? o->data : NULL;
 =

-		if (nc && nc->status >=3D 2 && nc->status <=3D 5)
+		if (nc && nc->status >=3D CALL_STATUS_DIALING &&
+				nc->status <=3D CALL_STATUS_WAITING)
 			poll_again =3D TRUE;
 =

 		if (oc && (nc =3D=3D NULL || (nc->id > oc->id))) {
@@ -216,7 +217,8 @@ static void clcc_poll_cb(gboolean ok, GAtResult *result=
, gpointer user_data)
 			 * arrives, or RING is used, then signal the call
 			 * here
 			 */
-			if (nc->status =3D=3D 4 && (vd->flags & FLAG_NEED_CLIP)) {
+			if (nc->status =3D=3D CALL_STATUS_INCOMING &&
+					(vd->flags & FLAG_NEED_CLIP)) {
 				if (nc->type =3D=3D 0)
 					ofono_voicecall_notify(vc, nc);
 =

@@ -323,10 +325,10 @@ static void atd_cb(gboolean ok, GAtResult *result, gp=
ointer user_data)
 	for (l =3D vd->calls; l; l =3D l->next) {
 		call =3D l->data;
 =

-		if (call->status !=3D 0)
+		if (call->status !=3D CALL_STATUS_ACTIVE)
 			continue;
 =

-		call->status =3D 1;
+		call->status =3D CALL_STATUS_HELD;
 		ofono_voicecall_notify(vc, call);
 	}
 =

@@ -345,7 +347,7 @@ static void atd_cb(gboolean ok, GAtResult *result, gpoi=
nter user_data)
 	}
 =

 	/* Generate a voice call that was just dialed, we guess the ID */
-	call =3D create_call(vc, 0, 0, 2, num, type, validity);
+	call =3D create_call(vc, 0, 0, CALL_STATUS_DIALING, num, type, validity);
 	if (call =3D=3D NULL) {
 		ofono_error("Unable to malloc, call tracking will fail!");
 		return;
@@ -467,14 +469,16 @@ static void at_hold_all_active(struct ofono_voicecall=
 *vc,
 static void at_release_all_held(struct ofono_voicecall *vc,
 				ofono_voicecall_cb_t cb, void *data)
 {
-	unsigned int held_status =3D 0x1 << 1;
+	unsigned int held_status =3D 1 << CALL_STATUS_HELD;
 	at_template("AT+CHLD=3D0", vc, generic_cb, held_status, cb, data);
 }
 =

 static void at_set_udub(struct ofono_voicecall *vc,
 			ofono_voicecall_cb_t cb, void *data)
 {
-	unsigned int incoming_or_waiting =3D (0x1 << 4) | (0x1 << 5);
+	unsigned int incoming_or_waiting =3D
+		(1 << CALL_STATUS_INCOMING) | (1 << CALL_STATUS_WAITING);
+
 	at_template("AT+CHLD=3D0", vc, generic_cb, incoming_or_waiting,
 			cb, data);
 }
@@ -547,7 +551,8 @@ static void at_deflect(struct ofono_voicecall *vc,
 			ofono_voicecall_cb_t cb, void *data)
 {
 	char buf[128];
-	unsigned int incoming_or_waiting =3D (0x1 << 4) | (0x1 << 5);
+	unsigned int incoming_or_waiting =3D
+		(1 << CALL_STATUS_INCOMING) | (1 << CALL_STATUS_WAITING);
 =

 	snprintf(buf, sizeof(buf), "AT+CTFR=3D%s,%d", ph->number, ph->type);
 	at_template(buf, vc, generic_cb, incoming_or_waiting, cb, data);
@@ -631,17 +636,19 @@ static void ring_notify(GAtResult *result, gpointer u=
ser_data)
 	struct ofono_call *call;
 =

 	/* See comment in CRING */
-	if (g_slist_find_custom(vd->calls, GINT_TO_POINTER(5),
+	if (g_slist_find_custom(vd->calls,
+				GINT_TO_POINTER(CALL_STATUS_WAITING),
 				at_util_call_compare_by_status))
 		return;
 =

 	/* RING can repeat, ignore if we already have an incoming call */
-	if (g_slist_find_custom(vd->calls, GINT_TO_POINTER(4),
+	if (g_slist_find_custom(vd->calls,
+				GINT_TO_POINTER(CALL_STATUS_INCOMING),
 				at_util_call_compare_by_status))
 		return;
 =

 	/* Generate an incoming call of unknown type */
-	call =3D create_call(vc, 9, 1, 4, NULL, 128, 2);
+	call =3D create_call(vc, 9, 1, CALL_STATUS_INCOMING, NULL, 128, 2);
 	if (call =3D=3D NULL) {
 		ofono_error("Couldn't create call, call management is fubar!");
 		return;
@@ -667,12 +674,14 @@ static void cring_notify(GAtResult *result, gpointer =
user_data)
 	 * the stage change.  If this happens, simply ignore the RING/CRING
 	 * when a waiting call exists (cannot have waiting + incoming in GSM)
 	 */
-	if (g_slist_find_custom(vd->calls, GINT_TO_POINTER(5),
+	if (g_slist_find_custom(vd->calls,
+				GINT_TO_POINTER(CALL_STATUS_WAITING),
 				at_util_call_compare_by_status))
 		return;
 =

 	/* CRING can repeat, ignore if we already have an incoming call */
-	if (g_slist_find_custom(vd->calls, GINT_TO_POINTER(4),
+	if (g_slist_find_custom(vd->calls,
+				GINT_TO_POINTER(CALL_STATUS_INCOMING),
 				at_util_call_compare_by_status))
 		return;
 =

@@ -692,7 +701,7 @@ static void cring_notify(GAtResult *result, gpointer us=
er_data)
 		type =3D 9;
 =

 	/* Generate an incoming call */
-	create_call(vc, type, 1, 4, NULL, 128, 2);
+	create_call(vc, type, 1, CALL_STATUS_INCOMING, NULL, 128, 2);
 =

 	/* We have a call, and call type but don't know the number and
 	 * must wait for the CLIP to arrive before announcing the call.
@@ -715,7 +724,8 @@ static void clip_notify(GAtResult *result, gpointer use=
r_data)
 	GSList *l;
 	struct ofono_call *call;
 =

-	l =3D g_slist_find_custom(vd->calls, GINT_TO_POINTER(4),
+	l =3D g_slist_find_custom(vd->calls,
+				GINT_TO_POINTER(CALL_STATUS_INCOMING),
 				at_util_call_compare_by_status);
 	if (l =3D=3D NULL) {
 		ofono_error("CLIP for unknown call");
@@ -776,7 +786,8 @@ static void cdip_notify(GAtResult *result, gpointer use=
r_data)
 	GSList *l;
 	struct ofono_call *call;
 =

-	l =3D g_slist_find_custom(vd->calls, GINT_TO_POINTER(4),
+	l =3D g_slist_find_custom(vd->calls,
+				GINT_TO_POINTER(CALL_STATUS_INCOMING),
 				at_util_call_compare_by_status);
 	if (l =3D=3D NULL) {
 		ofono_error("CDIP for unknown call");
@@ -824,7 +835,8 @@ static void cnap_notify(GAtResult *result, gpointer use=
r_data)
 	GSList *l;
 	struct ofono_call *call;
 =

-	l =3D g_slist_find_custom(vd->calls, GINT_TO_POINTER(4),
+	l =3D g_slist_find_custom(vd->calls,
+				GINT_TO_POINTER(CALL_STATUS_INCOMING),
 				at_util_call_compare_by_status);
 	if (l =3D=3D NULL) {
 		ofono_error("CNAP for unknown call");
@@ -877,7 +889,8 @@ static void ccwa_notify(GAtResult *result, gpointer use=
r_data)
 	struct ofono_call *call;
 =

 	/* Some modems resend CCWA, ignore it the second time around */
-	if (g_slist_find_custom(vd->calls, GINT_TO_POINTER(5),
+	if (g_slist_find_custom(vd->calls,
+				GINT_TO_POINTER(CALL_STATUS_WAITING),
 				at_util_call_compare_by_status))
 		return;
 =

@@ -908,7 +921,7 @@ static void ccwa_notify(GAtResult *result, gpointer use=
r_data)
 =

 	DBG("%s %d %d %d", num, num_type, cls, validity);
 =

-	call =3D create_call(vc, class_to_call_type(cls), 1, 5,
+	call =3D create_call(vc, class_to_call_type(cls), 1, CALL_STATUS_WAITING,
 				num, num_type, validity);
 	if (call =3D=3D NULL) {
 		ofono_error("Unable to malloc. Call management is fubar");
-- =

1.7.0.4


--===============7848219853817159872==--

