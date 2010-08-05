Content-Type: multipart/mixed; boundary="===============3496583156999655729=="
MIME-Version: 1.0
From: Zhenhua Zhang <zhenhua.zhang@intel.com>
Subject: [PATCH 2/6] bluetooth: Add Btio library for DUN
Date: Thu, 05 Aug 2010 09:51:28 +0800
Message-ID: <1280973092-3966-2-git-send-email-zhenhua.zhang@intel.com>
In-Reply-To: <1280973092-3966-1-git-send-email-zhenhua.zhang@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3496583156999655729==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Btio library is the low level socket API for BT RFCOMM connection.
---
 plugins/btio.c |  479 ++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++
 plugins/btio.h |  118 ++++++++++++++
 2 files changed, 597 insertions(+), 0 deletions(-)
 create mode 100644 plugins/btio.c
 create mode 100644 plugins/btio.h

diff --git a/plugins/btio.c b/plugins/btio.c
new file mode 100644
index 0000000..6156027
--- /dev/null
+++ b/plugins/btio.c
@@ -0,0 +1,479 @@
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2009  Marcel Holtmann <marcel@holtmann.org>
+ *  Copyright (C) 2009  Nokia Corporation
+ *  Copyright (C) 2010  Intel Corporation. All rights reserved.
+ *
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301 =
 USA
+ *
+ */
+#include <stdarg.h>
+#include <stdlib.h>
+#include <unistd.h>
+#include <errno.h>
+#include <poll.h>
+#include <sys/types.h>
+#include <sys/socket.h>
+
+#include <glib.h>
+
+#include "btio.h"
+
+#define ERROR_FAILED(gerr, str, err) \
+		g_set_error(gerr, BT_IO_ERROR, BT_IO_ERROR_FAILED, \
+				str ": %s (%d)", strerror(err), err)
+
+#define DEFAULT_DEFER_TIMEOUT 30
+
+struct set_opts {
+	bdaddr_t src;
+	int defer;
+	int sec_level;
+	uint8_t channel;
+	int master;
+};
+
+struct connect {
+	BtIOConnect connect;
+	gpointer user_data;
+	GDestroyNotify destroy;
+};
+
+struct accept {
+	BtIOConnect connect;
+	gpointer user_data;
+	GDestroyNotify destroy;
+};
+
+struct server {
+	BtIOConnect connect;
+	BtIOConfirm confirm;
+	gpointer user_data;
+	GDestroyNotify destroy;
+};
+
+static inline void bacpy(bdaddr_t *dst, const bdaddr_t *src)
+{
+	memcpy(dst, src, sizeof(bdaddr_t));
+}
+
+static void baswap(bdaddr_t *dst, const bdaddr_t *src)
+{
+	register unsigned char *d =3D (unsigned char *) dst;
+	register const unsigned char *s =3D (const unsigned char *) src;
+	register int i;
+
+	for (i =3D 0; i < 6; i++)
+		d[i] =3D s[5-i];
+}
+
+static int ba2str(const bdaddr_t *ba, char *str)
+{
+	uint8_t b[6];
+
+	baswap((bdaddr_t *) b, ba);
+	return sprintf(str, "%2.2X:%2.2X:%2.2X:%2.2X:%2.2X:%2.2X",
+		b[0], b[1], b[2], b[3], b[4], b[5]);
+}
+
+static void server_remove(struct server *server)
+{
+	if (server->destroy)
+		server->destroy(server->user_data);
+	g_free(server);
+}
+
+static void accept_remove(struct accept *accept)
+{
+	if (accept->destroy)
+		accept->destroy(accept->user_data);
+	g_free(accept);
+}
+
+static gboolean accept_cb(GIOChannel *io, GIOCondition cond,
+							gpointer user_data)
+{
+	struct accept *accept =3D user_data;
+	GError *err =3D NULL;
+
+	/* If the user aborted this accept attempt */
+	if (cond & G_IO_NVAL)
+		return FALSE;
+
+	if (cond & (G_IO_HUP | G_IO_ERR))
+		g_set_error(&err, BT_IO_ERROR, BT_IO_ERROR_DISCONNECTED,
+				"HUP or ERR on socket");
+
+	accept->connect(io, err, accept->user_data);
+
+	g_clear_error(&err);
+
+	return FALSE;
+}
+
+static gboolean server_cb(GIOChannel *io, GIOCondition cond,
+							gpointer user_data)
+{
+	struct server *server =3D user_data;
+	int srv_sock, cli_sock;
+	GIOChannel *cli_io;
+
+	/* If the user closed the server */
+	if (cond & G_IO_NVAL)
+		return FALSE;
+
+	srv_sock =3D g_io_channel_unix_get_fd(io);
+
+	cli_sock =3D accept(srv_sock, NULL, NULL);
+	if (cli_sock < 0)
+		return TRUE;
+
+	cli_io =3D g_io_channel_unix_new(cli_sock);
+
+	g_io_channel_set_close_on_unref(cli_io, TRUE);
+	g_io_channel_set_flags(cli_io, G_IO_FLAG_NONBLOCK, NULL);
+
+	if (server->confirm)
+		server->confirm(cli_io, server->user_data);
+	else
+		server->connect(cli_io, NULL, server->user_data);
+
+	g_io_channel_unref(cli_io);
+
+	return TRUE;
+}
+
+static void server_add(GIOChannel *io, BtIOConnect connect,
+				BtIOConfirm confirm, gpointer user_data,
+				GDestroyNotify destroy)
+{
+	struct server *server;
+	GIOCondition cond;
+
+	server =3D g_new0(struct server, 1);
+	server->connect =3D connect;
+	server->confirm =3D confirm;
+	server->user_data =3D user_data;
+	server->destroy =3D destroy;
+
+	cond =3D G_IO_IN | G_IO_ERR | G_IO_HUP | G_IO_NVAL;
+	g_io_add_watch_full(io, G_PRIORITY_DEFAULT, cond, server_cb, server,
+					(GDestroyNotify) server_remove);
+}
+
+static void accept_add(GIOChannel *io, BtIOConnect connect, gpointer user_=
data,
+							GDestroyNotify destroy)
+{
+	struct accept *accept;
+	GIOCondition cond;
+
+	accept =3D g_new0(struct accept, 1);
+	accept->connect =3D connect;
+	accept->user_data =3D user_data;
+	accept->destroy =3D destroy;
+
+	cond =3D G_IO_OUT | G_IO_ERR | G_IO_HUP | G_IO_NVAL;
+	g_io_add_watch_full(io, G_PRIORITY_DEFAULT, cond, accept_cb, accept,
+					(GDestroyNotify) accept_remove);
+}
+
+static int rfcomm_set_lm(int sock, int level)
+{
+	int lm_map[] =3D {
+		0,
+		RFCOMM_LM_AUTH,
+		RFCOMM_LM_AUTH | RFCOMM_LM_ENCRYPT,
+		RFCOMM_LM_AUTH | RFCOMM_LM_ENCRYPT | RFCOMM_LM_SECURE,
+	}, opt =3D lm_map[level];
+
+	if (setsockopt(sock, SOL_RFCOMM, RFCOMM_LM, &opt, sizeof(opt)) < 0)
+		return -errno;
+
+	return 0;
+}
+
+static gboolean set_sec_level(int sock, BtIOType type, int level, GError *=
*err)
+{
+	struct bt_security sec;
+	int ret;
+
+	if (level < BT_SECURITY_LOW || level > BT_SECURITY_HIGH) {
+		g_set_error(err, BT_IO_ERROR, BT_IO_ERROR_INVALID_ARGS,
+				"Valid security level range is %d-%d",
+				BT_SECURITY_LOW, BT_SECURITY_HIGH);
+		return FALSE;
+	}
+
+	memset(&sec, 0, sizeof(sec));
+	sec.level =3D level;
+
+	if (setsockopt(sock, SOL_BLUETOOTH, BT_SECURITY, &sec,
+							sizeof(sec)) =3D=3D 0)
+		return TRUE;
+
+	if (errno !=3D ENOPROTOOPT) {
+		ERROR_FAILED(err, "setsockopt(BT_SECURITY)", errno);
+		return FALSE;
+	}
+
+	ret =3D rfcomm_set_lm(sock, level);
+	if (ret < 0) {
+		ERROR_FAILED(err, "setsockopt(LM)", -ret);
+		return FALSE;
+	}
+
+	return TRUE;
+}
+
+static int rfcomm_bind(int sock, const bdaddr_t *src, uint8_t channel)
+{
+	struct sockaddr_rc addr;
+
+	memset(&addr, 0, sizeof(addr));
+	addr.rc_family =3D AF_BLUETOOTH;
+	bacpy(&addr.rc_bdaddr, src);
+	addr.rc_channel =3D channel;
+
+	return bind(sock, (struct sockaddr *) &addr, sizeof(addr));
+}
+
+static gboolean rfcomm_set(int sock, int sec_level, int master, GError **e=
rr)
+{
+	if (sec_level && !set_sec_level(sock, BT_IO_RFCOMM, sec_level, err))
+		return FALSE;
+
+	return TRUE;
+}
+
+static gboolean parse_set_opts(struct set_opts *opts, GError **err,
+						BtIOOption opt1, va_list args)
+{
+	BtIOOption opt =3D opt1;
+
+	memset(opts, 0, sizeof(*opts));
+
+	/* Set defaults */
+	opts->defer =3D DEFAULT_DEFER_TIMEOUT;
+	opts->master =3D -1;
+
+	while (opt !=3D BT_IO_OPT_INVALID) {
+		switch (opt) {
+		case BT_IO_OPT_CHANNEL:
+			opts->channel =3D va_arg(args, int);
+			break;
+		case BT_IO_OPT_SEC_LEVEL:
+			opts->sec_level =3D va_arg(args, int);
+			break;
+		default:
+			g_set_error(err, BT_IO_ERROR, BT_IO_ERROR_INVALID_ARGS,
+					"Unknown option %d", opt);
+			return FALSE;
+		}
+
+		opt =3D va_arg(args, int);
+	}
+
+	return TRUE;
+}
+
+static gboolean get_peers(int sock, struct sockaddr *src, struct sockaddr =
*dst,
+				socklen_t len, GError **err)
+{
+	socklen_t olen;
+
+	memset(src, 0, len);
+	olen =3D len;
+	if (getsockname(sock, src, &olen) < 0) {
+		ERROR_FAILED(err, "getsockname", errno);
+		return FALSE;
+	}
+
+	memset(dst, 0, len);
+	olen =3D len;
+	if (getpeername(sock, dst, &olen) < 0) {
+		ERROR_FAILED(err, "getpeername", errno);
+		return FALSE;
+	}
+
+	return TRUE;
+}
+
+static gboolean rfcomm_get(int sock, GError **err, BtIOOption opt1,
+								va_list args)
+{
+	BtIOOption opt =3D opt1;
+	struct sockaddr_rc src, dst;
+
+	if (!get_peers(sock, (struct sockaddr *) &src,
+				(struct sockaddr *) &dst, sizeof(src), err))
+		return FALSE;
+
+	while (opt !=3D BT_IO_OPT_INVALID) {
+		switch (opt) {
+		case BT_IO_OPT_SOURCE:
+			ba2str(&src.rc_bdaddr, va_arg(args, char *));
+			break;
+		case BT_IO_OPT_DEST:
+			ba2str(&dst.rc_bdaddr, va_arg(args, char *));
+			break;
+		case BT_IO_OPT_CHANNEL:
+			*(va_arg(args, uint8_t *)) =3D src.rc_channel ?
+					src.rc_channel : dst.rc_channel;
+			break;
+		default:
+			g_set_error(err, BT_IO_ERROR, BT_IO_ERROR_INVALID_ARGS,
+					"Unknown option %d", opt);
+			return FALSE;
+		}
+
+		opt =3D va_arg(args, int);
+	}
+
+	return TRUE;
+}
+
+static gboolean get_valist(GIOChannel *io, BtIOType type, GError **err,
+						BtIOOption opt1, va_list args)
+{
+	int sock =3D g_io_channel_unix_get_fd(io);
+
+	if (type !=3D BT_IO_RFCOMM) {
+		g_set_error(err, BT_IO_ERROR, BT_IO_ERROR_INVALID_ARGS,
+				"Unknown BtIO type %d", type);
+		return FALSE;
+	}
+
+	return rfcomm_get(sock, err, opt1, args);
+}
+
+gboolean bt_io_accept(GIOChannel *io, BtIOConnect connect, gpointer user_d=
ata,
+					GDestroyNotify destroy, GError **err)
+{
+	int sock;
+	char c;
+	struct pollfd pfd;
+
+	sock =3D g_io_channel_unix_get_fd(io);
+
+	memset(&pfd, 0, sizeof(pfd));
+	pfd.fd =3D sock;
+	pfd.events =3D POLLOUT;
+
+	if (poll(&pfd, 1, 0) < 0) {
+		ERROR_FAILED(err, "poll", errno);
+		return FALSE;
+	}
+
+	if (!(pfd.revents & POLLOUT)) {
+		int ret;
+		ret =3D read(sock, &c, 1);
+	}
+
+	accept_add(io, connect, user_data, destroy);
+
+	return TRUE;
+}
+
+gboolean bt_io_get(GIOChannel *io, BtIOType type, GError **err,
+							BtIOOption opt1, ...)
+{
+	va_list args;
+	gboolean ret;
+
+	va_start(args, opt1);
+	ret =3D get_valist(io, type, err, opt1, args);
+	va_end(args);
+
+	return ret;
+}
+
+static GIOChannel *create_io(BtIOType type, gboolean server,
+					struct set_opts *opts, GError **err)
+{
+	int sock;
+	GIOChannel *io;
+
+	if (type !=3D BT_IO_RFCOMM)
+		return NULL;
+
+	sock =3D socket(PF_BLUETOOTH, SOCK_STREAM, BTPROTO_RFCOMM);
+	if (sock < 0) {
+		ERROR_FAILED(err, "socket(STREAM, RFCOMM)", errno);
+		return NULL;
+	}
+
+	if (rfcomm_bind(sock, &opts->src,
+				server ? opts->channel : 0) < 0) {
+		ERROR_FAILED(err, "rfcomm_bind", errno);
+		return NULL;
+	}
+
+	if (!rfcomm_set(sock, opts->sec_level, opts->master, err))
+		return NULL;
+
+	io =3D g_io_channel_unix_new(sock);
+
+	g_io_channel_set_close_on_unref(io, TRUE);
+	g_io_channel_set_flags(io, G_IO_FLAG_NONBLOCK, NULL);
+
+	return io;
+}
+
+GIOChannel *bt_io_listen(BtIOType type, BtIOConnect connect,
+				BtIOConfirm confirm, gpointer user_data,
+				GDestroyNotify destroy, GError **err,
+				BtIOOption opt1, ...)
+{
+	GIOChannel *io;
+	va_list args;
+	struct set_opts opts;
+	int sock;
+	gboolean ret;
+
+	va_start(args, opt1);
+	ret =3D parse_set_opts(&opts, err, opt1, args);
+	va_end(args);
+
+	if (ret =3D=3D FALSE)
+		return NULL;
+
+	io =3D create_io(type, TRUE, &opts, err);
+	if (io =3D=3D NULL)
+		return NULL;
+
+	sock =3D g_io_channel_unix_get_fd(io);
+
+	if (confirm)
+		setsockopt(sock, SOL_BLUETOOTH, BT_DEFER_SETUP, &opts.defer,
+							sizeof(opts.defer));
+
+	if (listen(sock, 5) < 0) {
+		ERROR_FAILED(err, "listen", errno);
+		g_io_channel_unref(io);
+		return NULL;
+	}
+
+	server_add(io, connect, confirm, user_data, destroy);
+
+	return io;
+}
+
+GQuark bt_io_error_quark(void)
+{
+	return g_quark_from_static_string("bt-io-error-quark");
+}
diff --git a/plugins/btio.h b/plugins/btio.h
new file mode 100644
index 0000000..78d5961
--- /dev/null
+++ b/plugins/btio.h
@@ -0,0 +1,118 @@
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2009  Marcel Holtmann <marcel@holtmann.org>
+ *  Copyright (C) 2009  Nokia Corporation
+ *  Copyright (C) 2010  Intel Corporation. All rights reserved.
+ *
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301 =
 USA
+ *
+ */
+
+#include <glib.h>
+
+#include <stdio.h>
+#include <stdint.h>
+#include <string.h>
+#include <endian.h>
+#include <byteswap.h>
+
+#ifndef AF_BLUETOOTH
+#define AF_BLUETOOTH	31
+#define PF_BLUETOOTH	AF_BLUETOOTH
+#endif
+
+#define BTPROTO_RFCOMM		3
+#define SOL_RFCOMM		18
+#define SOL_BLUETOOTH		274
+
+struct bt_security {
+	uint8_t level;
+};
+#define BT_SECURITY_SDP		0
+#define BT_SECURITY_LOW		1
+#define BT_SECURITY_MEDIUM	2
+#define BT_SECURITY_HIGH	3
+#define BT_SECURITY		4
+
+#define BT_DEFER_SETUP		7
+
+/* BD Address */
+typedef struct {
+	uint8_t b[6];
+} __attribute__((packed)) bdaddr_t;
+
+#define RFCOMM_LM       	0x03
+#define RFCOMM_LM_AUTH		0x0002
+#define RFCOMM_LM_ENCRYPT	0x0004
+#define RFCOMM_LM_TRUSTED	0x0008
+#define RFCOMM_LM_RELIABLE	0x0010
+#define RFCOMM_LM_SECURE	0x0020
+
+#include <sys/socket.h>
+
+/* RFCOMM socket address */
+struct sockaddr_rc {
+	sa_family_t	rc_family;
+	bdaddr_t	rc_bdaddr;
+	uint8_t		rc_channel;
+};
+
+typedef enum {
+	BT_IO_ERROR_DISCONNECTED,
+	BT_IO_ERROR_CONNECT_FAILED,
+	BT_IO_ERROR_FAILED,
+	BT_IO_ERROR_INVALID_ARGS,
+} BtIOError;
+
+#define BT_IO_ERROR bt_io_error_quark()
+
+GQuark bt_io_error_quark(void);
+
+typedef enum {
+	BT_IO_RFCOMM,
+} BtIOType;
+
+typedef enum {
+	BT_IO_OPT_INVALID =3D 0,
+	BT_IO_OPT_SOURCE,
+	BT_IO_OPT_DEST,
+	BT_IO_OPT_SEC_LEVEL,
+	BT_IO_OPT_CHANNEL,
+} BtIOOption;
+
+typedef enum {
+	BT_IO_SEC_SDP =3D 0,
+	BT_IO_SEC_LOW,
+	BT_IO_SEC_MEDIUM,
+	BT_IO_SEC_HIGH,
+} BtIOSecLevel;
+
+typedef void (*BtIOConfirm)(GIOChannel *io, gpointer user_data);
+
+typedef void (*BtIOConnect)(GIOChannel *io, GError *err, gpointer user_dat=
a);
+
+gboolean bt_io_accept(GIOChannel *io, BtIOConnect connect, gpointer user_d=
ata,
+					GDestroyNotify destroy, GError **err);
+
+gboolean bt_io_get(GIOChannel *io, BtIOType type, GError **err,
+					BtIOOption opt1, ...);
+
+GIOChannel *bt_io_listen(BtIOType type, BtIOConnect connect,
+					BtIOConfirm confirm, gpointer user_data,
+					GDestroyNotify destroy, GError **err,
+					BtIOOption opt1, ...);
-- =

1.7.0.4


--===============3496583156999655729==--

