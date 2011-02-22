Content-Type: multipart/mixed; boundary="===============8336335107688380547=="
MIME-Version: 1.0
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: [PATCH v4 5/6] udev: add location-reporting device to mbm
Date: Tue, 22 Feb 2011 15:35:14 -0300
Message-ID: <1298399715-9617-6-git-send-email-lucas.demarchi@profusion.mobi>
In-Reply-To: <1298399715-9617-1-git-send-email-lucas.demarchi@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8336335107688380547==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Rafael Ignacio Zurita <rafael.zurita@profusion.mobi>

---
 plugins/udev.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/plugins/udev.c b/plugins/udev.c
index 84478d7..aa5702e 100644
--- a/plugins/udev.c
+++ b/plugins/udev.c
@@ -105,7 +105,7 @@ static void add_mbm(struct ofono_modem *modem,
 					struct udev_device *udev_device)
 {
 	const char *desc, *devnode;
-	const char *device, *data, *network;
+	const char *device, *data, *network, *gps;
 	int registered;
 =

 	desc =3D udev_device_get_sysattr_value(udev_device, "device/interface");
@@ -152,8 +152,9 @@ static void add_mbm(struct ofono_modem *modem,
 	device  =3D ofono_modem_get_string(modem, MODEM_DEVICE);
 	data =3D ofono_modem_get_string(modem, DATA_DEVICE);
 	network =3D ofono_modem_get_string(modem, NETWORK_INTERFACE);
+	gps =3D ofono_modem_get_string(modem, GPS_DEVICE);
 =

-	if (device !=3D NULL && data !=3D NULL && network !=3D NULL) {
+	if (device !=3D NULL && data !=3D NULL && network !=3D NULL && gps !=3D N=
ULL) {
 		ofono_modem_set_integer(modem, "Registered", 1);
 		ofono_modem_register(modem);
 	}
-- =

1.7.4.1


--===============8336335107688380547==--

