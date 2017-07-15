Content-Type: multipart/mixed; boundary="===============7565023526828292607=="
MIME-Version: 1.0
From: Matthijs Kooijman <matthijs@stdin.nl>
Subject: [PATCH] at/cdma/ifxmodem: Use /dev/net/tun to check for TUN support
Date: Sat, 15 Jul 2017 14:09:15 +0200
Message-ID: <20170715120915.19301-1-matthijs@stdin.nl>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7565023526828292607==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Previously, these drivers would check /sys/devices/virtual/misc/tun to
see if TUN is supported, and bail out otherwise. However, the tun module
can sometimes be autoloaded by opening the /dev/net/tun file. In this
case the /dev file already exists, but the /sys file only gets created
after the modul is loaded.

Additionally, the ppp code does not use the /sys file, but only the
/dev file, so checking for the existence of the latter seems a better
indicator of expected success.

---
This patch was only tested with the atmodem driver, but the other two
seem similar enough that it should work there as well.
---
 drivers/atmodem/gprs-context.c  | 4 ++--
 drivers/cdmamodem/connman.c     | 4 ++--
 drivers/ifxmodem/gprs-context.c | 4 ++--
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/atmodem/gprs-context.c b/drivers/atmodem/gprs-context.c
index 9b9679e8..42ec556d 100644
--- a/drivers/atmodem/gprs-context.c
+++ b/drivers/atmodem/gprs-context.c
@@ -43,7 +43,7 @@
 #include "atmodem.h"
 #include "vendor.h"
 =

-#define TUN_SYSFS_DIR "/sys/devices/virtual/misc/tun"
+#define TUN_DEV "/dev/net/tun"
 =

 #define STATIC_IP_NETMASK "255.255.255.255"
 =

@@ -426,7 +426,7 @@ static int at_gprs_context_probe(struct ofono_gprs_cont=
ext *gc,
 =

 	DBG("");
 =

-	if (stat(TUN_SYSFS_DIR, &st) < 0) {
+	if (stat(TUN_DEV, &st) < 0) {
 		ofono_error("Missing support for TUN/TAP devices");
 		return -ENODEV;
 	}
diff --git a/drivers/cdmamodem/connman.c b/drivers/cdmamodem/connman.c
index 8c3265a1..7f0f54b6 100644
--- a/drivers/cdmamodem/connman.c
+++ b/drivers/cdmamodem/connman.c
@@ -43,7 +43,7 @@
 #include "cdmamodem.h"
 #include "drivers/atmodem/vendor.h"
 =

-#define TUN_SYSFS_DIR "/sys/devices/virtual/misc/tun"
+#define TUN_DEV "/dev/net/tun"
 =

 #define STATIC_IP_NETMASK "255.255.255.255"
 =

@@ -285,7 +285,7 @@ static int cdma_connman_probe(struct ofono_cdma_connman=
 *cm,
 =

 	DBG("");
 =

-	if (stat(TUN_SYSFS_DIR, &st) < 0) {
+	if (stat(TUN_DEV, &st) < 0) {
 		ofono_error("Missing support for TUN/TAP devices");
 		return -ENODEV;
 	}
diff --git a/drivers/ifxmodem/gprs-context.c b/drivers/ifxmodem/gprs-contex=
t.c
index b7b102b9..52a3672c 100644
--- a/drivers/ifxmodem/gprs-context.c
+++ b/drivers/ifxmodem/gprs-context.c
@@ -42,7 +42,7 @@
 =

 #include "ifxmodem.h"
 =

-#define TUN_SYSFS_DIR "/sys/devices/virtual/misc/tun"
+#define TUN_DEV "/dev/net/tun"
 =

 #define STATIC_IP_NETMASK "255.255.255.255"
 =

@@ -470,7 +470,7 @@ static int ifx_gprs_context_probe(struct ofono_gprs_con=
text *gc,
 =

 	DBG("");
 =

-	if (stat(TUN_SYSFS_DIR, &st) < 0) {
+	if (stat(TUN_DEV, &st) < 0) {
 		ofono_error("Missing support for TUN/TAP devices");
 		return -ENODEV;
 	}
-- =

2.11.0


--===============7565023526828292607==--

