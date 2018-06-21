Content-Type: multipart/mixed; boundary="===============2337071200931990762=="
MIME-Version: 1.0
From: Slava Monich <slava.monich@jolla.com>
Subject: [PATCH 04/12] huaweimodem: Use new voicecall enums
Date: Thu, 21 Jun 2018 20:20:53 +0300
Message-ID: <1529601661-4856-4-git-send-email-slava.monich@jolla.com>
In-Reply-To: <1529601661-4856-1-git-send-email-slava.monich@jolla.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2337071200931990762==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 drivers/huaweimodem/voicecall.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/drivers/huaweimodem/voicecall.c b/drivers/huaweimodem/voicecal=
l.c
index f55568d..36a16a1 100644
--- a/drivers/huaweimodem/voicecall.c
+++ b/drivers/huaweimodem/voicecall.c
@@ -49,7 +49,8 @@ struct voicecall_data {
 };
 =

 static struct ofono_call *create_call(struct ofono_voicecall *vc, int type,
-					int direction, int status,
+					enum ofono_call_direction direction,
+					enum ofono_call_status status,
 					const char *num, int num_type,
 					int clip, int id)
 {
@@ -178,7 +179,7 @@ static void cring_notify(GAtResult *result, gpointer us=
er_data)
 =

 	/* CRING can repeat, ignore if we already have an incoming call */
 	if (g_slist_find_custom(vd->calls,
-				GINT_TO_POINTER(CALL_STATUS_INCOMING),
+				GINT_TO_POINTER(OFONO_CALL_STATUS_INCOMING),
 				at_util_call_compare_by_status))
 		return;
 =

@@ -200,7 +201,8 @@ static void cring_notify(GAtResult *result, gpointer us=
er_data)
 	id =3D ofono_voicecall_get_next_callid(vc);
 =

 	/* Generate an incoming call */
-	create_call(vc, type, 1, CALL_STATUS_INCOMING, NULL, 128, 2, id);
+	create_call(vc, type, OFONO_CALL_DIRECTION_MOBILE_TERMINATED,
+				OFONO_CALL_STATUS_INCOMING, NULL, 128, 2, id);
 =

 	/* Assume the CLIP always arrives, and we signal the call there */
 	DBG("%d", type);
@@ -217,7 +219,7 @@ static void clip_notify(GAtResult *result, gpointer use=
r_data)
 	struct ofono_call *call;
 =

 	l =3D g_slist_find_custom(vd->calls,
-				GINT_TO_POINTER(CALL_STATUS_INCOMING),
+				GINT_TO_POINTER(OFONO_CALL_STATUS_INCOMING),
 				at_util_call_compare_by_status);
 	if (l =3D=3D NULL) {
 		ofono_error("CLIP for unknown call");
@@ -316,8 +318,9 @@ static void orig_notify(GAtResult *result, gpointer use=
r_data)
 =

 	ofono_info("Call origin: id %d type %d", call_id, call_type);
 =

-	call =3D create_call(vc, call_type, 0, CALL_STATUS_DIALING, NULL, 128, 2,
-			    call_id);
+	call =3D create_call(vc, call_type,
+			OFONO_CALL_DIRECTION_MOBILE_ORIGINATED,
+			OFONO_CALL_STATUS_DIALING, NULL, 128, 2, call_id);
 	if (call =3D=3D NULL) {
 		ofono_error("Unable to malloc, call tracking will fail!");
 		return;
@@ -355,7 +358,7 @@ static void conf_notify(GAtResult *result, gpointer use=
r_data)
 =

 	/* Set call to alerting */
 	call =3D l->data;
-	call->status =3D CALL_STATUS_ALERTING;
+	call->status =3D OFONO_CALL_STATUS_ALERTING;
 =

 	if (call->type =3D=3D 0)
 		ofono_voicecall_notify(vc, call);
@@ -392,7 +395,7 @@ static void conn_notify(GAtResult *result, gpointer use=
r_data)
 =

 	/* Set call to active */
 	call =3D l->data;
-	call->status =3D CALL_STATUS_ACTIVE;
+	call->status =3D OFONO_CALL_STATUS_ACTIVE;
 =

 	if (call->type =3D=3D 0)
 		ofono_voicecall_notify(vc, call);
-- =

1.9.1


--===============2337071200931990762==--

