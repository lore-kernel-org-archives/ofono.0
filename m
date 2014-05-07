Content-Type: multipart/mixed; boundary="===============2142628436930453810=="
MIME-Version: 1.0
From: Jonas Bonn <jonas@southpole.se>
Subject: [PATCH v2 1/1] he910: reset modem after IO disconnect
Date: Wed, 07 May 2014 14:14:01 +0200
Message-ID: <1399464841-23097-1-git-send-email-jonas@southpole.se>
In-Reply-To: <5368E5DC.1040409@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2142628436930453810==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This patch primarily addresses an issue with SIM hotplug.  If the SIM
card is removed while there is an active data connection then the
io_disconnect function of gatchat.c pulls the rug out from under us
by cleaning up the modem chat that we hold a reference to.

This patch addresses this by hooking into the notification from
io_disconnect, cleaning up the chat structures in question, and
resetting the modem.

This patch also addresses a secondary issue whereby killing ofono during
an active connection causes the AUX port to report HUP when ofono is
restarted.

With this patch, SIM hotplug works reliably, as does restarting ofono
during an active connection.
---

Hi Denis,

How about this approach instead?  Using ofono_modem_reset has pretty
much the same effect as my previous patch and _feels" correct...

HUP on the modem port when the SIM is unplugged and HUP on the aux port
when ofono is restarted are easily reproducible for me.

/Jonas

 plugins/he910.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/plugins/he910.c b/plugins/he910.c
index 38dbfac..94fc1c4 100644
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
+	g_at_chat_unref(data->chat);
+	data->chat =3D NULL;
+
+	g_at_chat_unref(data->modem);
+	data->modem =3D NULL;
+
+	ofono_modem_reset(modem);
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


--===============2142628436930453810==--

