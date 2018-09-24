Content-Type: multipart/mixed; boundary="===============8420455739588815540=="
MIME-Version: 1.0
From: Clement Viel <vielclement@gmail.com>
Subject: [PATCH 1/3] sim800: adding support for SimCom SIM800 modem
Date: Tue, 25 Sep 2018 00:43:28 +0200
Message-ID: <1537829010-15668-1-git-send-email-vielclement@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8420455739588815540==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: clem <vielclement@gmail.com>

---
 Makefile.am      |   4 +
 plugins/sim800.c | 463 +++++++++++++++++++++++++++++++++++++++++++++++++++=
++++
 2 files changed, 467 insertions(+)
 create mode 100644 plugins/sim800.c

diff --git a/Makefile.am b/Makefile.am
index 6dee4ce..f4d03b6 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -496,6 +496,10 @@ builtin_sources +=3D plugins/speedupcdma.c
 builtin_modules +=3D samsung
 builtin_sources +=3D plugins/samsung.c
 =

+builtin_modules +=3D sim800
+builtin_sources +=3D plugins/sim800.c
+
+
 builtin_modules +=3D sim900
 builtin_sources +=3D plugins/sim900.c
 =

diff --git a/plugins/sim800.c b/plugins/sim800.c
new file mode 100644
index 0000000..c9285c1
--- /dev/null
+++ b/plugins/sim800.c
@@ -0,0 +1,463 @@
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
+#include <unistd.h>
+#include <glib.h>
+#include <gatchat.h>
+#include <gattty.h>
+#include <gatmux.h>
+
+#define OFONO_API_SUBJECT_TO_CHANGE
+#include <ofono/plugin.h>
+#include <ofono/modem.h>
+#include <ofono/devinfo.h>
+#include <ofono/netreg.h>
+#include <ofono/sim.h>
+#include <ofono/sms.h>
+#include <ofono/ussd.h>
+#include <ofono/gprs.h>
+#include <ofono/gprs-context.h>
+#include <ofono/phonebook.h>
+#include <ofono/history.h>
+#include <ofono/log.h>
+#include <ofono/voicecall.h>
+#include <ofono/call-volume.h>
+#include <drivers/atmodem/vendor.h>
+
+#define NUM_DLC 5
+
+#define VOICE_DLC   0
+#define NETREG_DLC  1
+#define SMS_DLC     2
+#define GPRS_DLC    3
+#define SETUP_DLC   4
+
+static char *dlc_prefixes[NUM_DLC] =3D { "Voice: ", "Net: ", "SMS: ",
+					"GPRS: " , "Setup: "};
+
+static const char *none_prefix[] =3D { NULL };
+
+struct sim800_data {
+	GIOChannel *device;
+	GAtMux *mux;
+	GAtChat * dlcs[NUM_DLC];
+	guint frame_size;
+	int mux_not_supported;
+};
+
+
+static void mux_ready_notify(GAtResult *result, gpointer user_data)
+{
+	struct ofono_modem *modem =3D user_data;
+	struct sim800_data *data =3D ofono_modem_get_data(modem);
+	struct ofono_gprs *gprs =3D NULL;
+	struct ofono_gprs_context *gc;
+	static int notified =3D 0;
+
+	if (!notified) {
+	ofono_sms_create(modem, OFONO_VENDOR_SIMCOM, "atmodem",
+						data->dlcs[SMS_DLC]);
+
+
+	gprs =3D ofono_gprs_create(modem, 0, "atmodem", data->dlcs[GPRS_DLC]);
+	if (gprs =3D=3D NULL)
+		return;
+
+	gc =3D ofono_gprs_context_create(modem, OFONO_VENDOR_SIMCOM,
+					"atmodem", data->dlcs[GPRS_DLC]);
+	if (gc)
+		ofono_gprs_add_context(gprs, gc);
+	}
+	notified =3D 1;
+
+}
+
+
+static int sim800_probe(struct ofono_modem *modem)
+{
+	struct sim800_data *data;
+
+	DBG("%p", modem);
+
+	data =3D g_try_new0(struct sim800_data, 1);
+	if (data =3D=3D NULL)
+		return -ENOMEM;
+
+	ofono_modem_set_data(modem, data);
+
+	return 0;
+}
+
+static void sim800_remove(struct ofono_modem *modem)
+{
+	struct sim800_data *data =3D ofono_modem_get_data(modem);
+
+	DBG("%p", modem);
+
+	ofono_modem_set_data(modem, NULL);
+
+	g_free(data);
+}
+
+static void sim800_debug(const char *str, void *user_data)
+{
+	const char *prefix =3D user_data;
+
+	ofono_info("%s%s", prefix, str);
+}
+
+static GAtChat *open_device(struct ofono_modem *modem,
+			const char *key, char *debug)
+{
+	struct sim800_data *data =3D ofono_modem_get_data(modem);
+	const char *device;
+	GAtSyntax *syntax;
+	GIOChannel *channel;
+	GAtChat *chat;
+	GHashTable *options;
+
+	device =3D ofono_modem_get_string(modem, key);
+	if (device =3D=3D NULL) {
+		DBG("couldn't get string %s",key);
+		return NULL;
+	}
+
+	DBG("%s %s", key, device);
+
+	options =3D g_hash_table_new(g_str_hash, g_str_equal);
+	if (options =3D=3D NULL) {
+		DBG("options is null");
+		return NULL;
+	}
+
+	g_hash_table_insert(options, "Baud", "115200");
+	g_hash_table_insert(options, "Parity", "none");
+	g_hash_table_insert(options, "StopBits", "1");
+	g_hash_table_insert(options, "DataBits", "8");
+	g_hash_table_insert(options, "XonXoff", "off");
+	g_hash_table_insert(options, "Local", "off");
+	g_hash_table_insert(options, "RtsCts", "off");
+	g_hash_table_insert(options, "Read", "on");
+
+	channel =3D g_at_tty_open(device, options);
+	g_hash_table_destroy(options);
+
+	if (channel =3D=3D NULL){
+		DBG("serial channel couldn't be opened");
+		return NULL;
+	}
+
+	data->device =3D channel;
+	syntax =3D g_at_syntax_new_gsm_permissive();
+	chat =3D g_at_chat_new(channel, syntax);
+	g_at_syntax_unref(syntax);
+
+	if (chat =3D=3D NULL) {
+		g_io_channel_unref(data->device);
+		data->device =3D NULL;
+		DBG("at channel couldn't be opened");
+
+		return NULL;
+	}
+
+	if (getenv("OFONO_AT_DEBUG"))
+		g_at_chat_set_debug(chat, sim800_debug, debug);
+
+	return chat;
+}
+
+static GAtChat *create_chat(GIOChannel *channel, struct ofono_modem *modem,
+				char *debug)
+{
+	GAtSyntax *syntax;
+	GAtChat *chat;
+
+	if (channel =3D=3D NULL)
+		return NULL;
+
+	syntax =3D g_at_syntax_new_gsmv1();
+	chat =3D g_at_chat_new(channel, syntax);
+	g_at_syntax_unref(syntax);
+	g_io_channel_unref(channel);
+
+	if (chat =3D=3D NULL)
+		return NULL;
+
+	if (getenv("OFONO_AT_DEBUG")) {
+		DBG("AT DEBUG enabled");
+		g_at_chat_set_debug(chat, sim800_debug, debug);
+	}
+
+	return chat;
+}
+
+static void shutdown_device(struct sim800_data *data)
+{
+	int i;
+
+	DBG("");
+
+	for (i =3D 0; i < NUM_DLC; i++) {
+		if (data->dlcs[i] =3D=3D NULL)
+			continue;
+
+		g_at_chat_unref(data->dlcs[i]);
+		data->dlcs[i] =3D NULL;
+	}
+
+	if (data->mux) {
+		g_at_mux_shutdown(data->mux);
+		g_at_mux_unref(data->mux);
+		data->mux =3D NULL;
+	}
+
+	g_io_channel_unref(data->device);
+	data->device =3D NULL;
+}
+
+static void setup_internal_mux(struct ofono_modem *modem)
+{
+	struct sim800_data *data =3D ofono_modem_get_data(modem);
+	int i;
+
+	DBG("");
+
+	data->frame_size =3D 128;
+
+	data->mux =3D g_at_mux_new_gsm0710_basic(data->device,
+						data->frame_size);
+	if (data->mux =3D=3D NULL)
+		goto error;
+
+	if (getenv("OFONO_MUX_DEBUG"))
+		g_at_mux_set_debug(data->mux, sim800_debug, "MUX: ");
+
+	if (!g_at_mux_start(data->mux)) {
+		g_at_mux_shutdown(data->mux);
+		g_at_mux_unref(data->mux);
+		goto error;
+	}
+
+	for (i =3D 0; i < NUM_DLC; i++) {
+		GIOChannel *channel =3D g_at_mux_create_channel(data->mux);
+
+		data->dlcs[i] =3D create_chat(channel, modem, dlc_prefixes[i]);
+		if (data->dlcs[i] =3D=3D NULL) {
+			ofono_error("Failed to create channel");
+			goto error;
+		}
+	}
+	for (i =3D 0; i<NUM_DLC; i++) {
+		g_at_chat_register(data->dlcs[i], "SMS Ready", mux_ready_notify, FALSE, =
modem, NULL);
+	}
+
+	ofono_modem_set_powered(modem, TRUE);
+	return;
+
+error:
+	shutdown_device(data);
+	ofono_modem_set_powered(modem, FALSE);
+}
+
+static void mux_setup_cb(gboolean ok, GAtResult *result, gpointer user_dat=
a)
+{
+	struct ofono_modem *modem =3D user_data;
+	struct sim800_data *data =3D ofono_modem_get_data(modem);
+
+	DBG("");
+
+	g_at_chat_unref(data->dlcs[SETUP_DLC]);
+	data->dlcs[SETUP_DLC] =3D NULL;
+
+	if (!ok)
+		goto error;
+
+	data->mux_not_supported =3D 0;
+	setup_internal_mux(modem);
+	return;
+
+error:
+	DBG("If you are on a SIM800H modem with firmware version is \
+		1308B02SIM800H32_BT or lower, CMUX command is not supported thus \
+		preventing GPRS, Voice and SMS managers \
+		to be executed simultaneously.");
+	/*
+	 * If your use of SIM800 does not need simultaneous use of Voice, SMS =

+	 * and GPRS, you can ignore the error, set mux_not_supported=3D1 and comm=
ent
+	 * setup_internal_mux function, refactor this code to use only one DLC.
+	 * Else, you must contact SIMCOM to get a firmware update.
+	 */
+	shutdown_device(data);
+	ofono_modem_set_powered(modem, FALSE);
+}
+
+static void cfun_enable(gboolean ok, GAtResult *result, gpointer user_data)
+{
+	struct ofono_modem *modem =3D user_data;
+	struct sim800_data *data =3D ofono_modem_get_data(modem);
+
+	DBG("");
+
+	if (!ok) {
+		g_at_chat_unref(data->dlcs[SETUP_DLC]);
+		data->dlcs[SETUP_DLC] =3D NULL;
+		ofono_modem_set_powered(modem, FALSE);
+		return;
+	}
+
+	g_at_chat_send(data->dlcs[SETUP_DLC],"AT+CMUX=3D0,0,5,128,10,3,30,10,2", =
NULL,mux_setup_cb, modem, NULL);
+
+}
+
+static int sim800_enable(struct ofono_modem *modem)
+{
+	struct sim800_data *data =3D ofono_modem_get_data(modem);
+
+	DBG("%p", modem);
+
+	data->dlcs[SETUP_DLC] =3D open_device(modem, "Device", "Setup: ");
+	if (data->dlcs[SETUP_DLC] =3D=3D NULL){
+		DBG("couldn't open device");
+		return -EINVAL;
+	}
+
+	g_at_chat_send(data->dlcs[SETUP_DLC], "ATE0", NULL, NULL, NULL, NULL);
+	g_at_chat_send(data->dlcs[SETUP_DLC], "AT+CFUN=3D1", none_prefix,
+					cfun_enable, modem, NULL);
+
+	return -EINPROGRESS;
+}
+
+static void cfun_disable(gboolean ok, GAtResult *result, gpointer user_dat=
a)
+{
+	struct ofono_modem *modem =3D user_data;
+	struct sim800_data *data =3D ofono_modem_get_data(modem);
+
+	DBG("");
+
+	shutdown_device(data);
+
+	if (ok)
+		ofono_modem_set_powered(modem, FALSE);
+}
+
+static int sim800_disable(struct ofono_modem *modem)
+{
+	struct sim800_data *data =3D ofono_modem_get_data(modem);
+
+	DBG("%p", modem);
+
+	g_at_chat_send(data->dlcs[SETUP_DLC], "AT+CFUN=3D4", none_prefix,
+					cfun_disable, modem, NULL);
+
+	return -EINPROGRESS;
+}
+
+static void sim800_pre_sim(struct ofono_modem *modem)
+{
+	struct sim800_data *data =3D ofono_modem_get_data(modem);
+	struct ofono_sim *sim;
+
+	DBG("%p %x", modem, data);
+
+	ofono_devinfo_create(modem, 0, "atmodem", data->dlcs[VOICE_DLC]);
+	DBG("devinfo created");
+	sim =3D ofono_sim_create(modem, OFONO_VENDOR_SIMCOM, "atmodem",
+						data->dlcs[VOICE_DLC]);
+	DBG("sim created created");
+
+	if (sim)
+		ofono_sim_inserted_notify(sim, TRUE);
+
+	DBG("pre sim finished");
+}
+
+static void sim800_post_sim(struct ofono_modem *modem)
+{
+	struct sim800_data *data =3D ofono_modem_get_data(modem);
+	struct ofono_gprs *gprs =3D NULL;
+	struct ofono_gprs_context *gc;
+
+	DBG("%p", modem);
+
+	/* If CMUX command is not supported, we can go through
+	 * the normal way but with only one DLC.*/
+
+	if (data->mux_not_supported){
+
+		ofono_sms_create(modem, OFONO_VENDOR_SIMCOM, "atmodem",
+							data->dlcs[SMS_DLC]);
+
+
+	gprs =3D ofono_gprs_create(modem, 0, "atmodem", data->dlcs[GPRS_DLC]);
+	if (gprs =3D=3D NULL)
+		return;
+
+	gc =3D ofono_gprs_context_create(modem, OFONO_VENDOR_SIMCOM,
+					"atmodem", data->dlcs[GPRS_DLC]);
+	if (gc)
+		ofono_gprs_add_context(gprs, gc);
+	}
+}
+
+static void sim800_post_online(struct ofono_modem *modem)
+{
+	struct sim800_data *data =3D ofono_modem_get_data(modem);
+
+	DBG("%p", modem);
+
+	ofono_phonebook_create(modem, 0, "atmodem", data->dlcs[VOICE_DLC]);
+	ofono_netreg_create(modem, OFONO_VENDOR_SIMCOM,
+			"atmodem", data->dlcs[NETREG_DLC]);
+	ofono_ussd_create(modem, 0, "atmodem", data->dlcs[VOICE_DLC]);
+	ofono_voicecall_create(modem, 0, "atmodem", data->dlcs[VOICE_DLC]);
+	ofono_call_volume_create(modem, 0, "atmodem", data->dlcs[VOICE_DLC]);
+}
+
+static struct ofono_modem_driver sim800_driver =3D {
+	.name		=3D "sim800",
+	.probe		=3D sim800_probe,
+	.remove		=3D sim800_remove,
+	.enable		=3D sim800_enable,
+	.disable	=3D sim800_disable,
+	.pre_sim	=3D sim800_pre_sim,
+	.post_sim	=3D sim800_post_sim,
+	.post_online	=3D sim800_post_online,
+};
+
+static int sim800_init(void)
+{
+	return ofono_modem_driver_register(&sim800_driver);
+}
+
+static void sim800_exit(void)
+{
+	ofono_modem_driver_unregister(&sim800_driver);
+}
+
+OFONO_PLUGIN_DEFINE(sim800, "SIM800 modem driver", VERSION,
+		OFONO_PLUGIN_PRIORITY_DEFAULT, sim800_init, sim800_exit)
-- =

2.7.4


--===============8420455739588815540==--

