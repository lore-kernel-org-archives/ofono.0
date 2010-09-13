Content-Type: multipart/mixed; boundary="===============1604269313818082837=="
MIME-Version: 1.0
From: Zhenhua Zhang <zhenhua.zhang@intel.com>
Subject: [PATCH 2/6] bluetooth: Add Btio library for DUN
Date: Mon, 13 Sep 2010 13:21:50 +0800
Message-ID: <1284355314-16253-3-git-send-email-zhenhua.zhang@intel.com>
In-Reply-To: <1284355314-16253-1-git-send-email-zhenhua.zhang@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1604269313818082837==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Btio library is the low level socket API for BT RFCOMM connection. We
share the same library among BlueZ, Obex and oFono. So make sure you
synchronize to other two projects when you make changes to btio.[ch].
---
 Makefile.am  |    8 +-
 btio/btio.c  | 1299 ++++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++
 btio/btio.h  |   97 +++++
 configure.ac |    5 +
 4 files changed, 1407 insertions(+), 2 deletions(-)
 create mode 100644 btio/btio.c
 create mode 100644 btio/btio.h

diff --git a/Makefile.am b/Makefile.am
index 802e94b..d0be7b8 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -72,6 +72,8 @@ gatchat_sources =3D gatchat/gatchat.h gatchat/gatchat.c \
 				gatchat/ppp_auth.c gatchat/ppp_net.c \
 				gatchat/ppp_ipcp.c
 =

+btio_sources =3D btio/btio.h btio/btio.c
+
 udev_files =3D plugins/ofono.rules
 =

 if UDEV
@@ -286,7 +288,8 @@ src_ofonod_SOURCES =3D $(gdbus_sources) $(builtin_sourc=
es) \
 			src/nettime.c src/stkagent.c src/stkagent.h \
 			src/simfs.c src/simfs.h
 =

-src_ofonod_LDADD =3D $(builtin_libadd) @GLIB_LIBS@ @DBUS_LIBS@ @CAPNG_LIBS=
@ -ldl
+src_ofonod_LDADD =3D $(builtin_libadd) @GLIB_LIBS@ @DBUS_LIBS@ @CAPNG_LIBS=
@ \
+			@BLUEZ_LIBS@ -ldl
 =

 src_ofonod_LDFLAGS =3D -Wl,--export-dynamic -Wl,--version-script=3Dsrc/ofo=
no.ver
 =

@@ -308,7 +311,8 @@ AM_CFLAGS =3D @DBUS_CFLAGS@ @GLIB_CFLAGS@ @CAPNG_CFLAGS=
@ $(builtin_cflags) \
 					-DPLUGINDIR=3D\""$(build_plugindir)"\"
 =

 INCLUDES =3D -I$(builddir)/include -I$(builddir)/src -I$(srcdir)/src \
-			-I$(srcdir)/gdbus -I$(srcdir)/gisi -I$(srcdir)/gatchat
+			-I$(srcdir)/gdbus -I$(srcdir)/gisi -I$(srcdir)/gatchat \
+			-I$(srcdir)/btio
 =

 doc_files =3D doc/overview.txt doc/ofono-paper.txt \
 		doc/manager-api.txt doc/modem-api.txt doc/network-api.txt \
diff --git a/btio/btio.c b/btio/btio.c
new file mode 100644
index 0000000..8b273ca
--- /dev/null
+++ b/btio/btio.c
@@ -0,0 +1,1299 @@
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2009-2010  Marcel Holtmann <marcel@holtmann.org>
+ *  Copyright (C) 2009-2010  Nokia Corporation
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
+#include <bluetooth/bluetooth.h>
+#include <bluetooth/l2cap.h>
+#include <bluetooth/rfcomm.h>
+#include <bluetooth/sco.h>
+#include <bluetooth/hci.h>
+#include <bluetooth/hci_lib.h>
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
+	bdaddr_t dst;
+	int defer;
+	int sec_level;
+	uint8_t channel;
+	uint16_t psm;
+	uint16_t mtu;
+	uint16_t imtu;
+	uint16_t omtu;
+	int master;
+	uint8_t mode;
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
+static void server_remove(struct server *server)
+{
+	if (server->destroy)
+		server->destroy(server->user_data);
+	g_free(server);
+}
+
+static void connect_remove(struct connect *conn)
+{
+	if (conn->destroy)
+		conn->destroy(conn->user_data);
+	g_free(conn);
+}
+
+static void accept_remove(struct accept *accept)
+{
+	if (accept->destroy)
+		accept->destroy(accept->user_data);
+	g_free(accept);
+}
+
+static gboolean check_nval(GIOChannel *io)
+{
+	struct pollfd fds;
+
+	memset(&fds, 0, sizeof(fds));
+	fds.fd =3D g_io_channel_unix_get_fd(io);
+	fds.events =3D POLLNVAL;
+
+	if (poll(&fds, 1, 0) > 0 && (fds.revents & POLLNVAL))
+		return TRUE;
+
+	return FALSE;
+}
+
+static gboolean accept_cb(GIOChannel *io, GIOCondition cond,
+							gpointer user_data)
+{
+	struct accept *accept =3D user_data;
+	GError *err =3D NULL;
+
+	/* If the user aborted this accept attempt */
+	if ((cond & G_IO_NVAL) || check_nval(io))
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
+static gboolean connect_cb(GIOChannel *io, GIOCondition cond,
+							gpointer user_data)
+{
+	struct connect *conn =3D user_data;
+	GError *gerr =3D NULL;
+
+	/* If the user aborted this connect attempt */
+	if ((cond & G_IO_NVAL) || check_nval(io))
+		return FALSE;
+
+	if (cond & G_IO_OUT) {
+		int err =3D 0, sock =3D g_io_channel_unix_get_fd(io);
+		socklen_t len =3D sizeof(err);
+
+		if (getsockopt(sock, SOL_SOCKET, SO_ERROR, &err, &len) < 0)
+			err =3D errno;
+
+		if (err)
+			g_set_error(&gerr, BT_IO_ERROR,
+					BT_IO_ERROR_CONNECT_FAILED, "%s (%d)",
+					strerror(err), err);
+	} else if (cond & (G_IO_HUP | G_IO_ERR))
+		g_set_error(&gerr, BT_IO_ERROR, BT_IO_ERROR_CONNECT_FAILED,
+				"HUP or ERR on socket");
+
+	conn->connect(io, gerr, conn->user_data);
+
+	if (gerr)
+		g_error_free(gerr);
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
+	if ((cond & G_IO_NVAL) || check_nval(io))
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
+static void connect_add(GIOChannel *io, BtIOConnect connect,
+				gpointer user_data, GDestroyNotify destroy)
+{
+	struct connect *conn;
+	GIOCondition cond;
+
+	conn =3D g_new0(struct connect, 1);
+	conn->connect =3D connect;
+	conn->user_data =3D user_data;
+	conn->destroy =3D destroy;
+
+	cond =3D G_IO_OUT | G_IO_ERR | G_IO_HUP | G_IO_NVAL;
+	g_io_add_watch_full(io, G_PRIORITY_DEFAULT, cond, connect_cb, conn,
+					(GDestroyNotify) connect_remove);
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
+static int l2cap_bind(int sock, const bdaddr_t *src, uint16_t psm, GError =
**err)
+{
+	struct sockaddr_l2 addr;
+
+	memset(&addr, 0, sizeof(addr));
+	addr.l2_family =3D AF_BLUETOOTH;
+	bacpy(&addr.l2_bdaddr, src);
+	addr.l2_psm =3D htobs(psm);
+
+	if (bind(sock, (struct sockaddr *) &addr, sizeof(addr)) < 0) {
+		ERROR_FAILED(err, "l2cap_bind", errno);
+		return -1;
+	}
+
+	return 0;
+}
+
+static int l2cap_connect(int sock, const bdaddr_t *dst, uint16_t psm)
+{
+	int err;
+	struct sockaddr_l2 addr;
+
+	memset(&addr, 0, sizeof(addr));
+	addr.l2_family =3D AF_BLUETOOTH;
+	bacpy(&addr.l2_bdaddr, dst);
+	addr.l2_psm =3D htobs(psm);
+
+	err =3D connect(sock, (struct sockaddr *) &addr, sizeof(addr));
+	if (err < 0 && !(errno =3D=3D EAGAIN || errno =3D=3D EINPROGRESS))
+		return err;
+
+	return 0;
+}
+
+static int l2cap_set_master(int sock, int master)
+{
+	int flags;
+	socklen_t len;
+
+	len =3D sizeof(flags);
+	if (getsockopt(sock, SOL_L2CAP, L2CAP_LM, &flags, &len) < 0)
+		return -errno;
+
+	if (master) {
+		if (flags & L2CAP_LM_MASTER)
+			return 0;
+		flags |=3D L2CAP_LM_MASTER;
+	} else {
+		if (!(flags & L2CAP_LM_MASTER))
+			return 0;
+		flags &=3D ~L2CAP_LM_MASTER;
+	}
+
+	if (setsockopt(sock, SOL_L2CAP, L2CAP_LM, &flags, sizeof(flags)) < 0)
+		return -errno;
+
+	return 0;
+}
+
+static int rfcomm_set_master(int sock, int master)
+{
+	int flags;
+	socklen_t len;
+
+	len =3D sizeof(flags);
+	if (getsockopt(sock, SOL_RFCOMM, RFCOMM_LM, &flags, &len) < 0)
+		return -errno;
+
+	if (master) {
+		if (flags & RFCOMM_LM_MASTER)
+			return 0;
+		flags |=3D RFCOMM_LM_MASTER;
+	} else {
+		if (!(flags & RFCOMM_LM_MASTER))
+			return 0;
+		flags &=3D ~RFCOMM_LM_MASTER;
+	}
+
+	if (setsockopt(sock, SOL_RFCOMM, RFCOMM_LM, &flags, sizeof(flags)) < 0)
+		return -errno;
+
+	return 0;
+}
+
+static int l2cap_set_lm(int sock, int level)
+{
+	int lm_map[] =3D {
+		0,
+		L2CAP_LM_AUTH,
+		L2CAP_LM_AUTH | L2CAP_LM_ENCRYPT,
+		L2CAP_LM_AUTH | L2CAP_LM_ENCRYPT | L2CAP_LM_SECURE,
+	}, opt =3D lm_map[level];
+
+	if (setsockopt(sock, SOL_L2CAP, L2CAP_LM, &opt, sizeof(opt)) < 0)
+		return -errno;
+
+	return 0;
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
+	if (type =3D=3D BT_IO_L2CAP)
+		ret =3D l2cap_set_lm(sock, level);
+	else
+		ret =3D rfcomm_set_lm(sock, level);
+
+	if (ret < 0) {
+		ERROR_FAILED(err, "setsockopt(LM)", -ret);
+		return FALSE;
+	}
+
+	return TRUE;
+}
+
+static int l2cap_get_lm(int sock, int *sec_level)
+{
+	int opt;
+	socklen_t len;
+
+	len =3D sizeof(opt);
+	if (getsockopt(sock, SOL_L2CAP, L2CAP_LM, &opt, &len) < 0)
+		return -errno;
+
+	*sec_level =3D 0;
+
+	if (opt & L2CAP_LM_AUTH)
+		*sec_level =3D BT_SECURITY_LOW;
+	if (opt & L2CAP_LM_ENCRYPT)
+		*sec_level =3D BT_SECURITY_MEDIUM;
+	if (opt & L2CAP_LM_SECURE)
+		*sec_level =3D BT_SECURITY_HIGH;
+
+	return 0;
+}
+
+static int rfcomm_get_lm(int sock, int *sec_level)
+{
+	int opt;
+	socklen_t len;
+
+	len =3D sizeof(opt);
+	if (getsockopt(sock, SOL_RFCOMM, RFCOMM_LM, &opt, &len) < 0)
+		return -errno;
+
+	*sec_level =3D 0;
+
+	if (opt & RFCOMM_LM_AUTH)
+		*sec_level =3D BT_SECURITY_LOW;
+	if (opt & RFCOMM_LM_ENCRYPT)
+		*sec_level =3D BT_SECURITY_MEDIUM;
+	if (opt & RFCOMM_LM_SECURE)
+		*sec_level =3D BT_SECURITY_HIGH;
+
+	return 0;
+}
+
+static gboolean get_sec_level(int sock, BtIOType type, int *level,
+								GError **err)
+{
+	struct bt_security sec;
+	socklen_t len;
+	int ret;
+
+	memset(&sec, 0, sizeof(sec));
+	len =3D sizeof(sec);
+	if (getsockopt(sock, SOL_BLUETOOTH, BT_SECURITY, &sec, &len) =3D=3D 0) {
+		*level =3D sec.level;
+		return TRUE;
+	}
+
+	if (errno !=3D ENOPROTOOPT) {
+		ERROR_FAILED(err, "getsockopt(BT_SECURITY)", errno);
+		return FALSE;
+	}
+
+	if (type =3D=3D BT_IO_L2CAP)
+		ret =3D l2cap_get_lm(sock, level);
+	else
+		ret =3D rfcomm_get_lm(sock, level);
+
+	if (ret < 0) {
+		ERROR_FAILED(err, "getsockopt(LM)", -ret);
+		return FALSE;
+	}
+
+	return TRUE;
+}
+
+static gboolean l2cap_set(int sock, int sec_level, uint16_t imtu, uint16_t=
 omtu,
+					uint8_t mode, int master, GError **err)
+{
+	if (imtu || omtu || mode) {
+		struct l2cap_options l2o;
+		socklen_t len;
+
+		memset(&l2o, 0, sizeof(l2o));
+		len =3D sizeof(l2o);
+		if (getsockopt(sock, SOL_L2CAP, L2CAP_OPTIONS, &l2o,
+								&len) < 0) {
+			ERROR_FAILED(err, "getsockopt(L2CAP_OPTIONS)", errno);
+			return FALSE;
+		}
+
+		if (imtu)
+			l2o.imtu =3D imtu;
+		if (omtu)
+			l2o.omtu =3D omtu;
+		if (mode)
+			l2o.mode =3D mode;
+
+		if (setsockopt(sock, SOL_L2CAP, L2CAP_OPTIONS, &l2o,
+							sizeof(l2o)) < 0) {
+			ERROR_FAILED(err, "setsockopt(L2CAP_OPTIONS)", errno);
+			return FALSE;
+		}
+	}
+
+	if (master >=3D 0 && l2cap_set_master(sock, master) < 0) {
+		ERROR_FAILED(err, "l2cap_set_master", errno);
+		return FALSE;
+	}
+
+	if (sec_level && !set_sec_level(sock, BT_IO_L2CAP, sec_level, err))
+		return FALSE;
+
+	return TRUE;
+}
+
+static int rfcomm_bind(int sock,
+		const bdaddr_t *src, uint8_t channel, GError **err)
+{
+	struct sockaddr_rc addr;
+
+	memset(&addr, 0, sizeof(addr));
+	addr.rc_family =3D AF_BLUETOOTH;
+	bacpy(&addr.rc_bdaddr, src);
+	addr.rc_channel =3D channel;
+
+	if (bind(sock, (struct sockaddr *) &addr, sizeof(addr)) < 0) {
+		ERROR_FAILED(err, "rfcomm_bind", errno);
+		return -1;
+	}
+
+	return 0;
+}
+
+static int rfcomm_connect(int sock, const bdaddr_t *dst, uint8_t channel)
+{
+	int err;
+	struct sockaddr_rc addr;
+
+	memset(&addr, 0, sizeof(addr));
+	addr.rc_family =3D AF_BLUETOOTH;
+	bacpy(&addr.rc_bdaddr, dst);
+	addr.rc_channel =3D channel;
+
+	err =3D connect(sock, (struct sockaddr *) &addr, sizeof(addr));
+	if (err < 0 && !(errno =3D=3D EAGAIN || errno =3D=3D EINPROGRESS))
+		return err;
+
+	return 0;
+}
+
+static gboolean rfcomm_set(int sock, int sec_level, int master, GError **e=
rr)
+{
+	if (sec_level && !set_sec_level(sock, BT_IO_RFCOMM, sec_level, err))
+		return FALSE;
+
+	if (master >=3D 0 && rfcomm_set_master(sock, master) < 0) {
+		ERROR_FAILED(err, "rfcomm_set_master", errno);
+		return FALSE;
+	}
+
+	return TRUE;
+}
+
+static int sco_bind(int sock, const bdaddr_t *src, GError **err)
+{
+	struct sockaddr_sco addr;
+
+	memset(&addr, 0, sizeof(addr));
+	addr.sco_family =3D AF_BLUETOOTH;
+	bacpy(&addr.sco_bdaddr, src);
+
+	if (bind(sock, (struct sockaddr *) &addr, sizeof(addr)) < 0) {
+		ERROR_FAILED(err, "sco_bind", errno);
+		return -1;
+	}
+
+	return 0;
+}
+
+static int sco_connect(int sock, const bdaddr_t *dst)
+{
+	struct sockaddr_sco addr;
+	int err;
+
+	memset(&addr, 0, sizeof(addr));
+	addr.sco_family =3D AF_BLUETOOTH;
+	bacpy(&addr.sco_bdaddr, dst);
+
+	err =3D connect(sock, (struct sockaddr *) &addr, sizeof(addr));
+	if (err < 0 && !(errno =3D=3D EAGAIN || errno =3D=3D EINPROGRESS))
+		return err;
+
+	return 0;
+}
+
+static gboolean sco_set(int sock, uint16_t mtu, GError **err)
+{
+	struct sco_options sco_opt;
+	socklen_t len;
+
+	if (!mtu)
+		return TRUE;
+
+	len =3D sizeof(sco_opt);
+	memset(&sco_opt, 0, len);
+	if (getsockopt(sock, SOL_SCO, SCO_OPTIONS, &sco_opt, &len) < 0) {
+		ERROR_FAILED(err, "getsockopt(SCO_OPTIONS)", errno);
+		return FALSE;
+	}
+
+	sco_opt.mtu =3D mtu;
+	if (setsockopt(sock, SOL_SCO, SCO_OPTIONS, &sco_opt,
+						sizeof(sco_opt)) < 0) {
+		ERROR_FAILED(err, "setsockopt(SCO_OPTIONS)", errno);
+		return FALSE;
+	}
+
+	return TRUE;
+}
+
+static gboolean parse_set_opts(struct set_opts *opts, GError **err,
+						BtIOOption opt1, va_list args)
+{
+	BtIOOption opt =3D opt1;
+	const char *str;
+
+	memset(opts, 0, sizeof(*opts));
+
+	/* Set defaults */
+	opts->defer =3D DEFAULT_DEFER_TIMEOUT;
+	opts->master =3D -1;
+	opts->sec_level =3D BT_IO_SEC_MEDIUM;
+	opts->mode =3D L2CAP_MODE_BASIC;
+
+	while (opt !=3D BT_IO_OPT_INVALID) {
+		switch (opt) {
+		case BT_IO_OPT_SOURCE:
+			str =3D va_arg(args, const char *);
+			if (strncasecmp(str, "hci", 3) =3D=3D 0)
+				hci_devba(atoi(str + 3), &opts->src);
+			else
+				str2ba(str, &opts->src);
+			break;
+		case BT_IO_OPT_SOURCE_BDADDR:
+			bacpy(&opts->src, va_arg(args, const bdaddr_t *));
+			break;
+		case BT_IO_OPT_DEST:
+			str2ba(va_arg(args, const char *), &opts->dst);
+			break;
+		case BT_IO_OPT_DEST_BDADDR:
+			bacpy(&opts->dst, va_arg(args, const bdaddr_t *));
+			break;
+		case BT_IO_OPT_DEFER_TIMEOUT:
+			opts->defer =3D va_arg(args, int);
+			break;
+		case BT_IO_OPT_SEC_LEVEL:
+			opts->sec_level =3D va_arg(args, int);
+			break;
+		case BT_IO_OPT_CHANNEL:
+			opts->channel =3D va_arg(args, int);
+			break;
+		case BT_IO_OPT_PSM:
+			opts->psm =3D va_arg(args, int);
+			break;
+		case BT_IO_OPT_MTU:
+			opts->mtu =3D va_arg(args, int);
+			opts->imtu =3D opts->mtu;
+			opts->omtu =3D opts->mtu;
+			break;
+		case BT_IO_OPT_OMTU:
+			opts->omtu =3D va_arg(args, int);
+			if (!opts->mtu)
+				opts->mtu =3D opts->omtu;
+			break;
+		case BT_IO_OPT_IMTU:
+			opts->imtu =3D va_arg(args, int);
+			if (!opts->mtu)
+				opts->mtu =3D opts->imtu;
+			break;
+		case BT_IO_OPT_MASTER:
+			opts->master =3D va_arg(args, gboolean);
+			break;
+		case BT_IO_OPT_MODE:
+			opts->mode =3D va_arg(args, int);
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
+static int l2cap_get_info(int sock, uint16_t *handle, uint8_t *dev_class)
+{
+	struct l2cap_conninfo info;
+	socklen_t len;
+
+	len =3D sizeof(info);
+	if (getsockopt(sock, SOL_L2CAP, L2CAP_CONNINFO, &info, &len) < 0)
+		return -errno;
+
+	if (handle)
+		*handle =3D info.hci_handle;
+
+	if (dev_class)
+		memcpy(dev_class, info.dev_class, 3);
+
+	return 0;
+}
+
+static gboolean l2cap_get(int sock, GError **err, BtIOOption opt1,
+								va_list args)
+{
+	BtIOOption opt =3D opt1;
+	struct sockaddr_l2 src, dst;
+	struct l2cap_options l2o;
+	int flags;
+	uint8_t dev_class[3];
+	uint16_t handle;
+	socklen_t len;
+
+	len =3D sizeof(l2o);
+	memset(&l2o, 0, len);
+	if (getsockopt(sock, SOL_L2CAP, L2CAP_OPTIONS, &l2o, &len) < 0) {
+		ERROR_FAILED(err, "getsockopt(L2CAP_OPTIONS)", errno);
+		return FALSE;
+	}
+
+	if (!get_peers(sock, (struct sockaddr *) &src,
+				(struct sockaddr *) &dst, sizeof(src), err))
+		return FALSE;
+
+	while (opt !=3D BT_IO_OPT_INVALID) {
+		switch (opt) {
+		case BT_IO_OPT_SOURCE:
+			ba2str(&src.l2_bdaddr, va_arg(args, char *));
+			break;
+		case BT_IO_OPT_SOURCE_BDADDR:
+			bacpy(va_arg(args, bdaddr_t *), &src.l2_bdaddr);
+			break;
+		case BT_IO_OPT_DEST:
+			ba2str(&dst.l2_bdaddr, va_arg(args, char *));
+			break;
+		case BT_IO_OPT_DEST_BDADDR:
+			bacpy(va_arg(args, bdaddr_t *), &dst.l2_bdaddr);
+			break;
+		case BT_IO_OPT_DEFER_TIMEOUT:
+			len =3D sizeof(int);
+			if (getsockopt(sock, SOL_BLUETOOTH, BT_DEFER_SETUP,
+					va_arg(args, int *), &len) < 0) {
+				ERROR_FAILED(err, "getsockopt(DEFER_SETUP)",
+									errno);
+				return FALSE;
+			}
+			break;
+		case BT_IO_OPT_SEC_LEVEL:
+			if (!get_sec_level(sock, BT_IO_L2CAP,
+						va_arg(args, int *), err))
+				return FALSE;
+			break;
+		case BT_IO_OPT_PSM:
+			*(va_arg(args, uint16_t *)) =3D src.l2_psm ?
+						src.l2_psm : dst.l2_psm;
+			break;
+		case BT_IO_OPT_OMTU:
+			*(va_arg(args, uint16_t *)) =3D l2o.omtu;
+			break;
+		case BT_IO_OPT_IMTU:
+			*(va_arg(args, uint16_t *)) =3D l2o.imtu;
+			break;
+		case BT_IO_OPT_MASTER:
+			len =3D sizeof(flags);
+			if (getsockopt(sock, SOL_L2CAP, L2CAP_LM, &flags,
+								&len) < 0) {
+				ERROR_FAILED(err, "getsockopt(L2CAP_LM)",
+									errno);
+				return FALSE;
+			}
+			*(va_arg(args, gboolean *)) =3D
+				(flags & L2CAP_LM_MASTER) ? TRUE : FALSE;
+			break;
+		case BT_IO_OPT_HANDLE:
+			if (l2cap_get_info(sock, &handle, dev_class) < 0) {
+				ERROR_FAILED(err, "L2CAP_CONNINFO", errno);
+				return FALSE;
+			}
+			*(va_arg(args, uint16_t *)) =3D handle;
+			break;
+		case BT_IO_OPT_CLASS:
+			if (l2cap_get_info(sock, &handle, dev_class) < 0) {
+				ERROR_FAILED(err, "L2CAP_CONNINFO", errno);
+				return FALSE;
+			}
+			memcpy(va_arg(args, uint8_t *), dev_class, 3);
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
+static int rfcomm_get_info(int sock, uint16_t *handle, uint8_t *dev_class)
+{
+	struct rfcomm_conninfo info;
+	socklen_t len;
+
+	len =3D sizeof(info);
+	if (getsockopt(sock, SOL_RFCOMM, RFCOMM_CONNINFO, &info, &len) < 0)
+		return -errno;
+
+	if (handle)
+		*handle =3D info.hci_handle;
+
+	if (dev_class)
+		memcpy(dev_class, info.dev_class, 3);
+
+	return 0;
+}
+
+static gboolean rfcomm_get(int sock, GError **err, BtIOOption opt1,
+								va_list args)
+{
+	BtIOOption opt =3D opt1;
+	struct sockaddr_rc src, dst;
+	int flags;
+	socklen_t len;
+	uint8_t dev_class[3];
+	uint16_t handle;
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
+		case BT_IO_OPT_SOURCE_BDADDR:
+			bacpy(va_arg(args, bdaddr_t *), &src.rc_bdaddr);
+			break;
+		case BT_IO_OPT_DEST:
+			ba2str(&dst.rc_bdaddr, va_arg(args, char *));
+			break;
+		case BT_IO_OPT_DEST_BDADDR:
+			bacpy(va_arg(args, bdaddr_t *), &dst.rc_bdaddr);
+			break;
+		case BT_IO_OPT_DEFER_TIMEOUT:
+			len =3D sizeof(int);
+			if (getsockopt(sock, SOL_BLUETOOTH, BT_DEFER_SETUP,
+					va_arg(args, int *), &len) < 0) {
+				ERROR_FAILED(err, "getsockopt(DEFER_SETUP)",
+									errno);
+				return FALSE;
+			}
+			break;
+		case BT_IO_OPT_SEC_LEVEL:
+			if (!get_sec_level(sock, BT_IO_RFCOMM,
+						va_arg(args, int *), err))
+				return FALSE;
+			break;
+		case BT_IO_OPT_CHANNEL:
+			*(va_arg(args, uint8_t *)) =3D src.rc_channel ?
+					src.rc_channel : dst.rc_channel;
+			break;
+		case BT_IO_OPT_SOURCE_CHANNEL:
+			*(va_arg(args, uint8_t *)) =3D src.rc_channel;
+			break;
+		case BT_IO_OPT_DEST_CHANNEL:
+			*(va_arg(args, uint8_t *)) =3D dst.rc_channel;
+			break;
+		case BT_IO_OPT_MASTER:
+			len =3D sizeof(flags);
+			if (getsockopt(sock, SOL_RFCOMM, RFCOMM_LM, &flags,
+								&len) < 0) {
+				ERROR_FAILED(err, "getsockopt(RFCOMM_LM)",
+									errno);
+				return FALSE;
+			}
+			*(va_arg(args, gboolean *)) =3D
+				(flags & RFCOMM_LM_MASTER) ? TRUE : FALSE;
+			break;
+		case BT_IO_OPT_HANDLE:
+			if (rfcomm_get_info(sock, &handle, dev_class) < 0) {
+				ERROR_FAILED(err, "RFCOMM_CONNINFO", errno);
+				return FALSE;
+			}
+			*(va_arg(args, uint16_t *)) =3D handle;
+			break;
+		case BT_IO_OPT_CLASS:
+			if (rfcomm_get_info(sock, &handle, dev_class) < 0) {
+				ERROR_FAILED(err, "RFCOMM_CONNINFO", errno);
+				return FALSE;
+			}
+			memcpy(va_arg(args, uint8_t *), dev_class, 3);
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
+static int sco_get_info(int sock, uint16_t *handle, uint8_t *dev_class)
+{
+	struct sco_conninfo info;
+	socklen_t len;
+
+	len =3D sizeof(info);
+	if (getsockopt(sock, SOL_SCO, SCO_CONNINFO, &info, &len) < 0)
+		return -errno;
+
+	if (handle)
+		*handle =3D info.hci_handle;
+
+	if (dev_class)
+		memcpy(dev_class, info.dev_class, 3);
+
+	return 0;
+}
+
+static gboolean sco_get(int sock, GError **err, BtIOOption opt1, va_list a=
rgs)
+{
+	BtIOOption opt =3D opt1;
+	struct sockaddr_sco src, dst;
+	struct sco_options sco_opt;
+	socklen_t len;
+	uint8_t dev_class[3];
+	uint16_t handle;
+
+	len =3D sizeof(sco_opt);
+	memset(&sco_opt, 0, len);
+	if (getsockopt(sock, SOL_SCO, SCO_OPTIONS, &sco_opt, &len) < 0) {
+		ERROR_FAILED(err, "getsockopt(SCO_OPTIONS)", errno);
+		return FALSE;
+	}
+
+	if (!get_peers(sock, (struct sockaddr *) &src,
+				(struct sockaddr *) &dst, sizeof(src), err))
+		return FALSE;
+
+	while (opt !=3D BT_IO_OPT_INVALID) {
+		switch (opt) {
+		case BT_IO_OPT_SOURCE:
+			ba2str(&src.sco_bdaddr, va_arg(args, char *));
+			break;
+		case BT_IO_OPT_SOURCE_BDADDR:
+			bacpy(va_arg(args, bdaddr_t *), &src.sco_bdaddr);
+			break;
+		case BT_IO_OPT_DEST:
+			ba2str(&dst.sco_bdaddr, va_arg(args, char *));
+			break;
+		case BT_IO_OPT_DEST_BDADDR:
+			bacpy(va_arg(args, bdaddr_t *), &dst.sco_bdaddr);
+			break;
+		case BT_IO_OPT_MTU:
+		case BT_IO_OPT_IMTU:
+		case BT_IO_OPT_OMTU:
+			*(va_arg(args, uint16_t *)) =3D sco_opt.mtu;
+			break;
+		case BT_IO_OPT_HANDLE:
+			if (sco_get_info(sock, &handle, dev_class) < 0) {
+				ERROR_FAILED(err, "RFCOMM_CONNINFO", errno);
+				return FALSE;
+			}
+			*(va_arg(args, uint16_t *)) =3D handle;
+			break;
+		case BT_IO_OPT_CLASS:
+			if (sco_get_info(sock, &handle, dev_class) < 0) {
+				ERROR_FAILED(err, "RFCOMM_CONNINFO", errno);
+				return FALSE;
+			}
+			memcpy(va_arg(args, uint8_t *), dev_class, 3);
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
+	int sock;
+
+	sock =3D g_io_channel_unix_get_fd(io);
+
+	switch (type) {
+	case BT_IO_L2RAW:
+	case BT_IO_L2CAP:
+		return l2cap_get(sock, err, opt1, args);
+	case BT_IO_RFCOMM:
+		return rfcomm_get(sock, err, opt1, args);
+	case BT_IO_SCO:
+		return sco_get(sock, err, opt1, args);
+	}
+
+	g_set_error(err, BT_IO_ERROR, BT_IO_ERROR_INVALID_ARGS,
+			"Unknown BtIO type %d", type);
+	return FALSE;
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
+gboolean bt_io_set(GIOChannel *io, BtIOType type, GError **err,
+							BtIOOption opt1, ...)
+{
+	va_list args;
+	gboolean ret;
+	struct set_opts opts;
+	int sock;
+
+	va_start(args, opt1);
+	ret =3D parse_set_opts(&opts, err, opt1, args);
+	va_end(args);
+
+	if (!ret)
+		return ret;
+
+	sock =3D g_io_channel_unix_get_fd(io);
+
+	switch (type) {
+	case BT_IO_L2RAW:
+	case BT_IO_L2CAP:
+		return l2cap_set(sock, opts.sec_level, opts.imtu, opts.omtu,
+						opts.mode, opts.master, err);
+	case BT_IO_RFCOMM:
+		return rfcomm_set(sock, opts.sec_level, opts.master, err);
+	case BT_IO_SCO:
+		return sco_set(sock, opts.mtu, err);
+	}
+
+	g_set_error(err, BT_IO_ERROR, BT_IO_ERROR_INVALID_ARGS,
+			"Unknown BtIO type %d", type);
+	return FALSE;
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
+	switch (type) {
+	case BT_IO_L2RAW:
+		sock =3D socket(PF_BLUETOOTH, SOCK_RAW, BTPROTO_L2CAP);
+		if (sock < 0) {
+			ERROR_FAILED(err, "socket(RAW, L2CAP)", errno);
+			return NULL;
+		}
+		if (l2cap_bind(sock, &opts->src,
+					server ? opts->psm : 0, err) < 0)
+			goto failed;
+		if (!l2cap_set(sock, opts->sec_level, 0, 0, 0, -1, err))
+			goto failed;
+		break;
+	case BT_IO_L2CAP:
+		sock =3D socket(PF_BLUETOOTH, SOCK_SEQPACKET, BTPROTO_L2CAP);
+		if (sock < 0) {
+			ERROR_FAILED(err, "socket(SEQPACKET, L2CAP)", errno);
+			return NULL;
+		}
+		if (l2cap_bind(sock, &opts->src,
+					server ? opts->psm : 0, err) < 0)
+			goto failed;
+		if (!l2cap_set(sock, opts->sec_level, opts->imtu, opts->omtu,
+						opts->mode, opts->master, err))
+			goto failed;
+		break;
+	case BT_IO_RFCOMM:
+		sock =3D socket(PF_BLUETOOTH, SOCK_STREAM, BTPROTO_RFCOMM);
+		if (sock < 0) {
+			ERROR_FAILED(err, "socket(STREAM, RFCOMM)", errno);
+			return NULL;
+		}
+		if (rfcomm_bind(sock, &opts->src,
+					server ? opts->channel : 0, err) < 0)
+			goto failed;
+		if (!rfcomm_set(sock, opts->sec_level, opts->master, err))
+			goto failed;
+		break;
+	case BT_IO_SCO:
+		sock =3D socket(PF_BLUETOOTH, SOCK_SEQPACKET, BTPROTO_SCO);
+		if (sock < 0) {
+			ERROR_FAILED(err, "socket(SEQPACKET, SCO)", errno);
+			return NULL;
+		}
+		if (sco_bind(sock, &opts->src, err) < 0)
+			goto failed;
+		if (!sco_set(sock, opts->mtu, err))
+			goto failed;
+		break;
+	default:
+		g_set_error(err, BT_IO_ERROR, BT_IO_ERROR_INVALID_ARGS,
+				"Unknown BtIO type %d", type);
+		return NULL;
+	}
+
+	io =3D g_io_channel_unix_new(sock);
+
+	g_io_channel_set_close_on_unref(io, TRUE);
+	g_io_channel_set_flags(io, G_IO_FLAG_NONBLOCK, NULL);
+
+	return io;
+
+failed:
+	close(sock);
+
+	return NULL;
+}
+
+GIOChannel *bt_io_connect(BtIOType type, BtIOConnect connect,
+				gpointer user_data, GDestroyNotify destroy,
+				GError **gerr, BtIOOption opt1, ...)
+{
+	GIOChannel *io;
+	va_list args;
+	struct set_opts opts;
+	int err, sock;
+	gboolean ret;
+
+	va_start(args, opt1);
+	ret =3D parse_set_opts(&opts, gerr, opt1, args);
+	va_end(args);
+
+	if (ret =3D=3D FALSE)
+		return NULL;
+
+	io =3D create_io(type, FALSE, &opts, gerr);
+	if (io =3D=3D NULL)
+		return NULL;
+
+	sock =3D g_io_channel_unix_get_fd(io);
+
+	switch (type) {
+	case BT_IO_L2RAW:
+		err =3D l2cap_connect(sock, &opts.dst, 0);
+		break;
+	case BT_IO_L2CAP:
+		err =3D l2cap_connect(sock, &opts.dst, opts.psm);
+		break;
+	case BT_IO_RFCOMM:
+		err =3D rfcomm_connect(sock, &opts.dst, opts.channel);
+		break;
+	case BT_IO_SCO:
+		err =3D sco_connect(sock, &opts.dst);
+		break;
+	default:
+		g_set_error(gerr, BT_IO_ERROR, BT_IO_ERROR_INVALID_ARGS,
+						"Unknown BtIO type %d", type);
+		return NULL;
+	}
+
+	if (err < 0) {
+		g_set_error(gerr, BT_IO_ERROR, BT_IO_ERROR_CONNECT_FAILED,
+				"connect: %s (%d)", strerror(-err), -err);
+		g_io_channel_unref(io);
+		return NULL;
+	}
+
+	connect_add(io, connect, user_data, destroy);
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
+	if (type =3D=3D BT_IO_L2RAW) {
+		g_set_error(err, BT_IO_ERROR, BT_IO_ERROR_INVALID_ARGS,
+				"Server L2CAP RAW sockets not supported");
+		return NULL;
+	}
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
diff --git a/btio/btio.h b/btio/btio.h
new file mode 100644
index 0000000..d373ed1
--- /dev/null
+++ b/btio/btio.h
@@ -0,0 +1,97 @@
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2009-2010  Marcel Holtmann <marcel@holtmann.org>
+ *  Copyright (C) 2009-2010  Nokia Corporation
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
+#ifndef BT_IO_H
+#define BT_IO_H
+
+#include <glib.h>
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
+	BT_IO_L2RAW,
+	BT_IO_L2CAP,
+	BT_IO_RFCOMM,
+	BT_IO_SCO,
+} BtIOType;
+
+typedef enum {
+	BT_IO_OPT_INVALID =3D 0,
+	BT_IO_OPT_SOURCE,
+	BT_IO_OPT_SOURCE_BDADDR,
+	BT_IO_OPT_DEST,
+	BT_IO_OPT_DEST_BDADDR,
+	BT_IO_OPT_DEFER_TIMEOUT,
+	BT_IO_OPT_SEC_LEVEL,
+	BT_IO_OPT_CHANNEL,
+	BT_IO_OPT_SOURCE_CHANNEL,
+	BT_IO_OPT_DEST_CHANNEL,
+	BT_IO_OPT_PSM,
+	BT_IO_OPT_MTU,
+	BT_IO_OPT_OMTU,
+	BT_IO_OPT_IMTU,
+	BT_IO_OPT_MASTER,
+	BT_IO_OPT_HANDLE,
+	BT_IO_OPT_CLASS,
+	BT_IO_OPT_MODE,
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
+gboolean bt_io_set(GIOChannel *io, BtIOType type, GError **err,
+						BtIOOption opt1, ...);
+
+gboolean bt_io_get(GIOChannel *io, BtIOType type, GError **err,
+						BtIOOption opt1, ...);
+
+GIOChannel *bt_io_connect(BtIOType type, BtIOConnect connect,
+				gpointer user_data, GDestroyNotify destroy,
+				GError **err, BtIOOption opt1, ...);
+
+GIOChannel *bt_io_listen(BtIOType type, BtIOConnect connect,
+				BtIOConfirm confirm, gpointer user_data,
+				GDestroyNotify destroy, GError **err,
+				BtIOOption opt1, ...);
+
+#endif
diff --git a/configure.ac b/configure.ac
index bd1dacb..4acd9c8 100644
--- a/configure.ac
+++ b/configure.ac
@@ -105,6 +105,11 @@ else
 fi
 AC_SUBST(DBUS_DATADIR)
 =

+PKG_CHECK_MODULES(BLUEZ, bluez, dummy=3Dyes,
+				AC_MSG_ERROR(libbluetooth is required))
+AC_SUBST(BLUEZ_CFLAGS)
+AC_SUBST(BLUEZ_LIBS)
+
 AC_ARG_ENABLE(udev, AC_HELP_STRING([--disable-udev],
 			[don't use udev support even if available]),
 						[enable_udev=3D${enableval}])
-- =

1.7.0.4


--===============1604269313818082837==--

