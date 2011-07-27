Content-Type: multipart/mixed; boundary="===============0603769496909650244=="
MIME-Version: 1.0
From: Bertrand Aygon <bertrand.aygon@intel.com>
Subject: [PATCH_v3] speedupcdma: open 2 ttys, to use a dedicated one for PPP.
Date: Wed, 27 Jul 2011 10:06:57 +0200
Message-ID: <1311754017-16247-1-git-send-email-bertrand.aygon@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0603769496909650244==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 plugins/speedupcdma.c |   91 +++++++++++++++++++++++++++++++--------------=
---
 1 files changed, 59 insertions(+), 32 deletions(-)

diff --git a/plugins/speedupcdma.c b/plugins/speedupcdma.c
index d11afb7..67bb617 100644
--- a/plugins/speedupcdma.c
+++ b/plugins/speedupcdma.c
@@ -37,10 +37,9 @@
 #include <ofono/cdma-connman.h>
 #include <ofono/log.h>
 =

-static const char *none_prefix[] =3D { NULL };
-
 struct speedupcdma_data {
-	GAtChat *chat;
+	GAtChat *modem;
+	GAtChat *aux;
 };
 =

 static void speedupcdma_debug(const char *str, void *data)
@@ -84,50 +83,70 @@ static void cfun_enable(gboolean ok, GAtResult *result,=
 gpointer user_data)
 	DBG("");
 =

 	if (!ok) {
-		g_at_chat_unref(data->chat);
-		data->chat =3D NULL;
+		g_at_chat_unref(data->modem);
+		data->modem =3D NULL;
 =

-		ofono_modem_set_powered(modem, FALSE);
-		return;
+		g_at_chat_unref(data->aux);
+		data->aux =3D NULL;
 	}
 =

-	ofono_modem_set_powered(modem, TRUE);
+	ofono_modem_set_powered(modem, ok);
 }
 =

-static int speedupcdma_enable(struct ofono_modem *modem)
+static GAtChat *open_device(struct ofono_modem *modem,
+				const char *key, char *debug)
 {
-	struct speedupcdma_data *data =3D ofono_modem_get_data(modem);
-	GAtSyntax *syntax;
+	const char *device;
 	GIOChannel *channel;
-	const char *modem_path;
+	GAtSyntax *syntax;
+	GAtChat *chat;
 =

-	modem_path =3D ofono_modem_get_string(modem, "Modem");
-	if (modem_path =3D=3D NULL)
-		return -EINVAL;
+	device =3D ofono_modem_get_string(modem, key);
+	if (device =3D=3D NULL)
+		return NULL;
 =

-	DBG("path is: %s", modem_path);
+	DBG("%s %s", key, device);
 =

-	channel =3D g_at_tty_open(modem_path, NULL);
+	channel =3D g_at_tty_open(device, NULL);
 	if (channel =3D=3D NULL)
-		return -EIO;
+		return NULL;
 =

 	syntax =3D g_at_syntax_new_gsm_permissive();
-	data->chat =3D g_at_chat_new(channel, syntax);
+	chat =3D g_at_chat_new(channel, syntax);
 	g_at_syntax_unref(syntax);
 =

 	g_io_channel_unref(channel);
 =

-	if (data->chat =3D=3D NULL)
-		return -ENOMEM;
+	if (chat =3D=3D NULL)
+		return NULL;
 =

 	if (getenv("OFONO_AT_DEBUG"))
-		g_at_chat_set_debug(data->chat, speedupcdma_debug, "Modem: ");
+		g_at_chat_set_debug(chat, speedupcdma_debug, debug);
 =

-	g_at_chat_send(data->chat, "ATE0 +CMEE=3D1", none_prefix,
-						NULL, NULL, NULL);
+	return chat;
+}
 =

-	g_at_chat_send(data->chat, "AT+CFUN=3D1", none_prefix,
-					cfun_enable, modem, NULL);
+static int speedupcdma_enable(struct ofono_modem *modem)
+{
+	struct speedupcdma_data *data =3D ofono_modem_get_data(modem);
+
+	DBG("");
+
+	data->modem =3D open_device(modem, "Modem", "Modem: ");
+	if (data->modem =3D=3D NULL)
+		return -EINVAL;
+
+	data->aux =3D open_device(modem, "Aux", "Aux: ");
+	if (data->aux =3D=3D NULL) {
+		g_at_chat_unref(data->modem);
+		data->modem =3D NULL;
+		return -EIO;
+	}
+
+	g_at_chat_send(data->modem, "ATE0 &C0 +CMEE=3D1", NULL, NULL, NULL, NULL);
+	g_at_chat_send(data->aux, "ATE0 &C0 +CMEE=3D1", NULL, NULL, NULL, NULL);
+
+	g_at_chat_send(data->aux, "AT+CFUN=3D1", NULL, cfun_enable, modem, NULL);
 =

 	return -EINPROGRESS;
 }
@@ -139,8 +158,8 @@ static void cfun_disable(gboolean ok, GAtResult *result=
, gpointer user_data)
 =

 	DBG("");
 =

-	g_at_chat_unref(data->chat);
-	data->chat =3D NULL;
+	g_at_chat_unref(data->aux);
+	data->aux =3D NULL;
 =

 	if (ok)
 		ofono_modem_set_powered(modem, FALSE);
@@ -152,8 +171,16 @@ static int speedupcdma_disable(struct ofono_modem *mod=
em)
 =

 	DBG("%p", modem);
 =

-	g_at_chat_send(data->chat, "AT+CFUN=3D0", none_prefix,
-					cfun_disable, modem, NULL);
+	g_at_chat_cancel_all(data->modem);
+	g_at_chat_unregister_all(data->modem);
+
+	g_at_chat_unref(data->modem);
+	data->modem =3D NULL;
+
+	g_at_chat_cancel_all(data->aux);
+	g_at_chat_unregister_all(data->aux);
+
+	g_at_chat_send(data->aux, "AT+CFUN=3D0", NULL, cfun_disable, modem, NULL);
 =

 	return -EINPROGRESS;
 }
@@ -164,7 +191,7 @@ static void speedupcdma_pre_sim(struct ofono_modem *mod=
em)
 =

 	DBG("%p", modem);
 =

-	ofono_devinfo_create(modem, 0, "cdmamodem", data->chat);
+	ofono_devinfo_create(modem, 0, "cdmamodem", data->aux);
 }
 =

 static void speedupcdma_post_sim(struct ofono_modem *modem)
@@ -178,7 +205,7 @@ static void speedupcdma_post_online(struct ofono_modem =
*modem)
 =

 	DBG("%p", modem);
 =

-	ofono_cdma_connman_create(modem, 0, "cdmamodem", data->chat);
+	ofono_cdma_connman_create(modem, 0, "cdmamodem", data->modem);
 }
 =

 static struct ofono_modem_driver speedupcdma_driver =3D {
-- =

1.7.4.1

---------------------------------------------------------------------
Intel Corporation SAS (French simplified joint stock company)
Registered headquarters: "Les Montalets"- 2, rue de Paris, =

92196 Meudon Cedex, France
Registration Number:  302 456 199 R.C.S. NANTERRE
Capital: 4,572,000 Euros

This e-mail and any attachments may contain confidential material for
the sole use of the intended recipient(s). Any review or distribution
by others is strictly prohibited. If you are not the intended
recipient, please contact the sender and delete all copies.

--===============0603769496909650244==--

