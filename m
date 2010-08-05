Content-Type: multipart/mixed; boundary="===============1756603564758465829=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 3/6] calypsomodem: Add a Calypso STK driver.
Date: Thu, 05 Aug 2010 19:30:54 +0200
Message-ID: <1281029457-9048-3-git-send-email-andrew.zaborowski@intel.com>
In-Reply-To: <1281029457-9048-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1756603564758465829==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 Makefile.am                         |    3 +-
 drivers/calypsomodem/calypsomodem.c |    2 +
 drivers/calypsomodem/calypsomodem.h |    5 +
 drivers/calypsomodem/stk.c          |  277 +++++++++++++++++++++++++++++++=
++++
 4 files changed, 286 insertions(+), 1 deletions(-)
 create mode 100644 drivers/calypsomodem/stk.c

diff --git a/Makefile.am b/Makefile.am
index b64ce8e..8d1d2c2 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -169,7 +169,8 @@ builtin_modules +=3D calypsomodem
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
index 80af134..2afc6c3 100644
--- a/drivers/calypsomodem/calypsomodem.h
+++ b/drivers/calypsomodem/calypsomodem.h
@@ -20,6 +20,11 @@
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
diff --git a/drivers/calypsomodem/stk.c b/drivers/calypsomodem/stk.c
new file mode 100644
index 0000000..67472da
--- /dev/null
+++ b/drivers/calypsomodem/stk.c
@@ -0,0 +1,277 @@
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
+	/*
+	 * Ignore errors "SIM memory failure" and "Unknown error", seem
+	 * to be generated for no reason.
+	 */
+	if (!ok && error.type =3D=3D OFONO_ERROR_TYPE_CMS && error.error =3D=3D 3=
20) {
+		ok =3D TRUE;
+		error.type =3D OFONO_ERROR_TYPE_NO_ERROR;
+	}
+	if (!ok && error.type =3D=3D OFONO_ERROR_TYPE_CME && error.error =3D=3D 1=
00) {
+		ok =3D TRUE;
+		error.type =3D OFONO_ERROR_TYPE_NO_ERROR;
+	}
+
+	if (!ok) {
+		cb(&error, NULL, 0, cbd->data);
+		return;
+	}
+
+	g_at_result_iter_init(&iter, result);
+
+	if (g_at_result_iter_next(&iter, "%SATE:"))
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
+	ret =3D g_at_chat_send(sd->chat, buf, sate_prefix,
+				calypso_sate_cb, cbd, g_free);
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
+static void calypso_satr_cb(gboolean ok, GAtResult *result,
+				gpointer user_data)
+{
+	struct cb_data *cbd =3D user_data;
+	ofono_stk_generic_cb_t cb =3D cbd->cb;
+	struct ofono_error error;
+
+	decode_at_error(&error, g_at_result_final_response(result));
+	cb(&error, cbd->data);
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
+	ret =3D g_at_chat_send(sd->chat, buf, none_prefix,
+				calypso_satr_cb, cbd, g_free);
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
+static void sati_notify(GAtResult *result, gpointer user_data)
+{
+	struct ofono_stk *stk =3D user_data;
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
+		/*
+		 * An empty notification is a End Session notification on
+		 * the part of the UICC.
+		 */
+		ofono_stk_proactive_session_end_notify(stk);
+
+		return;
+	}
+
+	ofono_stk_proactive_command_notify(stk, len, pdu);
+}
+
+static void sata_notify(GAtResult *result, gpointer user_data)
+{
+	/* TODO: Pending call alert */
+}
+
+static void satn_notify(GAtResult *result, gpointer user_data)
+{
+	/*
+	 * Proactive command has been handled by the modem.  Should
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
+	if (!ok)
+		return;
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
+	/*
+	 * Provide terminal profile data needed for the download and
+	 * enable %SATI / %SATN.  The actual PROFILE DOWNLOAD will
+	 * happen during AT+CFUN=3D1 later.
+	 */
+	g_at_chat_send(sd->chat, "AT%SATC=3D1,\"19E1FFFF0000FF7FFF03FEFF\"",
+			none_prefix, NULL, stk, NULL);
+
+	/* Enable Call Control / SMS Control */
+	g_at_chat_send(sd->chat, "AT%SATCC=3D1",
+			none_prefix, calypso_stk_register, stk, NULL);
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
-- =

1.7.1.86.g0e460.dirty


--===============1756603564758465829==--

