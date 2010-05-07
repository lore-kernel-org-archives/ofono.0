Content-Type: multipart/mixed; boundary="===============7382199790930560519=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH v2 6/6] Add calypsomodem STK driver.
Date: Fri, 07 May 2010 02:27:35 +0200
Message-ID: <1273192055-11276-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7382199790930560519==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

There is an issue with the atom drivers not running at the time we issue
AT+CFUN=3D1 so if that triggers an important notification, it'll be lost.
It could be fixed properly but with major change to initialisation order,
instead I added an extra ugly hack to store the initial %SATI
notification, please comment if that it too ugly :)
---
 Makefile.am                         |    3 +-
 drivers/calypsomodem/calypsomodem.c |    2 +
 drivers/calypsomodem/calypsomodem.h |    8 +
 drivers/calypsomodem/stk.c          |  304 +++++++++++++++++++++++++++++++=
++++
 plugins/phonesim.c                  |  127 +++++++++++++--
 5 files changed, 431 insertions(+), 13 deletions(-)
 create mode 100644 drivers/calypsomodem/stk.c

diff --git a/Makefile.am b/Makefile.am
index 7fd862f..8bf3e86 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -161,7 +161,8 @@ builtin_modules +=3D calypsomodem
 builtin_sources +=3D drivers/atmodem/atutil.h \
 			drivers/calypsomodem/calypsomodem.h \
 			drivers/calypsomodem/calypsomodem.c \
-			drivers/calypsomodem/voicecall.c
+			drivers/calypsomodem/voicecall.c \
+			drivers/calypsomodem/stk.c
 =

 builtin_modules +=3D hfpmodem
 builtin_sources +=3D drivers/atmodem/atutil.h \
diff --git a/drivers/calypsomodem/calypsomodem.c b/drivers/calypsomodem/cal=
ypsomodem.c
index 8cd213e..2ae436a 100644
--- a/drivers/calypsomodem/calypsomodem.c
+++ b/drivers/calypsomodem/calypsomodem.c
@@ -35,12 +35,14 @@
 static int calypsomodem_init(void)
 {
 	calypso_voicecall_init();
+	calypso_stk_init();
 =

 	return 0;
 }
 =

 static void calypsomodem_exit(void)
 {
+	calypso_stk_exit();
 	calypso_voicecall_exit();
 }
 =

diff --git a/drivers/calypsomodem/calypsomodem.h b/drivers/calypsomodem/cal=
ypsomodem.h
index 80af134..6e6f3ea 100644
--- a/drivers/calypsomodem/calypsomodem.h
+++ b/drivers/calypsomodem/calypsomodem.h
@@ -20,6 +20,14 @@
  */
 =

 #include <drivers/atmodem/atutil.h>
+#include <modem.h>
+#include <stk.h>
 =

 extern void calypso_voicecall_init();
 extern void calypso_voicecall_exit();
+
+extern void calypso_stk_init();
+extern void calypso_stk_exit();
+
+extern void calypsomodem_stk_sati_notify(struct ofono_stk *stk,
+						const guint8 *pdu, gint len);
diff --git a/drivers/calypsomodem/stk.c b/drivers/calypsomodem/stk.c
new file mode 100644
index 0000000..ef5b306
--- /dev/null
+++ b/drivers/calypsomodem/stk.c
@@ -0,0 +1,304 @@
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
+#include "calypsomodem.h"
+
+struct stk_data {
+	GAtChat *chat;
+	guint8 *set_up_menu_pdu;
+	guint set_up_menu_pdu_len;
+};
+
+static const char *sate_prefix[] =3D { "%SATE:", NULL };
+static const char *none_prefix[] =3D { NULL };
+
+static void calypso_sate_cb(gboolean ok, GAtResult *result,
+				gpointer user_data)
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
+	if (g_at_result_iter_next(&iter, "%SATE:"))
+		g_at_result_iter_next_hexstring(&iter, &pdu, &len);
+
+	cb(&error, pdu, len, cbd->data);
+	return;
+
+error:
+	CALLBACK_WITH_FAILURE(cb, NULL, 0, cbd->data);
+}
+
+static void calypso_stk_envelope(struct ofono_stk *stk, int length,
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
+	len =3D sprintf(buf, "AT%%SATE=3D\"");
+	for (; length; length--)
+		len +=3D sprintf(buf + len, "%02hhX", *command++);
+	len +=3D sprintf(buf + len, "\"");
+
+	ret =3D g_at_chat_send_full(sd->chat, buf, sate_prefix, NULL,
+			calypso_sate_cb, cbd, g_free);
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
+static void calypso_satr_cb(gboolean ok, GAtResult *result,
+				gpointer user_data)
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
+static void calypso_stk_terminal_response(struct ofono_stk *stk, int lengt=
h,
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
+	len =3D sprintf(buf, "AT%%SATR=3D\"");
+	for (; length; length--)
+		len +=3D sprintf(buf + len, "%02hhX", *command++);
+	len +=3D sprintf(buf + len, "\"");
+
+	ret =3D g_at_chat_send_full(sd->chat, buf, none_prefix, NULL,
+			calypso_satr_cb, cbd, g_free);
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
+void calypsomodem_stk_sati_notify(struct ofono_stk *stk,
+		const guint8 *pdu, gint len)
+{
+	struct stk_data *sd =3D ofono_stk_get_data(stk);
+	int length_bytes;
+
+	ofono_stk_proactive_command_notify(stk, len, pdu);
+
+	/* Check if this is a Set Up Menu command, if so, cache the PDU
+	 * because Calypso sends it only once.  */
+
+	while (len > 0 && (*pdu =3D=3D 0x00 || *pdu =3D=3D 0xff))
+		pdu++, len--;
+	if (len < 7)
+		return;
+	if (pdu[0] !=3D 0xd0) /* Command BER-TLV tag */
+		return;
+	if (pdu[1] < 0x80)
+		length_bytes =3D 1;
+	else
+		length_bytes =3D pdu[1] - 0x7f;
+	if (len < length_bytes + 6)
+		return;
+	if (pdu[1 + length_bytes] !=3D 0x01) /* Command Details CTLV tag */
+		return;
+	if (pdu[2 + length_bytes] !=3D 0x03) /* Command Details CTLV length */
+		return;
+	if (pdu[4 + length_bytes] !=3D 0x25) /* Set Up Menu command type */
+		return;
+
+	if (sd->set_up_menu_pdu)
+		g_free(sd->set_up_menu_pdu);
+
+	sd->set_up_menu_pdu =3D g_memdup(pdu, len);
+	sd->set_up_menu_pdu_len =3D len;
+}
+
+static void sati_notify(GAtResult *result, gpointer user_data)
+{
+	struct ofono_stk *stk =3D user_data;
+	struct stk_data *sd =3D ofono_stk_get_data(stk);
+	GAtResultIter iter;
+	const guint8 *pdu;
+	gint len;
+	gboolean ret;
+
+	g_at_result_iter_init(&iter, result);
+
+	if (!g_at_result_iter_next(&iter, "%SATI:"))
+		return;
+
+	ret =3D g_at_result_iter_next_hexstring(&iter, &pdu, &len);
+	if (!ret || len =3D=3D 0) {
+		/* An empty notification is a request to go back to main
+		 * menu, effectively like resending the previous Set Up
+		 * Menu proactive command.  */
+		if (sd->set_up_menu_pdu)
+			ofono_stk_proactive_command_notify(stk,
+					sd->set_up_menu_pdu_len,
+					sd->set_up_menu_pdu);
+
+		return;
+	}
+
+	calypsomodem_stk_sati_notify(stk, pdu, len);
+}
+
+static void sata_notify(GAtResult *result, gpointer user_data)
+{
+	/* TODO: Pending call alert */
+}
+
+static void satn_notify(GAtResult *result, gpointer user_data)
+{
+	/* Proactive command has been handled by the modem.  Should
+	 * the core be notified?  For now we just ignore it because
+	 * we must not respond to the command.
+	 */
+}
+
+static void calypso_stk_register(gboolean ok,
+		GAtResult *result, gpointer user_data)
+{
+	struct ofono_stk *stk =3D user_data;
+	struct stk_data *sd =3D ofono_stk_get_data(stk);
+
+	g_at_chat_register(sd->chat, "%SATI:", sati_notify, FALSE, stk, NULL);
+	g_at_chat_register(sd->chat, "%SATA:", sata_notify, FALSE, stk, NULL);
+	g_at_chat_register(sd->chat, "%SATN:", satn_notify, FALSE, stk, NULL);
+
+	ofono_stk_register(stk);
+}
+
+static int calypso_stk_probe(struct ofono_stk *stk,
+		unsigned int vendor, void *data)
+{
+	GAtChat *chat =3D data;
+	struct stk_data *sd;
+
+	sd =3D g_new0(struct stk_data, 1);
+	sd->chat =3D chat;
+
+	ofono_stk_set_data(stk, sd);
+
+	/* Enable Call Control / SMS Control */
+	g_at_chat_send(sd->chat, "AT%SATCC=3D1", none_prefix,
+			calypso_stk_register, stk);
+
+	return 0;
+}
+
+static void calypso_stk_remove(struct ofono_stk *stk)
+{
+	struct stk_data *sd =3D ofono_stk_get_data(stk);
+
+	ofono_stk_set_data(stk, NULL);
+
+	if (sd->set_up_menu_pdu)
+		g_free(sd->set_up_menu_pdu);
+
+	g_free(sd);
+}
+
+static struct ofono_stk_driver driver =3D {
+	.name			=3D "calypsomodem",
+	.probe			=3D calypso_stk_probe,
+	.remove			=3D calypso_stk_remove,
+	.envelope		=3D calypso_stk_envelope,
+	.terminal_response	=3D calypso_stk_terminal_response,
+};
+
+void calypso_stk_init()
+{
+	ofono_stk_driver_register(&driver);
+}
+
+void calypso_stk_exit()
+{
+	ofono_stk_driver_unregister(&driver);
+}
diff --git a/plugins/phonesim.c b/plugins/phonesim.c
index 488dd47..34d270e 100644
--- a/plugins/phonesim.c
+++ b/plugins/phonesim.c
@@ -60,14 +60,25 @@
 =

 #include <drivers/atmodem/vendor.h>
 #include <drivers/atmodem/sim-poll.h>
+#include <drivers/calypsomodem/calypsomodem.h>
+#include <src/ofono.h>
 =

 struct phonesim_data {
 	GAtMux *mux;
 	GAtChat *chat;
 	gboolean calypso;
 	gboolean use_mux;
+	gboolean have_sim;
+
+	guint sati_cb_id;
+	unsigned int stk_watch;
+	guint8 *stk_early_pdu;
+	guint stk_early_pdu_len;
 };
 =

+static const char *cpin_prefix[] =3D { "+CPIN:", NULL };
+static const char *none_prefix[] =3D { NULL };
+
 static int phonesim_probe(struct ofono_modem *modem)
 {
 	struct phonesim_data *data;
@@ -98,13 +109,32 @@ static void phonesim_debug(const char *str, void *user=
_data)
 	ofono_info("%s", str);
 }
 =

+static void cpin_check_cb(gboolean ok, GAtResult *result, gpointer user_da=
ta)
+{
+	struct ofono_modem *modem =3D user_data;
+	struct phonesim_data *data =3D ofono_modem_get_data(modem);
+
+	DBG("");
+
+	data->have_sim =3D ok;
+
+	ofono_modem_set_powered(modem, TRUE);
+}
+
 static void cfun_set_on_cb(gboolean ok, GAtResult *result, gpointer user_d=
ata)
 {
 	struct ofono_modem *modem =3D user_data;
+	struct phonesim_data *data =3D ofono_modem_get_data(modem);
 =

 	DBG("");
 =

-	ofono_modem_set_powered(modem, ok);
+	if (!ok) {
+		ofono_modem_set_powered(modem, FALSE);
+		return;
+	}
+
+	g_at_chat_send(data->chat, "AT+CPIN?", cpin_prefix,
+			cpin_check_cb, modem);
 }
 =

 static void phonesim_disconnected(gpointer user_data)
@@ -126,6 +156,84 @@ static void phonesim_disconnected(gpointer user_data)
 	}
 }
 =

+static void stk_watch(struct ofono_atom *atom,
+			enum ofono_atom_watch_condition cond, void *user_data)
+{
+	struct ofono_modem *modem =3D user_data;
+	struct phonesim_data *data =3D ofono_modem_get_data(modem);
+	struct ofono_stk *stk =3D __ofono_atom_get_data(atom);
+
+	if (cond !=3D OFONO_ATOM_WATCH_CONDITION_REGISTERED)
+		return;
+
+	__ofono_modem_remove_atom_watch(modem, data->stk_watch);
+
+	if (data->sati_cb_id) {
+		g_at_chat_unregister(data->chat, data->sati_cb_id);
+		data->sati_cb_id =3D 0;
+	}
+
+	if (data->stk_early_pdu) {
+		calypsomodem_stk_sati_notify(stk,
+				data->stk_early_pdu, data->stk_early_pdu_len);
+		g_free(data->stk_early_pdu);
+	}
+}
+
+static void sati_notify(GAtResult *result, gpointer user_data)
+{
+	struct ofono_modem *modem =3D user_data;
+	struct phonesim_data *data =3D ofono_modem_get_data(modem);
+	GAtResultIter iter;
+	const guint8 *pdu;
+	gint len;
+
+	g_at_result_iter_init(&iter, result);
+	g_at_result_iter_next(&iter, "%SATI:");
+	g_at_result_iter_next_hexstring(&iter, &pdu, &len);
+
+	data->stk_early_pdu =3D g_memdup(pdu, len);
+	data->stk_early_pdu_len =3D len;
+
+	g_at_chat_unregister(data->chat, data->sati_cb_id);
+	data->sati_cb_id =3D 0;
+}
+
+static void cfun_enable(struct phonesim_data *data, struct ofono_modem *mo=
dem)
+{
+	/* It looks like the PROFILE DOWNLOAD is done by the modem
+	 * as part of +CFUN=3D1.  By default the profile indicates that
+	 * TE supports no Proactive UICC.  We need to enable the
+	 * %SATA and other notifications here for STK support and
+	 * give the modem our profile bits (first N bytes) according
+	 * to ETSI TS 102 223 section 5.2.  The modem seems to AND
+	 * the given value with its own capabilities and OR with some
+	 * minimum value.  The bits are reset to the minimal values
+	 * on +CFUN=3D0.
+	 *
+	 * Default value is 450F80021F0000A4020000000000000000000000.
+	 * The mask is 4DFF973F7F0200FC0303FF00009FFFE700000000.
+	 */
+	g_at_chat_send(data->chat,
+			"AT%SATC=3D1,\"19E1FFFF0000FF7FFF03FE\"",
+			none_prefix, NULL, NULL);
+
+	/* The initial %SATI notification should arrive together with
+	 * AT+CFUN=3D1 response, that may be before the STK driver registers
+	 * the notification.  At the same time with Calypso we can't
+	 * lose this first notification or STK will not be
+	 * functional.  This is a hack to save the PDU and supply it
+	 * to STK driver once it's brought up.
+	 */
+	data->sati_cb_id =3D g_at_chat_register(data->chat,
+			"%SATI:", sati_notify, FALSE, modem, NULL);
+	data->stk_watch =3D __ofono_modem_add_atom_watch(modem,
+			OFONO_ATOM_TYPE_STK, stk_watch, modem, NULL);
+
+	g_at_chat_send(data->chat, "AT+CFUN=3D1",
+			none_prefix, cfun_set_on_cb, modem);
+}
+
 static void mux_setup(GAtMux *mux, gpointer user_data)
 {
 	struct ofono_modem *modem =3D user_data;
@@ -163,7 +271,7 @@ static void mux_setup(GAtMux *mux, gpointer user_data)
 	if (data->calypso)
 		g_at_chat_set_wakeup_command(data->chat, "AT\r", 500, 5000);
 =

-	g_at_chat_send(data->chat, "AT+CFUN=3D1", NULL, cfun_set_on_cb, modem);
+	cfun_enable(data, modem);
 }
 =

 static int phonesim_enable(struct ofono_modem *modem)
@@ -246,8 +354,7 @@ static int phonesim_enable(struct ofono_modem *modem)
 		g_at_chat_unref(data->chat);
 		data->chat =3D NULL;
 	} else {
-		g_at_chat_send(data->chat, "AT+CFUN=3D1", NULL,
-					cfun_set_on_cb, modem);
+		cfun_enable(data, modem);
 	}
 =

 	return -EINPROGRESS;
@@ -276,20 +383,16 @@ static void phonesim_pre_sim(struct ofono_modem *mode=
m)
 {
 	struct phonesim_data *data =3D ofono_modem_get_data(modem);
 	struct ofono_sim *sim;
+	const char *drivername =3D data->calypso ? "calypsomodem" : "atmodem";
 =

 	DBG("%p", modem);
 =

 	ofono_devinfo_create(modem, 0, "atmodem", data->chat);
 	sim =3D ofono_sim_create(modem, 0, "atmodem", data->chat);
+	ofono_voicecall_create(modem, 0, drivername, data->chat);
+	ofono_stk_create(modem, 0, drivername, data->chat);
 =

-	if (data->calypso)
-		ofono_voicecall_create(modem, 0, "calypsomodem", data->chat);
-	else
-		ofono_voicecall_create(modem, 0, "atmodem", data->chat);
-
-	ofono_stk_create(modem, 0, "atmodem", data->chat);
-
-	if (sim)
+	if (data->have_sim && sim)
 		ofono_sim_inserted_notify(sim, TRUE);
 }
 =

-- =

1.6.1


--===============7382199790930560519==--

