Content-Type: multipart/mixed; boundary="===============4649217875897110097=="
MIME-Version: 1.0
From: Alex J Lennon <ajlennon@dynamicdevices.co.uk>
Subject: [PATCH 2/3] ehs6: Add support for Cinterion EHS6 plugin
Date: Wed, 29 Apr 2015 19:39:04 +0100
Message-ID: <1430332745-15275-2-git-send-email-ajlennon@dynamicdevices.co.uk>
In-Reply-To: <1430332745-15275-1-git-send-email-ajlennon@dynamicdevices.co.uk>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4649217875897110097==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 plugins/ehs6.c | 249 +++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++
 plugins/udev.c |  15 ++++
 2 files changed, 264 insertions(+)
 create mode 100644 plugins/ehs6.c

diff --git a/plugins/ehs6.c b/plugins/ehs6.c
new file mode 100644
index 0000000..8c5fe48
--- /dev/null
+++ b/plugins/ehs6.c
@@ -0,0 +1,249 @@
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
+
+#include <ofono/gprs.h>
+#include <ofono/gprs-context.h>
+
+#include <drivers/atmodem/vendor.h>
+
+static int ehs6_probe(struct ofono_modem *modem)
+{
+	return 0;
+}
+
+static void ehs6_remove(struct ofono_modem *modem)
+{
+}
+
+static void ehs6_debug(const char *str, void *user_data)
+{
+	const char *prefix =3D user_data;
+
+	ofono_info("%s%s", prefix, str);
+}
+
+static int ehs6_enable(struct ofono_modem *modem)
+{
+	GAtChat *chat;
+	GIOChannel *channel;
+	GAtSyntax *syntax;
+	GHashTable *options;
+	const char *device;
+
+	DBG("%p", modem);
+
+	options =3D g_hash_table_new(g_str_hash, g_str_equal);
+	if (options =3D=3D NULL)
+		return -ENOMEM;
+
+	device =3D ofono_modem_get_string(modem, "Device");
+	if (device =3D=3D NULL)
+		return -EINVAL;
+
+	g_hash_table_insert(options, "Baud", "115200");
+	g_hash_table_insert(options, "StopBits", "1");
+	g_hash_table_insert(options, "DataBits", "8");
+	g_hash_table_insert(options, "Parity", "none");
+	g_hash_table_insert(options, "XonXoff", "off");
+	g_hash_table_insert(options, "RtsCts", "on");
+	g_hash_table_insert(options, "Local", "on");
+	g_hash_table_insert(options, "Read", "on");
+
+	channel =3D g_at_tty_open(device, options);
+	g_hash_table_destroy(options);
+
+	if (channel =3D=3D NULL)
+		return -EIO;
+
+	/*
+	 * (EHS6 plugin is based on TC65. Comment left in but may not be applicab=
le)
+	 *
+	 * TC65 works almost as the 27.007 says. But for example after
+	 * AT+CRSM the modem replies with the data in the queried EF and
+	 * writes three pairs of <CR><LF> after the data and before OK.
+	 */
+	syntax =3D g_at_syntax_new_gsm_permissive();
+
+	chat =3D g_at_chat_new(channel, syntax);
+	g_at_syntax_unref(syntax);
+	g_io_channel_unref(channel);
+
+	if (chat =3D=3D NULL)
+		return -ENOMEM;
+
+	if (getenv("OFONO_AT_DEBUG"))
+		g_at_chat_set_debug(chat, ehs6_debug, "");
+
+	ofono_modem_set_data(modem, chat);
+
+	return 0;
+}
+
+static int ehs6_disable(struct ofono_modem *modem)
+{
+	GAtChat *chat =3D ofono_modem_get_data(modem);
+
+	DBG("%p", modem);
+
+	ofono_modem_set_data(modem, NULL);
+
+	g_at_chat_send(chat, "AT+CFUN=3D7", NULL, NULL, NULL, NULL);
+
+	g_at_chat_unref(chat);
+
+	return 0;
+}
+
+static void set_online_cb(gboolean ok, GAtResult *result, gpointer user_da=
ta)
+{
+	struct cb_data *cbd =3D user_data;
+	ofono_modem_online_cb_t cb =3D cbd->cb;
+	struct ofono_error error;
+
+	decode_at_error(&error, g_at_result_final_response(result));
+
+	cb(&error, cbd->data);
+}
+
+static void ehs6_set_online(struct ofono_modem *modem, ofono_bool_t online,
+			ofono_modem_online_cb_t cb, void *user_data)
+{
+	GAtChat *chat =3D ofono_modem_get_data(modem);
+	struct cb_data *cbd =3D cb_data_new(cb, user_data);
+	char const *command =3D online ? "AT+CFUN=3D1" : "AT+CFUN=3D7";
+
+	DBG("modem %p %s", modem, online ? "online" : "offline");
+
+	if (g_at_chat_send(chat, command, NULL, set_online_cb, cbd, g_free))
+		return;
+
+	g_free(cbd);
+
+	CALLBACK_WITH_FAILURE(cb, cbd->data);
+}
+
+static void ehs6_pre_sim(struct ofono_modem *modem)
+{
+	GAtChat *chat =3D ofono_modem_get_data(modem);
+	struct ofono_sim *sim;
+
+	DBG("%p", modem);
+
+	ofono_devinfo_create(modem, 0, "atmodem", chat);
+	sim =3D ofono_sim_create(modem, 0, "atmodem", chat);
+	ofono_voicecall_create(modem, 0, "atmodem", chat);
+
+	if (sim)
+		ofono_sim_inserted_notify(sim, TRUE);
+}
+
+static void ehs6_post_sim(struct ofono_modem *modem)
+{
+	GAtChat *chat =3D ofono_modem_get_data(modem);
+
+	DBG("%p", modem);
+
+	ofono_phonebook_create(modem, 0, "atmodem", chat);
+
+	ofono_sms_create(modem, 0, "atmodem", chat);
+}
+
+static void ehs6_post_online(struct ofono_modem *modem)
+{
+	GAtChat *chat =3D ofono_modem_get_data(modem);
+	struct ofono_message_waiting *mw;
+	struct ofono_gprs *gprs;
+	struct ofono_gprs_context *gc;
+
+	DBG("%p", modem);
+
+	ofono_ussd_create(modem, 0, "atmodem", chat);
+	ofono_call_forwarding_create(modem, 0, "atmodem", chat);
+	ofono_call_settings_create(modem, 0, "atmodem", chat);
+	ofono_netreg_create(modem, OFONO_VENDOR_CINTERION, "atmodem", chat);
+	ofono_call_meter_create(modem, 0, "atmodem", chat);
+	ofono_call_barring_create(modem, 0, "atmodem", chat);
+
+	gprs =3D ofono_gprs_create(modem, 0, "atmodem", chat);
+	gc =3D ofono_gprs_context_create(modem, 0, "atmodem", chat);
+
+	if (gprs && gc)
+		ofono_gprs_add_context(gprs, gc);
+
+	mw =3D ofono_message_waiting_create(modem);
+	if (mw)
+		ofono_message_waiting_register(mw);
+}
+
+static struct ofono_modem_driver ehs6_driver =3D {
+	.name		=3D "ehs6",
+	.probe		=3D ehs6_probe,
+	.remove		=3D ehs6_remove,
+	.enable		=3D ehs6_enable,
+	.disable	=3D ehs6_disable,
+	.set_online	=3D ehs6_set_online,
+	.pre_sim	=3D ehs6_pre_sim,
+	.post_sim	=3D ehs6_post_sim,
+	.post_online	=3D ehs6_post_online,
+};
+
+static int ehs6_init(void)
+{
+	return ofono_modem_driver_register(&ehs6_driver);
+}
+
+static void ehs6_exit(void)
+{
+	ofono_modem_driver_unregister(&ehs6_driver);
+}
+
+OFONO_PLUGIN_DEFINE(ehs6, "Cinterion EHS6 driver plugin", VERSION,
+		OFONO_PLUGIN_PRIORITY_DEFAULT, ehs6_init, ehs6_exit)
diff --git a/plugins/udev.c b/plugins/udev.c
index a78cd41..957a91c 100644
--- a/plugins/udev.c
+++ b/plugins/udev.c
@@ -205,6 +205,19 @@ static void add_tc65(struct ofono_modem *modem,
 	ofono_modem_register(modem);
 }
 =

+static void add_ehs6(struct ofono_modem *modem,
+			struct udev_device *udev_device)
+{
+	const char *devnode;
+
+	DBG("modem %p", modem);
+
+	devnode =3D udev_device_get_devnode(udev_device);
+	ofono_modem_set_string(modem, "Device", devnode);
+
+	ofono_modem_register(modem);
+}
+
 static void add_nokiacdma(struct ofono_modem *modem,
 					struct udev_device *udev_device)
 {
@@ -307,6 +320,8 @@ done:
 		add_calypso(modem, udev_device);
 	else if (g_strcmp0(driver, "tc65") =3D=3D 0)
 		add_tc65(modem, udev_device);
+	else if (g_strcmp0(driver, "ehs6") =3D=3D 0)
+		add_ehs6(modem, udev_device);
 	else if (g_strcmp0(driver, "nokiacdma") =3D=3D 0)
 		add_nokiacdma(modem, udev_device);
 	else if (g_strcmp0(driver, "sim900") =3D=3D 0)
-- =

1.9.1


--===============4649217875897110097==--

