Content-Type: multipart/mixed; boundary="===============8905622960216386093=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH] Add a Calypso STK driver.
Date: Mon, 03 May 2010 09:30:52 +0200
Message-ID: <1272871852-22475-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8905622960216386093==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 Makefile.am                         |    3 +-
 drivers/calypsomodem/calypsomodem.c |    2 +
 drivers/calypsomodem/calypsomodem.h |    3 +
 drivers/calypsomodem/stk.c          |  274 +++++++++++++++++++++++++++++++=
++++
 plugins/phonesim.c                  |   46 +++++-
 5 files changed, 318 insertions(+), 10 deletions(-)
 create mode 100644 drivers/calypsomodem/stk.c

diff --git a/Makefile.am b/Makefile.am
index 463e52e..58d2dc0 100644
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
index 80af134..caf7a3d 100644
--- a/drivers/calypsomodem/calypsomodem.h
+++ b/drivers/calypsomodem/calypsomodem.h
@@ -23,3 +23,6 @@
 =

 extern void calypso_voicecall_init();
 extern void calypso_voicecall_exit();
+
+extern void calypso_stk_init();
+extern void calypso_stk_exit();
diff --git a/drivers/calypsomodem/stk.c b/drivers/calypsomodem/stk.c
new file mode 100644
index 0000000..7143009
--- /dev/null
+++ b/drivers/calypsomodem/stk.c
@@ -0,0 +1,274 @@
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
+static void calypso_sate_cb(gboolean ok, GAtResult *result,
+				gpointer user_data)
+{
+	struct cb_data *cbd =3D user_data;
+	ofono_stk_envelope_cb_t cb =3D cbd->cb;
+	struct ofono_error error;
+
+	decode_at_error(&error, g_at_result_final_response(result));
+
+	if (!ok)
+		goto error;
+
+	cb(&error, (const guint8 *) "", 0, cbd->data);
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
+	ret =3D g_at_chat_send(sd->chat, buf, NULL,
+				calypso_sate_cb, cbd, g_free);
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
+	ret =3D g_at_chat_send(sd->chat, buf, NULL,
+				calypso_satr_cb, cbd, g_free);
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
+static void sati_notify(GAtResult *result, gpointer user_data)
+{
+	struct ofono_stk *stk =3D user_data;
+	struct stk_data *sd =3D ofono_stk_get_data(stk);
+	GAtResultIter iter;
+	const guint8 *pdu;
+	gint len, length_bytes;
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
+static void satn_notify(GAtResult *result, gpointer user_data)
+{
+	/* TODO */
+}
+
+static gboolean calypso_stk_register(gpointer user)
+{
+	struct ofono_stk *stk =3D user;
+	struct stk_data *sd =3D ofono_stk_get_data(stk);
+
+	g_at_chat_register(sd->chat, "%SATI:", sati_notify, FALSE, stk, NULL);
+	g_at_chat_register(sd->chat, "%SATA:", sati_notify, FALSE, stk, NULL);
+	g_at_chat_register(sd->chat, "%SATN:", satn_notify, FALSE, stk, NULL);
+
+	ofono_stk_register(stk);
+
+	return FALSE;
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
+	g_idle_add(calypso_stk_register, stk);
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
index d0cd7f3..2712a15 100644
--- a/plugins/phonesim.c
+++ b/plugins/phonesim.c
@@ -66,6 +66,7 @@ struct phonesim_data {
 	GAtChat *chat;
 	gboolean calypso;
 	gboolean use_mux;
+	gboolean have_sim;
 };
 =

 static int phonesim_probe(struct ofono_modem *modem)
@@ -98,15 +99,29 @@ static void phonesim_debug(const char *str, void *user_=
data)
 	ofono_info("%s", str);
 }
 =

-static void cfun_set_on_cb(gboolean ok, GAtResult *result, gpointer user_d=
ata)
+static void cpin_check_cb(gboolean ok, GAtResult *result, gpointer user_da=
ta)
 {
 	struct ofono_modem *modem =3D user_data;
+	struct phonesim_data *data =3D ofono_modem_get_data(modem);
 =

 	DBG("");
 =

+	data->have_sim =3D ok;
+
 	ofono_modem_set_powered(modem, ok);
 }
 =

+static void cfun_set_on_cb(gboolean ok, GAtResult *result, gpointer user_d=
ata)
+{
+	struct ofono_modem *modem =3D user_data;
+	struct phonesim_data *data =3D ofono_modem_get_data(modem);
+
+	DBG("");
+
+	g_at_chat_send(data->chat, "AT+CPIN?", NULL,
+			cpin_check_cb, modem, NULL);
+}
+
 static void phonesim_disconnected(gpointer user_data)
 {
 	struct ofono_modem *modem =3D user_data;
@@ -241,6 +256,23 @@ static int phonesim_enable(struct ofono_modem *modem)
 =

 		g_at_chat_send(data->chat, "AT%CUNS=3D0",
 				NULL, NULL, NULL, NULL);
+
+		/* It looks like the PROFILE DOWNLOAD is done by the modem
+		 * as part of +CFUN=3D1.  By default the profile indicates that
+		 * TE supports no Proactive UICC.  We need to enable the
+		 * %SATA and other notifications here for STK support and
+		 * give the modem our profile bits (first N bytes) according
+		 * to ETSI TS 102 223 section 5.2.  The modem seems to AND
+		 * the given value with its own capabilities and OR with some
+		 * minimum value.  The bits are reset to the minimal values
+		 * on +CFUN=3D0.
+		 *
+		 * Default value is 450F80021F0000A4020000000000000000000000.
+		 * The mask is 4DFF973F7F0200FC0303FF00009FFFE700000000.
+		 */
+		g_at_chat_send(data->chat,
+				"AT%SATC=3D1,\"19E1FFFF0000FF7FFF03FE\"",
+				NULL, NULL, NULL, NULL);
 	}
 =

 	if (data->use_mux) {
@@ -278,20 +310,16 @@ static void phonesim_pre_sim(struct ofono_modem *mode=
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


--===============8905622960216386093==--

