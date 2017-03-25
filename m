Content-Type: multipart/mixed; boundary="===============8838936117001839728=="
MIME-Version: 1.0
From: Jonas Bonn <jonas@southpole.se>
Subject: [PATCH udev 09/15] udev: simplify wavecom modem registration
Date: Sat, 25 Mar 2017 17:57:59 +0100
Message-ID: <20170325165805.28166-10-jonas@southpole.se>
In-Reply-To: <20170325165805.28166-1-jonas@southpole.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8838936117001839728==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 plugins/udev.c | 26 ++++++--------------------
 1 file changed, 6 insertions(+), 20 deletions(-)

diff --git a/plugins/udev.c b/plugins/udev.c
index 687aa66..13cef32 100644
--- a/plugins/udev.c
+++ b/plugins/udev.c
@@ -155,29 +155,15 @@ static void add_isi(struct ofono_modem *modem,
 	ofono_modem_register(modem);
 }
 =

-static void add_wavecom(struct ofono_modem *modem,
-					struct udev_device *udev_device)
+static void add_wavecom(struct ofono_modem *modem, struct udev_device *dev)
 {
-	const char *devnode;
-	struct udev_list_entry *entry;
-
-	DBG("modem %p", modem);
-
-	devnode =3D udev_device_get_devnode(udev_device);
-	ofono_modem_set_string(modem, "Device", devnode);
-
-	entry =3D udev_device_get_properties_list_entry(udev_device);
-	while (entry) {
-		const char *name =3D udev_list_entry_get_name(entry);
-		const char *value =3D udev_list_entry_get_value(entry);
-
-		if (g_str_equal(name, "OFONO_WAVECOM_MODEL") =3D=3D TRUE)
-			ofono_modem_set_string(modem, "Model", value);
+	const char *value;
 =

-		entry =3D udev_list_entry_get_next(entry);
-	}
+	value =3D udev_device_get_property_value(dev, "OFONO_WAVECOM_MODEL");
+	if (value)
+		ofono_modem_set_string(modem, "Model", value);
 =

-	ofono_modem_register(modem);
+	__add_common(modem, dev);
 }
 =

 static void add_modem(struct udev_device *udev_device)
-- =

2.9.3


--===============8838936117001839728==--

