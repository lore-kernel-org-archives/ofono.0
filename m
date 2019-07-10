Content-Type: multipart/mixed; boundary="===============1846600052361903887=="
MIME-Version: 1.0
From: Martin =?unknown-8bit?q?Hundeb=C3=B8ll?= <martin@geanix.com>
Subject: [PATCHv3 2/9] quectel: always print modem pointer in debug messages
Date: Wed, 10 Jul 2019 23:51:41 +0200
Message-ID: <20190710215148.78083-3-martin@geanix.com>
In-Reply-To: <20190710215148.78083-1-martin@geanix.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1846600052361903887==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 plugins/quectel.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/plugins/quectel.c b/plugins/quectel.c
index 37969097..e1a5ffa4 100644
--- a/plugins/quectel.c
+++ b/plugins/quectel.c
@@ -127,7 +127,7 @@ static void cpin_notify(GAtResult *result, gpointer use=
r_data)
 =

 static void cpin_query(gboolean ok, GAtResult *result, gpointer user_data)
 {
-	DBG("ok %d", ok);
+	DBG("%p ok %d", user_data, ok);
 =

 	if (ok)
 		cpin_notify(result, user_data);
@@ -138,7 +138,7 @@ static void cfun_enable(gboolean ok, GAtResult *result,=
 gpointer user_data)
 	struct ofono_modem *modem =3D user_data;
 	struct quectel_data *data =3D ofono_modem_get_data(modem);
 =

-	DBG("ok %d", ok);
+	DBG("%p ok %d", modem, ok);
 =

 	if (!ok) {
 		g_at_chat_unref(data->aux);
@@ -162,7 +162,7 @@ static void cfun_query(gboolean ok, GAtResult *result, =
gpointer user_data)
 	GAtResultIter iter;
 	int status;
 =

-	DBG("ok %d", ok);
+	DBG("%p ok %d", modem, ok);
 =

 	if (!ok)
 		return;
@@ -227,7 +227,7 @@ static void cfun_disable(gboolean ok, GAtResult *result=
, gpointer user_data)
 	struct ofono_modem *modem =3D user_data;
 	struct quectel_data *data =3D ofono_modem_get_data(modem);
 =

-	DBG("");
+	DBG("%p", modem);
 =

 	g_at_chat_unref(data->aux);
 	data->aux =3D NULL;
@@ -263,6 +263,8 @@ static void set_online_cb(gboolean ok, GAtResult *resul=
t, gpointer user_data)
 	ofono_modem_online_cb_t cb =3D cbd->cb;
 	struct ofono_error error;
 =

+	DBG("%p", user_data);
+
 	decode_at_error(&error, g_at_result_final_response(result));
 	cb(&error, cbd->data);
 }
@@ -319,6 +321,8 @@ static void quectel_post_online(struct ofono_modem *mod=
em)
 {
 	struct quectel_data *data =3D ofono_modem_get_data(modem);
 =

+	DBG("%p", modem);
+
 	ofono_netreg_create(modem, 0, "atmodem", data->aux);
 }
 =

-- =

2.22.0


--===============1846600052361903887==--

