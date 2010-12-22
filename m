Content-Type: multipart/mixed; boundary="===============5830887836432491129=="
MIME-Version: 1.0
From: Oskari Timperi <oskari.timperi@ixonos.com>
Subject: [PATCHv2 3/3] udev initialization for TC65
Date: Wed, 22 Dec 2010 13:13:02 +0200
Message-ID: <1293016382-4607-4-git-send-email-oskari.timperi@ixonos.com>
In-Reply-To: <1293016382-4607-3-git-send-email-oskari.timperi@ixonos.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5830887836432491129==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 plugins/udev.c |   15 +++++++++++++++
 1 files changed, 15 insertions(+), 0 deletions(-)

diff --git a/plugins/udev.c b/plugins/udev.c
index 3ca6af0..e384583 100644
--- a/plugins/udev.c
+++ b/plugins/udev.c
@@ -462,6 +462,19 @@ static void add_calypso(struct ofono_modem *modem,
        ofono_modem_register(modem);
 }

+static void add_tc65(struct ofono_modem *modem,
+                                       struct udev_device *udev_device)
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


--===============5830887836432491129==--

