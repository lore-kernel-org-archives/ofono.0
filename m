Content-Type: multipart/mixed; boundary="===============4537349594363019315=="
MIME-Version: 1.0
From: Jessica Nilsson <jessica.j.nilsson@stericsson.com>
Subject: [PATCH v2 2/3] udev: u8500 support and style fix
Date: Tue, 01 Feb 2011 15:13:18 +0100
Message-ID: <5ad2960fe2824ff3eb808372bf4ebb5345b3636c.1296569048.git.jessica.j.nilsson@stericsson.com>
In-Reply-To: <cover.1296569048.git.jessica.j.nilsson@stericsson.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4537349594363019315==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 plugins/udev.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/plugins/udev.c b/plugins/udev.c
index ce1efe6..49b5eb8 100644
--- a/plugins/udev.c
+++ b/plugins/udev.c
@@ -185,7 +185,8 @@ static void add_hso(struct ofono_modem *modem,
 		devnode =3D udev_device_get_devnode(udev_device);
 =

 		if (g_str_has_suffix(type, "Application") =3D=3D TRUE)
-			ofono_modem_set_string(modem, APPLICATION_PORT, devnode);
+			ofono_modem_set_string(modem, APPLICATION_PORT,
+						devnode);
 		else if (g_str_has_suffix(type, "Control") =3D=3D TRUE)
 			ofono_modem_set_string(modem, CONTROL_PORT, devnode);
 	} else if (g_str_equal(subsystem, "net") =3D=3D TRUE) {
@@ -636,6 +637,8 @@ done:
 		add_nokia(modem, udev_device);
 	else if (g_strcmp0(driver, "isiusb") =3D=3D 0)
 		add_isi(modem, udev_device);
+	else if (g_strcmp0(driver, "u8500") =3D=3D 0)
+		add_isi(modem, udev_device);
 	else if (g_strcmp0(driver, "n900") =3D=3D 0)
 		add_isi(modem, udev_device);
 	else if (g_strcmp0(driver, "gobi") =3D=3D 0)
-- =

1.7.3.5


--===============4537349594363019315==--

