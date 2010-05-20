Content-Type: multipart/mixed; boundary="===============7151535113137419397=="
MIME-Version: 1.0
From: Kalle Valo <kalle.valo@canonical.com>
Subject: [PATCH v4 1/3] huawei: detect possible secondary device
Date: Thu, 20 May 2010 11:04:08 +0300
Message-ID: <20100520080408.17288.52965.stgit@potku.valot.fi>
In-Reply-To: <20100520080214.17288.7485.stgit@potku.valot.fi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7151535113137419397==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


---

 plugins/huawei.c |   68 ++++++++++++++++++++++++++++++++++++++++++++------=
----
 plugins/udev.c   |   61 ++++++++++++++++++++++++++++++++++++++++++------
 2 files changed, 108 insertions(+), 21 deletions(-)

diff --git a/plugins/huawei.c b/plugins/huawei.c
index df4d177..2a95cf6 100644
--- a/plugins/huawei.c
+++ b/plugins/huawei.c
@@ -45,7 +45,7 @@
 #include <drivers/atmodem/vendor.h>
 =

 struct huawei_data {
-	GAtChat *chat;
+	GAtChat *chat, *event;
 };
 =

 static int huawei_probe(struct ofono_modem *modem)
@@ -72,6 +72,7 @@ static void huawei_remove(struct ofono_modem *modem)
 	ofono_modem_set_data(modem, NULL);
 =

 	g_at_chat_unref(data->chat);
+	g_at_chat_unref(data->event);
 	g_free(data);
 }
 =

@@ -80,6 +81,11 @@ static void huawei_debug(const char *str, void *user_dat=
a)
 	ofono_info("%s", str);
 }
 =

+static void huawei_event_debug(const char *str, void *user_data)
+{
+	ofono_info("* %s", str);
+}
+
 static void cfun_enable(gboolean ok, GAtResult *result, gpointer user_data)
 {
 	struct ofono_modem *modem =3D user_data;
@@ -90,29 +96,43 @@ static void cfun_enable(gboolean ok, GAtResult *result,=
 gpointer user_data)
 		ofono_modem_set_powered(modem, TRUE);
 }
 =

-static int huawei_enable(struct ofono_modem *modem)
+static GAtChat *create_port(const char *device)
 {
-	struct huawei_data *data =3D ofono_modem_get_data(modem);
 	GAtSyntax *syntax;
 	GIOChannel *channel;
-	const char *device;
-
-	DBG("%p", modem);
-
-	device =3D ofono_modem_get_string(modem, "Device");
-	if (!device)
-			return -EINVAL;
+	GAtChat *chat;
 =

 	channel =3D g_at_tty_open(device, NULL);
 	if (!channel)
-		return -EIO;
+		return NULL;
 =

 	syntax =3D g_at_syntax_new_gsm_permissive();
-	data->chat =3D g_at_chat_new(channel, syntax);
+	chat =3D g_at_chat_new(channel, syntax);
 	g_at_syntax_unref(syntax);
 	g_io_channel_unref(channel);
 =

-	if (!data->chat)
+	if (!chat)
+		return NULL;
+
+	return chat;
+}
+
+static int huawei_enable(struct ofono_modem *modem)
+{
+	struct huawei_data *data =3D ofono_modem_get_data(modem);
+	const char *modem_device, *event_device;
+
+	DBG("%p", modem);
+
+	modem_device =3D ofono_modem_get_string(modem, "Device");
+	event_device =3D ofono_modem_get_string(modem, "SecondaryDevice");
+
+	if (modem_device =3D=3D NULL || event_device =3D=3D NULL)
+		return -EINVAL;
+
+	data->chat =3D create_port(modem_device);
+
+	if (data->chat =3D=3D NULL)
 		return -EIO;
 =

 	g_at_chat_add_terminator(data->chat, "COMMAND NOT SUPPORT", -1, FALSE);
@@ -120,6 +140,20 @@ static int huawei_enable(struct ofono_modem *modem)
 	if (getenv("OFONO_AT_DEBUG"))
 		g_at_chat_set_debug(data->chat, huawei_debug, NULL);
 =

+	data->event =3D create_port(modem_device);
+
+	if (data->event =3D=3D NULL) {
+		g_at_chat_unref(data->chat);
+		data->chat =3D NULL;
+		return -EIO;
+	}
+
+	g_at_chat_add_terminator(data->event, "COMMAND NOT SUPPORT", -1,
+					FALSE);
+
+	if (getenv("OFONO_AT_DEBUG"))
+		g_at_chat_set_debug(data->event, huawei_event_debug, NULL);
+
 	g_at_chat_send(data->chat, "ATE0", NULL, NULL, NULL, NULL);
 =

 	g_at_chat_send(data->chat, "AT+CFUN=3D1", NULL,
@@ -138,6 +172,9 @@ static void cfun_disable(gboolean ok, GAtResult *result=
, gpointer user_data)
 	g_at_chat_unref(data->chat);
 	data->chat =3D NULL;
 =

+	g_at_chat_unref(data->event);
+	data->event =3D NULL;
+
 	if (ok)
 		ofono_modem_set_powered(modem, FALSE);
 }
@@ -148,6 +185,11 @@ static int huawei_disable(struct ofono_modem *modem)
 =

 	DBG("%p", modem);
 =

+	if (data->event) {
+		g_at_chat_cancel_all(data->event);
+		g_at_chat_unregister_all(data->event);
+	}
+
 	if (!data->chat)
 		return 0;
 =

diff --git a/plugins/udev.c b/plugins/udev.c
index 3a6ea28..bdac4fd 100644
--- a/plugins/udev.c
+++ b/plugins/udev.c
@@ -89,6 +89,24 @@ static const char *get_serial(struct udev_device *udev_d=
evice)
 	return serial;
 }
 =

+static const char *get_usb_num(struct udev_device *udev_device)
+{
+	struct udev_list_entry *entry;
+	const char *num =3D NULL;
+
+	entry =3D udev_device_get_properties_list_entry(udev_device);
+	while (entry) {
+		const char *name =3D udev_list_entry_get_name(entry);
+
+		if (g_strcmp0(name, "ID_USB_INTERFACE_NUM") =3D=3D 0)
+			num =3D udev_list_entry_get_value(entry);
+
+		entry =3D udev_list_entry_get_next(entry);
+	}
+
+	return num;
+}
+
 #define MODEM_DEVICE		"ModemDevice"
 #define DATA_DEVICE		"DataDevice"
 #define GPS_DEVICE		"GPSDevice"
@@ -201,18 +219,45 @@ static void add_hso(struct ofono_modem *modem,
 static void add_huawei(struct ofono_modem *modem,
 					struct udev_device *udev_device)
 {
-	const char *devnode;
-	int registered;
+	const char *devnode, *num;
+	int primary, secondary;
 =

-	registered =3D ofono_modem_get_integer(modem, "Registered");
-	if (registered !=3D 0)
+	primary =3D ofono_modem_get_integer(modem, "PrimaryRegistered");
+	secondary =3D ofono_modem_get_integer(modem, "SecondaryRegistered");
+
+	if (primary && secondary)
 		return;
 =

-	devnode =3D udev_device_get_devnode(udev_device);
-	ofono_modem_set_string(modem, "Device", devnode);
+	num =3D get_usb_num(udev_device);
 =

-	ofono_modem_set_integer(modem, "Registered", 1);
-	ofono_modem_register(modem);
+	/*
+	 * Here is is assumed that that usb port number 0 is the control
+	 * port and port 2 is the event port. This assumption will surely
+	 * be false with some devices and better heuristics is needed.
+	 */
+	if (g_strcmp0(num, "00") =3D=3D 0) {
+		if (primary !=3D 0)
+			return;
+
+		devnode =3D udev_device_get_devnode(udev_device);
+		ofono_modem_set_string(modem, "Device", devnode);
+
+		primary =3D 1;
+		ofono_modem_set_integer(modem, "PrimaryRegistered", primary);
+	} else if (g_strcmp0(num, "02") =3D=3D 0) {
+		if (secondary !=3D 0)
+			return;
+
+		devnode =3D udev_device_get_devnode(udev_device);
+		ofono_modem_set_string(modem, "SecondaryDevice", devnode);
+
+		secondary =3D 1;
+		ofono_modem_set_integer(modem, "SecondaryRegistered",
+					secondary);
+	}
+
+	if (primary && secondary)
+		ofono_modem_register(modem);
 }
 =

 static void add_em770(struct ofono_modem *modem,


--===============7151535113137419397==--

