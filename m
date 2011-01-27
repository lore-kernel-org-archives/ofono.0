Content-Type: multipart/mixed; boundary="===============6705702432134508332=="
MIME-Version: 1.0
From: Jessica Nilsson <nilsson.r.j@gmail.com>
Subject: [PATCH 1/1] gisi: Updated subscriptions and pipe handling to
 accomodate additional isimodem versions
Date: Thu, 27 Jan 2011 13:37:14 +0000
Message-ID: <1296135411-17792-1-git-send-email-jessica.j.nilsson@stericsson.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6705702432134508332==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
This is needed in order for isimodem2.5 to work.

Best Regards,
Jessica

 gisi/common.h  |    3 +
 gisi/message.c |    8 +
 gisi/message.h |    1 +
 gisi/modem.c   |  105 ++++++++++++--
 gisi/modem.h   |    4 +
 gisi/pipe.c    |  433 ++++++++++++++++++++++++++++++++++++++++++++++++++++=
++--
 6 files changed, 531 insertions(+), 23 deletions(-)

diff --git a/gisi/common.h b/gisi/common.h
index 83a8cf5..c78f893 100644
--- a/gisi/common.h
+++ b/gisi/common.h
@@ -26,6 +26,8 @@
 extern "C" {
 #endif
 =

+#define PN_HOST					0x00
+#define PN_MODEM				0x60
 #define PN_COMMGR				0x10
 #define PN_NAMESERVICE				0xDB
 #define PN_FIREWALL				0x43
@@ -35,6 +37,7 @@ enum message_id {
 	PNS_NAME_ADD_REQ =3D			0x05,
 	PNS_NAME_REMOVE_REQ =3D			0x07,
 	PNS_SUBSCRIBED_RESOURCES_IND =3D		0x10,
+	PNS_SUBSCRIBED_RESOURCES_EXTEND_IND =3D	0x12,
 	COMM_ISI_VERSION_GET_REQ =3D		0x12,
 	COMM_ISI_VERSION_GET_RESP =3D		0x13,
 	COMM_ISA_ENTITY_NOT_REACHABLE_RESP =3D	0x14,
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
index 8750367..7201235 100644
--- a/gisi/modem.c
+++ b/gisi/modem.c
@@ -61,6 +61,7 @@ struct _GIsiModem {
 	unsigned index;
 	GHashTable *services;
 	gboolean subs_source;
+	GIsiVersion version;
 	int req_fd;
 	int ind_fd;
 	guint req_watch;
@@ -87,11 +88,6 @@ static const struct sockaddr_pn namesrv =3D {
 	.spn_resource =3D PN_NAMESERVICE,
 };
 =

-static const struct sockaddr_pn commgr =3D {
-	.spn_family =3D AF_PHONET,
-	.spn_resource =3D PN_COMMGR,
-};
-
 static GIsiServiceMux *service_get(GIsiModem *modem, uint8_t resource)
 {
 	GIsiServiceMux *mux;
@@ -349,11 +345,34 @@ static gboolean modem_subs_update(gpointer data)
 	gpointer keyptr, value;
 =

 	GIsiModem *modem =3D data;
-	uint8_t msg[3 + 256] =3D {
-		0, PNS_SUBSCRIBED_RESOURCES_IND,
-		0,
-	};
+	GIsiMessage dmsg;
+	uint8_t msg[3 + 256] =3D { 0 };
 	uint8_t count =3D 0;
+	int msg_size =3D 0;
+	struct sockaddr_pn commgr =3D {
+		.spn_family =3D AF_PHONET,
+		.spn_resource =3D PN_COMMGR,
+	};
+
+	if (g_isi_modem_version_major(modem) =3D=3D 2 &&
+		g_isi_modem_version_minor(modem) =3D=3D 5) {
+		uint8_t s_msg[4] =3D {
+			0, PNS_SUBSCRIBED_RESOURCES_EXTEND_IND,
+			0,
+			0, /* filler */
+		};
+		g_memmove(msg, s_msg, 4);
+		msg_size =3D 4;
+
+		commgr.spn_dev =3D PN_MODEM;
+	} else {
+		uint8_t s_msg[3] =3D {
+			0, PNS_SUBSCRIBED_RESOURCES_IND,
+			0,
+		};
+		g_memmove(msg, s_msg, 3);
+		msg_size =3D 3;
+	}
 =

 	modem->subs_source =3D 0;
 =

@@ -363,13 +382,31 @@ static gboolean modem_subs_update(gpointer data)
 		GIsiServiceMux *mux =3D value;
 =

 		if (mux->subscriptions > 0) {
-			msg[3 + count] =3D mux->resource;
+
 			count++;
+
+			if (g_isi_modem_version_major(modem) =3D=3D 2 &&
+				g_isi_modem_version_minor(modem) =3D=3D 5) {
+				msg[3 + (count * 4)] =3D mux->resource;
+				msg_size +=3D 4;
+			} else {
+				msg[2 + count] =3D mux->resource;
+				msg_size +=3D count;
+			}
+
 		}
 	}
 	msg[2] =3D count;
 =

-	sendto(modem->ind_fd, msg, 3 + msg[2], MSG_NOSIGNAL, (void *)&commgr,
+	dmsg.addr =3D &commgr;
+	dmsg.error =3D 0;
+	dmsg.data =3D msg;
+	dmsg.len =3D msg_size;
+
+	if (modem->trace !=3D NULL)
+		modem->trace(&dmsg, NULL);
+
+	sendto(modem->ind_fd, msg, msg_size, MSG_NOSIGNAL, (void *)&commgr,
 		sizeof(commgr));
 =

 	return FALSE;
@@ -499,6 +536,52 @@ GIsiModem *g_isi_modem_create_by_name(const char *name)
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
+gboolean g_isi_modem_set_version(GIsiModem *modem, const GIsiVersion versi=
on)
+{
+	if (modem =3D=3D NULL)
+		return FALSE;
+
+	modem->version =3D version;
+
+	return TRUE;
+}
+
+int g_isi_modem_version_major(const GIsiModem *modem)
+{
+	if (modem =3D=3D NULL)
+		return -1;
+
+	return modem->version.major;
+}
+
+int g_isi_modem_version_minor(const GIsiModem *modem)
+{
+	if (modem =3D=3D NULL)
+		return -1;
+
+	return modem->version.minor;
+}
+
 void *g_isi_modem_set_userdata(GIsiModem *modem, void *data)
 {
 	void *old =3D modem->opaque;
diff --git a/gisi/modem.h b/gisi/modem.h
index f0a1617..361164c 100644
--- a/gisi/modem.h
+++ b/gisi/modem.h
@@ -44,9 +44,13 @@ typedef void (*GIsiDebugFunc)(const char *fmt, ...);
 GIsiModem *g_isi_modem_create(unsigned index);
 GIsiModem *g_isi_modem_create_by_name(const char *name);
 void g_isi_modem_destroy(GIsiModem *modem);
+guint g_isi_modem_add_to_watch(GIsiModem *modem, int fd);
 unsigned g_isi_modem_index(GIsiModem *modem);
 void g_isi_modem_set_trace(GIsiModem *modem, GIsiNotifyFunc notify);
 void g_isi_modem_set_debug(GIsiModem *modem, GIsiDebugFunc debug);
+gboolean g_isi_modem_set_version(GIsiModem *modem, const GIsiVersion versi=
on);
+int g_isi_modem_version_major(const GIsiModem *modem);
+int g_isi_modem_version_minor(const GIsiModem *modem);
 void *g_isi_modem_set_userdata(GIsiModem *modem, void *data);
 void *g_isi_modem_get_userdata(GIsiModem *modem);
 =

diff --git a/gisi/pipe.c b/gisi/pipe.c
index 1bd5140..14d8b1c 100644
--- a/gisi/pipe.c
+++ b/gisi/pipe.c
@@ -24,15 +24,22 @@
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
+#include "common.h"
 =

 #define PN_PIPE			0xD9
 #define PN_PIPE_INVALID_HANDLE	0xFF
 =

+#define PN_OBJ_PEP_GPRS 0x30
+
 struct isi_pipe_create_req {
 	uint8_t cmd;
 	uint8_t state_after;
@@ -73,6 +80,53 @@ struct isi_pipe_resp {
 	uint8_t error2;
 };
 =

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
+struct isi_pep_resp {
+	uint8_t pipe_handle;
+	uint8_t error_code;
+};
+
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
+struct isi_pipe_enabled_ind{
+	uint8_t cmd;
+	uint8_t pipe_handle;
+	uint8_t filler;
+};
+
 enum isi_pipe_message_id {
 	PNS_PIPE_CREATE_REQ,
 	PNS_PIPE_CREATE_RESP,
@@ -86,6 +140,8 @@ enum isi_pipe_message_id {
 	PNS_PIPE_REDIRECT_RESP,
 	PNS_PIPE_DISABLE_REQ,
 	PNS_PIPE_DISABLE_RESP,
+	PNS_PIPE_CREATED_IND =3D		0x61,
+	PNS_PIPE_ENABLED_IND =3D		0x64
 };
 =

 enum pn_pipe_error {	/* error codes */
@@ -103,16 +159,47 @@ enum pn_pipe_error {	/* error codes */
 	PN_PIPE_ERR_NOT_SUPPORTED,
 };
 =

+enum isi_pep_type {
+	PN_PEP_TYPE_COMMON
+};
+
+enum isi_pep_message_id {
+	PNS_PEP_CONNECT_REQ =3D		0x40,
+	PNS_PEP_CONNECT_RESP =3D		0x41,
+	PNS_PEP_DISCONNECT_REQ =3D	0x42,
+	PNS_PEP_DISCONNECT_RESP =3D	0x43,
+	PNS_PEP_ENABLE_REQ =3D		0x46,
+	PNS_PEP_ENABLE_RESP =3D		0x47,
+};
+
+enum isi_pep_sb_id {
+	PN_PIPE_SB_NEGOTIATED_FC =3D	0x03,
+	PN_PIPE_SB_ALIGNED_DATA =3D	0x06,
+};
+
 enum pn_pipe_state {	/* initial pipe state */
 	PN_PIPE_DISABLE,
 	PN_PIPE_ENABLE,
 };
 =

 enum pn_msg_priority {
-	PN_MSG_PRIORITY_LOW =3D 1,
+	PN_MSG_PRIORITY_LOW =3D	1,
 	PN_MSG_PRIORITY_HIGH,
 };
 =

+enum pn_flow_control {
+	PN_NO_FLOW_CONTROL =3D		0x00,
+	PN_LEGACY_FLOW_CONTROL =3D	0x01,
+	PN_ONE_CREDIT_FLOW_CONTROL =3D	0x02,
+	PN_MULTI_CREDIT_FLOW_CONTROL =3D	0x03,
+};
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
@@ -122,8 +209,13 @@ struct _GIsiPipe {
 	uint8_t handle;
 	gboolean enabled;
 	gboolean enabling;
+	GIsiPipeServer *server;
 };
 =

+static gboolean g_isi_pep_connect(GIsiPipe *pipe, uint8_t obj, uint8_t dev=
);
+static void g_isi_pep_enable(GIsiPipe *pipe, uint8_t dev);
+static void g_isi_pep_disconnect(GIsiPipe *pipe, uint8_t dev);
+
 static int g_isi_pipe_error(enum pn_pipe_error code)
 {
 	switch (code) {
@@ -168,6 +260,147 @@ static void g_isi_pipe_handle_error(GIsiPipe *pipe, u=
int8_t code)
 		pipe->error_handler(pipe);
 }
 =

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
+static void g_isi_pipe_server_destroy(GIsiPipeServer *server)
+{
+
+	if (server->watch > 0)
+		g_source_remove(server->watch);
+
+	g_free(server);
+}
+
+static void g_isi_pep_connected(const GIsiMessage *msg, void *data)
+{
+	struct isi_pep_resp *resp;
+	size_t len =3D sizeof(struct isi_pipe_resp);
+	GIsiPipe *pipe =3D data;
+	GIsiClient *client =3D pipe->client;
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
+		g_isi_pipe_handle_error(pipe, PN_PIPE_ERR_TIMEOUT);
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
+	pipe->handle =3D resp->pipe_handle;
+	ind.pipe_handle =3D resp->pipe_handle;
+
+	if (g_isi_request_sendto(g_isi_client_modem(client), msg->addr, &ind,
+			sizeof(ind), G_ISI_CLIENT_DEFAULT_TIMEOUT,
+			NULL, NULL, NULL) =3D=3D NULL) {
+			g_isi_pipe_handle_error(pipe, PN_PIPE_ERR_GENERAL);
+			return;
+	}
+
+	if (g_isi_msg_device(msg) =3D=3D PN_HOST) {
+		g_isi_pep_connect(pipe, pipe->handle, PN_MODEM);
+		return;
+	}
+
+	if (pipe->enabling)
+		g_isi_pipe_start(pipe);
+
+	if (pipe->handler)
+		pipe->handler(pipe);
+}
+
+static gboolean g_isi_pep_connect(GIsiPipe *pipe, uint8_t obj, uint8_t dev)
+{
+	GIsiClient *client =3D pipe->client;
+	struct sockaddr_pn dst =3D {
+		.spn_family =3D AF_PHONET,
+	};
+	struct isi_pep_connect_req msg =3D {
+		.cmd =3D PNS_PEP_CONNECT_REQ,
+		.pipe_handle =3D obj,
+		.state_after =3D PN_PIPE_DISABLE,
+		.other_pep_type =3D PN_PEP_TYPE_COMMON,
+		.filler1 =3D 0x00,
+		.filler2 =3D 0x00,
+		.n_sb =3D 0x00,
+	};
+
+	if (dev =3D=3D PN_HOST) {
+		dst.spn_dev =3D PN_HOST;
+		dst.spn_resource =3D PN_PIPE;
+		dst.spn_obj =3D obj;
+	} else if (dev =3D=3D PN_MODEM) {
+		dst.spn_dev =3D PN_MODEM;
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
 static void g_isi_pipe_created(const GIsiMessage *msg, void *data)
 {
 	struct isi_pipe_resp *resp;
@@ -247,16 +480,115 @@ GIsiPipe *g_isi_pipe_create(GIsiModem *modem, GIsiPi=
peHandler cb, uint16_t obj1,
 	pipe->enabled =3D FALSE;
 	pipe->handle =3D PN_PIPE_INVALID_HANDLE;
 =

-	if (g_isi_client_send(pipe->client, &msg, len,
+	if (g_isi_modem_version_major(modem) =3D=3D 2 &&
+		g_isi_modem_version_minor(modem) =3D=3D 5) {
+
+		pipe->server =3D g_isi_pipe_server_create(modem);
+		if (pipe->server =3D=3D NULL)
+			goto error;
+
+		if (!g_isi_pep_connect(pipe, obj1 & 0xFF, PN_HOST)) {
+			g_isi_pipe_server_destroy(pipe->server);
+			goto error;
+		}
+	} else {
+
+		if (!g_isi_client_send(pipe->client, &msg, len,
 					g_isi_pipe_created, pipe, NULL))
-		return pipe;
+			goto error;
 =

+	}
+
+	return pipe;
+
+error:
 	g_isi_client_destroy(pipe->client);
 	g_free(pipe);
 =

 	return NULL;
 }
 =

+static void g_isi_pep_enabled(const GIsiMessage *msg, void *data)
+{
+	struct isi_pep_resp *resp;
+	size_t len =3D sizeof(struct isi_pep_resp);
+	GIsiPipe *pipe =3D data;
+	GIsiClient *client =3D pipe->client;
+	struct isi_pipe_enabled_ind ind =3D {
+		.cmd =3D PNS_PIPE_ENABLED_IND,
+		.pipe_handle =3D pipe->handle,
+		.filler =3D 0x00,
+	};
+
+	if (g_isi_msg_error(msg) < 0) {
+		g_isi_pipe_handle_error(pipe, PN_PIPE_ERR_TIMEOUT);
+		return;
+	}
+
+	if (g_isi_msg_id(msg) !=3D PNS_PEP_ENABLE_RESP)
+		return;
+
+	if (!g_isi_msg_data_get_struct(msg, 0, (const void **) &resp, len))
+		return;
+
+	if (pipe->handle !=3D resp->pipe_handle) {
+		g_isi_pipe_handle_error(pipe, PN_PIPE_ERR_INVALID_HANDLE);
+		return;
+	}
+
+	g_isi_pipe_handle_error(pipe, resp->error_code);
+	if (pipe->error)
+		return;
+
+	if (g_isi_request_sendto(g_isi_client_modem(client), msg->addr, &ind,
+			sizeof(ind), G_ISI_CLIENT_DEFAULT_TIMEOUT,
+			NULL, NULL, NULL) =3D=3D NULL) {
+			g_isi_pipe_handle_error(pipe, PN_PIPE_ERR_GENERAL);
+			return;
+	}
+
+	if (g_isi_msg_device(msg) =3D=3D PN_MODEM) {
+		g_isi_pep_enable(pipe, PN_HOST);
+		return;
+	}
+
+	pipe->enabling =3D FALSE;
+
+	if (!pipe->error)
+		pipe->enabled =3D TRUE;
+}
+
+static void g_isi_pep_enable(GIsiPipe *pipe, uint8_t dev)
+{
+	GIsiClient *client =3D pipe->client;
+	struct sockaddr_pn dst =3D {
+		.spn_family =3D AF_PHONET,
+	};
+	struct isi_pep_enable_req msg =3D {
+		.cmd =3D PNS_PEP_ENABLE_REQ,
+		.pipe_handle =3D pipe->handle,
+		.filler =3D 0x00,
+	};
+
+	if (dev =3D=3D PN_HOST) {
+		dst.spn_dev =3D PN_HOST;
+		dst.spn_resource =3D PN_PIPE;
+		dst.spn_obj =3D pipe->handle;
+	} else if (dev =3D=3D PN_MODEM) {
+		dst.spn_dev =3D PN_MODEM;
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
 static void g_isi_pipe_enabled(const GIsiMessage *msg, void *data)
 {
 	GIsiPipe *pipe =3D data;
@@ -287,14 +619,19 @@ static void g_isi_pipe_enabled(const GIsiMessage *msg=
, void *data)
 =

 static void g_isi_pipe_enable(GIsiPipe *pipe)
 {
+	GIsiModem *modem =3D g_isi_client_modem(pipe->client);
 	struct isi_pipe_enable_req msg =3D {
 		.cmd =3D PNS_PIPE_ENABLE_REQ,
 		.pipe_handle =3D pipe->handle,
 	};
 	size_t len =3D sizeof(msg);
 =

-	g_isi_client_send(pipe->client, &msg, len,
-				g_isi_pipe_enabled, pipe, NULL);
+	if (g_isi_modem_version_major(modem) =3D=3D 2 &&
+		g_isi_modem_version_minor(modem) =3D=3D 5)
+		g_isi_pep_enable(pipe, PN_MODEM);
+	else
+		g_isi_client_send(pipe->client, &msg, len,
+					g_isi_pipe_enabled, pipe, NULL);
 }
 =

 /**
@@ -339,8 +676,8 @@ static void g_isi_pipe_removed(const GIsiMessage *msg, =
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

@@ -356,17 +693,89 @@ static void g_isi_pipe_remove(GIsiPipe *pipe)
 				g_isi_pipe_removed, pipe, NULL);
 }
 =

+static void g_isi_pep_disconnected(const GIsiMessage *msg, void *data)
+{
+	struct isi_pep_resp *resp;
+	size_t len =3D sizeof(struct isi_pep_resp);
+	GIsiPipe *pipe =3D data;
+
+	if (g_isi_msg_error(msg) < 0) {
+		g_isi_pipe_handle_error(pipe, PN_PIPE_ERR_TIMEOUT);
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
+	if (pipe->handle !=3D resp->pipe_handle) {
+		g_isi_pipe_handle_error(pipe, PN_PIPE_ERR_INVALID_HANDLE);
+		return;
+	}
+
+	if (g_isi_msg_device(msg) =3D=3D PN_HOST) {
+		g_isi_pep_disconnect(pipe, PN_MODEM);
+		return;
+	}
+
+	g_isi_pipe_server_destroy(pipe->server);
+	g_isi_client_destroy(pipe->client);
+	g_free(pipe);
+}
+
+static void g_isi_pep_disconnect(GIsiPipe *pipe, uint8_t dev)
+{
+	GIsiClient *client =3D pipe->client;
+	struct sockaddr_pn dst =3D {
+		.spn_family =3D AF_PHONET,
+	};
+	struct isi_pep_disconnect_req msg =3D {
+		.cmd =3D PNS_PEP_DISCONNECT_REQ,
+		.pipe_handle =3D pipe->handle,
+		.filler =3D 0x00,
+	};
+
+	if (dev =3D=3D PN_HOST) {
+		dst.spn_dev =3D PN_HOST;
+		dst.spn_resource =3D PN_PIPE;
+		dst.spn_obj =3D pipe->handle;
+	} else if (dev =3D=3D PN_MODEM) {
+		dst.spn_dev =3D PN_MODEM;
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
+
 /**
  * Destroy a pipe. If it was connected, it is removed.
  * @param pipe pipe as returned from g_isi_pipe_create()
  */
 void g_isi_pipe_destroy(GIsiPipe *pipe)
 {
-	if (!pipe->error)
-		g_isi_pipe_remove(pipe);
-
-	g_isi_client_destroy(pipe->client);
-	g_free(pipe);
+	GIsiModem *modem =3D g_isi_client_modem(pipe->client);
+
+	if (!pipe->error) {
+		if (g_isi_modem_version_major(modem) =3D=3D 2 &&
+			g_isi_modem_version_minor(modem) =3D=3D 5)
+			g_isi_pep_disconnect(pipe, PN_HOST);
+		else
+			g_isi_pipe_remove(pipe);
+	}
 }
 =

 void g_isi_pipe_set_error_handler(GIsiPipe *pipe, GIsiPipeErrorHandler cb)
-- =

1.7.3.2


--===============6705702432134508332==--

