Content-Type: multipart/mixed; boundary="===============3896261107158639835=="
MIME-Version: 1.0
From: Pavel Machek <pavel@ucw.cz>
Subject: [PATCH v2] Support weird modem in Motorola Droid 4
Date: Sat, 01 Aug 2020 00:00:46 +0200
Message-ID: <20200731220046.GB2114@amd>
In-Reply-To: <20200731215730.GA2114@amd>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3896261107158639835==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This is basic support for modem in Droid 4, accessed over
ttyUSB4. That interface is unfortunately quite broken, so we need to
force very specific SMS mode.

---

Sorry, hit send too soon and sent version with unused variables and
broken whitespace. This one should be better.

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
diff --git a/drivers/atmodem/sim.c b/drivers/atmodem/sim.c
index e750a139..f46cd3a2 100644
--- a/drivers/atmodem/sim.c
+++ b/drivers/atmodem/sim.c
@@ -199,6 +199,7 @@ static void at_sim_read_info(struct ofono_sim *sim, int=
 fileid,
 	case OFONO_VENDOR_SPEEDUP:
 	case OFONO_VENDOR_QUALCOMM_MSM:
 	case OFONO_VENDOR_SIMCOM:
+	case OFONO_VENDOR_DROID:
 		/* Maximum possible length */
 		len +=3D sprintf(buf + len, ",0,0,255");
 		break;
diff --git a/drivers/atmodem/sms.c b/drivers/atmodem/sms.c
index d502da72..a9306916 100644
--- a/drivers/atmodem/sms.c
+++ b/drivers/atmodem/sms.c
@@ -349,8 +349,15 @@ static inline void at_ack_delivery(struct ofono_sms *s=
ms)
 			break;
 		}
 	} else {
-		/* Should be a safe fallback */
-		snprintf(buf, sizeof(buf), "AT+CNMA=3D0");
+		switch (data->vendor) {
+		case OFONO_VENDOR_DROID:
+			snprintf(buf, sizeof(buf), "AT");
+			break;
+		default:
+			/* Should be a safe fallback */
+			snprintf(buf, sizeof(buf), "AT+CNMA=3D0");
+			break;
+		}
 	}
 =

 	g_at_chat_send(data->chat, buf, none_prefix, at_cnma_cb, NULL, NULL);
@@ -845,6 +852,7 @@ static gboolean build_cnmi_string(char *buf, int *cnmi_=
opts,
 	case OFONO_VENDOR_ZTE:
 	case OFONO_VENDOR_SIMCOM:
 	case OFONO_VENDOR_QUECTEL:
+	case OFONO_VENDOR_DROID:
 		/* MSM devices advertise support for mode 2, but return an
 		 * error if we attempt to actually use it. */
 		mode =3D "1";
@@ -858,9 +866,14 @@ static gboolean build_cnmi_string(char *buf, int *cnmi=
_opts,
 	if (!append_cnmi_element(buf, &len, cnmi_opts[0], mode, FALSE))
 		return FALSE;
 =

+	mode =3D "21";
+	if (!data->cnma_enabled)
+		mode =3D "1";
+	if (data->vendor =3D=3D OFONO_VENDOR_DROID)
+		mode =3D "2";
+
 	/* Prefer to deliver SMS via +CMT if CNMA is supported */
-	if (!append_cnmi_element(buf, &len, cnmi_opts[1],
-					data->cnma_enabled ? "21" : "1", FALSE))
+	if (!append_cnmi_element(buf, &len, cnmi_opts[1], mode, FALSE))
 		return FALSE;
 =

 	switch (data->vendor) {
@@ -1243,7 +1256,9 @@ static void at_csms_status_cb(gboolean ok, GAtResult =
*result,
 			goto out;
 =

 		if (service =3D=3D 1 || service =3D=3D 128)
-			data->cnma_enabled =3D TRUE;
+			if (data->vendor !=3D OFONO_VENDOR_DROID) {
+				data->cnma_enabled =3D TRUE;
+			}
 =

 		if (mt =3D=3D 1 && mo =3D=3D 1)
 			supported =3D TRUE;
@@ -1290,6 +1305,8 @@ static void at_csms_query_cb(gboolean ok, GAtResult *=
result,
 		goto out;
 =

 	switch (data->vendor) {
+	case OFONO_VENDOR_DROID:
+		break;
 	case OFONO_VENDOR_QUECTEL_SERIAL:
 		g_at_result_iter_next_number(&iter, &status_min);
 		g_at_result_iter_next_number(&iter, &status_max);
diff --git a/drivers/atmodem/vendor.h b/drivers/atmodem/vendor.h
index d839d1e0..2bfd3eb8 100644
--- a/drivers/atmodem/vendor.h
+++ b/drivers/atmodem/vendor.h
@@ -27,6 +27,7 @@ enum ofono_vendor {
 	OFONO_VENDOR_MBM,
 	OFONO_VENDOR_GOBI,
 	OFONO_VENDOR_QUALCOMM_MSM,
+	OFONO_VENDOR_DROID,
 	OFONO_VENDOR_OPTION_HSO,
 	OFONO_VENDOR_ZTE,
 	OFONO_VENDOR_HUAWEI,
diff --git a/drivers/atmodem/voicecall.c b/drivers/atmodem/voicecall.c
index 7ab6567f..6c80bd4e 100644
--- a/drivers/atmodem/voicecall.c
+++ b/drivers/atmodem/voicecall.c
@@ -160,6 +160,10 @@ static void clcc_poll_cb(gboolean ok, GAtResult *resul=
t, gpointer user_data)
 			poll_again =3D TRUE;
 			goto poll_again;
 		}
+		if (vd->vendor =3D=3D OFONO_VENDOR_DROID) {
+			poll_again =3D TRUE;
+			goto poll_again;
+		}
 =

 		ofono_error("We are polling CLCC and received an error");
 		ofono_error("All bets are off for call management");
diff --git a/plugins/droid.c b/plugins/droid.c
new file mode 100644
index 00000000..4e048dbb
--- /dev/null
+++ b/plugins/droid.c
@@ -0,0 +1,226 @@
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
+	GAtSyntax *syntax;
+	GIOChannel *channel;
+	GAtChat *chat;
+	const char *device;
+
+	DBG("");
+
+	device =3D ofono_modem_get_string(modem, "Device");
+	if (device =3D=3D NULL)
+		return -EINVAL;
+
+	channel =3D g_at_tty_open(device, NULL);
+	if (channel =3D=3D NULL)
+		return -EIO;
+
+	syntax =3D g_at_syntax_new_gsm_permissive();
+	chat =3D g_at_chat_new(channel, syntax);
+	g_io_channel_unref(channel);
+	g_at_syntax_unref(syntax);
+
+	if (chat =3D=3D NULL)
+		return -EIO;
+
+	if (getenv("OFONO_AT_DEBUG"))
+		g_at_chat_set_debug(chat, droid_debug, "");
+
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
+	sim =3D ofono_sim_create(modem, 0, "atmodem", chat);
+	ofono_voicecall_create(modem, 0, "atmodem", chat);
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

(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--===============3896261107158639835==
Content-Type: application/pgp-signature
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="signature.asc"

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KVmVyc2lvbjogR251UEcgdjEKCmlFWUVBUkVD
QUFZRkFsOGtsSTRBQ2drUU1PZndhcFhiK3ZMNkZ3Q2ZZanUrcUpsTHYwZk53KzVlM3hMS2Y0Y0wK
R3N3QW4xY2Q3NEM2b2dXbnJUelBjTlRBbk5oc3VUcTAKPU9vQloKLS0tLS1FTkQgUEdQIFNJR05B
VFVSRS0tLS0tCg==

--===============3896261107158639835==--

