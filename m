Content-Type: multipart/mixed; boundary="===============2017321491485422573=="
MIME-Version: 1.0
From: Vincent Cesson <vincent.cesson@smile.fr>
Subject: [PATCH 1/2] plugins: Add Gemalto plugin for Cinterion P-family
Date: Mon, 16 Jan 2017 10:07:52 +0100
Message-ID: <1484557673-15666-1-git-send-email-vincent.cesson@smile.fr>
In-Reply-To: <ccbe1a5e-d8bf-e3bf-a89c-8531338b1398@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2017321491485422573==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Actual cinterion plugin is not compliant with newer Gemalto modems.
Gemalto plugin is based on cinterion with a custom struct to handle the
interfaces Application and Modem.
---
 Makefile.am       |   3 +
 plugins/gemalto.c | 264 ++++++++++++++++++++++++++++++++++++++++++++++++++=
++++
 2 files changed, 267 insertions(+)
 create mode 100644 plugins/gemalto.c

diff --git a/Makefile.am b/Makefile.am
index a817565..a87c892 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -452,6 +452,9 @@ builtin_sources +=3D plugins/caif.c
 builtin_modules +=3D cinterion
 builtin_sources +=3D plugins/cinterion.c
 =

+builtin_modules +=3D gemalto
+builtin_sources +=3D plugins/gemalto.c
+
 builtin_modules +=3D nokia
 builtin_sources +=3D plugins/nokia.c
 =

diff --git a/plugins/gemalto.c b/plugins/gemalto.c
new file mode 100644
index 0000000..286d52c
--- /dev/null
+++ b/plugins/gemalto.c
@@ -0,0 +1,264 @@
+/*
+ *
+ *  oFono - Open Source Telephony
+ *
+ *  Copyright (C) 2017 Vincent Cesson. All rights reserved.
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
+	g_at_chat_send(data->app, "AT^SMSO", NULL, NULL, NULL, NULL);
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


--===============2017321491485422573==--

