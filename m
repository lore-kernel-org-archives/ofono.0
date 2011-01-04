Content-Type: multipart/mixed; boundary="===============8598804867792490766=="
MIME-Version: 1.0
From: Dara Spieker-Doyle <dara.spieker-doyle@nokia.com>
Subject: [PATCH v4, 5/5] udev: Add nokiacdma device
Date: Mon, 03 Jan 2011 17:50:17 -0800
Message-ID: <1294105817-23397-6-git-send-email-dara.spieker-doyle@nokia.com>
In-Reply-To: <y>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8598804867792490766==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 plugins/udev.c |   16 ++++++++++++++++
 1 files changed, 16 insertions(+), 0 deletions(-)

diff --git a/plugins/udev.c b/plugins/udev.c
index 6a59b06..12402eb 100644
--- a/plugins/udev.c
+++ b/plugins/udev.c
@@ -462,6 +462,20 @@ static void add_calypso(struct ofono_modem *modem,
 	ofono_modem_register(modem);
 }
 =

+static void add_nokiacdma(struct ofono_modem *modem,
+					struct udev_device *udev_device)
+{
+	const char *devnode;
+
+	DBG("modem %p", modem);
+
+	devnode =3D udev_device_get_devnode(udev_device);
+
+	ofono_modem_set_string(modem, "Device", devnode);
+	ofono_modem_set_integer(modem, "Registered", 1);
+	ofono_modem_register(modem);
+}
+
 static void add_modem(struct udev_device *udev_device)
 {
 	struct ofono_modem *modem;
@@ -548,6 +562,8 @@ done:
 		add_isi(modem, udev_device);
 	else if (g_strcmp0(driver, "calypso") =3D=3D 0)
 		add_calypso(modem, udev_device);
+	else if (g_strcmp0(driver, "nokiacdma") =3D=3D 0)
+		add_nokiacdma(modem, udev_device);
 }
 =

 static gboolean devpath_remove(gpointer key, gpointer value, gpointer user=
_data)
-- =

1.7.0.4


--===============8598804867792490766==--

