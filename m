Content-Type: multipart/mixed; boundary="===============0274050004698392557=="
MIME-Version: 1.0
From: Daniel Wagner <wagi@monom.org>
Subject: [RFC v2 09/11] elect: Add GatChat and PPP handler
Date: Fri, 09 Dec 2011 17:35:44 +0100
Message-ID: <1323448546-2728-10-git-send-email-wagi@monom.org>
In-Reply-To: <1323448546-2728-1-git-send-email-wagi@monom.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0274050004698392557==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Daniel Wagner <daniel.wagner@bmw-carit.de>

---
 Makefile.am |    2 +-
 elect/dun.c |  207 +++++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++
 2 files changed, 208 insertions(+), 1 deletions(-)
 create mode 100644 elect/dun.c

diff --git a/Makefile.am b/Makefile.am
index 3e36d4e..6afd3a0 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -651,7 +651,7 @@ if ELECT
 =

 sbin_PROGRAMS +=3D elect/electd
 =

-elect_electd_SOURCES =3D $(gdbus_sources) $(btio_sources) \
+elect_electd_SOURCES =3D $(gdbus_sources) $(btio_sources) $(gatchat_source=
s) \
 			src/log.c src/dbus.c plugins/bluetooth.c \
 			elect/main.c elect/manager.c elect/device.c elect/dun.c
 =

diff --git a/elect/dun.c b/elect/dun.c
new file mode 100644
index 0000000..c4a3c5d
--- /dev/null
+++ b/elect/dun.c
@@ -0,0 +1,207 @@
+/*
+ *
+ *  oFono - Open Source Telephony
+ *
+ *  Copyright (C) 2008-2011  Intel Corporation. All rights reserved.
+ *  Copyright (C) 2011  BMW Car IT GmbH. All rights reserved.
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
+#include <string.h>
+#include <stdlib.h>
+#include <stdio.h>
+#include <errno.h>
+#include <unistd.h>
+#include <sys/signalfd.h>
+#include <sys/socket.h>
+#include <netinet/in.h>
+#include <arpa/inet.h>
+
+#include <glib.h>
+#include <gatchat.h>
+#include <gattty.h>
+#include <gatppp.h>
+
+#include "elect.h"
+
+static const char *none_prefix[] =3D { NULL };
+
+struct elect_dun {
+	char *path;
+	void *data;
+
+	GAtPPP *ppp;
+	GAtChat *chat;
+
+	elect_dun_connect_cb_t connect_cb;
+	elect_dun_disconnect_cb_t disconnect_cb;
+};
+
+static void dun_debug(const char *str, void *data)
+{
+	DBG("%s: %s\n", (const char *) data, str);
+}
+
+static void ppp_connect(const char *iface, const char *local, const char *=
peer,
+			const char *dns1, const char *dns2,
+			gpointer user_data)
+{
+	struct elect_dun *dun =3D user_data;
+
+	DBG("Network Device: %s\n", iface);
+	DBG("IP Address: %s\n", local);
+	DBG("Peer IP Address: %s\n", peer);
+	DBG("Primary DNS Server: %s\n", dns1);
+	DBG("Secondary DNS Server: %s\n", dns2);
+
+	if (dun->connect_cb)
+		dun->connect_cb(iface, local, peer, dns1, dns2, dun->data);
+}
+
+static void ppp_disconnect(GAtPPPDisconnectReason reason, gpointer user_da=
ta)
+{
+	struct elect_dun *dun =3D user_data;
+
+	DBG("PPP Link down: %d\n", reason);
+
+	g_at_ppp_unref(dun->ppp);
+	dun->ppp =3D NULL;
+
+	g_at_chat_resume(dun->chat);
+
+	if (dun->disconnect_cb)
+		dun->disconnect_cb(dun->data);
+}
+
+static void connect_cb(gboolean ok, GAtResult *result, gpointer user_data)
+{
+	struct elect_dun *dun =3D user_data;
+	GAtIO *io;
+
+	if (!ok) {
+		DBG("Unable to define context\n");
+		return;
+	}
+
+	/* get the data IO channel */
+	io =3D g_at_chat_get_io(dun->chat);
+
+	/*
+	 * shutdown gatchat or else it tries to take all the input
+	 * from the modem and does not let PPP get it.
+	 */
+	g_at_chat_suspend(dun->chat);
+
+	/* open ppp */
+	dun->ppp =3D g_at_ppp_new();
+	if (dun->ppp =3D=3D NULL) {
+		DBG("Unable to create PPP object\n");
+		return;
+	}
+	g_at_ppp_set_debug(dun->ppp, dun_debug, "PPP");
+
+	/* set connect and disconnect callbacks */
+	g_at_ppp_set_connect_function(dun->ppp, ppp_connect, dun);
+	g_at_ppp_set_disconnect_function(dun->ppp, ppp_disconnect, dun);
+
+	/* open the ppp connection */
+	g_at_ppp_open(dun->ppp, io);
+}
+
+static int open_serial(struct elect_dun *dun)
+{
+	GAtSyntax *syntax;
+	GIOChannel *channel;
+
+	channel =3D g_at_tty_open(dun->path, NULL);
+	if (channel =3D=3D NULL)
+		return -EIO;
+
+	syntax =3D g_at_syntax_new_gsm_permissive();
+	dun->chat =3D g_at_chat_new(channel, syntax);
+	g_io_channel_unref(channel);
+	g_at_syntax_unref(syntax);
+
+	if (dun->chat =3D=3D NULL)
+		return -EIO;
+
+	g_at_chat_set_debug(dun->chat, dun_debug, "Control");
+
+	return 0;
+}
+
+struct elect_dun *__elect_dun_create(const char *path,
+				elect_dun_connect_cb_t connect_cb,
+				elect_dun_disconnect_cb_t disconnect_cb,
+				void *data)
+{
+	struct elect_dun *dun;
+
+	DBG("%s", path);
+
+	dun =3D g_try_new0(struct elect_dun, 1);
+	if (dun =3D=3D NULL)
+		return NULL;
+
+	dun->path =3D g_strdup(path);
+	dun->data =3D data;
+
+	dun->connect_cb =3D connect_cb;
+	dun->disconnect_cb =3D disconnect_cb;
+
+	return dun;
+}
+
+int __elect_dun_connect(struct elect_dun *dun)
+{
+	int err;
+
+	DBG("%s", dun->path);
+
+	err =3D open_serial(dun);
+	if (err < 0)
+		return err;
+
+	g_at_chat_send(dun->chat, "ATD*99#", none_prefix, connect_cb,
+		dun, NULL);
+
+	return 0;
+}
+
+int __elect_dun_disconnect(struct elect_dun *dun)
+{
+	DBG("%s", dun->path);
+
+	if (dun->ppp =3D=3D NULL)
+		return -EINVAL;
+
+	g_at_ppp_suspend(dun->ppp);
+
+	return 0;
+}
+
+void __elect_dun_unref(struct elect_dun *dun)
+{
+	DBG("%s", dun->path);
+
+	g_free(dun->path);
+
+	g_free(dun);
+}
-- =

1.7.8.110.g4cb5d1


--===============0274050004698392557==--

