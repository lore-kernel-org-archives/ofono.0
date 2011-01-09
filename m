Content-Type: multipart/mixed; boundary="===============7235513032350347568=="
MIME-Version: 1.0
From: oskari.timperi@ixonos.com
Subject: [PATCHv4 2/2] udev: Handle TC65 modem
Date: Mon, 10 Jan 2011 01:44:48 +0200
Message-ID: <1294616688-17246-3-git-send-email-oskari.timperi@ixonos.com>
In-Reply-To: <1294616688-17246-1-git-send-email-oskari.timperi@ixonos.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7235513032350347568==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Oskari Timperi <oskari.timperi@iki.fi>

---
 plugins/udev.c |   15 +++++++++++++++
 1 files changed, 15 insertions(+), 0 deletions(-)

diff --git a/plugins/udev.c b/plugins/udev.c
index baec663..0daf030 100644
--- a/plugins/udev.c
+++ b/plugins/udev.c
@@ -494,6 +494,19 @@ static void add_calypso(struct ofono_modem *modem,
 	ofono_modem_register(modem);
 }
 =

+static void add_tc65(struct ofono_modem *modem,
+		struct udev_device *udev_device)
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
@@ -582,6 +595,8 @@ done:
 		add_gobi(modem, udev_device);
 	else if (g_strcmp0(driver, "calypso") =3D=3D 0)
 		add_calypso(modem, udev_device);
+	else if (g_strcmp0(driver, "tc65") =3D=3D 0)
+		add_tc65(modem, udev_device);
 }
 =

 static gboolean devpath_remove(gpointer key, gpointer value, gpointer user=
_data)
-- =

1.7.1


--===============7235513032350347568==--

