Content-Type: multipart/mixed; boundary="===============7499549754860523821=="
MIME-Version: 1.0
From: Bernhard.Guillon@hale.at
Subject: [PATCH v4 4/4] udev: add Telit UC864-G and update udev rules
Date: Wed, 08 Jun 2011 17:18:37 +0200
Message-ID: <1307546317-31831-4-git-send-email-Bernhard.Guillon@hale.at>
In-Reply-To: <1307546317-31831-1-git-send-email-Bernhard.Guillon@hale.at>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7499549754860523821==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Bernhard Guillon <Bernhard.Guillon@hale.at>

*add Modem and GPS check for telit
*make GPS yes/no configurable with udev rules settings
**this is necessary because telit has different interface
  numbers on different modems e.g. GPS and UART
---
 plugins/ofono.rules |    8 +++++
 plugins/udev.c      |   72 +++++++++++++++++++++++++++++++++++++++++++++++=
++++
 2 files changed, 80 insertions(+), 0 deletions(-)

diff --git a/plugins/ofono.rules b/plugins/ofono.rules
index 268b327..64fa4b2 100644
--- a/plugins/ofono.rules
+++ b/plugins/ofono.rules
@@ -344,6 +344,11 @@ ATTRS{idVendor}=3D=3D"12d1", ATTRS{idProduct}=3D=3D"14=
85", ENV{OFONO_IFACE_NUM}=3D=3D"02", E
 ATTRS{idVendor}=3D=3D"12d1", ATTRS{idProduct}=3D=3D"1486", ENV{OFONO_IFACE=
_NUM}=3D=3D"00", ENV{OFONO_HUAWEI_TYPE}=3D"Modem"
 ATTRS{idVendor}=3D=3D"12d1", ATTRS{idProduct}=3D=3D"1486", ENV{OFONO_IFACE=
_NUM}=3D=3D"02", ENV{OFONO_HUAWEI_TYPE}=3D"Pcui"
 =

+#Telit UC864-G
+ATTRS{idVendor}=3D=3D"1bc7", ATTRS{idProduct}=3D=3D"1004", ENV{OFONO_TELIT=
_GPS}=3D"1"
+ATTRS{idVendor}=3D=3D"1bc7", ATTRS{idProduct}=3D=3D"1004", ENV{OFONO_IFACE=
_NUM}=3D=3D"00", ENV{OFONO_TELIT_TYPE}=3D"Modem"
+ATTRS{idVendor}=3D=3D"1bc7", ATTRS{idProduct}=3D=3D"1004", ENV{OFONO_IFACE=
_NUM}=3D=3D"02", ENV{OFONO_TELIT_TYPE}=3D"GPS"
+
 LABEL=3D"ofono_tty_end"
 =

 # ISI/Phonet drivers
@@ -459,4 +464,7 @@ ATTRS{idVendor}=3D=3D"0421", ATTRS{idProduct}=3D=3D"00b=
6", ENV{OFONO_DRIVER}=3D"nokiacdma"
 # Teracom (Linktop/LW27x) 3G Data Card
 ATTRS{idVendor}=3D=3D"230d", ATTRS{idProduct}=3D=3D"0001", ENV{OFONO_DRIVE=
R}=3D"linktop"
 =

+# Telit
+ATTRS{idVendor}=3D=3D"1bc7", ENV{OFONO_DRIVER}=3D"telit"
+
 LABEL=3D"ofono_end"
diff --git a/plugins/udev.c b/plugins/udev.c
index 0234fc0..e56d3db 100644
--- a/plugins/udev.c
+++ b/plugins/udev.c
@@ -587,6 +587,76 @@ static void add_linktop(struct ofono_modem *modem,
 	}
 }
 =

+static void add_telit(struct ofono_modem *modem,
+					struct udev_device *udev_device)
+{
+	struct udev_list_entry *entry;
+	const char *devnode, *type;
+	int device, gps_device, has_gps;
+
+	DBG("modem %p", modem);
+
+	/*
+	 * Some Telit modems have a built in GPS device. According to the
+	 * manual the the interface numbers can differ between different
+	 * devices hence we need to use udev rules to set the environment
+	 * accordingly.
+	 */
+	device =3D ofono_modem_get_integer(modem, "ModemRegistered");
+	gps_device =3D ofono_modem_get_integer(modem, "GPSRegistered");
+	has_gps =3D ofono_modem_get_integer(modem, "HasGPS");
+
+	if ((!has_gps && device) || (device && gps_device))
+		return;
+
+	entry =3D udev_device_get_properties_list_entry(udev_device);
+	while (entry) {
+		const char *name =3D udev_list_entry_get_name(entry);
+		type =3D udev_list_entry_get_value(entry);
+
+		if (g_str_equal(name, "OFONO_TELIT_GPS") =3D=3D TRUE) {
+			int value =3D g_str_equal(type, "1");
+
+			ofono_modem_set_integer(modem, "HasGPS", value);
+			entry =3D udev_list_entry_get_next(entry);
+			continue;
+		}
+
+		if (g_str_equal(name, "OFONO_TELIT_TYPE") !=3D TRUE) {
+			entry =3D udev_list_entry_get_next(entry);
+			continue;
+		}
+
+		if (g_str_equal(type, "Modem") =3D=3D TRUE) {
+
+			if (device !=3D 0)
+				return;
+
+			devnode =3D udev_device_get_devnode(udev_device);
+			ofono_modem_set_string(modem, "Modem", devnode);
+			device =3D 1;
+			ofono_modem_set_integer(modem, "ModemRegistered",
+							device);
+		} else if (g_str_equal(type, "GPS") =3D=3D TRUE) {
+
+			if (gps_device !=3D 0)
+				return;
+
+			devnode =3D udev_device_get_devnode(udev_device);
+			ofono_modem_set_string(modem, "GPS", devnode);
+
+			gps_device =3D 1;
+			ofono_modem_set_integer(modem, "GPSRegistered",
+							gps_device);
+		}
+
+		break;
+	}
+
+	if ((!has_gps && device) || (device && gps_device))
+		ofono_modem_register(modem);
+}
+
 static void add_modem(struct udev_device *udev_device)
 {
 	struct ofono_modem *modem;
@@ -681,6 +751,8 @@ done:
 		add_calypso(modem, udev_device);
 	else if (g_strcmp0(driver, "tc65") =3D=3D 0)
 		add_tc65(modem, udev_device);
+	else if (g_strcmp0(driver, "telit") =3D=3D 0)
+		add_telit(modem, udev_device);
 	else if (g_strcmp0(driver, "nokiacdma") =3D=3D 0)
 		add_nokiacdma(modem, udev_device);
         else if (g_strcmp0(driver, "linktop") =3D=3D 0)
-- =

1.7.0.4



--
Scanned by MailScanner.


--===============7499549754860523821==--

