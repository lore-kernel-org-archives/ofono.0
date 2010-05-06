Content-Type: multipart/mixed; boundary="===============3805952070524222738=="
MIME-Version: 1.0
From: Zhenhua Zhang <zhenhua.zhang@intel.com>
Subject: [PATCH 2/2] Fix check data device before register the modem
Date: Thu, 06 May 2010 14:28:13 +0800
Message-ID: <1273127293-4671-2-git-send-email-zhenhua.zhang@intel.com>
In-Reply-To: <1273127293-4671-1-git-send-email-zhenhua.zhang@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3805952070524222738==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

To avoid the race condition that modem is registered before we retrieve
the data device property.
---
 plugins/udev.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/plugins/udev.c b/plugins/udev.c
index 6850bf9..83468ce 100644
--- a/plugins/udev.c
+++ b/plugins/udev.c
@@ -98,7 +98,7 @@ static void add_mbm(struct ofono_modem *modem,
 					struct udev_device *udev_device)
 {
 	const char *desc, *devnode;
-	const char *device, *network;
+	const char *device, *data, *network;
 	int registered;
 =

 	desc =3D udev_device_get_sysattr_value(udev_device, "device/interface");
@@ -144,9 +144,10 @@ static void add_mbm(struct ofono_modem *modem,
 	}
 =

 	device  =3D ofono_modem_get_string(modem, MODEM_DEVICE);
+	data =3D ofono_modem_get_string(modem, DATA_DEVICE);
 	network =3D ofono_modem_get_string(modem, NETWORK_INTERFACE);
 =

-	if (device !=3D NULL && network !=3D NULL) {
+	if (device !=3D NULL && data !=3D NULL && network !=3D NULL) {
 		ofono_modem_set_integer(modem, "Registered", 1);
 		ofono_modem_register(modem);
 	}
-- =

1.6.3.3


--===============3805952070524222738==--

