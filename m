Content-Type: multipart/mixed; boundary="===============3165354455167913840=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 5/9] stk: Handle ENVELOPEs in a queue, retry on sim busy.
Date: Tue, 29 Jun 2010 12:14:04 +0200
Message-ID: <1277806448-5322-5-git-send-email-andrew.zaborowski@intel.com>
In-Reply-To: <1277806448-5322-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3165354455167913840==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Some envelope types should be retried when sim reports busy status.
Envelopes such as Event Download need to be returned in the order
of the event occurences, so need to be handled in a queue.
---
 src/stk.c |  110 +++++++++++++++++++++++++++++++++++++++++++++++++--------=
---
 1 files changed, 90 insertions(+), 20 deletions(-)

diff --git a/src/stk.c b/src/stk.c
index 4edf05b..4fea62b 100644
--- a/src/stk.c
+++ b/src/stk.c
@@ -45,8 +45,22 @@ struct ofono_stk {
 	struct ofono_atom *atom;
 	struct stk_command *pending_cmd;
 	void (*cancel_cmd)(struct ofono_stk *stk);
+
+	gboolean envelope_q_busy;
+	GQueue *envelope_q;
+};
+
+struct envelope_op {
+	struct stk_envelope e;
+	int retries;
+	void (*cb)(struct ofono_stk *stk, gboolean ok,
+			const unsigned char *data, int length);
 };
 =

+#define ENVELOPE_RETRIES_DEFAULT 5
+
+static void envelope_queue_run(struct ofono_stk *stk);
+
 static int stk_respond(struct ofono_stk *stk, struct stk_response *rsp,
 			void (*cb)(const struct ofono_error *error,
 					struct ofono_stk *stk))
@@ -72,37 +86,87 @@ static int stk_respond(struct ofono_stk *stk, struct st=
k_response *rsp,
 	return 0;
 }
 =

-static int stk_send_envelope(struct ofono_stk *stk, struct stk_envelope *e,
-				void (*cb)(const struct ofono_error *error,
-						const unsigned char *data,
-						int length,
-						struct ofono_stk *stk))
+static void envelope_cb(const struct ofono_error *error, const uint8_t *da=
ta,
+			int length, void *user_data)
+{
+	struct ofono_stk *stk =3D user_data;
+	struct envelope_op *op =3D g_queue_peek_head(stk->envelope_q);
+	gboolean result =3D TRUE;
+
+	stk->envelope_q_busy =3D FALSE;
+
+	if (op->retries > 0 && error->type =3D=3D OFONO_ERROR_TYPE_SIM &&
+			error->error =3D=3D 0x9300) {
+		op->retries--;
+		goto out;
+	}
+
+	if (error->type !=3D OFONO_ERROR_TYPE_NO_ERROR)
+		result =3D FALSE;
+
+	g_queue_pop_head(stk->envelope_q);
+
+	if (op->cb)
+		op->cb(stk, result, data, length);
+	g_free(op);
+
+out:
+	envelope_queue_run(stk);
+}
+
+static void envelope_queue_run(struct ofono_stk *stk)
 {
 	const guint8 *tlv;
 	unsigned int tlv_len;
 =

-	e->dst =3D STK_DEVICE_IDENTITY_TYPE_UICC;
+	while (stk->envelope_q_busy =3D=3D FALSE &&
+			g_queue_get_length(stk->envelope_q) > 0) {
+		struct envelope_op *op =3D g_queue_peek_head(stk->envelope_q);
+
+		tlv =3D stk_pdu_from_envelope(&op->e, &tlv_len);
+		if (!tlv) {
+			g_queue_pop_head(stk->envelope_q);
+
+			op->cb(stk, FALSE, NULL, -1);
+			g_free(op);
+
+			continue;
+		}
+
+		stk->envelope_q_busy =3D TRUE;
+		stk->driver->envelope(stk, tlv_len, tlv, envelope_cb, stk);
+	}
+}
+
+static int stk_send_envelope(struct ofono_stk *stk, struct stk_envelope *e,
+				void (*cb)(struct ofono_stk *stk, gboolean ok,
+						const uint8_t *data,
+						int length), int retries)
+{
+	struct envelope_op *op;
 =

 	if (stk->driver->envelope =3D=3D NULL)
 		return -ENOSYS;
 =

-	tlv =3D stk_pdu_from_envelope(e, &tlv_len);
-	if (!tlv)
-		return -EINVAL;
+	op =3D g_new0(struct envelope_op, 1);
+
+	memcpy(&op->e, e, sizeof(op->e));
+	op->e.dst =3D STK_DEVICE_IDENTITY_TYPE_UICC;
+	op->cb =3D cb;
+	op->retries =3D retries;
+
+	g_queue_push_tail(stk->envelope_q, op);
+
+	envelope_queue_run(stk);
 =

-	stk->driver->envelope(stk, tlv_len, tlv,
-				(ofono_stk_envelope_cb_t) cb, stk);
 	return 0;
 }
 =

-static void stk_cbs_download_cb(const struct ofono_error *error,
-				const unsigned char *data, int len,
-				struct ofono_stk *stk)
+static void stk_cbs_download_cb(struct ofono_stk *stk, gboolean ok,
+				const unsigned char *data, int len)
 {
-	if (error->type !=3D OFONO_ERROR_TYPE_NO_ERROR) {
+	if (!ok) {
 		ofono_error("CellBroadcast download to UICC failed");
-		/* "The ME may retry to deliver the same Cell Broadcast
-		 * page." */
 		return;
 	}
 =

@@ -115,7 +179,6 @@ static void stk_cbs_download_cb(const struct ofono_erro=
r *error,
 =

 void __ofono_cbs_sim_download(struct ofono_stk *stk, const struct cbs *msg)
 {
-	struct ofono_error error =3D { .type =3D OFONO_ERROR_TYPE_FAILURE };
 	struct stk_envelope e;
 	int err;
 =

@@ -125,9 +188,10 @@ void __ofono_cbs_sim_download(struct ofono_stk *stk, c=
onst struct cbs *msg)
 	e.src =3D STK_DEVICE_IDENTITY_TYPE_NETWORK;
 	memcpy(&e.cbs_pp_download.page, msg, sizeof(msg));
 =

-	err =3D stk_send_envelope(stk, &e, stk_cbs_download_cb);
+	err =3D stk_send_envelope(stk, &e, stk_cbs_download_cb,
+				ENVELOPE_RETRIES_DEFAULT);
 	if (err)
-		stk_cbs_download_cb(&error, NULL, -1, stk);
+		stk_cbs_download_cb(stk, FALSE, NULL, -1);
 }
 =

 static void stk_command_cb(const struct ofono_error *error,
@@ -254,6 +318,10 @@ void ofono_stk_driver_unregister(const struct ofono_st=
k_driver *d)
 =

 static void stk_unregister(struct ofono_atom *atom)
 {
+	struct ofono_stk *stk =3D __ofono_atom_get_data(atom);
+
+	g_queue_foreach(stk->envelope_q, (GFunc) g_free, NULL);
+	g_queue_free(stk->envelope_q);
 }
 =

 static void stk_remove(struct ofono_atom *atom)
@@ -309,6 +377,8 @@ struct ofono_stk *ofono_stk_create(struct ofono_modem *=
modem,
 void ofono_stk_register(struct ofono_stk *stk)
 {
 	__ofono_atom_register(stk->atom, stk_unregister);
+
+	stk->envelope_q =3D g_queue_new();
 }
 =

 void ofono_stk_remove(struct ofono_stk *stk)
-- =

1.7.1.86.g0e460.dirty


--===============3165354455167913840==--

