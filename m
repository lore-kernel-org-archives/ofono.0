Content-Type: multipart/mixed; boundary="===============5785080447447921267=="
MIME-Version: 1.0
From: Yang Gu <yang.gu@intel.com>
Subject: [PATCH] Add support of Huawei EM770 modem
Date: Tue, 16 Mar 2010 15:42:29 +0800
Message-ID: <1268725349-22790-1-git-send-email-yang.gu@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5785080447447921267==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Comparing with general Huawei modem, EM770 is a full feature modem that
supports voicecall, phonebook, call forwarding, call barring, etc.
---
 Makefile.am         |    3 +
 plugins/em770.c     |  226 +++++++++++++++++++++++++++++++++++++++++++++++=
++++
 plugins/ofono.rules |    1 +
 plugins/udev.c      |   27 ++++++
 4 files changed, 257 insertions(+), 0 deletions(-)
 create mode 100644 plugins/em770.c

diff --git a/Makefile.am b/Makefile.am
index 93d4f67..eca8eee 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -195,6 +195,9 @@ builtin_sources +=3D plugins/hso.c
 builtin_modules +=3D huawei
 builtin_sources +=3D plugins/huawei.c
 =

+builtin_modules +=3D em770
+builtin_sources +=3D plugins/em770.c
+
 builtin_modules +=3D novatel
 builtin_sources +=3D plugins/novatel.c
 =

diff --git a/plugins/em770.c b/plugins/em770.c
new file mode 100644
index 0000000..a5d87f7
--- /dev/null
+++ b/plugins/em770.c
@@ -0,0 +1,226 @@
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
+#include <ofono/ssn.h>
+#include <ofono/ussd.h>
+#include <ofono/gprs.h>
+#include <ofono/voicecall.h>
+
+#include <drivers/atmodem/vendor.h>
+
+struct em770_data {
+	GAtChat *chat;
+};
+
+static int em770_probe(struct ofono_modem *modem)
+{
+	struct em770_data *data;
+
+	DBG("%p", modem);
+
+	data =3D g_try_new0(struct em770_data, 1);
+	if (!data)
+		return -ENOMEM;
+
+	ofono_modem_set_data(modem, data);
+
+	return 0;
+}
+
+static void em770_remove(struct ofono_modem *modem)
+{
+	struct em770_data *data =3D ofono_modem_get_data(modem);
+
+	DBG("%p", modem);
+
+	ofono_modem_set_data(modem, NULL);
+
+	g_at_chat_unref(data->chat);
+	g_free(data);
+}
+
+static void em770_debug(const char *str, void *user_data)
+{
+	ofono_info("%s", str);
+}
+
+static void cfun_enable(gboolean ok, GAtResult *result, gpointer user_data)
+{
+	struct ofono_modem *modem =3D user_data;
+
+	DBG("");
+
+	if (ok)
+		ofono_modem_set_powered(modem, TRUE);
+}
+
+static int em770_enable(struct ofono_modem *modem)
+{
+	struct em770_data *data =3D ofono_modem_get_data(modem);
+	GAtSyntax *syntax;
+	GIOChannel *channel;
+	const char *device;
+
+	DBG("%p", modem);
+
+	device =3D ofono_modem_get_string(modem, "Device");
+	if (!device)
+			return -EINVAL;
+
+	channel =3D g_at_tty_open(device, NULL);
+	if (!channel)
+		return -EIO;
+
+	syntax =3D g_at_syntax_new_gsmv1();
+	data->chat =3D g_at_chat_new(channel, syntax);
+	g_at_syntax_unref(syntax);
+	g_io_channel_unref(channel);
+
+	if (!data->chat)
+		return -EIO;
+
+	g_at_chat_add_terminator(data->chat, "COMMAND NOT SUPPORT", -1, FALSE);
+	g_at_chat_add_terminator(data->chat, "TOO MANY PARAMETERS", -1, FALSE);
+
+	if (getenv("OFONO_AT_DEBUG"))
+		g_at_chat_set_debug(data->chat, em770_debug, NULL);
+
+	g_at_chat_send(data->chat, "ATE0", NULL, NULL, NULL, NULL);
+
+	g_at_chat_send(data->chat, "AT+CFUN=3D1", NULL,
+					cfun_enable, modem, NULL);
+
+	return 0;
+}
+
+static void cfun_disable(gboolean ok, GAtResult *result, gpointer user_dat=
a)
+{
+	struct ofono_modem *modem =3D user_data;
+	struct em770_data *data =3D ofono_modem_get_data(modem);
+
+	DBG("");
+
+	g_at_chat_shutdown(data->chat);
+	g_at_chat_unref(data->chat);
+	data->chat =3D NULL;
+
+	if (ok)
+		ofono_modem_set_powered(modem, FALSE);
+}
+
+static int em770_disable(struct ofono_modem *modem)
+{
+	struct em770_data *data =3D ofono_modem_get_data(modem);
+
+	DBG("%p", modem);
+
+	if (!data->chat)
+		return 0;
+
+	g_at_chat_cancel_all(data->chat);
+	g_at_chat_unregister_all(data->chat);
+	g_at_chat_send(data->chat, "AT+CFUN=3D0", NULL,
+					cfun_disable, modem, NULL);
+
+	return -EINPROGRESS;
+}
+
+static void em770_pre_sim(struct ofono_modem *modem)
+{
+	struct em770_data *data =3D ofono_modem_get_data(modem);
+
+	DBG("%p", modem);
+
+	ofono_devinfo_create(modem, 0, "atmodem", data->chat);
+	ofono_sim_create(modem, 0, "atmodem", data->chat);
+	ofono_voicecall_create(modem, 0, "atmodem", data->chat);
+}
+
+static void em770_post_sim(struct ofono_modem *modem)
+{
+	struct em770_data *data =3D ofono_modem_get_data(modem);
+	struct ofono_message_waiting *mw;
+
+	DBG("%p", modem);
+
+	ofono_ussd_create(modem, 0, "atmodem", data->chat);
+	ofono_call_forwarding_create(modem, 0, "atmodem", data->chat);
+	ofono_call_settings_create(modem, 0, "atmodem", data->chat);
+	ofono_netreg_create(modem, 0, "atmodem", data->chat);
+	ofono_call_meter_create(modem, 0, "atmodem", data->chat);
+	ofono_call_barring_create(modem, 0, "atmodem", data->chat);
+	ofono_ssn_create(modem, 0, "atmodem", data->chat);
+	ofono_sms_create(modem, OFONO_VENDOR_QUALCOMM_MSM, "atmodem", data->chat);
+	ofono_phonebook_create(modem, 0, "atmodem", data->chat);
+
+	mw =3D ofono_message_waiting_create(modem);
+	if (mw)
+		ofono_message_waiting_register(mw);
+}
+
+static struct ofono_modem_driver em770_driver =3D {
+	.name		=3D "em770",
+	.probe		=3D em770_probe,
+	.remove		=3D em770_remove,
+	.enable		=3D em770_enable,
+	.disable	=3D em770_disable,
+	.pre_sim	=3D em770_pre_sim,
+	.post_sim	=3D em770_post_sim,
+};
+
+static int em770_init(void)
+{
+	return ofono_modem_driver_register(&em770_driver);
+}
+
+static void em770_exit(void)
+{
+	ofono_modem_driver_unregister(&em770_driver);
+}
+
+OFONO_PLUGIN_DEFINE(em770, "HUAWEI EM770 modem driver", VERSION,
+		OFONO_PLUGIN_PRIORITY_DEFAULT, em770_init, em770_exit)
diff --git a/plugins/ofono.rules b/plugins/ofono.rules
index 3db0cf4..a6202f9 100644
--- a/plugins/ofono.rules
+++ b/plugins/ofono.rules
@@ -6,6 +6,7 @@ ENV{DEVTYPE}!=3D"usb_device", GOTO=3D"ofono_end"
 =

 # HUAWEI Technology
 ATTRS{idVendor}=3D=3D"12d1", ENV{OFONO_DRIVER}=3D"huawei"
+ATTRS{idVendor}=3D=3D"12d1", ATTRS{idProduct}=3D=3D"1404", ENV{OFONO_DRIVE=
R}=3D"em770"
 =

 # Novatel Wireless
 ATTRS{idVendor}=3D=3D"1410", ENV{OFONO_DRIVER}=3D"novatel"
diff --git a/plugins/udev.c b/plugins/udev.c
index 455bef3..9c4f2c8 100644
--- a/plugins/udev.c
+++ b/plugins/udev.c
@@ -28,6 +28,7 @@
 #include <libudev.h>
 =

 #include <glib.h>
+#include <string.h>
 =

 #define OFONO_API_SUBJECT_TO_CHANGE
 #include <ofono/plugin.h>
@@ -208,6 +209,30 @@ static void add_huawei(struct ofono_modem *modem,
 	ofono_modem_register(modem);
 }
 =

+static void add_em770(struct ofono_modem *modem,
+					struct udev_device *udev_device)
+{
+	const char *devnode, *intf_number;
+	int registered;
+	struct udev_device *parent;
+
+	registered =3D ofono_modem_get_integer(modem, "Registered");
+	if (registered !=3D 0)
+		return;
+
+	parent =3D udev_device_get_parent(udev_device);
+	parent =3D udev_device_get_parent(parent);
+	intf_number =3D udev_device_get_sysattr_value(parent, "bInterfaceNumber");
+
+	if (!strcmp(intf_number, "02")) {
+		devnode =3D udev_device_get_devnode(udev_device);
+		ofono_modem_set_string(modem, "Device", devnode);
+
+		ofono_modem_set_integer(modem, "Registered", 1);
+		ofono_modem_register(modem);
+	}
+}
+
 static void add_novatel(struct ofono_modem *modem,
 					struct udev_device *udev_device)
 {
@@ -271,6 +296,8 @@ static void add_modem(struct udev_device *udev_device)
 		add_hso(modem, udev_device);
 	else if (g_strcmp0(driver, "huawei") =3D=3D 0)
 		add_huawei(modem, udev_device);
+	else if (g_strcmp0(driver, "em770") =3D=3D 0)
+		add_em770(modem, udev_device);
 	else if (g_strcmp0(driver, "novatel") =3D=3D 0)
 		add_novatel(modem, udev_device);
 }
-- =

1.6.3.3


--===============5785080447447921267==--

