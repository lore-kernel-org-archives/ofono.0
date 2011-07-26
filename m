Content-Type: multipart/mixed; boundary="===============9083019822580949719=="
MIME-Version: 1.0
From: Bertrand Aygon <bertrand.aygon@intel.com>
Subject: [PATCH_v2] speedupcdma: open 2 ttys, to use a dedicated one for PPP.
Date: Tue, 26 Jul 2011 11:24:57 +0200
Message-ID: <1311672297-11678-1-git-send-email-bertrand.aygon@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============9083019822580949719==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 plugins/speedupcdma.c |   99 ++++++++++++++++++++++++++++++++++++---------=
----
 1 files changed, 73 insertions(+), 26 deletions(-)

diff --git a/plugins/speedupcdma.c b/plugins/speedupcdma.c
index d11afb7..8cb4dae 100644
--- a/plugins/speedupcdma.c
+++ b/plugins/speedupcdma.c
@@ -40,7 +40,8 @@
 static const char *none_prefix[] =3D { NULL };
 =

 struct speedupcdma_data {
-	GAtChat *chat;
+	GAtChat *modem;
+	GAtChat *aux;
 };
 =

 static void speedupcdma_debug(const char *str, void *data)
@@ -84,8 +85,11 @@ static void cfun_enable(gboolean ok, GAtResult *result, =
gpointer user_data)
 	DBG("");
 =

 	if (!ok) {
-		g_at_chat_unref(data->chat);
-		data->chat =3D NULL;
+		g_at_chat_unref(data->modem);
+		data->modem =3D NULL;
+
+		g_at_chat_unref(data->aux);
+		data->aux =3D NULL;
 =

 		ofono_modem_set_powered(modem, FALSE);
 		return;
@@ -94,39 +98,70 @@ static void cfun_enable(gboolean ok, GAtResult *result,=
 gpointer user_data)
 	ofono_modem_set_powered(modem, TRUE);
 }
 =

-static int speedupcdma_enable(struct ofono_modem *modem)
+static GAtChat *create_port(const char *device)
 {
-	struct speedupcdma_data *data =3D ofono_modem_get_data(modem);
 	GAtSyntax *syntax;
 	GIOChannel *channel;
-	const char *modem_path;
-
-	modem_path =3D ofono_modem_get_string(modem, "Modem");
-	if (modem_path =3D=3D NULL)
-		return -EINVAL;
-
-	DBG("path is: %s", modem_path);
+	GAtChat *chat;
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
-
 	g_io_channel_unref(channel);
 =

-	if (data->chat =3D=3D NULL)
-		return -ENOMEM;
+	if (chat =3D=3D NULL)
+		return NULL;
+
+	return chat;
+}
+
+static GAtChat *open_device(struct ofono_modem *modem,
+				const char *key, char *debug)
+{
+	const char *device;
+	GAtChat *chat;
+
+	device =3D ofono_modem_get_string(modem, key);
+	if (device =3D=3D NULL)
+		return NULL;
+
+	DBG("%s %s", key, device);
+
+	chat =3D create_port(device);
+	if (chat =3D=3D NULL)
+		return NULL;
 =

 	if (getenv("OFONO_AT_DEBUG"))
-		g_at_chat_set_debug(data->chat, speedupcdma_debug, "Modem: ");
+		g_at_chat_set_debug(chat, speedupcdma_debug, debug);
+
+	return chat;
+}
+
+static int speedupcdma_enable(struct ofono_modem *modem)
+{
+	struct speedupcdma_data *data =3D ofono_modem_get_data(modem);
+
+	DBG("");
 =

-	g_at_chat_send(data->chat, "ATE0 +CMEE=3D1", none_prefix,
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
+	g_at_chat_send(data->aux, "ATE0 +CMEE=3D1", none_prefix,
 						NULL, NULL, NULL);
 =

-	g_at_chat_send(data->chat, "AT+CFUN=3D1", none_prefix,
+	g_at_chat_send(data->aux, "AT+CFUN=3D1", none_prefix,
 					cfun_enable, modem, NULL);
 =

 	return -EINPROGRESS;
@@ -139,8 +174,8 @@ static void cfun_disable(gboolean ok, GAtResult *result=
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
@@ -152,7 +187,19 @@ static int speedupcdma_disable(struct ofono_modem *mod=
em)
 =

 	DBG("%p", modem);
 =

-	g_at_chat_send(data->chat, "AT+CFUN=3D0", none_prefix,
+	if (data->modem) {
+		g_at_chat_cancel_all(data->modem);
+		g_at_chat_unregister_all(data->modem);
+		g_at_chat_unref(data->modem);
+		data->modem =3D NULL;
+	}
+
+	if (data->aux =3D=3D NULL)
+		return 0;
+
+	g_at_chat_cancel_all(data->aux);
+	g_at_chat_unregister_all(data->aux);
+	g_at_chat_send(data->aux, "AT+CFUN=3D0", none_prefix,
 					cfun_disable, modem, NULL);
 =

 	return -EINPROGRESS;
@@ -164,7 +211,7 @@ static void speedupcdma_pre_sim(struct ofono_modem *mod=
em)
 =

 	DBG("%p", modem);
 =

-	ofono_devinfo_create(modem, 0, "cdmamodem", data->chat);
+	ofono_devinfo_create(modem, 0, "cdmamodem", data->aux);
 }
 =

 static void speedupcdma_post_sim(struct ofono_modem *modem)
@@ -178,7 +225,7 @@ static void speedupcdma_post_online(struct ofono_modem =
*modem)
 =

 	DBG("%p", modem);
 =

-	ofono_cdma_connman_create(modem, 0, "cdmamodem", data->chat);
+	ofono_cdma_connman_create(modem, 1, "cdmamodem", data->modem);
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

--===============9083019822580949719==--

