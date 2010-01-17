Content-Type: multipart/mixed; boundary="===============3027306604175408966=="
MIME-Version: 1.0
From: sjur.brandeland@stericsson.com
Subject: [RFC 1/3] STE-plugin: Add vendor STE
Date: Sun, 17 Jan 2010 18:28:30 +0100
Message-ID: <1263749312-6567-2-git-send-email-sjur.brandeland@stericsson.com>
In-Reply-To: <1263749312-6567-1-git-send-email-sjur.brandeland@stericsson.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3027306604175408966==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Sjur Brandeland <sjur.brandeland@stericsson.com>

This patch add STE as vendor, and a few adjustments needed in "atmodem" =

for ST-Ericsson modem.

---
 drivers/atmodem/gprs.c   |   15 +++++++++++++--
 drivers/atmodem/vendor.h |    5 +++++
 plugins/modemconf.c      |    5 +++++
 3 files changed, 23 insertions(+), 2 deletions(-)

diff --git a/drivers/atmodem/gprs.c b/drivers/atmodem/gprs.c
index 76085d9..305f22f 100644
--- a/drivers/atmodem/gprs.c
+++ b/drivers/atmodem/gprs.c
@@ -17,6 +17,10 @@
  *  along with this program; if not, write to the Free Software
  *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301 =
 USA
  *
+ *  Copyright (C) 2010 ST-Ericsson AB.
+ *  Author: Marit Henriksen, marit.xx.henriksen(a)stericsson.com.
+ *  STE specific implementation.
+ *
  */
 =

 #ifdef HAVE_CONFIG_H
@@ -38,6 +42,7 @@
 #include "gatresult.h"
 =

 #include "atmodem.h"
+#include "vendor.h"
 =

 static const char *cgreg_prefix[] =3D { "+CGREG:", NULL };
 static const char *cgdcont_prefix[] =3D { "+CGDCONT:", NULL };
@@ -45,6 +50,7 @@ static const char *none_prefix[] =3D { NULL };
 =

 struct gprs_data {
 	GAtChat *chat;
+	unsigned int vendor;
 };
 =

 static void at_cgatt_cb(gboolean ok, GAtResult *result, gpointer user_data)
@@ -216,7 +222,12 @@ static void at_cgreg_test_cb(gboolean ok, GAtResult *r=
esult,
 =

 	g_at_chat_send(gd->chat, cmd, none_prefix, NULL, NULL, NULL);
 	g_at_chat_send(gd->chat, "AT+CGAUTO=3D0", none_prefix, NULL, NULL, NULL);
-	g_at_chat_send(gd->chat, "AT+CGEREP=3D2,1", none_prefix,
+
+	if (gd->vendor =3D=3D OFONO_VENDOR_STE)
+		g_at_chat_send(gd->chat, "AT+CGEREP=3D1,0", none_prefix,
+			gprs_initialized, gprs, NULL);
+	else
+		g_at_chat_send(gd->chat, "AT+CGEREP=3D2,1", none_prefix,
 			gprs_initialized, gprs, NULL);
 	return;
 =

@@ -289,7 +300,7 @@ static int at_gprs_probe(struct ofono_gprs *gprs,
 =

 	gd =3D g_new0(struct gprs_data, 1);
 	gd->chat =3D chat;
-
+	gd->vendor =3D vendor;
 	ofono_gprs_set_data(gprs, gd);
 =

 	g_at_chat_send(chat, "AT+CGDCONT=3D?", cgdcont_prefix,
diff --git a/drivers/atmodem/vendor.h b/drivers/atmodem/vendor.h
index 8d9ed47..d7b5210 100644
--- a/drivers/atmodem/vendor.h
+++ b/drivers/atmodem/vendor.h
@@ -17,11 +17,16 @@
  *  along with this program; if not, write to the Free Software
  *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301 =
 USA
  *
+ *  Copyright (C) 2010 ST-Ericsson AB.
+ *  Author: Marit Henriksen, marit.xx.henriksen(a)stericsson.com.
+ *  STE specific implementation.
+ *
  */
 =

 enum ofono_vendor {
 	OFONO_VENDOR_GENERIC =3D 0,
 	OFONO_VENDOR_CALYPSO,
+	OFONO_VENDOR_STE,
 	OFONO_VENDOR_QUALCOMM_MSM,
 	OFONO_VENDOR_OPTION_HSO,
 };
diff --git a/plugins/modemconf.c b/plugins/modemconf.c
index c8c261f..41c7428 100644
--- a/plugins/modemconf.c
+++ b/plugins/modemconf.c
@@ -17,6 +17,10 @@
  *  along with this program; if not, write to the Free Software
  *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301 =
 USA
  *
+ *  Copyright (C) 2010 ST-Ericsson AB.
+ *  Author: Marit Henriksen, marit.xx.henriksen(a)stericsson.com.
+ *  STE specific implementation.
+ *
  */
 =

 #ifdef HAVE_CONFIG_H
@@ -128,6 +132,7 @@ static struct ofono_modem *create_modem(GKeyFile *keyfi=
le, const char *group)
 		set_address(modem, keyfile, group);
 =

 	if (!g_strcmp0(driver, "atgen") || !g_strcmp0(driver, "g1") ||
+						!g_strcmp0(driver, "ste") ||
 						!g_strcmp0(driver, "calypso") ||
 						!g_strcmp0(driver, "hfp") ||
 						!g_strcmp0(driver, "palmpre"))
-- =

1.6.0.4


--===============3027306604175408966==--

