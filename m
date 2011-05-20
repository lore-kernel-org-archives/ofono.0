Content-Type: multipart/mixed; boundary="===============6848792259451110265=="
MIME-Version: 1.0
From: Philippe Nunes <philippe.nunes@linux.intel.com>
Subject: [PATCH v4 8/8] stk: Add read/write handlers
Date: Fri, 20 May 2011 18:26:21 +0200
Message-ID: <1305908781-8322-8-git-send-email-philippe.nunes@linux.intel.com>
In-Reply-To: <1305908781-8322-1-git-send-email-philippe.nunes@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6848792259451110265==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/stk.c |  171 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++=
----
 1 files changed, 161 insertions(+), 10 deletions(-)

diff --git a/src/stk.c b/src/stk.c
index fbd93c3..72ca936 100644
--- a/src/stk.c
+++ b/src/stk.c
@@ -29,6 +29,8 @@
 #include <stdlib.h>
 #include <stdint.h>
 #include <arpa/inet.h>
+#include <unistd.h>
+#include <fcntl.h>
 =

 #include <glib.h>
 #include <gdbus.h>
@@ -89,6 +91,10 @@ struct ofono_stk {
 	gboolean report_channel_status;
 	struct ofono_gprs *gprs;
 	struct stk_bearer_description bearer_desc;
+	enum stk_transport_protocol_type protocol;
+	struct sockaddr_in dest_addr;
+	GIOChannel *io;
+	guint read_watch;
 };
 =

 struct envelope_op {
@@ -573,6 +579,9 @@ static void stk_close_channel(struct ofono_stk *stk)
 {
 	int err;
 =

+	if (stk->read_watch > 0)
+		g_source_remove(stk->read_watch);
+
 	err =3D __ofono_gprs_remove_pdp_context(stk->gprs, stk->channel.id,
 			ofono_stk_remove_pdp_context_cb, stk);
 =

@@ -636,6 +645,74 @@ static void stk_alpha_id_unset(struct ofono_stk *stk)
 	stk_agent_request_cancel(stk->current_agent);
 }
 =

+gsize stk_channel_data_write(struct ofono_stk *stk)
+{
+	GIOStatus status;
+	gsize bytes_written;
+	gchar *data =3D (gchar *)(stk->tx_buffer.data.array);
+	gsize count =3D stk->tx_buffer.data.len - stk->tx_buffer.tx_avail;
+
+	if (stk->protocol =3D=3D STK_TRANSPORT_PROTOCOL_UDP_CLIENT_REMOTE) {
+		bytes_written =3D sendto(g_io_channel_unix_get_fd(stk->io), data,
+				count, 0, &stk->dest_addr,
+				sizeof(stk->dest_addr));
+
+		if (bytes_written =3D=3D -1 && stk->read_watch > 0) {
+			g_source_remove(stk->read_watch);
+			return 0;
+		}
+	} else {
+		status =3D g_io_channel_write_chars(stk->io, data,
+						count, &bytes_written, NULL);
+
+		if (status !=3D G_IO_STATUS_NORMAL && stk->read_watch > 0) {
+			g_source_remove(stk->read_watch);
+			return 0;
+		}
+	}
+
+	DBG("Send %zd bytes", bytes_written);
+
+	stk->tx_buffer.tx_avail +=3D bytes_written;
+	count =3D stk->tx_buffer.data.len - stk->rx_buffer.tx_avail;
+	if (count > 0)
+		memmove(stk->tx_buffer.data.array, stk->rx_buffer.data.array +
+			bytes_written, count);
+
+	return bytes_written;
+}
+
+static gboolean receive_callback(GIOChannel *channel, GIOCondition cond,
+				gpointer userdata)
+{
+	struct ofono_stk *stk =3D (struct ofono_stk *) userdata;
+	GIOStatus status;
+	gsize bytes_read;
+	gchar *buf =3D (gchar *)(stk->rx_buffer.data.array +
+						stk->rx_buffer.rx_remaining);
+	gsize count =3D stk->rx_buffer.data.len - stk->rx_buffer.rx_remaining;
+
+	if (cond & (G_IO_NVAL | G_IO_ERR | G_IO_HUP))
+		return FALSE;
+
+	if (cond & G_IO_IN) {
+		status =3D g_io_channel_read_chars(channel, buf, count,
+							&bytes_read, NULL);
+		DBG("Received %zd bytes", bytes_read);
+
+		if (bytes_read > 0 && stk->rx_buffer.rx_remaining =3D=3D 0 &&
+				stk->report_data_available) {
+			stk_send_data_available_event(stk, bytes_read);
+		}
+
+		stk->rx_buffer.rx_remaining +=3D bytes_read;
+
+		if (status !=3D G_IO_STATUS_NORMAL && status !=3D G_IO_STATUS_AGAIN)
+			return FALSE;
+	}
+	return TRUE;
+}
+
 static void ofono_stk_activate_pdp_context_cb(int error, const char *inter=
face,
 						const char *ip,
 						void *data)
@@ -643,6 +720,8 @@ static void ofono_stk_activate_pdp_context_cb(int error=
, const char *interface,
 	struct ofono_stk *stk =3D data;
 	struct stk_response rsp;
 	struct ofono_error failure =3D { .type =3D OFONO_ERROR_TYPE_FAILURE };
+	GIOChannel *io;
+	int sk;
 =

 	DBG("");
 =

@@ -656,6 +735,67 @@ static void ofono_stk_activate_pdp_context_cb(int erro=
r, const char *interface,
 		stk->channel.status =3D STK_CHANNEL_PACKET_DATA_SERVICE_ACTIVATED;
 	}
 =

+	if (stk->protocol =3D=3D STK_TRANSPORT_PROTOCOL_TCP_CLIENT_REMOTE) {
+		sk =3D socket(AF_INET, SOCK_STREAM, 0);
+		if (sk < 0) {
+			rsp.result.type =3D STK_RESULT_TYPE_NOT_CAPABLE;
+			goto out;
+		}
+
+		error =3D connect(sk, (struct sockaddr *) &stk->dest_addr,
+						sizeof(stk->dest_addr));
+
+		if (error < 0) {
+			close(sk);
+			rsp.result.type =3D STK_RESULT_TYPE_NOT_CAPABLE;
+			goto out;
+		}
+	} else if (stk->protocol =3D=3D STK_TRANSPORT_PROTOCOL_UDP_CLIENT_REMOTE)=
 {
+		struct sockaddr_in addr;
+
+		sk =3D socket(AF_INET, SOCK_DGRAM, 0);
+		if (sk < 0) {
+			rsp.result.type =3D STK_RESULT_TYPE_NOT_CAPABLE;
+			goto out;
+		}
+
+		memset(&addr, 0, sizeof(addr));
+		addr.sin_family =3D AF_INET;
+		addr.sin_addr.s_addr =3D htonl(INADDR_ANY);
+		addr.sin_port =3D htons(0);
+
+		error =3D bind(sk, (struct sockaddr *) &addr, sizeof(addr));
+		if (error < 0) {
+			close(sk);
+			rsp.result.type =3D STK_RESULT_TYPE_NOT_CAPABLE;
+			goto out;
+		}
+	} else {
+		/* raw IP */
+		sk =3D open(interface, O_RDWR);
+		if (sk < 0)
+			return;
+	}
+
+	io =3D g_io_channel_unix_new(sk);
+	if (io =3D=3D NULL) {
+		close(sk);
+		error =3D -ENOMEM;
+		rsp.result.type =3D STK_RESULT_TYPE_NOT_CAPABLE;
+		goto out;
+	}
+
+	g_io_channel_set_close_on_unref(io, TRUE);
+	g_io_channel_set_flags(io, G_IO_FLAG_NONBLOCK, NULL);
+	g_io_channel_set_encoding(io, NULL, NULL);
+	g_io_channel_set_buffered(io, FALSE);
+
+	stk->read_watch =3D g_io_add_watch_full(io, G_PRIORITY_DEFAULT,
+				G_IO_IN | G_IO_HUP | G_IO_ERR | G_IO_NVAL,
+				receive_callback, stk, NULL);
+	stk->io =3D io;
+	g_io_channel_unref(io);
+
 	if (stk->pending_cmd =3D=3D NULL) {
 		if (stk->report_channel_status)
 			stk_send_channel_status_event(stk);
@@ -670,11 +810,13 @@ static void ofono_stk_activate_pdp_context_cb(int err=
or, const char *interface,
 				sizeof(struct stk_bearer_description));
 	} else if (stk->pending_cmd->type =3D=3D STK_COMMAND_TYPE_SEND_DATA &&
 			stk->link_on_demand) {
-		/*
-		 * TODO
-		 * send the data immediately, flush the tx buffer
-		 */
-
+		while (stk->tx_buffer.data.len - stk->tx_buffer.tx_avail) {
+			if (stk_channel_data_write(stk) =3D=3D 0) {
+				ofono_error("Failed to send data");
+				rsp.result.type =3D STK_RESULT_TYPE_NOT_CAPABLE;
+				goto out;
+			}
+		}
 		rsp.send_data.tx_avail =3D stk->tx_buffer.tx_avail;
 	}
 =

@@ -711,6 +853,11 @@ static void stk_open_channel(struct ofono_stk *stk)
 		memset(host, 0, sizeof(host));
 		addr.s_addr =3D oc->data_dest_addr.addr.ipv4;
 		inet_ntop(AF_INET, &addr, host, INET_ADDRSTRLEN);
+
+		memset(&stk->dest_addr, 0, sizeof(stk->dest_addr));
+		stk->dest_addr.sin_family =3D AF_INET;
+		stk->dest_addr.sin_port =3D htons(oc->uti.port);
+		stk->dest_addr.sin_addr.s_addr =3D oc->data_dest_addr.addr.ipv4;
 	} else {
 		/*
 		 * For now, only the bearer type "GPRS / UTRAN packet service /
@@ -760,6 +907,7 @@ static void stk_open_channel(struct ofono_stk *stk)
 =

 	memcpy(&stk->bearer_desc, &oc->bearer_desc,
 					sizeof(struct stk_bearer_description));
+	stk->protocol =3D oc->uti.protocol;
 	stk->link_on_demand =3D (stk->pending_cmd->qualifier &
 				STK_OPEN_CHANNEL_FLAG_IMMEDIATE) ? FALSE : TRUE;
 =

@@ -848,11 +996,14 @@ static void stk_send_data(struct ofono_stk *stk,
 =

 		return;
 	} else {
-		/*
-		 * TODO
-		 * send the data immediately, flush the tx buffer
-		 */
-		rsp.send_data.tx_avail =3D stk->tx_buffer.data.len;
+		while (stk->tx_buffer.data.len - stk->tx_buffer.tx_avail) {
+			if (stk_channel_data_write(stk) =3D=3D 0) {
+				ofono_error("Failed to send data");
+				rsp.result.type =3D STK_RESULT_TYPE_NOT_CAPABLE;
+				goto out;
+			}
+		}
+		rsp.send_data.tx_avail =3D stk->tx_buffer.tx_avail;
 	}
 =

 out:
-- =

1.7.1


--===============6848792259451110265==--

