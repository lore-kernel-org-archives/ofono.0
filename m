Content-Type: multipart/mixed; boundary="===============8759919304256728991=="
MIME-Version: 1.0
From: Pekka.Pessi@nokia.com
Subject: [isi-voicecall-fix PATCHv3 4/6] isi/voicecall: fix answering early
 incoming calls
Date: Tue, 16 Nov 2010 19:05:22 +0200
Message-ID: <1289927124-30133-4-git-send-email-Pekka.Pessi@nokia.com>
In-Reply-To: <1289927124-30133-3-git-send-email-Pekka.Pessi@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8759919304256728991==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Pekka Pessi <Pekka.Pessi@nokia.com>

The voicecall driver must wait until the incoming call is mt-alerting or
waiting before answering.
---
 drivers/isimodem/voicecall.c |   49 ++++++++++++++++++++++++++++++++++++++=
+++-
 1 files changed, 48 insertions(+), 1 deletions(-)

diff --git a/drivers/isimodem/voicecall.c b/drivers/isimodem/voicecall.c
index 60052d4..76aa8f5 100644
--- a/drivers/isimodem/voicecall.c
+++ b/drivers/isimodem/voicecall.c
@@ -671,18 +671,65 @@ static void isi_call_status_ind_cb(GIsiClient *client,
 		isi_call_notify(ovc, call);
 }
 =

+static void isi_wait_incoming(struct isi_call_req_context *irc, int event);
+
 static struct isi_call_req_context *
 isi_call_answer_req(struct ofono_voicecall *ovc,
 			uint8_t call_id, ofono_voicecall_cb_t cb, void *data)
 {
+	struct isi_voicecall *ivc =3D ofono_voicecall_get_data(ovc);
+	int id;
+
 	uint8_t const req[] =3D {
 		CALL_ANSWER_REQ, call_id, 0
 	};
 	size_t rlen =3D sizeof req;
 =

+	for (id =3D 1; id <=3D 7; id++) {
+		struct isi_call_req_context *irc;
+
+		if (!(ivc->calls[id].mode_info & CALL_MODE_ORIGINATOR))
+			continue;
+
+		if (ivc->calls[id].status !=3D CALL_STATUS_PROCEEDING &&
+				ivc->calls[id].status !=3D CALL_STATUS_COMING)
+			continue;
+
+		irc =3D isi_call_req_new(ovc, cb, data);
+		if (irc)
+			isi_ctx_queue(irc, isi_wait_incoming, id);
+
+		return irc;
+	}
+
 	return isi_call_req(ovc, req, rlen, isi_call_answer_resp, cb, data);
 }
 =

+static void isi_wait_incoming(struct isi_call_req_context *irc,
+				int event)
+{
+	struct isi_voicecall *ivc;
+
+	DBG("irc=3D%p event=3D%u", (void *)irc, event);
+
+	switch (event) {
+	case CALL_STATUS_MT_ALERTING:
+	case CALL_STATUS_WAITING:
+		isi_call_answer_req(irc->ovc, irc->id, irc->cb, irc->data);
+		isi_ctx_free(irc);
+		return;
+	}
+
+	ivc =3D ofono_voicecall_get_data(irc->ovc);
+	switch (ivc->calls[irc->id].status) {
+	case CALL_STATUS_MO_RELEASE:
+	case CALL_STATUS_MT_RELEASE:
+	case CALL_STATUS_TERMINATED:
+	case CALL_STATUS_IDLE:
+		isi_ctx_return_failure(irc);
+	}
+}
+
 static gboolean isi_call_answer_resp(GIsiClient *client,
 					void const *restrict data,
 					size_t len,
@@ -1018,7 +1065,7 @@ static void isi_hangup_current(struct ofono_voicecall=
 *ovc,
 	 * active calls or calls in progress.
 	 */
 	struct isi_voicecall *ivc =3D ofono_voicecall_get_data(ovc);
-	int id =3D 0;
+	int id;
 =

 	for (id =3D 1; id <=3D 7; id++) {
 		if (ivc->calls[id].call_id & CALL_ID_WAITING)
-- =

1.7.1


--===============8759919304256728991==--

