Content-Type: multipart/mixed; boundary="===============0472419631495457275=="
MIME-Version: 1.0
From: Pekka.Pessi@nokia.com
Subject: [isi-voicecall-fix PATCHv3 3/6] isi/voicecall: save call id when
 queueing requests
Date: Tue, 16 Nov 2010 19:05:21 +0200
Message-ID: <1289927124-30133-3-git-send-email-Pekka.Pessi@nokia.com>
In-Reply-To: <1289927124-30133-2-git-send-email-Pekka.Pessi@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0472419631495457275==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Pekka Pessi <Pekka.Pessi@nokia.com>

---
 drivers/isimodem/voicecall.c |   64 +++++++++++++++++++++++++++-----------=
----
 1 files changed, 41 insertions(+), 23 deletions(-)

diff --git a/drivers/isimodem/voicecall.c b/drivers/isimodem/voicecall.c
index c450f12..60052d4 100644
--- a/drivers/isimodem/voicecall.c
+++ b/drivers/isimodem/voicecall.c
@@ -80,41 +80,57 @@ enum {
 /* -----------------------------------------------------------------------=
-- */
 /* Request context for voicecall cb */
 =

-struct isi_call_req_context;
-
 typedef void isi_call_req_step(struct isi_call_req_context *, int reason);
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
+	struct ofono_voicecall *ovc,
+	ofono_voicecall_cb_t cb,
+	void *data)
 {
-	struct isi_voicecall *ivc;
 	struct isi_call_req_context *irc;
 =

-	ivc =3D ofono_voicecall_get_data(ovc);
-
 	irc =3D g_try_new0(struct isi_call_req_context, 1);
+	if (irc =3D=3D NULL) {
+		if (cb)
+			CALLBACK_WITH_FAILURE(cb, data);
+		return NULL;
+	}
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
+	if (!irc)
+		return NULL;
+
+	ivc =3D ofono_voicecall_get_data(ovc);
+	if (g_isi_send(ivc->client, req, len,
+			ISI_CALL_TIMEOUT, handler, irc, NULL))
+		return irc;
 =

 	g_free(irc);
 =

@@ -125,7 +141,8 @@ isi_call_req(struct ofono_voicecall *ovc,
 }
 =

 static void isi_ctx_queue(struct isi_call_req_context *irc,
-				isi_call_req_step *next)
+				isi_call_req_step *next,
+				int id)
 {
 	if (irc->prev =3D=3D NULL) {
 		struct isi_voicecall *ivc =3D ofono_voicecall_get_data(irc->ovc);
@@ -139,6 +156,7 @@ static void isi_ctx_queue(struct isi_call_req_context *=
irc,
 	}
 =

 	irc->step =3D next;
+	irc->id =3D id;
 }
 =

 static void isi_ctx_remove(struct isi_call_req_context *irc)
@@ -1078,9 +1096,9 @@ static void isi_release_all_active(struct ofono_voice=
call *ovc,
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
-- =

1.7.1


--===============0472419631495457275==--

