Content-Type: multipart/mixed; boundary="===============1875267783608672913=="
MIME-Version: 1.0
From: Amit Mendapara <mendapara.amit@gmail.com>
Subject: [PATCH 2/2] udev: changed linktop device strings
Date: Mon, 27 Jun 2011 11:52:15 +0530
Message-ID: <1309155735-14544-2-git-send-email-mendapara.amit@gmail.com>
In-Reply-To: <1309155735-14544-1-git-send-email-mendapara.amit@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1875267783608672913==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 plugins/udev.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/plugins/udev.c b/plugins/udev.c
index 99303e9..1580b02 100644
--- a/plugins/udev.c
+++ b/plugins/udev.c
@@ -577,10 +577,10 @@ static void add_linktop(struct ofono_modem *modem,
 =

 	if (g_strcmp0(intfnum, "01") =3D=3D 0) {
 		devnode =3D udev_device_get_devnode(udev_device);
-		ofono_modem_set_string(modem, "Modem", devnode);
+		ofono_modem_set_string(modem, "Aux", devnode);
 	} else if (g_strcmp0(intfnum, "03") =3D=3D 0) {
 		devnode =3D udev_device_get_devnode(udev_device);
-		ofono_modem_set_string(modem, "Control", devnode);
+		ofono_modem_set_string(modem, "Modem", devnode);
 =

 		ofono_modem_set_integer(modem, "Registered", 1);
 		ofono_modem_register(modem);
-- =

1.7.4.1


--===============1875267783608672913==--

