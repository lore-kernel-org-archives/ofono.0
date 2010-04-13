Content-Type: multipart/mixed; boundary="===============8365534731298232169=="
MIME-Version: 1.0
From: Zhenhua Zhang <zhenhua.zhang@intel.com>
Subject: [PATCH 7/8] Add atemulator plugin
Date: Tue, 13 Apr 2010 22:18:18 +0800
Message-ID: <1271168299-4862-8-git-send-email-zhenhua.zhang@intel.com>
In-Reply-To: <1271168299-4862-7-git-send-email-zhenhua.zhang@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8365534731298232169==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 Makefile.am          |    3 +
 plugins/atemulator.c |  299 ++++++++++++++++++++++++++++++++++++++++++++++=
++++
 2 files changed, 302 insertions(+), 0 deletions(-)
 create mode 100644 plugins/atemulator.c

diff --git a/Makefile.am b/Makefile.am
index eda7ad6..3abd577 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -217,6 +217,9 @@ builtin_sources +=3D plugins/palmpre.c
 builtin_modules +=3D ste
 builtin_sources +=3D plugins/ste.c
 =

+builtin_modules +=3D atemulator
+builtin_sources +=3D plugins/atemulator.c
+
 endif
 =

 if MAINTAINER_MODE
diff --git a/plugins/atemulator.c b/plugins/atemulator.c
new file mode 100644
index 0000000..8a8c79c
--- /dev/null
+++ b/plugins/atemulator.c
@@ -0,0 +1,299 @@
+/*
+ *
+ *  oFono - Open Source Telephony
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
+#include <errno.h>
+#include <unistd.h>
+#include <stdlib.h>
+#include <string.h>
+#include <sys/socket.h>
+#include <netinet/in.h>
+#include <arpa/inet.h>
+
+#include <glib.h>
+
+#define OFONO_API_SUBJECT_TO_CHANGE
+#include <ofono/plugin.h>
+#include <ofono/log.h>
+#include <ofono/modem.h>
+#include <ofono/emulator.h>
+
+#include <utmp.h>
+#include <pty.h>
+
+#include "gatserver.h"
+
+struct at_emulator_data {
+	GAtServer *server;
+	GIOChannel *client_io;
+};
+
+static GAtServerResult dial_voicecall(struct ofono_emulator *emulator,
+					const char *dial_str)
+{
+	GAtServerResult res =3D G_AT_SERVER_RESULT_ERROR;
+	char c;
+	char *number;
+	int len =3D strlen(dial_str);
+
+	/* Skip last comma */
+	len--;
+
+	c =3D dial_str[len-1];
+	/* Skip closed user group flag */
+	if (c =3D=3D 'G' || c =3D=3D 'g')
+		len--;
+
+	c =3D dial_str[len-1];
+	/* Skip caller id suppress flag */
+	if (c =3D=3D 'I' || c =3D=3D 'i')
+		len--;
+
+	number =3D g_strndup(dial_str, len);
+
+	if (!ofono_emulator_dial(emulator, number))
+		goto done;
+
+	res =3D G_AT_SERVER_RESULT_OK;
+
+done:
+	if (number)
+		g_free(number);
+
+	return res;
+}
+
+static GAtServerResult dial_call(struct ofono_emulator *emulator,
+					const char *dial_str)
+{
+	struct at_emulator_data *data =3D ofono_emulator_get_data(emulator);
+	GAtServer *server =3D data->server;
+	GAtServerResult res =3D G_AT_SERVER_RESULT_ERROR;
+
+	if (dial_str[0] =3D=3D '*' || dial_str[0] =3D=3D '#') {
+		/* Supplementary service request */
+		sleep(2);
+		g_at_server_send_intermediate(server, "CONNECT");
+		sleep(2);
+
+		/* Perform PPP connection */
+		res =3D G_AT_SERVER_RESULT_OK;
+	} else
+		/* Voice call */
+		res =3D dial_voicecall(emulator, dial_str);
+
+	return res;
+}
+
+static void dial_cb(GAtServerRequestType type, GAtResult *result,
+					gpointer user_data)
+{
+	struct ofono_emulator *emulator =3D user_data;
+	struct at_emulator_data *data =3D ofono_emulator_get_data(emulator);
+	GAtServer *server =3D data->server;
+	GAtServerResult res =3D G_AT_SERVER_RESULT_ERROR;
+	GAtResultIter iter;
+	const char *dial_str;
+
+	if (type !=3D G_AT_SERVER_REQUEST_TYPE_SET)
+		goto done;
+
+	g_at_result_iter_init(&iter, result);
+
+	if (!g_at_result_iter_next(&iter, "D"))
+		goto done;
+
+	dial_str =3D g_at_result_iter_raw_line(&iter);
+	if (!dial_str)
+		goto done;
+
+	res =3D dial_call(emulator, dial_str);
+
+done:
+	g_at_server_send_final(server, res);
+}
+
+static void at_notify_call(struct ofono_emulator *emulator,
+				struct ofono_call *nc)
+{
+	DBG("notify new call %s\n", nc->phone_number.number);
+}
+
+static void voicecall_enable(struct ofono_emulator *emulator)
+{
+	struct at_emulator_data *data =3D ofono_emulator_get_data(emulator);
+	GAtServer *server =3D data->server;
+
+	g_at_server_register(server, "D", dial_cb, emulator, NULL);
+}
+
+static int at_emulator_probe(struct ofono_emulator *emulator)
+{
+	struct at_emulator_data *data;
+
+	DBG("%p", emulator);
+
+	data =3D g_try_new0(struct at_emulator_data, 1);
+	if (!data)
+		return -ENOMEM;
+
+	ofono_emulator_set_data(emulator, data);
+
+	ofono_emulator_register(emulator);
+
+	return 0;
+}
+
+static void at_emulator_remove(struct ofono_emulator *emulator)
+{
+	struct at_emulator_data *data =3D ofono_emulator_get_data(emulator);
+
+	DBG("%p", emulator);
+
+	g_free(data);
+	ofono_emulator_set_data(emulator, NULL);
+}
+
+static void at_emulator_debug(const char *str, void *user_data)
+{
+	ofono_info("%s", str);
+}
+
+static void set_raw_mode(int fd)
+{
+	struct termios options;
+
+	tcgetattr(fd, &options);
+
+	/* Set TTY as raw mode to disable echo back of input characters
+	 * when they are received from Modem to avoid feedback loop */
+	options.c_lflag &=3D ~(ICANON | ECHO | ECHOE | ISIG);
+
+	tcsetattr(fd, TCSANOW, &options);
+}
+
+static int create_tty(GIOChannel *client_io)
+{
+	int master, slave;
+	char pty_name[256];
+
+	if (openpty(&master, &slave, pty_name, NULL, NULL) < 0)
+		return 0;
+
+	set_raw_mode(slave);
+
+	client_io =3D g_io_channel_unix_new(slave);
+	g_io_channel_set_close_on_unref(client_io, TRUE);
+
+	DBG("new pty is created@%s\n", pty_name);
+
+	return master;
+}
+
+static int at_emulator_enable(struct ofono_emulator *emulator)
+{
+	GAtServer *server;
+	GIOChannel *server_io;
+	GIOChannel *client_io =3D NULL;
+	int master;
+	int ret =3D 0;
+	struct at_emulator_data *data =3D ofono_emulator_get_data(emulator);
+
+	DBG("%p", emulator);
+
+	master =3D create_tty(client_io);
+	if (!master) {
+		ret =3D -EIO;
+		goto error;
+	}
+
+	server_io =3D g_io_channel_unix_new(master);
+	if (!server_io) {
+		g_io_channel_shutdown(server_io, FALSE, NULL);
+		g_io_channel_unref(server_io);
+
+		ret =3D -EIO;
+		goto error;
+	}
+
+	server =3D g_at_server_new(server_io);
+	if (!server) {
+		g_io_channel_shutdown(server_io, FALSE, NULL);
+		g_io_channel_unref(server_io);
+
+		return FALSE;
+	}
+
+	data->server =3D server;
+	data->client_io =3D client_io;
+
+	if (getenv("OFONO_AT_DEBUG"))
+		g_at_server_set_debug(server, at_emulator_debug, NULL);
+
+	voicecall_enable(emulator);
+
+	return 0;
+
+error:
+	g_free(data);
+
+	return ret;
+}
+
+static int at_emulator_disable(struct ofono_emulator *emulator)
+{
+	struct at_emulator_data *data =3D ofono_emulator_get_data(emulator);
+
+	DBG("%p", emulator);
+
+	g_io_channel_unref(data->client_io);
+	g_at_server_unref(data->server);
+	g_at_server_shutdown(data->server);
+	data->server =3D NULL;
+
+	return 0;
+}
+
+static struct ofono_emulator_driver at_emulator_driver =3D {
+	.name		=3D "atemulator",
+	.probe		=3D at_emulator_probe,
+	.remove		=3D at_emulator_remove,
+	.enable		=3D at_emulator_enable,
+	.disable	=3D at_emulator_disable,
+	.notify_call	=3D at_notify_call,
+};
+
+static int at_emulator_init(void)
+{
+	return ofono_emulator_driver_register(&at_emulator_driver);
+}
+
+static void at_emulator_exit(void)
+{
+	ofono_emulator_driver_unregister(&at_emulator_driver);
+}
+
+OFONO_PLUGIN_DEFINE(atemulator, "AT server emulator", VERSION,
+		OFONO_PLUGIN_PRIORITY_DEFAULT, at_emulator_init,
+		at_emulator_exit)
-- =

1.6.6.1


--===============8365534731298232169==--

