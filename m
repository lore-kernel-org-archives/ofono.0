Content-Type: multipart/mixed; boundary="===============1238776051628057733=="
MIME-Version: 1.0
From: Zhenhua Zhang <zhenhua.zhang@intel.com>
Subject: [PATCH] Fix: Poll CLCC to replace the code in call_held=1
Date: Thu, 19 Nov 2009 11:21:16 +0800
Message-ID: <1258600876.5440.0.camel@zzhan17-mobl.ccr.corp.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1238776051628057733==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

When using CHLD=3D2x in multiparty call, call_held is 1 and we
should not swap all active->held. So we cannot save this pull
in private chat.
---
 drivers/hfpmodem/voicecall.c |   50
+++++------------------------------------
 1 files changed, 6 insertions(+), 44 deletions(-)

diff --git a/drivers/hfpmodem/voicecall.c b/drivers/hfpmodem/voicecall.c
index 3591b74..52cdfd7 100644
--- a/drivers/hfpmodem/voicecall.c
+++ b/drivers/hfpmodem/voicecall.c
@@ -60,7 +60,6 @@ struct voicecall_data {
 	int cind_val[HFP_INDICATOR_LAST];
 	unsigned int id_list;
 	unsigned int local_release;
-	ofono_bool_t ignore_callheld_1;
 };
 =

 struct release_id_req {
@@ -322,8 +321,6 @@ static void atd_cb(gboolean ok, GAtResult *result,
gpointer user_data)
 =

 		call->status =3D CALL_STATUS_HELD;
 		ofono_voicecall_notify(vc, call);
-
-		vd->ignore_callheld_1 =3D TRUE;
 	}
 =

 	call =3D create_call(vd, 0, 0, CALL_STATUS_DIALING, NULL, type,
validity);
@@ -839,15 +836,6 @@ static void ciev_callheld_notify(struct
ofono_voicecall *vc,
 	struct ofono_call *call;
 	unsigned int callheld =3D vd->cind_val[HFP_INDICATOR_CALLHELD];
 =

-	/* When ATD is sent when another call is active, we will receive
-	 * callheld=3D1, then callsetup=3D2.  We have already placed active
-	 * calls on hold in atd_cb, so ignore the callheld in this case
-	 */
-	if (vd->ignore_callheld_1 =3D=3D TRUE && value =3D=3D 1) {
-		vd->ignore_callheld_1 =3D FALSE;
-		goto out;
-	}
-
 	switch (value) {
 	case 0:
 		/* We have to poll here, we have no idea whether the call was
@@ -859,38 +847,13 @@ static void ciev_callheld_notify(struct
ofono_voicecall *vc,
 		break;
 =

 	case 1:
-	{
-		GSList *waiting;
-
-		waiting =3D g_slist_find_custom(vd->calls,
-					GINT_TO_POINTER(CALL_STATUS_WAITING),
-					at_util_call_compare_by_status);
-
-		for (l =3D vd->calls; l; l =3D l->next) {
-			call =3D l->data;
-
-			if (waiting) {
-				if (call->status =3D=3D CALL_STATUS_WAITING) {
-					call->status =3D CALL_STATUS_ACTIVE;
-					ofono_voicecall_notify(vc, call);
-				} else if (call->status =3D=3D CALL_STATUS_ACTIVE) {
-					call->status =3D CALL_STATUS_HELD;
-					ofono_voicecall_notify(vc, call);
-				}
-			} else {
-				if (call->status =3D=3D CALL_STATUS_ACTIVE) {
-					call->status =3D CALL_STATUS_HELD;
-					ofono_voicecall_notify(vc, call);
-				} else if (call->status =3D=3D CALL_STATUS_HELD) {
-					call->status =3D CALL_STATUS_ACTIVE;
-					ofono_voicecall_notify(vc, call);
-				}
-			}
-		}
-
+		/* We have to poll here, we have no idea whether the call was
+		 * accepted by CHLD=3D1 or swapped by CHLD=3D2 or one call was
+		 * chosed for private chat by CHLD=3D2x
+		 */
+		g_at_chat_send(vd->chat, "AT+CLCC", clcc_prefix,
+				clcc_poll_cb, vc, NULL);
 		break;
-	}
-
 	case 2:
 		if (callheld =3D=3D 0) {
 			for (l =3D vd->calls; l; l =3D l->next) {
@@ -907,7 +870,6 @@ static void ciev_callheld_notify(struct
ofono_voicecall *vc,
 			release_with_status(vc, CALL_STATUS_ACTIVE);
 	}
 =

-out:
 	vd->cind_val[HFP_INDICATOR_CALLHELD] =3D value;
 }
 =

-- =

1.6.2.5




--===============1238776051628057733==--

