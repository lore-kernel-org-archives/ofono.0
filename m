Content-Type: multipart/mixed; boundary="===============8976225415638753499=="
MIME-Version: 1.0
From: Kalle Valo <kalle.valo@canonical.com>
Subject: [PATCH v2 3/6] huawei: detect SecondaryDevice which is used for events
Date: Fri, 30 Apr 2010 15:55:11 +0300
Message-ID: <20100430125511.30019.69990.stgit@potku.valot.fi>
In-Reply-To: <20100430124405.30019.86945.stgit@potku.valot.fi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8976225415638753499==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


---

 plugins/huawei.c |   39 ++++++++++++++++++++++++++++++++++-
 plugins/udev.c   |   61 +++++++++++++++++++++++++++++++++++++++++++++++---=
----
 2 files changed, 91 insertions(+), 9 deletions(-)

diff --git a/plugins/huawei.c b/plugins/huawei.c
index 94cbb68..e895d16 100644
--- a/plugins/huawei.c
+++ b/plugins/huawei.c
@@ -47,7 +47,7 @@
 #include <drivers/atmodem/vendor.h>
 =

 struct huawei_data {
-	GAtChat *chat;
+	GAtChat *chat, *event;
 };
 =

 static int huawei_probe(struct ofono_modem *modem)
@@ -74,6 +74,7 @@ static void huawei_remove(struct ofono_modem *modem)
 	ofono_modem_set_data(modem, NULL);
 =

 	g_at_chat_unref(data->chat);
+	g_at_chat_unref(data->event);
 	g_free(data);
 }
 =

@@ -82,6 +83,11 @@ static void huawei_debug(const char *str, void *user_dat=
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
@@ -122,6 +128,29 @@ static int huawei_enable(struct ofono_modem *modem)
 	if (getenv("OFONO_AT_DEBUG"))
 		g_at_chat_set_debug(data->chat, huawei_debug, NULL);
 =

+	device =3D ofono_modem_get_string(modem, "SecondaryDevice");
+	if (!device)
+		return -EINVAL;
+
+	channel =3D g_at_tty_open(device, NULL);
+	if (!channel)
+		return -EIO;
+
+	syntax =3D g_at_syntax_new_gsm_permissive();
+	data->event =3D g_at_chat_new(channel, syntax);
+	g_at_syntax_unref(syntax);
+	g_io_channel_unref(channel);
+
+	if (!data->event)
+		return -EIO;
+
+	g_at_chat_add_terminator(data->event, "COMMAND NOT SUPPORT", -1,
+				 FALSE);
+
+	if (getenv("OFONO_AT_DEBUG"))
+		g_at_chat_set_debug(data->event, huawei_event_debug, NULL);
+
+
 	g_at_chat_send(data->chat, "ATE0", NULL, NULL, NULL, NULL);
 =

 	g_at_chat_send(data->chat, "AT+CFUN=3D1", NULL,
@@ -140,6 +169,9 @@ static void cfun_disable(gboolean ok, GAtResult *result=
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
@@ -150,6 +182,11 @@ static int huawei_disable(struct ofono_modem *modem)
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
index 964ac65..8ad4f83 100644
--- a/plugins/udev.c
+++ b/plugins/udev.c
@@ -88,6 +88,24 @@ static const char *get_serial(struct udev_device *udev_d=
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
@@ -199,18 +217,45 @@ static void add_hso(struct ofono_modem *modem,
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


--===============8976225415638753499==--

