Content-Type: multipart/mixed; boundary="===============6861133148722615935=="
MIME-Version: 1.0
From: Amit Mendapara <mendapara.amit@gmail.com>
Subject: [PATCH 2/2] udev: changed linktop device strings
Date: Wed, 08 Jun 2011 15:16:20 +0530
Message-ID: <1307526380-6285-2-git-send-email-mendapara.amit@gmail.com>
In-Reply-To: <1307526380-6285-1-git-send-email-mendapara.amit@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6861133148722615935==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Signed-off-by: Amit Mendapara <mendapara.amit@gmail.com>
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


--===============6861133148722615935==--

