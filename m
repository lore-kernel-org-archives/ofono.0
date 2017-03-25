Content-Type: multipart/mixed; boundary="===============0361330026324531313=="
MIME-Version: 1.0
From: Jonas Bonn <jonas@southpole.se>
Subject: [PATCH udev 08/15] udev: simplify ifx modem registration
Date: Sat, 25 Mar 2017 17:57:58 +0100
Message-ID: <20170325165805.28166-9-jonas@southpole.se>
In-Reply-To: <20170325165805.28166-1-jonas@southpole.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0361330026324531313==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 plugins/udev.c | 48 ++++++++++++++++++------------------------------
 1 file changed, 18 insertions(+), 30 deletions(-)

diff --git a/plugins/udev.c b/plugins/udev.c
index 05945a0..687aa66 100644
--- a/plugins/udev.c
+++ b/plugins/udev.c
@@ -96,10 +96,9 @@ static const char *get_serial(struct udev_device *udev_d=
evice)
 	return serial;
 }
 =

-static void add_ifx(struct ofono_modem *modem,
+static void __add_common(struct ofono_modem *modem,
 					struct udev_device *udev_device)
 {
-	struct udev_list_entry *entry;
 	const char *devnode;
 =

 	DBG("modem %p", modem);
@@ -107,24 +106,26 @@ static void add_ifx(struct ofono_modem *modem,
 	devnode =3D udev_device_get_devnode(udev_device);
 	ofono_modem_set_string(modem, "Device", devnode);
 =

-	entry =3D udev_device_get_properties_list_entry(udev_device);
-	while (entry) {
-		const char *name =3D udev_list_entry_get_name(entry);
-		const char *value =3D udev_list_entry_get_value(entry);
-
-		if (g_str_equal(name, "OFONO_IFX_LDISC") =3D=3D TRUE)
-			ofono_modem_set_string(modem, "LineDiscipline", value);
-		else if (g_str_equal(name, "OFONO_IFX_AUDIO") =3D=3D TRUE)
-			ofono_modem_set_string(modem, "AudioSetting", value);
-		else if (g_str_equal(name, "OFONO_IFX_LOOPBACK") =3D=3D TRUE)
-			ofono_modem_set_string(modem, "AudioLoopback", value);
-
-		entry =3D udev_list_entry_get_next(entry);
-	}
-
 	ofono_modem_register(modem);
 }
 =

+static void add_ifx(struct ofono_modem *modem, struct udev_device *dev)
+{
+	const char *value;
+
+	value =3D udev_device_get_property_value(dev, "OFONO_IFX_LDISC");
+	if (value)
+		ofono_modem_set_string(modem, "LineDiscipline", value);
+	value =3D udev_device_get_property_value(dev, "OFONO_IFX_AUDIO");
+	if (value)
+		ofono_modem_set_string(modem, "AudioSetting", value);
+	value =3D udev_device_get_property_value(dev, "OFONO_IFX_LOOPBACK");
+	if (value)
+		ofono_modem_set_string(modem, "AudioLoopback", value);
+
+	__add_common(modem, dev);
+}
+
 static void add_isi(struct ofono_modem *modem,
 					struct udev_device *udev_device)
 {
@@ -154,19 +155,6 @@ static void add_isi(struct ofono_modem *modem,
 	ofono_modem_register(modem);
 }
 =

-static void __add_common(struct ofono_modem *modem,
-					struct udev_device *udev_device)
-{
-	const char *devnode;
-
-	DBG("modem %p", modem);
-
-	devnode =3D udev_device_get_devnode(udev_device);
-	ofono_modem_set_string(modem, "Device", devnode);
-
-	ofono_modem_register(modem);
-}
-
 static void add_wavecom(struct ofono_modem *modem,
 					struct udev_device *udev_device)
 {
-- =

2.9.3


--===============0361330026324531313==--

