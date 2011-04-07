Content-Type: multipart/mixed; boundary="===============2472995599678049934=="
MIME-Version: 1.0
From: Ostermann, Christophe <Christophe.Ostermann@sicpa.com>
Subject: [PATCH: Motorola H24 early support]
Date: Thu, 07 Apr 2011 13:35:44 +0200
Message-ID: <65D0035E6914AC478A46CFE3E20C392601E9F71C@snch1xch53.sicpa-net.ads>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2472995599678049934==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi, =


I try to send again a patch to support Motorola H24 modem.
Sorry but I can t use git to generate the patch in my environment.

I ve attached a patch file and send my mail in plain text.  Hope you can ea=
sily use this patch.

BR
Christophe



----------
Index: ofono-0.45/drivers/atmodem/sms.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- ofono-0.45.orig/drivers/atmodem/sms.c	2011-04-07 13:05:12.214329411 +02=
00
+++ ofono-0.45/drivers/atmodem/sms.c	2011-04-07 13:05:36.826829247 +0200
@@ -783,6 +783,7 @@
 	case OFONO_VENDOR_QUALCOMM_MSM:
 	case OFONO_VENDOR_NOVATEL:
 	case OFONO_VENDOR_HUAWEI:
+	case OFONO_VENDOR_MOTOROLA:
 		/* MSM devices advertise support for mode 2, but return an
 		 * error if we attempt to actually use it. */
 		mode =3D "1";
Index: ofono-0.45/drivers/atmodem/vendor.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- ofono-0.45.orig/drivers/atmodem/vendor.h	2011-04-07 13:05:12.222329128 =
+0200
+++ ofono-0.45/drivers/atmodem/vendor.h	2011-04-07 13:05:36.826829247 +0200
@@ -35,4 +35,5 @@
 	OFONO_VENDOR_WAVECOM,
 	OFONO_VENDOR_NOKIA,
 	OFONO_VENDOR_PHONESIM,
+	OFONO_VENDOR_MOTOROLA,
 };
Index: ofono-0.45/plugins/h24.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ ofono-0.45/plugins/h24.c	2011-04-07 13:05:36.826829247 +0200
@@ -0,0 +1,249 @@
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
+#include <drivers/atmodem/vendor.h>
+
+#include <ofono/gprs.h>
+#include <ofono/gprs-context.h>
+
+static int h24_probe(struct ofono_modem *modem)
+{
+	return 0;
+}
+
+static void h24_remove(struct ofono_modem *modem)
+{
+}
+
+static void h24_debug(const char *str, void *user_data)
+{
+	const char *prefix =3D user_data;
+
+	ofono_info("%s%s", prefix, str);
+}
+
+static int h24_enable(struct ofono_modem *modem)
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
+	 * H24 works almost as the 27.007 says. Today I
+         * just copied existing config from tc65.
+         * TODO: check if it works with a more stict parsing
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
+		g_at_chat_set_debug(chat, h24_debug, "");
+
+	ofono_modem_set_data(modem, chat);
+
+	return 0;
+}
+
+static int h24_disable(struct ofono_modem *modem)
+{
+	GAtChat *chat =3D ofono_modem_get_data(modem);
+
+	DBG("%p", modem);
+
+	ofono_modem_set_data(modem, NULL);
+
+	g_at_chat_send(chat, "AT+CFUN=3D4", NULL, NULL, NULL, NULL);
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
+static void h24_set_online(struct ofono_modem *modem, ofono_bool_t online,
+			ofono_modem_online_cb_t cb, void *user_data)
+{
+	GAtChat *chat =3D ofono_modem_get_data(modem);
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
+static void h24_pre_sim(struct ofono_modem *modem)
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
+static void h24_post_sim(struct ofono_modem *modem)
+{
+	GAtChat *chat =3D ofono_modem_get_data(modem);
+
+	DBG("%p", modem);
+
+	ofono_phonebook_create(modem, 0, "atmodem", chat);
+
+	ofono_sms_create(modem, OFONO_VENDOR_MOTOROLA, "atmodem", chat);
+}
+
+static void h24_post_online(struct ofono_modem *modem)
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
+	ofono_netreg_create(modem, 0, "atmodem", chat);
+	ofono_call_meter_create(modem, 0, "atmodem", chat);
+	ofono_call_barring_create(modem, 0, "atmodem", chat);
+
+	gprs =3D ofono_gprs_create(modem, 0, "atmodem", chat);
+	gc =3D ofono_gprs_context_create(modem, OFONO_VENDOR_MOTOROLA, "atmodem",=
 chat);
+
+        	DBG("GPRS");
+	if (gprs && gc){
+        	DBG("GPRS add context");
+
+		ofono_gprs_add_context(gprs, gc);
+        }
+	mw =3D ofono_message_waiting_create(modem);
+	if (mw)
+		ofono_message_waiting_register(mw);
+}
+
+static struct ofono_modem_driver h24_driver =3D {
+	.name                   =3D "h24",
+	.probe                  =3D h24_probe,
+	.remove                 =3D h24_remove,
+	.enable                 =3D h24_enable,
+	.disable                =3D h24_disable,
+	.set_online             =3D h24_set_online,
+	.pre_sim                =3D h24_pre_sim,
+	.post_sim               =3D h24_post_sim,
+	.post_online            =3D h24_post_online,
+};
+
+static int h24_init(void)
+{
+	return ofono_modem_driver_register(&h24_driver);
+}
+
+static void h24_exit(void)
+{
+	ofono_modem_driver_unregister(&h24_driver);
+}
+
+OFONO_PLUGIN_DEFINE(h24, "Motorola H24 driver plugin", VERSION,
+		OFONO_PLUGIN_PRIORITY_DEFAULT, h24_init, h24_exit)
Index: ofono-0.45/plugins/udev.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- ofono-0.45.orig/plugins/udev.c	2011-04-07 13:05:12.202389964 +0200
+++ ofono-0.45/plugins/udev.c	2011-04-07 13:05:36.826829247 +0200
@@ -545,6 +545,19 @@
 	ofono_modem_register(modem);
 }
 =

+static void add_h24(struct ofono_modem *modem,
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
@@ -682,6 +695,8 @@
 		add_calypso(modem, udev_device);
 	else if (g_strcmp0(driver, "tc65") =3D=3D 0)
 		add_tc65(modem, udev_device);
+	else if (g_strcmp0(driver, "h24") =3D=3D 0)
+		add_h24(modem, udev_device);
 	else if (g_strcmp0(driver, "nokiacdma") =3D=3D 0)
 		add_nokiacdma(modem, udev_device);
         else if (g_strcmp0(driver, "linktop") =3D=3D 0)
Index: ofono-0.45/doc/h24-modem.txt
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ ofono-0.45/doc/h24-modem.txt	2011-04-07 13:05:36.826829247 +0200
@@ -0,0 +1,11 @@
+H24 modem usage
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+The H24 modem is presented by the kernel as serial device
+/dev/ACM0 if usb link to modem is used. To allow oFono to
+autodetect and use this, a simple udev rule is needed:
+
+KERNEL=3D=3D"ttyACM0", ENV{OFONO_DRIVER}=3D"h24"
+
+You can put this in any file in /lib/udev/rules.d.
+
Index: ofono-0.45/drivers/atmodem/gprs-context.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- ofono-0.45.orig/drivers/atmodem/gprs-context.c	2011-04-07 13:05:12.2183=
43796 +0200
+++ ofono-0.45/drivers/atmodem/gprs-context.c	2011-04-07 13:05:36.826829247=
 +0200
@@ -41,6 +41,7 @@
 #include "gatppp.h"
 =

 #include "atmodem.h"
+#include "vendor.h"
 =

 #define TUN_SYSFS_DIR "/sys/devices/virtual/misc/tun"
 =

@@ -67,6 +68,7 @@
 		ofono_gprs_context_up_cb_t up_cb;       /* Up callback */
 	};
 	void *cb_data;                                  /* Callback data */
+	unsigned int vendor;
 };
 =

 static void ppp_debug(const char *str, void *data)
@@ -209,7 +211,11 @@
 		return;
 	}
 =

-	sprintf(buf, "AT+CGDATA=3D\"PPP\",%u", gcd->active_context);
+        if(gcd->vendor =3D=3D OFONO_VENDOR_MOTOROLA)
+		sprintf(buf, "ATD*99***%u#", gcd->active_context);
+        else
+		sprintf(buf, "AT+CGDATA=3D\"PPP\",%u", gcd->active_context);
+
 	if (g_at_chat_send(gcd->chat, buf, none_prefix,
 				at_cgdata_cb, gc, NULL) > 0)
 		return;
@@ -287,6 +293,8 @@
 =

 	gcd->chat =3D g_at_chat_clone(chat);
 =

+	gcd->vendor =3D vendor;
+
 	ofono_gprs_context_set_data(gc, gcd);
 =

 	return 0;
Index: ofono-0.45/Makefile.am
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- ofono-0.45.orig/Makefile.am	2011-04-07 13:06:29.298329934 +0200
+++ ofono-0.45/Makefile.am	2011-04-07 13:06:55.110329282 +0200
@@ -313,6 +313,9 @@
 builtin_modules +=3D tc65
 builtin_sources +=3D plugins/tc65.c
 =

+builtin_modules +=3D h24
+builtin_sources +=3D plugins/h24.c
+
 builtin_modules +=3D nokia
 builtin_sources +=3D plugins/nokia.c

----------


----------
Christophe Ostermann =

Software Engineer
Devices Engineering
SICPA Security Solutions SA
Av. de Florissant 41, 1008 Prilly, Switzerland
Tel +41 21 627 59 70 =C2=A0Direct +41 21 627=C2=A063 68
Fax +41 21 620 06 22 =

christophe.ostermann(a)sicpa.com =C2=A0www.sicpa.com
=C2=A0



This message was delivered through encrypted mechanism.


The information in this email and any attachments is confidential
and intended solely for the use of the individual(s) to whom it is
addressed or otherwise directed.
Please note that any views or opinions presented in this email are
solely those of the author and do not necessarily represent those
of the Company.
Finally, the recipient should check this email and any attachments
for the presence of viruses.
The Company accepts no liability for any damage caused by any virus
transmitted by this email.

--===============2472995599678049934==
Content-Type: application/octet-stream
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="h24-early_support.patch"

SW5kZXg6IG9mb25vLTAuNDUvZHJpdmVycy9hdG1vZGVtL3Ntcy5jCj09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0KLS0tIG9m
b25vLTAuNDUub3JpZy9kcml2ZXJzL2F0bW9kZW0vc21zLmMJMjAxMS0wNC0wNyAxMzowNToxMi4y
MTQzMjk0MTEgKzAyMDAKKysrIG9mb25vLTAuNDUvZHJpdmVycy9hdG1vZGVtL3Ntcy5jCTIwMTEt
MDQtMDcgMTM6MDU6MzYuODI2ODI5MjQ3ICswMjAwCkBAIC03ODMsNiArNzgzLDcgQEAKIAljYXNl
IE9GT05PX1ZFTkRPUl9RVUFMQ09NTV9NU006CiAJY2FzZSBPRk9OT19WRU5ET1JfTk9WQVRFTDoK
IAljYXNlIE9GT05PX1ZFTkRPUl9IVUFXRUk6CisJY2FzZSBPRk9OT19WRU5ET1JfTU9UT1JPTEE6
CiAJCS8qIE1TTSBkZXZpY2VzIGFkdmVydGlzZSBzdXBwb3J0IGZvciBtb2RlIDIsIGJ1dCByZXR1
cm4gYW4KIAkJICogZXJyb3IgaWYgd2UgYXR0ZW1wdCB0byBhY3R1YWxseSB1c2UgaXQuICovCiAJ
CW1vZGUgPSAiMSI7CkluZGV4OiBvZm9uby0wLjQ1L2RyaXZlcnMvYXRtb2RlbS92ZW5kb3IuaAo9
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09Ci0tLSBvZm9uby0wLjQ1Lm9yaWcvZHJpdmVycy9hdG1vZGVtL3ZlbmRvci5oCTIw
MTEtMDQtMDcgMTM6MDU6MTIuMjIyMzI5MTI4ICswMjAwCisrKyBvZm9uby0wLjQ1L2RyaXZlcnMv
YXRtb2RlbS92ZW5kb3IuaAkyMDExLTA0LTA3IDEzOjA1OjM2LjgyNjgyOTI0NyArMDIwMApAQCAt
MzUsNCArMzUsNSBAQAogCU9GT05PX1ZFTkRPUl9XQVZFQ09NLAogCU9GT05PX1ZFTkRPUl9OT0tJ
QSwKIAlPRk9OT19WRU5ET1JfUEhPTkVTSU0sCisJT0ZPTk9fVkVORE9SX01PVE9ST0xBLAogfTsK
SW5kZXg6IG9mb25vLTAuNDUvcGx1Z2lucy9oMjQuYwo9PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09Ci0tLSAvZGV2L251bGwJ
MTk3MC0wMS0wMSAwMDowMDowMC4wMDAwMDAwMDAgKzAwMDAKKysrIG9mb25vLTAuNDUvcGx1Z2lu
cy9oMjQuYwkyMDExLTA0LTA3IDEzOjA1OjM2LjgyNjgyOTI0NyArMDIwMApAQCAtMCwwICsxLDI0
OSBAQAorLyoKKyAqCisgKiAgb0Zvbm8gLSBPcGVuIFNvdXJjZSBUZWxlcGhvbnkKKyAqCisgKiAg
Q29weXJpZ2h0IChDKSAyMDA4LTIwMTAgIEludGVsIENvcnBvcmF0aW9uLiBBbGwgcmlnaHRzIHJl
c2VydmVkLgorICoKKyAqICBUaGlzIHByb2dyYW0gaXMgZnJlZSBzb2Z0d2FyZTsgeW91IGNhbiBy
ZWRpc3RyaWJ1dGUgaXQgYW5kL29yIG1vZGlmeQorICogIGl0IHVuZGVyIHRoZSB0ZXJtcyBvZiB0
aGUgR05VIEdlbmVyYWwgUHVibGljIExpY2Vuc2UgdmVyc2lvbiAyIGFzCisgKiAgcHVibGlzaGVk
IGJ5IHRoZSBGcmVlIFNvZnR3YXJlIEZvdW5kYXRpb24uCisgKgorICogIFRoaXMgcHJvZ3JhbSBp
cyBkaXN0cmlidXRlZCBpbiB0aGUgaG9wZSB0aGF0IGl0IHdpbGwgYmUgdXNlZnVsLAorICogIGJ1
dCBXSVRIT1VUIEFOWSBXQVJSQU5UWTsgd2l0aG91dCBldmVuIHRoZSBpbXBsaWVkIHdhcnJhbnR5
IG9mCisgKiAgTUVSQ0hBTlRBQklMSVRZIG9yIEZJVE5FU1MgRk9SIEEgUEFSVElDVUxBUiBQVVJQ
T1NFLiAgU2VlIHRoZQorICogIEdOVSBHZW5lcmFsIFB1YmxpYyBMaWNlbnNlIGZvciBtb3JlIGRl
dGFpbHMuCisgKgorICogIFlvdSBzaG91bGQgaGF2ZSByZWNlaXZlZCBhIGNvcHkgb2YgdGhlIEdO
VSBHZW5lcmFsIFB1YmxpYyBMaWNlbnNlCisgKiAgYWxvbmcgd2l0aCB0aGlzIHByb2dyYW07IGlm
IG5vdCwgd3JpdGUgdG8gdGhlIEZyZWUgU29mdHdhcmUKKyAqICBGb3VuZGF0aW9uLCBJbmMuLCA1
MSBGcmFua2xpbiBTdCwgRmlmdGggRmxvb3IsIEJvc3RvbiwgTUEgIDAyMTEwLTEzMDEgIFVTQQor
ICoKKyAqLworCisjaWZkZWYgSEFWRV9DT05GSUdfSAorI2luY2x1ZGUgPGNvbmZpZy5oPgorI2Vu
ZGlmCisKKyNpbmNsdWRlIDxlcnJuby5oPgorI2luY2x1ZGUgPHN0ZGxpYi5oPgorCisjaW5jbHVk
ZSA8Z2xpYi5oPgorI2luY2x1ZGUgPGdhdGNoYXQuaD4KKyNpbmNsdWRlIDxnYXR0dHkuaD4KKwor
I2RlZmluZSBPRk9OT19BUElfU1VCSkVDVF9UT19DSEFOR0UKKyNpbmNsdWRlIDxvZm9uby9wbHVn
aW4uaD4KKyNpbmNsdWRlIDxvZm9uby9sb2cuaD4KKyNpbmNsdWRlIDxvZm9uby9tb2RlbS5oPgor
I2luY2x1ZGUgPG9mb25vL2NhbGwtYmFycmluZy5oPgorI2luY2x1ZGUgPG9mb25vL2NhbGwtZm9y
d2FyZGluZy5oPgorI2luY2x1ZGUgPG9mb25vL2NhbGwtbWV0ZXIuaD4KKyNpbmNsdWRlIDxvZm9u
by9jYWxsLXNldHRpbmdzLmg+CisjaW5jbHVkZSA8b2Zvbm8vZGV2aW5mby5oPgorI2luY2x1ZGUg
PG9mb25vL21lc3NhZ2Utd2FpdGluZy5oPgorI2luY2x1ZGUgPG9mb25vL25ldHJlZy5oPgorI2lu
Y2x1ZGUgPG9mb25vL3Bob25lYm9vay5oPgorI2luY2x1ZGUgPG9mb25vL3NpbS5oPgorI2luY2x1
ZGUgPG9mb25vL3Ntcy5oPgorI2luY2x1ZGUgPG9mb25vL3Vzc2QuaD4KKyNpbmNsdWRlIDxvZm9u
by92b2ljZWNhbGwuaD4KKworI2luY2x1ZGUgPGRyaXZlcnMvYXRtb2RlbS9hdHV0aWwuaD4KKyNp
bmNsdWRlIDxkcml2ZXJzL2F0bW9kZW0vdmVuZG9yLmg+CisKKyNpbmNsdWRlIDxvZm9uby9ncHJz
Lmg+CisjaW5jbHVkZSA8b2Zvbm8vZ3Bycy1jb250ZXh0Lmg+CisKK3N0YXRpYyBpbnQgaDI0X3By
b2JlKHN0cnVjdCBvZm9ub19tb2RlbSAqbW9kZW0pCit7CisJcmV0dXJuIDA7Cit9CisKK3N0YXRp
YyB2b2lkIGgyNF9yZW1vdmUoc3RydWN0IG9mb25vX21vZGVtICptb2RlbSkKK3sKK30KKworc3Rh
dGljIHZvaWQgaDI0X2RlYnVnKGNvbnN0IGNoYXIgKnN0ciwgdm9pZCAqdXNlcl9kYXRhKQorewor
CWNvbnN0IGNoYXIgKnByZWZpeCA9IHVzZXJfZGF0YTsKKworCW9mb25vX2luZm8oIiVzJXMiLCBw
cmVmaXgsIHN0cik7Cit9CisKK3N0YXRpYyBpbnQgaDI0X2VuYWJsZShzdHJ1Y3Qgb2Zvbm9fbW9k
ZW0gKm1vZGVtKQoreworCUdBdENoYXQgKmNoYXQ7CisJR0lPQ2hhbm5lbCAqY2hhbm5lbDsKKwlH
QXRTeW50YXggKnN5bnRheDsKKwlHSGFzaFRhYmxlICpvcHRpb25zOworCWNvbnN0IGNoYXIgKmRl
dmljZTsKKworCURCRygiJXAiLCBtb2RlbSk7CisKKwlvcHRpb25zID0gZ19oYXNoX3RhYmxlX25l
dyhnX3N0cl9oYXNoLCBnX3N0cl9lcXVhbCk7CisJaWYgKG9wdGlvbnMgPT0gTlVMTCkKKwkJcmV0
dXJuIC1FTk9NRU07CisKKwlkZXZpY2UgPSBvZm9ub19tb2RlbV9nZXRfc3RyaW5nKG1vZGVtLCAi
RGV2aWNlIik7CisJaWYgKGRldmljZSA9PSBOVUxMKQorCQlyZXR1cm4gLUVJTlZBTDsKKworCWdf
aGFzaF90YWJsZV9pbnNlcnQob3B0aW9ucywgIkJhdWQiLCAiMTE1MjAwIik7CisJZ19oYXNoX3Rh
YmxlX2luc2VydChvcHRpb25zLCAiU3RvcEJpdHMiLCAiMSIpOworCWdfaGFzaF90YWJsZV9pbnNl
cnQob3B0aW9ucywgIkRhdGFCaXRzIiwgIjgiKTsKKwlnX2hhc2hfdGFibGVfaW5zZXJ0KG9wdGlv
bnMsICJQYXJpdHkiLCAibm9uZSIpOworCWdfaGFzaF90YWJsZV9pbnNlcnQob3B0aW9ucywgIlhv
blhvZmYiLCAib2ZmIik7CisJZ19oYXNoX3RhYmxlX2luc2VydChvcHRpb25zLCAiUnRzQ3RzIiwg
Im9uIik7CisJZ19oYXNoX3RhYmxlX2luc2VydChvcHRpb25zLCAiTG9jYWwiLCAib24iKTsKKwln
X2hhc2hfdGFibGVfaW5zZXJ0KG9wdGlvbnMsICJSZWFkIiwgIm9uIik7CisKKwljaGFubmVsID0g
Z19hdF90dHlfb3BlbihkZXZpY2UsIG9wdGlvbnMpOworCWdfaGFzaF90YWJsZV9kZXN0cm95KG9w
dGlvbnMpOworCisJaWYgKGNoYW5uZWwgPT0gTlVMTCkKKwkJcmV0dXJuIC1FSU87CisKKwkvKgor
CSAqIEgyNCB3b3JrcyBhbG1vc3QgYXMgdGhlIDI3LjAwNyBzYXlzLiBUb2RheSBJCisgICAgICAg
ICAqIGp1c3QgY29waWVkIGV4aXN0aW5nIGNvbmZpZyBmcm9tIHRjNjUuCisgICAgICAgICAqIFRP
RE86IGNoZWNrIGlmIGl0IHdvcmtzIHdpdGggYSBtb3JlIHN0aWN0IHBhcnNpbmcKKwkgKi8KKwlz
eW50YXggPSBnX2F0X3N5bnRheF9uZXdfZ3NtX3Blcm1pc3NpdmUoKTsKKworCWNoYXQgPSBnX2F0
X2NoYXRfbmV3KGNoYW5uZWwsIHN5bnRheCk7CisJZ19hdF9zeW50YXhfdW5yZWYoc3ludGF4KTsK
KwlnX2lvX2NoYW5uZWxfdW5yZWYoY2hhbm5lbCk7CisKKwlpZiAoY2hhdCA9PSBOVUxMKQorCQly
ZXR1cm4gLUVOT01FTTsKKworCWlmIChnZXRlbnYoIk9GT05PX0FUX0RFQlVHIikpCisJCWdfYXRf
Y2hhdF9zZXRfZGVidWcoY2hhdCwgaDI0X2RlYnVnLCAiIik7CisKKwlvZm9ub19tb2RlbV9zZXRf
ZGF0YShtb2RlbSwgY2hhdCk7CisKKwlyZXR1cm4gMDsKK30KKworc3RhdGljIGludCBoMjRfZGlz
YWJsZShzdHJ1Y3Qgb2Zvbm9fbW9kZW0gKm1vZGVtKQoreworCUdBdENoYXQgKmNoYXQgPSBvZm9u
b19tb2RlbV9nZXRfZGF0YShtb2RlbSk7CisKKwlEQkcoIiVwIiwgbW9kZW0pOworCisJb2Zvbm9f
bW9kZW1fc2V0X2RhdGEobW9kZW0sIE5VTEwpOworCisJZ19hdF9jaGF0X3NlbmQoY2hhdCwgIkFU
K0NGVU49NCIsIE5VTEwsIE5VTEwsIE5VTEwsIE5VTEwpOworCisJZ19hdF9jaGF0X3VucmVmKGNo
YXQpOworCisJcmV0dXJuIDA7Cit9CisKK3N0YXRpYyB2b2lkIHNldF9vbmxpbmVfY2IoZ2Jvb2xl
YW4gb2ssIEdBdFJlc3VsdCAqcmVzdWx0LCBncG9pbnRlciB1c2VyX2RhdGEpCit7CisJc3RydWN0
IGNiX2RhdGEgKmNiZCA9IHVzZXJfZGF0YTsKKwlvZm9ub19tb2RlbV9vbmxpbmVfY2JfdCBjYiA9
IGNiZC0+Y2I7CisJc3RydWN0IG9mb25vX2Vycm9yIGVycm9yOworCisJZGVjb2RlX2F0X2Vycm9y
KCZlcnJvciwgZ19hdF9yZXN1bHRfZmluYWxfcmVzcG9uc2UocmVzdWx0KSk7CisKKwljYigmZXJy
b3IsIGNiZC0+ZGF0YSk7Cit9CisKK3N0YXRpYyB2b2lkIGgyNF9zZXRfb25saW5lKHN0cnVjdCBv
Zm9ub19tb2RlbSAqbW9kZW0sIG9mb25vX2Jvb2xfdCBvbmxpbmUsCisJCQlvZm9ub19tb2RlbV9v
bmxpbmVfY2JfdCBjYiwgdm9pZCAqdXNlcl9kYXRhKQoreworCUdBdENoYXQgKmNoYXQgPSBvZm9u
b19tb2RlbV9nZXRfZGF0YShtb2RlbSk7CisJc3RydWN0IGNiX2RhdGEgKmNiZCA9IGNiX2RhdGFf
bmV3KGNiLCB1c2VyX2RhdGEpOworCWNoYXIgY29uc3QgKmNvbW1hbmQgPSBvbmxpbmUgPyAiQVQr
Q0ZVTj0xIiA6ICJBVCtDRlVOPTQiOworCisJREJHKCJtb2RlbSAlcCAlcyIsIG1vZGVtLCBvbmxp
bmUgPyAib25saW5lIiA6ICJvZmZsaW5lIik7CisKKwlpZiAoZ19hdF9jaGF0X3NlbmQoY2hhdCwg
Y29tbWFuZCwgTlVMTCwgc2V0X29ubGluZV9jYiwgY2JkLCBnX2ZyZWUpKQorCQlyZXR1cm47CisK
KwlnX2ZyZWUoY2JkKTsKKworCUNBTExCQUNLX1dJVEhfRkFJTFVSRShjYiwgY2JkLT5kYXRhKTsK
K30KKworc3RhdGljIHZvaWQgaDI0X3ByZV9zaW0oc3RydWN0IG9mb25vX21vZGVtICptb2RlbSkK
K3sKKwlHQXRDaGF0ICpjaGF0ID0gb2Zvbm9fbW9kZW1fZ2V0X2RhdGEobW9kZW0pOworCXN0cnVj
dCBvZm9ub19zaW0gKnNpbTsKKworCURCRygiJXAiLCBtb2RlbSk7CisKKwlvZm9ub19kZXZpbmZv
X2NyZWF0ZShtb2RlbSwgMCwgImF0bW9kZW0iLCBjaGF0KTsKKwlzaW0gPSBvZm9ub19zaW1fY3Jl
YXRlKG1vZGVtLCAwLCAiYXRtb2RlbSIsIGNoYXQpOworCW9mb25vX3ZvaWNlY2FsbF9jcmVhdGUo
bW9kZW0sIDAsICJhdG1vZGVtIiwgY2hhdCk7CisKKwlpZiAoc2ltKQorCQlvZm9ub19zaW1faW5z
ZXJ0ZWRfbm90aWZ5KHNpbSwgVFJVRSk7Cit9CisKK3N0YXRpYyB2b2lkIGgyNF9wb3N0X3NpbShz
dHJ1Y3Qgb2Zvbm9fbW9kZW0gKm1vZGVtKQoreworCUdBdENoYXQgKmNoYXQgPSBvZm9ub19tb2Rl
bV9nZXRfZGF0YShtb2RlbSk7CisKKwlEQkcoIiVwIiwgbW9kZW0pOworCisJb2Zvbm9fcGhvbmVi
b29rX2NyZWF0ZShtb2RlbSwgMCwgImF0bW9kZW0iLCBjaGF0KTsKKworCW9mb25vX3Ntc19jcmVh
dGUobW9kZW0sIE9GT05PX1ZFTkRPUl9NT1RPUk9MQSwgImF0bW9kZW0iLCBjaGF0KTsKK30KKwor
c3RhdGljIHZvaWQgaDI0X3Bvc3Rfb25saW5lKHN0cnVjdCBvZm9ub19tb2RlbSAqbW9kZW0pCit7
CisJR0F0Q2hhdCAqY2hhdCA9IG9mb25vX21vZGVtX2dldF9kYXRhKG1vZGVtKTsKKwlzdHJ1Y3Qg
b2Zvbm9fbWVzc2FnZV93YWl0aW5nICptdzsKKwlzdHJ1Y3Qgb2Zvbm9fZ3BycyAqZ3ByczsKKwlz
dHJ1Y3Qgb2Zvbm9fZ3Byc19jb250ZXh0ICpnYzsKKworCURCRygiJXAiLCBtb2RlbSk7CisKKwlv
Zm9ub191c3NkX2NyZWF0ZShtb2RlbSwgMCwgImF0bW9kZW0iLCBjaGF0KTsKKwlvZm9ub19jYWxs
X2ZvcndhcmRpbmdfY3JlYXRlKG1vZGVtLCAwLCAiYXRtb2RlbSIsIGNoYXQpOworCW9mb25vX2Nh
bGxfc2V0dGluZ3NfY3JlYXRlKG1vZGVtLCAwLCAiYXRtb2RlbSIsIGNoYXQpOworCW9mb25vX25l
dHJlZ19jcmVhdGUobW9kZW0sIDAsICJhdG1vZGVtIiwgY2hhdCk7CisJb2Zvbm9fY2FsbF9tZXRl
cl9jcmVhdGUobW9kZW0sIDAsICJhdG1vZGVtIiwgY2hhdCk7CisJb2Zvbm9fY2FsbF9iYXJyaW5n
X2NyZWF0ZShtb2RlbSwgMCwgImF0bW9kZW0iLCBjaGF0KTsKKworCWdwcnMgPSBvZm9ub19ncHJz
X2NyZWF0ZShtb2RlbSwgMCwgImF0bW9kZW0iLCBjaGF0KTsKKwlnYyA9IG9mb25vX2dwcnNfY29u
dGV4dF9jcmVhdGUobW9kZW0sIE9GT05PX1ZFTkRPUl9NT1RPUk9MQSwgImF0bW9kZW0iLCBjaGF0
KTsKKworICAgICAgICAJREJHKCJHUFJTIik7CisJaWYgKGdwcnMgJiYgZ2MpeworICAgICAgICAJ
REJHKCJHUFJTIGFkZCBjb250ZXh0Iik7CisKKwkJb2Zvbm9fZ3Byc19hZGRfY29udGV4dChncHJz
LCBnYyk7CisgICAgICAgIH0KKwltdyA9IG9mb25vX21lc3NhZ2Vfd2FpdGluZ19jcmVhdGUobW9k
ZW0pOworCWlmIChtdykKKwkJb2Zvbm9fbWVzc2FnZV93YWl0aW5nX3JlZ2lzdGVyKG13KTsKK30K
Kworc3RhdGljIHN0cnVjdCBvZm9ub19tb2RlbV9kcml2ZXIgaDI0X2RyaXZlciA9IHsKKwkubmFt
ZSAgICAgICAgICAgICAgICAgICA9ICJoMjQiLAorCS5wcm9iZSAgICAgICAgICAgICAgICAgID0g
aDI0X3Byb2JlLAorCS5yZW1vdmUgICAgICAgICAgICAgICAgID0gaDI0X3JlbW92ZSwKKwkuZW5h
YmxlICAgICAgICAgICAgICAgICA9IGgyNF9lbmFibGUsCisJLmRpc2FibGUgICAgICAgICAgICAg
ICAgPSBoMjRfZGlzYWJsZSwKKwkuc2V0X29ubGluZSAgICAgICAgICAgICA9IGgyNF9zZXRfb25s
aW5lLAorCS5wcmVfc2ltICAgICAgICAgICAgICAgID0gaDI0X3ByZV9zaW0sCisJLnBvc3Rfc2lt
ICAgICAgICAgICAgICAgPSBoMjRfcG9zdF9zaW0sCisJLnBvc3Rfb25saW5lICAgICAgICAgICAg
PSBoMjRfcG9zdF9vbmxpbmUsCit9OworCitzdGF0aWMgaW50IGgyNF9pbml0KHZvaWQpCit7CisJ
cmV0dXJuIG9mb25vX21vZGVtX2RyaXZlcl9yZWdpc3RlcigmaDI0X2RyaXZlcik7Cit9CisKK3N0
YXRpYyB2b2lkIGgyNF9leGl0KHZvaWQpCit7CisJb2Zvbm9fbW9kZW1fZHJpdmVyX3VucmVnaXN0
ZXIoJmgyNF9kcml2ZXIpOworfQorCitPRk9OT19QTFVHSU5fREVGSU5FKGgyNCwgIk1vdG9yb2xh
IEgyNCBkcml2ZXIgcGx1Z2luIiwgVkVSU0lPTiwKKwkJT0ZPTk9fUExVR0lOX1BSSU9SSVRZX0RF
RkFVTFQsIGgyNF9pbml0LCBoMjRfZXhpdCkKSW5kZXg6IG9mb25vLTAuNDUvcGx1Z2lucy91ZGV2
LmMKPT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PQotLS0gb2Zvbm8tMC40NS5vcmlnL3BsdWdpbnMvdWRldi5jCTIwMTEtMDQt
MDcgMTM6MDU6MTIuMjAyMzg5OTY0ICswMjAwCisrKyBvZm9uby0wLjQ1L3BsdWdpbnMvdWRldi5j
CTIwMTEtMDQtMDcgMTM6MDU6MzYuODI2ODI5MjQ3ICswMjAwCkBAIC01NDUsNiArNTQ1LDE5IEBA
CiAJb2Zvbm9fbW9kZW1fcmVnaXN0ZXIobW9kZW0pOwogfQogCitzdGF0aWMgdm9pZCBhZGRfaDI0
KHN0cnVjdCBvZm9ub19tb2RlbSAqbW9kZW0sCisJCQlzdHJ1Y3QgdWRldl9kZXZpY2UgKnVkZXZf
ZGV2aWNlKQoreworCWNvbnN0IGNoYXIgKmRldm5vZGU7CisKKwlEQkcoIm1vZGVtICVwIiwgbW9k
ZW0pOworCisJZGV2bm9kZSA9IHVkZXZfZGV2aWNlX2dldF9kZXZub2RlKHVkZXZfZGV2aWNlKTsK
KwlvZm9ub19tb2RlbV9zZXRfc3RyaW5nKG1vZGVtLCAiRGV2aWNlIiwgZGV2bm9kZSk7CisKKwlv
Zm9ub19tb2RlbV9yZWdpc3Rlcihtb2RlbSk7Cit9CisKIHN0YXRpYyB2b2lkIGFkZF9ub2tpYWNk
bWEoc3RydWN0IG9mb25vX21vZGVtICptb2RlbSwKIAkJCQkJc3RydWN0IHVkZXZfZGV2aWNlICp1
ZGV2X2RldmljZSkKIHsKQEAgLTY4Miw2ICs2OTUsOCBAQAogCQlhZGRfY2FseXBzbyhtb2RlbSwg
dWRldl9kZXZpY2UpOwogCWVsc2UgaWYgKGdfc3RyY21wMChkcml2ZXIsICJ0YzY1IikgPT0gMCkK
IAkJYWRkX3RjNjUobW9kZW0sIHVkZXZfZGV2aWNlKTsKKwllbHNlIGlmIChnX3N0cmNtcDAoZHJp
dmVyLCAiaDI0IikgPT0gMCkKKwkJYWRkX2gyNChtb2RlbSwgdWRldl9kZXZpY2UpOwogCWVsc2Ug
aWYgKGdfc3RyY21wMChkcml2ZXIsICJub2tpYWNkbWEiKSA9PSAwKQogCQlhZGRfbm9raWFjZG1h
KG1vZGVtLCB1ZGV2X2RldmljZSk7CiAgICAgICAgIGVsc2UgaWYgKGdfc3RyY21wMChkcml2ZXIs
ICJsaW5rdG9wIikgPT0gMCkKSW5kZXg6IG9mb25vLTAuNDUvZG9jL2gyNC1tb2RlbS50eHQKPT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PQotLS0gL2Rldi9udWxsCTE5NzAtMDEtMDEgMDA6MDA6MDAuMDAwMDAwMDAwICswMDAw
CisrKyBvZm9uby0wLjQ1L2RvYy9oMjQtbW9kZW0udHh0CTIwMTEtMDQtMDcgMTM6MDU6MzYuODI2
ODI5MjQ3ICswMjAwCkBAIC0wLDAgKzEsMTEgQEAKK0gyNCBtb2RlbSB1c2FnZQorPT09PT09PT09
PT09PT09PT09PQorCitUaGUgSDI0IG1vZGVtIGlzIHByZXNlbnRlZCBieSB0aGUga2VybmVsIGFz
IHNlcmlhbCBkZXZpY2UKKy9kZXYvQUNNMCBpZiB1c2IgbGluayB0byBtb2RlbSBpcyB1c2VkLiBU
byBhbGxvdyBvRm9ubyB0bworYXV0b2RldGVjdCBhbmQgdXNlIHRoaXMsIGEgc2ltcGxlIHVkZXYg
cnVsZSBpcyBuZWVkZWQ6CisKK0tFUk5FTD09InR0eUFDTTAiLCBFTlZ7T0ZPTk9fRFJJVkVSfT0i
aDI0IgorCitZb3UgY2FuIHB1dCB0aGlzIGluIGFueSBmaWxlIGluIC9saWIvdWRldi9ydWxlcy5k
LgorCkluZGV4OiBvZm9uby0wLjQ1L2RyaXZlcnMvYXRtb2RlbS9ncHJzLWNvbnRleHQuYwo9PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09Ci0tLSBvZm9uby0wLjQ1Lm9yaWcvZHJpdmVycy9hdG1vZGVtL2dwcnMtY29udGV4dC5j
CTIwMTEtMDQtMDcgMTM6MDU6MTIuMjE4MzQzNzk2ICswMjAwCisrKyBvZm9uby0wLjQ1L2RyaXZl
cnMvYXRtb2RlbS9ncHJzLWNvbnRleHQuYwkyMDExLTA0LTA3IDEzOjA1OjM2LjgyNjgyOTI0NyAr
MDIwMApAQCAtNDEsNiArNDEsNyBAQAogI2luY2x1ZGUgImdhdHBwcC5oIgogCiAjaW5jbHVkZSAi
YXRtb2RlbS5oIgorI2luY2x1ZGUgInZlbmRvci5oIgogCiAjZGVmaW5lIFRVTl9TWVNGU19ESVIg
Ii9zeXMvZGV2aWNlcy92aXJ0dWFsL21pc2MvdHVuIgogCkBAIC02Nyw2ICs2OCw3IEBACiAJCW9m
b25vX2dwcnNfY29udGV4dF91cF9jYl90IHVwX2NiOyAgICAgICAvKiBVcCBjYWxsYmFjayAqLwog
CX07CiAJdm9pZCAqY2JfZGF0YTsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgLyog
Q2FsbGJhY2sgZGF0YSAqLworCXVuc2lnbmVkIGludCB2ZW5kb3I7CiB9OwogCiBzdGF0aWMgdm9p
ZCBwcHBfZGVidWcoY29uc3QgY2hhciAqc3RyLCB2b2lkICpkYXRhKQpAQCAtMjA5LDcgKzIxMSwx
MSBAQAogCQlyZXR1cm47CiAJfQogCi0Jc3ByaW50ZihidWYsICJBVCtDR0RBVEE9XCJQUFBcIiwl
dSIsIGdjZC0+YWN0aXZlX2NvbnRleHQpOworICAgICAgICBpZihnY2QtPnZlbmRvciA9PSBPRk9O
T19WRU5ET1JfTU9UT1JPTEEpCisJCXNwcmludGYoYnVmLCAiQVREKjk5KioqJXUjIiwgZ2NkLT5h
Y3RpdmVfY29udGV4dCk7CisgICAgICAgIGVsc2UKKwkJc3ByaW50ZihidWYsICJBVCtDR0RBVEE9
XCJQUFBcIiwldSIsIGdjZC0+YWN0aXZlX2NvbnRleHQpOworCiAJaWYgKGdfYXRfY2hhdF9zZW5k
KGdjZC0+Y2hhdCwgYnVmLCBub25lX3ByZWZpeCwKIAkJCQlhdF9jZ2RhdGFfY2IsIGdjLCBOVUxM
KSA+IDApCiAJCXJldHVybjsKQEAgLTI4Nyw2ICsyOTMsOCBAQAogCiAJZ2NkLT5jaGF0ID0gZ19h
dF9jaGF0X2Nsb25lKGNoYXQpOwogCisJZ2NkLT52ZW5kb3IgPSB2ZW5kb3I7CisKIAlvZm9ub19n
cHJzX2NvbnRleHRfc2V0X2RhdGEoZ2MsIGdjZCk7CiAKIAlyZXR1cm4gMDsKSW5kZXg6IG9mb25v
LTAuNDUvTWFrZWZpbGUuYW0KPT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PQotLS0gb2Zvbm8tMC40NS5vcmlnL01ha2VmaWxl
LmFtCTIwMTEtMDQtMDcgMTM6MDY6MjkuMjk4MzI5OTM0ICswMjAwCisrKyBvZm9uby0wLjQ1L01h
a2VmaWxlLmFtCTIwMTEtMDQtMDcgMTM6MDY6NTUuMTEwMzI5MjgyICswMjAwCkBAIC0zMTMsNiAr
MzEzLDkgQEAKIGJ1aWx0aW5fbW9kdWxlcyArPSB0YzY1CiBidWlsdGluX3NvdXJjZXMgKz0gcGx1
Z2lucy90YzY1LmMKIAorYnVpbHRpbl9tb2R1bGVzICs9IGgyNAorYnVpbHRpbl9zb3VyY2VzICs9
IHBsdWdpbnMvaDI0LmMKKwogYnVpbHRpbl9tb2R1bGVzICs9IG5va2lhCiBidWlsdGluX3NvdXJj
ZXMgKz0gcGx1Z2lucy9ub2tpYS5jCiAK

--===============2472995599678049934==--

