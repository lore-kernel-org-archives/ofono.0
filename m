Content-Type: multipart/mixed; boundary="===============8448002446249864654=="
MIME-Version: 1.0
From: Philippe Nunes <philippe.nunes@linux.intel.com>
Subject: [PATCH v3 5/7] stk: Use Gprs private APIs to handle the Open
 channel/Close Channel
Date: Fri, 13 May 2011 19:22:02 +0200
Message-ID: <1305307324-19548-5-git-send-email-philippe.nunes@linux.intel.com>
In-Reply-To: <1305307324-19548-1-git-send-email-philippe.nunes@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8448002446249864654==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/stk.c |  177 ++++++++++++++++++++++++++++++++++++++++++++++++++++-----=
----
 1 files changed, 152 insertions(+), 25 deletions(-)

diff --git a/src/stk.c b/src/stk.c
index dec0439..62e5465 100644
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
@@ -487,32 +488,56 @@ static void emit_menu_changed(struct ofono_stk *stk)
 	g_dbus_send_message(conn, signal);
 }
 =

-static void stk_close_channel(struct ofono_stk *stk)
+static void ofono_stk_remove_pdp_context_cb(int error, void *data)
 {
-	/*
-	 * TODO
-	 * Deactivate and remove PDP context
-	 * Send the Terminal Response once the PDP context is deactivated
-	 */
+	struct ofono_stk *stk =3D data;
+
+	DBG("");
 =

-	/* Temporary implementation */
+	stk->channel.status =3D STK_CHANNEL_PACKET_DATA_SERVICE_NOT_ACTIVATED;
+
+	if (stk->pending_cmd && stk->pending_cmd->type =3D=3D
+			STK_COMMAND_TYPE_CLOSE_CHANNEL) {
+		if (error < 0)
+			send_simple_response(stk, STK_RESULT_TYPE_NOT_CAPABLE);
+		else
+			send_simple_response(stk, STK_RESULT_TYPE_SUCCESS);
+	} else {
+		/*
+		 * TODO
+		 * Send Event channel status
+		 */
+	}
+
+	/* free the buffers even in case of error */
 	g_free(stk->rx_buffer.data.array);
 	g_free(stk->tx_buffer.data.array);
 	stk->rx_buffer.data.array =3D NULL;
 	stk->tx_buffer.data.array =3D NULL;
 =

 	stk->channel.id =3D 0;
-	stk->channel.status =3D STK_CHANNEL_PACKET_DATA_SERVICE_NOT_ACTIVATED;
+}
+
+static void stk_close_channel(struct ofono_stk *stk)
+{
+	int err;
+
+	err =3D __ofono_gprs_remove_pdp_context(stk->gprs, stk->channel.id,
+			ofono_stk_remove_pdp_context_cb, stk);
 =

-	if (stk->pending_cmd &&
-			stk->pending_cmd->type =3D=3D
+	if (err =3D=3D 0) {
+		g_free(stk->rx_buffer.data.array);
+		g_free(stk->tx_buffer.data.array);
+		stk->rx_buffer.data.array =3D NULL;
+		stk->tx_buffer.data.array =3D NULL;
+
+		stk->channel.id =3D 0;
+		stk->channel.status =3D
+				STK_CHANNEL_PACKET_DATA_SERVICE_NOT_ACTIVATED;
+
+		if (stk->pending_cmd && stk->pending_cmd->type =3D=3D
 				STK_COMMAND_TYPE_CLOSE_CHANNEL)
-		send_simple_response(stk, STK_RESULT_TYPE_SUCCESS);
-	else {
-		/*
-		 * TODO
-		 * Send Event channel status
-		 */
+			send_simple_response(stk, STK_RESULT_TYPE_SUCCESS);
 	}
 }
 =

@@ -560,12 +585,66 @@ static void stk_alpha_id_unset(struct ofono_stk *stk)
 	stk_agent_request_cancel(stk->current_agent);
 }
 =

+static void ofono_stk_activate_pdp_context_cb(int error, const char *inter=
face,
+						const char *ipv4,
+						const char *ipv6,
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
+	if (error < 0) {
+		rsp.result.type =3D STK_RESULT_TYPE_NOT_CAPABLE;
+	} else {
+		DBG("Interface %s, ipv4 =3D %s, ipv6 =3D %s", interface, ipv4,
+									ipv6);
+		stk->channel.status =3D STK_CHANNEL_PACKET_DATA_SERVICE_ACTIVATED;
+	}
+
+	if (stk->pending_cmd =3D=3D NULL) {
+		/*
+		 * TODO
+		 * Send Event channel status
+		 */
+		return;
+	}
+
+	if (stk->pending_cmd->type =3D=3D STK_COMMAND_TYPE_OPEN_CHANNEL) {
+		rsp.open_channel.channel.id =3D stk->channel.id;
+		rsp.open_channel.channel.status =3D stk->channel.status;
+		rsp.open_channel.buf_size =3D stk->rx_buffer.data.len;
+		memcpy(&rsp.open_channel.bearer_desc, &stk->bearer_desc,
+				sizeof(struct stk_bearer_description));
+	} else if (stk->pending_cmd->type =3D=3D STK_COMMAND_TYPE_SEND_DATA &&
+			stk->link_on_demand) {
+
+		if (error =3D=3D 0) {
+			/*
+			 * TODO
+			 * send the data immediately, flush the tx buffer
+			 */
+			stk->tx_buffer.tx_avail =3D stk->tx_buffer.data.len;
+			rsp.send_data.tx_avail =3D stk->tx_buffer.tx_avail;
+		}
+	}
+
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
@@ -592,13 +671,54 @@ static void stk_open_channel(struct ofono_stk *stk)
 	stk->tx_buffer.data.len =3D oc->buf_size;
 	stk->link_on_demand =3D (stk->pending_cmd->qualifier &
 				STK_OPEN_CHANNEL_FLAG_IMMEDIATE) ? FALSE : TRUE;
+	memcpy(&stk->bearer_desc, &oc->bearer_desc,
+					sizeof(struct stk_bearer_description));
 =

 	/*
-	 * TODO
 	 * Add a new primary PDP context based on the provided settings
-	 * Send the Terminal Response or wait until the PDP context is activated
-	 * in case of immediate link establishment not in background.
+	 * According 3GPP TS 31.111, the packet data protocol type is set to 02
+	 * '02' =3D IP (Internet Protocol, IETF STD 5)
 	 */
+	id =3D __ofono_gprs_add_pdp_context(stk->gprs,
+					OFONO_GPRS_CONTEXT_TYPE_STK,
+					OFONO_GPRS_PROTO_IP, oc->apn,
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
+	err =3D __ofono_gprs_activate_pdp_context(stk->gprs, id,
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
@@ -642,12 +762,19 @@ static void stk_send_data(struct ofono_stk *stk,
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
+		err =3D __ofono_gprs_activate_pdp_context(stk->gprs,
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


--===============8448002446249864654==--

