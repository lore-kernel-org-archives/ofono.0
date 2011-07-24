Content-Type: multipart/mixed; boundary="===============5478887190465357421=="
MIME-Version: 1.0
From: Bertrand Aygon <bertrand.aygon@intel.com>
Subject: [PATCH] cdmamodem: check for TUN/TAP devices in ConnMan atom.
Date: Sun, 24 Jul 2011 05:32:42 +0200
Message-ID: <1311478362-18474-1-git-send-email-bertrand.aygon@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5478887190465357421==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 drivers/cdmamodem/connman.c |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/drivers/cdmamodem/connman.c b/drivers/cdmamodem/connman.c
index ce9a748..0df93eb 100644
--- a/drivers/cdmamodem/connman.c
+++ b/drivers/cdmamodem/connman.c
@@ -28,6 +28,7 @@
 #include <stdlib.h>
 #include <stdio.h>
 #include <errno.h>
+#include <sys/stat.h>
 =

 #include <glib.h>
 =

@@ -41,6 +42,8 @@
 =

 #include "cdmamodem.h"
 =

+#define TUN_SYSFS_DIR "/sys/devices/virtual/misc/tun"
+
 #define STATIC_IP_NETMASK "255.255.255.255"
 =

 static const char *none_prefix[] =3D { NULL };
@@ -240,9 +243,15 @@ static int cdma_connman_probe(struct ofono_cdma_connma=
n *cm,
 {
 	GAtChat *chat =3D data;
 	struct connman_data *cd;
+	struct stat st;
 =

 	DBG("");
 =

+	if (stat(TUN_SYSFS_DIR, &st) < 0) {
+		ofono_error("Missing support for TUN/TAP devices");
+		return -ENODEV;
+	}
+
 	cd =3D g_try_new0(struct connman_data, 1);
 	if (cd =3D=3D NULL)
 		return -ENOMEM;
-- =

1.7.4.1

---------------------------------------------------------------------
Intel Corporation SAS (French simplified joint stock company)
Registered headquarters: "Les Montalets"- 2, rue de Paris, =

92196 Meudon Cedex, France
Registration Number:  302 456 199 R.C.S. NANTERRE
Capital: 4,572,000 Euros

This e-mail and any attachments may contain confidential material for
the sole use of the intended recipient(s). Any review or distribution
by others is strictly prohibited. If you are not the intended
recipient, please contact the sender and delete all copies.

--===============5478887190465357421==--

