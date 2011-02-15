Content-Type: multipart/mixed; boundary="===============8929912587374052051=="
MIME-Version: 1.0
From: Andreas Westin <andreas.westin@stericsson.com>
Subject: [PATCH 01/18] gisi: pipe and pep for wgmodem2.5
Date: Tue, 15 Feb 2011 13:30:55 +0100
Message-ID: <f492c9a7397b927f36e345450bd884bbb37a10fd.1297772944.git.andreas.westin@stericsson.com>
In-Reply-To: <cover.1297772944.git.andreas.westin@stericsson.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8929912587374052051==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Jessica Nilsson <jessica.j.nilsson@stericsson.com>

---
 gisi/message.c |    8 ++
 gisi/message.h |    1 +
 gisi/modem.c   |   20 ++++
 gisi/modem.h   |    1 +
 gisi/pep.c     |  330 ++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++
 gisi/pep.h     |    6 +
 gisi/pipe.c    |  180 ++++++++++++++++++++++++++++--
 gisi/pipe.h    |   17 +++
 8 files changed, 551 insertions(+), 12 deletions(-)

diff --git a/gisi/message.c b/gisi/message.c
index 8f4fe5a..9d00108 100644
--- a/gisi/message.c
+++ b/gisi/message.c
@@ -65,6 +65,14 @@ uint8_t g_isi_msg_resource(const GIsiMessage *msg)
 	return msg->addr->spn_resource;
 }
 =

+uint8_t g_isi_msg_device(const GIsiMessage *msg)
+{
+	if (msg =3D=3D NULL || msg->addr =3D=3D NULL)
+		return 0;
+
+	return msg->addr->spn_dev;
+}
+
 uint16_t g_isi_msg_object(const GIsiMessage *msg)
 {
 	if (msg =3D=3D NULL || msg->addr =3D=3D NULL)
diff --git a/gisi/message.h b/gisi/message.h
index 95348f8..f34ce57 100644
--- a/gisi/message.h
+++ b/gisi/message.h
@@ -52,6 +52,7 @@ int g_isi_msg_version_minor(const GIsiMessage *msg);
 int g_isi_msg_error(const GIsiMessage *msg);
 const char *g_isi_msg_strerror(const GIsiMessage *msg);
 uint8_t g_isi_msg_resource(const GIsiMessage *msg);
+uint8_t g_isi_msg_device(const GIsiMessage *msg);
 uint16_t g_isi_msg_object(const GIsiMessage *msg);
 =

 uint8_t g_isi_msg_id(const GIsiMessage *msg);
diff --git a/gisi/modem.c b/gisi/modem.c
index f745bb2..7657bd1 100644
--- a/gisi/modem.c
+++ b/gisi/modem.c
@@ -519,6 +519,26 @@ GIsiModem *g_isi_modem_create_by_name(const char *name)
 	return g_isi_modem_create(if_nametoindex(name));
 }
 =

+guint g_isi_modem_add_to_watch(GIsiModem *modem, int fd)
+{
+	GIOChannel *channel;
+	guint watch;
+
+	if (modem =3D=3D NULL || fd < 0)
+		return 0;
+
+	channel =3D g_io_channel_unix_new(fd);
+	g_io_channel_set_close_on_unref(channel, TRUE);
+	g_io_channel_set_encoding(channel, NULL, NULL);
+	g_io_channel_set_buffered(channel, FALSE);
+	watch =3D g_io_add_watch(channel,
+				G_IO_IN|G_IO_ERR|G_IO_HUP|G_IO_NVAL,
+				isi_callback, modem);
+	g_io_channel_unref(channel);
+
+	return watch;
+}
+
 void *g_isi_modem_set_userdata(GIsiModem *modem, void *data)
 {
 	void *old;
diff --git a/gisi/modem.h b/gisi/modem.h
index 0397a87..83ba92c 100644
--- a/gisi/modem.h
+++ b/gisi/modem.h
@@ -48,6 +48,7 @@ typedef void (*GIsiDebugFunc)(const char *fmt, ...);
 GIsiModem *g_isi_modem_create(unsigned index);
 GIsiModem *g_isi_modem_create_by_name(const char *name);
 void g_isi_modem_destroy(GIsiModem *modem);
+guint g_isi_modem_add_to_watch(GIsiModem *modem, int fd);
 =

 unsigned g_isi_modem_index(GIsiModem *modem);
 =

diff --git a/gisi/pep.c b/gisi/pep.c
index c82dc39..98b5ee0 100644
--- a/gisi/pep.c
+++ b/gisi/pep.c
@@ -3,6 +3,7 @@
  *  oFono - Open Source Telephony
  *
  *  Copyright (C) 2009-2010 Nokia Corporation and/or its subsidiary(-ies).
+ *  Copyright (C) ST-Ericsson SA 2011.
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2 as
@@ -30,10 +31,18 @@
 #include <unistd.h>
 #include <glib.h>
 =

+#include "common.h"
 #include "phonet.h"
 #include "socket.h"
+#include "modem.h"
+#include "client.h"
+#include "server.h"
 #include "pep.h"
 =

+#define PN_PIPE					0xD9
+#define PN_PIPE_INVALID_HANDLE	0xFF
+#define PN_OBJ_PEP_GPRS			0x30
+
 struct _GIsiPEP {
 	GIsiPEPCallback ready;
 	void *opaque;
@@ -42,6 +51,88 @@ struct _GIsiPEP {
 	uint16_t handle;
 };
 =

+struct isi_pipe_created_ind{
+	uint8_t cmd;
+	uint8_t pipe_handle;
+	uint8_t n_sb;
+	uint8_t sb_neg_fc;
+	uint8_t sb_len;
+	uint8_t tx_fc;
+	uint8_t rx_fc;
+};
+
+struct isi_pep_resp {
+	uint8_t pipe_handle;
+	uint8_t error_code;
+};
+
+struct isi_pep_connect_req{
+	uint8_t cmd;
+	uint8_t pipe_handle;
+	uint8_t state_after;
+	uint8_t other_pep_type;
+	uint8_t filler1;
+	uint8_t filler2;
+	uint8_t n_sb;
+	uint8_t data_sb;
+	uint8_t sb_len;
+	uint8_t alignment;
+	uint8_t filler;
+};
+
+struct isi_pipe_enabled_ind{
+	uint8_t cmd;
+	uint8_t pipe_handle;
+	uint8_t filler;
+};
+
+
+struct isi_pep_enable_req{
+	uint8_t cmd;
+	uint8_t pipe_handle;
+	uint8_t filler;
+};
+
+struct isi_pep_disconnect_req{
+	uint8_t cmd;
+	uint8_t pipe_handle;
+	uint8_t filler;
+};
+
+enum pn_flow_control {
+	PN_NO_FLOW_CONTROL =3D		0x00,
+	PN_LEGACY_FLOW_CONTROL =3D	0x01,
+	PN_ONE_CREDIT_FLOW_CONTROL =3D	0x02,
+	PN_MULTI_CREDIT_FLOW_CONTROL =3D	0x03,
+};
+
+enum isi_pep_message_id {
+	PNS_PEP_CONNECT_REQ =3D		0x40,
+	PNS_PEP_CONNECT_RESP =3D		0x41,
+	PNS_PEP_DISCONNECT_REQ =3D	0x42,
+	PNS_PEP_DISCONNECT_RESP =3D	0x43,
+	PNS_PEP_ENABLE_REQ =3D		0x46,
+	PNS_PEP_ENABLE_RESP =3D		0x47,
+	PNS_PIPE_CREATED_IND =3D		0x61,
+	PNS_PIPE_ENABLED_IND =3D		0x64,
+};
+
+enum isi_pep_sb_id {
+	PN_PIPE_SB_NEGOTIATED_FC =3D	0x03,
+	PN_PIPE_SB_ALIGNED_DATA =3D	0x06,
+};
+
+enum isi_pep_type {
+	PN_PEP_TYPE_COMMON
+};
+
+enum pn_pep_state {	/* initial pep state */
+	PN_PEP_DISABLE,
+	PN_PEP_ENABLE,
+};
+
+
+static void g_isi_pep_disconnected(const GIsiMessage *msg, void *data);
 =

 static gboolean g_isi_pep_callback(GIOChannel *channel, GIOCondition cond,
 					gpointer data)
@@ -153,3 +244,242 @@ char *g_isi_pep_get_ifname(const GIsiPEP *pep, char *=
ifname)
 =

 	return if_indextoname(g_isi_pep_get_ifindex(pep), ifname);
 }
+
+static void g_isi_pep_connected(const GIsiMessage *msg, void *data)
+{
+	struct isi_pep_resp *resp;
+	size_t len =3D sizeof(struct isi_pep_resp);
+	GIsiPipe *pipe =3D data;
+	GIsiClient *client =3D g_isi_pipe_client(pipe);
+	struct isi_pipe_created_ind ind =3D {
+		.cmd =3D PNS_PIPE_CREATED_IND,
+		.pipe_handle =3D 0x00,
+		.n_sb =3D 0x01,
+		.sb_neg_fc =3D PN_PIPE_SB_NEGOTIATED_FC,
+		.sb_len =3D 0x04,
+		.tx_fc =3D PN_LEGACY_FLOW_CONTROL,
+		.rx_fc =3D PN_LEGACY_FLOW_CONTROL,
+	};
+
+	if (g_isi_msg_error(msg) < 0) {
+		g_isi_pipe_set_error_timeout(pipe);
+		return;
+	}
+
+	if (g_isi_msg_id(msg) !=3D PNS_PEP_CONNECT_RESP)
+		return;
+
+	if (!g_isi_msg_data_get_struct(msg, 0, (const void **) &resp, len))
+		return;
+
+	if (resp->pipe_handle =3D=3D PN_PIPE_INVALID_HANDLE) {
+		g_isi_pipe_handle_error(pipe, resp->error_code);
+		return;
+	}
+
+	g_isi_pipe_set_handle(pipe, resp->pipe_handle);
+	ind.pipe_handle =3D resp->pipe_handle;
+
+	if (g_isi_request_sendto(g_isi_client_modem(client), msg->addr, &ind,
+			sizeof(ind), G_ISI_CLIENT_DEFAULT_TIMEOUT,
+			NULL, NULL, NULL) =3D=3D NULL) {
+			g_isi_pipe_set_error_general(pipe);
+			return;
+	}
+
+	if (g_isi_msg_device(msg) =3D=3D PN_DEV_HOST) {
+		g_isi_pep_connect(pipe, g_isi_pipe_get_handle(pipe),
+					PN_DEV_MODEM);
+		return;
+	}
+
+	if (g_isi_pipe_get_enabling(pipe))
+		g_isi_pipe_start(pipe);
+
+	g_isi_pipe_start_handler(pipe);
+
+}
+
+gboolean g_isi_pep_connect(GIsiPipe *pipe, uint8_t obj, uint8_t dev)
+{
+	GIsiClient *client =3D  g_isi_pipe_client(pipe);
+	struct sockaddr_pn dst =3D {
+		.spn_family =3D AF_PHONET,
+	};
+	struct isi_pep_connect_req msg =3D {
+		.cmd =3D PNS_PEP_CONNECT_REQ,
+		.pipe_handle =3D obj,
+		.state_after =3D PN_PEP_DISABLE,
+		.other_pep_type =3D PN_PEP_TYPE_COMMON,
+		.filler1 =3D 0x00,
+		.filler2 =3D 0x00,
+		.n_sb =3D 0x00,
+	};
+
+	if (dev =3D=3D PN_DEV_HOST) {
+		dst.spn_dev =3D PN_DEV_HOST;
+		dst.spn_resource =3D PN_PIPE;
+		dst.spn_obj =3D obj;
+	} else if (dev =3D=3D PN_DEV_MODEM) {
+		dst.spn_dev =3D PN_DEV_MODEM;
+		dst.spn_resource =3D g_isi_client_resource(client);
+		dst.spn_obj =3D PN_OBJ_PEP_GPRS;
+	} else
+		return FALSE;
+
+	if (g_isi_request_sendto(g_isi_client_modem(client), &dst, &msg,
+			sizeof(msg), G_ISI_CLIENT_DEFAULT_TIMEOUT,
+			g_isi_pep_connected, pipe, NULL) =3D=3D NULL)
+		return FALSE;
+
+	return TRUE;
+}
+
+static void g_isi_pep_enabled(const GIsiMessage *msg, void *data)
+{
+	struct isi_pep_resp *resp;
+	size_t len =3D sizeof(struct isi_pep_resp);
+	GIsiPipe *pipe =3D data;
+	GIsiClient *client =3D g_isi_pipe_client(pipe);
+	struct isi_pipe_enabled_ind ind =3D {
+		.cmd =3D PNS_PIPE_ENABLED_IND,
+		.pipe_handle =3D g_isi_pipe_get_handle(pipe),
+		.filler =3D 0x00,
+	};
+
+	if (g_isi_msg_error(msg) < 0) {
+		g_isi_pipe_set_error_timeout(pipe);
+		return;
+	}
+
+	if (g_isi_msg_id(msg) !=3D PNS_PEP_ENABLE_RESP)
+		return;
+
+	if (!g_isi_msg_data_get_struct(msg, 0, (const void **) &resp, len))
+		return;
+
+	if (g_isi_pipe_get_handle(pipe) !=3D resp->pipe_handle) {
+		g_isi_pipe_set_error_invalid_handle(pipe);
+		return;
+	}
+
+	g_isi_pipe_handle_error(pipe, resp->error_code);
+	if (g_isi_pipe_get_error(pipe))
+		return;
+
+	if (g_isi_request_sendto(g_isi_client_modem(client), msg->addr, &ind,
+			sizeof(ind), G_ISI_CLIENT_DEFAULT_TIMEOUT,
+			NULL, NULL, NULL) =3D=3D NULL) {
+			g_isi_pipe_set_error_general(pipe);
+			return;
+	}
+
+	if (g_isi_msg_device(msg) =3D=3D PN_DEV_MODEM) {
+		g_isi_pep_enable(pipe, PN_DEV_HOST);
+		return;
+	}
+	g_isi_pipe_set_enabling(pipe, FALSE);
+
+	if (!g_isi_pipe_get_error(pipe))
+		g_isi_pipe_set_enabled(pipe, TRUE);
+}
+
+void g_isi_pep_enable(GIsiPipe *pipe, uint8_t dev)
+{
+	GIsiClient *client =3D g_isi_pipe_client(pipe);
+	struct sockaddr_pn dst =3D {
+		.spn_family =3D AF_PHONET,
+	};
+	struct isi_pep_enable_req msg =3D {
+		.cmd =3D PNS_PEP_ENABLE_REQ,
+		.pipe_handle =3D g_isi_pipe_get_handle(pipe),
+		.filler =3D 0x00,
+	};
+
+	if (dev =3D=3D PN_DEV_HOST) {
+		dst.spn_dev =3D PN_DEV_HOST;
+		dst.spn_resource =3D PN_PIPE;
+		dst.spn_obj =3D g_isi_pipe_get_handle(pipe);
+	} else if (dev =3D=3D PN_DEV_MODEM) {
+		dst.spn_dev =3D PN_DEV_MODEM;
+		dst.spn_resource =3D g_isi_client_resource(client);
+		dst.spn_obj =3D PN_OBJ_PEP_GPRS;
+	} else
+		return;
+
+	if (g_isi_request_sendto(g_isi_client_modem(client), &dst, &msg,
+			sizeof(msg), G_ISI_CLIENT_DEFAULT_TIMEOUT,
+			g_isi_pep_enabled, pipe, NULL) =3D=3D NULL)
+		return;
+
+	return;
+}
+
+static void g_isi_pep_disconnected(const GIsiMessage *msg, void *data)
+{
+	struct isi_pep_resp *resp;
+	size_t len =3D sizeof(struct isi_pep_resp);
+	GIsiPipe *pipe =3D data;
+
+	if (g_isi_msg_error(msg) < 0) {
+		g_isi_pipe_set_error_timeout(pipe);
+		return;
+	}
+
+	if (g_isi_msg_id(msg) !=3D PNS_PEP_DISCONNECT_RESP)
+		return;
+
+	if (!g_isi_msg_data_get_struct(msg, 0, (const void **) &resp, len))
+		return;
+
+	if (resp->pipe_handle =3D=3D PN_PIPE_INVALID_HANDLE) {
+		g_isi_pipe_handle_error(pipe, resp->error_code);
+		return;
+	}
+
+	if (g_isi_pipe_get_handle(pipe) !=3D resp->pipe_handle) {
+		g_isi_pipe_set_error_invalid_handle(pipe);
+		return;
+	}
+
+	if (g_isi_msg_device(msg) =3D=3D PN_DEV_HOST) {
+		g_isi_pep_disconnect(pipe, PN_DEV_MODEM);
+		return;
+	}
+
+	g_isi_pipe_server_destroy(pipe);
+	g_isi_client_destroy(g_isi_pipe_client(pipe));
+	g_free(pipe);
+}
+
+
+void g_isi_pep_disconnect(GIsiPipe *pipe, uint8_t dev)
+{
+	GIsiClient *client =3D g_isi_pipe_client(pipe);
+	struct sockaddr_pn dst =3D {
+		.spn_family =3D AF_PHONET,
+	};
+	struct isi_pep_disconnect_req msg =3D {
+		.cmd =3D PNS_PEP_DISCONNECT_REQ,
+		.pipe_handle =3D g_isi_pipe_get_handle(pipe),
+		.filler =3D 0x00,
+	};
+
+	if (dev =3D=3D PN_DEV_HOST) {
+		dst.spn_dev =3D PN_DEV_HOST;
+		dst.spn_resource =3D PN_PIPE;
+		dst.spn_obj =3D g_isi_pipe_get_handle(pipe);
+	} else if (dev =3D=3D PN_DEV_MODEM) {
+		dst.spn_dev =3D PN_DEV_MODEM;
+		dst.spn_resource =3D g_isi_client_resource(client);
+		dst.spn_obj =3D PN_OBJ_PEP_GPRS;
+	} else
+		return;
+
+	if (g_isi_request_sendto(g_isi_client_modem(client), &dst, &msg,
+			sizeof(msg), G_ISI_CLIENT_DEFAULT_TIMEOUT,
+			g_isi_pep_disconnected, pipe, NULL) =3D=3D NULL)
+		return;
+
+	return;
+}
diff --git a/gisi/pep.h b/gisi/pep.h
index d46c8d0..1be5e10 100644
--- a/gisi/pep.h
+++ b/gisi/pep.h
@@ -23,6 +23,7 @@
 #define __GISI_PEP_H
 =

 #include "modem.h"
+#include "pipe.h"
 =

 #ifdef __cplusplus
 extern "C" {
@@ -37,6 +38,11 @@ uint16_t g_isi_pep_get_object(const GIsiPEP *pep);
 unsigned g_isi_pep_get_ifindex(const GIsiPEP *pep);
 char *g_isi_pep_get_ifname(const GIsiPEP *pep, char *ifname);
 =

+void g_isi_pep_enable(GIsiPipe *pipe, uint8_t dev);
+gboolean g_isi_pep_connect(GIsiPipe *pipe, uint8_t obj, uint8_t dev);
+void g_isi_pep_disconnect(GIsiPipe *pipe, uint8_t dev);
+
+
 #ifdef __cplusplus
 }
 #endif
diff --git a/gisi/pipe.c b/gisi/pipe.c
index 1bd5140..cf7d3c6 100644
--- a/gisi/pipe.c
+++ b/gisi/pipe.c
@@ -24,15 +24,23 @@
 #endif
 =

 #include <stdint.h>
+#include <sys/ioctl.h>
+#include <net/if.h>
+#include <fcntl.h>
+#include <unistd.h>
 #include <errno.h>
 #include <glib.h>
 =

 #include "client.h"
 #include "pipe.h"
+#include "pep.h"
+#include "common.h"
 =

 #define PN_PIPE			0xD9
 #define PN_PIPE_INVALID_HANDLE	0xFF
 =

+#define PN_OBJ_PEP_GPRS		0x30
+
 struct isi_pipe_create_req {
 	uint8_t cmd;
 	uint8_t state_after;
@@ -73,6 +81,8 @@ struct isi_pipe_resp {
 	uint8_t error2;
 };
 =

+
+
 enum isi_pipe_message_id {
 	PNS_PIPE_CREATE_REQ,
 	PNS_PIPE_CREATE_RESP,
@@ -86,6 +96,8 @@ enum isi_pipe_message_id {
 	PNS_PIPE_REDIRECT_RESP,
 	PNS_PIPE_DISABLE_REQ,
 	PNS_PIPE_DISABLE_RESP,
+	PNS_PIPE_CREATED_IND =3D		0x61,
+	PNS_PIPE_ENABLED_IND =3D		0x64,
 };
 =

 enum pn_pipe_error {	/* error codes */
@@ -103,6 +115,7 @@ enum pn_pipe_error {	/* error codes */
 	PN_PIPE_ERR_NOT_SUPPORTED,
 };
 =

+
 enum pn_pipe_state {	/* initial pipe state */
 	PN_PIPE_DISABLE,
 	PN_PIPE_ENABLE,
@@ -113,6 +126,14 @@ enum pn_msg_priority {
 	PN_MSG_PRIORITY_HIGH,
 };
 =

+
+
+struct _GIsiPipeServer {
+	int fd;
+	guint watch;
+};
+typedef struct _GIsiPipeServer GIsiPipeServer;
+
 struct _GIsiPipe {
 	GIsiClient *client;
 	GIsiPipeHandler handler;
@@ -122,8 +143,11 @@ struct _GIsiPipe {
 	uint8_t handle;
 	gboolean enabled;
 	gboolean enabling;
+	GIsiPipeServer *server;
 };
 =

+
+
 static int g_isi_pipe_error(enum pn_pipe_error code)
 {
 	switch (code) {
@@ -155,7 +179,7 @@ static int g_isi_pipe_error(enum pn_pipe_error code)
 	return -EBADMSG;
 }
 =

-static void g_isi_pipe_handle_error(GIsiPipe *pipe, uint8_t code)
+void g_isi_pipe_handle_error(GIsiPipe *pipe, uint8_t code)
 {
 	int err =3D g_isi_pipe_error(code);
 =

@@ -168,6 +192,61 @@ static void g_isi_pipe_handle_error(GIsiPipe *pipe, ui=
nt8_t code)
 		pipe->error_handler(pipe);
 }
 =

+
+GIsiClient *g_isi_pipe_client(GIsiPipe *pipe)
+{
+	return pipe !=3D NULL ? pipe->client : NULL;
+}
+
+
+void g_isi_pipe_set_handle(GIsiPipe *pipe, uint8_t handle)
+{
+	pipe->handle =3D handle;
+}
+
+static GIsiPipeServer *g_isi_pipe_server_create(GIsiModem *modem)
+{
+	GIsiPipeServer *server;
+	unsigned ifindex =3D g_isi_modem_index(modem);
+	struct sockaddr_pn addr =3D {
+		.spn_family =3D AF_PHONET,
+		.spn_resource =3D PN_PIPE,
+		.spn_obj =3D PN_OBJ_PEP_GPRS,
+	};
+	char buf[IF_NAMESIZE];
+	int fd =3D socket(PF_PHONET, SOCK_DGRAM, 0);
+
+	if (fd =3D=3D -1)
+		return NULL;
+
+	server =3D g_try_new0(GIsiPipeServer, 1);
+	if (server =3D=3D NULL)
+		goto error;
+
+	fcntl(fd, F_SETFD, FD_CLOEXEC);
+	/* Use blocking mode on purpose. */
+
+	if (ifindex =3D=3D 0)
+		g_warning("Unspecified modem interface index");
+	else if (if_indextoname(ifindex, buf) =3D=3D NULL ||
+		setsockopt(fd, SOL_SOCKET, SO_BINDTODEVICE, buf, IF_NAMESIZE))
+		goto error;
+
+	if (bind(fd, (void *)&addr, sizeof(addr)))
+		goto error;
+
+	server->fd =3D fd;
+	server->watch =3D g_isi_modem_add_to_watch(modem, fd);
+	if (!server->watch)
+		goto error;
+
+	return server;
+
+error:
+	close(fd);
+	return NULL;
+}
+
 static void g_isi_pipe_created(const GIsiMessage *msg, void *data)
 {
 	struct isi_pipe_resp *resp;
@@ -226,6 +305,7 @@ GIsiPipe *g_isi_pipe_create(GIsiModem *modem, GIsiPipeH=
andler cb, uint16_t obj1,
 	};
 	size_t len =3D sizeof(msg);
 	GIsiPipe *pipe;
+	gboolean legacy =3D g_isi_modem_flags(modem);
 =

 	pipe =3D g_try_new0(GIsiPipe, 1);
 	if (pipe =3D=3D NULL) {
@@ -247,16 +327,34 @@ GIsiPipe *g_isi_pipe_create(GIsiModem *modem, GIsiPip=
eHandler cb, uint16_t obj1,
 	pipe->enabled =3D FALSE;
 	pipe->handle =3D PN_PIPE_INVALID_HANDLE;
 =

-	if (g_isi_client_send(pipe->client, &msg, len,
-					g_isi_pipe_created, pipe, NULL))
-		return pipe;
+	if (legacy) {
+		if (!g_isi_client_send(pipe->client, &msg, len,
+			g_isi_pipe_created, pipe, NULL))
+			goto error;
+
+	} else {
+		pipe->server =3D g_isi_pipe_server_create(modem);
+		if (pipe->server =3D=3D NULL)
+			goto error;
+
+		if (!g_isi_pep_connect(pipe, obj1 & 0xFF, PN_DEV_HOST)) {
+					g_isi_pipe_server_destroy(pipe);
+		goto error;
+		}
+	}
 =

+	return pipe;
+
+
+error:
 	g_isi_client_destroy(pipe->client);
 	g_free(pipe);
 =

 	return NULL;
 }
 =

+
+
 static void g_isi_pipe_enabled(const GIsiMessage *msg, void *data)
 {
 	GIsiPipe *pipe =3D data;
@@ -287,14 +385,20 @@ static void g_isi_pipe_enabled(const GIsiMessage *msg=
, void *data)
 =

 static void g_isi_pipe_enable(GIsiPipe *pipe)
 {
+	GIsiModem *modem =3D g_isi_client_modem(pipe->client);
+	gboolean legacy =3D g_isi_modem_flags(modem);
 	struct isi_pipe_enable_req msg =3D {
 		.cmd =3D PNS_PIPE_ENABLE_REQ,
 		.pipe_handle =3D pipe->handle,
 	};
 	size_t len =3D sizeof(msg);
 =

-	g_isi_client_send(pipe->client, &msg, len,
-				g_isi_pipe_enabled, pipe, NULL);
+	if (legacy)
+		g_isi_client_send(pipe->client, &msg, len,
+					g_isi_pipe_enabled, pipe, NULL);
+	else
+		g_isi_pep_enable(pipe, PN_DEV_MODEM);
+
 }
 =

 /**
@@ -339,8 +443,8 @@ static void g_isi_pipe_removed(const GIsiMessage *msg, =
void *data)
 	if (pipe->handle !=3D resp->pipe_handle)
 		return;
 =

-	pipe->handle =3D PN_PIPE_INVALID_HANDLE;
-	pipe->error =3D -EPIPE;
+	g_isi_client_destroy(pipe->client);
+	g_free(pipe);
 }
 =

 =

@@ -356,17 +460,32 @@ static void g_isi_pipe_remove(GIsiPipe *pipe)
 				g_isi_pipe_removed, pipe, NULL);
 }
 =

+
 /**
  * Destroy a pipe. If it was connected, it is removed.
  * @param pipe pipe as returned from g_isi_pipe_create()
  */
 void g_isi_pipe_destroy(GIsiPipe *pipe)
 {
-	if (!pipe->error)
-		g_isi_pipe_remove(pipe);
+	GIsiModem *modem =3D g_isi_client_modem(pipe->client);
+	gboolean legacy =3D g_isi_modem_flags(modem);
+
+	if (!pipe->error) {
+		if (legacy)
+			g_isi_pipe_remove(pipe);
+		else
+			g_isi_pep_disconnect(pipe, PN_DEV_HOST);
+	}
 =

-	g_isi_client_destroy(pipe->client);
-	g_free(pipe);
+}
+
+
+void g_isi_pipe_server_destroy(GIsiPipe *pipe)
+{
+	if (pipe->server->watch > 0)
+		g_source_remove(pipe->server->watch);
+
+	g_free(pipe->server);
 }
 =

 void g_isi_pipe_set_error_handler(GIsiPipe *pipe, GIsiPipeErrorHandler cb)
@@ -403,3 +522,40 @@ uint8_t g_isi_pipe_get_handle(GIsiPipe *pipe)
 {
 	return pipe->handle;
 }
+
+void g_isi_pipe_start_handler(GIsiPipe *pipe)
+{
+	if (pipe->handler)
+		pipe->handler(pipe);
+}
+
+gboolean g_isi_pipe_get_enabling(GIsiPipe *pipe)
+{
+	return pipe->enabling;
+}
+
+void g_isi_pipe_set_enabling(GIsiPipe *pipe, gboolean value)
+{
+	pipe->enabling =3D value;
+}
+
+void g_isi_pipe_set_enabled(GIsiPipe *pipe, gboolean value)
+{
+	pipe->enabled =3D value;
+}
+
+void g_isi_pipe_set_error_general(GIsiPipe *pipe)
+{
+	g_isi_pipe_handle_error(pipe, PN_PIPE_ERR_GENERAL);
+
+}
+
+void g_isi_pipe_set_error_timeout(GIsiPipe *pipe)
+{
+	g_isi_pipe_handle_error(pipe, PN_PIPE_ERR_TIMEOUT);
+}
+
+void g_isi_pipe_set_error_invalid_handle(GIsiPipe *pipe)
+{
+	g_isi_pipe_handle_error(pipe, PN_PIPE_ERR_INVALID_HANDLE);
+}
\ No newline at end of file
diff --git a/gisi/pipe.h b/gisi/pipe.h
index 01265a9..4570821 100644
--- a/gisi/pipe.h
+++ b/gisi/pipe.h
@@ -26,24 +26,41 @@
 extern "C" {
 #endif
 =

+#include "client.h"
+
 struct _GIsiPipe;
 typedef struct _GIsiPipe GIsiPipe;
 =

+
 typedef void (*GIsiPipeHandler)(GIsiPipe *pipe);
 typedef void (*GIsiPipeErrorHandler)(GIsiPipe *pipe);
 =

 GIsiPipe *g_isi_pipe_create(GIsiModem *modem, GIsiPipeHandler cb, uint16_t=
 obj1,
 				uint16_t obj2, uint8_t type1, uint8_t type2);
 void g_isi_pipe_destroy(GIsiPipe *pipe);
+void g_isi_pipe_server_destroy(GIsiPipe *pipe);
 =

 void g_isi_pipe_set_error_handler(GIsiPipe *pipe, GIsiPipeErrorHandler cb);
 int g_isi_pipe_get_error(const GIsiPipe *pipe);
 void *g_isi_pipe_set_userdata(GIsiPipe *pipe, void *data);
 void *g_isi_pipe_get_userdata(GIsiPipe *pipe);
 uint8_t g_isi_pipe_get_handle(GIsiPipe *pipe);
+gboolean g_isi_pipe_get_enabling(GIsiPipe *pipe);
+void g_isi_pipe_set_enabling(GIsiPipe *pipe, gboolean value);
+void g_isi_pipe_set_enabled(GIsiPipe *pipe, gboolean value);
 =

 int g_isi_pipe_start(GIsiPipe *pipe);
 =

+GIsiClient *g_isi_pipe_client(GIsiPipe *pipe);
+void g_isi_pipe_set_handle(GIsiPipe *pipe, uint8_t handle);
+void g_isi_pipe_start_handler(GIsiPipe *pipe);
+
+void g_isi_pipe_handle_error(GIsiPipe *pipe, uint8_t code);
+void g_isi_pipe_set_error_general(GIsiPipe *pipe);
+void g_isi_pipe_set_error_timeout(GIsiPipe *pipe);
+void g_isi_pipe_set_error_invalid_handle(GIsiPipe *pipe);
+
+
 #ifdef __cplusplus
 }
 #endif
-- =

1.7.3.5


--===============8929912587374052051==--

