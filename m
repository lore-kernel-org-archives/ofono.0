Content-Type: multipart/mixed; boundary="===============0442534970120758938=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 5/6] Add mbmmodem STK driver.
Date: Fri, 07 May 2010 02:27:27 +0200
Message-ID: <1273192047-11247-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0442534970120758938==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Tested with a F3607gw data card.
---
 Makefile.am                 |    3 +-
 drivers/mbmmodem/mbmmodem.c |    2 +
 drivers/mbmmodem/mbmmodem.h |    3 +
 drivers/mbmmodem/stk.c      |  254 +++++++++++++++++++++++++++++++++++++++=
++++
 plugins/mbm.c               |   45 +++++++-
 5 files changed, 302 insertions(+), 5 deletions(-)
 create mode 100644 drivers/mbmmodem/stk.c

diff --git a/Makefile.am b/Makefile.am
index 463e52e..7fd862f 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -175,7 +175,8 @@ builtin_modules +=3D mbmmodem
 builtin_sources +=3D drivers/atmodem/atutil.h \
 			drivers/mbmmodem/mbmmodem.h \
 			drivers/mbmmodem/mbmmodem.c \
-			drivers/mbmmodem/gprs-context.c
+			drivers/mbmmodem/gprs-context.c \
+			drivers/mbmmodem/stk.c
 =

 builtin_modules +=3D hsomodem
 builtin_sources +=3D drivers/atmodem/atutil.h \
diff --git a/drivers/mbmmodem/mbmmodem.c b/drivers/mbmmodem/mbmmodem.c
index 08e3d72..03b61b3 100644
--- a/drivers/mbmmodem/mbmmodem.c
+++ b/drivers/mbmmodem/mbmmodem.c
@@ -35,12 +35,14 @@
 static int mbmmodem_init(void)
 {
 	mbm_gprs_context_init();
+	mbm_stk_init();
 =

 	return 0;
 }
 =

 static void mbmmodem_exit(void)
 {
+	mbm_stk_exit();
 	mbm_gprs_context_exit();
 }
 =

diff --git a/drivers/mbmmodem/mbmmodem.h b/drivers/mbmmodem/mbmmodem.h
index 0430c77..65786d7 100644
--- a/drivers/mbmmodem/mbmmodem.h
+++ b/drivers/mbmmodem/mbmmodem.h
@@ -23,3 +23,6 @@
 =

 extern void mbm_gprs_context_init();
 extern void mbm_gprs_context_exit();
+
+extern void mbm_stk_init();
+extern void mbm_stk_exit();
diff --git a/drivers/mbmmodem/stk.c b/drivers/mbmmodem/stk.c
new file mode 100644
index 0000000..46c8192
--- /dev/null
+++ b/drivers/mbmmodem/stk.c
@@ -0,0 +1,254 @@
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
+#include "mbmmodem.h"
+
+struct stk_data {
+	GAtChat *chat;
+};
+
+static const char *stke_prefix[] =3D { "%STKE:", NULL };
+static const char *none_prefix[] =3D { NULL };
+
+static void mbm_stke_cb(gboolean ok, GAtResult *result, gpointer user_data)
+{
+	struct cb_data *cbd =3D user_data;
+	ofono_stk_envelope_cb_t cb =3D cbd->cb;
+	GAtResultIter iter;
+	struct ofono_error error;
+	const guint8 *pdu =3D { 0 };
+	gint len =3D 0;
+
+	decode_at_error(&error, g_at_result_final_response(result));
+
+	if (!ok)
+		goto error;
+
+	g_at_result_iter_init(&iter, result);
+
+	if (g_at_result_iter_next(&iter, "*STKE:"))
+		g_at_result_iter_next_hexstring(&iter, &pdu, &len);
+
+	cb(&error, pdu, len, cbd->data);
+	return;
+
+error:
+	CALLBACK_WITH_FAILURE(cb, NULL, 0, cbd->data);
+}
+
+static void mbm_stk_envelope(struct ofono_stk *stk, int length,
+				const unsigned char *command,
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
+	len =3D sprintf(buf, "AT*STKE=3D\"");
+	for (; length; length--)
+		len +=3D sprintf(buf + len, "%02hhX", *command++);
+	len +=3D sprintf(buf + len, "\"");
+
+	ret =3D g_at_chat_send_full(sd->chat, buf, stke_prefix, NULL,
+			mbm_stke_cb, cbd, g_free);
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
+static void mbm_stkr_cb(gboolean ok, GAtResult *result, gpointer user_data)
+{
+	struct cb_data *cbd =3D user_data;
+	ofono_stk_generic_cb_t cb =3D cbd->cb;
+	struct ofono_error error;
+
+	decode_at_error(&error, g_at_result_final_response(result));
+
+	if (ok)
+		cb(&error, cbd->data);
+	else
+		CALLBACK_WITH_FAILURE(cb, cbd->data);
+}
+
+static void mbm_stk_terminal_response(struct ofono_stk *stk, int length,
+				const unsigned char *command,
+				ofono_stk_generic_cb_t cb, void *data)
+{
+	struct stk_data *sd =3D ofono_stk_get_data(stk);
+	struct cb_data *cbd =3D cb_data_new(cb, data);
+	char *buf =3D g_try_new(char, 64 + length * 2);
+	int len, ret;
+
+	if (!cbd || !buf)
+		goto error;
+
+	len =3D sprintf(buf, "AT*STKR=3D\"");
+	for (; length; length--)
+		len +=3D sprintf(buf + len, "%02hhX", *command++);
+	len +=3D sprintf(buf + len, "\"");
+
+	ret =3D g_at_chat_send_full(sd->chat, buf, none_prefix, NULL,
+			mbm_stkr_cb, cbd, g_free);
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
+	CALLBACK_WITH_FAILURE(cb, data);
+}
+
+static void stki_notify(GAtResult *result, gpointer user_data)
+{
+	struct ofono_stk *stk =3D user_data;
+	GAtResultIter iter;
+	const guint8 *pdu;
+	gint len;
+
+	g_at_result_iter_init(&iter, result);
+
+	if (!g_at_result_iter_next(&iter, "*STKI:"))
+		return;
+
+	if (!g_at_result_iter_next_hexstring(&iter, &pdu, &len))
+		return;
+
+	ofono_stk_proactive_command_notify(stk, len, pdu);
+}
+
+static void stkn_notify(GAtResult *result, gpointer user_data)
+{
+	/* Proactive command has been handled by the modem.  Should
+	 * the core be notified?  For now we just ignore it because
+	 * we must not respond to the command.
+	 */
+}
+
+static void stkend_notify(GAtResult *result, gpointer user_data)
+{
+}
+
+static void mbm_stkc_cb(gboolean ok, GAtResult *result, gpointer user_data)
+{
+}
+
+static gboolean mbm_stk_register(gpointer user)
+{
+	struct ofono_stk *stk =3D user;
+	struct stk_data *sd =3D ofono_stk_get_data(stk);
+
+	g_at_chat_register(sd->chat, "*STKI:", stki_notify, FALSE, stk, NULL);
+	g_at_chat_register(sd->chat, "*STKN:", stkn_notify, FALSE, stk, NULL);
+	g_at_chat_register(sd->chat, "*STKEND",
+			stkend_notify, FALSE, stk, NULL);
+
+	/* Perform PROFILE DOWNLOAD and enable *STKI / *STKN */
+	g_at_chat_send(sd->chat, "AT*STKC=3D1,\"19E1FFFF0000FF7FFF03FEFF\"",
+			none_prefix, mbm_stkc_cb, stk);
+
+	ofono_stk_register(stk);
+
+	return FALSE;
+}
+
+static int mbm_stk_probe(struct ofono_stk *stk,
+		unsigned int vendor, void *data)
+{
+	GAtChat *chat =3D data;
+	struct stk_data *sd;
+
+	sd =3D g_new0(struct stk_data, 1);
+	sd->chat =3D chat;
+
+	ofono_stk_set_data(stk, sd);
+	g_idle_add(mbm_stk_register, stk);
+
+	return 0;
+}
+
+static void mbm_stk_remove(struct ofono_stk *stk)
+{
+	struct stk_data *sd =3D ofono_stk_get_data(stk);
+
+	ofono_stk_set_data(stk, NULL);
+
+	g_free(sd);
+}
+
+static struct ofono_stk_driver driver =3D {
+	.name			=3D "mbmmodem",
+	.probe			=3D mbm_stk_probe,
+	.remove			=3D mbm_stk_remove,
+	.envelope		=3D mbm_stk_envelope,
+	.terminal_response	=3D mbm_stk_terminal_response,
+};
+
+void mbm_stk_init()
+{
+	ofono_stk_driver_register(&driver);
+}
+
+void mbm_stk_exit()
+{
+	ofono_stk_driver_unregister(&driver);
+}
diff --git a/plugins/mbm.c b/plugins/mbm.c
index 53bd7ae..199aa17 100644
--- a/plugins/mbm.c
+++ b/plugins/mbm.c
@@ -37,6 +37,7 @@
 #include <ofono/devinfo.h>
 #include <ofono/netreg.h>
 #include <ofono/sim.h>
+#include <ofono/stk.h>
 #include <ofono/sms.h>
 #include <ofono/cbs.h>
 #include <ofono/ssn.h>
@@ -54,11 +55,13 @@
 #include <drivers/atmodem/vendor.h>
 =

 static const char *cfun_prefix[] =3D { "+CFUN:", NULL };
+static const char *crsm_prefix[] =3D { "+CRSM:", NULL };
 static const char *none_prefix[] =3D { NULL };
 =

 struct mbm_data {
 	GAtChat *modem_port;
 	GAtChat *data_port;
+	gboolean have_sim;
 };
 =

 static int mbm_probe(struct ofono_modem *modem)
@@ -96,18 +99,51 @@ static void mbm_debug(const char *str, void *user_data)
 	ofono_info("%s %s", prefix, str);
 }
 =

-static void cfun_enable(gboolean ok, GAtResult *result, gpointer user_data)
+static void status_check(gboolean ok, GAtResult *result, gpointer user_dat=
a)
 {
 	struct ofono_modem *modem =3D user_data;
+	struct mbm_data *data =3D ofono_modem_get_data(modem);
+	GAtResultIter iter;
+	gint sw[2];
 =

 	DBG("");
 =

 	if (!ok)
-		ofono_modem_set_powered(modem, FALSE);
+		goto poweron;
+
+	/* Modem fakes a 94 04 response from card (File Id not found /
+	 * Pattern not found) when there's no card in the slot.
+	 */
+	g_at_result_iter_init(&iter, result);
+
+	if (!g_at_result_iter_next(&iter, "+CRSM:"))
+		goto poweron;
+
+	g_at_result_iter_next_number(&iter, &sw[0]);
+	g_at_result_iter_next_number(&iter, &sw[1]);
 =

+	data->have_sim =3D sw[0] !=3D 0x94 || sw[1] !=3D 0x04;
+
+poweron:
 	ofono_modem_set_powered(modem, TRUE);
 }
 =

+static void cfun_enable(gboolean ok, GAtResult *result, gpointer user_data)
+{
+	struct ofono_modem *modem =3D user_data;
+	struct mbm_data *data =3D ofono_modem_get_data(modem);
+
+	DBG("");
+
+	if (!ok) {
+		ofono_modem_set_powered(modem, FALSE);
+		return;
+	}
+
+	g_at_chat_send(data->modem_port, "AT+CRSM=3D242", crsm_prefix,
+			status_check, modem);
+}
+
 static void cfun_query(gboolean ok, GAtResult *result, gpointer user_data)
 {
 	struct ofono_modem *modem =3D user_data;
@@ -133,7 +169,7 @@ static void cfun_query(gboolean ok, GAtResult *result, =
gpointer user_data)
 		return;
 	}
 =

-	ofono_modem_set_powered(modem, TRUE);
+	cfun_enable(TRUE, NULL, modem);
 }
 =

 static void emrdy_notifier(GAtResult *result, gpointer user_data)
@@ -290,8 +326,9 @@ static void mbm_pre_sim(struct ofono_modem *modem)
 	ofono_devinfo_create(modem, 0, "atmodem", data->modem_port);
 	sim =3D ofono_sim_create(modem, 0, "atmodem", data->modem_port);
 	ofono_voicecall_create(modem, 0, "atmodem", data->modem_port);
+	ofono_stk_create(modem, 0, "mbmmodem", data->modem_port);
 =

-	if (sim)
+	if (data->have_sim && sim)
 		ofono_sim_inserted_notify(sim, TRUE);
 }
 =

-- =

1.6.1


--===============0442534970120758938==--

