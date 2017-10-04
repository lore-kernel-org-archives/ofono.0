Content-Type: multipart/mixed; boundary="===============0881448355874922140=="
MIME-Version: 1.0
From: Ankit Navik <ankit.p.navik@intel.com>
Subject: [PATCH 4/6] xmm7modem: Add ims atom driver
Date: Wed, 04 Oct 2017 10:37:05 +0530
Message-ID: <1507093627-2118-2-git-send-email-ankit.p.navik@intel.com>
In-Reply-To: <1507093627-2118-1-git-send-email-ankit.p.navik@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0881448355874922140==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 Makefile.am                   |   3 +-
 drivers/xmm7modem/ims.c       | 257 ++++++++++++++++++++++++++++++++++++++=
++++
 drivers/xmm7modem/xmm7modem.c |   2 +
 drivers/xmm7modem/xmm7modem.h |   3 +
 plugins/xmm7xxx.c             |   1 +
 5 files changed, 265 insertions(+), 1 deletion(-)
 create mode 100755 drivers/xmm7modem/ims.c

diff --git a/Makefile.am b/Makefile.am
index 199de08..1a03229 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -401,7 +401,8 @@ builtin_modules +=3D xmm7modem
 builtin_sources +=3D drivers/atmodem/atutil.h \
 			drivers/xmm7modem/xmm7modem.h \
 			drivers/xmm7modem/xmm7modem.c \
-			drivers/xmm7modem/radio-settings.c
+			drivers/xmm7modem/radio-settings.c \
+			drivers/xmm7modem/ims.c
 =

 if PHONESIM
 builtin_modules +=3D phonesim
diff --git a/drivers/xmm7modem/ims.c b/drivers/xmm7modem/ims.c
new file mode 100755
index 0000000..f9e42c7
--- /dev/null
+++ b/drivers/xmm7modem/ims.c
@@ -0,0 +1,257 @@
+/*
+ *
+ *  oFono - Open Source Telephony
+ *
+ *  Copyright (C) 2017  Intel Corporation. All rights reserved.
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
+#include <stdlib.h>
+#include <stdio.h>
+#include <string.h>
+#include <errno.h>
+
+#include <glib.h>
+
+#include <ofono/modem.h>
+#include <ofono/log.h>
+#include <ofono/ims.h>
+
+#include "gatchat.h"
+#include "gatresult.h"
+
+#include "xmm7modem.h"
+
+static const char *none_prefix[] =3D { NULL };
+static const char *cireg_prefix[] =3D { "+CIREG:", NULL };
+
+struct ims_driver_data {
+	GAtChat *chat;
+};
+
+static void xmm_cireg_cb(gboolean ok, GAtResult *result,
+							gpointer user_data)
+{
+	struct cb_data *cbd =3D user_data;
+	ofono_ims_status_cb_t cb =3D cbd->cb;
+	struct ofono_error error;
+	GAtResultIter iter;
+	int value, reg_info =3D -1, ext_info =3D -1;
+
+	DBG("ok %d", ok);
+
+	decode_at_error(&error, g_at_result_final_response(result));
+
+	if (!ok) {
+		cb(&error, -1, -1, cbd->data);
+		return;
+	}
+
+	g_at_result_iter_init(&iter, result);
+
+	if (g_at_result_iter_next(&iter, "+CIREG:") =3D=3D FALSE)
+		goto error;
+
+	if (g_at_result_iter_next_number(&iter, &value) =3D=3D FALSE)
+		goto error;
+
+	if (g_at_result_iter_next_number(&iter, &reg_info) =3D=3D FALSE)
+		goto error;
+
+	if (reg_info =3D=3D 0)
+		ext_info =3D  -1;
+	else
+		if (g_at_result_iter_next_number(&iter, &ext_info) =3D=3D FALSE)
+			goto error;
+
+	cb(&error, reg_info, ext_info, cbd->data);
+
+	return;
+
+error:
+	CALLBACK_WITH_FAILURE(cb, -1, -1, cbd->data);
+}
+
+static void xmm_ims_registration_status(struct ofono_ims *ims,
+					ofono_ims_status_cb_t cb, void *data)
+{
+	struct ims_driver_data *idd =3D ofono_ims_get_data(ims);
+	struct cb_data *cbd =3D cb_data_new(cb, data);
+
+	if (g_at_chat_send(idd->chat, "AT+CIREG?", cireg_prefix,
+					xmm_cireg_cb, cbd, g_free) > 0)
+		return;
+
+	CALLBACK_WITH_FAILURE(cb, -1, -1, data);
+	g_free(cbd);
+}
+
+static void xmm_ims_register_cb(gboolean ok, GAtResult *result,
+					gpointer user_data)
+{
+	struct cb_data *cbd =3D user_data;
+	ofono_ims_register_cb_t cb =3D cbd->cb;
+	struct ofono_error error;
+
+	DBG("ok %d", ok);
+
+	decode_at_error(&error, g_at_result_final_response(result));
+	cb(&error, cbd->data);
+}
+
+static void xmm_ims_register(struct ofono_ims *ims,
+					ofono_ims_register_cb_t cb, void *data)
+{
+	struct ims_driver_data *idd =3D ofono_ims_get_data(ims);
+	struct cb_data *cbd =3D cb_data_new(cb, data);
+
+	/* We can't do much in case of failure so don't check response. */
+	if (g_at_chat_send(idd->chat, "AT+XIREG=3D1", none_prefix,
+			xmm_ims_register_cb, cbd, g_free) > 0)
+		return;
+
+	CALLBACK_WITH_FAILURE(cb, data);
+	g_free(cbd);
+}
+
+static void xmm_ims_unregister(struct ofono_ims *ims,
+					ofono_ims_register_cb_t cb, void *data)
+{
+	struct ims_driver_data *idd =3D ofono_ims_get_data(ims);
+	struct cb_data *cbd =3D cb_data_new(cb, data);
+
+	/* We can't do much in case of failure so don't check response. */
+	if (g_at_chat_send(idd->chat, "AT+XIREG=3D0", none_prefix,
+			xmm_ims_register_cb, cbd, g_free) > 0)
+		return;
+
+	CALLBACK_WITH_FAILURE(cb, data);
+	g_free(cbd);
+}
+
+static void ciregu_notify(GAtResult *result, gpointer user_data)
+{
+	struct ofono_ims *ims =3D user_data;
+	int reg_info =3D -1, ext_info =3D -1;
+	GAtResultIter iter;
+
+	g_at_result_iter_init(&iter, result);
+
+	if (!g_at_result_iter_next(&iter, "+CIREGU:"))
+		return;
+
+	if (!g_at_result_iter_next_number(&iter, &reg_info))
+		return;
+
+	if (reg_info =3D=3D 0)
+		ext_info =3D  -1;
+	else
+		if (!g_at_result_iter_next_number(&iter, &ext_info))
+			return;
+
+	DBG("reg_info:%d, ext_info:%d", reg_info, ext_info);
+
+	ofono_ims_status_notify(ims, reg_info, ext_info);
+}
+
+static void xmm_cireg_set_cb(gboolean ok, GAtResult *result,
+						gpointer user_data)
+{
+	struct ofono_ims *ims =3D user_data;
+
+	if (!ok) {
+		ofono_ims_remove(ims);
+		return;
+	}
+
+	ofono_ims_register(ims);
+}
+
+static void cireg_support_cb(gboolean ok, GAtResult *result,
+						gpointer user_data)
+{
+	struct ofono_ims *ims =3D user_data;
+	struct ims_driver_data *idd =3D ofono_ims_get_data(ims);
+
+	if (!ok) {
+		ofono_ims_remove(ims);
+		return;
+	}
+
+	g_at_chat_register(idd->chat, "+CIREGU:", ciregu_notify,
+					FALSE, ims, NULL);
+
+	g_at_chat_send(idd->chat, "AT+CIREG=3D2", none_prefix,
+				xmm_cireg_set_cb, ims, NULL);
+}
+
+static int xmm_ims_probe(struct ofono_ims *ims, void *data)
+{
+	GAtChat *chat =3D data;
+	struct ims_driver_data *idd;
+
+	DBG("at ims probe");
+
+	idd =3D g_try_new0(struct ims_driver_data, 1);
+	if (!idd)
+		return -ENOMEM;
+
+	idd->chat =3D g_at_chat_clone(chat);
+
+	ofono_ims_set_data(ims, idd);
+
+	g_at_chat_send(idd->chat, "AT+CIREG=3D?", cireg_prefix,
+				cireg_support_cb, ims, NULL);
+
+	return 0;
+}
+
+static void xmm_ims_remove(struct ofono_ims *ims)
+{
+	struct ims_driver_data *idd =3D ofono_ims_get_data(ims);
+
+	DBG("at ims remove");
+
+	g_at_chat_unref(idd->chat);
+
+	ofono_ims_set_data(ims, NULL);
+
+	g_free(idd);
+}
+
+static struct ofono_ims_driver driver =3D {
+	.name				=3D "xmm7modem",
+	.probe				=3D xmm_ims_probe,
+	.remove				=3D xmm_ims_remove,
+	.ims_register			=3D xmm_ims_register,
+	.ims_unregister			=3D xmm_ims_unregister,
+	.registration_status		=3D xmm_ims_registration_status,
+};
+
+void xmm_ims_init(void)
+{
+	ofono_ims_driver_register(&driver);
+}
+
+void xmm_ims_exit(void)
+{
+	ofono_ims_driver_unregister(&driver);
+}
diff --git a/drivers/xmm7modem/xmm7modem.c b/drivers/xmm7modem/xmm7modem.c
index db1864e..5c08343 100644
--- a/drivers/xmm7modem/xmm7modem.c
+++ b/drivers/xmm7modem/xmm7modem.c
@@ -36,6 +36,7 @@
 static int xmm7modem_init(void)
 {
 	xmm_radio_settings_init();
+	xmm_ims_init();
 =

 	return 0;
 }
@@ -43,6 +44,7 @@ static int xmm7modem_init(void)
 static void xmm7modem_exit(void)
 {
 	xmm_radio_settings_exit();
+	xmm_ims_exit();
 }
 =

 OFONO_PLUGIN_DEFINE(xmm7modem, "Intel xmm7xxx series modem driver",
diff --git a/drivers/xmm7modem/xmm7modem.h b/drivers/xmm7modem/xmm7modem.h
index 44fa3d6..5f8f172 100644
--- a/drivers/xmm7modem/xmm7modem.h
+++ b/drivers/xmm7modem/xmm7modem.h
@@ -25,3 +25,6 @@
 =

 extern void xmm_radio_settings_init(void);
 extern void xmm_radio_settings_exit(void);
+
+extern void xmm_ims_init(void);
+extern void xmm_ims_exit(void);
diff --git a/plugins/xmm7xxx.c b/plugins/xmm7xxx.c
index 4443d4c..24b7d31 100644
--- a/plugins/xmm7xxx.c
+++ b/plugins/xmm7xxx.c
@@ -48,6 +48,7 @@
 #include <ofono/gprs-context.h>
 #include <ofono/stk.h>
 #include <ofono/lte.h>
+#include <ofono/ims.h>
 =

 #include <drivers/atmodem/atutil.h>
 #include <drivers/atmodem/vendor.h>
-- =

1.9.1


--===============0881448355874922140==--

