Content-Type: multipart/mixed; boundary="===============6728437262577484899=="
MIME-Version: 1.0
From: Vincent Cesson <cesson.vincent@gmail.com>
Subject: [RFC 1/3] plugins: Add Gemalto plugin for Cinterion P-family
Date: Thu, 12 Jan 2017 18:06:50 +0100
Message-ID: <1484240812-3327-2-git-send-email-vincent.cesson@smile.fr>
In-Reply-To: <1484240812-3327-1-git-send-email-vincent.cesson@smile.fr>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6728437262577484899==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: vcesson <vincent.cesson@smile.fr>

Actual cinterion plugin is not compliant with newer Gemalto modems.
Gemalto plugin is based on cinterion with a custom struct to handle the
interfaces Application and Modem.
---
 plugins/gemalto.c | 265 ++++++++++++++++++++++++++++++++++++++++++++++++++=
++++
 1 file changed, 265 insertions(+)
 create mode 100644 plugins/gemalto.c

diff --git a/plugins/gemalto.c b/plugins/gemalto.c
new file mode 100644
index 0000000..4758f62
--- /dev/null
+++ b/plugins/gemalto.c
@@ -0,0 +1,265 @@
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
+struct gemalto_data {
+	GAtChat *app;
+	GAtChat *mdm;
+	struct ofono_private_config *config;
+};
+
+static int gemalto_probe(struct ofono_modem *modem)
+{
+	struct gemalto_data *data;
+
+	data =3D g_try_new0(struct gemalto_data, 1);
+	if (data =3D=3D NULL)
+		return -ENOMEM;
+
+	ofono_modem_set_data(modem, data);
+
+	return 0;
+}
+
+static void gemalto_remove(struct ofono_modem *modem)
+{
+	struct gemalto_data *data =3D ofono_modem_get_data(modem);
+
+	ofono_modem_set_data(modem, NULL);
+	g_free(data);
+}
+
+static void gemalto_debug(const char *str, void *user_data)
+{
+	const char *prefix =3D user_data;
+
+	ofono_info("%s%s", prefix, str);
+}
+
+static GAtChat *open_device(const char *device)
+{
+	GAtSyntax *syntax;
+	GIOChannel *channel;
+	GAtChat *chat;
+
+	DBG("Opening device %s", device);
+
+	channel =3D g_at_tty_open(device, NULL);
+	if (channel =3D=3D NULL)
+		return NULL;
+
+	syntax =3D g_at_syntax_new_gsm_permissive();
+	chat =3D g_at_chat_new(channel, syntax);
+	g_at_syntax_unref(syntax);
+	g_io_channel_unref(channel);
+
+	if (chat =3D=3D NULL)
+		return NULL;
+
+	return chat;
+}
+
+static int gemalto_enable(struct ofono_modem *modem)
+{
+	struct gemalto_data *data =3D ofono_modem_get_data(modem);
+	const char *app, *mdm;
+
+	DBG("%p", modem);
+
+	app =3D ofono_modem_get_string(modem, "Application");
+	mdm =3D ofono_modem_get_string(modem, "Modem");
+
+	if (app =3D=3D NULL || mdm =3D=3D NULL)
+		return -EINVAL;
+
+	/* Open devices */
+	data->app =3D open_device(app);
+	if (data->app =3D=3D NULL)
+		return -EINVAL;
+
+	data->mdm =3D open_device(mdm);
+	if (data->mdm =3D=3D NULL) {
+		g_at_chat_unref(data->app);
+		data->app =3D NULL;
+		return -EINVAL;
+	}
+
+	if (getenv("OFONO_AT_DEBUG")) {
+		g_at_chat_set_debug(data->app, gemalto_debug, "App");
+		g_at_chat_set_debug(data->mdm, gemalto_debug, "Mdm");
+	}
+
+	return 0;
+}
+
+static int gemalto_disable(struct ofono_modem *modem)
+{
+	struct gemalto_data *data =3D ofono_modem_get_data(modem);
+
+	DBG("%p", modem);
+
+	g_at_chat_send(data->app, "AT+CFUN=3D0", NULL, NULL, NULL, NULL);
+
+	ofono_modem_set_data(modem, NULL);
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
+static void gemalto_set_online(struct ofono_modem *modem, ofono_bool_t onl=
ine,
+		ofono_modem_online_cb_t cb, void *user_data)
+{
+	struct gemalto_data *data =3D ofono_modem_get_data(modem);
+	struct cb_data *cbd =3D cb_data_new(cb, user_data);
+	char const *command =3D online ? "AT+CFUN=3D1" : "AT+CFUN=3D0";
+
+	DBG("modem %p %s", modem, online ? "online" : "offline");
+
+	if (g_at_chat_send(data->app, command, NULL, set_online_cb, cbd, g_free))
+		return;
+
+	CALLBACK_WITH_FAILURE(cb, cbd->data);
+
+	g_free(cbd);
+}
+
+static void gemalto_pre_sim(struct ofono_modem *modem)
+{
+	struct gemalto_data *data =3D ofono_modem_get_data(modem);
+	struct ofono_sim *sim;
+
+	DBG("%p", modem);
+
+	ofono_devinfo_create(modem, 0, "atmodem", data->app);
+	sim =3D ofono_sim_create(modem, 0, "atmodem", data->app);
+	ofono_voicecall_create(modem, 0, "atmodem", data->app);
+	ofono_location_reporting_create(modem, 0, "gemaltomodem", data->app);
+
+	if (sim)
+		ofono_sim_inserted_notify(sim, TRUE);
+}
+
+static void gemalto_post_sim(struct ofono_modem *modem)
+{
+	struct gemalto_data *data =3D ofono_modem_get_data(modem);
+
+	DBG("%p", modem);
+
+	ofono_phonebook_create(modem, 0, "atmodem", data->app);
+
+	ofono_sms_create(modem, 0, "atmodem", data->app);
+}
+
+static void gemalto_post_online(struct ofono_modem *modem)
+{
+	struct gemalto_data *data =3D ofono_modem_get_data(modem);
+	struct ofono_message_waiting *mw;
+	struct ofono_gprs *gprs;
+	struct ofono_gprs_context *gc;
+
+	DBG("%p", modem);
+
+	ofono_ussd_create(modem, 0, "atmodem", data->app);
+	ofono_call_forwarding_create(modem, 0, "atmodem", data->app);
+	ofono_call_settings_create(modem, 0, "atmodem", data->app);
+	ofono_netreg_create(modem, OFONO_VENDOR_CINTERION, "atmodem", data->app);
+	ofono_call_meter_create(modem, 0, "atmodem", data->app);
+	ofono_call_barring_create(modem, 0, "atmodem", data->app);
+
+	gprs =3D ofono_gprs_create(modem, 0, "atmodem", data->app);
+	gc =3D ofono_gprs_context_create(modem, 0, "atmodem", data->mdm);
+
+	if (gprs && gc)
+		ofono_gprs_add_context(gprs, gc);
+
+	mw =3D ofono_message_waiting_create(modem);
+	if (mw)
+		ofono_message_waiting_register(mw);
+}
+
+static struct ofono_modem_driver gemalto_driver =3D {
+	.name		=3D "gemalto",
+	.probe		=3D gemalto_probe,
+	.remove		=3D gemalto_remove,
+	.enable		=3D gemalto_enable,
+	.disable	=3D gemalto_disable,
+	.set_online	=3D gemalto_set_online,
+	.pre_sim	=3D gemalto_pre_sim,
+	.post_sim	=3D gemalto_post_sim,
+	.post_online	=3D gemalto_post_online,
+};
+
+static int gemalto_init(void)
+{
+	return ofono_modem_driver_register(&gemalto_driver);
+}
+
+static void gemalto_exit(void)
+{
+	ofono_modem_driver_unregister(&gemalto_driver);
+}
+
+OFONO_PLUGIN_DEFINE(gemalto, "Gemalto modem plugin", VERSION,
+		OFONO_PLUGIN_PRIORITY_DEFAULT, gemalto_init, gemalto_exit)
-- =

1.9.1


--===============6728437262577484899==--

