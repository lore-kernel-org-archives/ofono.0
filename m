Content-Type: multipart/mixed; boundary="===============4990119086983936103=="
MIME-Version: 1.0
From: Martin =?unknown-8bit?q?Hundeb=C3=B8ll?= <martin@geanix.com>
Subject: [PATCH 05/10] quectel: always print modem pointer in debug messages
Date: Wed, 03 Jul 2019 20:09:50 +0200
Message-ID: <20190703180955.18246-6-martin@geanix.com>
In-Reply-To: <20190703180955.18246-1-martin@geanix.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4990119086983936103==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 plugins/quectel.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/plugins/quectel.c b/plugins/quectel.c
index 50657265..3b57e06d 100644
--- a/plugins/quectel.c
+++ b/plugins/quectel.c
@@ -128,7 +128,7 @@ static void cpin_notify(GAtResult *result, void *user_d=
ata)
 =

 static void cpin_query(int ok, GAtResult *result, void *user_data)
 {
-	DBG("ok %d", ok);
+	DBG("%p ok %d", user_data, ok);
 =

 	if (ok)
 		cpin_notify(result, user_data);
@@ -139,7 +139,7 @@ static void cfun_enable(int ok, GAtResult *result, void=
 *user_data)
 	struct ofono_modem *modem =3D user_data;
 	struct quectel_data *data =3D ofono_modem_get_data(modem);
 =

-	DBG("ok %d", ok);
+	DBG("%p ok %d", modem, ok);
 =

 	if (!ok) {
 		g_at_chat_unref(data->aux);
@@ -163,7 +163,7 @@ static void cfun_query(int ok, GAtResult *result, void =
*user_data)
 	GAtResultIter iter;
 	int status;
 =

-	DBG("ok %d", ok);
+	DBG("%p ok %d", modem, ok);
 =

 	if (!ok)
 		return;
@@ -228,7 +228,7 @@ static void cfun_disable(int ok, GAtResult *result, voi=
d *user_data)
 	struct ofono_modem *modem =3D user_data;
 	struct quectel_data *data =3D ofono_modem_get_data(modem);
 =

-	DBG("");
+	DBG("%p", modem);
 =

 	g_at_chat_unref(data->aux);
 	data->aux =3D NULL;
@@ -264,6 +264,8 @@ static void set_online_cb(int ok, GAtResult *result, vo=
id *user_data)
 	ofono_modem_online_cb_t cb =3D cbd->cb;
 	struct ofono_error error;
 =

+	DBG("%p", user_data);
+
 	decode_at_error(&error, g_at_result_final_response(result));
 	cb(&error, cbd->data);
 }
@@ -320,6 +322,8 @@ static void quectel_post_online(struct ofono_modem *mod=
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


--===============4990119086983936103==--

