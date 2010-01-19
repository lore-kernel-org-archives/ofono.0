Content-Type: multipart/mixed; boundary="===============1151981882097637315=="
MIME-Version: 1.0
From: sjur.brandeland@stericsson.com
Subject: [RFC v2 4/7] STE-plugin: Add STE plugin
Date: Tue, 19 Jan 2010 17:11:50 +0100
Message-ID: <1263917513-6756-5-git-send-email-sjur.brandeland@stericsson.com>
In-Reply-To: <1263917513-6756-4-git-send-email-sjur.brandeland@stericsson.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1151981882097637315==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Added check on return value of socket() and connect() calls.
Use gsm_permissive syntax all the time.
Added ATE0 in initialization.
---
 plugins/ste.c |  262 +++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++
 1 files changed, 262 insertions(+), 0 deletions(-)
 create mode 100644 plugins/ste.c

diff --git a/plugins/ste.c b/plugins/ste.c
new file mode 100644
index 0000000..6127c71
--- /dev/null
+++ b/plugins/ste.c
@@ -0,0 +1,262 @@
+/*
+ *
+ *  oFono - Open Source Telephony
+ *
+ *  Copyright (C) 2008-2009  Intel Corporation. All rights reserved.
+ *  Copyright (C) 2010 ST-Ericsson AB.
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
+#include <ofono/call-volume.h>
+#include <ofono/voicecall.h>
+#include <drivers/atmodem/vendor.h>
+#include <ofono/gprs.h>
+#include <unistd.h>
+#include <ofono/gprs-context.h>
+
+/* Use the local CAIF header files until is included in linux kernel */
+#ifdef PF_CAIF
+#include <linux/caif/caif_socket.h>
+#include <linux/caif/if_caif.h>
+#else
+#include "gcaif/caif_socket.h"
+#include "gcaif/if_caif.h"
+#endif
+
+struct ste_data {
+	GAtChat *chat;
+};
+
+static int ste_probe(struct ofono_modem *modem)
+{
+	struct ste_data *data;
+
+	DBG("%p", modem);
+
+	data =3D g_try_new0(struct ste_data, 1);
+
+	if (!data)
+		return -ENOMEM;
+
+	ofono_modem_set_data(modem, data);
+	return 0;
+}
+
+static void ste_remove(struct ofono_modem *modem)
+{
+	struct ste_data *data =3D ofono_modem_get_data(modem);
+
+	DBG("%p", modem);
+
+	ofono_modem_set_data(modem, NULL);
+
+	g_at_chat_unref(data->chat);
+	g_free(data);
+}
+
+static void ste_debug(const char *str, void *user_data)
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
+	if (!ok)
+		ofono_modem_set_powered(modem, FALSE);
+
+	ofono_modem_set_powered(modem, TRUE);
+}
+
+static int ste_enable(struct ofono_modem *modem)
+{
+	struct ste_data *data =3D ofono_modem_get_data(modem);
+	GIOChannel *channel;
+	GAtSyntax *syntax;
+	int fd, err;
+	struct sockaddr_caif addr =3D {
+		.family =3D AF_CAIF,
+		.u.at.type =3D CAIF_ATTYPE_PLAIN
+	};
+
+	DBG("%p", modem);
+
+	/* Create a CAIF socket for AT Service */
+	fd =3D socket(AF_CAIF, SOCK_SEQPACKET, CAIFPROTO_AT);
+
+	if (fd < 0) {
+		ofono_debug("Failed to create CAIF socket for AT");
+		return -EIO;
+	}
+	/* Connect to the AT Service@the modem */
+	err =3D connect(fd, (struct sockaddr *) &addr, sizeof(addr));
+
+	if (err < 0) {
+		close(fd);
+		return err;
+	}
+	channel =3D g_io_channel_unix_new(fd);
+
+	if (!channel)  {
+		close(fd);
+		return -EIO;
+	}
+	g_io_channel_set_close_on_unref(channel, TRUE);
+
+	syntax =3D g_at_syntax_new_gsm_permissive();
+
+	data->chat =3D g_at_chat_new(channel, syntax);
+	g_at_syntax_unref(syntax);
+	g_io_channel_unref(channel);
+
+	if (!data->chat)
+		return -ENOMEM;
+
+	if (getenv("OFONO_AT_DEBUG"))
+		g_at_chat_set_debug(data->chat, ste_debug, NULL);
+
+	g_at_chat_send(data->chat, "ATE0 +CMEE=3D1", NULL, NULL, NULL, NULL);
+	g_at_chat_send(data->chat, "AT+CFUN=3D1", NULL, cfun_enable, modem, NULL);
+
+	return -EINPROGRESS;
+}
+
+static void cfun_disable(gboolean ok, GAtResult *result, gpointer user_dat=
a)
+{
+	struct ofono_modem *modem =3D user_data;
+	struct ste_data *data =3D ofono_modem_get_data(modem);
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
+static int ste_disable(struct ofono_modem *modem)
+{
+	struct ste_data *data =3D ofono_modem_get_data(modem);
+
+	DBG("%p", modem);
+
+	if (!data->chat)
+		return 0;
+
+	g_at_chat_cancel_all(data->chat);
+	g_at_chat_unregister_all(data->chat);
+	g_at_chat_send(data->chat, "AT+CFUN=3D4", NULL,
+					cfun_disable, modem, NULL);
+
+	return -EINPROGRESS;
+}
+
+static void ste_pre_sim(struct ofono_modem *modem)
+{
+	struct ste_data *data =3D ofono_modem_get_data(modem);
+	DBG("%p", modem);
+
+	ofono_devinfo_create(modem, 0, "atmodem", data->chat);
+	ofono_sim_create(modem, 0, "atmodem", data->chat);
+	ofono_voicecall_create(modem, 0, "stemodem", data->chat);
+}
+
+static void ste_post_sim(struct ofono_modem *modem)
+{
+	struct ste_data *data =3D ofono_modem_get_data(modem);
+	struct ofono_message_waiting *mw;
+	struct ofono_gprs *gprs;
+	struct ofono_gprs_context *gc;
+
+	DBG("%p", modem);
+	ofono_ussd_create(modem, 0, "atmodem", data->chat);
+	ofono_call_forwarding_create(modem, 0, "atmodem", data->chat);
+	ofono_call_settings_create(modem, 0, "atmodem", data->chat);
+	ofono_netreg_create(modem, OFONO_VENDOR_STE, "atmodem", data->chat);
+	ofono_call_meter_create(modem, 0, "atmodem", data->chat);
+	ofono_call_barring_create(modem, 0, "atmodem", data->chat);
+	ofono_ssn_create(modem, 0, "atmodem", data->chat);
+	ofono_sms_create(modem, 0, "atmodem", data->chat);
+	ofono_phonebook_create(modem, 0, "atmodem", data->chat);
+	ofono_call_volume_create(modem, 0, "atmodem", data->chat);
+
+	gprs =3D ofono_gprs_create(modem,
+			OFONO_VENDOR_STE, "atmodem", data->chat);
+	gc =3D ofono_gprs_context_create(modem, 0, "stemodem", data->chat);
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
+static struct ofono_modem_driver ste_driver =3D {
+	.name		=3D "ste",
+	.probe		=3D ste_probe,
+	.remove		=3D ste_remove,
+	.enable		=3D ste_enable,
+	.disable	=3D ste_disable,
+	.pre_sim	=3D ste_pre_sim,
+	.post_sim	=3D ste_post_sim,
+};
+
+static int ste_init(void)
+{
+	return ofono_modem_driver_register(&ste_driver);
+}
+
+static void ste_exit(void)
+{
+	ofono_modem_driver_unregister(&ste_driver);
+}
+
+OFONO_PLUGIN_DEFINE(ste, "ST-Ericsson modem driver", VERSION,
+		OFONO_PLUGIN_PRIORITY_DEFAULT, ste_init, ste_exit)
-- =

1.6.0.4


--===============1151981882097637315==--

