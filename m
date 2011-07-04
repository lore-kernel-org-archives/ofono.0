Content-Type: multipart/mixed; boundary="===============1874540431203251516=="
MIME-Version: 1.0
From: Philippe Nunes <philippe.nunes@linux.intel.com>
Subject: [PATCH v2 05/11] stk: Add 'ofono_stk_activate_cb' definition
Date: Mon, 04 Jul 2011 18:06:36 +0200
Message-ID: <1309795602-26046-6-git-send-email-philippe.nunes@linux.intel.com>
In-Reply-To: <1309795602-26046-1-git-send-email-philippe.nunes@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1874540431203251516==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/stk.c |  154 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++
 1 files changed, 154 insertions(+), 0 deletions(-)

diff --git a/src/stk.c b/src/stk.c
index 8d4f7c0..1e4d237 100644
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
@@ -88,6 +91,9 @@ struct ofono_stk {
 		struct ofono_gprs *gprs;
 		struct stk_bearer_description bearer_desc;
 		enum stk_transport_protocol_type protocol;
+		struct sockaddr_in dest_addr;
+		GIOChannel *io;
+		guint read_watch;
 	} bip;
 };
 =

@@ -582,10 +588,152 @@ static void stk_alpha_id_unset(struct ofono_stk *stk)
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
+		stk->bip.channel.status =3D
+				STK_CHANNEL_PACKET_DATA_SERVICE_ACTIVATED;
+	}
+
+	if (stk->bip.protocol =3D=3D STK_TRANSPORT_PROTOCOL_TCP_CLIENT_REMOTE) {
+		sk =3D socket(AF_INET, SOCK_STREAM, 0);
+		if (sk < 0) {
+			rsp.result.type =3D STK_RESULT_TYPE_NOT_CAPABLE;
+			goto out;
+		}
+
+		error =3D connect(sk, (struct sockaddr *) &stk->bip.dest_addr,
+						sizeof(stk->bip.dest_addr));
+
+		if (error < 0) {
+			close(sk);
+			rsp.result.type =3D STK_RESULT_TYPE_NOT_CAPABLE;
+			goto out;
+		}
+	} else if (stk->bip.protocol =3D=3D
+				STK_TRANSPORT_PROTOCOL_UDP_CLIENT_REMOTE) {
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
+	stk->bip.read_watch =3D g_io_add_watch_full(io, G_PRIORITY_DEFAULT,
+				G_IO_IN | G_IO_HUP | G_IO_ERR | G_IO_NVAL,
+				receive_callback, stk, NULL);
+	stk->bip.io =3D io;
+	g_io_channel_unref(io);
+
+	if (stk->pending_cmd =3D=3D NULL) {
+		/* TODO send channel status event */
+		return;
+	} else if (stk->pending_cmd->type =3D=3D STK_COMMAND_TYPE_OPEN_CHANNEL) {
+		rsp.open_channel.channel.id =3D stk->bip.channel.id;
+		rsp.open_channel.channel.status =3D stk->bip.channel.status;
+		rsp.open_channel.buf_size =3D stk->bip.tx_avail;
+		memcpy(&rsp.open_channel.bearer_desc, &stk->bip.bearer_desc,
+				sizeof(struct stk_bearer_description));
+	} else if (stk->pending_cmd->type =3D=3D STK_COMMAND_TYPE_SEND_DATA &&
+			stk->bip.link_on_demand) {
+		/* TODO send data */
+		rsp.send_data.tx_avail =3D stk->bip.tx_avail;
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
@@ -611,6 +759,12 @@ static void stk_open_channel(struct ofono_stk *stk)
 		 */
 		rsp.result.type =3D STK_RESULT_TYPE_NOT_CAPABLE;
 		goto out;
+	} else if (oc->data_dest_addr.type =3D=3D STK_ADDRESS_IPV4) {
+		memset(&stk->bip.dest_addr, 0, sizeof(stk->bip.dest_addr));
+		stk->bip.dest_addr.sin_family =3D AF_INET;
+		stk->bip.dest_addr.sin_port =3D htons(oc->uti.port);
+		stk->bip.dest_addr.sin_addr.s_addr
+						=3D oc->data_dest_addr.addr.ipv4;
 	}
 =

 	stk->bip.channel.id =3D DEFAULT_CHANNEL_ID;
-- =

1.7.1


--===============1874540431203251516==--

