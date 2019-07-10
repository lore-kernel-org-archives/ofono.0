Content-Type: multipart/mixed; boundary="===============6024946024417549198=="
MIME-Version: 1.0
From: Martin =?unknown-8bit?q?Hundeb=C3=B8ll?= <martin@geanix.com>
Subject: [PATCHv3 4/9] quectel: replace glib uses with ell
Date: Wed, 10 Jul 2019 23:51:43 +0200
Message-ID: <20190710215148.78083-5-martin@geanix.com>
In-Reply-To: <20190710215148.78083-1-martin@geanix.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6024946024417549198==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---

Changes since v1:
 * don't use l_free in plugin callback

 plugins/quectel.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/plugins/quectel.c b/plugins/quectel.c
index faad16cc..6e93f45a 100644
--- a/plugins/quectel.c
+++ b/plugins/quectel.c
@@ -26,7 +26,7 @@
 #include <errno.h>
 #include <stdlib.h>
 =

-#include <glib.h>
+#include <ell/ell.h>
 #include <gatchat.h>
 #include <gattty.h>
 =

@@ -67,9 +67,7 @@ static int quectel_probe(struct ofono_modem *modem)
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

@@ -88,7 +86,7 @@ static void quectel_remove(struct ofono_modem *modem)
 	ofono_modem_set_data(modem, NULL);
 	g_at_chat_unref(data->aux);
 	g_at_chat_unref(data->modem);
-	g_free(data);
+	l_free(data);
 }
 =

 static void cpin_notify(GAtResult *result, gpointer user_data)
-- =

2.22.0


--===============6024946024417549198==--

