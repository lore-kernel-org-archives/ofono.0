Content-Type: multipart/mixed; boundary="===============0969794416053066296=="
MIME-Version: 1.0
From: Jonas Bonn <jonas@southpole.se>
Subject: [PATCH 1/1] udev: set driver for serial drivers
Date: Fri, 08 Sep 2017 10:07:17 +0200
Message-ID: <20170908080717.4441-1-jonas@southpole.se>
In-Reply-To: <20170908060611.GE3@computer.craftyguy.net>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0969794416053066296==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The switch away from udev.c to udevng.c for serial modems ended up
having a hardcoded driver "legacy" set on them.  This breaks as the
setup routine for the device will never be found this way.  This patch
sets the correct driver for the device.
---
Hi Clayton,

Here's another patch that hopefully gets the N900 a bit further down
the road to initialization.  Apply this _on top of_ the earlier patch
I sent you; they are both needed.

Cheers,
Jonas

 plugins/udevng.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/plugins/udevng.c b/plugins/udevng.c
index 241fcda..5767259 100644
--- a/plugins/udevng.c
+++ b/plugins/udevng.c
@@ -1335,7 +1335,7 @@ static void add_serial_device(struct udev_device *dev)
 		modem->type =3D MODEM_TYPE_SERIAL;
 		modem->syspath =3D g_strdup(syspath);
 		modem->devname =3D g_strdup(devname);
-		modem->driver =3D g_strdup("legacy");
+		modem->driver =3D g_strdup(driver);
 =

 		g_hash_table_replace(modem_list, modem->syspath, modem);
 	}
-- =

2.9.3


--===============0969794416053066296==--

