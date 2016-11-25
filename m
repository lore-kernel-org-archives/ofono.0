Content-Type: multipart/mixed; boundary="===============3023072096391913685=="
MIME-Version: 1.0
From: djalal@endocode.com
Subject: [PATCH 4/5] ubloxmodem: intialize and register the netmon driver
Date: Fri, 25 Nov 2016 15:00:14 +0100
Message-ID: <1480082415-30822-5-git-send-email-djalal@endocode.com>
In-Reply-To: <1480082415-30822-1-git-send-email-djalal@endocode.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3023072096391913685==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Djalal Harouni <djalal@endocode.com>

This patch allows to intialize and register the ublox netmon driver.
---
 drivers/ubloxmodem/ubloxmodem.c | 2 ++
 drivers/ubloxmodem/ubloxmodem.h | 3 +++
 plugins/ublox.c                 | 3 +++
 3 files changed, 8 insertions(+)

diff --git a/drivers/ubloxmodem/ubloxmodem.c b/drivers/ubloxmodem/ubloxmode=
m.c
index 93cb928..a325b1f 100644
--- a/drivers/ubloxmodem/ubloxmodem.c
+++ b/drivers/ubloxmodem/ubloxmodem.c
@@ -36,6 +36,7 @@
 static int ubloxmodem_init(void)
 {
 	ublox_gprs_context_init();
+	ublox_netmon_init();
 	ublox_lte_init();
 =

 	return 0;
@@ -44,6 +45,7 @@ static int ubloxmodem_init(void)
 static void ubloxmodem_exit(void)
 {
 	ublox_gprs_context_exit();
+	ublox_netmon_exit();
 	ublox_lte_exit();
 }
 =

diff --git a/drivers/ubloxmodem/ubloxmodem.h b/drivers/ubloxmodem/ubloxmode=
m.h
index cf66412..bfb0106 100644
--- a/drivers/ubloxmodem/ubloxmodem.h
+++ b/drivers/ubloxmodem/ubloxmodem.h
@@ -26,5 +26,8 @@
 extern void ublox_gprs_context_init(void);
 extern void ublox_gprs_context_exit(void);
 =

+extern void ublox_netmon_init(void);
+extern void ublox_netmon_exit(void);
+
 extern void ublox_lte_init(void);
 extern void ublox_lte_exit(void);
diff --git a/plugins/ublox.c b/plugins/ublox.c
index 6d77df8..cc44de4 100644
--- a/plugins/ublox.c
+++ b/plugins/ublox.c
@@ -38,6 +38,7 @@
 #include <ofono/sim.h>
 #include <ofono/gprs.h>
 #include <ofono/gprs-context.h>
+#include <ofono/netmon.h>
 #include <ofono/lte.h>
 =

 #include <drivers/atmodem/atutil.h>
@@ -323,6 +324,8 @@ static void ublox_post_online(struct ofono_modem *modem)
 	struct ublox_data *data =3D ofono_modem_get_data(modem);
 =

 	ofono_netreg_create(modem, data->vendor_family, "atmodem", data->aux);
+
+	ofono_netmon_create(modem, data->vendor_family, "ubloxmodem", data);
 }
 =

 static struct ofono_modem_driver ublox_driver =3D {
-- =

2.5.5


--===============3023072096391913685==--

