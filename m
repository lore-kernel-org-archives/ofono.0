Content-Type: multipart/mixed; boundary="===============0149853450576533058=="
MIME-Version: 1.0
From: Jonas Bonn <jonas@southpole.se>
Subject: [PATCH 1/2] udev: fixes for detection of non-USB modems
Date: Tue, 12 Sep 2017 10:11:19 +0200
Message-ID: <20170912081120.29364-1-jonas@southpole.se>
In-Reply-To: <ba3c362b-2bd4-0c4d-0c01-bdaed7ad53c3@southpole.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0149853450576533058==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This patch fixes up some fallout from the merging of the udev and udevng
modules.

i)  The 'serial' modems in question are not necessarily serial modems at
all; for example, the N900 ISI modems appear as network devices and don't
have a devnode.  This patch relaxes the requirement that a devnode exist.

ii)  The modem driver was being set to 'legacy', which is a remnant of
an earlier approach to merging these modules.  The driver needs to be
properly set to the value of the OFONO_DRIVER property in order for the
setup function to be found.

iii)  The serial modem's private data was being added to the modem
structure incorrectly...

In particular point iii) above shows that there is essentially nobody
using these devices which makes modifications in this area tricky.
---
 plugins/udevng.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/plugins/udevng.c b/plugins/udevng.c
index 518eda8..9d00bb8 100644
--- a/plugins/udevng.c
+++ b/plugins/udevng.c
@@ -1325,7 +1325,7 @@ static void add_serial_device(struct udev_device *dev)
 =

 	devnode =3D udev_device_get_devnode(dev);
 =

-	if (!syspath || !devname || !devpath || !devnode)
+	if (!syspath || !devpath)
 		return;
 =

 	modem =3D g_hash_table_lookup(modem_list, syspath);
@@ -1337,7 +1337,7 @@ static void add_serial_device(struct udev_device *dev)
 		modem->type =3D MODEM_TYPE_SERIAL;
 		modem->syspath =3D g_strdup(syspath);
 		modem->devname =3D g_strdup(devname);
-		modem->driver =3D g_strdup("legacy");
+		modem->driver =3D g_strdup(driver);
 =

 		g_hash_table_replace(modem_list, modem->syspath, modem);
 	}
@@ -1357,7 +1357,7 @@ static void add_serial_device(struct udev_device *dev)
 	info->subsystem =3D g_strdup(subsystem);
 	info->dev =3D udev_device_ref(dev);
 =

-	modem->devices =3D g_slist_append(modem->devices, info);
+	modem->serial =3D info;
 }
 =

 static void add_device(const char *syspath, const char *devname,
-- =

2.9.3


--===============0149853450576533058==--

