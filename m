Content-Type: multipart/mixed; boundary="===============6851107512265942722=="
MIME-Version: 1.0
From: Dara Spieker-Doyle <dara.spieker-doyle@nokia.com>
Subject: [PATCH v5, 5/5] udev: Add nokiacdma device
Date: Mon, 10 Jan 2011 17:45:32 -0800
Message-ID: <1294710332-6028-6-git-send-email-dara.spieker-doyle@nokia.com>
In-Reply-To: <y>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6851107512265942722==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 plugins/udev.c |   15 +++++++++++++++
 1 files changed, 15 insertions(+), 0 deletions(-)

diff --git a/plugins/udev.c b/plugins/udev.c
index e502669..58308e3 100644
--- a/plugins/udev.c
+++ b/plugins/udev.c
@@ -507,6 +507,19 @@ static void add_tc65(struct ofono_modem *modem,
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
+	ofono_modem_set_string(modem, "Device", devnode);
+
+	ofono_modem_register(modem);
+}
+
 static void add_modem(struct udev_device *udev_device)
 {
 	struct ofono_modem *modem;
@@ -597,6 +610,8 @@ done:
 		add_calypso(modem, udev_device);
 	else if (g_strcmp0(driver, "tc65") =3D=3D 0)
 		add_tc65(modem, udev_device);
+	else if (g_strcmp0(driver, "nokiacdma") =3D=3D 0)
+		add_nokiacdma(modem, udev_device);
 }
 =

 static gboolean devpath_remove(gpointer key, gpointer value, gpointer user=
_data)
-- =

1.7.0.4


--===============6851107512265942722==--

