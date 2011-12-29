Content-Type: multipart/mixed; boundary="===============1637445645753233904=="
MIME-Version: 1.0
From: r.r.zaripov@gmail.com
Subject: [PATCH v3 2/3] Add SIM900 detection support.
Date: Thu, 29 Dec 2011 16:06:26 +0400
Message-ID: <1325160387-19607-2-git-send-email-r.r.zaripov@gmail.com>
In-Reply-To: <1325160387-19607-1-git-send-email-r.r.zaripov@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1637445645753233904==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Renat Zaripov <r.r.zaripov@gmail.com>

This allows for detection of SIM900 modem module in case of
appropriate driver specified in udev rules.

Example rule:
KERNEL=3D=3D"gsmtty3", ENV{OFONO_DRIVER}=3D"sim900"

Signed-off-by: Renat Zaripov <r.r.zaripov@gmail.com>
---
 plugins/udev.c |   15 +++++++++++++++
 1 files changed, 15 insertions(+), 0 deletions(-)

diff --git a/plugins/udev.c b/plugins/udev.c
index d0673f7..f05af48 100644
--- a/plugins/udev.c
+++ b/plugins/udev.c
@@ -193,6 +193,19 @@ static void add_nokiacdma(struct ofono_modem *modem,
 	ofono_modem_register(modem);
 }
 =

+static void add_sim900(struct ofono_modem *modem,
+                       struct udev_device *udev_device)
+{
+        const char *devnode;
+
+        DBG("modem %p", modem);
+
+        devnode =3D udev_device_get_devnode(udev_device);
+        ofono_modem_set_string(modem, "Device", devnode);
+
+        ofono_modem_register(modem);
+}
+
 static void add_modem(struct udev_device *udev_device)
 {
 	struct ofono_modem *modem;
@@ -271,6 +284,8 @@ done:
 		add_tc65(modem, udev_device);
 	else if (g_strcmp0(driver, "nokiacdma") =3D=3D 0)
 		add_nokiacdma(modem, udev_device);
+        else if (g_strcmp0(driver, "sim900") =3D=3D 0)
+                add_sim900(modem, udev_device);
 }
 =

 static gboolean devpath_remove(gpointer key, gpointer value, gpointer user=
_data)
-- =

1.7.7.3


--===============1637445645753233904==--

