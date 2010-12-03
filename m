Content-Type: multipart/mixed; boundary="===============2252904219190618405=="
MIME-Version: 1.0
From: Gustavo F. Padovan <padovan@profusion.mobi>
Subject: [PATCH -v3 4/5] phonesim: Add modem reset trigger
Date: Fri, 03 Dec 2010 16:52:56 -0200
Message-ID: <1291402377-9211-4-git-send-email-padovan@profusion.mobi>
In-Reply-To: <1291402377-9211-3-git-send-email-padovan@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2252904219190618405==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 plugins/phonesim.c |   27 +++++++++++++++++++++++++++
 1 files changed, 27 insertions(+), 0 deletions(-)

diff --git a/plugins/phonesim.c b/plugins/phonesim.c
index 6b483ff..c7ef0d7 100644
--- a/plugins/phonesim.c
+++ b/plugins/phonesim.c
@@ -374,6 +374,30 @@ static void cfun_set_on_cb(gboolean ok, GAtResult *res=
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
@@ -526,6 +550,9 @@ static int phonesim_enable(struct ofono_modem *modem)
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


--===============2252904219190618405==--

