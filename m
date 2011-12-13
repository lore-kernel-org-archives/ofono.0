Content-Type: multipart/mixed; boundary="===============8595446880336345904=="
MIME-Version: 1.0
From: Daniel Wagner <wagi@monom.org>
Subject: [RFC v3 14/16] elect: Add GatChat and PPP handler
Date: Tue, 13 Dec 2011 16:00:08 +0100
Message-ID: <1323788410-9988-15-git-send-email-wagi@monom.org>
In-Reply-To: <1323788410-9988-1-git-send-email-wagi@monom.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8595446880336345904==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Daniel Wagner <daniel.wagner@bmw-carit.de>

---
 Makefile.am  |    2 +-
 elect/dial.c |  125 ++++++++++++++++++++++++++++++++++++++++++++++++++++++=
+++-
 2 files changed, 125 insertions(+), 2 deletions(-)

diff --git a/Makefile.am b/Makefile.am
index 588183d..f39035f 100644
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
 			elect/main.c elect/dbus.c elect/manager.c elect/device.c \
 			elect/dial.c
diff --git a/elect/dial.c b/elect/dial.c
index 6f83981..01ff4c2 100644
--- a/elect/dial.c
+++ b/elect/dial.c
@@ -24,18 +24,122 @@
 #include <config.h>
 #endif
 =

+#include <errno.h>
+
 #include <glib.h>
 =

+#include <gatchat.h>
+#include <gattty.h>
+#include <gatppp.h>
+
 #include "elect.h"
 =

+static const char *none_prefix[] =3D { NULL };
+
 struct elect_dial {
 	char *path;
 	void *data;
 =

+	GAtPPP *ppp;
+	GAtChat *chat;
+
 	elect_dial_connect_cb_t connect_cb;
 	elect_dial_disconnect_cb_t disconnect_cb;
 };
 =

+static void dial_debug(const char *str, void *data)
+{
+	DBG("%s: %s\n", (const char *) data, str);
+}
+
+static void ppp_connect(const char *iface, const char *local, const char *=
peer,
+			const char *dns1, const char *dns2,
+			gpointer user_data)
+{
+	struct elect_dial *dial =3D user_data;
+
+	DBG("Network Device: %s\n", iface);
+	DBG("IP Address: %s\n", local);
+	DBG("Peer IP Address: %s\n", peer);
+	DBG("Primary DNS Server: %s\n", dns1);
+	DBG("Secondary DNS Server: %s\n", dns2);
+
+	if (dial->connect_cb)
+		dial->connect_cb(iface, local, peer, dns1, dns2, dial->data);
+}
+
+static void ppp_disconnect(GAtPPPDisconnectReason reason, gpointer user_da=
ta)
+{
+	struct elect_dial *dial =3D user_data;
+
+	DBG("PPP Link down: %d\n", reason);
+
+	g_at_ppp_unref(dial->ppp);
+	dial->ppp =3D NULL;
+
+	g_at_chat_resume(dial->chat);
+
+	if (dial->disconnect_cb)
+		dial->disconnect_cb(dial->data);
+}
+
+static void connect_cb(gboolean ok, GAtResult *result, gpointer user_data)
+{
+	struct elect_dial *dial =3D user_data;
+	GAtIO *io;
+
+	if (!ok) {
+		DBG("Unable to define context\n");
+		return;
+	}
+
+	/* get the data IO channel */
+	io =3D g_at_chat_get_io(dial->chat);
+
+	/*
+	 * shutdown gatchat or else it tries to take all the input
+	 * from the modem and does not let PPP get it.
+	 */
+	g_at_chat_suspend(dial->chat);
+
+	/* open ppp */
+	dial->ppp =3D g_at_ppp_new();
+	if (dial->ppp =3D=3D NULL) {
+		DBG("Unable to create PPP object\n");
+		return;
+	}
+	g_at_ppp_set_debug(dial->ppp, dial_debug, "PPP");
+
+	/* set connect and disconnect callbacks */
+	g_at_ppp_set_connect_function(dial->ppp, ppp_connect, dial);
+	g_at_ppp_set_disconnect_function(dial->ppp, ppp_disconnect, dial);
+
+	/* open the ppp connection */
+	g_at_ppp_open(dial->ppp, io);
+}
+
+static int open_serial(struct elect_dial *dial)
+{
+	GAtSyntax *syntax;
+	GIOChannel *channel;
+
+	channel =3D g_at_tty_open(dial->path, NULL);
+	if (channel =3D=3D NULL)
+		return -EIO;
+
+	syntax =3D g_at_syntax_new_gsm_permissive();
+	dial->chat =3D g_at_chat_new(channel, syntax);
+	g_io_channel_unref(channel);
+	g_at_syntax_unref(syntax);
+
+	if (dial->chat =3D=3D NULL)
+		return -EIO;
+
+	g_at_chat_set_debug(dial->chat, dial_debug, "Control");
+
+	return 0;
+}
+
 struct elect_dial *__elect_dial_create(elect_dial_connect_cb_t connect_cb,
 				elect_dial_disconnect_cb_t disconnect_cb,
 				void *data)
@@ -58,11 +162,19 @@ struct elect_dial *__elect_dial_create(elect_dial_conn=
ect_cb_t connect_cb,
 =

 int __elect_dial_connect(struct elect_dial *dial, const char *path)
 {
+	int err;
 	DBG("%s", dial->path);
 =

 	g_free(dial->path);
 	dial->path =3D g_strdup(path);	=

 =

+	err =3D open_serial(dial);
+	if (err < 0)
+		return err;
+
+	g_at_chat_send(dial->chat, "ATD*99#", none_prefix, connect_cb,
+		dial, NULL);
+
 	return 0;
 }
 =

@@ -70,12 +182,23 @@ int __elect_dial_disconnect(struct elect_dial *dial)
 {
 	DBG("%s", dial->path);
 =

+	if (dial->ppp =3D=3D NULL)
+		return -EINVAL;
+
+	g_at_ppp_suspend(dial->ppp);
+
 	return 0;
 }
 =

 void __elect_dial_unref(struct elect_dial *dial)
 {
-	DBG("%s", dial->path);
+	DBG("");
+
+	if (dial->chat !=3D NULL)
+		g_at_chat_unref(dial->chat);
+
+	if (dial->ppp !=3D NULL)
+		g_at_ppp_unref(dial->ppp);
 =

 	g_free(dial->path);
 =

-- =

1.7.8.110.g4cb5d1


--===============8595446880336345904==--

