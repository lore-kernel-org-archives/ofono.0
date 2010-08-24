Content-Type: multipart/mixed; boundary="===============5868655370561253656=="
MIME-Version: 1.0
From: Pekka.Pessi@nokia.com
Subject: [online PATCH 6/9] novatel: implement Online property
Date: Tue, 24 Aug 2010 14:32:01 +0300
Message-ID: <1282649524-31353-7-git-send-email-Pekka.Pessi@nokia.com>
In-Reply-To: <1282649524-31353-6-git-send-email-Pekka.Pessi@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5868655370561253656==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Pekka Pessi <Pekka.Pessi@nokia.com>

---
 plugins/novatel.c |   34 +++++++++++++++++++++++++++++++---
 1 files changed, 31 insertions(+), 3 deletions(-)

diff --git a/plugins/novatel.c b/plugins/novatel.c
index 38a6c3b..998ea59 100644
--- a/plugins/novatel.c
+++ b/plugins/novatel.c
@@ -156,7 +156,7 @@ static void nwdmat_action(gboolean ok, GAtResult *resul=
t, gpointer user_data)
 							NULL, NULL, NULL);
 =

 done:
-	g_at_chat_send(data->primary, "AT+CFUN=3D1", none_prefix,
+	g_at_chat_send(data->primary, "AT+CFUN=3D4", none_prefix,
 						cfun_enable, modem, NULL);
 }
 =

@@ -288,6 +288,33 @@ static int novatel_disable(struct ofono_modem *modem)
 	return -EINPROGRESS;
 }
 =

+static void set_online_cb(gboolean ok, GAtResult *result, gpointer user_da=
ta)
+{
+	struct cb_data *cbd =3D user_data;
+	ofono_modem_online_cb_t cb =3D cbd->cb;
+
+	if (ok)
+		CALLBACK_WITH_SUCCESS(cb, cbd->data);
+	else
+		CALLBACK_WITH_FAILURE(cb, cbd->data);
+}
+
+static void novatel_set_online(struct ofono_modem *modem, ofono_bool_t onl=
ine,
+				ofono_modem_online_cb_t cb, void *user_data)
+{
+	struct novatel_data *data =3D ofono_modem_get_data(modem);
+	struct cb_data *cbd =3D cb_data_new(cb, user_data);
+	char const *command =3D online ? "AT+CFUN=3D1" : "AT+CFUN=3D4";
+
+	DBG("modem %p %s", modem, online ? "online" : "offline");
+
+	if (!data->primary)
+		return;
+
+	g_at_chat_send(data->primary, command, NULL,
+			set_online_cb, cbd, g_free);
+}
+
 static void novatel_pre_sim(struct ofono_modem *modem)
 {
 	struct novatel_data *data =3D ofono_modem_get_data(modem);
@@ -309,7 +336,7 @@ static void novatel_pre_sim(struct ofono_modem *modem)
 		ofono_sim_inserted_notify(sim, TRUE);
 }
 =

-static void novatel_post_sim(struct ofono_modem *modem)
+static void novatel_post_online(struct ofono_modem *modem)
 {
 	struct novatel_data *data =3D ofono_modem_get_data(modem);
 =

@@ -351,8 +378,9 @@ static struct ofono_modem_driver novatel_driver =3D {
 	.remove		=3D novatel_remove,
 	.enable		=3D novatel_enable,
 	.disable	=3D novatel_disable,
+	.set_online     =3D novatel_set_online,
 	.pre_sim	=3D novatel_pre_sim,
-	.post_sim	=3D novatel_post_sim,
+	.post_online	=3D novatel_post_online,
 };
 =

 static int novatel_init(void)
-- =

1.7.0.4


--===============5868655370561253656==--

