Content-Type: multipart/mixed; boundary="===============0705230777471015413=="
MIME-Version: 1.0
From: Martin =?unknown-8bit?q?Hundeb=C3=B8ll?= <martin@geanix.com>
Subject: [PATCH 07/10] quectel: replace glib uses with ell
Date: Wed, 03 Jul 2019 20:09:52 +0200
Message-ID: <20190703180955.18246-8-martin@geanix.com>
In-Reply-To: <20190703180955.18246-1-martin@geanix.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0705230777471015413==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 plugins/quectel.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/plugins/quectel.c b/plugins/quectel.c
index 83197991..3c6b9d9f 100644
--- a/plugins/quectel.c
+++ b/plugins/quectel.c
@@ -27,7 +27,7 @@
 #include <stdlib.h>
 #include <stdbool.h>
 =

-#include <glib.h>
+#include <ell/ell.h>
 #include <gatchat.h>
 #include <gattty.h>
 =

@@ -68,9 +68,7 @@ static int quectel_probe(struct ofono_modem *modem)
 =

 	DBG("%p", modem);
 =

-	data =3D g_try_new0(struct quectel_data, 1);
-	if (data =3D=3D NULL)
-		return -ENOMEM;
+	data =3D l_new(struct quectel_data, 1);
 =

 	ofono_modem_set_data(modem, data);
 =

@@ -89,7 +87,7 @@ static void quectel_remove(struct ofono_modem *modem)
 	ofono_modem_set_data(modem, NULL);
 	g_at_chat_unref(data->aux);
 	g_at_chat_unref(data->modem);
-	g_free(data);
+	l_free(data);
 }
 =

 static void cpin_notify(GAtResult *result, void *user_data)
@@ -281,7 +279,7 @@ static void quectel_set_online(struct ofono_modem *mode=
m, int online,
 =

 	CALLBACK_WITH_FAILURE(cb, cbd->data);
 =

-	g_free(cbd);
+	l_free(cbd);
 }
 =

 static void quectel_pre_sim(struct ofono_modem *modem)
-- =

2.22.0


--===============0705230777471015413==--

