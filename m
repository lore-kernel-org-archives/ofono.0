Content-Type: multipart/mixed; boundary="===============5359940978739619577=="
MIME-Version: 1.0
From: Bertrand Aygon <bertrand.aygon@intel.com>
Subject: [PATCH_v2] huaweicdma: open 2 ttys, to use a dedicated one for PPP.
Date: Wed, 27 Jul 2011 10:07:38 +0200
Message-ID: <1311754058-16411-1-git-send-email-bertrand.aygon@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5359940978739619577==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 plugins/huaweicdma.c |  106 +++++++++++++++++++++++++++++++++++++++++-----=
----
 1 files changed, 87 insertions(+), 19 deletions(-)

diff --git a/plugins/huaweicdma.c b/plugins/huaweicdma.c
index 7288850..dccf17e 100644
--- a/plugins/huaweicdma.c
+++ b/plugins/huaweicdma.c
@@ -38,7 +38,8 @@
 #include <ofono/log.h>
 =

 struct huaweicdma_data {
-	GAtChat *chat;
+	GAtChat *modem;
+	GAtChat *pcui;
 };
 =

 static void huaweicdma_debug(const char *str, void *data)
@@ -71,39 +72,97 @@ static void huaweicdma_remove(struct ofono_modem *modem)
 =

 	ofono_modem_set_data(modem, NULL);
 =

-	g_at_chat_unref(data->chat);
-
 	g_free(data);
 }
 =

-static int huaweicdma_enable(struct ofono_modem *modem)
+static void cfun_enable(gboolean ok, GAtResult *result, gpointer user_data)
 {
+	struct ofono_modem *modem =3D user_data;
 	struct huaweicdma_data *data =3D ofono_modem_get_data(modem);
-	GAtSyntax *syntax;
-	GIOChannel *channel;
+
+	DBG("");
+
+	if (!ok) {
+		g_at_chat_unref(data->modem);
+		data->modem =3D NULL;
+
+		g_at_chat_unref(data->pcui);
+		data->pcui =3D NULL;
+	}
+
+	ofono_modem_set_powered(modem, ok);
+}
+
+static GAtChat *open_device(struct ofono_modem *modem,
+				const char *key, char *debug)
+{
 	const char *device;
+	GIOChannel *channel;
+	GAtSyntax *syntax;
+	GAtChat *chat;
 =

-	device =3D ofono_modem_get_string(modem, "Device");
+	device =3D ofono_modem_get_string(modem, key);
 	if (device =3D=3D NULL)
-		return -EINVAL;
+		return NULL;
+
+	DBG("%s %s", key, device);
 =

 	channel =3D g_at_tty_open(device, NULL);
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
-		g_at_chat_set_debug(data->chat, huaweicdma_debug, "Device: ");
+		g_at_chat_set_debug(chat, huaweicdma_debug, debug);
 =

-	return 0;
+	return chat;
+}
+
+static int huaweicdma_enable(struct ofono_modem *modem)
+{
+	struct huaweicdma_data *data =3D ofono_modem_get_data(modem);
+
+	DBG("");
+
+	data->modem =3D open_device(modem, "Modem", "Modem: ");
+	if (data->modem =3D=3D NULL)
+		return -EINVAL;
+
+	data->pcui =3D open_device(modem, "Pcui", "PCUI: ");
+	if (data->pcui =3D=3D NULL) {
+		g_at_chat_unref(data->modem);
+		data->modem =3D NULL;
+		return -EIO;
+	}
+
+	g_at_chat_send(data->modem, "ATE0 &C0 +CMEE=3D1", NULL, NULL, NULL, NULL);
+	g_at_chat_send(data->pcui, "ATE0 &C0 +CMEE=3D1", NULL, NULL, NULL, NULL);
+
+	g_at_chat_send(data->pcui, "AT+CFUN=3D1", NULL, cfun_enable, modem, NULL);
+
+	return -EINPROGRESS;
+}
+
+static void cfun_disable(gboolean ok, GAtResult *result, gpointer user_dat=
a)
+{
+	struct ofono_modem *modem =3D user_data;
+	struct huaweicdma_data *data =3D ofono_modem_get_data(modem);
+
+	DBG("");
+
+	g_at_chat_unref(data->pcui);
+	data->pcui =3D NULL;
+
+	if (ok)
+		ofono_modem_set_powered(modem, FALSE);
 }
 =

 static int huaweicdma_disable(struct ofono_modem *modem)
@@ -112,10 +171,19 @@ static int huaweicdma_disable(struct ofono_modem *mod=
em)
 =

 	DBG("%p", modem);
 =

-	g_at_chat_unref(data->chat);
-	data->chat =3D NULL;
+	g_at_chat_cancel_all(data->modem);
+	g_at_chat_unregister_all(data->modem);
 =

-	return 0;
+	g_at_chat_unref(data->modem);
+	data->modem =3D NULL;
+
+	g_at_chat_cancel_all(data->pcui);
+	g_at_chat_unregister_all(data->pcui);
+
+	g_at_chat_send(data->pcui, "AT+CFUN=3D0", NULL, cfun_disable,
+				modem, NULL);
+
+	return -EINPROGRESS;
 }
 =

 static void huaweicdma_pre_sim(struct ofono_modem *modem)
@@ -124,7 +192,7 @@ static void huaweicdma_pre_sim(struct ofono_modem *mode=
m)
 =

 	DBG("%p", modem);
 =

-	ofono_devinfo_create(modem, 0, "cdmamodem", data->chat);
+	ofono_devinfo_create(modem, 0, "cdmamodem", data->pcui);
 }
 =

 static void huaweicdma_post_sim(struct ofono_modem *modem)
@@ -138,7 +206,7 @@ static void huaweicdma_post_online(struct ofono_modem *=
modem)
 =

 	DBG("%p", modem);
 =

-	ofono_cdma_connman_create(modem, 0, "cdmamodem", data->chat);
+	ofono_cdma_connman_create(modem, 0, "cdmamodem", data->modem);
 }
 =

 static struct ofono_modem_driver huaweicdma_driver =3D {
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

--===============5359940978739619577==--

