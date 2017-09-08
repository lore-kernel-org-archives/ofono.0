Content-Type: multipart/mixed; boundary="===============6361661401181040007=="
MIME-Version: 1.0
From: Jonas Bonn <jonas@southpole.se>
Subject: [PATCH 1/1] udev: devnode is not a required modem property
Date: Fri, 08 Sep 2017 05:17:58 +0200
Message-ID: <20170908031758.32608-1-jonas@southpole.se>
In-Reply-To: <20170908013840.GD3@computer.craftyguy.net>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6361661401181040007==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

A devnode does not always exist; the Nokia N900, for example, does not
provide one for its modem.

This patch relaxes the check on device properties to exclude the
requirement of a devnode.

The "Device" property is not used by the n900 or u8500 drivers, so drop
setting this property when setting up these devices.
---

Hi Clayton,

Could you try this patch and see if the N900 is detected?

Thanks,
Jonas

 plugins/udevng.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/plugins/udevng.c b/plugins/udevng.c
index 518eda8..241fcda 100644
--- a/plugins/udevng.c
+++ b/plugins/udevng.c
@@ -1013,8 +1013,6 @@ static gboolean setup_isi_serial(struct modem_info* m=
odem)
 	if (value)
 		ofono_modem_set_integer(modem->modem, "Address", atoi(value));
 =

-	ofono_modem_set_string(modem->modem, "Device", info->devnode);
-
 	return TRUE;
 }
 =

@@ -1325,7 +1323,7 @@ static void add_serial_device(struct udev_device *dev)
 =

 	devnode =3D udev_device_get_devnode(dev);
 =

-	if (!syspath || !devname || !devpath || !devnode)
+	if (!syspath || !devpath)
 		return;
 =

 	modem =3D g_hash_table_lookup(modem_list, syspath);
-- =

2.9.3


--===============6361661401181040007==--

