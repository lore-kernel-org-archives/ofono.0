Content-Type: multipart/mixed; boundary="===============0097728442924496561=="
MIME-Version: 1.0
From: Andres Salomon <dilinger@collabora.co.uk>
Subject: [PATCH] G1: move chat handling into enable callback
Date: Tue, 29 Sep 2009 23:53:59 -0400
Message-ID: <20090929235359.2b3dffd7@mycelium.queued.net>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0097728442924496561==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


This updates the g1 code to create the GAtChat object in the enable() callb=
ack,
and to unref it in the disable() callback.  This is more in line with what
the other plugins do, and as a bonus fixes a segfault when powering down
the G1 modem..

Signed-off-by: Andres Salomon <dilinger@collabora.co.uk>
---
 plugins/g1.c |   48 ++++++++++++++++++++++--------------------------
 1 files changed, 22 insertions(+), 26 deletions(-)

diff --git a/plugins/g1.c b/plugins/g1.c
index 5c53a12..0414f49 100644
--- a/plugins/g1.c
+++ b/plugins/g1.c
@@ -57,39 +57,14 @@ static void g1_debug(const char *str, void *data)
 /* Detect hardware, and initialize if found */
 static int g1_probe(struct ofono_modem *modem)
 {
-	GAtSyntax *syntax;
-	GAtChat *chat;
-	const char *device;
-
 	DBG("");
 =

-	device =3D ofono_modem_get_string(modem, "Device");
-	if (device =3D=3D NULL)
-		return -EINVAL;
-
-	syntax =3D g_at_syntax_new_gsm_permissive();
-	chat =3D g_at_chat_new_from_tty(device, syntax);
-	g_at_syntax_unref(syntax);
-
-	if (chat =3D=3D NULL)
-		return -EIO;
-
-	if (getenv("OFONO_AT_DEBUG") !=3D NULL)
-		g_at_chat_set_debug(chat, g1_debug, NULL);
-
-	ofono_modem_set_data(modem, chat);
-
 	return 0;
 }
 =

 static void g1_remove(struct ofono_modem *modem)
 {
-	GAtChat *chat =3D ofono_modem_get_data(modem);
-
 	DBG("");
-
-	ofono_modem_set_data(modem, NULL);
-	g_at_chat_unref(chat);
 }
 =

 static void cfun_set_on_cb(gboolean ok, GAtResult *result, gpointer user_d=
ata)
@@ -105,10 +80,28 @@ static void cfun_set_on_cb(gboolean ok, GAtResult *res=
ult, gpointer user_data)
 /* power up hardware */
 static int g1_enable(struct ofono_modem *modem)
 {
-	GAtChat *chat =3D ofono_modem_get_data(modem);
+	GAtSyntax *syntax;
+	GAtChat *chat;
+	const char *device;
 =

 	DBG("");
 =

+	device =3D ofono_modem_get_string(modem, "Device");
+	if (device =3D=3D NULL)
+		return -EINVAL;
+
+	syntax =3D g_at_syntax_new_gsm_permissive();
+	chat =3D g_at_chat_new_from_tty(device, syntax);
+	g_at_syntax_unref(syntax);
+
+	if (chat =3D=3D NULL)
+		return -EIO;
+
+	if (getenv("OFONO_AT_DEBUG") !=3D NULL)
+		g_at_chat_set_debug(chat, g1_debug, NULL);
+
+	ofono_modem_set_data(modem, chat);
+
 	/* ensure modem is in a known state; verbose on, echo/quiet off */
 	g_at_chat_send(chat, "ATE0Q0V1", NULL, NULL, NULL, NULL);
 =

@@ -137,6 +130,9 @@ static int g1_disable(struct ofono_modem *modem)
 	/* power down modem */
 	g_at_chat_send(chat, "AT+CFUN=3D0", NULL, cfun_set_off_cb, modem, NULL);
 =

+	g_at_chat_unref(chat);
+	ofono_modem_set_data(modem, NULL);
+
 	return 0;
 }
 =

-- =

1.6.4.3




--===============0097728442924496561==--

