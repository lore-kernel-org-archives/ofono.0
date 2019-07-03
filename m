Content-Type: multipart/mixed; boundary="===============7807881810173504912=="
MIME-Version: 1.0
From: Martin =?unknown-8bit?q?Hundeb=C3=B8ll?= <martin@geanix.com>
Subject: [PATCH 06/10] quectel: unwrap call to at_util_open_device()
Date: Wed, 03 Jul 2019 20:09:51 +0200
Message-ID: <20190703180955.18246-7-martin@geanix.com>
In-Reply-To: <20190703180955.18246-1-martin@geanix.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7807881810173504912==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 plugins/quectel.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/plugins/quectel.c b/plugins/quectel.c
index 3b57e06d..83197991 100644
--- a/plugins/quectel.c
+++ b/plugins/quectel.c
@@ -92,12 +92,6 @@ static void quectel_remove(struct ofono_modem *modem)
 	g_free(data);
 }
 =

-static GAtChat *open_device(struct ofono_modem *modem, const char *key,
-				char *debug)
-{
-	return at_util_open_device(modem, key, quectel_debug, debug, NULL);
-}
-
 static void cpin_notify(GAtResult *result, void *user_data)
 {
 	struct ofono_modem *modem =3D user_data;
@@ -200,11 +194,13 @@ static int quectel_enable(struct ofono_modem *modem)
 =

 	DBG("%p", modem);
 =

-	data->modem =3D open_device(modem, "Modem", "Modem: ");
+	data->modem =3D at_util_open_device(modem, "Modem", quectel_debug,
+						"Modem: ", NULL);
 	if (data->modem =3D=3D NULL)
 		return -EINVAL;
 =

-	data->aux =3D open_device(modem, "Aux", "Aux: ");
+	data->aux =3D at_util_open_device(modem, "Aux", quectel_debug, "Aux: ",
+					NULL);
 	if (data->aux =3D=3D NULL) {
 		g_at_chat_unref(data->modem);
 		data->modem =3D NULL;
-- =

2.22.0


--===============7807881810173504912==--

