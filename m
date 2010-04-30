Content-Type: multipart/mixed; boundary="===============0292702877391001521=="
MIME-Version: 1.0
From: Kalle Valo <kalle.valo@canonical.com>
Subject: [PATCH v2 2/6] atmodem: create struct atmodem_network_registration
Date: Fri, 30 Apr 2010 15:55:05 +0300
Message-ID: <20100430125505.30019.63489.stgit@potku.valot.fi>
In-Reply-To: <20100430124405.30019.86945.stgit@potku.valot.fi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0292702877391001521==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Needed to provide more channels to atmodem network_registration module.
---

 drivers/atmodem/network-registration.c |    7 ++++---
 drivers/atmodem/network-registration.h |   26 ++++++++++++++++++++++++++
 plugins/atgen.c                        |    7 ++++++-
 plugins/calypso.c                      |    7 ++++++-
 plugins/em770.c                        |    2 ++
 plugins/g1.c                           |    8 +++++++-
 plugins/hso.c                          |    7 ++++++-
 plugins/huawei.c                       |    9 ++++++++-
 plugins/mbm.c                          |    7 ++++++-
 plugins/novatel.c                      |    9 ++++++++-
 plugins/palmpre.c                      |    7 ++++++-
 plugins/phonesim.c                     |    9 +++++++--
 plugins/ste.c                          |    8 +++++++-
 13 files changed, 99 insertions(+), 14 deletions(-)
 create mode 100644 drivers/atmodem/network-registration.h

diff --git a/drivers/atmodem/network-registration.c b/drivers/atmodem/netwo=
rk-registration.c
index f7aafbe..777cbc3 100644
--- a/drivers/atmodem/network-registration.c
+++ b/drivers/atmodem/network-registration.c
@@ -40,6 +40,7 @@
 =

 #include "atmodem.h"
 #include "vendor.h"
+#include "network-registration.h"
 =

 static const char *none_prefix[] =3D { NULL };
 static const char *creg_prefix[] =3D { "+CREG:", NULL };
@@ -972,17 +973,17 @@ error:
 static int at_netreg_probe(struct ofono_netreg *netreg, unsigned int vendo=
r,
 				void *data)
 {
-	GAtChat *chat =3D data;
+	struct atmodem_network_registration *nr =3D data;
 	struct netreg_data *nd;
 =

 	nd =3D g_new0(struct netreg_data, 1);
 =

-	nd->chat =3D chat;
+	nd->chat =3D nr->chat;
 	nd->vendor =3D vendor;
 	nd->tech =3D -1;
 	ofono_netreg_set_data(netreg, nd);
 =

-	g_at_chat_send(chat, "AT+CREG=3D?", creg_prefix,
+	g_at_chat_send(nd->chat, "AT+CREG=3D?", creg_prefix,
 			at_creg_test_cb, netreg, NULL);
 =

 	return 0;
diff --git a/drivers/atmodem/network-registration.h b/drivers/atmodem/netwo=
rk-registration.h
new file mode 100644
index 0000000..506ed7d
--- /dev/null
+++ b/drivers/atmodem/network-registration.h
@@ -0,0 +1,26 @@
+/*
+ *
+ *  oFono - Open Source Telephony
+ *
+ *  Copyright (C) 2010 Canonical Ltd. All rights reserved.
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License version 2 as
+ *  published by the Free Software Foundation.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301 =
 USA
+ *
+ */
+
+struct atmodem_network_registration
+{
+	/* primary chat channel */
+	GAtChat *chat;
+};
diff --git a/plugins/atgen.c b/plugins/atgen.c
index 7c38fde..7d3b280 100644
--- a/plugins/atgen.c
+++ b/plugins/atgen.c
@@ -25,6 +25,7 @@
 =

 #include <errno.h>
 #include <stdlib.h>
+#include <string.h>
 =

 #include <glib.h>
 #include <gatchat.h>
@@ -50,6 +51,7 @@
 #include <ofono/voicecall.h>
 =

 #include <drivers/atmodem/sim-poll.h>
+#include <drivers/atmodem/network-registration.h>
 =

 static const char *tty_opts[] =3D {
 	"Baud",
@@ -174,13 +176,16 @@ static void atgen_post_sim(struct ofono_modem *modem)
 {
 	GAtChat *chat =3D ofono_modem_get_data(modem);
 	struct ofono_message_waiting *mw;
+	struct atmodem_network_registration atmodem_netreg;
 =

 	DBG("%p", modem);
 =

+	memset(&atmodem_netreg, 0, sizeof(atmodem_netreg));
+
 	ofono_ussd_create(modem, 0, "atmodem", chat);
 	ofono_call_forwarding_create(modem, 0, "atmodem", chat);
 	ofono_call_settings_create(modem, 0, "atmodem", chat);
-	ofono_netreg_create(modem, 0, "atmodem", chat);
+	ofono_netreg_create(modem, 0, "atmodem", &atmodem_netreg);
 	ofono_call_meter_create(modem, 0, "atmodem", chat);
 	ofono_call_barring_create(modem, 0, "atmodem", chat);
 	ofono_ssn_create(modem, 0, "atmodem", chat);
diff --git a/plugins/calypso.c b/plugins/calypso.c
index 60f3242..5497d67 100644
--- a/plugins/calypso.c
+++ b/plugins/calypso.c
@@ -56,6 +56,7 @@
 #include <ofono/voicecall.h>
 =

 #include <drivers/atmodem/vendor.h>
+#include <drivers/atmodem/network-registration.h>
 =

 #define CALYPSO_POWER_PATH "/sys/bus/platform/devices/neo1973-pm-gsm.0/pow=
er_on"
 #define CALYPSO_RESET_PATH "/sys/bus/platform/devices/neo1973-pm-gsm.0/res=
et"
@@ -445,14 +446,18 @@ static void calypso_post_sim(struct ofono_modem *mode=
m)
 {
 	struct calypso_data *data =3D ofono_modem_get_data(modem);
 	struct ofono_message_waiting *mw;
+	struct atmodem_network_registration atmodem_netreg;
 =

 	DBG("");
 =

+	memset(&atmodem_netreg, 0, sizeof(atmodem_netreg));
+	atmodem_netreg.chat =3D data->dlcs[NETREG_DLC];
+
 	ofono_ussd_create(modem, 0, "atmodem", data->dlcs[AUX_DLC]);
 	ofono_call_forwarding_create(modem, 0, "atmodem", data->dlcs[AUX_DLC]);
 	ofono_call_settings_create(modem, 0, "atmodem", data->dlcs[AUX_DLC]);
 	ofono_netreg_create(modem, OFONO_VENDOR_CALYPSO, "atmodem",
-				data->dlcs[NETREG_DLC]);
+			    &atmodem_netreg);
 	ofono_call_meter_create(modem, 0, "atmodem", data->dlcs[AUX_DLC]);
 	ofono_call_barring_create(modem, 0, "atmodem", data->dlcs[AUX_DLC]);
 	ofono_ssn_create(modem, 0, "atmodem", data->dlcs[AUX_DLC]);
diff --git a/plugins/em770.c b/plugins/em770.c
index de82f94..bf7978d 100644
--- a/plugins/em770.c
+++ b/plugins/em770.c
@@ -26,6 +26,7 @@
 #include <stdio.h>
 #include <errno.h>
 #include <stdlib.h>
+#include <string.h>
 =

 #include <glib.h>
 #include <gatchat.h>
@@ -50,6 +51,7 @@
 #include <ofono/gprs.h>
 #include <ofono/voicecall.h>
 =

+#include <drivers/atmodem/network-registration.h>
 #include <drivers/atmodem/vendor.h>
 =

 struct em770_data {
diff --git a/plugins/g1.c b/plugins/g1.c
index fa96eb1..45d0290 100644
--- a/plugins/g1.c
+++ b/plugins/g1.c
@@ -25,6 +25,7 @@
 =

 #include <stdlib.h>
 #include <errno.h>
+#include <string.h>
 =

 #include <glib.h>
 #include <gatchat.h>
@@ -48,6 +49,7 @@
 #include <ofono/ussd.h>
 #include <ofono/voicecall.h>
 =

+#include <drivers/atmodem/network-registration.h>
 #include <drivers/atmodem/vendor.h>
 =

 static void g1_debug(const char *str, void *data)
@@ -172,13 +174,17 @@ static void g1_post_sim(struct ofono_modem *modem)
 {
 	GAtChat *chat =3D ofono_modem_get_data(modem);
 	struct ofono_message_waiting *mw;
+	struct atmodem_network_registration atmodem_netreg;
 =

 	DBG("");
 =

+	memset(&atmodem_netreg, 0, sizeof(atmodem_netreg));
+	atmodem_netreg.chat =3D chat;
+
 	ofono_ussd_create(modem, 0, "atmodem", chat);
 	ofono_call_forwarding_create(modem, 0, "atmodem", chat);
 	ofono_call_settings_create(modem, 0, "atmodem", chat);
-	ofono_netreg_create(modem, 0, "atmodem", chat);
+	ofono_netreg_create(modem, 0, "atmodem", &atmodem_netreg);
 	ofono_call_meter_create(modem, 0, "atmodem", chat);
 	ofono_call_barring_create(modem, 0, "atmodem", chat);
 	ofono_ssn_create(modem, 0, "atmodem", chat);
diff --git a/plugins/hso.c b/plugins/hso.c
index 26f6c81..67e5335 100644
--- a/plugins/hso.c
+++ b/plugins/hso.c
@@ -44,6 +44,7 @@
 #include <ofono/log.h>
 =

 #include <drivers/atmodem/gprs.h>
+#include <drivers/atmodem/network-registration.h>
 #include <drivers/atmodem/vendor.h>
 =

 static const char *none_prefix[] =3D { NULL };
@@ -215,11 +216,15 @@ static void hso_post_sim(struct ofono_modem *modem)
 	struct ofono_gprs *gprs;
 	struct ofono_gprs_context *gc;
 	struct atmodem_gprs atmodem_gprs;
+	struct atmodem_network_registration atmodem_netreg;
 =

 	DBG("%p", modem);
 =

+	memset(&atmodem_netreg, 0, sizeof(atmodem_netreg));
+	atmodem_netreg.chat =3D data->app;
+
 	ofono_netreg_create(modem, OFONO_VENDOR_OPTION_HSO,
-				"atmodem", data->app);
+				"atmodem", &atmodem_netreg);
 	ofono_sms_create(modem, 0, "atmodem", data->app);
 =

 	memset(&atmodem_gprs, 0, sizeof(atmodem_gprs));
diff --git a/plugins/huawei.c b/plugins/huawei.c
index df4d177..94cbb68 100644
--- a/plugins/huawei.c
+++ b/plugins/huawei.c
@@ -26,6 +26,7 @@
 #include <stdio.h>
 #include <errno.h>
 #include <stdlib.h>
+#include <string.h>
 =

 #include <glib.h>
 #include <gatchat.h>
@@ -42,6 +43,7 @@
 #include <ofono/voicecall.h>
 #include <ofono/log.h>
 =

+#include <drivers/atmodem/network-registration.h>
 #include <drivers/atmodem/vendor.h>
 =

 struct huawei_data {
@@ -177,10 +179,15 @@ static void huawei_pre_sim(struct ofono_modem *modem)
 static void huawei_post_sim(struct ofono_modem *modem)
 {
 	struct huawei_data *data =3D ofono_modem_get_data(modem);
+	struct atmodem_network_registration atmodem_netreg;
 =

 	DBG("%p", modem);
 =

-	ofono_netreg_create(modem, OFONO_VENDOR_HUAWEI, "atmodem", data->chat);
+	memset(&atmodem_netreg, 0, sizeof(atmodem_netreg));
+	atmodem_netreg.chat =3D data->chat;
+
+	ofono_netreg_create(modem, OFONO_VENDOR_HUAWEI, "atmodem",
+			    &atmodem_netreg);
 	ofono_sms_create(modem, OFONO_VENDOR_QUALCOMM_MSM, "atmodem", data->chat);
 }
 =

diff --git a/plugins/mbm.c b/plugins/mbm.c
index 518aaaa..226ec11 100644
--- a/plugins/mbm.c
+++ b/plugins/mbm.c
@@ -53,6 +53,7 @@
 #include <ofono/gprs-context.h>
 #include <ofono/log.h>
 #include <drivers/atmodem/gprs.h>
+#include <drivers/atmodem/network-registration.h>
 #include <drivers/atmodem/vendor.h>
 =

 static const char *cfun_prefix[] =3D { "+CFUN:", NULL };
@@ -304,9 +305,13 @@ static void mbm_post_sim(struct ofono_modem *modem)
 	struct ofono_gprs *gprs;
 	struct ofono_gprs_context *gc;
 	struct atmodem_gprs atmodem_gprs;
+	struct atmodem_network_registration atmodem_netreg;
 =

 	DBG("%p", modem);
 =

+	memset(&atmodem_netreg, 0, sizeof(atmodem_netreg));
+	atmodem_netreg.chat =3D data->modem_port;
+
 	ofono_call_forwarding_create(modem, 0, "atmodem", data->modem_port);
 	ofono_call_settings_create(modem, 0, "atmodem", data->modem_port);
 	ofono_call_meter_create(modem, 0, "atmodem", data->modem_port);
@@ -314,7 +319,7 @@ static void mbm_post_sim(struct ofono_modem *modem)
 =

 	ofono_ussd_create(modem, 0, "atmodem", data->modem_port);
 	ofono_netreg_create(modem, OFONO_VENDOR_MBM, "atmodem",
-				data->modem_port);
+			    &atmodem_netreg);
 	ofono_phonebook_create(modem, 0, "atmodem", data->modem_port);
 	ofono_ssn_create(modem, 0, "atmodem", data->modem_port);
 	ofono_sms_create(modem, 0, "atmodem", data->modem_port);
diff --git a/plugins/novatel.c b/plugins/novatel.c
index 792e17f..b0ea27f 100644
--- a/plugins/novatel.c
+++ b/plugins/novatel.c
@@ -26,6 +26,7 @@
 #include <stdio.h>
 #include <errno.h>
 #include <stdlib.h>
+#include <string.h>
 =

 #include <glib.h>
 #include <gatchat.h>
@@ -39,6 +40,8 @@
 #include <ofono/sms.h>
 #include <ofono/log.h>
 =

+#include <drivers/atmodem/network-registration.h>
+
 struct novatel_data {
 	GAtChat *chat;
 };
@@ -162,10 +165,14 @@ static void novatel_pre_sim(struct ofono_modem *modem)
 static void novatel_post_sim(struct ofono_modem *modem)
 {
 	struct novatel_data *data =3D ofono_modem_get_data(modem);
+	struct atmodem_network_registration atmodem_netreg;
 =

 	DBG("%p", modem);
 =

-	ofono_netreg_create(modem, 0, "atmodem", data->chat);
+	memset(&atmodem_netreg, 0, sizeof(atmodem_netreg));
+	atmodem_netreg.chat =3D data->chat;
+
+	ofono_netreg_create(modem, 0, "atmodem", &atmodem_netreg);
 }
 =

 static struct ofono_modem_driver novatel_driver =3D {
diff --git a/plugins/palmpre.c b/plugins/palmpre.c
index 9292e55..509224f 100644
--- a/plugins/palmpre.c
+++ b/plugins/palmpre.c
@@ -46,6 +46,7 @@
 #include <ofono/sms.h>
 =

 #include <drivers/atmodem/gprs.h>
+#include <drivers/atmodem/network-registration.h>
 #include <drivers/atmodem/vendor.h>
 =

 struct palmpre_data {
@@ -192,10 +193,14 @@ static void palmpre_post_sim(struct ofono_modem *mode=
m)
 	struct ofono_gprs *gprs;
 	struct ofono_gprs_context *gc;
 	struct atmodem_gprs atmodem_gprs;
+	struct atmodem_network_registration atmodem_netreg;
 =

 	DBG("%p", modem);
 =

-	ofono_netreg_create(modem, 0, "atmodem", data->chat);
+	memset(&atmodem_netreg, 0, sizeof(atmodem_netreg));
+	atmodem_netreg.chat =3D data->chat;
+
+	ofono_netreg_create(modem, 0, "atmodem", &atmodem_netreg);
 	ofono_sms_create(modem, OFONO_VENDOR_QUALCOMM_MSM, "atmodem",
 				data->chat);
 	ofono_phonebook_create(modem, 0, "atmodem", data->chat);
diff --git a/plugins/phonesim.c b/plugins/phonesim.c
index becd06a..f5058bb 100644
--- a/plugins/phonesim.c
+++ b/plugins/phonesim.c
@@ -59,6 +59,7 @@
 #include <ofono/gprs-context.h>
 =

 #include <drivers/atmodem/gprs.h>
+#include <drivers/atmodem/network-registration.h>
 #include <drivers/atmodem/vendor.h>
 #include <drivers/atmodem/sim-poll.h>
 =

@@ -303,6 +304,7 @@ static void phonesim_post_sim(struct ofono_modem *modem)
 	struct ofono_gprs *gprs;
 	struct ofono_gprs_context *gc;
 	struct atmodem_gprs atmodem_gprs;
+	struct atmodem_network_registration atmodem_netreg;
 =

 	DBG("%p", modem);
 =

@@ -310,12 +312,15 @@ static void phonesim_post_sim(struct ofono_modem *mod=
em)
 	ofono_call_forwarding_create(modem, 0, "atmodem", data->chat);
 	ofono_call_settings_create(modem, 0, "atmodem", data->chat);
 =

+	memset(&atmodem_netreg, 0, sizeof(atmodem_netreg));
+	atmodem_netreg.chat =3D data->chat;
+
 	if (data->calypso)
 		ofono_netreg_create(modem, OFONO_VENDOR_CALYPSO,
-							"atmodem", data->chat);
+				    "atmodem", &atmodem_netreg);
 	else
 		ofono_netreg_create(modem, OFONO_VENDOR_PHONESIM,
-							"atmodem", data->chat);
+				    "atmodem", &atmodem_netreg);
 =

 	ofono_call_meter_create(modem, 0, "atmodem", data->chat);
 	ofono_call_barring_create(modem, 0, "atmodem", data->chat);
diff --git a/plugins/ste.c b/plugins/ste.c
index a744797..68ff792 100644
--- a/plugins/ste.c
+++ b/plugins/ste.c
@@ -55,6 +55,7 @@
 #include <ofono/gprs.h>
 #include <ofono/gprs-context.h>
 #include <drivers/atmodem/gprs.h>
+#include <drivers/atmodem/network-registration.h>
 #include <drivers/atmodem/vendor.h>
 =

 #include <drivers/stemodem/caif_socket.h>
@@ -227,13 +228,18 @@ static void ste_post_sim(struct ofono_modem *modem)
 	struct ofono_gprs *gprs;
 	struct ofono_gprs_context *gc;
 	struct atmodem_gprs atmodem_gprs;
+	struct atmodem_network_registration atmodem_netreg;
 =

 	DBG("%p", modem);
 =

+	memset(&atmodem_netreg, 0, sizeof(atmodem_netreg));
+	atmodem_netreg.chat =3D data->chat;
+
 	ofono_ussd_create(modem, 0, "atmodem", data->chat);
 	ofono_call_forwarding_create(modem, 0, "atmodem", data->chat);
 	ofono_call_settings_create(modem, 0, "atmodem", data->chat);
-	ofono_netreg_create(modem, OFONO_VENDOR_STE, "atmodem", data->chat);
+	ofono_netreg_create(modem, OFONO_VENDOR_STE, "atmodem",
+			    &atmodem_netreg);
 	ofono_call_meter_create(modem, 0, "atmodem", data->chat);
 	ofono_call_barring_create(modem, 0, "atmodem", data->chat);
 	ofono_ssn_create(modem, 0, "atmodem", data->chat);


--===============0292702877391001521==--

