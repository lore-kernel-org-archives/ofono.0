Content-Type: multipart/mixed; boundary="===============5909207288634425847=="
MIME-Version: 1.0
From: Anthony Viallard <viallard@syscom-instruments.com>
Subject: [PATCH] Simcom support
Date: Thu, 24 Jan 2013 17:45:00 +0100
Message-ID: <1359045900-17358-1-git-send-email-viallard@syscom-instruments.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5909207288634425847==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Add SIMCOM support.

I developped this with the SIM5216E chipset.

SMS and GPRS work. I don't add voice part because i don't use it so
can't test it.

Signed-off-by: Anthony Viallard <homer242@gmail.com>
--- ofono-1.6.orig/Makefile.am	2012-04-20 21:06:29.000000000 +0200
+++ ofono-1.6/Makefile.am	2013-01-21 17:17:48.089627277 +0100
@@ -371,6 +371,9 @@ builtin_sources +=3D plugins/samsung.c
 builtin_modules +=3D sim900
 builtin_sources +=3D plugins/sim900.c
 =

+builtin_modules +=3D simcom
+builtin_sources +=3D plugins/simcom.c
+
 if BLUETOOTH
 builtin_modules +=3D bluetooth
 builtin_sources +=3D plugins/bluetooth.c plugins/bluetooth.h
--- ofono-1.6.orig/drivers/atmodem/sms.c	2012-04-20 21:06:29.000000000 +0200
+++ ofono-1.6/drivers/atmodem/sms.c	2013-01-21 16:48:44.460627485 +0100
@@ -805,6 +807,7 @@ static gboolean build_cnmi_string(char *
 	case OFONO_VENDOR_NOVATEL:
 	case OFONO_VENDOR_HUAWEI:
 	case OFONO_VENDOR_ZTE:
+	case OFONO_VENDOR_SIMCOM:
 		/* MSM devices advertise support for mode 2, but return an
 		 * error if we attempt to actually use it. */
 		mode =3D "1";
diff -pruN ofono-1.6.orig/drivers/atmodem/sim.c ofono-1.6/drivers/atmodem/s=
im.c
--- ofono-1.6.orig/drivers/atmodem/sim.c	2013-01-23 11:38:22.959609087 +0100
+++ ofono-1.6/drivers/atmodem/sim.c	2013-01-23 11:57:52.602608948 +0100
@@ -1023,10 +1023,16 @@ static void at_pin_send_cb(gboolean ok,
 							FALSE, cbd, g_free);
 		return;
 	case OFONO_VENDOR_ZTE:
+	case OFONO_VENDOR_SIMCOM:
 		/*
 		 * On ZTE modems, after pin is entered, SIM state is checked
 		 * by polling CPIN as their modem doesn't provide unsolicited
 		 * notification of SIM readiness.
+		 *
+		 * On SIMCOM modems, SIM is busy after pin is entered (we've
+		 * got an "+CME ERROR: 14" at "AT+CPIN?" request) and ofono
+		 * don't catch the "+CPIN: READY" message sent by the modem
+		 * when SIM is ready. So, use extra CPIN to check the state.
 		 */
 		sd->sim_state_query =3D at_util_sim_state_query_new(sd->chat,
 						2, 20, sim_state_cb, cbd,
diff -purN ofono-1.6/drivers/atmodem/network-registration.c ofono-patched/d=
rivers/atmodem/network-registration.c
--- ofono-1.6/drivers/atmodem/network-registration.c	2013-01-18 15:04:03.59=
8659165 +0100
+++ ofono-patched/drivers/atmodem/network-registration.c	2013-01-18 14:54:0=
3.256659236 +0100
@@ -1411,6 +1411,14 @@ static void at_creg_set_cb(gboolean ok,
 	}
 =

 	switch (nd->vendor) {
+	case OFONO_VENDOR_SIMCOM:
+		/* Register for CSQ changes */
+		g_at_chat_send(nd->chat, "AT+AUTOCSQ=3D1,1", none_prefix,
+				NULL, NULL, NULL);
+
+		g_at_chat_register(nd->chat, "+CSQ:",
+ 				   csq_notify, FALSE, netreg, NULL);
+ 		break;
 	case OFONO_VENDOR_PHONESIM:
 		g_at_chat_register(nd->chat, "+CSQ:",
 					csq_notify, FALSE, netreg, NULL);
@@ -1534,7 +1537,6 @@ static void at_creg_set_cb(gboolean ok,
 		break;
 	case OFONO_VENDOR_NOKIA:
 	case OFONO_VENDOR_SAMSUNG:
-	case OFONO_VENDOR_SIMCOM:
 		/* Signal strength reporting via CIND is not supported */
 		break;
 	default:
--- /dev/null	2013-01-16 10:54:41.551089567 +0100
+++ ofono-1.6/plugins/simcom.c	2013-01-23 10:43:05.631609483 +0100
@@ -0,0 +1,308 @@
+/*
+ *
+ *  oFono - Open Source Telephony
+ *
+ *  Copyright (C) 2008-2011  Intel Corporation. All rights reserved.
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
+#include <errno.h>
+#include <stdlib.h>
+
+#include <glib.h>
+#include <gatchat.h>
+#include <gattty.h>
+
+#define OFONO_API_SUBJECT_TO_CHANGE
+#include <ofono/plugin.h>
+#include <ofono/modem.h>
+#include <ofono/devinfo.h>
+#include <ofono/netreg.h>
+#include <ofono/sim.h>
+#include <ofono/cbs.h>
+#include <ofono/sms.h>
+#include <ofono/ussd.h>
+#include <ofono/gprs.h>
+#include <ofono/gprs-context.h>
+#include <ofono/radio-settings.h>
+#include <ofono/phonebook.h>
+#include <ofono/log.h>
+
+#include <drivers/atmodem/atutil.h>
+#include <drivers/atmodem/vendor.h>
+
+static const char *none_prefix[] =3D { NULL };
+
+struct simcom_data {
+	GAtChat *modem;
+	GAtChat *data;
+};
+
+/* Callback and helpers functions */
+static void simcom_debug(const char *str, void *user_data)
+{
+	const char *prefix =3D user_data;
+
+	ofono_info("%s%s", prefix, str);
+}
+
+static void cfun_enable(gboolean ok, GAtResult *result, gpointer user_data)
+{
+	struct ofono_modem *modem =3D user_data;
+	struct simcom_data *data =3D ofono_modem_get_data(modem);
+
+	DBG("");
+
+	if (!ok) {
+		g_at_chat_unref(data->modem);
+		data->modem =3D NULL;
+
+		g_at_chat_unref(data->data);
+		data->data =3D NULL;
+
+		ofono_modem_set_powered(modem, FALSE);
+		return;
+	}
+
+	ofono_modem_set_powered(modem, TRUE);
+}
+
+static void cfun_disable(gboolean ok, GAtResult *result, gpointer user_dat=
a)
+{
+	struct ofono_modem *modem =3D user_data;
+	struct simcom_data *data =3D ofono_modem_get_data(modem);
+
+	DBG("");
+
+	g_at_chat_unref(data->data);
+	data->data =3D NULL;
+
+	if (ok)
+		ofono_modem_set_powered(modem, FALSE);
+}
+
+static GAtChat *open_device(struct ofono_modem *modem,
+			    const char *key,
+			    char *debug)
+{
+	const char *device;
+	GIOChannel *channel;
+	GAtSyntax *syntax;
+	GAtChat *chat;
+	/* GHashTable *options; */
+
+	device =3D ofono_modem_get_string(modem, key);
+	if (device =3D=3D NULL)
+		return NULL;
+
+	DBG("%s %s", key, device);
+
+	/* options =3D g_hash_table_new(g_str_hash, g_str_equal); */
+	/* if (options =3D=3D NULL) */
+	/* 	return NULL; */
+
+	/* g_hash_table_insert(options, "Baud", "115200"); */
+	/* g_hash_table_insert(options, "Parity", "none"); */
+	/* g_hash_table_insert(options, "StopBits", "1"); */
+	/* g_hash_table_insert(options, "DataBits", "8"); */
+	/* g_hash_table_insert(options, "XonXoff", "off"); */
+	/* g_hash_table_insert(options, "RtsCts", "on"); */
+	/* g_hash_table_insert(options, "Local", "on"); */
+	/* g_hash_table_insert(options, "Read", "on"); */
+
+	channel =3D g_at_tty_open(device, NULL);
+
+	/* g_hash_table_destroy(options); */
+
+	if (channel =3D=3D NULL)
+		return NULL;
+
+	syntax =3D g_at_syntax_new_gsm_permissive();
+	chat =3D g_at_chat_new(channel, syntax);
+	g_at_syntax_unref(syntax);
+
+	g_io_channel_unref(channel);
+
+	if (chat =3D=3D NULL)
+		return NULL;
+
+	if (getenv("OFONO_AT_DEBUG"))
+		g_at_chat_set_debug(chat, simcom_debug, debug);
+
+	return chat;
+}
+
+/* Modem interface function */
+static int simcom_probe(struct ofono_modem *modem)
+{
+	struct simcom_data *data;
+
+	DBG("%p", modem);
+
+	data =3D g_try_new0(struct simcom_data, 1);
+	if (data =3D=3D NULL)
+		return -ENOMEM;
+
+	ofono_modem_set_data(modem, data);
+
+	return 0;
+}
+
+static void simcom_remove(struct ofono_modem *modem)
+{
+	struct simcom_data *data =3D ofono_modem_get_data(modem);
+
+	DBG("%p", modem);
+
+	ofono_modem_set_data(modem, NULL);
+
+	/* Cleanup after hot-unplug */
+	g_at_chat_unref(data->data);
+
+	g_free(data);
+}
+
+static int simcom_enable(struct ofono_modem *modem)
+{
+	struct simcom_data *data =3D ofono_modem_get_data(modem);
+
+	DBG("%p", modem);
+
+	data->modem =3D open_device(modem, "Modem", "Modem: ");
+	if (data->modem =3D=3D NULL)
+		return -EINVAL;
+
+	data->data =3D open_device(modem, "Data", "Data: ");
+	if (data->data =3D=3D NULL) {
+		g_at_chat_unref(data->modem);
+		data->modem =3D NULL;
+		return -EIO;
+	}
+
+	g_at_chat_set_slave(data->modem, data->data);
+
+	g_at_chat_blacklist_terminator(data->data,
+					G_AT_CHAT_TERMINATOR_NO_CARRIER);
+
+	/* init modem */
+	g_at_chat_send(data->modem, "ATE0 +CMEE=3D1", NULL, NULL, NULL, NULL);
+	g_at_chat_send(data->data, "ATE0 +CMEE=3D1", NULL, NULL, NULL, NULL);
+
+	g_at_chat_send(data->data, "AT+CFUN=3D1", none_prefix,
+		       cfun_enable, modem, NULL);
+
+	return -EINPROGRESS;
+}
+
+static int simcom_disable(struct ofono_modem *modem)
+{
+	struct simcom_data *data =3D ofono_modem_get_data(modem);
+
+	DBG("%p", modem);
+
+	g_at_chat_cancel_all(data->modem);
+	g_at_chat_unregister_all(data->modem);
+
+	g_at_chat_unref(data->modem);
+	data->modem =3D NULL;
+
+	g_at_chat_cancel_all(data->data);
+	g_at_chat_unregister_all(data->data);
+
+	g_at_chat_send(data->data, "AT+CFUN=3D4", none_prefix,
+		       cfun_disable, modem, NULL);
+
+	return -EINPROGRESS;
+}
+
+static void simcom_pre_sim(struct ofono_modem *modem)
+{
+	struct simcom_data *data =3D ofono_modem_get_data(modem);
+	struct ofono_sim *sim;
+
+	DBG("%p", modem);
+
+	ofono_devinfo_create(modem, 0, "atmodem", data->data);
+	sim =3D ofono_sim_create(modem, OFONO_VENDOR_SIMCOM, "atmodem",
+				data->data);
+
+	if (sim)
+		ofono_sim_inserted_notify(sim, TRUE);
+}
+
+static void simcom_post_sim(struct ofono_modem *modem)
+{
+	struct simcom_data *data =3D ofono_modem_get_data(modem);
+	struct ofono_message_waiting *mw;
+	struct ofono_gprs *gprs;
+	struct ofono_gprs_context *gc;
+
+	DBG("%p", modem);
+
+	ofono_phonebook_create(modem, 0, "atmodem", data->data);
+
+	ofono_sms_create(modem, OFONO_VENDOR_SIMCOM, "atmodem",
+				data->data);
+
+	/* gprs things */
+	gprs =3D ofono_gprs_create(modem, 0, "atmodem", data->data);
+	gc =3D ofono_gprs_context_create(modem, 0, "atmodem", data->modem);
+
+	if(gprs && gc)
+	{
+		ofono_gprs_add_context(gprs, gc);
+	}
+}
+
+static void simcom_post_online(struct ofono_modem *modem)
+{
+	struct simcom_data *data =3D ofono_modem_get_data(modem);
+
+	DBG("%p", modem);
+
+	ofono_netreg_create(modem, OFONO_VENDOR_SIMCOM, "atmodem", data->data);
+	ofono_cbs_create(modem, 0, "atmodem", data->data);
+	ofono_ussd_create(modem, 0, "atmodem", data->data);
+}
+
+static struct ofono_modem_driver simcom_driver =3D {
+	.name		=3D "simcom",
+	.probe		=3D simcom_probe,
+	.remove		=3D simcom_remove,
+	.enable		=3D simcom_enable,
+	.disable	=3D simcom_disable,
+	.pre_sim	=3D simcom_pre_sim,
+	.post_sim	=3D simcom_post_sim,
+	.post_online	=3D simcom_post_online,
+};
+
+static int simcom_init(void)
+{
+	return ofono_modem_driver_register(&simcom_driver);
+}
+
+static void simcom_exit(void)
+{
+	ofono_modem_driver_unregister(&simcom_driver);
+}
+
+OFONO_PLUGIN_DEFINE(simcom, "SIMCOM modem driver", VERSION,
+		    OFONO_PLUGIN_PRIORITY_DEFAULT,
+		    simcom_init, simcom_exit)

--===============5909207288634425847==--

