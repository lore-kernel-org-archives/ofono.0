Content-Type: multipart/mixed; boundary="===============3902290269613139855=="
MIME-Version: 1.0
From: Jonas Bonn <jonas@southpole.se>
Subject: [PATCH 7/7] gobi: add location-reporting atom
Date: Fri, 08 Sep 2017 04:40:40 +0200
Message-ID: <20170908024040.31418-7-jonas@southpole.se>
In-Reply-To: <20170908024040.31418-1-jonas@southpole.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3902290269613139855==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This patch is submitted as a request for advice:  where should these
changes go???

The patch is required for Quectel QMI modems to get location-reporting
working:  the 'aux' AT interface needs to be set up and passed to the
location-reporting atom.  But this is very Quectel specific and has nothing
to do with Gobi at all.

So what's the best approach here...?
---
 plugins/gobi.c | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/plugins/gobi.c b/plugins/gobi.c
index bc2b068..962c947 100644
--- a/plugins/gobi.c
+++ b/plugins/gobi.c
@@ -29,6 +29,10 @@
 #include <unistd.h>
 #include <stdlib.h>
 =

+#include <glib.h>
+#include <gatchat.h>
+#include <gattty.h>
+
 #define OFONO_API_SUBJECT_TO_CHANGE
 #include <ofono/plugin.h>
 #include <ofono/modem.h>
@@ -319,10 +323,18 @@ static void discover_cb(uint8_t count, const struct q=
mi_version *list,
 						create_dms_cb, modem, NULL);
 }
 =

+static void q_debug(const char* str, void *user_data)
+{
+	const char* prefix =3D user_data;
+
+	ofono_info("%s%s", prefix, str);
+}
+
 static int gobi_enable(struct ofono_modem *modem)
 {
 	struct gobi_data *data =3D ofono_modem_get_data(modem);
 	const char *device;
+	const char *gps, *aux;
 	int fd;
 =

 	DBG("%p", modem);
@@ -348,6 +360,27 @@ static int gobi_enable(struct ofono_modem *modem)
 =

 	qmi_device_discover(data->device, discover_cb, modem, NULL);
 =

+	aux =3D ofono_modem_get_string(modem, "Aux");
+	gps =3D ofono_modem_get_string(modem, "GPS");
+	DBG("aux =3D %s, gps =3D %s", aux, gps);
+	if (aux && gps) {
+		GAtChat *chat;
+		GAtSyntax *syntax;
+		GHashTable *options;
+		GIOChannel *channel;
+		DBG("Setting up location service");
+		options =3D g_hash_table_new(g_str_hash, g_str_equal);
+		g_hash_table_insert(options, "Baud", "115200");
+		channel =3D g_at_tty_open(aux, options);
+		syntax =3D g_at_syntax_new_gsm_permissive();
+		chat =3D g_at_chat_new(channel, syntax);
+		g_at_syntax_unref(syntax);
+		g_io_channel_unref(channel);
+		if (getenv("OFONO_AT_DEBUG"))
+			g_at_chat_set_debug(chat, q_debug, "Aux: ");
+		ofono_location_reporting_create(modem, 0, "quectelmodem", chat);
+	}
+
 	return -EINPROGRESS;
 }
 =

-- =

2.9.3


--===============3902290269613139855==--

