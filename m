Content-Type: multipart/mixed; boundary="===============1193830521196654831=="
MIME-Version: 1.0
From: Gustavo F. Padovan <padovan@profusion.mobi>
Subject: [PATCH 2/5] phonesim: Add modem reset trigger
Date: Thu, 25 Nov 2010 17:02:17 -0200
Message-ID: <1290711740-27886-2-git-send-email-padovan@profusion.mobi>
In-Reply-To: <1290711740-27886-1-git-send-email-padovan@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1193830521196654831==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 plugins/phonesim.c |   27 +++++++++++++++++++++++++++
 1 files changed, 27 insertions(+), 0 deletions(-)

diff --git a/plugins/phonesim.c b/plugins/phonesim.c
index d2faf42..14dae47 100644
--- a/plugins/phonesim.c
+++ b/plugins/phonesim.c
@@ -237,6 +237,30 @@ static void cfun_set_on_cb(gboolean ok, GAtResult *res=
ult, gpointer user_data)
 	ofono_modem_set_powered(modem, ok);
 }
 =

+static gboolean phonesim_reset(void *user_data)
+{
+	struct ofono_modem *modem =3D user_data;
+	struct phonesim_data *data =3D ofono_modem_get_data(modem);
+
+	g_at_chat_unref(data->chat);
+	data->chat =3D NULL;
+
+	if (data->mux) {
+		g_at_mux_shutdown(data->mux);
+		g_at_mux_unref(data->mux);
+		data->mux =3D NULL;
+	}
+
+	ofono_modem_reset(modem);
+
+	return FALSE;
+}
+
+static void crst_notify(GAtResult *result, gpointer user_data)
+{
+	g_idle_add(phonesim_reset, user_data);
+}
+
 static void phonesim_disconnected(gpointer user_data)
 {
 	struct ofono_modem *modem =3D user_data;
@@ -389,6 +413,9 @@ static int phonesim_enable(struct ofono_modem *modem)
 	g_at_chat_send(data->chat, "AT+CSCS=3D\"GSM\"", none_prefix,
 			NULL, NULL, NULL);
 =

+	g_at_chat_register(data->chat, "+CRST:",
+				crst_notify, FALSE, modem, NULL);
+
 	return 0;
 }
 =

-- =

1.7.3.2


--===============1193830521196654831==--

