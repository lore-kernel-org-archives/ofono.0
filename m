Content-Type: multipart/mixed; boundary="===============3747787438277750114=="
MIME-Version: 1.0
From: Zhenhua Zhang <zhenhua.zhang@intel.com>
Subject: [PATCH 2/4] Add GAtServer basic parsing support
Date: Mon, 11 Jan 2010 18:53:48 +0800
Message-ID: <1263207230-22036-2-git-send-email-zhenhua.zhang@intel.com>
In-Reply-To: <1263207230-22036-1-git-send-email-zhenhua.zhang@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3747787438277750114==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

It's the basic skeleton of GAtServer, including new/shutdown, ref/
unref, received_data/parse_buffer and set_discuss/set_debug.

GAtServer is to emulate the server side of AT conversation. It
complies with V.250 and 27.007 spec to accept AT command like
ATV1, ATE0 and extended command like AT+CLCC. Upper layer could
create customize server to expose TTY, tcp or unix socket to client
side application.
---
 Makefile.am         |    3 +-
 gatchat/gatserver.c |  428 +++++++++++++++++++++++++++++++++++++++++++++++=
++++
 gatchat/gatserver.h |   65 ++++++++
 3 files changed, 495 insertions(+), 1 deletions(-)
 create mode 100644 gatchat/gatserver.c
 create mode 100644 gatchat/gatserver.h

diff --git a/Makefile.am b/Makefile.am
index 67882b9..50dabca 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -52,7 +52,8 @@ gatchat_sources =3D gatchat/gatchat.h gatchat/gatchat.c \
 				gatchat/gatmux.h gatchat/gatmux.c \
 				gatchat/gsm0710.h gatchat/gsm0710.c \
 				gatchat/gattty.h gatchat/gattty.c \
-				gatchat/gatutil.h gatchat/gatutil.c
+				gatchat/gatutil.h gatchat/gatutil.c \
+				gatchat/gatserver.h gatchat/gatserver.c
 =

 udev_files =3D plugins/ofono.rules
 =

diff --git a/gatchat/gatserver.c b/gatchat/gatserver.c
new file mode 100644
index 0000000..e861e25
--- /dev/null
+++ b/gatchat/gatserver.c
@@ -0,0 +1,428 @@
+/*
+ *
+ *  AT server library with GLib integration
+ *
+ *  Copyright (C) 2008-2010  Intel Corporation. All rights reserved.
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License version 2 as
+ *  published by the Free Software Foundation.
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
+#ifdef HAVE_CONFIG_H
+#include <config.h>
+#endif
+
+#include <stdio.h>
+#include <unistd.h>
+#include <string.h>
+
+#include <glib.h>
+
+#include "ringbuffer.h"
+#include "gatresult.h"
+#include "gatserver.h"
+
+#define DBG(fmt, arg...) g_print("%s:%s() " fmt, __FILE__, __FUNCTION__ , =
## arg)
+
+struct result_codes {
+	const char *v1;
+	unsigned int v0;
+};
+
+/* V.250 Table 1/V.250 Result codes */
+static struct result_codes at_server_result_codes[] =3D {
+	{ "OK",			0, },
+	{ "CONNECT",		1, },
+	{ "RING",		2, },
+	{ "NO CARRIER",		3, },
+	{ "ERROR",		4, },
+	{ "NO DIALTONE",	5, },
+	{ "BUSY",		6, },
+	{ "NO ANSWER",		7, },
+	{ "CONNECT",		8, },
+	{ NULL },
+};
+
+/* Basic command setting for V.250 */
+struct v250_settings {
+	char s3;			/* set by S3=3D<val> */
+	char s4;			/* set by S4=3D<val> */
+	char s5;			/* set by S5=3D<val> */
+	gboolean echo;			/* set by E<val> */
+	gboolean quiet;			/* set by Q<val> */
+	gboolean is_v1;			/* set by V<val>, v0 or v1 */
+	unsigned int res_format;	/* set by X<val> */
+	unsigned int c109;		/* set by &C<val> */
+	unsigned int c108;		/* set by &D<val> */
+};
+
+struct _GAtServer {
+	gint ref_count;				/* Ref count */
+	struct v250_settings *v250;		/* V.250 command setting */
+	GIOChannel *server_io;			/* Server IO */
+	int server_watch;			/* Watch for server IO */
+	char *modem_path;			/* Emulated modem path */
+	GAtDisconnectFunc user_disconnect;	/* User disconnect func */
+	gpointer user_disconnect_data;		/* User disconnect data */
+	GAtDebugFunc debugf;			/* Debugging output function */
+	gpointer debug_data;			/* Data to pass to debug func */
+	struct ring_buffer *buf;		/* Current read buffer */
+};
+
+static int at_server_parse(GAtServer *server, char *buf);
+
+static void g_at_server_send_result_code(GAtServer *server, int error)
+{
+	struct v250_settings *v250 =3D server->v250;
+	char buf[1024];
+	char text[1024];
+	char t =3D v250->s3;
+	char r =3D v250->s4;
+	struct result_codes c;
+	gsize wbuf;
+
+	memset(buf, 0, sizeof(buf));
+	memset(text, 0, sizeof(text));
+
+	if (v250->quiet)
+		return;
+
+	c =3D at_server_result_codes[error];
+
+	if (v250->is_v1)
+		sprintf(text, "%s", c.v1);
+	else
+		sprintf(text, "%d", c.v0);
+
+	if (v250->is_v1)
+		sprintf(buf, "%c%c%s%c%c", t, r, text, t, r);
+	else
+		sprintf(buf, "%s%c", text, t);
+
+	g_at_util_debug_chat(server->debugf, FALSE, buf, strlen(buf),
+							server->debug_data);
+
+	g_io_channel_write(server->server_io, (char *) buf, strlen(buf),
+							&wbuf);
+}
+
+static gsize skip_space(const char *buf, gsize pos)
+{
+	gsize i =3D pos;
+	char c =3D buf[i];
+
+	while (c =3D=3D ' ')
+		c =3D buf[++i];
+
+	return i;
+}
+
+static int parse_v250_settings(GAtServer *server, char *buf)
+{
+	int res =3D G_AT_SERVER_RESULT_ERROR;
+
+	return res;
+}
+
+static int at_server_parse(GAtServer *server, char *buf)
+{
+	int res =3D G_AT_SERVER_RESULT_ERROR;
+	struct v250_settings *v250 =3D server->v250;
+	gsize i =3D 0;
+	char c;
+
+	/* skip space after "AT" or previous command */
+	i =3D skip_space(buf, i);
+
+	c =3D buf[i];
+	/* skip semicolon */
+	if (c =3D=3D ';')
+		c =3D buf[++i];
+
+	if (g_ascii_isalpha(c) || c =3D=3D '&')
+		res =3D parse_v250_settings(server, buf + i);
+	else if (c =3D=3D v250->s3)
+		res =3D G_AT_SERVER_RESULT_OK;
+
+	return res;
+}
+
+static void parse_buffer(GAtServer *server, unsigned int len)
+{
+	int res =3D G_AT_SERVER_RESULT_ERROR;
+	gsize i =3D 0;
+	char *buf =3D NULL;
+
+	g_at_server_ref(server);
+
+	buf =3D g_try_new0(char, len+1);
+
+	if (!buf)
+		goto out;
+
+	if (-1 =3D=3D ring_buffer_read(server->buf, buf, len))
+		goto out;
+
+	buf[len] =3D '\0';
+
+	DBG("received %s\n", buf);
+
+	/* skip header space */
+	buf +=3D skip_space(buf, i);
+
+	/* Make sure the command line prefix is "AT" or "at" */
+	if (g_str_has_prefix(buf, "AT") ||
+				g_str_has_prefix(buf, "at"))
+		res =3D at_server_parse(server, (char *) buf + 2);
+
+	g_at_server_send_result_code(server, res);
+
+out:
+	/* We're overflowing the buffer, shutdown the socket */
+	if (server->buf && ring_buffer_avail(server->buf) =3D=3D 0)
+		g_at_server_shutdown(server);
+
+	g_at_server_unref(server);
+}
+
+static gboolean received_data(GIOChannel *chan, GIOCondition cond,
+				gpointer data)
+{
+	GAtServer *server =3D data;
+	struct v250_settings *v250 =3D server->v250;
+	GIOError err;
+	gsize rbytes;
+	gsize total_read =3D 0;
+	unsigned char *total_buf =3D ring_buffer_write_ptr(server->buf);
+	static gsize total_len;
+
+	if (cond & G_IO_NVAL)
+		return FALSE;
+
+	if (cond & (G_IO_HUP | G_IO_ERR)) {
+		g_at_server_shutdown(server);
+
+		return FALSE;
+	}
+
+	/* Regardless of condition, try to read all the data available */
+	do {
+		unsigned char *buf;
+		gsize toread;
+
+		rbytes =3D 0;
+
+		toread =3D ring_buffer_avail_no_wrap(server->buf);
+
+		if (toread =3D=3D 0)
+			break;
+
+		buf =3D ring_buffer_write_ptr(server->buf);
+
+		err =3D g_io_channel_read(chan, (char *) buf, toread, &rbytes);
+
+		total_read +=3D rbytes;
+
+		if (rbytes > 0)
+			ring_buffer_write_advance(server->buf, rbytes);
+
+	} while (err =3D=3D G_IO_ERROR_NONE && rbytes > 0);
+
+	g_at_util_debug_chat(server->debugf, TRUE, (char *) total_buf,
+						total_read, server->debug_data);
+
+	if (total_read =3D=3D 0) {
+		g_at_server_shutdown(server);
+
+		return FALSE;
+	}
+
+	total_len +=3D total_read;
+
+	/* Add '\0' to perform strchr */
+	total_buf[total_read] =3D '\0';
+
+	/* Parse buffer until we meet the terminator so that
+	 * all preceding characters will be processed
+	 */
+	if (strchr((char *) total_buf, v250->s3)) {
+		parse_buffer(server, total_len);
+
+		total_len =3D 0;
+	}
+
+	if (err !=3D G_IO_ERROR_NONE && err !=3D G_IO_ERROR_AGAIN)
+		return FALSE;
+
+	return TRUE;
+}
+
+static struct v250_settings *v250_settings_create()
+{
+	struct v250_settings *v250;
+
+	v250 =3D g_try_new0(struct v250_settings, 1);
+
+	if (!v250)
+		return NULL;
+
+	v250->s3 =3D '\r';
+	v250->s4 =3D '\n';
+	v250->s5 =3D '\b';
+	v250->echo =3D TRUE;
+	v250->quiet =3D FALSE;
+	v250->is_v1 =3D TRUE;
+	v250->res_format =3D 0;
+	v250->c109 =3D 1;
+	v250->c108 =3D 0;
+
+	return v250;
+}
+
+GAtServer *g_at_server_new(GIOChannel *io, const char *modem_path)
+{
+	GAtServer *server;
+
+	if (!io || !modem_path)
+		return NULL;
+
+	server =3D g_try_new0(GAtServer, 1);
+	if (!server)
+		return NULL;
+
+	server->ref_count =3D 1;
+	server->v250 =3D v250_settings_create();
+	server->server_io =3D io;
+	server->modem_path =3D g_strdup(modem_path);
+	server->user_disconnect =3D NULL;
+	server->user_disconnect_data =3D NULL;
+	server->debugf =3D NULL;
+	server->debug_data =3D NULL;
+	server->buf =3D ring_buffer_new(4096);
+
+	if (!server->v250)
+		goto error;
+
+	if (!server->buf)
+		goto error;
+
+	if (!g_at_util_set_io(server->server_io))
+		goto error;
+
+	server->server_watch =3D g_io_add_watch_full(io,
+				G_PRIORITY_DEFAULT,
+				G_IO_IN | G_IO_HUP | G_IO_ERR | G_IO_NVAL,
+				received_data, server, NULL);
+
+	return server;
+
+error:
+	if (server->buf)
+		ring_buffer_free(server->buf);
+
+	if (server->modem_path)
+		g_free(server->modem_path);
+
+	if (server->v250)
+		g_free(server->v250);
+
+	if (server)
+		g_free(server);
+
+	return NULL;
+}
+
+GAtServer *g_at_server_ref(GAtServer *server)
+{
+	if (server =3D=3D NULL)
+		return NULL;
+
+	g_atomic_int_inc(&server->ref_count);
+
+	return server;
+}
+
+void g_at_server_unref(GAtServer *server)
+{
+	gboolean is_zero;
+
+	if (server =3D=3D NULL)
+		return;
+
+	is_zero =3D g_atomic_int_dec_and_test(&server->ref_count);
+
+	if (is_zero =3D=3D FALSE)
+		return;
+
+	g_at_server_shutdown(server);
+}
+
+gboolean g_at_server_shutdown(GAtServer *server)
+{
+	if (!server)
+		return FALSE;
+
+	if (server->modem_path)
+		g_free(server->modem_path);
+
+	if (server->v250)
+		g_free(server->v250);
+
+	ring_buffer_free(server->buf);
+	server->buf =3D NULL;
+
+	if (server->server_watch) {
+		g_source_remove(server->server_watch);
+		server->server_watch =3D 0;
+	}
+
+	if (server->server_io) {
+		g_io_channel_shutdown(server->server_io, FALSE, NULL);
+		g_io_channel_unref(server->server_io);
+		server->server_io =3D NULL;
+	}
+
+	if (server->user_disconnect)
+		server->user_disconnect(server->user_disconnect_data);
+
+	g_free(server);
+	server =3D NULL;
+
+	return TRUE;
+}
+
+gboolean g_at_server_set_disconnect_function(GAtServer *server,
+						GAtDisconnectFunc disconnect,
+						gpointer user)
+{
+	if (server =3D=3D NULL)
+		return FALSE;
+
+	server->user_disconnect =3D disconnect;
+	server->user_disconnect_data =3D user;
+
+	return TRUE;
+}
+
+gboolean g_at_server_set_debug(GAtServer *server, GAtDebugFunc func,
+						gpointer user)
+{
+	if (server =3D=3D NULL)
+		return FALSE;
+
+	server->debugf =3D func;
+	server->debug_data =3D user;
+
+	return TRUE;
+}
diff --git a/gatchat/gatserver.h b/gatchat/gatserver.h
new file mode 100644
index 0000000..39916ec
--- /dev/null
+++ b/gatchat/gatserver.h
@@ -0,0 +1,65 @@
+/*
+ *
+ *  AT Server library with GLib integration
+ *
+ *  Copyright (C) 2008-2010  Intel Corporation. All rights reserved.
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License version 2 as
+ *  published by the Free Software Foundation.
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
+#ifndef __GATSERVER_H
+#define __GATSERVER_H
+
+#ifdef __cplusplus
+extern "C" {
+#endif
+
+#include "gatutil.h"
+
+struct _GAtServer;
+
+typedef struct _GAtServer GAtServer;
+
+/* V.250 Table 1/V.250 Result codes */
+enum _GAtServerResultCodes {
+	G_AT_SERVER_RESULT_OK =3D 0,
+	G_AT_SERVER_RESULT_CONNECT,
+	G_AT_SERVER_RESULT_RING,
+	G_AT_SERVER_RESULT_NO_CARRIER,
+	G_AT_SERVER_RESULT_ERROR,
+	G_AT_SERVER_RESULT_NO_DIALTONE,
+	G_AT_SERVER_RESULT_BUSY,
+	G_AT_SERVER_RESULT_NO_ANSWER,
+	G_AT_SERVER_RESULT_CONNECT_EXT,
+};
+
+GAtServer *g_at_server_new(GIOChannel *io, const char *modem_path);
+
+GAtServer *g_at_server_ref(GAtServer *server);
+void g_at_server_unref(GAtServer *server);
+gboolean g_at_server_shutdown(GAtServer *server);
+
+gboolean g_at_server_set_disconnect_function(GAtServer *server,
+					GAtDisconnectFunc disconnect,
+					gpointer user_data);
+gboolean g_at_server_set_debug(GAtServer *server,
+					GAtDebugFunc func,
+					gpointer user);
+
+#ifdef __cplusplus
+}
+#endif
+
+#endif /* __GATSERVER_H */
-- =

1.6.3.3


--===============3747787438277750114==--

