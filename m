Content-Type: multipart/mixed; boundary="===============7459588570500496165=="
MIME-Version: 1.0
From: Amit Mendapara <mendapara.amit@gmail.com>
Subject: [PATCH] plugin: add plugin for Linktop/Teracom LW273 data card
Date: Thu, 03 Feb 2011 20:33:55 +0530
Message-ID: <4d4ad72f.23968e0a.65af.3ec8@mx.google.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7459588570500496165==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Signed-off-by: Amit Mendapara <mendapara.amit@gmail.com>
---
 Makefile.am         |    3 +
 plugins/linktop.c   |  357 +++++++++++++++++++++++++++++++++++++++++++++++=
++++
 plugins/ofono.rules |    3 +
 plugins/udev.c      |   32 +++++
 4 files changed, 395 insertions(+), 0 deletions(-)
 create mode 100644 plugins/linktop.c

diff --git a/Makefile.am b/Makefile.am
index 758fb10..2fb8962 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -314,6 +314,9 @@ builtin_sources +=3D plugins/nokia.c
 builtin_modules +=3D nokiacdma
 builtin_sources +=3D plugins/nokiacdma.c
 =

+builtin_modules +=3D linktop
+builtin_sources +=3D plugins/linktop.c
+
 if BLUETOOTH
 builtin_modules +=3D bluetooth
 builtin_sources +=3D plugins/bluetooth.c plugins/bluetooth.h
diff --git a/plugins/linktop.c b/plugins/linktop.c
new file mode 100644
index 0000000..7f552b5
--- /dev/null
+++ b/plugins/linktop.c
@@ -0,0 +1,357 @@
+/*
+ *
+ *  oFono - Open Source Telephony
+ *
+ *  Copyright (C) 2008-2010  Intel Corporation. All rights reserved.
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
+#include <stdio.h>
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
+#include <ofono/call-barring.h>
+#include <ofono/call-forwarding.h>
+#include <ofono/call-meter.h>
+#include <ofono/call-settings.h>
+#include <ofono/devinfo.h>
+#include <ofono/message-waiting.h>
+#include <ofono/netreg.h>
+#include <ofono/sim.h>
+#include <ofono/cbs.h>
+#include <ofono/sms.h>
+#include <ofono/ssn.h>
+#include <ofono/ussd.h>
+#include <ofono/call-volume.h>
+#include <ofono/voicecall.h>
+#include <ofono/gprs.h>
+#include <ofono/gprs-context.h>
+#include <ofono/phonebook.h>
+#include <ofono/radio-settings.h>
+#include <ofono/log.h>
+
+#include <drivers/atmodem/vendor.h>
+#include <drivers/atmodem/atutil.h>
+
+static const char *none_prefix[] =3D { NULL };
+
+struct linktop_data {
+	GAtChat *modem;
+	GAtChat *control;
+	struct ofono_gprs *gprs;
+	struct ofono_gprs_context *gc;
+};
+
+static int linktop_probe(struct ofono_modem *modem)
+{
+	struct linktop_data *data;
+
+	DBG("%p", modem);
+
+	data =3D g_try_new0(struct linktop_data, 1);
+	if (data =3D=3D NULL)
+		return -ENOMEM;
+
+	ofono_modem_set_data(modem, data);
+
+	return 0;
+}
+
+static void linktop_remove(struct ofono_modem *modem)
+{
+	struct linktop_data *data =3D ofono_modem_get_data(modem);
+
+	DBG("%p", modem);
+
+	ofono_modem_set_data(modem, NULL);
+
+	g_at_chat_unref(data->modem);
+	g_at_chat_unref(data->control);
+
+	g_free(data);
+}
+
+static void linktop_debug(const char *str, void *user_data)
+{
+        const char *prefix =3D user_data;
+
+        ofono_info("%s%s", prefix, str);
+}
+
+static GAtChat *open_device(struct ofono_modem *modem,
+				const char *key, char *debug)
+{
+	const char *device;
+	GAtSyntax *syntax;
+	GIOChannel *channel;
+	GAtChat *chat;
+
+	device =3D ofono_modem_get_string(modem, key);
+	if (device =3D=3D NULL)
+		return NULL;
+
+	DBG("%s %s", key, device);
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
+	if (getenv("OFONO_AT_DEBUG"))
+		g_at_chat_set_debug(chat, linktop_debug, debug);
+
+	return chat;
+}
+
+static void linktop_disconnect(gpointer user_data)
+{
+	struct ofono_modem *modem =3D user_data;
+	struct linktop_data *data =3D ofono_modem_get_data(modem);
+
+	DBG("");
+
+	if (data->gc)
+		ofono_gprs_context_remove(data->gc);
+
+	g_at_chat_unref(data->modem);
+	data->modem =3D NULL;
+
+	data->modem =3D open_device(modem, "Modem", "Modem: ");
+	if (data->modem =3D=3D NULL)
+		return;
+
+	g_at_chat_set_disconnect_function(data->modem,
+						linktop_disconnect, modem);
+
+	ofono_info("Reopened GPRS context channel");
+
+	data->gc =3D ofono_gprs_context_create(modem, 0, "atmodem", data->modem);
+
+	if (data->gprs && data->gc)
+		ofono_gprs_add_context(data->gprs, data->gc);
+}
+
+static void cfun_enable(gboolean ok, GAtResult *result, gpointer user_data)
+{
+	struct ofono_modem *modem =3D user_data;
+
+	DBG("");
+
+	ofono_modem_set_powered(modem, ok);
+}
+
+static int linktop_enable(struct ofono_modem *modem)
+{
+	struct linktop_data *data =3D ofono_modem_get_data(modem);
+
+	DBG("%p", modem);
+
+	data->modem =3D open_device(modem, "Modem", "Modem: ");
+	if (data->modem =3D=3D NULL)
+		return -EINVAL;
+
+	g_at_chat_set_disconnect_function(data->modem,
+						linktop_disconnect, modem);
+
+	data->control =3D open_device(modem, "Control", "Control: ");
+	if (data->control =3D=3D NULL) {
+		g_at_chat_unref(data->modem);
+		data->modem =3D NULL;
+		return -EIO;
+	}
+
+	g_at_chat_send(data->control, "ATE0 +CMEE=3D1", none_prefix,
+						NULL, NULL, NULL);
+
+	g_at_chat_send(data->modem, "AT", none_prefix,
+						NULL, NULL, NULL);
+
+	g_at_chat_send(data->modem, "AT &F", none_prefix,
+						NULL, NULL, NULL);
+
+	g_at_chat_send(data->control, "AT+CFUN=3D1", none_prefix,
+					cfun_enable, modem, NULL);
+
+	return -EINPROGRESS;
+}
+
+static void cfun_disable(gboolean ok, GAtResult *result, gpointer user_dat=
a)
+{
+	struct ofono_modem *modem =3D user_data;
+	struct linktop_data *data =3D ofono_modem_get_data(modem);
+
+	DBG("");
+
+	g_at_chat_unref(data->control);
+	data->control =3D NULL;
+
+	if (ok)
+		ofono_modem_set_powered(modem, FALSE);
+}
+
+static int linktop_disable(struct ofono_modem *modem)
+{
+	struct linktop_data *data =3D ofono_modem_get_data(modem);
+
+	DBG("%p", modem);
+
+	if (data->modem) {
+		g_at_chat_cancel_all(data->modem);
+		g_at_chat_unregister_all(data->modem);
+		g_at_chat_unref(data->modem);
+		data->modem =3D NULL;
+	}
+
+	if (data->control =3D=3D NULL)
+		return 0;
+
+	g_at_chat_cancel_all(data->control);
+	g_at_chat_unregister_all(data->control);
+	g_at_chat_send(data->control, "AT+CFUN=3D4", none_prefix,
+					cfun_disable, modem, NULL);
+
+	return -EINPROGRESS;
+}
+
+static void set_online_cb(gboolean ok, GAtResult *result, gpointer user_da=
ta)
+{
+	struct cb_data *cbd =3D user_data;
+	ofono_modem_online_cb_t cb =3D cbd->cb;
+
+	if (ok)
+		CALLBACK_WITH_SUCCESS(cb, cbd->data);
+	else
+		CALLBACK_WITH_FAILURE(cb, cbd->data);
+}
+
+static void linktop_set_online(struct ofono_modem *modem, ofono_bool_t onl=
ine,
+				ofono_modem_online_cb_t cb, void *user_data)
+{
+	struct linktop_data *data =3D ofono_modem_get_data(modem);
+	GAtChat *chat =3D data->control;
+	struct cb_data *cbd =3D cb_data_new(cb, user_data);
+	char const *command =3D online ? "AT+CFUN=3D1" : "AT+CFUN=3D4";
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
+static void linktop_pre_sim(struct ofono_modem *modem)
+{
+	struct linktop_data *data =3D ofono_modem_get_data(modem);
+	struct ofono_sim *sim;
+
+	DBG("%p", modem);
+
+	ofono_devinfo_create(modem, 0, "atmodem", data->control);
+	sim =3D ofono_sim_create(modem, 0, "atmodem", data->control);
+	ofono_voicecall_create(modem, 0, "stemodem", data->control);
+
+	if (sim)
+		ofono_sim_inserted_notify(sim, TRUE);
+}
+
+static void linktop_post_sim(struct ofono_modem *modem)
+{
+	struct linktop_data *data =3D ofono_modem_get_data(modem);
+
+	DBG("%p", modem);
+
+	ofono_radio_settings_create(modem, 0, "stemodem", data->control);
+	ofono_phonebook_create(modem, 0, "atmodem", data->control);
+	ofono_sms_create(modem, 0, "atmodem", data->control);
+}
+
+static void linktop_post_online(struct ofono_modem *modem)
+{
+	struct linktop_data *data =3D ofono_modem_get_data(modem);
+	struct ofono_message_waiting *mw;
+	struct ofono_gprs *gprs;
+	struct ofono_gprs_context *gc;
+
+	DBG("%p", modem);
+
+	ofono_ussd_create(modem, 0, "atmodem", data->control);
+	ofono_call_forwarding_create(modem, 0, "atmodem", data->control);
+	ofono_call_settings_create(modem, 0, "atmodem", data->control);
+	ofono_netreg_create(modem, OFONO_VENDOR_MBM, "atmodem", data->control);
+	ofono_call_meter_create(modem, 0, "atmodem", data->control);
+	ofono_call_barring_create(modem, 0, "atmodem", data->control);
+	ofono_ssn_create(modem, 0, "atmodem", data->control);
+	ofono_call_volume_create(modem, 0, "atmodem", data->control);
+	ofono_cbs_create(modem, 0, "atmodem", data->control);
+
+	gprs =3D ofono_gprs_create(modem, OFONO_VENDOR_MBM,
+					"atmodem", data->control);
+	gc =3D ofono_gprs_context_create(modem, 0, "atmodem", data->modem);
+
+	if (gprs && gc)
+		ofono_gprs_add_context(gprs, gc);
+
+	mw =3D ofono_message_waiting_create(modem);
+
+	if (mw)
+		ofono_message_waiting_register(mw);
+}
+
+static struct ofono_modem_driver linktop_driver =3D {
+	.name		=3D "linktop",
+	.probe		=3D linktop_probe,
+	.remove		=3D linktop_remove,
+	.enable		=3D linktop_enable,
+	.disable	=3D linktop_disable,
+	.set_online =3D linktop_set_online,
+	.pre_sim	=3D linktop_pre_sim,
+	.post_sim	=3D linktop_post_sim,
+	.post_online	=3D linktop_post_online,
+};
+
+static int linktop_init(void)
+{
+	return ofono_modem_driver_register(&linktop_driver);
+}
+
+static void linktop_exit(void)
+{
+	ofono_modem_driver_unregister(&linktop_driver);
+}
+
+OFONO_PLUGIN_DEFINE(linktop, "Linktop Datacard modem driver", VERSION,
+		OFONO_PLUGIN_PRIORITY_DEFAULT, linktop_init, linktop_exit)
diff --git a/plugins/ofono.rules b/plugins/ofono.rules
index 111f071..c7a77fe 100644
--- a/plugins/ofono.rules
+++ b/plugins/ofono.rules
@@ -451,4 +451,7 @@ ATTRS{idVendor}=3D=3D"0421", ATTRS{idProduct}=3D=3D"062=
3", ENV{OFONO_DRIVER}=3D"nokia"
 ATTRS{idVendor}=3D=3D"0421", ATTRS{idProduct}=3D=3D"023e", ENV{OFONO_DRIVE=
R}=3D"nokiacdma"
 ATTRS{idVendor}=3D=3D"0421", ATTRS{idProduct}=3D=3D"00b6", ENV{OFONO_DRIVE=
R}=3D"nokiacdma"
 =

++# Teracom (Linktop/273) 3G Data Card
++ATTRS{idVendor}=3D=3D"230d", ATTRS{idProduct}=3D=3D"0001", ENV{OFONO_DRIV=
ER}=3D"linktop"
+
 LABEL=3D"ofono_end"
diff --git a/plugins/udev.c b/plugins/udev.c
index ce1efe6..84478d7 100644
--- a/plugins/udev.c
+++ b/plugins/udev.c
@@ -552,6 +552,36 @@ static void add_nokiacdma(struct ofono_modem *modem,
 	ofono_modem_register(modem);
 }
 =

+static void add_linktop(struct ofono_modem *modem,
+					struct udev_device *udev_device)
+{
+	const char *devnode, *intfnum;
+	struct udev_device *parent;
+	int registered;
+
+	DBG("modem %p", modem);
+
+	registered =3D ofono_modem_get_integer(modem, "Registered");
+	if (registered !=3D 0)
+		return;
+
+	parent =3D udev_device_get_parent(udev_device);
+	intfnum =3D udev_device_get_sysattr_value(parent, "bInterfaceNumber");
+
+	DBG("intfnum %s", intfnum);
+
+	if (g_strcmp0(intfnum, "01") =3D=3D 0) {
+		devnode =3D udev_device_get_devnode(udev_device);
+		ofono_modem_set_string(modem, "Modem", devnode);
+	} else if (g_strcmp0(intfnum, "03") =3D=3D 0) {
+		devnode =3D udev_device_get_devnode(udev_device);
+		ofono_modem_set_string(modem, "Control", devnode);
+
+		ofono_modem_set_integer(modem, "Registered", 1);
+		ofono_modem_register(modem);
+	}
+}
+
 static void add_modem(struct udev_device *udev_device)
 {
 	struct ofono_modem *modem;
@@ -646,6 +676,8 @@ done:
 		add_tc65(modem, udev_device);
 	else if (g_strcmp0(driver, "nokiacdma") =3D=3D 0)
 		add_nokiacdma(modem, udev_device);
+        else if (g_strcmp0(driver, "linktop") =3D=3D 0)
+		add_linktop(modem, udev_device);
 }
 =

 static gboolean devpath_remove(gpointer key, gpointer value, gpointer user=
_data)
-- =

1.7.1


--===============7459588570500496165==--

