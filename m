Content-Type: multipart/mixed; boundary="===============0511846201657889635=="
MIME-Version: 1.0
From: Jeevaka Badrappan <jeevaka.badrappan@elektrobit.com>
Subject: [PATCH v2 4/5] ifxmodem: Use defined call_status enum
Date: Sat, 05 Feb 2011 05:03:02 -0800
Message-ID: <1296910983-20402-5-git-send-email-jeevaka.badrappan@elektrobit.com>
In-Reply-To: <1296910983-20402-1-git-send-email-jeevaka.badrappan@elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0511846201657889635==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 drivers/ifxmodem/voicecall.c |   33 +++++++++++++++++++++------------
 1 files changed, 21 insertions(+), 12 deletions(-)

diff --git a/drivers/ifxmodem/voicecall.c b/drivers/ifxmodem/voicecall.c
index e7f72fc..5ff3bcc 100644
--- a/drivers/ifxmodem/voicecall.c
+++ b/drivers/ifxmodem/voicecall.c
@@ -38,6 +38,7 @@
 #include "gatchat.h"
 #include "gatresult.h"
 =

+#include "common.h"
 #include "ifxmodem.h"
 =

 static const char *none_prefix[] =3D { NULL };
@@ -143,7 +144,8 @@ static void xcallstat_notify(GAtResult *result, gpointe=
r user_data)
 		 * In the case of incoming, we will get the info from CLIP
 		 * indications.
 		 */
-		if (status !=3D 4 && status !=3D 5) {
+		if (status !=3D CALL_STATUS_INCOMING &&
+				    status !=3D CALL_STATUS_WAITING) {
 			ofono_info("Received an XCALLSTAT for an untracked"
 					" call, this indicates a bug!");
 			return;
@@ -155,7 +157,7 @@ static void xcallstat_notify(GAtResult *result, gpointe=
r user_data)
 	call =3D l->data;
 =

 	/* Check if call has been disconnected */
-	if (status =3D=3D 6) {
+	if (status =3D=3D CALL_STATUS_DISCONNECTED) {
 		enum ofono_disconnect_reason r;
 =

 		if (vd->local_release & (0x1 << call->id))
@@ -282,7 +284,7 @@ static void atd_cb(gboolean ok, GAtResult *result, gpoi=
nter user_data)
 	}
 =

 	/* Generate a voice call that was just dialed, we guess the ID */
-	call =3D create_call(vc, 0, 0, 2, num, type, validity);
+	call =3D create_call(vc, 0, 0, CALL_STATUS_DIALING, num, type, validity);
 	if (call =3D=3D NULL) {
 		ofono_error("Unable to malloc, call tracking will fail!");
 		return;
@@ -390,14 +392,16 @@ static void ifx_hold_all_active(struct ofono_voicecal=
l *vc,
 static void ifx_release_all_held(struct ofono_voicecall *vc,
 				ofono_voicecall_cb_t cb, void *data)
 {
-	unsigned int held_status =3D 0x1 << 1;
+	unsigned int held_status =3D 1 << CALL_STATUS_HELD;
 	ifx_template("AT+CHLD=3D0", vc, generic_cb, held_status, cb, data);
 }
 =

 static void ifx_set_udub(struct ofono_voicecall *vc,
 			ofono_voicecall_cb_t cb, void *data)
 {
-	unsigned int incoming_or_waiting =3D (0x1 << 4) | (0x1 << 5);
+	unsigned int incoming_or_waiting =3D
+		(1 << CALL_STATUS_INCOMING) | (1 << CALL_STATUS_WAITING);
+
 	ifx_template("AT+CHLD=3D0", vc, generic_cb, incoming_or_waiting,
 			cb, data);
 }
@@ -470,7 +474,8 @@ static void ifx_deflect(struct ofono_voicecall *vc,
 			ofono_voicecall_cb_t cb, void *data)
 {
 	char buf[128];
-	unsigned int incoming_or_waiting =3D (0x1 << 4) | (0x1 << 5);
+	unsigned int incoming_or_waiting =3D
+		(1 << CALL_STATUS_INCOMING) | (1 << CALL_STATUS_WAITING);
 =

 	snprintf(buf, sizeof(buf), "AT+CTFR=3D%s,%d", ph->number, ph->type);
 	ifx_template(buf, vc, generic_cb, incoming_or_waiting, cb, data);
@@ -541,12 +546,14 @@ static void cring_notify(GAtResult *result, gpointer =
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

@@ -566,7 +573,7 @@ static void cring_notify(GAtResult *result, gpointer us=
er_data)
 		type =3D 9;
 =

 	/* Generate an incoming call */
-	create_call(vc, type, 1, 4, NULL, 128, 2);
+	create_call(vc, type, 1, CALL_STATUS_INCOMING, NULL, 128, 2);
 =

 	/* Assume the CLIP always arrives, and we signal the call there */
 	DBG("cring_notify");
@@ -582,7 +589,8 @@ static void clip_notify(GAtResult *result, gpointer use=
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
@@ -637,7 +645,8 @@ static void ccwa_notify(GAtResult *result, gpointer use=
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

@@ -668,7 +677,7 @@ static void ccwa_notify(GAtResult *result, gpointer use=
r_data)
 =

 	DBG("ccwa_notify: %s %d %d %d", num, num_type, cls, validity);
 =

-	call =3D create_call(vc, class_to_call_type(cls), 1, 5,
+	call =3D create_call(vc, class_to_call_type(cls), 1, CALL_STATUS_WAITING,
 				num, num_type, validity);
 	if (call =3D=3D NULL) {
 		ofono_error("Unable to malloc. Call management is fubar");
-- =

1.7.0.4


--===============0511846201657889635==--

