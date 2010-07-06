Content-Type: multipart/mixed; boundary="===============1420051110258512786=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 06/14] stk: Handle ENVELOPEs in a queue, retry on sim busy.
Date: Wed, 07 Jul 2010 00:39:01 +0200
Message-ID: <1278455949-2823-7-git-send-email-andrew.zaborowski@intel.com>
In-Reply-To: <1278455949-2823-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1420051110258512786==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Some envelope types need to be retried when sim reports busy status.
Then envelopes such as Event Download need to be returned in the
order of the event occurences, so need to be handled in a queue.
---
 src/stk.c |   91 +++++++++++++++++++++++++++++++++++++++++++++++++++------=
---
 1 files changed, 77 insertions(+), 14 deletions(-)

diff --git a/src/stk.c b/src/stk.c
index ba66fe2..b4b65c1 100644
--- a/src/stk.c
+++ b/src/stk.c
@@ -46,8 +46,21 @@ struct ofono_stk {
 	struct stk_command *pending_cmd;
 	void (*cancel_cmd)(struct ofono_stk *stk);
 	gboolean cancelled;
+	GQueue *envelope_q;
 };
 =

+struct envelope_op {
+	uint8_t tlv[256];
+	unsigned int tlv_len;
+	int retries;
+	void (*cb)(struct ofono_stk *stk, gboolean ok,
+			const unsigned char *data, int length);
+};
+
+#define ENVELOPE_RETRIES_DEFAULT 5
+
+static void envelope_queue_run(struct ofono_stk *stk);
+
 static int stk_respond(struct ofono_stk *stk, struct stk_response *rsp,
 			ofono_stk_generic_cb_t cb)
 {
@@ -75,35 +88,80 @@ static int stk_respond(struct ofono_stk *stk, struct st=
k_response *rsp,
 	return 0;
 }
 =

+static void envelope_cb(const struct ofono_error *error, const uint8_t *da=
ta,
+			int length, void *user_data)
+{
+	struct ofono_stk *stk =3D user_data;
+	struct envelope_op *op =3D g_queue_peek_head(stk->envelope_q);
+	gboolean result =3D TRUE;
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
+
+	g_free(op);
+
+out:
+	envelope_queue_run(stk);
+}
+
+static void envelope_queue_run(struct ofono_stk *stk)
+{
+	while (g_queue_get_length(stk->envelope_q) > 0) {
+		struct envelope_op *op =3D g_queue_peek_head(stk->envelope_q);
+
+		stk->driver->envelope(stk, op->tlv_len, op->tlv,
+				envelope_cb, stk);
+	}
+}
+
 static int stk_send_envelope(struct ofono_stk *stk, struct stk_envelope *e,
-				ofono_stk_envelope_cb_t cb)
+				void (*cb)(struct ofono_stk *stk, gboolean ok,
+						const uint8_t *data,
+						int length), int retries)
 {
-	const guint8 *tlv;
+	const uint8_t *tlv;
 	unsigned int tlv_len;
+	struct envelope_op *op;
 =

 	if (stk->driver->envelope =3D=3D NULL)
 		return -ENOSYS;
 =

 	e->dst =3D STK_DEVICE_IDENTITY_TYPE_UICC;
-
 	tlv =3D stk_pdu_from_envelope(e, &tlv_len);
 	if (!tlv)
 		return -EINVAL;
 =

-	stk->driver->envelope(stk, tlv_len, tlv, cb, stk);
+	op =3D g_new0(struct envelope_op, 1);
+
+	op->cb =3D cb;
+	op->retries =3D retries;
+	memcpy(op->tlv, tlv, tlv_len);
+	op->tlv_len =3D tlv_len;
+
+	g_queue_push_tail(stk->envelope_q, op);
+
+	if (g_queue_get_length(stk->envelope_q) =3D=3D 1)
+		envelope_queue_run(stk);
 =

 	return 0;
 }
 =

-static void stk_cbs_download_cb(const struct ofono_error *error,
-				const unsigned char *data, int len, void *user)
+static void stk_cbs_download_cb(struct ofono_stk *stk, gboolean ok,
+				const unsigned char *data, int len)
 {
-	if (error->type !=3D OFONO_ERROR_TYPE_NO_ERROR) {
+	if (!ok) {
 		ofono_error("CellBroadcast download to UICC failed");
-		/*
-		 * "The ME may retry to deliver the same Cell Broadcast
-		 * page."
-		 */
 		return;
 	}
 =

@@ -116,7 +174,6 @@ static void stk_cbs_download_cb(const struct ofono_erro=
r *error,
 =

 void __ofono_cbs_sim_download(struct ofono_stk *stk, const struct cbs *msg)
 {
-	struct ofono_error error =3D { .type =3D OFONO_ERROR_TYPE_FAILURE };
 	struct stk_envelope e;
 	int err;
 =

@@ -126,9 +183,10 @@ void __ofono_cbs_sim_download(struct ofono_stk *stk, c=
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

 static void stk_command_cb(const struct ofono_error *error, void *data)
@@ -281,6 +339,9 @@ static void stk_unregister(struct ofono_atom *atom)
 		stk_command_free(stk->pending_cmd);
 		stk->pending_cmd =3D NULL;
 	}
+
+	g_queue_foreach(stk->envelope_q, (GFunc) g_free, NULL);
+	g_queue_free(stk->envelope_q);
 }
 =

 static void stk_remove(struct ofono_atom *atom)
@@ -336,6 +397,8 @@ struct ofono_stk *ofono_stk_create(struct ofono_modem *=
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


--===============1420051110258512786==--

