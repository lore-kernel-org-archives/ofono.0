Content-Type: multipart/mixed; boundary="===============1993169694071301767=="
MIME-Version: 1.0
From: Matthias <matgnt@gmail.com>
Subject: [PATCH] Added Wavecom modem plugin.
Date: Mon, 19 Apr 2010 21:34:28 +0200
Message-ID: <1271705668-23970-1-git-send-email-matgnt@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1993169694071301767==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The Wavecom WMP100 assumes CPIN to be the final response, therefore some sp=
ecial handling is
neccessary (see 6d28f82dc1ccb3de3a028a88eafb96fb001c7e61). Now the vendor i=
d OFONO_VENDOR_WAVECOM
is passed with all "*create" functions.
---
 Makefile.am         |    3 +
 plugins/modemconf.c |    1 +
 plugins/wavecom.c   |  212 +++++++++++++++++++++++++++++++++++++++++++++++=
++++
 3 files changed, 216 insertions(+), 0 deletions(-)
 create mode 100644 plugins/wavecom.c

diff --git a/Makefile.am b/Makefile.am
index 0eaadda..9b4b31c 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -187,6 +187,9 @@ builtin_sources +=3D plugins/atgen.c
 builtin_modules +=3D g1
 builtin_sources +=3D plugins/g1.c
 =

+builtin_modules +=3D wavecom
+builtin_sources +=3D plugins/wavecom.c
+
 builtin_modules +=3D calypso
 builtin_sources +=3D plugins/calypso.c
 =

diff --git a/plugins/modemconf.c b/plugins/modemconf.c
index cf0ee8b..f38ca98 100644
--- a/plugins/modemconf.c
+++ b/plugins/modemconf.c
@@ -121,6 +121,7 @@ static struct {
 	{ "phonesim",	set_address	},
 	{ "atgen",	set_device	},
 	{ "g1",		set_device	},
+	{ "wavecom",	set_device	},
 	{ "ste",	set_device	},
 	{ "calypso",	set_device	},
 	{ "palmpre",	set_device	},
diff --git a/plugins/wavecom.c b/plugins/wavecom.c
new file mode 100644
index 0000000..7beeb5b
--- /dev/null
+++ b/plugins/wavecom.c
@@ -0,0 +1,212 @@
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
+#include <ofono/ssn.h>
+#include <ofono/ussd.h>
+#include <ofono/voicecall.h>
+
+#include <drivers/atmodem/vendor.h>
+
+static const char *tty_opts[] =3D {
+	"Baud",
+	"Read",
+	"Local",
+	"StopBits",
+	"DataBits",
+	"Parity",
+	"XonXoff",
+	"RtsCts",
+	NULL,
+};
+
+static int wavecom_probe(struct ofono_modem *modem)
+{
+	return 0;
+}
+
+static void wavecom_remove(struct ofono_modem *modem)
+{
+}
+
+static void wavecom_debug(const char *str, void *user_data)
+{
+	ofono_info("%s", str);
+}
+
+static int wavecom_enable(struct ofono_modem *modem)
+{
+	GAtChat *chat;
+	GIOChannel *channel;
+	GAtSyntax *syntax;
+	const char *device;
+	const char *value;
+	GHashTable *options;
+	int i;
+
+	DBG("%p", modem);
+
+	device =3D ofono_modem_get_string(modem, "Device");
+	if (!device)
+		return -EINVAL;
+
+	options =3D g_hash_table_new_full(g_str_hash, g_str_equal,
+					g_free, g_free);
+	if (!options)
+		return -ENOMEM;
+
+	for (i =3D 0; tty_opts[i]; i++) {
+		value =3D ofono_modem_get_string(modem, tty_opts[i]);
+
+		if (value =3D=3D NULL)
+			continue;
+
+		g_hash_table_insert(options, g_strdup(tty_opts[i]),
+					g_strdup(value));
+	}
+
+	channel =3D g_at_tty_open(device, options);
+
+	g_hash_table_destroy(options);
+
+	if (!channel) {
+		return -EIO;
+	}
+
+	value =3D ofono_modem_get_string(modem, "GsmSyntax");
+	if (value) {
+		if (g_str_equal(value, "V1"))
+			syntax =3D g_at_syntax_new_gsmv1();
+		else if (g_str_equal(value, "Permissive"))
+			syntax =3D g_at_syntax_new_gsm_permissive();
+		else
+			return -EINVAL;
+	} else {
+		syntax =3D g_at_syntax_new_gsmv1();
+	}
+
+	chat =3D g_at_chat_new(channel, syntax);
+	g_at_syntax_unref(syntax);
+	g_io_channel_unref(channel);
+
+	if (!chat)
+		return -ENOMEM;
+
+	if (getenv("OFONO_AT_DEBUG"))
+		g_at_chat_set_debug(chat, wavecom_debug, NULL);
+
+	ofono_modem_set_data(modem, chat);
+
+	return 0;
+}
+
+static int wavecom_disable(struct ofono_modem *modem)
+{
+	GAtChat *chat =3D ofono_modem_get_data(modem);
+
+	DBG("%p", modem);
+
+	ofono_modem_set_data(modem, NULL);
+
+	g_at_chat_unref(chat);
+
+	return 0;
+}
+
+static void wavecom_pre_sim(struct ofono_modem *modem)
+{
+	GAtChat *chat =3D ofono_modem_get_data(modem);
+
+	DBG("%p", modem);
+
+	ofono_devinfo_create(modem, OFONO_VENDOR_WAVECOM, "atmodem", chat);
+	ofono_sim_create(modem, OFONO_VENDOR_WAVECOM, "atmodem", chat);
+	ofono_voicecall_create(modem, OFONO_VENDOR_WAVECOM, "atmodem", chat);
+}
+
+static void wavecom_post_sim(struct ofono_modem *modem)
+{
+	GAtChat *chat =3D ofono_modem_get_data(modem);
+	struct ofono_message_waiting *mw;
+
+	DBG("%p", modem);
+
+	ofono_ussd_create(modem, OFONO_VENDOR_WAVECOM, "atmodem", chat);
+	ofono_call_forwarding_create(modem, OFONO_VENDOR_WAVECOM, "atmodem", chat=
);
+	ofono_call_settings_create(modem, OFONO_VENDOR_WAVECOM, "atmodem", chat);
+	ofono_netreg_create(modem, OFONO_VENDOR_WAVECOM, "atmodem", chat);
+	ofono_call_meter_create(modem, OFONO_VENDOR_WAVECOM, "atmodem", chat);
+	ofono_call_barring_create(modem, OFONO_VENDOR_WAVECOM, "atmodem", chat);
+	ofono_ssn_create(modem, OFONO_VENDOR_WAVECOM, "atmodem", chat);
+	ofono_sms_create(modem, OFONO_VENDOR_WAVECOM, "atmodem", chat);
+	ofono_phonebook_create(modem, OFONO_VENDOR_WAVECOM, "atmodem", chat);
+
+	mw =3D ofono_message_waiting_create(modem);
+	if (mw)
+		ofono_message_waiting_register(mw);
+}
+
+static struct ofono_modem_driver wavecom_driver =3D {
+	.name		=3D "wavecom",
+	.probe		=3D wavecom_probe,
+	.remove		=3D wavecom_remove,
+	.enable		=3D wavecom_enable,
+	.disable	=3D wavecom_disable,
+	.pre_sim	=3D wavecom_pre_sim,
+	.post_sim	=3D wavecom_post_sim,
+};
+
+static int wavecom_init(void)
+{
+	return ofono_modem_driver_register(&wavecom_driver);
+}
+
+static void wavecom_exit(void)
+{
+	ofono_modem_driver_unregister(&wavecom_driver);
+}
+
+OFONO_PLUGIN_DEFINE(wavecom, "Wavecom driver", VERSION,
+		OFONO_PLUGIN_PRIORITY_DEFAULT, wavecom_init, wavecom_exit)
-- =

1.6.3.3


--===============1993169694071301767==--

