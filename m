Content-Type: multipart/mixed; boundary="===============1708270914866124206=="
MIME-Version: 1.0
From: Pekka.Pessi@nokia.com
Subject: [fix-isi-voicecall PATCHv5 4/4] isi/voicecall: fix handling of
 waiting calls
Date: Fri, 03 Dec 2010 10:30:50 +0200
Message-ID: <1291365050-19739-5-git-send-email-Pekka.Pessi@nokia.com>
In-Reply-To: <1291365050-19739-4-git-send-email-Pekka.Pessi@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1708270914866124206==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Pekka Pessi <Pekka.Pessi@nokia.com>

Also, do not retrieve calls after isi_release_all_active() because
retrieving is now only an unwanted side-effect .
---
 drivers/isimodem/voicecall.c |  114 ++++++++++++++++++++------------------=
---
 1 files changed, 56 insertions(+), 58 deletions(-)

diff --git a/drivers/isimodem/voicecall.c b/drivers/isimodem/voicecall.c
index 9c1bec7..f2fd53a 100644
--- a/drivers/isimodem/voicecall.c
+++ b/drivers/isimodem/voicecall.c
@@ -1060,65 +1060,59 @@ static void isi_retrieve(struct ofono_voicecall *ov=
c,
 	isi_call_control_req(ovc, CALL_ID_HOLD, CALL_OP_RETRIEVE, 0, cb, data);
 }
 =

-static isi_call_req_step isi_wait_and_answer, isi_wait_and_retrieve;
+static void isi_wait_and_answer(struct isi_call_req_context *irc,
+				int id, int status)
+{
+	DBG("irc=3D%p id=3D%d status=3D%d", (void *)irc, id, status);
+
+	if (id !=3D irc->id)
+		return;
+
+	switch (status) {
+	case CALL_STATUS_MT_ALERTING:
+		isi_call_answer_req(irc->ovc, irc->id, irc->cb, irc->data);
+		isi_ctx_free(irc);
+		break;
+
+	default:
+		isi_ctx_return_failure(irc);
+		break;
+	}
+}
 =

 static void isi_release_all_active(struct ofono_voicecall *ovc,
 					ofono_voicecall_cb_t cb, void *data)
 {
 	/* AT+CHLD=3D1 */
 	struct isi_voicecall *ivc =3D ofono_voicecall_get_data(ovc);
-	int id =3D 0, waiting =3D 0, active =3D 0, hold =3D 0;
+	struct isi_call_req_context *irc;
+	int id;
+	int waiting_id =3D 0;
+	int active =3D 0;
 =

 	for (id =3D 1; id <=3D 7; id++) {
 		if (ivc->calls[id].call_id & CALL_ID_WAITING)
-			waiting++;
-		if (ivc->calls[id].call_id & CALL_ID_HOLD)
-			hold++;
+			waiting_id =3D id;
+
 		if (ivc->calls[id].call_id & CALL_ID_ACTIVE)
 			active++;
 	}
 =

-	if (active) {
-		struct isi_call_req_context *irc;
-
-		irc =3D isi_call_release_req(ovc, CALL_ID_ACTIVE,
-						CALL_CAUSE_RELEASE_BY_USER,
-						cb, data);
-
-		if (irc =3D=3D NULL)
-			;
-		else if (waiting)
-			isi_ctx_queue(irc, isi_wait_and_answer, 0);
-		else if (hold)
-			isi_ctx_queue(irc, isi_wait_and_retrieve, 0);
-	} else
+	if (!active) {
 		CALLBACK_WITH_FAILURE(cb, data);
-}
-
-static void isi_wait_and_answer(struct isi_call_req_context *irc,
-				int id, int status)
-{
-	DBG("irc=3D%p id=3D%d status=3D%d", (void *)irc, id, status);
-
-	switch (status) {
-	case CALL_STATUS_TERMINATED:
-		isi_answer(irc->ovc, irc->cb, irc->data);
-		isi_ctx_free(irc);
-		break;
+		return;
 	}
-}
 =

-static void isi_wait_and_retrieve(struct isi_call_req_context *irc,
-					int id, int status)
-{
-	DBG("irc=3D%p id=3D%u status=3D%u", (void *)irc, id, status);
+	irc =3D isi_call_release_req(ovc, CALL_ID_ACTIVE,
+					CALL_CAUSE_RELEASE_BY_USER,
+					cb, data);
+	if (irc =3D=3D NULL)
+		return;
 =

-	switch (status) {
-	case CALL_STATUS_TERMINATED:
-		isi_retrieve(irc->ovc, irc->cb, irc->data);
-		isi_ctx_free(irc);
-		break;
-	}
+	if (waiting_id)
+		isi_ctx_queue(irc, isi_wait_and_answer, waiting_id);
+
+	/* Retrieving held calls is currently a unwanted side-effect */
 }
 =

 static void isi_hold_all_active(struct ofono_voicecall *ovc,
@@ -1126,34 +1120,38 @@ static void isi_hold_all_active(struct ofono_voicec=
all *ovc,
 {
 	/* AT+CHLD=3D2 */
 	struct isi_voicecall *ivc =3D ofono_voicecall_get_data(ovc);
-	int id =3D 0, op =3D 0, waiting =3D 0, active =3D 0, hold =3D 0;
+	int id;
+	int waiting =3D 0;
+	int active =3D 0;
+	int hold =3D 0;
+	int op;
 =

 	for (id =3D 1; id <=3D 7; id++) {
 		if (ivc->calls[id].call_id & CALL_ID_WAITING)
 			waiting++;
-		if (ivc->calls[id].call_id & CALL_ID_HOLD)
+		else if (ivc->calls[id].call_id & CALL_ID_HOLD)
 			hold++;
-		if (ivc->calls[id].call_id & CALL_ID_ACTIVE)
+		else if (ivc->calls[id].call_id & CALL_ID_ACTIVE)
 			active++;
 	}
 =

 	if (waiting) {
 		isi_call_answer_req(ovc, CALL_ID_WAITING, cb, data);
-	} else if (hold) {
-		if (active) {
+		return;
+	}
+
+	if (active) {
+		if (hold)
 			op =3D CALL_OP_SWAP;
-			id =3D CALL_ID_ACTIVE;
-		} else {
-			op =3D CALL_OP_RETRIEVE;
-			id =3D CALL_ID_HOLD;
-		}
-		isi_call_control_req(ovc, id, op, 0, cb, data);
-	} else if (active) {
-		id =3D CALL_ID_ACTIVE, op =3D CALL_OP_HOLD;
-		isi_call_control_req(ovc, id, op, 0, cb, data);
-	} else {
+		else
+			op =3D CALL_OP_HOLD;
+
+		isi_call_control_req(ovc, CALL_ID_ACTIVE, op, 0, cb, data);
+
+	} else if (hold)
+		isi_retrieve(ovc, cb, data);
+	else
 		CALLBACK_WITH_FAILURE(cb, data);
-	}
 }
 =

 static void isi_release_specific(struct ofono_voicecall *ovc, int id,
-- =

1.7.1


--===============1708270914866124206==--

