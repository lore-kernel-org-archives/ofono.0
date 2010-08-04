Content-Type: multipart/mixed; boundary="===============1215124506898917914=="
MIME-Version: 1.0
From: Gustavo F. Padovan <gustavo@padovan.org>
Subject: [PATCH 5/5] dun: Add GAtChat for the rfcomm device
Date: Wed, 04 Aug 2010 07:22:14 -0300
Message-ID: <1280917334-4519-5-git-send-email-gustavo@padovan.org>
In-Reply-To: <1280917334-4519-4-git-send-email-gustavo@padovan.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1215124506898917914==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 drivers/dunmodem/dunmodem.c |    1 +
 drivers/dunmodem/dunmodem.h |    1 +
 plugins/dun.c               |   56 +++++++++++++++++++++++++++++++++++++++=
++++
 3 files changed, 58 insertions(+), 0 deletions(-)

diff --git a/drivers/dunmodem/dunmodem.c b/drivers/dunmodem/dunmodem.c
index 5657668..1020dd2 100644
--- a/drivers/dunmodem/dunmodem.c
+++ b/drivers/dunmodem/dunmodem.c
@@ -30,6 +30,7 @@
 #include <errno.h>
 =

 #include <glib.h>
+#include <gatchat.h>
 =

 #define OFONO_API_SUBJECT_TO_CHANGE
 #include <ofono/plugin.h>
diff --git a/drivers/dunmodem/dunmodem.h b/drivers/dunmodem/dunmodem.h
index 6d545c9..f7351b7 100644
--- a/drivers/dunmodem/dunmodem.h
+++ b/drivers/dunmodem/dunmodem.h
@@ -22,4 +22,5 @@
 struct dun_data {
 	char *dun_path;
 	char *rfcomm;
+	GAtChat *chat;
 };
diff --git a/plugins/dun.c b/plugins/dun.c
index 3d1e5c4..488e7a3 100644
--- a/plugins/dun.c
+++ b/plugins/dun.c
@@ -23,11 +23,14 @@
 #include <config.h>
 #endif
 #include <stdio.h>
+#include <stdlib.h>
 #include <string.h>
 #include <errno.h>
 #include <gdbus.h>
 #include <glib.h>
 #include <ofono.h>
+#include <gatchat.h>
+#include <gattty.h>
 =

 #define OFONO_API_SUBJECT_TO_CHANGE
 #include <ofono/plugin.h>
@@ -47,6 +50,48 @@
 static DBusConnection *connection;
 static GHashTable *modem_hash =3D NULL;
 =

+static void dun_debug(const char *str, void *user_data)
+{
+	ofono_info("%s", str);
+}
+
+static GAtChat *create_port(const char *device)
+{
+	GAtSyntax *syntax;
+	GIOChannel *channel;
+	GAtChat *chat;
+
+	channel =3D g_at_tty_open(device, NULL);
+	if (!channel)
+		return NULL;
+
+	syntax =3D g_at_syntax_new_gsm_permissive();
+	chat =3D g_at_chat_new(channel, syntax);
+	g_at_syntax_unref(syntax);
+	g_io_channel_unref(channel);
+
+	if (!chat)
+		return NULL;
+
+	return chat;
+}
+
+static GAtChat *open_device(const char *device, char *debug)
+{
+	GAtChat *chat;
+
+	DBG("%s", device);
+
+	chat =3D create_port(device);
+	if (chat =3D=3D NULL)
+		return NULL;
+
+	if (getenv("OFONO_AT_DEBUG"))
+		g_at_chat_set_debug(chat, dun_debug, debug);
+
+	return chat;
+}
+
 static int dun_create_modem(const char *device, const char *dev_addr,
 				const char *adapter_addr, const char *alias)
 {
@@ -159,6 +204,10 @@ static void dun_connect_reply(DBusPendingCall *call, g=
pointer user_data)
 =

 	data->rfcomm =3D g_strdup(dev);
 =

+	data->chat =3D open_device(dev, "Modem:");
+	if (data->chat =3D=3D NULL)
+		goto done;
+
 	dbus_error_init(&derr);
 	if (!dbus_set_error_from_message(&derr, reply)) {
 		ofono_modem_set_powered(modem, TRUE);
@@ -235,6 +284,13 @@ static int dun_disable(struct ofono_modem *modem)
 	if (!ofono_modem_get_powered(modem))
 		return 0;
 =

+	if (data->chat) {
+		g_at_chat_cancel_all(data->chat);
+		g_at_chat_unregister_all(data->chat);
+		g_at_chat_unref(data->chat);
+		data->chat =3D NULL;
+	}
+
 	status =3D bluetooth_send_with_reply(data->dun_path,
 				BLUEZ_SERIAL_INTERFACE, "Disconnect",
 				dun_power_down, modem, NULL, DBUS_TIMEOUT,
-- =

1.7.1.1


--===============1215124506898917914==--

