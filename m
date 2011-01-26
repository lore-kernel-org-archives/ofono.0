Content-Type: multipart/mixed; boundary="===============1458885787038356514=="
MIME-Version: 1.0
From: Rafael Ignacio Zurita <rafael.zurita@profusion.mobi>
Subject: [PATCH v3 5/7] plugins/udev.c: add gps comparison for add_mbm
 registered modem
Date: Wed, 26 Jan 2011 12:32:52 -0300
Message-ID: <1296055974-9640-6-git-send-email-rafael.zurita@profusion.mobi>
In-Reply-To: <1296055974-9640-1-git-send-email-rafael.zurita@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1458885787038356514==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 plugins/udev.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/plugins/udev.c b/plugins/udev.c
index 202b225..ca09a30 100644
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

1.7.2.3


--===============1458885787038356514==--

