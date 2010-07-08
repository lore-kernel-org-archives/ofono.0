Content-Type: multipart/mixed; boundary="===============6000343867245298306=="
MIME-Version: 1.0
From: Yang Gu <yang.gu@intel.com>
Subject: [PATCH] Add init phonesim stk support
Date: Thu, 08 Jul 2010 18:56:48 +0800
Message-ID: <1278586608-6246-1-git-send-email-yang.gu@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6000343867245298306==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 Makefile.am                           |   28 ++--
 drivers/phonesimmodem/phonesimmodem.c |   48 +++++
 drivers/phonesimmodem/phonesimmodem.h |   26 +++
 drivers/phonesimmodem/stk.c           |  316 +++++++++++++++++++++++++++++=
++++
 plugins/phonesim.c                    |    2 +-
 5 files changed, 408 insertions(+), 12 deletions(-)
 create mode 100644 drivers/phonesimmodem/phonesimmodem.c
 create mode 100644 drivers/phonesimmodem/phonesimmodem.h
 create mode 100644 drivers/phonesimmodem/stk.c

diff --git a/Makefile.am b/Makefile.am
index 24aa886..0548038 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -158,12 +158,6 @@ builtin_sources +=3D $(gatchat_sources) \
 				drivers/atmodem/gprs.c \
 				drivers/atmodem/gprs-context.c
 =

-builtin_modules +=3D nwmodem
-builtin_sources +=3D drivers/atmodem/atutil.h \
-			drivers/nwmodem/nwmodem.h \
-			drivers/nwmodem/nwmodem.c \
-			drivers/nwmodem/radio-settings.c
-
 builtin_modules +=3D calypsomodem
 builtin_sources +=3D drivers/atmodem/atutil.h \
 			drivers/calypsomodem/calypsomodem.h \
@@ -178,6 +172,13 @@ builtin_sources +=3D drivers/atmodem/atutil.h \
 			drivers/hfpmodem/network-registration.c \
 			drivers/hfpmodem/call-volume.c
 =

+builtin_modules +=3D hsomodem
+builtin_sources +=3D drivers/atmodem/atutil.h \
+			drivers/hsomodem/hsomodem.h \
+			drivers/hsomodem/hsomodem.c \
+			drivers/hsomodem/gprs-context.c \
+			drivers/hsomodem/radio-settings.c
+
 builtin_modules +=3D mbmmodem
 builtin_sources +=3D drivers/atmodem/atutil.h \
 			drivers/mbmmodem/mbmmodem.h \
@@ -185,12 +186,17 @@ builtin_sources +=3D drivers/atmodem/atutil.h \
 			drivers/mbmmodem/gprs-context.c \
 			drivers/mbmmodem/stk.c
 =

-builtin_modules +=3D hsomodem
+builtin_modules +=3D nwmodem
 builtin_sources +=3D drivers/atmodem/atutil.h \
-			drivers/hsomodem/hsomodem.h \
-			drivers/hsomodem/hsomodem.c \
-			drivers/hsomodem/gprs-context.c \
-			drivers/hsomodem/radio-settings.c
+			drivers/nwmodem/nwmodem.h \
+			drivers/nwmodem/nwmodem.c \
+			drivers/nwmodem/radio-settings.c
+
+builtin_modules +=3D phonesimmodem
+builtin_sources +=3D drivers/atmodem/atutil.h \
+			drivers/phonesimmodem/phonesimmodem.h \
+			drivers/phonesimmodem/phonesimmodem.c \
+			drivers/phonesimmodem/stk.c
 =

 builtin_modules +=3D stemodem
 builtin_sources +=3D drivers/atmodem/atutil.h \
diff --git a/drivers/phonesimmodem/phonesimmodem.c b/drivers/phonesimmodem/=
phonesimmodem.c
new file mode 100644
index 0000000..86a2f05
--- /dev/null
+++ b/drivers/phonesimmodem/phonesimmodem.c
@@ -0,0 +1,48 @@
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
+#include <glib.h>
+#include <gatchat.h>
+
+#define OFONO_API_SUBJECT_TO_CHANGE
+#include <ofono/plugin.h>
+#include <ofono/types.h>
+
+#include "phonesimmodem.h"
+
+static int phonesimmodem_init(void)
+{
+	phonesim_stk_init();
+
+	return 0;
+}
+
+static void phonesimmodem_exit(void)
+{
+	phonesim_stk_exit();
+}
+
+OFONO_PLUGIN_DEFINE(phonesimmodem, "Phonesim modem driver", VERSION,
+	OFONO_PLUGIN_PRIORITY_DEFAULT, phonesimmodem_init, phonesimmodem_exit)
diff --git a/drivers/phonesimmodem/phonesimmodem.h b/drivers/phonesimmodem/=
phonesimmodem.h
new file mode 100644
index 0000000..2e81712
--- /dev/null
+++ b/drivers/phonesimmodem/phonesimmodem.h
@@ -0,0 +1,26 @@
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
+#include <drivers/atmodem/atutil.h>
+
+extern void phonesim_stk_init();
+extern void phonesim_stk_exit();
+
diff --git a/drivers/phonesimmodem/stk.c b/drivers/phonesimmodem/stk.c
new file mode 100644
index 0000000..2cdac4c
--- /dev/null
+++ b/drivers/phonesimmodem/stk.c
@@ -0,0 +1,316 @@
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
+#include "phonesimmodem.h"
+
+struct stk_data {
+	GAtChat *chat;
+};
+
+static const char *csim_prefix[] =3D { "+CSIM:", NULL };
+
+static void phonesim_csim_envelope_cb(gboolean ok, GAtResult *result,
+				gpointer user_data)
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
+static void phonesim_stk_envelope(struct ofono_stk *stk, int length,
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
+	len =3D sprintf(buf, "AT+CSIM=3D%i,A0C20000%02hhX",
+			12 + length * 2, length);
+
+	for (; length; length--)
+		len +=3D sprintf(buf + len, "%02hhX", *command++);
+
+	len +=3D sprintf(buf + len, "FF");
+
+	ret =3D g_at_chat_send(sd->chat, buf, csim_prefix,
+				phonesim_csim_envelope_cb, cbd, g_free);
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
+static void phonesim_csim_terminal_response_cb(gboolean ok, GAtResult *res=
ult,
+						gpointer user_data)
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
+static void phonesim_stk_terminal_response(struct ofono_stk *stk, int leng=
th,
+					const unsigned char *value,
+					ofono_stk_generic_cb_t cb,
+					void *data)
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
+			phonesim_csim_terminal_response_cb, cbd, g_free);
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
+static void fetch_cb(gboolean ok, GAtResult *result,
+		gpointer user_data)
+{
+	struct ofono_stk *stk =3D user_data;
+	GAtResultIter iter;
+	const guint8 *response;
+	gint rlen, len;
+
+	if (!ok)
+		return;
+
+	g_at_result_iter_init(&iter, result);
+
+	if (!g_at_result_iter_next(&iter, "+CSIM:"))
+		return;
+
+	if (!g_at_result_iter_next_number(&iter, &rlen))
+		return;
+
+	if (!g_at_result_iter_next_hexstring(&iter, &response, &len))
+		return;
+
+	if (rlen !=3D len * 2 || len < 2)
+		return;
+
+	/* Check that SW1 indicates success */
+	if (response[len - 2] !=3D 0x90 && response[len - 2] !=3D 0x91)
+		return;
+
+	if (response[len - 2] =3D=3D 0x90 && response[len - 1] !=3D 0)
+		return;
+
+	ofono_stk_proactive_command_notify(stk, len - 2, response);
+}
+
+static void tcmd_notify(GAtResult *result, gpointer user_data)
+{
+	struct ofono_stk *stk =3D user_data;
+	struct stk_data *data =3D ofono_stk_get_data(stk);
+	GAtResultIter iter;
+	int length;
+	char buf[64];
+
+	g_at_result_iter_init(&iter, result);
+
+	if (!g_at_result_iter_next(&iter, "*TCMD:"))
+		return;
+
+	if (!g_at_result_iter_next_number(&iter, &length))
+		return;
+
+	snprintf(buf, sizeof(buf), "AT+CSIM=3D10,A0120000%02hhX", length);
+	g_at_chat_send(data->chat, buf, csim_prefix, fetch_cb, stk, NULL);
+}
+
+static gboolean phonesim_stk_register(gpointer user)
+{
+	struct ofono_stk *stk =3D user;
+	struct stk_data *data =3D ofono_stk_get_data(stk);
+
+	g_at_chat_register(data->chat, "*TCMD", tcmd_notify, FALSE, stk, NULL);
+	ofono_stk_register(stk);
+
+	return FALSE;
+}
+
+static int phonesim_stk_probe(struct ofono_stk *stk, unsigned int vendor,
+								void *data)
+{
+	GAtChat *chat =3D data;
+	struct stk_data *sd;
+
+	sd =3D g_new0(struct stk_data, 1);
+	sd->chat =3D chat;
+
+	ofono_stk_set_data(stk, sd);
+	g_idle_add(phonesim_stk_register, stk);
+
+	return 0;
+}
+
+static void phonesim_stk_remove(struct ofono_stk *stk)
+{
+	struct stk_data *sd =3D ofono_stk_get_data(stk);
+
+	ofono_stk_set_data(stk, NULL);
+
+	g_free(sd);
+}
+
+static struct ofono_stk_driver driver =3D {
+	.name			=3D "phonesimmodem",
+	.probe			=3D phonesim_stk_probe,
+	.remove			=3D phonesim_stk_remove,
+	.envelope		=3D phonesim_stk_envelope,
+	.terminal_response	=3D phonesim_stk_terminal_response,
+};
+
+void phonesim_stk_init()
+{
+	ofono_stk_driver_register(&driver);
+}
+
+void phonesim_stk_exit()
+{
+	ofono_stk_driver_unregister(&driver);
+}
diff --git a/plugins/phonesim.c b/plugins/phonesim.c
index d0cd7f3..86e50a9 100644
--- a/plugins/phonesim.c
+++ b/plugins/phonesim.c
@@ -289,7 +289,7 @@ static void phonesim_pre_sim(struct ofono_modem *modem)
 	else
 		ofono_voicecall_create(modem, 0, "atmodem", data->chat);
 =

-	ofono_stk_create(modem, 0, "atmodem", data->chat);
+	ofono_stk_create(modem, 0, "phonesimmodem", data->chat);
 =

 	if (sim)
 		ofono_sim_inserted_notify(sim, TRUE);
-- =

1.7.0.4


--===============6000343867245298306==--

