Content-Type: multipart/mixed; boundary="===============8368307501227069864=="
MIME-Version: 1.0
From: Gustavo F. Padovan <padovan@profusion.mobi>
Subject: [PATCH 1/2] hfp: add watch to trigger HUP of the file descriptor
Date: Mon, 15 Feb 2010 18:40:25 -0200
Message-ID: <1266266426-31844-1-git-send-email-padovan@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8368307501227069864==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 plugins/hfp.c |   13 +++++++++++++
 1 files changed, 13 insertions(+), 0 deletions(-)

diff --git a/plugins/hfp.c b/plugins/hfp.c
index 411cfc1..616b119 100644
--- a/plugins/hfp.c
+++ b/plugins/hfp.c
@@ -482,6 +482,17 @@ error:
 	service_level_conn_failed(modem);
 }
 =

+static void hfp_disconnected_cb(gpointer user_data)
+{
+	struct ofono_modem *modem =3D user_data;
+	struct hfp_data *data =3D ofono_modem_get_data(modem);
+
+	ofono_modem_set_powered(modem, FALSE);
+
+	g_at_chat_unref(data->chat);
+	data->chat =3D NULL;
+}
+
 /* either oFono or Phone could request SLC connection */
 static int service_level_connection(struct ofono_modem *modem, int fd)
 {
@@ -506,6 +517,8 @@ static int service_level_connection(struct ofono_modem =
*modem, int fd)
 	if (!chat)
 		return -ENOMEM;
 =

+	g_at_chat_set_disconnect_function(chat, hfp_disconnected_cb, modem);
+
 	if (getenv("OFONO_AT_DEBUG"))
 		g_at_chat_set_debug(chat, hfp_debug, NULL);
 =

-- =

1.6.4.4


--===============8368307501227069864==--

