Content-Type: multipart/mixed; boundary="===============6976824811489125891=="
MIME-Version: 1.0
From: Alexey Mednyy <swexru@gmail.com>
Subject: [PATCH 1/1] add set_online interface to he910 modem
Date: Mon, 01 Dec 2014 14:35:09 +0300
Message-ID: <547C526D.3030901@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6976824811489125891==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Had to add set_online interface to he910 modem connman now, working
properly if disable he910 cellular (was not implemented error before).
---
 plugins/he910.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/plugins/he910.c b/plugins/he910.c
index 69362b8..add2243 100644
--- a/plugins/he910.c
+++ b/plugins/he910.c
@@ -322,6 +322,30 @@ static void he910_pre_sim(struct ofono_modem *modem)
        ofono_location_reporting_create(modem, 0, "telitmodem", data->chat);
 }
 =

+
+static void set_online_cb(gboolean ok, GAtResult *result, gpointer
user_data)
+{
+        struct cb_data *cbd =3D user_data;
+        ofono_modem_online_cb_t cb =3D cbd->cb;
+        struct ofono_error error;
+
+        decode_at_error(&error, g_at_result_final_response(result));
+        cb(&error, cbd->data);
+}
+
+static void he910_set_online(struct ofono_modem *modem, ofono_bool_t
online,
+                                ofono_modem_online_cb_t cb, void
*user_data)
+{
+        struct he910_data *data =3D ofono_modem_get_data(modem);
+        struct cb_data *cbd =3D cb_data_new(cb, user_data);
+        char const *command =3D online ? "AT+CFUN=3D1,0" : "AT+CFUN=3D4,0";
+
+        DBG("modem %p %s", modem, online ? "online" : "offline");
+
+        g_at_chat_send(data->chat, command, none_prefix, set_online_cb,
+                                                cbd, g_free);
+}
+
 static void he910_post_online(struct ofono_modem *modem)
 {
        struct he910_data *data =3D ofono_modem_get_data(modem);
@@ -388,6 +412,7 @@ static struct ofono_modem_driver he910_driver =3D {
        .enable         =3D he910_enable,
        .disable        =3D he910_disable,
        .pre_sim        =3D he910_pre_sim,
+        .set_online     =3D he910_set_online,
        .post_online    =3D he910_post_online,
 };
 =

-- =

1.9.1



--===============6976824811489125891==--

