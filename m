Content-Type: multipart/mixed; boundary="===============7572660772497209109=="
MIME-Version: 1.0
From: Pekka.Pessi@nokia.com
Subject: [fix-isi-voicecall PATCHv5 2/4] isi/voicecall: add call id to queued
 requests
Date: Fri, 03 Dec 2010 10:30:48 +0200
Message-ID: <1291365050-19739-3-git-send-email-Pekka.Pessi@nokia.com>
In-Reply-To: <1291365050-19739-2-git-send-email-Pekka.Pessi@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7572660772497209109==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Pekka Pessi <Pekka.Pessi@nokia.com>

---
 drivers/isimodem/voicecall.c |   89 +++++++++++++++++++++++++++-----------=
----
 1 files changed, 57 insertions(+), 32 deletions(-)

diff --git a/drivers/isimodem/voicecall.c b/drivers/isimodem/voicecall.c
index b89cbb3..e7126a8 100644
--- a/drivers/isimodem/voicecall.c
+++ b/drivers/isimodem/voicecall.c
@@ -80,41 +80,62 @@ enum {
 /* -----------------------------------------------------------------------=
-- */
 /* Request context for voicecall cb */
 =

-struct isi_call_req_context;
-
-typedef void isi_call_req_step(struct isi_call_req_context *, int reason);
+typedef void isi_call_req_step(struct isi_call_req_context *,
+				int id, int status);
 =

 struct isi_call_req_context {
-	struct isi_call_req_context *next, **prev;
+	struct isi_call_req_context *next;
+	struct isi_call_req_context **prev;
 	isi_call_req_step *step;
+	int id;
 	struct ofono_voicecall *ovc;
 	ofono_voicecall_cb_t cb;
 	void *data;
 };
 =

-static struct isi_call_req_context *
-isi_call_req(struct ofono_voicecall *ovc,
-		void const *restrict req,
-		size_t len,
-		GIsiResponse *handler,
-		ofono_voicecall_cb_t cb, void *data)
+static struct isi_call_req_context *isi_call_req_new(
+					struct ofono_voicecall *ovc,
+					ofono_voicecall_cb_t cb,
+					void *data)
 {
-	struct isi_voicecall *ivc;
 	struct isi_call_req_context *irc;
 =

-	ivc =3D ofono_voicecall_get_data(ovc);
-
 	irc =3D g_try_new0(struct isi_call_req_context, 1);
+	if (irc =3D=3D NULL)
+		goto failed;
 =

-	if (irc) {
-		irc->ovc =3D ovc;
-		irc->cb =3D cb;
-		irc->data =3D data;
+	irc->ovc =3D ovc;
+	irc->cb =3D cb;
+	irc->data =3D data;
 =

-		if (g_isi_request_make(ivc->client, req, len,
-					ISI_CALL_TIMEOUT, handler, irc))
-			return irc;
-	}
+	return irc;
+
+failed:
+	if (cb)
+		CALLBACK_WITH_FAILURE(cb, data);
+
+	return NULL;
+}
+
+static struct isi_call_req_context *isi_call_req(struct ofono_voicecall *o=
vc,
+						void const *restrict req,
+						size_t len,
+						GIsiResponse *handler,
+						ofono_voicecall_cb_t cb,
+						void *data)
+{
+	struct isi_voicecall *ivc;
+	struct isi_call_req_context *irc;
+
+	irc =3D isi_call_req_new(ovc, cb, data);
+	if (irc =3D=3D NULL)
+		return NULL;
+
+	ivc =3D ofono_voicecall_get_data(ovc);
+
+	if (g_isi_send(ivc->client, req, len,
+			ISI_CALL_TIMEOUT, handler, irc, NULL))
+		return irc;
 =

 	g_free(irc);
 =

@@ -125,7 +146,8 @@ isi_call_req(struct ofono_voicecall *ovc,
 }
 =

 static void isi_ctx_queue(struct isi_call_req_context *irc,
-				isi_call_req_step *next)
+				isi_call_req_step *next,
+				int id)
 {
 	if (irc->prev =3D=3D NULL) {
 		struct isi_voicecall *ivc =3D ofono_voicecall_get_data(irc->ovc);
@@ -139,6 +161,7 @@ static void isi_ctx_queue(struct isi_call_req_context *=
irc,
 	}
 =

 	irc->step =3D next;
+	irc->id =3D id;
 }
 =

 static void isi_ctx_remove(struct isi_call_req_context *irc)
@@ -187,7 +210,7 @@ static gboolean isi_ctx_return_failure(struct isi_call_=
req_context *irc)
 static gboolean isi_ctx_return_success(struct isi_call_req_context *irc)
 {
 	if (irc && irc->step) {
-		irc->step(irc, 0);
+		irc->step(irc, 0, 0);
 		return TRUE;
 	}
 =

@@ -310,7 +333,7 @@ static void isi_call_notify(struct ofono_voicecall *ovc,
 		call_status_name(call->status), call->status);
 =

 	for (queue =3D &ivc->queue; (irc =3D *queue);) {
-		irc->step(irc, call->status);
+		irc->step(irc, call->id, call->status);
 =

 		if (*queue =3D=3D irc)
 			queue =3D &irc->next;
@@ -1063,18 +1086,19 @@ static void isi_release_all_active(struct ofono_voi=
cecall *ovc,
 		if (irc =3D=3D NULL)
 			;
 		else if (waiting)
-			isi_ctx_queue(irc, isi_wait_and_answer);
+			isi_ctx_queue(irc, isi_wait_and_answer, 0);
 		else if (hold)
-			isi_ctx_queue(irc, isi_wait_and_retrieve);
+			isi_ctx_queue(irc, isi_wait_and_retrieve, 0);
 	} else
 		CALLBACK_WITH_FAILURE(cb, data);
 }
 =

 static void isi_wait_and_answer(struct isi_call_req_context *irc,
-				int event)
+				int id, int status)
 {
-	DBG("irc=3D%p event=3D%u", (void *)irc, event);
-	switch (event) {
+	DBG("irc=3D%p id=3D%d status=3D%d", (void *)irc, id, status);
+
+	switch (status) {
 	case CALL_STATUS_TERMINATED:
 		isi_answer(irc->ovc, irc->cb, irc->data);
 		isi_ctx_free(irc);
@@ -1083,10 +1107,11 @@ static void isi_wait_and_answer(struct isi_call_req=
_context *irc,
 }
 =

 static void isi_wait_and_retrieve(struct isi_call_req_context *irc,
-					int event)
+					int id, int status)
 {
-	DBG("irc=3D%p event=3D%u", (void *)irc, event);
-	switch (event) {
+	DBG("irc=3D%p id=3D%u status=3D%u", (void *)irc, id, status);
+
+	switch (status) {
 	case CALL_STATUS_TERMINATED:
 		isi_retrieve(irc->ovc, irc->cb, irc->data);
 		isi_ctx_free(irc);
-- =

1.7.1


--===============7572660772497209109==--

