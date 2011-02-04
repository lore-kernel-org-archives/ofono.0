Content-Type: multipart/mixed; boundary="===============8656482510824564924=="
MIME-Version: 1.0
From: Jeevaka Badrappan <jeevaka.badrappan@elektrobit.com>
Subject: [PATCH 3/5] huaweimodem: Use defined call_status enum
Date: Fri, 04 Feb 2011 12:35:41 -0800
Message-ID: <1296851743-14483-4-git-send-email-jeevaka.badrappan@elektrobit.com>
In-Reply-To: <1296851743-14483-1-git-send-email-jeevaka.badrappan@elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8656482510824564924==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 drivers/huaweimodem/voicecall.c |   20 ++++++++++++--------
 1 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/drivers/huaweimodem/voicecall.c b/drivers/huaweimodem/voicecal=
l.c
index 53377d9..1800763 100644
--- a/drivers/huaweimodem/voicecall.c
+++ b/drivers/huaweimodem/voicecall.c
@@ -38,6 +38,7 @@
 #include "gatchat.h"
 #include "gatresult.h"
 =

+#include "common.h"
 #include "huaweimodem.h"
 =

 static const char *none_prefix[] =3D { NULL };
@@ -170,8 +171,9 @@ static void cring_notify(GAtResult *result, gpointer us=
er_data)
 	int id;
 =

 	/* CRING can repeat, ignore if we already have an incoming call */
-	if (g_slist_find_custom(vd->calls, GINT_TO_POINTER(4),
-					at_util_call_compare_by_status))
+	if (g_slist_find_custom(vd->calls,
+				GINT_TO_POINTER(CALL_STATUS_INCOMING),
+				at_util_call_compare_by_status))
 		return;
 =

 	g_at_result_iter_init(&iter, result);
@@ -192,7 +194,7 @@ static void cring_notify(GAtResult *result, gpointer us=
er_data)
 	id =3D ofono_voicecall_get_next_callid(vc);
 =

 	/* Generate an incoming call */
-	create_call(vc, type, 1, 4, NULL, 128, 2, id);
+	create_call(vc, type, 1, CALL_STATUS_INCOMING, NULL, 128, 2, id);
 =

 	/* Assume the CLIP always arrives, and we signal the call there */
 	DBG("%d", type);
@@ -208,8 +210,9 @@ static void clip_notify(GAtResult *result, gpointer use=
r_data)
 	GSList *l;
 	struct ofono_call *call;
 =

-	l =3D g_slist_find_custom(vd->calls, GINT_TO_POINTER(4),
-					at_util_call_compare_by_status);
+	l =3D g_slist_find_custom(vd->calls,
+				GINT_TO_POINTER(CALL_STATUS_INCOMING),
+				at_util_call_compare_by_status);
 	if (l =3D=3D NULL) {
 		ofono_error("CLIP for unknown call");
 		return;
@@ -307,7 +310,8 @@ static void orig_notify(GAtResult *result, gpointer use=
r_data)
 =

 	ofono_info("Call origin: id %d type %d", call_id, call_type);
 =

-	call =3D create_call(vc, call_type, 0, 2, NULL, 128, 2, call_id);
+	call =3D create_call(vc, call_type, 0, CALL_STATUS_DIALING, NULL, 128, 2,
+			    call_id);
 	if (call =3D=3D NULL) {
 		ofono_error("Unable to malloc, call tracking will fail!");
 		return;
@@ -345,7 +349,7 @@ static void conf_notify(GAtResult *result, gpointer use=
r_data)
 =

 	/* Set call to alerting */
 	call =3D l->data;
-	call->status =3D 3;
+	call->status =3D CALL_STATUS_ALERTING;
 =

 	if (call->type =3D=3D 0)
 		ofono_voicecall_notify(vc, call);
@@ -382,7 +386,7 @@ static void conn_notify(GAtResult *result, gpointer use=
r_data)
 =

 	/* Set call to active */
 	call =3D l->data;
-	call->status =3D 0;
+	call->status =3D CALL_STATUS_ACTIVE;
 =

 	if (call->type =3D=3D 0)
 		ofono_voicecall_notify(vc, call);
-- =

1.7.0.4


--===============8656482510824564924==--

