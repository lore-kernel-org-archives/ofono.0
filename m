Content-Type: multipart/mixed; boundary="===============4533509200362968172=="
MIME-Version: 1.0
From: Amit Mendapara <mendapara.amit@gmail.com>
Subject: [PATCH 2/3] udev: Handle Linktop data card
Date: Mon, 07 Feb 2011 08:52:03 +0530
Message-ID: <1297048924-11919-2-git-send-email-mendapara.amit@gmail.com>
In-Reply-To: <1297048924-11919-1-git-send-email-mendapara.amit@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4533509200362968172==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 plugins/udev.c |   32 ++++++++++++++++++++++++++++++++
 1 files changed, 32 insertions(+), 0 deletions(-)

diff --git a/plugins/udev.c b/plugins/udev.c
index ce1efe6..84478d7 100644
--- a/plugins/udev.c
+++ b/plugins/udev.c
@@ -552,6 +552,36 @@ static void add_nokiacdma(struct ofono_modem *modem,
 	ofono_modem_register(modem);
 }
 =

+static void add_linktop(struct ofono_modem *modem,
+					struct udev_device *udev_device)
+{
+	const char *devnode, *intfnum;
+	struct udev_device *parent;
+	int registered;
+
+	DBG("modem %p", modem);
+
+	registered =3D ofono_modem_get_integer(modem, "Registered");
+	if (registered !=3D 0)
+		return;
+
+	parent =3D udev_device_get_parent(udev_device);
+	intfnum =3D udev_device_get_sysattr_value(parent, "bInterfaceNumber");
+
+	DBG("intfnum %s", intfnum);
+
+	if (g_strcmp0(intfnum, "01") =3D=3D 0) {
+		devnode =3D udev_device_get_devnode(udev_device);
+		ofono_modem_set_string(modem, "Modem", devnode);
+	} else if (g_strcmp0(intfnum, "03") =3D=3D 0) {
+		devnode =3D udev_device_get_devnode(udev_device);
+		ofono_modem_set_string(modem, "Control", devnode);
+
+		ofono_modem_set_integer(modem, "Registered", 1);
+		ofono_modem_register(modem);
+	}
+}
+
 static void add_modem(struct udev_device *udev_device)
 {
 	struct ofono_modem *modem;
@@ -646,6 +676,8 @@ done:
 		add_tc65(modem, udev_device);
 	else if (g_strcmp0(driver, "nokiacdma") =3D=3D 0)
 		add_nokiacdma(modem, udev_device);
+        else if (g_strcmp0(driver, "linktop") =3D=3D 0)
+		add_linktop(modem, udev_device);
 }
 =

 static gboolean devpath_remove(gpointer key, gpointer value, gpointer user=
_data)
-- =

1.7.1


--===============4533509200362968172==--

