Content-Type: multipart/mixed; boundary="===============4032037026065328390=="
MIME-Version: 1.0
From: Jeevaka Badrappan <jeevaka.badrappan@elektrobit.com>
Subject: [PATCH v2 1/1] ifxmodem: add enable/disable ctm support
Date: Thu, 13 Jan 2011 13:02:45 +0200
Message-ID: <1294916565-16657-2-git-send-email-jeevaka.badrappan@elektrobit.com>
In-Reply-To: <1294916565-16657-1-git-send-email-jeevaka.badrappan@elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4032037026065328390==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 Makefile.am                 |    3 +-
 drivers/ifxmodem/ctm.c      |  194 +++++++++++++++++++++++++++++++++++++++=
++++
 drivers/ifxmodem/ifxmodem.c |    2 +
 drivers/ifxmodem/ifxmodem.h |    3 +
 4 files changed, 201 insertions(+), 1 deletions(-)
 create mode 100644 drivers/ifxmodem/ctm.c

diff --git a/Makefile.am b/Makefile.am
index a68fc36..179ea07 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -222,7 +222,8 @@ builtin_sources +=3D drivers/atmodem/atutil.h \
 			drivers/ifxmodem/audio-settings.c \
 			drivers/ifxmodem/radio-settings.c \
 			drivers/ifxmodem/gprs-context.c \
-			drivers/ifxmodem/stk.c
+			drivers/ifxmodem/stk.c \
+			drivers/ifxmodem/ctm.c
 =

 builtin_modules +=3D stemodem
 builtin_sources +=3D drivers/atmodem/atutil.h \
diff --git a/drivers/ifxmodem/ctm.c b/drivers/ifxmodem/ctm.c
new file mode 100644
index 0000000..b70fe09
--- /dev/null
+++ b/drivers/ifxmodem/ctm.c
@@ -0,0 +1,194 @@
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
+#include <errno.h>
+
+#include <glib.h>
+
+#include <ofono/log.h>
+#include <ofono/modem.h>
+#include <ofono/ctm.h>
+
+#include "gatchat.h"
+#include "gatresult.h"
+
+#include "ifxmodem.h"
+
+static const char *none_prefix[] =3D { NULL };
+static const char *xctms_prefix[] =3D { "XCTMS:", NULL };
+
+struct ctm_data {
+	GAtChat *chat;
+};
+
+static void xctms_query_cb(gboolean ok, GAtResult *result, gpointer user_d=
ata)
+{
+	struct cb_data *cbd =3D user_data;
+	ofono_ctm_query_cb_t cb =3D cbd->cb;
+	struct ofono_error error;
+	GAtResultIter iter;
+	int value;
+	ofono_bool_t enable;
+
+	decode_at_error(&error, g_at_result_final_response(result));
+
+	if (!ok) {
+		cb(&error, -1, cbd->data);
+		return;
+	}
+
+	g_at_result_iter_init(&iter, result);
+
+	if (g_at_result_iter_next(&iter, "XCTMS:") =3D=3D FALSE)
+		goto error;
+
+	if (g_at_result_iter_next_number(&iter, &value) =3D=3D FALSE)
+		goto error;
+
+	/* FULL TTY mode status only sent to oFono */
+	enable =3D (value =3D=3D 1) ? TRUE : FALSE;
+
+	cb(&error, enable, cbd->data);
+
+	return;
+
+error:
+	CALLBACK_WITH_FAILURE(cb, -1, cbd->data);
+}
+
+static void ifx_query_tty(struct ofono_ctm *ctm, ofono_ctm_query_cb_t cb,
+				void *data)
+{
+	struct ctm_data *ctmd =3D ofono_ctm_get_data(ctm);
+	struct cb_data *cbd =3D cb_data_new(cb, data);
+
+	if (cbd =3D=3D NULL)
+		goto error;
+
+	if (g_at_chat_send(ctmd->chat, "AT+XCTMS?", xctms_prefix,
+				xctms_query_cb, cbd, g_free) > 0)
+		return;
+
+error:
+	g_free(cbd);
+
+	CALLBACK_WITH_FAILURE(cb, -1, data);
+}
+
+static void xctms_modify_cb(gboolean ok, GAtResult *result, gpointer user_=
data)
+{
+	struct cb_data *cbd =3D user_data;
+	ofono_ctm_set_cb_t cb =3D cbd->cb;
+	struct ofono_error error;
+
+	decode_at_error(&error, g_at_result_final_response(result));
+
+	/* TODO: Audio path configuration */
+
+	cb(&error, cbd->data);
+}
+
+static void ifx_set_tty(struct ofono_ctm *ctm, ofono_bool_t enable,
+				ofono_ctm_set_cb_t cb, void *data)
+{
+	struct ctm_data *ctmd =3D ofono_ctm_get_data(ctm);
+	struct cb_data *cbd =3D cb_data_new(cb, data);
+	char buf[20];
+
+	if (cbd =3D=3D NULL)
+		goto error;
+
+	/* Only FULL TTY mode enabled/disabled */
+	snprintf(buf, sizeof(buf), "AT+XCTMS=3D%i", enable ? 1 : 0);
+
+	if (g_at_chat_send(ctmd->chat, buf, none_prefix,
+				xctms_modify_cb, cbd, g_free) > 0)
+		return;
+
+error:
+	g_free(cbd);
+
+	CALLBACK_WITH_FAILURE(cb, data);
+}
+
+static void xctms_support_cb(gboolean ok, GAtResult *result, gpointer user=
_data)
+{
+	struct ofono_ctm *ctm =3D user_data;
+
+	if (ok)
+		ofono_ctm_register(ctm);
+}
+
+static int ifx_ctm_probe(struct ofono_ctm *ctm,
+				unsigned int vendor, void *data)
+{
+	GAtChat *chat =3D data;
+	struct ctm_data *ctmd;
+
+	ctmd =3D g_try_new0(struct ctm_data, 1);
+	if (ctmd =3D=3D NULL)
+		return -ENOMEM;
+
+	ctmd->chat =3D g_at_chat_clone(chat);
+
+	ofono_ctm_set_data(ctm, ctmd);
+
+	g_at_chat_send(ctmd->chat, "AT+XCTMS=3D?", xctms_prefix,
+			xctms_support_cb, ctm, NULL);
+
+	return 0;
+}
+
+static void ifx_ctm_remove(struct ofono_ctm *ctm)
+{
+	struct ctm_data *ctmd =3D ofono_ctm_get_data(ctm);
+
+	ofono_ctm_set_data(ctm, NULL);
+
+	g_at_chat_unref(ctmd->chat);
+	g_free(ctmd);
+}
+
+static struct ofono_ctm_driver driver =3D {
+	.name           =3D "ifxmodem",
+	.probe          =3D ifx_ctm_probe,
+	.remove         =3D ifx_ctm_remove,
+	.query_tty      =3D ifx_query_tty,
+	.set_tty        =3D ifx_set_tty,
+};
+
+void ifx_ctm_init(void)
+{
+	ofono_ctm_driver_register(&driver);
+}
+
+void ifx_ctm_exit(void)
+{
+	ofono_ctm_driver_unregister(&driver);
+}
diff --git a/drivers/ifxmodem/ifxmodem.c b/drivers/ifxmodem/ifxmodem.c
index 8a9ac8f..fecb221 100644
--- a/drivers/ifxmodem/ifxmodem.c
+++ b/drivers/ifxmodem/ifxmodem.c
@@ -39,6 +39,7 @@ static int ifxmodem_init(void)
 	ifx_radio_settings_init();
 	ifx_gprs_context_init();
 	ifx_stk_init();
+	ifx_ctm_init();
 =

 	return 0;
 }
@@ -50,6 +51,7 @@ static void ifxmodem_exit(void)
 	ifx_radio_settings_exit();
 	ifx_audio_settings_exit();
 	ifx_voicecall_exit();
+	ifx_ctm_exit();
 }
 =

 OFONO_PLUGIN_DEFINE(ifxmodem, "Infineon modem driver", VERSION,
diff --git a/drivers/ifxmodem/ifxmodem.h b/drivers/ifxmodem/ifxmodem.h
index fbd3c06..5da62b8 100644
--- a/drivers/ifxmodem/ifxmodem.h
+++ b/drivers/ifxmodem/ifxmodem.h
@@ -35,3 +35,6 @@ extern void ifx_gprs_context_exit(void);
 =

 extern void ifx_stk_init(void);
 extern void ifx_stk_exit(void);
+
+extern void ifx_ctm_init(void);
+extern void ifx_ctm_exit(void);
\ No newline at end of file
-- =

1.7.0.4


--===============4032037026065328390==--

