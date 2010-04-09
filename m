Content-Type: multipart/mixed; boundary="===============7601667380520187513=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 7/8] Add AT driver for STK atom.
Date: Fri, 09 Apr 2010 08:50:00 +0200
Message-ID: <1270795800-7273-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7601667380520187513==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 Makefile.am               |    1 +
 drivers/atmodem/atmodem.c |    2 +
 drivers/atmodem/atmodem.h |    3 +
 drivers/atmodem/stk.c     |  258 +++++++++++++++++++++++++++++++++++++++++=
++++
 plugins/atgen.c           |    2 +
 plugins/phonesim.c        |    3 +
 6 files changed, 269 insertions(+), 0 deletions(-)
 create mode 100644 drivers/atmodem/stk.c

diff --git a/Makefile.am b/Makefile.am
index 7a18c41..a506dba 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -124,6 +124,7 @@ builtin_sources +=3D $(gatchat_sources) \
 				drivers/atmodem/call-meter.c \
 				drivers/atmodem/network-registration.c \
 				drivers/atmodem/sim.c \
+				drivers/atmodem/stk.c \
 				drivers/atmodem/ussd.c \
 				drivers/atmodem/voicecall.c \
 				drivers/atmodem/call-barring.c \
diff --git a/drivers/atmodem/atmodem.c b/drivers/atmodem/atmodem.c
index 0ac8182..c88f6b2 100644
--- a/drivers/atmodem/atmodem.c
+++ b/drivers/atmodem/atmodem.c
@@ -45,6 +45,7 @@ static int atmodem_init(void)
 	at_ussd_init();
 	at_sms_init();
 	at_sim_init();
+	at_stk_init();
 	at_netreg_init();
 	at_cbs_init();
 	at_call_volume_init();
@@ -56,6 +57,7 @@ static int atmodem_init(void)
 =

 static void atmodem_exit(void)
 {
+	at_stk_exit();
 	at_sim_exit();
 	at_sms_exit();
 	at_ussd_exit();
diff --git a/drivers/atmodem/atmodem.h b/drivers/atmodem/atmodem.h
index 1fb4bfa..2ee47f5 100644
--- a/drivers/atmodem/atmodem.h
+++ b/drivers/atmodem/atmodem.h
@@ -45,6 +45,9 @@ extern void at_call_barring_exit();
 extern void at_sim_init();
 extern void at_sim_exit();
 =

+extern void at_stk_init();
+extern void at_stk_exit();
+
 extern void at_sms_init();
 extern void at_sms_exit();
 =

diff --git a/drivers/atmodem/stk.c b/drivers/atmodem/stk.c
new file mode 100644
index 0000000..05c1138
--- /dev/null
+++ b/drivers/atmodem/stk.c
@@ -0,0 +1,258 @@
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
+#define _GNU_SOURCE
+#include <string.h>
+#include <stdlib.h>
+#include <stdio.h>
+
+#include <glib.h>
+
+#include <ofono/log.h>
+#include <ofono/modem.h>
+#include <ofono/stk.h>
+
+#include "gatchat.h"
+#include "gatresult.h"
+
+#include "atmodem.h"
+
+struct stk_data {
+	GAtChat *chat;
+};
+
+static const char *csim_prefix[] =3D { "+CSIM:", NULL };
+
+static void at_csim_envelope_cb(gboolean ok, GAtResult *result,
+		gpointer user_data)
+{
+	struct cb_data *cbd =3D user_data;
+	GAtResultIter iter;
+	ofono_stk_envelope_cb_t cb =3D cbd->cb;
+	struct ofono_error error;
+	const guint8 *response;
+	gint rlen, len;
+
+	decode_at_error(&error, g_at_result_final_response(result));
+
+	if (!ok)
+		goto error;
+
+	g_at_result_iter_init(&iter, result);
+
+	if (!g_at_result_iter_next(&iter, "+CSIM:"))
+		goto error;
+
+	if (!g_at_result_iter_next_number(&iter, &rlen))
+		goto error;
+
+	if (!g_at_result_iter_next_hexstring(&iter, &response, &len))
+		goto error;
+
+	if (rlen !=3D len * 2 || len < 2)
+		goto error;
+
+	if (response[len - 2] !=3D 0x90 && response[len - 2] !=3D 0x91)
+		goto error;
+
+	if (response[len - 2] =3D=3D 0x90 && response[len - 1] !=3D 0)
+		goto error;
+
+	DBG("csim_envelope_cb: %i", len);
+
+	cb(&error, response, len - 2, cbd->data);
+	return;
+
+error:
+	CALLBACK_WITH_FAILURE(cb, NULL, 0, cbd->data);
+}
+
+static void at_stk_envelope(struct ofono_stk *stk, int length,
+				const guint8 *command,
+				ofono_stk_envelope_cb_t cb, void *data)
+{
+	struct stk_data *sd =3D ofono_stk_get_data(stk);
+	struct cb_data *cbd =3D cb_data_new(cb, data);
+	char *buf =3D g_try_new(char, 64 + length * 2);
+	int len, ret;
+
+	if (!cbd || !buf)
+		goto error;
+
+	len =3D sprintf(buf, "AT+CSIM=3D%i,A0C20000%02hhX",
+			12 + length * 2, length);
+
+	for (; length; length--)
+		len +=3D sprintf(buf + len, "%02hhX", *command++);
+
+	len +=3D sprintf(buf + len, "FF");
+
+	ret =3D g_at_chat_send(sd->chat, buf, csim_prefix,
+				at_csim_envelope_cb, cbd, g_free);
+
+	g_free(buf);
+	buf =3D NULL;
+
+	if (ret > 0)
+		return;
+
+error:
+	if (buf)
+		g_free(buf);
+
+	if (cbd)
+		g_free(cbd);
+
+	CALLBACK_WITH_FAILURE(cb, NULL, 0, data);
+}
+
+static void at_csim_terminal_response_cb(gboolean ok, GAtResult *result,
+		gpointer user_data)
+{
+	struct cb_data *cbd =3D user_data;
+	GAtResultIter iter;
+	ofono_stk_generic_cb_t cb =3D cbd->cb;
+	struct ofono_error error;
+	const guint8 *response;
+	gint rlen, len;
+
+	decode_at_error(&error, g_at_result_final_response(result));
+
+	if (!ok)
+		goto error;
+
+	g_at_result_iter_init(&iter, result);
+
+	if (!g_at_result_iter_next(&iter, "+CSIM:"))
+		goto error;
+
+	if (!g_at_result_iter_next_number(&iter, &rlen))
+		goto error;
+
+	if (!g_at_result_iter_next_hexstring(&iter, &response, &len))
+		goto error;
+
+	if (rlen !=3D len * 2 || len < 2)
+		goto error;
+
+	if (response[len - 2] !=3D 0x90 && response[len - 2] !=3D 0x91)
+		goto error;
+
+	if (response[len - 2] =3D=3D 0x90 && response[len - 1] !=3D 0)
+		goto error;
+
+	DBG("csim_terminal_response_cb: %i", len);
+
+	cb(&error, cbd->data);
+	return;
+
+error:
+	CALLBACK_WITH_FAILURE(cb, cbd->data);
+}
+
+static void at_stk_terminal_response(struct ofono_stk *stk, int length,
+		const unsigned char *value, ofono_stk_generic_cb_t cb,
+		void *data)
+{
+	struct stk_data *sd =3D ofono_stk_get_data(stk);
+	struct cb_data *cbd =3D cb_data_new(cb, data);
+	char *buf =3D g_try_new(char, 64 + length * 2);
+	int len, ret;
+
+	if (!cbd || !buf)
+		goto error;
+
+	len =3D sprintf(buf, "AT+CSIM=3D%i,A0140000%02hhX",
+			10 + length * 2, length);
+
+	for (; length; length--)
+		len +=3D sprintf(buf + len, "%02hhX", *value++);
+
+	ret =3D g_at_chat_send(sd->chat, buf, csim_prefix,
+				at_csim_terminal_response_cb, cbd, g_free);
+
+	g_free(buf);
+	buf =3D NULL;
+
+	if (ret > 0)
+		return;
+
+error:
+	if (cbd)
+		g_free(cbd);
+
+	CALLBACK_WITH_FAILURE(cb, data);
+}
+
+static gboolean at_stk_register(gpointer user)
+{
+	struct ofono_stk *stk =3D user;
+
+	ofono_stk_register(stk);
+
+	return FALSE;
+}
+
+static int at_stk_probe(struct ofono_stk *stk, unsigned int vendor,
+		void *data)
+{
+	GAtChat *chat =3D data;
+	struct stk_data *sd;
+
+	sd =3D g_new0(struct stk_data, 1);
+	sd->chat =3D chat;
+
+	ofono_stk_set_data(stk, sd);
+	g_idle_add(at_stk_register, stk);
+
+	return 0;
+}
+
+static void at_stk_remove(struct ofono_stk *stk)
+{
+	struct stk_data *sd =3D ofono_stk_get_data(stk);
+
+	ofono_stk_set_data(stk, NULL);
+
+	g_free(sd);
+}
+
+static struct ofono_stk_driver driver =3D {
+	.name			=3D "atmodem",
+	.probe			=3D at_stk_probe,
+	.remove			=3D at_stk_remove,
+	.envelope		=3D at_stk_envelope,
+	.terminal_response	=3D at_stk_terminal_response,
+};
+
+void at_stk_init()
+{
+	ofono_stk_driver_register(&driver);
+}
+
+void at_stk_exit()
+{
+	ofono_stk_driver_unregister(&driver);
+}
diff --git a/plugins/atgen.c b/plugins/atgen.c
index ed963c2..262d32f 100644
--- a/plugins/atgen.c
+++ b/plugins/atgen.c
@@ -43,6 +43,7 @@
 #include <ofono/netreg.h>
 #include <ofono/phonebook.h>
 #include <ofono/sim.h>
+#include <ofono/stk.h>
 #include <ofono/sms.h>
 #include <ofono/ssn.h>
 #include <ofono/ussd.h>
@@ -163,6 +164,7 @@ static void atgen_pre_sim(struct ofono_modem *modem)
 	ofono_devinfo_create(modem, 0, "atmodem", chat);
 	sim =3D ofono_sim_create(modem, 0, "atmodem", chat);
 	ofono_voicecall_create(modem, 0, "atmodem", chat);
+	ofono_stk_create(modem, 0, "atmodem", chat);
 =

 	if (sim)
 		ofono_sim_inserted_notify(sim, TRUE);
diff --git a/plugins/phonesim.c b/plugins/phonesim.c
index 4c3b3ce..9153e1b 100644
--- a/plugins/phonesim.c
+++ b/plugins/phonesim.c
@@ -50,6 +50,7 @@
 #include <ofono/netreg.h>
 #include <ofono/phonebook.h>
 #include <ofono/sim.h>
+#include <ofono/stk.h>
 #include <ofono/sms.h>
 #include <ofono/ssn.h>
 #include <ofono/ussd.h>
@@ -289,6 +290,8 @@ static void phonesim_pre_sim(struct ofono_modem *modem)
 	else
 		ofono_voicecall_create(modem, 0, "atmodem", data->chat);
 =

+	ofono_stk_create(modem, 0, "atmodem", data->chat);
+
 	if (sim)
 		ofono_sim_inserted_notify(sim, TRUE);
 }
-- =

1.6.1


--===============7601667380520187513==--

