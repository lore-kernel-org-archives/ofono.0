Content-Type: multipart/mixed; boundary="===============7681477941637852085=="
MIME-Version: 1.0
From: Dara Spieker-Doyle <dara.spieker-doyle@nokia.com>
Subject: [PATCH v3, Part2, 3/3] udev: Add nokiacdma device
Date: Tue, 21 Dec 2010 11:23:30 -0800
Message-ID: <1292959410-6566-4-git-send-email-dara.spieker-doyle@nokia.com>
In-Reply-To: <y>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7681477941637852085==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 plugins/udev.c |   21 +++++++++++++++++++++
 1 files changed, 21 insertions(+), 0 deletions(-)

diff --git a/plugins/udev.c b/plugins/udev.c
index 255755e..9447e5c 100644
--- a/plugins/udev.c
+++ b/plugins/udev.c
@@ -449,6 +449,25 @@ static void add_isi(struct ofono_modem *modem,
 	ofono_modem_register(modem);
 }
 =

+static void add_nokiacdma(struct ofono_modem *modem,
+					struct udev_device *udev_device)
+{
+	const char *devnode;
+	int registered;
+
+	DBG("modem %p", modem);
+
+	devnode =3D udev_device_get_devnode(udev_device);
+
+	registered =3D ofono_modem_get_integer(modem, "Registered");
+	if (registered !=3D 0)
+		return;
+
+	ofono_modem_set_string(modem, "Device", devnode);
+	ofono_modem_set_integer(modem, "Registered", 1);
+	ofono_modem_register(modem);
+}
+
 static void add_modem(struct udev_device *udev_device)
 {
 	struct ofono_modem *modem;
@@ -533,6 +552,8 @@ done:
 		add_isi(modem, udev_device);
 	else if (g_strcmp0(driver, "n900") =3D=3D 0)
 		add_isi(modem, udev_device);
+	else if (g_strcmp0(driver, "nokiacdma") =3D=3D 0)
+		add_nokiacdma(modem, udev_device);
 }
 =

 static gboolean devpath_remove(gpointer key, gpointer value, gpointer user=
_data)
-- =

1.7.0.4


--===============7681477941637852085==--

