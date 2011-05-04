Content-Type: multipart/mixed; boundary="===============0522086663823974793=="
MIME-Version: 1.0
From: Philippe Nunes <philippe.nunes@linux.intel.com>
Subject: [PATCH 3/4] stk: Use gprs APIs to create,
 activate and remove a dedicated PDP context
Date: Wed, 04 May 2011 19:26:41 +0200
Message-ID: <1304530002-13336-4-git-send-email-philippe.nunes@linux.intel.com>
In-Reply-To: <1304530002-13336-1-git-send-email-philippe.nunes@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0522086663823974793==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/stk.c |  132 +++++++++++++++++++++++++++++++++++++++++++++++++++++----=
---
 1 files changed, 116 insertions(+), 16 deletions(-)

diff --git a/src/stk.c b/src/stk.c
index dec0439..fe74cb5 100644
--- a/src/stk.c
+++ b/src/stk.c
@@ -85,6 +85,7 @@ struct ofono_stk {
 	struct stk_channel_data tx_buffer;
 	gboolean link_on_demand;
 	struct ofono_gprs *gprs;
+	struct stk_bearer_description bearer_desc;
 };
 =

 struct envelope_op {
@@ -489,13 +490,10 @@ static void emit_menu_changed(struct ofono_stk *stk)
 =

 static void stk_close_channel(struct ofono_stk *stk)
 {
-	/*
-	 * TODO
-	 * Deactivate and remove PDP context
-	 * Send the Terminal Response once the PDP context is deactivated
-	 */
+	int err;
+
+	err =3D ofono_gprs_remove_pdp_context(stk->gprs, stk->channel.id);
 =

-	/* Temporary implementation */
 	g_free(stk->rx_buffer.data.array);
 	g_free(stk->tx_buffer.data.array);
 	stk->rx_buffer.data.array =3D NULL;
@@ -504,6 +502,9 @@ static void stk_close_channel(struct ofono_stk *stk)
 	stk->channel.id =3D 0;
 	stk->channel.status =3D STK_CHANNEL_PACKET_DATA_SERVICE_NOT_ACTIVATED;
 =

+	if (err < 0)
+		return;
+
 	if (stk->pending_cmd &&
 			stk->pending_cmd->type =3D=3D
 				STK_COMMAND_TYPE_CLOSE_CHANNEL)
@@ -560,12 +561,65 @@ static void stk_alpha_id_unset(struct ofono_stk *stk)
 	stk_agent_request_cancel(stk->current_agent);
 }
 =

+static void ofono_stk_activate_pdp_context_cb(int error, char *interface,
+						char *ipv4, char *ipv6,
+						void *data)
+{
+	struct ofono_stk *stk =3D data;
+	struct stk_response rsp;
+	struct ofono_error failure =3D { .type =3D OFONO_ERROR_TYPE_FAILURE };
+
+	DBG("");
+
+	memset(&rsp, 0, sizeof(rsp));
+
+	if (error !=3D 0) {
+		rsp.result.type =3D STK_RESULT_TYPE_NOT_CAPABLE;
+		goto out;
+	}
+
+	if (stk->pending_cmd =3D=3D NULL) {
+		/* TODO
+		 * send the event channel status
+		 * insert local address if dynamic local address is requested
+		 * insert bearer description if Open channel in background mode
+		 */
+		return;
+	}
+
+	DBG("Interface %s, ipv4 =3D %s, ipv6 =3D %s", interface, ipv4, ipv6);
+
+	stk->channel.status =3D STK_CHANNEL_PACKET_DATA_SERVICE_ACTIVATED;
+
+	if (stk->pending_cmd->type =3D=3D STK_COMMAND_TYPE_OPEN_CHANNEL) {
+		rsp.open_channel.channel.id =3D stk->channel.id;
+		rsp.open_channel.channel.status =3D stk->channel.status;
+		rsp.open_channel.buf_size =3D stk->rx_buffer.data.len;
+		memcpy(&rsp.open_channel.bearer_desc, &stk->bearer_desc,
+				sizeof(struct stk_bearer_description));
+	} else if (stk->pending_cmd->type =3D=3D STK_COMMAND_TYPE_SEND_DATA &&
+			stk->link_on_demand) {
+		/*
+		 * TODO
+		 * send the data immediately, flush the tx buffer
+		 */
+		stk->tx_buffer.tx_avail =3D stk->tx_buffer.data.len;
+		rsp.send_data.tx_avail =3D stk->tx_buffer.tx_avail;
+	}
+
+out:
+	if (stk_respond(stk, &rsp, stk_command_cb))
+		stk_command_cb(&failure, stk);
+}
 =

 static void stk_open_channel(struct ofono_stk *stk)
 {
 	const struct stk_command_open_channel *oc;
 	struct stk_response rsp;
 	struct ofono_error failure =3D { .type =3D OFONO_ERROR_TYPE_FAILURE };
+	char *host =3D NULL;
+	unsigned int id;
+	int err;
 =

 	if (stk->pending_cmd =3D=3D NULL ||
 		stk->pending_cmd->type !=3D STK_COMMAND_TYPE_OPEN_CHANNEL)
@@ -592,13 +646,52 @@ static void stk_open_channel(struct ofono_stk *stk)
 	stk->tx_buffer.data.len =3D oc->buf_size;
 	stk->link_on_demand =3D (stk->pending_cmd->qualifier &
 				STK_OPEN_CHANNEL_FLAG_IMMEDIATE) ? FALSE : TRUE;
-
+	memcpy(&stk->bearer_desc, &oc->bearer_desc,
+					sizeof(struct stk_bearer_description));
 	/*
-	 * TODO
 	 * Add a new primary PDP context based on the provided settings
-	 * Send the Terminal Response or wait until the PDP context is activated
-	 * in case of immediate link establishment not in background.
+	 * According 3GPP TS 31.111, the packet data protocol type is set to 02
+	 * '02' =3D IP (Internet Protocol, IETF STD 5)
 	 */
+
+	id =3D ofono_gprs_add_pdp_context(stk->gprs, "stk", "ip", oc->apn,
+					oc->text_usr, oc->text_passwd, host);
+
+	if (id =3D=3D 0) {
+		rsp.result.type =3D STK_RESULT_TYPE_NOT_CAPABLE;
+		goto out;
+	}
+
+	stk->channel.id =3D id;
+
+	if (stk->link_on_demand) {
+		rsp.open_channel.channel.id =3D id;
+		rsp.open_channel.channel.status =3D
+				STK_CHANNEL_PACKET_DATA_SERVICE_NOT_ACTIVATED;
+		rsp.open_channel.buf_size =3D oc->buf_size;
+		goto out;
+	}
+
+	err =3D ofono_gprs_activate_pdp_context(stk->gprs, id,
+					ofono_stk_activate_pdp_context_cb, stk);
+
+	if (err < 0) {
+		rsp.result.type =3D STK_RESULT_TYPE_NOT_CAPABLE;
+		goto out;
+	}
+
+	/* In background mode, send the terminal response now */
+	if (stk->pending_cmd->qualifier & STK_OPEN_CHANNEL_FLAG_BACKGROUND) {
+		rsp.open_channel.channel.id =3D id;
+		rsp.open_channel.channel.status =3D
+				STK_CHANNEL_PACKET_DATA_SERVICE_NOT_ACTIVATED;
+		rsp.open_channel.buf_size =3D oc->buf_size;
+		goto out;
+	}
+
+	/* wait for the PDP context activation to send the Terminal Response */
+	return;
+
 out:
 	if (stk_respond(stk, &rsp, stk_command_cb))
 		stk_command_cb(&failure, stk);
@@ -642,12 +735,19 @@ static void stk_send_data(struct ofono_stk *stk,
 =

 	if (stk->channel.status =3D=3D STK_CHANNEL_PACKET_DATA_SERVICE_NOT_ACTIVA=
TED
 			&& stk->link_on_demand =3D=3D TRUE) {
-		/*
-		 * TODO
-		 * activate the context, update the channel status
-		 * once the context is activated, send the data immediately
-		 * and flush the tx buffer
-		 */
+		int err;
+
+		err =3D ofono_gprs_activate_pdp_context(stk->gprs,
+					stk->channel.id,
+					ofono_stk_activate_pdp_context_cb,
+					stk);
+
+		if (err < 0) {
+			rsp.result.type =3D STK_RESULT_TYPE_NOT_CAPABLE;
+			goto out;
+		}
+
+		return;
 	} else {
 		/*
 		 * TODO
-- =

1.7.1


--===============0522086663823974793==--

