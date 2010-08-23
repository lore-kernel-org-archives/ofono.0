Content-Type: multipart/mixed; boundary="===============7756852266091955340=="
MIME-Version: 1.0
From: =?unknown-8bit?q?Jo=C3=A3o?= Paulo Rechi Vita <jprvita@profusion.mobi>
Subject: [PATCH] hfp: fix typo
Date: Mon, 23 Aug 2010 15:04:49 -0300
Message-ID: <1282586689-6776-1-git-send-email-jprvita@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7756852266091955340==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 plugins/hfp.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/plugins/hfp.c b/plugins/hfp.c
index 0337891..9a892db 100644
--- a/plugins/hfp.c
+++ b/plugins/hfp.c
@@ -83,7 +83,7 @@ static void clear_data(struct ofono_modem *modem)
 	memset(data->cind_pos, 0, sizeof(data->cind_pos));
 }
 =

-static void sevice_level_conn_established(struct ofono_modem *modem)
+static void service_level_conn_established(struct ofono_modem *modem)
 {
 	DBusMessage *msg;
 	struct hfp_data *data =3D ofono_modem_get_data(modem);
@@ -158,7 +158,7 @@ static void chld_cb(gboolean ok, GAtResult *result, gpo=
inter user_data)
 =

 	data->ag_mpty_features =3D ag_mpty_feature;
 =

-	sevice_level_conn_established(modem);
+	service_level_conn_established(modem);
 }
 =

 static void cmer_cb(gboolean ok, GAtResult *result, gpointer user_data)
@@ -175,7 +175,7 @@ static void cmer_cb(gboolean ok, GAtResult *result, gpo=
inter user_data)
 		g_at_chat_send(data->chat, "AT+CHLD=3D?", chld_prefix,
 			chld_cb, modem, NULL);
 	else
-		sevice_level_conn_established(modem);
+		service_level_conn_established(modem);
 }
 =

 static void cind_status_cb(gboolean ok, GAtResult *result,
-- =

1.7.0.4


--===============7756852266091955340==--

