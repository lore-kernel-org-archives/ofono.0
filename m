Content-Type: multipart/mixed; boundary="===============1069781110104278688=="
MIME-Version: 1.0
From: Slava Monich <slava.monich@jolla.com>
Subject: [PATCH 03/12] hfpmodem: Use new voicecall enums
Date: Thu, 21 Jun 2018 20:20:52 +0300
Message-ID: <1529601661-4856-3-git-send-email-slava.monich@jolla.com>
In-Reply-To: <1529601661-4856-1-git-send-email-slava.monich@jolla.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1069781110104278688==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 drivers/hfpmodem/voicecall.c | 92 +++++++++++++++++++++++-----------------=
----
 1 file changed, 48 insertions(+), 44 deletions(-)

diff --git a/drivers/hfpmodem/voicecall.c b/drivers/hfpmodem/voicecall.c
index 6ffe9d5..1ab2aa2 100644
--- a/drivers/hfpmodem/voicecall.c
+++ b/drivers/hfpmodem/voicecall.c
@@ -84,13 +84,14 @@ static GSList *find_dialing(GSList *calls)
 {
 	GSList *c;
 =

-	c =3D g_slist_find_custom(calls, GINT_TO_POINTER(CALL_STATUS_DIALING),
+	c =3D g_slist_find_custom(calls,
+				GINT_TO_POINTER(OFONO_CALL_STATUS_DIALING),
 				at_util_call_compare_by_status);
 =

 	if (c =3D=3D NULL)
 		c =3D g_slist_find_custom(calls,
-					GINT_TO_POINTER(CALL_STATUS_ALERTING),
-					at_util_call_compare_by_status);
+				GINT_TO_POINTER(OFONO_CALL_STATUS_ALERTING),
+				at_util_call_compare_by_status);
 =

 	return c;
 }
@@ -104,7 +105,8 @@ static void voicecall_notify(gpointer value, gpointer u=
ser)
 }
 =

 static struct ofono_call *create_call(struct ofono_voicecall *vc, int type,
-					int direction, int status,
+					enum ofono_call_direction direction,
+					enum ofono_call_status status,
 					const char *num, int num_type, int clip)
 {
 	struct voicecall_data *d =3D ofono_voicecall_get_data(vc);
@@ -230,10 +232,10 @@ static void clcc_poll_cb(gboolean ok, GAtResult *resu=
lt, gpointer user_data)
 		nc =3D n ? n->data : NULL;
 		oc =3D o ? o->data : NULL;
 =

-		if (nc && (nc->status =3D=3D CALL_STATUS_ACTIVE))
+		if (nc && (nc->status =3D=3D OFONO_CALL_STATUS_ACTIVE))
 			num_active++;
 =

-		if (nc && (nc->status =3D=3D CALL_STATUS_HELD))
+		if (nc && (nc->status =3D=3D OFONO_CALL_STATUS_HELD))
 			num_held++;
 =

 		if (oc && (nc =3D=3D NULL || (nc->id > oc->id))) {
@@ -361,14 +363,15 @@ static void atd_cb(gboolean ok, GAtResult *result, gp=
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

-	call =3D create_call(vc, 0, 0, CALL_STATUS_DIALING, NULL, type, validity);
+	call =3D create_call(vc, 0, OFONO_CALL_DIRECTION_MOBILE_ORIGINATED,
+			OFONO_CALL_STATUS_DIALING, NULL, type, validity);
 	if (call =3D=3D NULL) {
 		ofono_error("Unable to allocate call, "
 				"call tracking will fail!");
@@ -478,10 +481,10 @@ static void hfp_answer(struct ofono_voicecall *vc,
 static void hfp_hangup(struct ofono_voicecall *vc,
 			ofono_voicecall_cb_t cb, void *data)
 {
-	unsigned int affected =3D (1 << CALL_STATUS_INCOMING) |
-				(1 << CALL_STATUS_DIALING) |
-				(1 << CALL_STATUS_ALERTING) |
-				(1 << CALL_STATUS_ACTIVE);
+	unsigned int affected =3D (1 << OFONO_CALL_STATUS_INCOMING) |
+				(1 << OFONO_CALL_STATUS_DIALING) |
+				(1 << OFONO_CALL_STATUS_ALERTING) |
+				(1 << OFONO_CALL_STATUS_ACTIVE);
 =

 	/* Hangup current active call */
 	hfp_template("AT+CHUP", vc, generic_cb, affected, cb, data);
@@ -504,7 +507,7 @@ static void hfp_release_all_held(struct ofono_voicecall=
 *vc,
 				ofono_voicecall_cb_t cb, void *data)
 {
 	struct voicecall_data *vd =3D ofono_voicecall_get_data(vc);
-	unsigned int held_status =3D 1 << CALL_STATUS_HELD;
+	unsigned int held_status =3D 1 << OFONO_CALL_STATUS_HELD;
 =

 	if (vd->ag_mpty_features & HFP_AG_CHLD_0) {
 		hfp_template("AT+CHLD=3D0", vc, generic_cb, held_status,
@@ -519,7 +522,7 @@ static void hfp_set_udub(struct ofono_voicecall *vc,
 			ofono_voicecall_cb_t cb, void *data)
 {
 	struct voicecall_data *vd =3D ofono_voicecall_get_data(vc);
-	unsigned int incoming_or_waiting =3D 1 << CALL_STATUS_WAITING;
+	unsigned int incoming_or_waiting =3D 1 << OFONO_CALL_STATUS_WAITING;
 =

 	if (vd->ag_mpty_features & HFP_AG_CHLD_0) {
 		hfp_template("AT+CHLD=3D0", vc, generic_cb, incoming_or_waiting,
@@ -759,7 +762,7 @@ static void ccwa_notify(GAtResult *result, gpointer use=
r_data)
 =

 	/* CCWA can repeat, ignore if we already have an waiting call */
 	if (g_slist_find_custom(vd->calls,
-				GINT_TO_POINTER(CALL_STATUS_WAITING),
+				GINT_TO_POINTER(OFONO_CALL_STATUS_WAITING),
 				at_util_call_compare_by_status))
 		return;
 =

@@ -768,7 +771,7 @@ static void ccwa_notify(GAtResult *result, gpointer use=
r_data)
 	 * as our previous WAITING call has been promoted to INCOMING
 	 */
 	if (g_slist_find_custom(vd->calls,
-				GINT_TO_POINTER(CALL_STATUS_INCOMING),
+				GINT_TO_POINTER(OFONO_CALL_STATUS_INCOMING),
 				at_util_call_compare_by_status))
 		return;
 =

@@ -791,8 +794,8 @@ static void ccwa_notify(GAtResult *result, gpointer use=
r_data)
 =

 	DBG("ccwa_notify: %s %d %d", num, num_type, validity);
 =

-	call =3D create_call(vc, 0, 1, CALL_STATUS_WAITING, num, num_type,
-				validity);
+	call =3D create_call(vc, 0, OFONO_CALL_DIRECTION_MOBILE_TERMINATED,
+			OFONO_CALL_STATUS_WAITING, num, num_type, validity);
 =

 	if (call =3D=3D NULL) {
 		ofono_error("malloc call struct failed.  "
@@ -811,7 +814,7 @@ static gboolean clip_timeout(gpointer user_data)
 	struct ofono_call *call;
 =

 	l =3D g_slist_find_custom(vd->calls,
-				GINT_TO_POINTER(CALL_STATUS_INCOMING),
+				GINT_TO_POINTER(OFONO_CALL_STATUS_INCOMING),
 				at_util_call_compare_by_status);
 =

 	if (l =3D=3D NULL)
@@ -840,13 +843,13 @@ static void ring_notify(GAtResult *result, gpointer u=
ser_data)
 =

 	/* RING can repeat, ignore if we already have an incoming call */
 	if (g_slist_find_custom(vd->calls,
-				GINT_TO_POINTER(CALL_STATUS_INCOMING),
+				GINT_TO_POINTER(OFONO_CALL_STATUS_INCOMING),
 				at_util_call_compare_by_status))
 		return;
 =

 	waiting =3D g_slist_find_custom(vd->calls,
-					GINT_TO_POINTER(CALL_STATUS_WAITING),
-					at_util_call_compare_by_status);
+				GINT_TO_POINTER(OFONO_CALL_STATUS_WAITING),
+				at_util_call_compare_by_status);
 =

 	/* If we started receiving RINGS but have a waiting call, most
 	 * likely all other calls were dropped and we just didn't get
@@ -861,14 +864,15 @@ static void ring_notify(GAtResult *result, gpointer u=
ser_data)
 		vd->calls =3D waiting;
 =

 		call =3D waiting->data;
-		call->status =3D CALL_STATUS_INCOMING;
+		call->status =3D OFONO_CALL_STATUS_INCOMING;
 		ofono_voicecall_notify(vc, call);
 =

 		return;
 	}
 =

 	/* Generate an incoming call of voice type */
-	call =3D create_call(vc, 0, 1, CALL_STATUS_INCOMING, NULL, 128, 2);
+	call =3D create_call(vc, 0, OFONO_CALL_DIRECTION_MOBILE_TERMINATED,
+				OFONO_CALL_STATUS_INCOMING, NULL, 128, 2);
 =

 	if (call =3D=3D NULL)
 		ofono_error("Couldn't create call, call management is fubar!");
@@ -890,7 +894,7 @@ static void clip_notify(GAtResult *result, gpointer use=
r_data)
 	struct ofono_call *call;
 =

 	l =3D g_slist_find_custom(vd->calls,
-				GINT_TO_POINTER(CALL_STATUS_INCOMING),
+				GINT_TO_POINTER(OFONO_CALL_STATUS_INCOMING),
 				at_util_call_compare_by_status);
 =

 	if (l =3D=3D NULL) {
@@ -951,15 +955,15 @@ static void ciev_call_notify(struct ofono_voicecall *=
vc,
 		 * calls, dialing calls are kept.  This also handles the
 		 * situation when dialing and waiting calls exist
 		 */
-		release_with_status(vc, CALL_STATUS_HELD);
-		release_with_status(vc, CALL_STATUS_ACTIVE);
+		release_with_status(vc, OFONO_CALL_STATUS_HELD);
+		release_with_status(vc, OFONO_CALL_STATUS_ACTIVE);
 =

 		/* Promote waiting to incoming if it is the last call */
 		if (vd->calls && vd->calls->next =3D=3D NULL) {
 			call =3D vd->calls->data;
 =

-			if (call->status =3D=3D CALL_STATUS_WAITING) {
-				call->status =3D CALL_STATUS_INCOMING;
+			if (call->status =3D=3D OFONO_CALL_STATUS_WAITING) {
+				call->status =3D OFONO_CALL_STATUS_INCOMING;
 				ofono_voicecall_notify(vc, call);
 			}
 		}
@@ -976,10 +980,10 @@ static void ciev_call_notify(struct ofono_voicecall *=
vc,
 		for (l =3D vd->calls; l; l =3D l->next) {
 			call =3D l->data;
 =

-			if (call->status =3D=3D CALL_STATUS_DIALING ||
-					call->status =3D=3D CALL_STATUS_ALERTING ||
-					call->status =3D=3D CALL_STATUS_INCOMING) {
-				call->status =3D CALL_STATUS_ACTIVE;
+			if (call->status =3D=3D OFONO_CALL_STATUS_DIALING ||
+				call->status =3D=3D OFONO_CALL_STATUS_ALERTING ||
+				call->status =3D=3D OFONO_CALL_STATUS_INCOMING) {
+				call->status =3D OFONO_CALL_STATUS_ACTIVE;
 				ofono_voicecall_notify(vc, call);
 			}
 		}
@@ -1006,8 +1010,8 @@ static void ciev_callsetup_notify(struct ofono_voicec=
all *vc,
 	dialing =3D find_dialing(vd->calls);
 =

 	waiting =3D g_slist_find_custom(vd->calls,
-					GINT_TO_POINTER(CALL_STATUS_WAITING),
-					at_util_call_compare_by_status);
+				GINT_TO_POINTER(OFONO_CALL_STATUS_WAITING),
+				at_util_call_compare_by_status);
 =

 	/* This is a truly bizarre case not covered at all by the specification
 	 * (yes, they are complete idiots).  Here we assume the other side is
@@ -1052,7 +1056,7 @@ static void ciev_callsetup_notify(struct ofono_voicec=
all *vc,
 			 * call=3D1 arrives first, then callsetup=3D0
 			 */
 =

-			call->status =3D CALL_STATUS_ACTIVE;
+			call->status =3D OFONO_CALL_STATUS_ACTIVE;
 			ofono_voicecall_notify(vc, call);
 		} else {
 			g_at_chat_send(vd->chat, "AT+CLCC", clcc_prefix,
@@ -1085,13 +1089,13 @@ static void ciev_callsetup_notify(struct ofono_voic=
ecall *vc,
 	case 3:
 	{
 		GSList *o =3D g_slist_find_custom(vd->calls,
-					GINT_TO_POINTER(CALL_STATUS_DIALING),
-					at_util_call_compare_by_status);
+				GINT_TO_POINTER(OFONO_CALL_STATUS_DIALING),
+				at_util_call_compare_by_status);
 =

 		if (o) {
 			struct ofono_call *call =3D o->data;
 =

-			call->status =3D CALL_STATUS_ALERTING;
+			call->status =3D OFONO_CALL_STATUS_ALERTING;
 			ofono_voicecall_notify(vc, call);
 		}
 =

@@ -1142,10 +1146,10 @@ static void ciev_callheld_notify(struct ofono_voice=
call *vc,
 			for (l =3D vd->calls; l; l =3D l->next) {
 				call =3D l->data;
 =

-				if (call->status !=3D CALL_STATUS_ACTIVE)
+				if (call->status !=3D OFONO_CALL_STATUS_ACTIVE)
 					continue;
 =

-				call->status =3D CALL_STATUS_HELD;
+				call->status =3D OFONO_CALL_STATUS_HELD;
 				ofono_voicecall_notify(vc, call);
 			}
 		} else if (callheld =3D=3D 1) {
@@ -1225,9 +1229,9 @@ static void hfp_clcc_cb(gboolean ok, GAtResult *resul=
t, gpointer user_data)
 	while (n) {
 		nc =3D n->data;
 =

-		if (nc->status =3D=3D CALL_STATUS_ACTIVE)
+		if (nc->status =3D=3D OFONO_CALL_STATUS_ACTIVE)
 			num_active++;
-		else if (nc->status =3D=3D CALL_STATUS_HELD)
+		else if (nc->status =3D=3D OFONO_CALL_STATUS_HELD)
 			num_held++;
 =

 		n =3D n->next;
-- =

1.9.1


--===============1069781110104278688==--

