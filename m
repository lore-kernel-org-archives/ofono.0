Content-Type: multipart/mixed; boundary="===============7570178051945857543=="
MIME-Version: 1.0
From: Pavel Machek <pavel@ucw.cz>
Subject: [PATCH 3/3] droid 4: Add probing.
Date: Tue, 15 Sep 2020 15:23:25 +0200
Message-ID: <20200915132325.GA13348@duo.ucw.cz>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7570178051945857543==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Probe Droid 4 modem. This should result in basic support working.
---
 Makefile.am      |   3 +
 plugins/droid.c  | 206 +++++++++++++++++++++++++++++++++++++++++++++++++++=
++++
 plugins/udevng.c |  31 +++++++++
 3 files changed, 240 insertions(+)
 create mode 100644 plugins/droid.c

diff --git a/Makefile.am b/Makefile.am
index fbb0eff4..9b3fbb8d 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -603,6 +603,9 @@ builtin_sources +=3D plugins/ublox.c
 builtin_modules +=3D xmm7xxx
 builtin_sources +=3D plugins/xmm7xxx.c
 =

+builtin_modules +=3D droid
+builtin_sources +=3D plugins/droid.c
+
 if BLUETOOTH
 if BLUEZ4
 builtin_modules +=3D sap
diff --git a/plugins/droid.c b/plugins/droid.c
new file mode 100644
index 00000000..220d440b
--- /dev/null
+++ b/plugins/droid.c
@@ -0,0 +1,206 @@
+/*
+ *
+ *  oFono - Open Source Telephony
+ *
+ *  Copyright (C) 2008-2011  Intel Corporation. All rights reserved.
+ *  Copyright (C) 2009  Collabora Ltd. All rights reserved.
+ *  Copyright (C) 2020  Pavel Machek. All rights reserved.
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
+#ifdef HAVE_CONFIG_H
+#include <config.h>
+#endif
+
+#include <stdlib.h>
+#include <errno.h>
+
+#include <glib.h>
+#include <gatchat.h>
+#include <gattty.h>
+
+#define OFONO_API_SUBJECT_TO_CHANGE
+#include <ofono/plugin.h>
+#include <ofono/log.h>
+#include <ofono/modem.h>
+#include <ofono/call-barring.h>
+#include <ofono/call-forwarding.h>
+#include <ofono/call-meter.h>
+#include <ofono/call-settings.h>
+#include <ofono/devinfo.h>
+#include <ofono/message-waiting.h>
+#include <ofono/netreg.h>
+#include <ofono/phonebook.h>
+#include <ofono/sim.h>
+#include <ofono/sms.h>
+#include <ofono/ussd.h>
+#include <ofono/voicecall.h>
+
+#include <drivers/atmodem/atutil.h>
+#include <drivers/atmodem/vendor.h>
+
+static void droid_debug(const char *str, void *user_data)
+{
+	const char *prefix =3D user_data;
+
+	ofono_info("%s%s", prefix, str);
+}
+
+/* Detect hardware, and initialize if found */
+static int droid_probe(struct ofono_modem *modem)
+{
+	DBG("");
+
+	return 0;
+}
+
+static void droid_remove(struct ofono_modem *modem)
+{
+	GAtChat *chat =3D ofono_modem_get_data(modem);
+
+	DBG("");
+
+	if (chat) {
+		g_at_chat_unref(chat);
+		ofono_modem_set_data(modem, NULL);
+	}
+}
+
+static void cfun_set_on_cb(gboolean ok, GAtResult *result, gpointer user_d=
ata)
+{
+	struct ofono_modem *modem =3D user_data;
+
+	DBG("");
+
+	if (ok)
+		ofono_modem_set_powered(modem, TRUE);
+}
+
+/* power up hardware */
+static int droid_enable(struct ofono_modem *modem)
+{
+	GAtChat *chat;
+
+	DBG("");
+
+	chat =3D at_util_open_device(modem, "Device", droid_debug, "", NULL);
+	ofono_modem_set_data(modem, chat);
+
+	/* ensure modem is in a known state; verbose on, echo/quiet off */
+	g_at_chat_send(chat, "ATE0Q0V1", NULL, NULL, NULL, NULL);
+
+	/* power up modem */
+	g_at_chat_send(chat, "AT+CFUN=3D1", NULL, cfun_set_on_cb, modem, NULL);
+
+	return 0;
+}
+
+static void cfun_set_off_cb(gboolean ok, GAtResult *result, gpointer user_=
data)
+{
+	struct ofono_modem *modem =3D user_data;
+	GAtChat *chat =3D ofono_modem_get_data(modem);
+
+	DBG("");
+
+	g_at_chat_unref(chat);
+	ofono_modem_set_data(modem, NULL);
+
+	if (ok)
+		ofono_modem_set_powered(modem, FALSE);
+}
+
+static int droid_disable(struct ofono_modem *modem)
+{
+	GAtChat *chat =3D ofono_modem_get_data(modem);
+
+	DBG("");
+
+	/* power down modem */
+	g_at_chat_cancel_all(chat);
+	g_at_chat_unregister_all(chat);
+	g_at_chat_send(chat, "AT+CFUN=3D0", NULL, cfun_set_off_cb, modem, NULL);
+
+	return -EINPROGRESS;
+}
+
+static void droid_pre_sim(struct ofono_modem *modem)
+{
+	GAtChat *chat =3D ofono_modem_get_data(modem);
+	struct ofono_sim *sim;
+
+	DBG("");
+
+	ofono_devinfo_create(modem, 0, "atmodem", chat);
+	sim =3D ofono_sim_create(modem, OFONO_VENDOR_DROID, "atmodem", chat);
+	ofono_voicecall_create(modem, OFONO_VENDOR_DROID, "atmodem", chat);
+
+	if (sim)
+		ofono_sim_inserted_notify(sim, TRUE);
+}
+
+static void droid_post_sim(struct ofono_modem *modem)
+{
+	GAtChat *chat =3D ofono_modem_get_data(modem);
+	struct ofono_message_waiting *mw;
+
+	DBG("");
+
+	ofono_ussd_create(modem, 0, "atmodem", chat);
+	ofono_call_forwarding_create(modem, 0, "atmodem", chat);
+	ofono_call_settings_create(modem, 0, "atmodem", chat);
+	ofono_netreg_create(modem, 0, "atmodem", chat);
+	/*
+	 * Droid 4 modem has problems with AT+CPUC?, avoid call meter for now.
+	 */
+	ofono_call_barring_create(modem, 0, "atmodem", chat);
+	ofono_sms_create(modem, OFONO_VENDOR_DROID, "atmodem", chat);
+	ofono_phonebook_create(modem, 0, "atmodem", chat);
+
+	mw =3D ofono_message_waiting_create(modem);
+	if (mw)
+		ofono_message_waiting_register(mw);
+}
+
+static struct ofono_modem_driver droid_driver =3D {
+	.name		=3D "droid",
+	.probe		=3D droid_probe,
+	.remove		=3D droid_remove,
+	.enable		=3D droid_enable,
+	.disable	=3D droid_disable,
+	.pre_sim	=3D droid_pre_sim,
+	.post_sim	=3D droid_post_sim,
+};
+
+static int droid_init(void)
+{
+	return ofono_modem_driver_register(&droid_driver);
+}
+
+static void droid_exit(void)
+{
+	ofono_modem_driver_unregister(&droid_driver);
+}
+
+/* Modem in Motorola Droid has few different interfaces:
+ * -- gsmmux over serial -- using very non-standard commands
+ * -- QMI -- unfortunately not usable without gsmmux
+ * -- standard AT over ttyUSB4 -- unfortunately quite broken
+ *
+ * This driver is for the standard AT commands.
+ */
+
+OFONO_PLUGIN_DEFINE(droid, "Motorola Droid modem driver", VERSION,
+			OFONO_PLUGIN_PRIORITY_DEFAULT, droid_init, droid_exit)
diff --git a/plugins/udevng.c b/plugins/udevng.c
index 4a38621b..14e6e2a7 100644
--- a/plugins/udevng.c
+++ b/plugins/udevng.c
@@ -712,6 +712,34 @@ static gboolean setup_telitqmi(struct modem_info *mode=
m)
 	return TRUE;
 }
 =

+static gboolean setup_droid(struct modem_info *modem)
+{
+	const char *at =3D NULL;
+	GSList *list;
+
+	DBG("%s", modem->syspath);
+
+	for (list =3D modem->devices; list; list =3D list->next) {
+		struct device_info *info =3D list->data;
+
+		DBG("%s %s %s %s %s", info->devnode, info->interface,
+				info->number, info->label, info->subsystem);
+
+		if (g_strcmp0(info->interface, "255/255/255") =3D=3D 0 &&
+				g_strcmp0(info->number, "04") =3D=3D 0) {
+			at =3D info->devnode;
+		}
+	}
+
+	if (at =3D=3D NULL)
+		return FALSE;
+
+	ofono_modem_set_string(modem->modem, "Device", at);
+	ofono_modem_set_driver(modem->modem, "droid");
+
+	return TRUE;
+}
+
 /* TODO: Not used as we have no simcom driver */
 static gboolean setup_simcom(struct modem_info *modem)
 {
@@ -1401,6 +1429,7 @@ static struct {
 	{ "gemalto",	setup_gemalto	},
 	{ "xmm7xxx",	setup_xmm7xxx	},
 	{ "mbim",	setup_mbim	},
+	{ "droid",	setup_droid	},
 	/* Following are non-USB modems */
 	{ "ifx",	setup_ifx		},
 	{ "u8500",	setup_isi_serial	},
@@ -1786,6 +1815,8 @@ static struct {
 	{ "telit",	"cdc_acm",	"1bc7", "0021"	},
 	{ "telitqmi",	"qmi_wwan",	"1bc7", "1201"	},
 	{ "telitqmi",	"option",	"1bc7", "1201"	},
+	{ "droid",	"qmi_wwan",	"22b8", "2a70"	},
+	{ "droid",	"option",	"22b8", "2a70"	},
 	{ "nokia",	"option",	"0421", "060e"	},
 	{ "nokia",	"option",	"0421", "0623"	},
 	{ "samsung",	"option",	"04e8", "6889"	},
-- =

2.11.0


-- =

(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--===============7570178051945857543==
Content-Type: application/pgp-signature
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="signature.asc"

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlGMEVBQkVDQUIwV0lRUlBmUE83cjBlQWhr
MDEwdjB3NS9CcWxkdjY4Z1VDWDJEQVRRQUtDUkF3NS9CcWxkdjYKOGdHOEFKd05VbGZVNFpEZWpt
c1hsOHI1clZ2Mld5TzNvUUNmZXprdVZYc3NXRDFvL05tdGlVeG4xS0c5UnEwPQo9WUkyWgotLS0t
LUVORCBQR1AgU0lHTkFUVVJFLS0tLS0K

--===============7570178051945857543==--

