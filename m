Content-Type: multipart/mixed; boundary="===============1180049274215441267=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 1/9] stk: Utilities for proactive command/envelope handling
Date: Tue, 29 Jun 2010 12:14:00 +0200
Message-ID: <1277806448-5322-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1180049274215441267==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 include/stk.h |    2 +
 src/stk.c     |  144 ++++++++++++++++++++++++++++++++++++++++++++++++++---=
----
 2 files changed, 129 insertions(+), 17 deletions(-)

diff --git a/include/stk.h b/include/stk.h
index ad3f6c5..4e5d01e 100644
--- a/include/stk.h
+++ b/include/stk.h
@@ -65,6 +65,8 @@ void *ofono_stk_get_data(struct ofono_stk *stk);
 void ofono_stk_proactive_command_notify(struct ofono_stk *stk,
 					int length, const unsigned char *pdu);
 =

+void ofono_stk_proactive_command_cancel(struct ofono_stk *stk);
+
 #ifdef __cplusplus
 }
 #endif
diff --git a/src/stk.c b/src/stk.c
index b5c6919..e513b06 100644
--- a/src/stk.c
+++ b/src/stk.c
@@ -43,10 +43,61 @@ struct ofono_stk {
 	const struct ofono_stk_driver *driver;
 	void *driver_data;
 	struct ofono_atom *atom;
+	struct stk_command *pending_cmd;
+	void (*cancel_cmd)(struct ofono_stk *stk);
 };
 =

+static int stk_respond(struct ofono_stk *stk, struct stk_response *rsp,
+			void (*cb)(const struct ofono_error *error,
+					struct ofono_stk *stk))
+{
+	const guint8 *tlv;
+	unsigned int tlv_len;
+
+	rsp->src =3D STK_DEVICE_IDENTITY_TYPE_TERMINAL;
+	rsp->dst =3D STK_DEVICE_IDENTITY_TYPE_UICC;
+	rsp->number =3D stk->pending_cmd->number;
+	rsp->type =3D stk->pending_cmd->type;
+	rsp->qualifier =3D stk->pending_cmd->qualifier;
+
+	if (stk->driver->terminal_response =3D=3D NULL)
+		return -ENOSYS;
+
+	tlv =3D stk_pdu_from_response(rsp, &tlv_len);
+	if (!tlv)
+		return -EINVAL;
+
+	stk->driver->terminal_response(stk, tlv_len, tlv,
+					(ofono_stk_generic_cb_t) cb, stk);
+	return 0;
+}
+
+static int stk_send_envelope(struct ofono_stk *stk, struct stk_envelope *e,
+				void (*cb)(const struct ofono_error *error,
+						const unsigned char *data,
+						int length,
+						struct ofono_stk *stk))
+{
+	const guint8 *tlv;
+	unsigned int tlv_len;
+
+	e->dst =3D STK_DEVICE_IDENTITY_TYPE_UICC;
+
+	if (stk->driver->envelope =3D=3D NULL)
+		return -ENOSYS;
+
+	tlv =3D stk_pdu_from_envelope(e, &tlv_len);
+	if (!tlv)
+		return -EINVAL;
+
+	stk->driver->envelope(stk, tlv_len, tlv,
+				(ofono_stk_envelope_cb_t) cb, stk);
+	return 0;
+}
+
 static void stk_cbs_download_cb(const struct ofono_error *error,
-				const unsigned char *data, int len, void *user)
+				const unsigned char *data, int len,
+				struct ofono_stk *stk)
 {
 	if (error->type !=3D OFONO_ERROR_TYPE_NO_ERROR) {
 		ofono_error("CellBroadcast download to UICC failed");
@@ -55,36 +106,62 @@ static void stk_cbs_download_cb(const struct ofono_err=
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
+	struct ofono_error error =3D { .type =3D OFONO_ERROR_TYPE_FAILURE };
 	struct stk_envelope e;
+	int err;
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
+	err =3D stk_send_envelope(stk, &e, stk_cbs_download_cb);
+	if (err)
+		stk_cbs_download_cb(&error, NULL, -1, stk);
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
+}
+
+void ofono_stk_proactive_command_cancel(struct ofono_stk *stk)
+{
+	if (!stk->pending_cmd)
+		return;
+
+	stk->cancel_cmd(stk);
 }
 =

 void ofono_stk_proactive_command_notify(struct ofono_stk *stk,
 					int length, const unsigned char *pdu)
 {
-	struct stk_command *cmd;
+	struct ofono_error error =3D { .type =3D OFONO_ERROR_TYPE_FAILURE };
+	struct stk_response rsp;
 	char *buf;
-	int i;
+	int i, err;
+	gboolean respond =3D TRUE;
 =

 	buf =3D g_try_malloc(length * 2 + 1);
 	if (!buf)
@@ -93,18 +170,51 @@ void ofono_stk_proactive_command_notify(struct ofono_s=
tk *stk,
 	for (i =3D 0; i < length; i ++)
 		sprintf(buf + i * 2, "%02hhx", pdu[i]);
 =

-	cmd =3D stk_command_new_from_pdu(pdu, length);
-	if (!cmd) {
+	stk->pending_cmd =3D stk_command_new_from_pdu(pdu, length);
+	if (!stk->pending_cmd) {
 		ofono_error("Can't parse proactive command: %s", buf);
 =

-		/* TODO: return TERMINAL RESPONSE with permanent error */
+		/*
+		 * Nothing we can do, we'd need at least Command Details
+		 * to be able to respond with an error.
+		 */
 		goto done;
 	}
 =

-	/* TODO: execute */
-	ofono_info("Proactive command PDU: %s", buf);
+	ofono_debug("Proactive command PDU: %s", buf);
+
+	memset(&rsp, 0, sizeof(rsp));
+
+	switch (stk->pending_cmd->status) {
+	case STK_PARSE_RESULT_OK:
+		switch (stk->pending_cmd->type) {
+		default:
+			rsp.result.type =3D
+				STK_RESULT_TYPE_COMMAND_NOT_UNDERSTOOD;
+			break;
+		}
+
+		if (respond)
+			break;
+		return;
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
 =

-	stk_command_free(cmd);
+	err =3D stk_respond(stk, &rsp, stk_command_cb);
+	if (err)
+		stk_command_cb(&error, stk);
 =

 done:
 	g_free(buf);
-- =

1.7.1.86.g0e460.dirty


--===============1180049274215441267==--

