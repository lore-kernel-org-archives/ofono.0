Content-Type: multipart/mixed; boundary="===============8518445912258343902=="
MIME-Version: 1.0
From: Pekka.Pessi@nokia.com
Subject: [isi-voicecall-fix PATCHv3 6/6] isi/voicecall: fix
 isi_release_all_active()
Date: Tue, 16 Nov 2010 19:05:24 +0200
Message-ID: <1289927124-30133-6-git-send-email-Pekka.Pessi@nokia.com>
In-Reply-To: <1289927124-30133-5-git-send-email-Pekka.Pessi@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8518445912258343902==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Pekka Pessi <Pekka.Pessi@nokia.com>

Handle to-be-waiting calls properly.
---
 drivers/isimodem/voicecall.c |   66 +++++++++++++++++++++++++++++---------=
---
 1 files changed, 46 insertions(+), 20 deletions(-)

diff --git a/drivers/isimodem/voicecall.c b/drivers/isimodem/voicecall.c
index cdd5d11..360994a 100644
--- a/drivers/isimodem/voicecall.c
+++ b/drivers/isimodem/voicecall.c
@@ -292,6 +292,23 @@ static int isi_call_status_to_clcc(struct isi_voicecal=
l const *ivc,
 	return CLCC_STATUS_ACTIVE;
 }
 =

+static gboolean is_call_waiting(struct isi_voicecall const *ivc,
+				struct isi_call const *call)
+{
+	if (!(call->mode_info & CALL_MODE_ORIGINATOR))
+		return FALSE;
+
+	switch (call->status) {
+	case CALL_STATUS_COMING:
+	case CALL_STATUS_PROCEEDING:
+		return isi_call_waiting_or_incoming(ivc) =3D=3D CLCC_STATUS_WAITING;
+	case CALL_STATUS_WAITING:
+		return TRUE;
+	}
+
+	return FALSE;
+}
+
 static struct ofono_call isi_call_as_ofono_call(struct isi_voicecall const=
 *ivc,
 						struct isi_call const *call)
 {
@@ -1119,35 +1136,40 @@ static isi_call_req_step isi_wait_and_answer, isi_w=
ait_and_retrieve;
 static void isi_release_all_active(struct ofono_voicecall *ovc,
 					ofono_voicecall_cb_t cb, void *data)
 {
-	/* AT+CHLD=3D1 */
 	struct isi_voicecall *ivc =3D ofono_voicecall_get_data(ovc);
-	int id =3D 0, waiting =3D 0, active =3D 0, hold =3D 0;
+	struct isi_call_req_context *irc;
+	int id;
+	int waiting_id =3D 0;
+	int active =3D 0;
+	int hold =3D 0;
 =

 	for (id =3D 1; id <=3D 7; id++) {
-		if (ivc->calls[id].call_id & CALL_ID_WAITING)
-			waiting++;
+		if (is_call_waiting(ivc, &ivc->calls[id]))
+			waiting_id =3D id;
+
 		if (ivc->calls[id].call_id & CALL_ID_HOLD)
 			hold++;
+
 		if (ivc->calls[id].call_id & CALL_ID_ACTIVE)
 			active++;
 	}
 =

-	if (active) {
-		struct isi_call_req_context *irc;
-
-		irc =3D isi_call_release_req(ovc, CALL_ID_ACTIVE,
-						CALL_CAUSE_TYPE_CLIENT,
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
+		return;
+	}
+
+	irc =3D isi_call_release_req(ovc, CALL_ID_ACTIVE,
+					CALL_CAUSE_TYPE_CLIENT,
+					CALL_CAUSE_RELEASE_BY_USER,
+					cb, data);
+	if (!irc)
+		return;
+
+	if (waiting_id)
+		isi_ctx_queue(irc, isi_wait_and_answer, waiting_id);
+	else if (hold)
+		isi_ctx_queue(irc, isi_wait_and_retrieve, 0);
 }
 =

 static void isi_wait_and_answer(struct isi_call_req_context *irc,
@@ -1155,8 +1177,10 @@ static void isi_wait_and_answer(struct isi_call_req_=
context *irc,
 {
 	DBG("irc=3D%p event=3D%u", (void *)irc, event);
 	switch (event) {
+	case CALL_STATUS_MO_RELEASE:
+	case CALL_STATUS_MT_RELEASE:
 	case CALL_STATUS_TERMINATED:
-		isi_answer(irc->ovc, irc->cb, irc->data);
+		isi_call_answer_req(irc->ovc, irc->id, irc->cb, irc->data);
 		isi_ctx_free(irc);
 		break;
 	}
@@ -1167,6 +1191,8 @@ static void isi_wait_and_retrieve(struct isi_call_req=
_context *irc,
 {
 	DBG("irc=3D%p event=3D%u", (void *)irc, event);
 	switch (event) {
+	case CALL_STATUS_MO_RELEASE:
+	case CALL_STATUS_MT_RELEASE:
 	case CALL_STATUS_TERMINATED:
 		isi_retrieve(irc->ovc, irc->cb, irc->data);
 		isi_ctx_free(irc);
-- =

1.7.1


--===============8518445912258343902==--

