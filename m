Content-Type: multipart/mixed; boundary="===============3338353488815041765=="
MIME-Version: 1.0
From: Sjur =?unknown-8bit?q?Br=C3=A6ndeland?= <sjur.brandeland@stericsson.com>
Subject: [PATCH 3/6] stemodem: Add support for STK.
Date: Fri, 13 Aug 2010 12:53:11 +0200
Message-ID: <1281696794-10891-3-git-send-email-sjur.brandeland@stericsson.com>
In-Reply-To: <1281696794-10891-1-git-send-email-sjur.brandeland@stericsson.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3338353488815041765==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Copy and rename stk.c from mbmmodem.c
Original author: Andrzej Zaborowski <andrew.zaborowski@intel.com>
---
 Makefile.am                 |    3 +-
 drivers/stemodem/stemodem.c |    2 +
 drivers/stemodem/stemodem.h |    2 +
 drivers/stemodem/stk.c      |  245 +++++++++++++++++++++++++++++++++++++++=
++++
 plugins/ste.c               |    2 +
 5 files changed, 253 insertions(+), 1 deletions(-)
 create mode 100644 drivers/stemodem/stk.c

diff --git a/Makefile.am b/Makefile.am
index 2f0b745..82e0c0d 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -204,7 +204,8 @@ builtin_sources +=3D drivers/atmodem/atutil.h \
 			drivers/stemodem/voicecall.c \
 			drivers/stemodem/gprs-context.c \
 			drivers/stemodem/caif_socket.h \
-			drivers/stemodem/if_caif.h
+			drivers/stemodem/if_caif.h \
+			drivers/stemodem/stk.c
 =

 builtin_modules +=3D phonesim
 builtin_sources +=3D plugins/phonesim.c
diff --git a/drivers/stemodem/stemodem.c b/drivers/stemodem/stemodem.c
index c18a8b5..34dab80 100644
--- a/drivers/stemodem/stemodem.c
+++ b/drivers/stemodem/stemodem.c
@@ -38,6 +38,7 @@ static int stemodem_init(void)
 {
 	ste_voicecall_init();
 	ste_gprs_context_init();
+	ste_stk_init();
 =

 	return 0;
 }
@@ -46,6 +47,7 @@ static void stemodem_exit(void)
 {
 	ste_voicecall_exit();
 	ste_gprs_context_exit();
+	ste_stk_exit();
 }
 =

 OFONO_PLUGIN_DEFINE(stemodem, "STE modem driver", VERSION,
diff --git a/drivers/stemodem/stemodem.h b/drivers/stemodem/stemodem.h
index 267e001..27123d4 100644
--- a/drivers/stemodem/stemodem.h
+++ b/drivers/stemodem/stemodem.h
@@ -28,3 +28,5 @@ extern void ste_gprs_context_exit();
 extern void ste_voicecall_init();
 extern void ste_voicecall_exit();
 =

+extern void ste_stk_init();
+extern void ste_stk_exit();
diff --git a/drivers/stemodem/stk.c b/drivers/stemodem/stk.c
new file mode 100644
index 0000000..2c39114
--- /dev/null
+++ b/drivers/stemodem/stk.c
@@ -0,0 +1,245 @@
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
+#include "stemodem.h"
+
+struct stk_data {
+	GAtChat *chat;
+};
+
+static const char *stke_prefix[] =3D { "%STKE:", NULL };
+static const char *none_prefix[] =3D { NULL };
+
+static void ste_stke_cb(gboolean ok, GAtResult *result, gpointer user_data)
+{
+	struct cb_data *cbd =3D user_data;
+	ofono_stk_envelope_cb_t cb =3D cbd->cb;
+	GAtResultIter iter;
+	struct ofono_error error;
+	const guint8 *pdu =3D NULL;
+	gint len =3D 0;
+
+	decode_at_error(&error, g_at_result_final_response(result));
+
+	if (!ok) {
+		cb(&error, NULL, 0, cbd->data);
+		return;
+	}
+
+	g_at_result_iter_init(&iter, result);
+
+	if (g_at_result_iter_next(&iter, "*STKE:") =3D=3D TRUE)
+		if (g_at_result_iter_next_hexstring(&iter, &pdu, &len) =3D=3D FALSE)
+			goto error;
+
+	cb(&error, pdu, len, cbd->data);
+	return;
+
+error:
+	CALLBACK_WITH_FAILURE(cb, NULL, 0, cbd->data);
+}
+
+static void ste_stk_envelope(struct ofono_stk *stk, int length,
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
+	ret =3D g_at_chat_send(sd->chat, buf, stke_prefix,
+				ste_stke_cb, cbd, g_free);
+
+	g_free(buf);
+	buf =3D NULL;
+
+	if (ret > 0)
+		return;
+
+error:
+	g_free(buf);
+	g_free(cbd);
+
+	CALLBACK_WITH_FAILURE(cb, NULL, 0, data);
+}
+
+static void ste_stkr_cb(gboolean ok, GAtResult *result, gpointer user_data)
+{
+	struct cb_data *cbd =3D user_data;
+	ofono_stk_generic_cb_t cb =3D cbd->cb;
+	struct ofono_error error;
+
+	decode_at_error(&error, g_at_result_final_response(result));
+	cb(&error, cbd->data);
+}
+
+static void ste_stk_terminal_response(struct ofono_stk *stk, int length,
+					const unsigned char *command,
+					ofono_stk_generic_cb_t cb, void *data)
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
+	ret =3D g_at_chat_send(sd->chat, buf, none_prefix,
+				ste_stkr_cb, cbd, g_free);
+
+	g_free(buf);
+	buf =3D NULL;
+
+	if (ret > 0)
+		return;
+
+error:
+	g_free(buf);
+	g_free(cbd);
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
+	struct ofono_stk *stk =3D user_data;
+
+	ofono_stk_proactive_session_end_notify(stk);
+}
+
+static void ste_stkc_cb(gboolean ok, GAtResult *result, gpointer user_data)
+{
+	struct ofono_stk *stk =3D user_data;
+	struct stk_data *sd =3D ofono_stk_get_data(stk);
+
+	if (!ok)
+		return;
+
+	g_at_chat_register(sd->chat, "*STKI:", stki_notify, FALSE, stk, NULL);
+	g_at_chat_register(sd->chat, "*STKN:", stkn_notify, FALSE, stk, NULL);
+	g_at_chat_register(sd->chat, "*STKEND",
+					stkend_notify, FALSE, stk, NULL);
+
+	ofono_stk_register(stk);
+}
+
+static int ste_stk_probe(struct ofono_stk *stk, unsigned int vendor, void =
*data)
+{
+	GAtChat *chat =3D data;
+	struct stk_data *sd;
+
+	sd =3D g_new0(struct stk_data, 1);
+	sd->chat =3D chat;
+
+	ofono_stk_set_data(stk, sd);
+
+	/* Perform PROFILE DOWNLOAD and enable *STKI / *STKN */
+	g_at_chat_send(sd->chat, "AT*STKC=3D1,\"19E1FFFF0000FF7FFF03FEFF\"",
+			none_prefix, ste_stkc_cb, stk, NULL);
+
+	return 0;
+}
+
+static void ste_stk_remove(struct ofono_stk *stk)
+{
+	struct stk_data *sd =3D ofono_stk_get_data(stk);
+
+	ofono_stk_set_data(stk, NULL);
+
+	g_free(sd);
+}
+
+static struct ofono_stk_driver driver =3D {
+	.name			=3D "stemodem",
+	.probe			=3D ste_stk_probe,
+	.remove			=3D ste_stk_remove,
+	.envelope		=3D ste_stk_envelope,
+	.terminal_response	=3D ste_stk_terminal_response,
+};
+
+void ste_stk_init()
+{
+	ofono_stk_driver_register(&driver);
+}
+
+void ste_stk_exit()
+{
+	ofono_stk_driver_unregister(&driver);
+}
diff --git a/plugins/ste.c b/plugins/ste.c
index f3ae0b2..ab48e18 100644
--- a/plugins/ste.c
+++ b/plugins/ste.c
@@ -54,6 +54,7 @@
 #include <ofono/voicecall.h>
 #include <ofono/gprs.h>
 #include <ofono/gprs-context.h>
+#include <ofono/stk.h>
 #include <drivers/atmodem/vendor.h>
 =

 #include <drivers/stemodem/caif_socket.h>
@@ -241,6 +242,7 @@ static void ste_post_sim(struct ofono_modem *modem)
 =

 	gprs =3D ofono_gprs_create(modem,
 			OFONO_VENDOR_STE, "atmodem", data->chat);
+	ofono_stk_create(modem, 0, "stemodem", data->chat);
 	gc =3D ofono_gprs_context_create(modem, 0, "stemodem", data->chat);
 =

 	if (gprs && gc)
-- =

1.7.0.4


--===============3338353488815041765==--

