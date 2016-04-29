Content-Type: multipart/mixed; boundary="===============7541369357184812771=="
MIME-Version: 1.0
From: caiwen.zhang@intel.com
Subject: [PATCH] rilmodem/stk: add STK support for rilmodem
Date: Fri, 29 Apr 2016 10:21:27 +0800
Message-ID: <1461896487-22200-1-git-send-email-caiwen.zhang@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7541369357184812771==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Caiwen Zhang <caiwen.zhang@intel.com>

---
 Makefile.am                 |   1 +
 drivers/rilmodem/rilmodem.c |   2 +
 drivers/rilmodem/rilmodem.h |   3 +
 drivers/rilmodem/stk.c      | 237 ++++++++++++++++++++++++++++++++++++++++=
++++
 plugins/ril.c               |   1 +
 5 files changed, 244 insertions(+)
 create mode 100644 drivers/rilmodem/stk.c

diff --git a/Makefile.am b/Makefile.am
index 5215b2e..8ab9851 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -151,6 +151,7 @@ builtin_sources +=3D drivers/rilmodem/rilmodem.h \
 			drivers/rilmodem/radio-settings.c \
 			drivers/rilmodem/call-barring.c \
 			drivers/rilmodem/netmon.c \
+			drivers/rilmodem/stk.c \
 			drivers/infineonmodem/infineon_constants.h
 endif
 =

diff --git a/drivers/rilmodem/rilmodem.c b/drivers/rilmodem/rilmodem.c
index e4de3c2..9a063a2 100644
--- a/drivers/rilmodem/rilmodem.c
+++ b/drivers/rilmodem/rilmodem.c
@@ -52,6 +52,7 @@ static int rilmodem_init(void)
 	ril_radio_settings_init();
 	ril_call_barring_init();
 	ril_netmon_init();
+	ril_stk_init();
 =

 	return 0;
 }
@@ -74,6 +75,7 @@ static void rilmodem_exit(void)
 	ril_radio_settings_exit();
 	ril_call_barring_exit();
 	ril_netmon_exit();
+	ril_stk_exit();
 }
 =

 OFONO_PLUGIN_DEFINE(rilmodem, "RIL modem driver", VERSION,
diff --git a/drivers/rilmodem/rilmodem.h b/drivers/rilmodem/rilmodem.h
index f838b6b..7e47573 100644
--- a/drivers/rilmodem/rilmodem.h
+++ b/drivers/rilmodem/rilmodem.h
@@ -72,3 +72,6 @@ extern void ril_phonebook_exit(void);
 =

 extern void ril_netmon_init(void);
 extern void ril_netmon_exit(void);
+
+extern void ril_stk_init(void);
+extern void ril_stk_exit(void);
diff --git a/drivers/rilmodem/stk.c b/drivers/rilmodem/stk.c
new file mode 100644
index 0000000..9082683
--- /dev/null
+++ b/drivers/rilmodem/stk.c
@@ -0,0 +1,237 @@
+/*
+ *
+ *  oFono - Open Source Telephony
+ *
+ *  Copyright (C) 2008-2016  Intel Corporation. All rights reserved.
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
+#define _GNU_SOURCE
+#include <string.h>
+#include <stdio.h>
+
+#include <glib.h>
+
+#include <ofono/log.h>
+#include <ofono/modem.h>
+#include <ofono/stk.h>
+#include "util.h"
+
+#include <gril.h>
+#include <parcel.h>
+
+#include "rilmodem.h"
+#include "vendor.h"
+
+struct stk_data {
+	GRil *ril;
+	unsigned int vendor;
+};
+
+static void ril_stk_terminal_response_cb(struct ril_msg *message,
+				gpointer user_data)
+{
+	struct cb_data *cbd =3D user_data;
+	ofono_stk_generic_cb_t cb =3D cbd->cb;
+	struct stk_data *sd =3D cbd->user;
+
+	g_ril_print_response(sd->ril, message);
+
+	if (message->error =3D=3D RIL_E_SUCCESS) {
+		CALLBACK_WITH_SUCCESS(cb, cbd->data);
+	} else {
+		ofono_error("%s RILD reply failure: %s",
+			g_ril_request_id_to_string(sd->ril, message->req),
+			ril_error_to_string(message->error));
+		CALLBACK_WITH_FAILURE(cb, cbd->data);
+	}
+}
+
+static void ril_stk_terminal_response(struct ofono_stk *stk, int len,
+				const unsigned char *data,
+				ofono_stk_generic_cb_t cb, void *user_data)
+{
+	struct stk_data *sd =3D ofono_stk_get_data(stk);
+	struct cb_data *cbd =3D cb_data_new(cb, user_data, sd);
+	struct parcel rilp;
+	char *buf =3D alloca(len * 2 + 1);
+	int size =3D 0;
+
+	for (; len; len--)
+		size +=3D sprintf(buf + size, "%02hhX", *data++);
+
+	parcel_init(&rilp);
+	parcel_w_string(&rilp, buf);
+
+	if (g_ril_send(sd->ril, RIL_REQUEST_STK_SEND_TERMINAL_RESPONSE, &rilp,
+			ril_stk_terminal_response_cb, cbd, g_free) > 0)
+		return;
+
+	g_free(cbd);
+	CALLBACK_WITH_FAILURE(cb, user_data);
+}
+
+static void ril_stk_envelope_cb(struct ril_msg *message, gpointer user_dat=
a)
+{
+	struct cb_data *cbd =3D user_data;
+	ofono_stk_envelope_cb_t cb =3D cbd->cb;
+	struct stk_data *sd =3D cbd->user;
+	struct parcel rilp;
+	unsigned char *response =3D NULL;
+	long len =3D 0;
+	char *pdu;
+
+	g_ril_print_response(sd->ril, message);
+
+	if (message->error =3D=3D RIL_E_SUCCESS) {
+		g_ril_init_parcel(message, &rilp);
+		pdu =3D parcel_r_string(&rilp);
+		if (pdu)
+			response =3D decode_hex(pdu, -1, &len, -1);
+
+		CALLBACK_WITH_SUCCESS(cb, response, len, cbd->data);
+		g_free(response);
+	} else {
+		ofono_error("%s RILD reply failure: %s",
+			g_ril_request_id_to_string(sd->ril, message->req),
+			ril_error_to_string(message->error));
+		CALLBACK_WITH_FAILURE(cb, NULL, 0, cbd->data);
+	}
+}
+
+static void ril_stk_envelope(struct ofono_stk *stk, int len,
+				const unsigned char *cmd,
+				ofono_stk_envelope_cb_t cb, void *user_data)
+{
+	struct stk_data *sd =3D ofono_stk_get_data(stk);
+	struct cb_data *cbd =3D cb_data_new(cb, user_data, sd);
+	struct parcel rilp;
+	char *buf =3D alloca(len * 2 + 1);
+	int size =3D 0;
+
+	for (; len; len--)
+		size +=3D sprintf(buf + size, "%02hhX", *cmd++);
+
+	parcel_init(&rilp);
+	parcel_w_string(&rilp, buf);
+
+	if (g_ril_send(sd->ril, RIL_REQUEST_STK_SEND_ENVELOPE_COMMAND, &rilp,
+			ril_stk_envelope_cb, cbd, g_free) > 0)
+		return;
+
+	g_free(cbd);
+	CALLBACK_WITH_FAILURE(cb, NULL, 0, user_data);
+}
+
+static void ril_stk_proactive_cmd_noti(struct ril_msg *message,
+				gpointer user_data)
+{
+	struct ofono_stk *stk =3D user_data;
+	struct parcel rilp;
+	long pdulen;
+	unsigned char *pdu;
+
+	DBG("");
+
+	g_ril_init_parcel(message, &rilp);
+	pdu =3D decode_hex(parcel_r_string(&rilp), -1, &pdulen, -1);
+
+	ofono_stk_proactive_command_notify(stk, pdulen, pdu);
+	g_free(pdu);
+}
+
+static void ril_stk_event_noti(struct ril_msg *message, gpointer user_data)
+{
+	struct ofono_stk *stk =3D user_data;
+	struct parcel rilp;
+	long pdulen;
+	unsigned char *pdu;
+
+	DBG("");
+
+	g_ril_init_parcel(message, &rilp);
+	pdu =3D decode_hex(parcel_r_string(&rilp), -1, &pdulen, -1);
+
+	ofono_stk_proactive_command_handled_notify(stk, pdulen, pdu);
+	g_free(pdu);
+}
+
+static void ril_stk_session_end_noti(struct ril_msg *message,
+				gpointer user_data)
+{
+	struct ofono_stk *stk =3D user_data;
+
+	DBG("");
+	ofono_stk_proactive_session_end_notify(stk);
+}
+
+static int ril_stk_probe(struct ofono_stk *stk, unsigned int vendor,
+				void *user)
+{
+	GRil *ril =3D user;
+	struct stk_data *data;
+
+	data =3D g_new0(struct stk_data, 1);
+	data->ril =3D g_ril_clone(ril);
+	data->vendor =3D vendor;
+
+	ofono_stk_set_data(stk, data);
+
+	g_ril_register(ril, RIL_UNSOL_STK_PROACTIVE_COMMAND,
+					ril_stk_proactive_cmd_noti, stk);
+
+	g_ril_register(ril, RIL_UNSOL_STK_SESSION_END,
+					ril_stk_session_end_noti, stk);
+
+	g_ril_register(ril, RIL_UNSOL_STK_EVENT_NOTIFY,
+					ril_stk_event_noti, stk);
+
+	ofono_stk_register(stk);
+
+	return 0;
+}
+
+static void ril_stk_remove(struct ofono_stk *stk)
+{
+	struct stk_data *data =3D ofono_stk_get_data(stk);
+
+	ofono_stk_set_data(stk, NULL);
+
+	g_ril_unref(data->ril);
+	g_free(data);
+}
+
+static struct ofono_stk_driver driver =3D {
+	.name =3D RILMODEM,
+	.probe =3D ril_stk_probe,
+	.remove =3D ril_stk_remove,
+	.envelope =3D ril_stk_envelope,
+	.terminal_response =3D ril_stk_terminal_response,
+};
+
+void ril_stk_init(void)
+{
+	ofono_stk_driver_register(&driver);
+}
+
+void ril_stk_exit(void)
+{
+	ofono_stk_driver_unregister(&driver);
+}
diff --git a/plugins/ril.c b/plugins/ril.c
index b66664a..833fd99 100644
--- a/plugins/ril.c
+++ b/plugins/ril.c
@@ -230,6 +230,7 @@ void ril_post_sim(struct ofono_modem *modem)
 =

 	ofono_call_forwarding_create(modem, rd->vendor, RILMODEM, rd->ril);
 =

+	ofono_stk_create(modem, rd->vendor, RILMODEM, rd->ril);
 	ofono_phonebook_create(modem, rd->vendor, RILMODEM, modem);
 }
 =

-- =

1.9.1


--===============7541369357184812771==--

