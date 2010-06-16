Content-Type: multipart/mixed; boundary="===============3154317484630783428=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 2/4] stk: Allow registering proactive command handlers.
Date: Wed, 16 Jun 2010 17:26:53 +0200
Message-ID: <1276702015-8711-2-git-send-email-andrew.zaborowski@intel.com>
In-Reply-To: <1276702015-8711-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3154317484630783428==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/stk.c |  144 +++++++++++++++++++++++++++++++++++++++++++++++++++++++--=
----
 1 files changed, 131 insertions(+), 13 deletions(-)

diff --git a/src/stk.c b/src/stk.c
index f472a63..1dd5b77 100644
--- a/src/stk.c
+++ b/src/stk.c
@@ -40,14 +40,85 @@
 =

 static GSList *g_drivers =3D NULL;
 =

+typedef void (*generic_cb_t)(const struct ofono_error *error,
+				struct ofono_stk *stk);
+
+typedef void (*envelope_cb_t)(const struct ofono_error *error,
+				const unsigned char *rdata,
+				int length, struct ofono_stk *stk);
+
+typedef gboolean (*command_handler_t)(const struct stk_command *cmd,
+					struct stk_response *rsp,
+					struct ofono_stk *stk);
+
 struct ofono_stk {
 	const struct ofono_stk_driver *driver;
 	void *driver_data;
 	struct ofono_atom *atom;
+	command_handler_t handlers[256];
+	struct stk_command *pending_cmd;
 };
 =

+static void stk_respond(struct ofono_stk *stk, struct stk_command *cmd,
+			struct stk_response *rsp, generic_cb_t cb)
+{
+	struct ofono_error error =3D { .type =3D OFONO_ERROR_TYPE_FAILURE };
+	const guint8 *tlv;
+	unsigned int tlv_len;
+
+	if (cmd =3D=3D NULL)
+		cmd =3D stk->pending_cmd;
+	else
+		stk->pending_cmd =3D cmd;
+
+	rsp->src =3D STK_DEVICE_IDENTITY_TYPE_TERMINAL;
+	rsp->dst =3D STK_DEVICE_IDENTITY_TYPE_UICC;
+	rsp->number =3D cmd->number;
+	rsp->type =3D cmd->type;
+	rsp->qualifier =3D cmd->qualifier;
+
+	if (stk->driver->terminal_response =3D=3D NULL) {
+		cb(&error, stk);
+		return;
+	}
+
+	tlv =3D stk_pdu_from_response(rsp, &tlv_len);
+	if (!tlv) {
+		cb(&error, stk);
+		return;
+	}
+
+	stk->driver->terminal_response(stk, tlv_len, tlv,
+					(ofono_stk_generic_cb_t) cb, stk);
+}
+
+static void stk_send_envelope(struct ofono_stk *stk, struct stk_envelope *=
e,
+				envelope_cb_t cb)
+{
+	struct ofono_error error =3D { .type =3D OFONO_ERROR_TYPE_FAILURE };
+	const guint8 *tlv;
+	unsigned int tlv_len;
+
+	e->dst =3D STK_DEVICE_IDENTITY_TYPE_UICC;
+
+	if (stk->driver->envelope =3D=3D NULL) {
+		cb(&error, NULL, -1, stk);
+		return;
+	}
+
+	tlv =3D stk_pdu_from_envelope(e, &tlv_len);
+	if (!tlv) {
+		cb(&error, NULL, -1, stk);
+		return;
+	}
+
+	stk->driver->envelope(stk, tlv_len, tlv,
+				(ofono_stk_envelope_cb_t) cb, stk);
+}
+
 static void stk_cbs_download_cb(const struct ofono_error *error,
-				const unsigned char *data, int len, void *user)
+				const unsigned char *data, int len,
+				struct ofono_stk *stk)
 {
 	if (error->type !=3D OFONO_ERROR_TYPE_NO_ERROR) {
 		ofono_error("CellBroadcast download to UICC failed");
@@ -56,34 +126,47 @@ static void stk_cbs_download_cb(const struct ofono_err=
or *error,
 		return;
 	}
 =

+	if (len)
+		ofono_error("CellBroadcast download returned %i bytes of data",
+				len);
+
 	DBG("CellBroadcast download to UICC reported no error");
 }
 =

 void __ofono_cbs_sim_download(struct ofono_stk *stk, const struct cbs *msg)
 {
-	const guint8 *tlv;
-	unsigned int tlv_len;
 	struct stk_envelope e;
 =

-	if (stk->driver->envelope =3D=3D NULL)
-		return;
+	memset(&e, 0, sizeof(e));
 =

 	e.type =3D STK_ENVELOPE_TYPE_CBS_PP_DOWNLOAD;
 	e.src =3D STK_DEVICE_IDENTITY_TYPE_NETWORK;
-	e.dst =3D STK_DEVICE_IDENTITY_TYPE_UICC;
 	memcpy(&e.cbs_pp_download.page, msg, sizeof(msg));
 =

-	tlv =3D stk_pdu_from_envelope(&e, &tlv_len);
-	if (!tlv)
+	stk_send_envelope(stk, &e, stk_cbs_download_cb);
+}
+
+static void stk_command_cb(const struct ofono_error *error,
+				struct ofono_stk *stk)
+{
+	stk_command_free(stk->pending_cmd);
+	stk->pending_cmd =3D NULL;
+
+	if (error->type !=3D OFONO_ERROR_TYPE_NO_ERROR) {
+		ofono_error("TERMINAL RESPONSE to a UICC command failed");
+		/* "The ME may retry to deliver the same Cell Broadcast
+		 * page." */
 		return;
+	}
 =

-	stk->driver->envelope(stk, tlv_len, tlv, stk_cbs_download_cb, stk);
+	DBG("TERMINAL RESPONSE to a command reported no errors");
 }
 =

 void ofono_stk_proactive_command_notify(struct ofono_stk *stk,
 					int length, const unsigned char *pdu)
 {
 	struct stk_command *cmd;
+	struct stk_response rsp;
 	char *buf;
 	int i;
 =

@@ -97,14 +180,49 @@ void ofono_stk_proactive_command_notify(struct ofono_s=
tk *stk,
 		ofono_error("Can't parse proactive command: %s", buf);
 		g_free(buf);
 =

-		/* TODO: return TERMINAL RESPONSE with permanent error */
+		/*
+		 * There's nothing we can do, we'd need at least Command
+		 * Details to respond with an error.
+		 */
 		return;
 	}
+	g_free(buf);
 =

-	/* TODO: execute */
+	memset(&rsp, 0, sizeof(rsp));
 =

-	g_free(buf);
-	stk_command_free(cmd);
+	switch (cmd->status) {
+	case STK_PARSE_RESULT_OK:
+		if (stk->handlers[cmd->type]) {
+			if (stk->handlers[cmd->type](cmd, &rsp, stk) =3D=3D TRUE)
+				break;
+
+			stk->pending_cmd =3D cmd;
+			return;
+		}
+		/* Fall through */
+
+	case STK_PARSE_RESULT_TYPE_NOT_UNDERSTOOD:
+	default:
+		rsp.result.type =3D STK_RESULT_TYPE_COMMAND_NOT_UNDERSTOOD;
+		break;
+
+	case STK_PARSE_RESULT_MISSING_VALUE:
+		rsp.result.type =3D STK_RESULT_TYPE_MINIMUM_NOT_MET;
+		break;
+
+	case STK_PARSE_RESULT_DATA_NOT_UNDERSTOOD:
+		rsp.result.type =3D STK_RESULT_TYPE_DATA_NOT_UNDERSTOOD;
+		break;
+	}
+
+	stk_respond(stk, cmd, &rsp, stk_command_cb);
+}
+
+static void stk_command_handler_register(struct ofono_stk *stk,
+						enum stk_command_type type,
+						command_handler_t handler)
+{
+	stk->handlers[type] =3D handler;
 }
 =

 int ofono_stk_driver_register(const struct ofono_stk_driver *d)
-- =

1.7.1.86.g0e460.dirty


--===============3154317484630783428==--

