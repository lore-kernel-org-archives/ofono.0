Content-Type: multipart/mixed; boundary="===============6199362597349450749=="
MIME-Version: 1.0
From: Pekka.Pessi@nokia.com
Subject: [fix-isi-udev PATCH 2/3] udev: refactor add_isi
Date: Mon, 04 Oct 2010 16:11:05 +0300
Message-ID: <1286197866-19572-3-git-send-email-Pekka.Pessi@nokia.com>
In-Reply-To: <1286197866-19572-2-git-send-email-Pekka.Pessi@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6199362597349450749==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Pekka Pessi <Pekka.Pessi@nokia.com>

Gather OFONO_ISI_ADDRESS from same udev device node as OFONO_DRIVER.
---
 plugins/udev.c |   20 +++++++++++++++-----
 1 files changed, 15 insertions(+), 5 deletions(-)

diff --git a/plugins/udev.c b/plugins/udev.c
index d506234..a352b90 100644
--- a/plugins/udev.c
+++ b/plugins/udev.c
@@ -420,19 +420,29 @@ static void add_nokia(struct ofono_modem *modem,
 static void add_isi(struct ofono_modem *modem,
 					struct udev_device *udev_device)
 {
-	const char *ifname, *addr;
+	const char *ifname, *type, *addr;
 =

 	DBG("modem %p", modem);
 =

-	ifname =3D udev_device_get_sysname(udev_device);
-	ofono_modem_set_string(modem, "Interface", ifname);
-
-	DBG("interface %s", ifname);
+	if (ofono_modem_get_string(modem, "Interface"))
+		return;
 =

 	addr =3D get_property(udev_device, "OFONO_ISI_ADDRESS");
 	if (addr !=3D NULL)
 		ofono_modem_set_integer(modem, "Address", atoi(addr));
 =

+	if (g_strcmp0(udev_device_get_subsystem(udev_device), "net") !=3D 0)
+		return;
+
+	type =3D udev_device_get_sysattr_value(udev_device, "type");
+	if (g_strcmp0(type, "820") !=3D 0)
+		return;
+
+	ifname =3D udev_device_get_sysname(udev_device);
+	ofono_modem_set_string(modem, "Interface", ifname);
+
+	DBG("interface %s", ifname);
+
 	ofono_modem_register(modem);
 }
 =

-- =

1.7.0.4


--===============6199362597349450749==--

