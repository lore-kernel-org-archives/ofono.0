Content-Type: multipart/mixed; boundary="===============2483894932851953494=="
MIME-Version: 1.0
From: Philippe Nunes <philippe.nunes@linux.intel.com>
Subject: [PATCH 05/11] stk: Add 'ofono_stk_activate_cb' definition
Date: Tue, 28 Jun 2011 19:16:17 +0200
Message-ID: <1309281383-6605-6-git-send-email-philippe.nunes@linux.intel.com>
In-Reply-To: <1309281383-6605-1-git-send-email-philippe.nunes@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2483894932851953494==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/stk.c |  151 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++
 1 files changed, 151 insertions(+), 0 deletions(-)

diff --git a/src/stk.c b/src/stk.c
index 8426af7..1db45eb 100644
--- a/src/stk.c
+++ b/src/stk.c
@@ -28,6 +28,9 @@
 #include <stdio.h>
 #include <stdlib.h>
 #include <stdint.h>
+#include <arpa/inet.h>
+#include <net/if.h>
+#include <unistd.h>
 =

 #include <glib.h>
 #include <gdbus.h>
@@ -87,6 +90,9 @@ struct ofono_stk {
 	struct ofono_gprs *gprs;
 	struct stk_bearer_description bearer_desc;
 	enum stk_transport_protocol_type protocol;
+	struct sockaddr_in dest_addr;
+	GIOChannel *io;
+	guint read_watch;
 };
 =

 struct envelope_op {
@@ -571,10 +577,150 @@ static void stk_alpha_id_unset(struct ofono_stk *stk)
 	stk_agent_request_cancel(stk->current_agent);
 }
 =

+static gboolean receive_callback(GIOChannel *channel, GIOCondition cond,
+				gpointer userdata)
+{
+	return TRUE;
+}
+
 static void ofono_stk_activate_context_cb(int error, const char *interface,
 						const char *ip,
 						void *data)
 {
+	struct ofono_stk *stk =3D data;
+	struct stk_response rsp;
+	struct ofono_error failure =3D { .type =3D OFONO_ERROR_TYPE_FAILURE };
+	GIOChannel *io;
+	int sk;
+
+	DBG("");
+
+	memset(&rsp, 0, sizeof(rsp));
+	rsp.result.type =3D STK_RESULT_TYPE_SUCCESS;
+
+	if (error < 0) {
+		ofono_error("Failed to connect gprs context");
+
+		if (stk->pending_cmd =3D=3D NULL ||
+				(stk->pending_cmd->type !=3D
+				STK_COMMAND_TYPE_OPEN_CHANNEL &&
+				stk->pending_cmd->type !=3D
+				STK_COMMAND_TYPE_SEND_DATA)) {
+			/* TODO send channel status event */
+			return;
+		} else {
+			rsp.result.type =3D STK_RESULT_TYPE_NETWORK_UNAVAILABLE;
+			goto out;
+		}
+	} else {
+		DBG("Interface %s, IP =3D %s", interface, ip);
+		stk->channel.status =3D STK_CHANNEL_PACKET_DATA_SERVICE_ACTIVATED;
+	}
+
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
+		sk =3D socket(AF_INET, SOCK_RAW, 0);
+		if (sk < 0) {
+			rsp.result.type =3D STK_RESULT_TYPE_NOT_CAPABLE;
+			goto out;
+		}
+
+		/* Bind socket to specified interface */
+		if (interface) {
+			struct ifreq ifreq;
+
+			memset(&ifreq, 0, sizeof(ifreq));
+			strcpy(ifreq.ifr_name, interface);
+			error =3D setsockopt(sk, SOL_SOCKET,
+					SO_BINDTODEVICE, &ifreq, sizeof(ifreq));
+			if (error < 0) {
+				ofono_error("Failed to bind socket "
+						"to interface");
+				close(sk);
+				rsp.result.type =3D STK_RESULT_TYPE_NOT_CAPABLE;
+				goto out;
+			}
+		}
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
+	g_io_channel_set_flags(io, 0, NULL);
+	g_io_channel_set_encoding(io, NULL, NULL);
+	g_io_channel_set_buffered(io, FALSE);
+
+	stk->read_watch =3D g_io_add_watch_full(io, G_PRIORITY_DEFAULT,
+				G_IO_IN | G_IO_HUP | G_IO_ERR | G_IO_NVAL,
+				receive_callback, stk, NULL);
+	stk->io =3D io;
+	g_io_channel_unref(io);
+
+	if (stk->pending_cmd =3D=3D NULL) {
+		/* TODO send channel status event */
+		return;
+	} else if (stk->pending_cmd->type =3D=3D STK_COMMAND_TYPE_OPEN_CHANNEL) {
+		rsp.open_channel.channel.id =3D stk->channel.id;
+		rsp.open_channel.channel.status =3D stk->channel.status;
+		rsp.open_channel.buf_size =3D stk->tx_avail;
+		memcpy(&rsp.open_channel.bearer_desc, &stk->bearer_desc,
+				sizeof(struct stk_bearer_description));
+	} else if (stk->pending_cmd->type =3D=3D STK_COMMAND_TYPE_SEND_DATA &&
+			stk->link_on_demand) {
+		/* TODO send data */
+		rsp.send_data.tx_avail =3D stk->tx_avail;
+	} else {
+		/* TODO send channel status event */
+		return;
+	}
+
+out:
+	if (stk_respond(stk, &rsp, stk_command_cb))
+		stk_command_cb(&failure, stk);
+
+	if (rsp.result.type !=3D STK_RESULT_TYPE_SUCCESS)
+		stk_close_channel(stk);
 }
 =

 static void stk_open_channel(struct ofono_stk *stk)
@@ -602,6 +748,11 @@ static void stk_open_channel(struct ofono_stk *stk)
 		 */
 		rsp.result.type =3D STK_RESULT_TYPE_NOT_CAPABLE;
 		goto out;
+	} else if (oc->data_dest_addr.type =3D=3D STK_ADDRESS_IPV4) {
+		memset(&stk->dest_addr, 0, sizeof(stk->dest_addr));
+		stk->dest_addr.sin_family =3D AF_INET;
+		stk->dest_addr.sin_port =3D htons(oc->uti.port);
+		stk->dest_addr.sin_addr.s_addr =3D oc->data_dest_addr.addr.ipv4;
 	}
 =

 	stk->channel.id =3D DEFAULT_CHANNEL_ID;
-- =

1.7.1


--===============2483894932851953494==--

