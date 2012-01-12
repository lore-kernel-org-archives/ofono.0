Content-Type: multipart/mixed; boundary="===============5963250584074847975=="
MIME-Version: 1.0
From: r.r.zaripov@gmail.com
Subject: [PATCH v5 2/4] Add SIM900 detection support.
Date: Thu, 12 Jan 2012 16:32:20 +0400
Message-ID: <1326371542-29964-2-git-send-email-r.r.zaripov@gmail.com>
In-Reply-To: <1326371542-29964-1-git-send-email-r.r.zaripov@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5963250584074847975==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Renat Zaripov <r.r.zaripov@gmail.com>

This allows for detection of SIM900 modem module in case
of appropriate driver specified in udev rules.

Example rule:
KERNEL=3D=3D"gsmtty3", ENV{OFONO_DRIVER}=3D"sim900"
---
 plugins/udev.c |   15 +++++++++++++++
 1 files changed, 15 insertions(+), 0 deletions(-)

diff --git a/plugins/udev.c b/plugins/udev.c
index 79027d7..8cb87a5 100644
--- a/plugins/udev.c
+++ b/plugins/udev.c
@@ -193,6 +193,19 @@ static void add_nokiacdma(struct ofono_modem *modem,
 	ofono_modem_register(modem);
 }
 =

+static void add_sim900(struct ofono_modem *modem,
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
@@ -271,6 +284,8 @@ done:
 		add_tc65(modem, udev_device);
 	else if (g_strcmp0(driver, "nokiacdma") =3D=3D 0)
 		add_nokiacdma(modem, udev_device);
+	else if (g_strcmp0(driver, "sim900") =3D=3D 0)
+		add_sim900(modem, udev_device);
 }
 =

 static gboolean devpath_remove(gpointer key, gpointer value, gpointer user=
_data)
-- =

1.7.7.3


--===============5963250584074847975==--

