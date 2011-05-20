Content-Type: multipart/mixed; boundary="===============7542423270969047994=="
MIME-Version: 1.0
From: Gustavo F. Padovan <padovan@profusion.mobi>
Subject: [PATCH 4/7] udev: remove set but not used var
Date: Fri, 20 May 2011 16:03:42 -0300
Message-ID: <1305918225-8438-4-git-send-email-padovan@profusion.mobi>
In-Reply-To: <1305918225-8438-3-git-send-email-padovan@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7542423270969047994==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 plugins/udev.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/plugins/udev.c b/plugins/udev.c
index cbb596d..0234fc0 100644
--- a/plugins/udev.c
+++ b/plugins/udev.c
@@ -105,7 +105,7 @@ static void add_mbm(struct ofono_modem *modem,
 					struct udev_device *udev_device)
 {
 	const char *desc, *devnode;
-	const char *device, *data, *network, *gps;
+	const char *device, *data, *network;
 	int registered;
 =

 	desc =3D udev_device_get_sysattr_value(udev_device, "device/interface");
@@ -157,7 +157,6 @@ static void add_mbm(struct ofono_modem *modem,
 	device  =3D ofono_modem_get_string(modem, MODEM_DEVICE);
 	data =3D ofono_modem_get_string(modem, DATA_DEVICE);
 	network =3D ofono_modem_get_string(modem, NETWORK_INTERFACE);
-	gps =3D ofono_modem_get_string(modem, GPS_DEVICE);
 =

 	if (device !=3D NULL && data !=3D NULL && network !=3D NULL) {
 		ofono_modem_set_integer(modem, "Registered", 1);
-- =

1.7.5.1


--===============7542423270969047994==--

