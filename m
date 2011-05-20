Content-Type: multipart/mixed; boundary="===============0749327264796156295=="
MIME-Version: 1.0
From: Philippe Nunes <philippe.nunes@linux.intel.com>
Subject: [PATCH v4 5/8] stk: Use Gprs private APIs to handle the
 Open	channel/Close Channel
Date: Fri, 20 May 2011 18:26:18 +0200
Message-ID: <1305908781-8322-5-git-send-email-philippe.nunes@linux.intel.com>
In-Reply-To: <1305908781-8322-1-git-send-email-philippe.nunes@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0749327264796156295==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/stk.c |  198 +++++++++++++++++++++++++++++++++++++++++++++++++++++----=
---
 1 files changed, 175 insertions(+), 23 deletions(-)

diff --git a/src/stk.c b/src/stk.c
index fb376a6..d9f1e25 100644
--- a/src/stk.c
+++ b/src/stk.c
@@ -28,6 +28,7 @@
 #include <stdio.h>
 #include <stdlib.h>
 #include <stdint.h>
+#include <arpa/inet.h>
 =

 #include <glib.h>
 #include <gdbus.h>
@@ -85,6 +86,7 @@ struct ofono_stk {
 	struct stk_channel_data tx_buffer;
 	gboolean link_on_demand;
 	struct ofono_gprs *gprs;
+	struct stk_bearer_description bearer_desc;
 };
 =

 struct envelope_op {
@@ -487,27 +489,57 @@ static void emit_menu_changed(struct ofono_stk *stk)
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
 =

-	/* Temporary implementation */
+	DBG("");
+
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
+			send_simple_response(stk, STK_RESULT_TYPE_SUCCESS);
+	}
 }
 =

 static void user_termination_cb(enum stk_agent_result result, void *user_d=
ata)
@@ -554,12 +586,66 @@ static void stk_alpha_id_unset(struct ofono_stk *stk)
 	stk_agent_request_cancel(stk->current_agent);
 }
 =

+static void ofono_stk_activate_pdp_context_cb(int error, const char *inter=
face,
+						const char *ip,
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
+		goto out;
+	} else {
+		DBG("Interface %s, IP =3D %s", interface, ip);
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
+		/*
+		 * TODO
+		 * send the data immediately, flush the tx buffer
+		 */
+
+		rsp.send_data.tx_avail =3D stk->tx_buffer.tx_avail;
+	}
+
+out:
+	if (stk_respond(stk, &rsp, stk_command_cb))
+		stk_command_cb(&failure, stk);
+
+	if (error < 0)
+		stk_close_channel(stk);
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
@@ -570,6 +656,37 @@ static void stk_open_channel(struct ofono_stk *stk)
 	memset(&rsp, 0, sizeof(rsp));
 	rsp.result.type =3D STK_RESULT_TYPE_SUCCESS;
 =

+	if (oc->data_dest_addr.type =3D=3D STK_ADDRESS_IPV4) {
+		struct in_addr addr;
+
+		host =3D g_try_malloc0(INET_ADDRSTRLEN);
+		memset(host, 0, sizeof(host));
+		addr.s_addr =3D oc->data_dest_addr.addr.ipv4;
+		inet_ntop(AF_INET, &addr, host, INET_ADDRSTRLEN);
+	} else {
+		/*
+		 * For now, only the bearer type "GPRS / UTRAN packet service /
+		 * E-UTRAN" is supported.
+		 * For such bearer, according 3GPP TS 31.111, the packet data
+		 * protocol type is IP, so only IPv4 addresses are considered.
+		 */
+		rsp.result.type =3D STK_RESULT_TYPE_NOT_CAPABLE;
+		goto out;
+	}
+
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
+	ofono_info("Channel %d", id);
+
 	stk->rx_buffer.data.array =3D g_try_malloc(oc->buf_size);
 	if (stk->rx_buffer.data.array =3D=3D NULL) {
 		unsigned char no_cause_result[] =3D { 0x00 };
@@ -592,16 +709,44 @@ static void stk_open_channel(struct ofono_stk *stk)
 	stk->rx_buffer.rx_remaining =3D 0;
 	stk->tx_buffer.data.len =3D oc->buf_size;
 	stk->tx_buffer.tx_avail =3D oc->buf_size;
+
+	memcpy(&stk->bearer_desc, &oc->bearer_desc,
+					sizeof(struct stk_bearer_description));
 	stk->link_on_demand =3D (stk->pending_cmd->qualifier &
 				STK_OPEN_CHANNEL_FLAG_IMMEDIATE) ? FALSE : TRUE;
 =

-	/*
-	 * TODO
-	 * Add a new primary PDP context based on the provided settings
-	 * Send the Terminal Response or wait until the PDP context is activated
-	 * in case of immediate link establishment not in background.
-	 */
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
+	g_free(host);
+	/* wait for the PDP context activation to send the Terminal Response */
+	return;
+
 out:
+	g_free(host);
+
 	if (stk_respond(stk, &rsp, stk_command_cb))
 		stk_command_cb(&failure, stk);
 =

@@ -641,12 +786,19 @@ static void stk_send_data(struct ofono_stk *stk,
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


--===============0749327264796156295==--

