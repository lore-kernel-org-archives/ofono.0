Content-Type: multipart/mixed; boundary="===============2340536798913003971=="
MIME-Version: 1.0
From: Oskari Timperi <oskari.timperi@ixonos.com>
Subject: [PATCHv3 2/2] udev: Handle TC65 modem
Date: Wed, 29 Dec 2010 11:55:10 +0200
Message-ID: <1293616510-18042-3-git-send-email-oskari.timperi@ixonos.com>
In-Reply-To: <1293616510-18042-2-git-send-email-oskari.timperi@ixonos.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2340536798913003971==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 plugins/udev.c |   15 +++++++++++++++
 1 files changed, 15 insertions(+), 0 deletions(-)

diff --git a/plugins/udev.c b/plugins/udev.c
index 6a59b06..97de0e1 100644
--- a/plugins/udev.c
+++ b/plugins/udev.c
@@ -462,6 +462,19 @@ static void add_calypso(struct ofono_modem *modem,
        ofono_modem_register(modem);
 }

+static void add_tc65(struct ofono_modem *modem,
+               struct udev_device *udev_device)
+{
+       const char *devnode;
+
+       DBG("modem %p", modem);
+
+       devnode =3D udev_device_get_devnode(udev_device);
+       ofono_modem_set_string(modem, "Device", devnode);
+
+       ofono_modem_register(modem);
+}
+
 static void add_modem(struct udev_device *udev_device)
 {
        struct ofono_modem *modem;
@@ -548,6 +561,8 @@ done:
                add_isi(modem, udev_device);
        else if (g_strcmp0(driver, "calypso") =3D=3D 0)
                add_calypso(modem, udev_device);
+       else if (g_strcmp0(driver, "tc65") =3D=3D 0)
+               add_tc65(modem, udev_device);
 }

 static gboolean devpath_remove(gpointer key, gpointer value, gpointer user=
_data)
--
1.6.3.3

-- See us at Mobile World Congress, 14-17 February 2011, in Barcelona, Spai=
n. Visit the Ixonos booth Hall 1, # 1E19.


--===============2340536798913003971==--

