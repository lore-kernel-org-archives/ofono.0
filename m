Content-Type: multipart/mixed; boundary="===============0231860332024342655=="
MIME-Version: 1.0
From: Amit Mendapara <mendapara.amit@gmail.com>
Subject: [PATCH 2/2] udev: changed linktop device strings
Date: Wed, 15 Jun 2011 12:43:21 +0530
Message-ID: <1308122001-7649-2-git-send-email-mendapara.amit@gmail.com>
In-Reply-To: <1308122001-7649-1-git-send-email-mendapara.amit@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0231860332024342655==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 plugins/udev.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/plugins/udev.c b/plugins/udev.c
index 0234fc0..4f4e6d8 100644
--- a/plugins/udev.c
+++ b/plugins/udev.c
@@ -577,10 +577,10 @@ static void add_linktop(struct ofono_modem *modem,
 =

 	if (g_strcmp0(intfnum, "01") =3D=3D 0) {
 		devnode =3D udev_device_get_devnode(udev_device);
-		ofono_modem_set_string(modem, "Modem", devnode);
+		ofono_modem_set_string(modem, "ModemDevice", devnode);
 	} else if (g_strcmp0(intfnum, "03") =3D=3D 0) {
 		devnode =3D udev_device_get_devnode(udev_device);
-		ofono_modem_set_string(modem, "Control", devnode);
+		ofono_modem_set_string(modem, "DataDevice", devnode);
 =

 		ofono_modem_set_integer(modem, "Registered", 1);
 		ofono_modem_register(modem);
-- =

1.7.4.1


--===============0231860332024342655==--

