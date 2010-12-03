Content-Type: multipart/mixed; boundary="===============6078464957770285465=="
MIME-Version: 1.0
From: Pekka.Pessi@nokia.com
Subject: [fix-isi-voicecall PATCHv5 3/4] isi/voicecall: avoid side-effects of
 release
Date: Fri, 03 Dec 2010 10:30:49 +0200
Message-ID: <1291365050-19739-4-git-send-email-Pekka.Pessi@nokia.com>
In-Reply-To: <1291365050-19739-3-git-send-email-Pekka.Pessi@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6078464957770285465==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Pekka Pessi <Pekka.Pessi@nokia.com>

If a call was held automatically when an another call was dialed or
answered, it gets retrieved when the other call is released unless
auto change features is explicitly disabled.

Drop cause_type parameter because it is never used.

Use cause code for busy when releasing incoming or waiting calls.
---
 drivers/isimodem/voicecall.c |   32 ++++++++++++++++----------------
 1 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/drivers/isimodem/voicecall.c b/drivers/isimodem/voicecall.c
index e7126a8..9c1bec7 100644
--- a/drivers/isimodem/voicecall.c
+++ b/drivers/isimodem/voicecall.c
@@ -699,12 +699,13 @@ static gboolean isi_call_answer_resp(GIsiClient *clie=
nt,
 =

 static struct isi_call_req_context *
 isi_call_release_req(struct ofono_voicecall *ovc,
-			uint8_t call_id, enum call_cause_type cause_type,
-			uint8_t cause, ofono_voicecall_cb_t cb, void *data)
+			uint8_t call_id, uint8_t cause,
+			ofono_voicecall_cb_t cb, void *data)
 {
 	uint8_t const req[] =3D {
-		CALL_RELEASE_REQ, call_id, 1,
-		CALL_CAUSE, 4, cause_type, cause,
+		CALL_RELEASE_REQ, call_id, 2,
+		CALL_CAUSE, 4, CALL_CAUSE_TYPE_CLIENT, cause,
+		CALL_STATE_AUTO_CHANGE, 4, 0, 0
 	};
 	size_t rlen =3D sizeof req;
 =

@@ -1008,7 +1009,8 @@ static void isi_hangup_current(struct ofono_voicecall=
 *ovc,
 	 * active calls or calls in progress.
 	 */
 	struct isi_voicecall *ivc =3D ofono_voicecall_get_data(ovc);
-	int id =3D 0;
+	int id;
+	uint8_t cause =3D CALL_CAUSE_RELEASE_BY_USER;
 =

 	for (id =3D 1; id <=3D 7; id++) {
 		if (ivc->calls[id].call_id & CALL_ID_WAITING)
@@ -1018,11 +1020,14 @@ static void isi_hangup_current(struct ofono_voiceca=
ll *ovc,
 =

 		switch (ivc->calls[id].status) {
 		case CALL_STATUS_CREATE:
+		case CALL_STATUS_MT_ALERTING:
+		case CALL_STATUS_ANSWERED:
+			goto release_by_id;
+
 		case CALL_STATUS_COMING:
 		case CALL_STATUS_PROCEEDING:
 		case CALL_STATUS_MO_ALERTING:
-		case CALL_STATUS_MT_ALERTING:
-		case CALL_STATUS_ANSWERED:
+			cause =3D CALL_CAUSE_BUSY_USER_REQUEST;
 			goto release_by_id;
 		}
 	}
@@ -1030,15 +1035,14 @@ static void isi_hangup_current(struct ofono_voiceca=
ll *ovc,
 	id =3D CALL_ID_ACTIVE;
 =

 release_by_id:
-	isi_call_release_req(ovc, id, CALL_CAUSE_TYPE_CLIENT,
-				CALL_CAUSE_RELEASE_BY_USER, cb, data);
+	isi_call_release_req(ovc, id, cause, cb, data);
 }
 =

 static void isi_release_all_held(struct ofono_voicecall *ovc,
 				ofono_voicecall_cb_t cb, void *data)
 {
 	/* AT+CHLD=3D0 (w/out incoming calls) */
-	isi_call_release_req(ovc, CALL_ID_HOLD, CALL_CAUSE_TYPE_CLIENT,
+	isi_call_release_req(ovc, CALL_ID_HOLD,
 				CALL_CAUSE_RELEASE_BY_USER, cb, data);
 }
 =

@@ -1047,8 +1051,7 @@ static void isi_set_udub(struct ofono_voicecall *ovc,
 {
 	/* Release waiting calls */
 	isi_call_release_req(ovc, CALL_ID_WAITING,
-		CALL_CAUSE_TYPE_CLIENT, CALL_CAUSE_BUSY_USER_REQUEST,
-		cb, data);
+				CALL_CAUSE_BUSY_USER_REQUEST, cb, data);
 }
 =

 static void isi_retrieve(struct ofono_voicecall *ovc,
@@ -1079,7 +1082,6 @@ static void isi_release_all_active(struct ofono_voice=
call *ovc,
 		struct isi_call_req_context *irc;
 =

 		irc =3D isi_call_release_req(ovc, CALL_ID_ACTIVE,
-						CALL_CAUSE_TYPE_CLIENT,
 						CALL_CAUSE_RELEASE_BY_USER,
 						cb, data);
 =

@@ -1176,9 +1178,7 @@ static void isi_release_specific(struct ofono_voiceca=
ll *ovc, int id,
 			break;
 		}
 =

-		isi_call_release_req(ovc, id,
-					CALL_CAUSE_TYPE_CLIENT, cause,
-					cb, data);
+		isi_call_release_req(ovc, id, cause, cb, data);
 	} else
 		CALLBACK_WITH_FAILURE(cb, data);
 }
-- =

1.7.1


--===============6078464957770285465==--

