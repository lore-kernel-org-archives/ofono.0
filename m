Content-Type: multipart/mixed; boundary="===============7829655357976865932=="
MIME-Version: 1.0
From: Vijay Nayani <vijay.nayani@elektrobit.com>
Subject: [RFC PATCH 18/20] phonesim: Add cemode query implementation
Date: Mon, 11 Apr 2011 13:20:16 +0300
Message-ID: <1302517218-2147-19-git-send-email-vijay.nayani@elektrobit.com>
In-Reply-To: <1302517218-2147-1-git-send-email-vijay.nayani@elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7829655357976865932==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 plugins/phonesim.c |   34 +++++++++++++++++++++++++++++++++-
 1 files changed, 33 insertions(+), 1 deletions(-)

diff --git a/plugins/phonesim.c b/plugins/phonesim.c
index 13f942e..0727baf 100644
--- a/plugins/phonesim.c
+++ b/plugins/phonesim.c
@@ -66,6 +66,7 @@
 =

 static const char *none_prefix[] =3D { NULL };
 static const char *ptty_prefix[] =3D { "+PTTY:", NULL };
+static const char *cemode_prefix[] =3D { "+CEMODE:", NULL };
 static int next_iface =3D 0;
 =

 struct phonesim_data {
@@ -73,6 +74,7 @@ struct phonesim_data {
 	GAtChat *chat;
 	gboolean calypso;
 	gboolean use_mux;
+	int pref_ue_mode;
 };
 =

 struct packet_context_data {
@@ -419,6 +421,31 @@ static void crst_notify(GAtResult *result, gpointer us=
er_data)
 	g_idle_add(phonesim_reset, user_data);
 }
 =

+static void cemode_read_cb(gboolean ok, GAtResult *result, gpointer user_d=
ata)
+{
+	struct ofono_modem *modem =3D user_data;
+	struct phonesim_data *data =3D ofono_modem_get_data(modem);
+	GAtResultIter iter;
+	int mode;
+
+	if (!ok)
+		goto out;
+
+	g_at_result_iter_init(&iter, result);
+
+	if (g_at_result_iter_next(&iter, "+CEMODE:") =3D=3D FALSE)
+		goto out;
+
+	if (g_at_result_iter_next_number(&iter, &mode) =3D=3D FALSE)
+		goto out;
+
+	data->pref_ue_mode =3D mode;
+	ofono_modem_set_preferred_ue_mode(modem, mode);
+
+out:
+	ofono_modem_set_powered(modem, TRUE);
+}
+
 static void phonesim_disconnected(gpointer user_data)
 {
 	struct ofono_modem *modem =3D user_data;
@@ -529,6 +556,8 @@ static int phonesim_enable(struct ofono_modem *modem)
 		return -ENOMEM;
 	}
 =

+	data->pref_ue_mode =3D -1;
+
 	if (data->calypso)
 		syntax =3D g_at_syntax_new_gsm_permissive();
 	else
@@ -574,7 +603,10 @@ static int phonesim_enable(struct ofono_modem *modem)
 	g_at_chat_register(data->chat, "+CRST:",
 				crst_notify, FALSE, modem, NULL);
 =

-	return 0;
+	g_at_chat_send(data->chat, "AT+CEMODE?", cemode_prefix,
+			cemode_read_cb, modem, NULL);
+
+	return -EINPROGRESS;
 }
 =

 static void set_online_cb(gboolean ok, GAtResult *result, gpointer user_da=
ta)
-- =

1.7.0.4


--===============7829655357976865932==--

