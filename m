Content-Type: multipart/mixed; boundary="===============7873080103704161382=="
MIME-Version: 1.0
From: Jonas Bonn <jonas@southpole.se>
Subject: [PATCH 1/1] he910: set modem unpowered after IO disconnect
Date: Fri, 02 May 2014 16:15:39 +0200
Message-ID: <1399040139-30253-1-git-send-email-jonas@southpole.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7873080103704161382==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This patch address an issue with SIM hotplug.  If the SIM card is removed
while there is an active connection then the io_disconnect function
of gatchat.c pulls the rug out from under us by cleaning up the modem
chat that we hold a reference to.

This patch addresses this by hooking into the notification from
io_disconnect and setting the modem to 'unpowered' state in order to force
a reinitialization when the SIM is reinserted.

The modem is not actually powered off as that would turn off SIM detection
as well.

With this patch, SIM hotplug works reliably.
---
 plugins/he910.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/plugins/he910.c b/plugins/he910.c
index 38dbfac..999889f 100644
--- a/plugins/he910.c
+++ b/plugins/he910.c
@@ -76,6 +76,22 @@ static void he910_debug(const char *str, void *user_data)
 	ofono_info("%s%s", prefix, str);
 }
 =

+static void he910_disconnected_cb(gpointer user_data)
+{
+	struct ofono_modem *modem =3D user_data;
+	struct he910_data *data =3D ofono_modem_get_data(modem);
+
+	DBG("HE910 disconnected");
+
+	ofono_modem_set_powered(modem, FALSE);
+
+	g_at_chat_unref(data->chat);
+	data->chat =3D NULL;
+
+	g_at_chat_unref(data->modem);
+	data->modem =3D NULL;
+}
+
 static GAtChat *open_device(struct ofono_modem *modem,
 				const char *key, char *debug)
 {
@@ -110,6 +126,8 @@ static GAtChat *open_device(struct ofono_modem *modem,
 	if (chat =3D=3D NULL)
 		return NULL;
 =

+	g_at_chat_set_disconnect_function(chat, he910_disconnected_cb, modem);
+
 	if (getenv("OFONO_AT_DEBUG"))
 		g_at_chat_set_debug(chat, he910_debug, debug);
 =

-- =

1.9.1


--===============7873080103704161382==--

