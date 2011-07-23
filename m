Content-Type: multipart/mixed; boundary="===============1432797801619133958=="
MIME-Version: 1.0
From: Bertrand Aygon <bertrand.aygon@intel.com>
Subject: [PATCH] huaweicdma: rework driver to match huawei driver and not
 nokiacdma.
Date: Sat, 23 Jul 2011 06:52:11 +0200
Message-ID: <1311396731-16157-1-git-send-email-bertrand.aygon@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1432797801619133958==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 plugins/huaweicdma.c |  135 +++++++++++++++++++++++++++++++++++++++++++---=
----
 1 files changed, 116 insertions(+), 19 deletions(-)

diff --git a/plugins/huaweicdma.c b/plugins/huaweicdma.c
index 4f45fec..aacad28 100644
--- a/plugins/huaweicdma.c
+++ b/plugins/huaweicdma.c
@@ -40,8 +40,12 @@
 =

 #include <drivers/atmodem/atutil.h>
 =

+static const char *none_prefix[] =3D { NULL };
+static const char *cfun_prefix[] =3D { "+CFUN:", NULL };
+
 struct huaweicdma_data {
-	GAtChat *chat;
+	GAtChat *modem;
+	GAtChat *pcui;
 };
 =

 static void huaweicdma_debug(const char *str, void *data)
@@ -74,39 +78,129 @@ static void huaweicdma_remove(struct ofono_modem *mode=
m)
 =

 	ofono_modem_set_data(modem, NULL);
 =

-	g_at_chat_unref(data->chat);
+	if (data->modem)
+		g_at_chat_unref(data->modem);
 =

+	g_at_chat_unref(data->pcui);
 	g_free(data);
 }
 =

-static int huaweicdma_enable(struct ofono_modem *modem)
+static void cfun_enable(gboolean ok, GAtResult *result, gpointer user_data)
+{
+	struct ofono_modem *modem =3D user_data;
+	struct huaweicdma_data *data =3D ofono_modem_get_data(modem);
+
+	DBG("");
+
+	if (!ok) {
+		g_at_chat_unref(data->modem);
+		data->modem =3D NULL;
+
+		g_at_chat_unref(data->pcui);
+		data->pcui =3D NULL;
+
+		ofono_modem_set_powered(modem, FALSE);
+		return;
+	}
+
+	ofono_modem_set_powered(modem, TRUE);
+}
+
+static void cfun_query(gboolean ok, GAtResult *result, gpointer user_data)
 {
+	struct ofono_modem *modem =3D user_data;
 	struct huaweicdma_data *data =3D ofono_modem_get_data(modem);
+	GAtResultIter iter;
+	int status;
+
+	DBG("%d", ok);
+
+	if (!ok)
+		return;
+
+	g_at_result_iter_init(&iter, result);
+
+	if (g_at_result_iter_next(&iter, "+CFUN:") =3D=3D FALSE)
+		return;
+
+	g_at_result_iter_next_number(&iter, &status);
+
+	if (status !=3D 1) {
+		g_at_chat_send(data->pcui, "AT+CFUN=3D1", none_prefix,
+				cfun_enable, modem, NULL);
+		return;
+	}
+
+	ofono_modem_set_powered(modem, TRUE);
+}
+
+static GAtChat *create_port(const char *device)
+{
 	GAtSyntax *syntax;
 	GIOChannel *channel;
-	const char *device;
-
-	device =3D ofono_modem_get_string(modem, "Device");
-	if (device =3D=3D NULL)
-		return -EINVAL;
+	GAtChat *chat;
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
+
+	g_at_chat_add_terminator(chat, "COMMAND NOT SUPPORT", -1, FALSE);
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
+	g_at_chat_send(data->pcui, "ATE0 +CMEE=3D1", none_prefix,
+						NULL, NULL, NULL);
+
+	g_at_chat_send(data->pcui, "AT+CFUN?", cfun_prefix,
+					cfun_query, modem, NULL);
+
+	return -EINPROGRESS;
 }
 =

 static int huaweicdma_disable(struct ofono_modem *modem)
@@ -115,8 +209,11 @@ static int huaweicdma_disable(struct ofono_modem *mode=
m)
 =

 	DBG("%p", modem);
 =

-	g_at_chat_unref(data->chat);
-	data->chat =3D NULL;
+	g_at_chat_unref(data->modem);
+	data->modem =3D NULL;
+
+	g_at_chat_unref(data->pcui);
+	data->pcui =3D NULL;
 =

 	return 0;
 }
@@ -127,7 +224,7 @@ static void huaweicdma_pre_sim(struct ofono_modem *mode=
m)
 =

 	DBG("%p", modem);
 =

-	ofono_devinfo_create(modem, 0, "cdmamodem", data->chat);
+	ofono_devinfo_create(modem, 0, "cdmamodem", data->pcui);
 }
 =

 static void huaweicdma_post_sim(struct ofono_modem *modem)
@@ -141,7 +238,7 @@ static void huaweicdma_post_online(struct ofono_modem *=
modem)
 =

 	DBG("%p", modem);
 =

-	ofono_cdma_connman_create(modem, 0, "cdmamodem", data->chat);
+	ofono_cdma_connman_create(modem, 0, "cdmamodem", data->pcui);
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

--===============1432797801619133958==--

