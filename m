Content-Type: multipart/mixed; boundary="===============2973834992602043240=="
MIME-Version: 1.0
From: Bertrand Aygon <bertrand.aygon@intel.com>
Subject: [PATCH 2/2] Add udev rules for SpeedUp modem
Date: Wed, 06 Jul 2011 19:25:59 +0200
Message-ID: <1309973159-4446-2-git-send-email-bertrand.aygon@intel.com>
In-Reply-To: <1309973159-4446-1-git-send-email-bertrand.aygon@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2973834992602043240==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 plugins/ofono.rules |    9 ++++++++
 plugins/udev.c      |   54 +++++++++++++++++++++++++++++++++++++++++++++++=
++++
 2 files changed, 63 insertions(+), 0 deletions(-)

diff --git a/plugins/ofono.rules b/plugins/ofono.rules
index 2829ea2..1fcdddb 100644
--- a/plugins/ofono.rules
+++ b/plugins/ofono.rules
@@ -358,6 +358,10 @@ ATTRS{idVendor}=3D=3D"1bc7", ATTRS{idProduct}=3D=3D"10=
04", ENV{OFONO_IFACE_NUM}=3D=3D"00", E
 ATTRS{idVendor}=3D=3D"1bc7", ATTRS{idProduct}=3D=3D"1004", ENV{OFONO_IFACE=
_NUM}=3D=3D"02", ENV{OFONO_TELIT_TYPE}=3D"GPS"
 ATTRS{idVendor}=3D=3D"1bc7", ATTRS{idProduct}=3D=3D"1004", ENV{OFONO_IFACE=
_NUM}=3D=3D"03", ENV{OFONO_TELIT_TYPE}=3D"Data"
 =

+# SpeedUp 9800
+ATTRS{idVendor}=3D=3D"1c9e", ATTRS{idProduct}=3D=3D"9800", ENV{OFONO_IFACE=
_NUM}=3D=3D"01", ENV{OFONO_SPEEDUP_TYPE}=3D"modem"
+ATTRS{idVendor}=3D=3D"1c9e", ATTRS{idProduct}=3D=3D"9800", ENV{OFONO_IFACE=
_NUM}=3D=3D"02", ENV{OFONO_SPEEDUP_TYPE}=3D"aux"
+
 LABEL=3D"ofono_tty_end"
 =

 # ISI/Phonet drivers
@@ -398,6 +402,11 @@ ATTRS{idVendor}=3D=3D"19d2", ENV{OFONO_DRIVER}=3D"zte"
 =

 ATTRS{idVendor}=3D=3D"19d2", ATTRS{serial}=3D=3D"1234567890ABCDEF", ENV{ID=
_SERIAL_SHORT}=3D""
 =

+# SpeedUp
+ATTRS{idVendor}=3D=3D"1c9e", ENV{OFONO_DRIVER}=3D"speedup"
+
+ATTRS{idVendor}=3D=3D"1c9e", ATTRS{serial}=3D=3D"1234567890ABCDEF", ENV{ID=
_SERIAL_SHORT}=3D""
+
 # Option Globetrotter
 ATTRS{idVendor}=3D=3D"0af0", ATTRS{idProduct}=3D=3D"6911", ENV{OFONO_DRIVE=
R}=3D"hso"
 ATTRS{idVendor}=3D=3D"0af0", ATTRS{idProduct}=3D=3D"6971", ENV{OFONO_DRIVE=
R}=3D"hso"
diff --git a/plugins/udev.c b/plugins/udev.c
index 4faf63e..a28bea7 100644
--- a/plugins/udev.c
+++ b/plugins/udev.c
@@ -639,6 +639,58 @@ static void add_telit(struct ofono_modem *modem,
 	}
 }
 =

+static void add_speedup(struct ofono_modem *modem,
+					struct udev_device *udev_device)
+{
+	struct udev_list_entry *entry;
+	const char *devnode, *type;
+
+	int ppp, aux;
+
+	DBG("modem %p", modem);
+
+	ppp =3D ofono_modem_get_integer(modem, "ModemRegistered");
+	aux =3D ofono_modem_get_integer(modem, "AuxRegistered");
+
+	if (ppp && aux)
+		return;
+
+	entry =3D udev_device_get_properties_list_entry(udev_device);
+	while (entry) {
+		const char *name =3D udev_list_entry_get_name(entry);
+		type =3D udev_list_entry_get_value(entry);
+
+		if (g_str_equal(name, "OFONO_SPEEDUP_TYPE") !=3D TRUE) {
+			entry =3D udev_list_entry_get_next(entry);
+			continue;
+		}
+
+		if (g_str_equal(type, "modem") =3D=3D TRUE) {
+			if (ppp !=3D 0)
+				return;
+
+			devnode =3D udev_device_get_devnode(udev_device);
+			ofono_modem_set_string(modem, "Modem", devnode);
+			ppp =3D 1;
+			ofono_modem_set_integer(modem, "ModemRegistered", ppp);
+		} else if (g_str_equal(type, "aux") =3D=3D TRUE) {
+			if (aux !=3D 0)
+				return;
+
+			devnode =3D udev_device_get_devnode(udev_device);
+			ofono_modem_set_string(modem, "Aux", devnode);
+
+			aux =3D 1;
+			ofono_modem_set_integer(modem, "AuxRegistered", aux);
+		}
+
+		break;
+	}
+
+	if (ppp && aux)
+		ofono_modem_register(modem);
+}
+
 static void add_modem(struct udev_device *udev_device)
 {
 	struct ofono_modem *modem;
@@ -739,6 +791,8 @@ done:
 		add_nokiacdma(modem, udev_device);
         else if (g_strcmp0(driver, "linktop") =3D=3D 0)
 		add_linktop(modem, udev_device);
+        else if (g_strcmp0(driver, "speedup") =3D=3D 0)
+		add_speedup(modem, udev_device);
 }
 =

 static gboolean devpath_remove(gpointer key, gpointer value, gpointer user=
_data)
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

--===============2973834992602043240==--

