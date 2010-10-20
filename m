Content-Type: multipart/mixed; boundary="===============3040008150855236461=="
MIME-Version: 1.0
From: Pekka.Pessi@nokia.com
Subject: [PATCHv3] isi: fix hangup_active and set_udub methods
Date: Wed, 20 Oct 2010 20:08:29 +0300
Message-ID: <1287594509-32711-1-git-send-email-Pekka.Pessi@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3040008150855236461==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Pekka Pessi <Pekka.Pessi@nokia.com>

The concept of "active" call seems to be overloaded.
---
 drivers/isimodem/voicecall.c |   60 +++++++++++++++++++++++++-------------=
---
 1 files changed, 36 insertions(+), 24 deletions(-)

diff --git a/drivers/isimodem/voicecall.c b/drivers/isimodem/voicecall.c
index 82f7eef..c3365f6 100644
--- a/drivers/isimodem/voicecall.c
+++ b/drivers/isimodem/voicecall.c
@@ -902,9 +902,9 @@ static int isi_call_status_to_clcc(struct isi_call cons=
t *call)
 		return 4;
 	case CALL_STATUS_PROCEEDING:
 		if ((call->mode_info & CALL_MODE_ORIGINATOR))
-			return 4;
+			return 4; /* MT */
 		else
-			return 2;
+			return 2; /* MO */
 	case CALL_STATUS_MO_ALERTING:
 		return 3;
 	case CALL_STATUS_MT_ALERTING:
@@ -986,10 +986,37 @@ static void isi_answer(struct ofono_voicecall *ovc,
 	isi_call_answer_req(ovc, CALL_ID_ALL, cb, data);
 }
 =

-static void isi_hangup_active(struct ofono_voicecall *ovc,
+static void isi_hangup_current(struct ofono_voicecall *ovc,
 			ofono_voicecall_cb_t cb, void *data)
 {
-	isi_call_release_req(ovc, CALL_ID_ACTIVE, CALL_CAUSE_TYPE_CLIENT,
+	/*
+	 * Hangup call(s) that are not held or waiting:
+	 * active calls or calls in progress.
+	 */
+	struct isi_voicecall *ivc =3D ofono_voicecall_get_data(ovc);
+	int id =3D 0;
+
+	for (id =3D 1; id <=3D 7; id++) {
+		if (ivc->calls[id].call_id & CALL_ID_WAITING)
+			continue;
+		if (ivc->calls[id].call_id & CALL_ID_HOLD)
+			continue;
+
+		switch (ivc->calls[id].status) {
+		case CALL_STATUS_CREATE:
+		case CALL_STATUS_COMING:
+		case CALL_STATUS_PROCEEDING:
+		case CALL_STATUS_MO_ALERTING:
+		case CALL_STATUS_MT_ALERTING:
+		case CALL_STATUS_ANSWERED:
+			goto release_by_id;
+		}
+	}
+
+	id =3D CALL_ID_ACTIVE;
+
+release_by_id:
+	isi_call_release_req(ovc, id, CALL_CAUSE_TYPE_CLIENT,
 				CALL_CAUSE_RELEASE_BY_USER, cb, data);
 }
 =

@@ -1004,25 +1031,10 @@ static void isi_release_all_held(struct ofono_voice=
call *ovc,
 static void isi_set_udub(struct ofono_voicecall *ovc,
 				ofono_voicecall_cb_t cb, void *data)
 {
-	/* AT+CHLD=3D0 (w/ incoming calls) */
-	struct isi_voicecall *ivc =3D ofono_voicecall_get_data(ovc);
-	int id =3D 0;
-
-	for (id =3D 1; id <=3D 7; id++) {
-		if (ivc->calls[id].status =3D=3D CALL_STATUS_WAITING)
-			break;
-		if (ivc->calls[id].status =3D=3D CALL_STATUS_MT_ALERTING)
-			break;
-		if (ivc->calls[id].status =3D=3D CALL_STATUS_COMING)
-			break;
-	}
-
-	if (id <=3D 7)
-		isi_call_release_req(ovc, id, CALL_CAUSE_TYPE_CLIENT,
-					CALL_CAUSE_BUSY_USER_REQUEST,
-					cb, data);
-	else
-		CALLBACK_WITH_FAILURE(cb, data);
+	/* Release waiting calls */
+	isi_call_release_req(ovc, CALL_ID_WAITING,
+		CALL_CAUSE_TYPE_CLIENT, CALL_CAUSE_BUSY_USER_REQUEST,
+		cb, data);
 }
 =

 static void isi_retrieve(struct ofono_voicecall *ovc,
@@ -1317,7 +1329,7 @@ static struct ofono_voicecall_driver driver =3D {
 	.remove			=3D isi_voicecall_remove,
 	.dial			=3D isi_dial,
 	.answer			=3D isi_answer,
-	.hangup_active		=3D isi_hangup_active,
+	.hangup_active		=3D isi_hangup_current,
 	.hold_all_active	=3D isi_hold_all_active,
 	.release_all_held	=3D isi_release_all_held,
 	.set_udub		=3D isi_set_udub,
-- =

1.7.1


--===============3040008150855236461==--

