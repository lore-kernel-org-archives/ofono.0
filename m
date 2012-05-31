Content-Type: multipart/mixed; boundary="===============1467829751593902630=="
MIME-Version: 1.0
From: pablo@gnumonks.org
Subject: [PATCH 1/2] udev: add Wavecom support
Date: Thu, 31 May 2012 16:01:24 +0200
Message-ID: <1338472885-30645-2-git-send-email-pablo@gnumonks.org>
In-Reply-To: <1338472885-30645-1-git-send-email-pablo@gnumonks.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1467829751593902630==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Pablo Neira Ayuso <pablo@gnumonks.org>

This adds OFONO_WAVECOM_MODEL that can set in the udev rules file
to indicate the modem model, eg.

 ENV{OFONO_WAVECOM_MODEL}=3D"Q2XXX"
---
 plugins/udev.c |   27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/plugins/udev.c b/plugins/udev.c
index 8cb87a5..a78cd41 100644
--- a/plugins/udev.c
+++ b/plugins/udev.c
@@ -167,6 +167,31 @@ static void add_calypso(struct ofono_modem *modem,
 	ofono_modem_register(modem);
 }
 =

+static void add_wavecom(struct ofono_modem *modem,
+					struct udev_device *udev_device)
+{
+	const char *devnode;
+	struct udev_list_entry *entry;
+
+	DBG("modem %p", modem);
+
+	devnode =3D udev_device_get_devnode(udev_device);
+	ofono_modem_set_string(modem, "Device", devnode);
+
+	entry =3D udev_device_get_properties_list_entry(udev_device);
+	while (entry) {
+		const char *name =3D udev_list_entry_get_name(entry);
+		const char *value =3D udev_list_entry_get_value(entry);
+
+		if (g_str_equal(name, "OFONO_WAVECOM_MODEL") =3D=3D TRUE)
+			ofono_modem_set_string(modem, "Model", value);
+
+		entry =3D udev_list_entry_get_next(entry);
+	}
+
+	ofono_modem_register(modem);
+}
+
 static void add_tc65(struct ofono_modem *modem,
 			struct udev_device *udev_device)
 {
@@ -286,6 +311,8 @@ done:
 		add_nokiacdma(modem, udev_device);
 	else if (g_strcmp0(driver, "sim900") =3D=3D 0)
 		add_sim900(modem, udev_device);
+	else if (g_strcmp0(driver, "wavecom") =3D=3D 0)
+		add_wavecom(modem, udev_device);
 }
 =

 static gboolean devpath_remove(gpointer key, gpointer value, gpointer user=
_data)
-- =

1.7.10


--===============1467829751593902630==--

