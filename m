Content-Type: multipart/mixed; boundary="===============0289282613832225661=="
MIME-Version: 1.0
From: Jonas Bonn <jonas@southpole.se>
Subject: [PATCH udev 04/15] udev: get udev property via lib function
Date: Sat, 25 Mar 2017 17:57:54 +0100
Message-ID: <20170325165805.28166-5-jonas@southpole.se>
In-Reply-To: <20170325165805.28166-1-jonas@southpole.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0289282613832225661==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 plugins/udev.c | 24 +++---------------------
 1 file changed, 3 insertions(+), 21 deletions(-)

diff --git a/plugins/udev.c b/plugins/udev.c
index 196c528..7c090aa 100644
--- a/plugins/udev.c
+++ b/plugins/udev.c
@@ -55,34 +55,16 @@ static struct ofono_modem *find_modem(const char *devpa=
th)
 	return NULL;
 }
 =

-static const char *get_property(struct udev_device *device,
-				char const *property_name)
-{
-	struct udev_list_entry *entry;
-
-	entry =3D udev_device_get_properties_list_entry(device);
-	while (entry) {
-		const char *name =3D udev_list_entry_get_name(entry);
-
-		if (g_strcmp0(name, property_name) =3D=3D 0)
-			return udev_list_entry_get_value(entry);
-
-		entry =3D udev_list_entry_get_next(entry);
-	}
-
-	return NULL;
-}
-
 static const char *get_driver(struct udev_device *udev_device)
 {
-	return get_property(udev_device, "OFONO_DRIVER");
+	return udev_device_get_property_value(udev_device, "OFONO_DRIVER");
 }
 =

 static const char *get_serial(struct udev_device *udev_device)
 {
 	const char *serial;
 =

-	serial =3D get_property(udev_device, "ID_SERIAL_SHORT");
+	serial =3D udev_device_get_property_value(udev_device, "ID_SERIAL_SHORT");
 =

 	if (serial !=3D NULL) {
 		unsigned int i, len =3D strlen(serial);
@@ -135,7 +117,7 @@ static void add_isi(struct ofono_modem *modem,
 	if (ofono_modem_get_string(modem, "Interface"))
 		return;
 =

-	addr =3D get_property(udev_device, "OFONO_ISI_ADDRESS");
+	addr =3D udev_device_get_property_value(udev_device, "OFONO_ISI_ADDRESS");
 	if (addr !=3D NULL)
 		ofono_modem_set_integer(modem, "Address", atoi(addr));
 =

-- =

2.9.3


--===============0289282613832225661==--

