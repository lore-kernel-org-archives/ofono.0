Content-Type: multipart/mixed; boundary="===============8553964967993129115=="
MIME-Version: 1.0
From: Kalle Valo <kalle.valo@canonical.com>
Subject: [PATCH 1/2] huawei: reopen the GPRS context when the modem closes it
 after PPP
Date: Tue, 29 Jun 2010 10:59:31 +0300
Message-ID: <20100629075931.18717.84414.stgit@potku.valot.fi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8553964967993129115==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Huawei always closes the tty port after PPP disconnect. Handle this in
huawei plugin, similarly as done with novatel. Now there's no need
to unplug the modem after disconnection.

Tested with Huawei E1552.

Based on a patch by Marcel Holtmann:

commit 0329a6ceaf8f69857cb5f8437b9db86ca327ef1d
Author: Marcel Holtmann <marcel@holtmann.org>
Date:   Mon Jun 7 02:36:12 2010 -0700

    Reopen the GPRS context channel when the modem closes it after PPP
---
 plugins/huawei.c |   86 +++++++++++++++++++++++++++++++++++++++-----------=
----
 1 files changed, 62 insertions(+), 24 deletions(-)

diff --git a/plugins/huawei.c b/plugins/huawei.c
index e2dfd1e..ae0139a 100644
--- a/plugins/huawei.c
+++ b/plugins/huawei.c
@@ -56,6 +56,8 @@ struct huawei_data {
 	GAtChat *pcui;
 	struct ofono_sim *sim;
 	gint sim_state;
+	struct ofono_gprs *gprs;
+	struct ofono_gprs_context *gc;
 };
 =

 static int huawei_probe(struct ofono_modem *modem)
@@ -196,42 +198,80 @@ static GAtChat *create_port(const char *device)
 	return chat;
 }
 =

-static int huawei_enable(struct ofono_modem *modem)
+static GAtChat *open_device(struct ofono_modem *modem,
+				const char *key, char *debug)
 {
 	struct huawei_data *data =3D ofono_modem_get_data(modem);
-	const char *modem_device, *pcui_device;
+	const char *device;
+	GAtChat *chat;
 =

-	DBG("%p", modem);
+	device =3D ofono_modem_get_string(modem, key);
+	if (device =3D=3D NULL)
+		return NULL;
 =

-	modem_device =3D ofono_modem_get_string(modem, "Modem");
-	pcui_device =3D ofono_modem_get_string(modem, "Pcui");
+	DBG("%s %s", key, device);
 =

-	if (modem_device =3D=3D NULL || pcui_device =3D=3D NULL)
-		return -EINVAL;
+	chat =3D create_port(device);
+	if (chat =3D=3D NULL)
+		return NULL;
+
+	g_at_chat_add_terminator(chat, "COMMAND NOT SUPPORT", -1, FALSE);
+
+	if (getenv("OFONO_AT_DEBUG"))
+		g_at_chat_set_debug(chat, huawei_debug, debug);
+
+	return chat;
+}
+
+static void huawei_disconnect(gpointer user_data)
+{
+	struct ofono_modem *modem =3D user_data;
+	struct huawei_data *data =3D ofono_modem_get_data(modem);
+
+	DBG("");
+
+	ofono_gprs_context_remove(data->gc);
 =

-	data->modem =3D create_port(modem_device);
+	g_at_chat_unref(data->modem);
+	data->modem =3D NULL;
 =

+	data->modem =3D open_device(modem, "Modem", "Modem:");
 	if (data->modem =3D=3D NULL)
-		return -EIO;
+		return;
 =

-	g_at_chat_add_terminator(data->modem, "COMMAND NOT SUPPORT", -1, FALSE);
+	g_at_chat_set_disconnect_function(data->modem,
+						huawei_disconnect, modem);
 =

-	if (getenv("OFONO_AT_DEBUG"))
-		g_at_chat_set_debug(data->modem, huawei_debug, "Modem:");
+	ofono_info("Reopened GPRS context channel");
+
+	data->gc =3D ofono_gprs_context_create(modem, 0, "atmodem",
+							data->modem);
+
+	if (data->gprs && data->gc)
+		ofono_gprs_add_context(data->gprs, data->gc);
+}
+
+static int huawei_enable(struct ofono_modem *modem)
+{
+	struct huawei_data *data =3D ofono_modem_get_data(modem);
+	const char *modem_device, *pcui_device;
+
+	DBG("%p", modem);
+
+	data->modem =3D open_device(modem, "Modem", "Modem:");
+	if (data->modem =3D=3D NULL)
+		return -EINVAL;
 =

-	data->pcui =3D create_port(pcui_device);
+	g_at_chat_set_disconnect_function(data->modem,
+						huawei_disconnect, modem);
 =

+	data->pcui =3D open_device(modem, "Pcui", "Pcui:");
 	if (data->pcui =3D=3D NULL) {
 		g_at_chat_unref(data->modem);
 		data->modem =3D NULL;
 		return -EIO;
 	}
 =

-	g_at_chat_add_terminator(data->pcui, "COMMAND NOT SUPPORT", -1, FALSE);
-
-	if (getenv("OFONO_AT_DEBUG"))
-		g_at_chat_set_debug(data->pcui, huawei_debug, "Pcui:");
-
 	data->sim_state =3D 0;
 =

 	g_at_chat_send(data->pcui, "ATE0", none_prefix, NULL, NULL, NULL);
@@ -293,9 +333,7 @@ static void huawei_pre_sim(struct ofono_modem *modem)
 static void huawei_post_sim(struct ofono_modem *modem)
 {
 	struct huawei_data *data =3D ofono_modem_get_data(modem);
-	struct ofono_gprs_context *gc;
 	struct ofono_netreg *netreg;
-	struct ofono_gprs *gprs;
 =

 	DBG("%p", modem);
 =

@@ -307,11 +345,11 @@ static void huawei_post_sim(struct ofono_modem *modem)
 								data->pcui);
 	ofono_ussd_create(modem, 0, "atmodem", data->pcui);
 =

-	gprs =3D ofono_gprs_create(modem, 0, "atmodem", data->pcui);
-	gc =3D ofono_gprs_context_create(modem, 0, "atmodem", data->modem);
+	data->gprs =3D ofono_gprs_create(modem, 0, "atmodem", data->pcui);
+	data->gc =3D ofono_gprs_context_create(modem, 0, "atmodem", data->modem);
 =

-	if (gprs && gc)
-		ofono_gprs_add_context(gprs, gc);
+	if (data->gprs && data->gc)
+		ofono_gprs_add_context(data->gprs, data->gc);
 }
 =

 static struct ofono_modem_driver huawei_driver =3D {


--===============8553964967993129115==--

