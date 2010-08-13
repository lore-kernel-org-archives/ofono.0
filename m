Content-Type: multipart/mixed; boundary="===============4369644296197576645=="
MIME-Version: 1.0
From: Sjur =?unknown-8bit?q?Br=C3=A6ndeland?= <sjur.brandeland@stericsson.com>
Subject: [PATCH 5/6] stemodem: Add Radio Settings to STE Modem
Date: Fri, 13 Aug 2010 12:53:13 +0200
Message-ID: <1281696794-10891-5-git-send-email-sjur.brandeland@stericsson.com>
In-Reply-To: <1281696794-10891-1-git-send-email-sjur.brandeland@stericsson.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4369644296197576645==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 Makefile.am                       |    3 +-
 drivers/stemodem/radio-settings.c |  217 +++++++++++++++++++++++++++++++++=
++++
 drivers/stemodem/stemodem.c       |    2 +
 drivers/stemodem/stemodem.h       |    3 +
 plugins/ste.c                     |    2 +
 5 files changed, 226 insertions(+), 1 deletions(-)
 create mode 100644 drivers/stemodem/radio-settings.c

diff --git a/Makefile.am b/Makefile.am
index 82e0c0d..ad88bfa 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -205,7 +205,8 @@ builtin_sources +=3D drivers/atmodem/atutil.h \
 			drivers/stemodem/gprs-context.c \
 			drivers/stemodem/caif_socket.h \
 			drivers/stemodem/if_caif.h \
-			drivers/stemodem/stk.c
+			drivers/stemodem/stk.c \
+			drivers/stemodem/radio-settings.c
 =

 builtin_modules +=3D phonesim
 builtin_sources +=3D plugins/phonesim.c
diff --git a/drivers/stemodem/radio-settings.c b/drivers/stemodem/radio-set=
tings.c
new file mode 100644
index 0000000..2a5697d
--- /dev/null
+++ b/drivers/stemodem/radio-settings.c
@@ -0,0 +1,217 @@
+/*
+ *
+ *  oFono - Open Source Telephony
+ *
+ *  Copyright (C) 2008-2010  Intel Corporation. All rights reserved.
+ *  Copyright (C) 2010 ST-Ericsson AB.
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
+#include <ofono/radio-settings.h>
+
+#include "gatchat.h"
+#include "gatresult.h"
+
+#include "stemodem.h"
+
+
+static const char *none_prefix[] =3D { NULL };
+static const char *cfun_prefix[] =3D { "+CFUN:", NULL };
+struct radio_settings_data {
+	GAtChat *chat;
+};
+
+enum ste_ofono_radio_access_mode {
+	STE_RADIO_OFF =3D 0,
+	STE_RADIO_ON =3D 1,
+	STE_RADIO_FLIGHT_MODE =3D 4,
+	STE_RADIO_GSM_ONLY =3D 5,
+	STE_RADIO_WCDMA_ONLY =3D 6
+};
+
+static gboolean ste_mode_to_ofono_mode(enum ste_ofono_radio_access_mode st=
emode,
+				enum ofono_radio_access_mode *mode)
+{
+	switch (stemode) {
+	case STE_RADIO_ON:
+		*mode =3D OFONO_RADIO_ACCESS_MODE_ANY;
+		return TRUE;
+	case STE_RADIO_GSM_ONLY:
+		*mode =3D OFONO_RADIO_ACCESS_MODE_GSM;
+		return TRUE;
+	case STE_RADIO_WCDMA_ONLY:
+		*mode =3D OFONO_RADIO_ACCESS_MODE_UMTS;
+		return TRUE;
+	default:
+		return FALSE;
+	}
+}
+
+static gboolean ofono_mode_to_ste_mode(enum ofono_radio_access_mode mode,
+				enum ste_ofono_radio_access_mode *stemode)
+{
+	switch (mode) {
+	case OFONO_RADIO_ACCESS_MODE_ANY:
+		*stemode =3D STE_RADIO_ON;
+		return TRUE;
+	case OFONO_RADIO_ACCESS_MODE_GSM:
+		*stemode =3D STE_RADIO_GSM_ONLY;
+		return TRUE;
+
+	case OFONO_RADIO_ACCESS_MODE_UMTS:
+		*stemode =3D STE_RADIO_WCDMA_ONLY;
+		return TRUE;
+	default:
+		return FALSE;
+	}
+}
+
+static void sterat_query_cb(gboolean ok, GAtResult *result, gpointer user_=
data)
+{
+	struct cb_data *cbd =3D user_data;
+	ofono_radio_settings_rat_mode_query_cb_t cb =3D cbd->cb;
+	enum ofono_radio_access_mode mode;
+	GAtResultIter iter;
+	int value;
+
+	if (!ok) {
+		CALLBACK_WITH_FAILURE(cb, -1, cbd->data);
+		return;
+	}
+
+	g_at_result_iter_init(&iter, result);
+	if (!g_at_result_iter_next(&iter, "+CFUN:"))
+		return;
+
+	if (!g_at_result_iter_next_number(&iter, &value)) {
+		CALLBACK_WITH_FAILURE(cb, -1, cbd->data);
+		return;
+	}
+
+	if (!ste_mode_to_ofono_mode(value, &mode)) {
+		CALLBACK_WITH_FAILURE(cb, -1, cbd->data);
+		return;
+	}
+
+	CALLBACK_WITH_SUCCESS(cb, mode, cbd->data);
+}
+
+static void ste_query_rat_mode(struct ofono_radio_settings *rs,
+				ofono_radio_settings_rat_mode_query_cb_t cb,
+				void *data)
+{
+	struct radio_settings_data *rsd =3D ofono_radio_settings_get_data(rs);
+	struct cb_data *cbd =3D cb_data_new(cb, data);
+
+	if (g_at_chat_send(rsd->chat, "AT+CFUN?", cfun_prefix,
+					sterat_query_cb, cbd, g_free) =3D=3D 0) {
+		CALLBACK_WITH_FAILURE(cb, -1, data);
+		g_free(cbd);
+	}
+}
+
+static void sterat_modify_cb(gboolean ok, GAtResult *result, gpointer user=
_data)
+{
+	struct cb_data *cbd =3D user_data;
+	ofono_radio_settings_rat_mode_set_cb_t cb =3D cbd->cb;
+
+	if (!ok) {
+		CALLBACK_WITH_FAILURE(cb, cbd->data);
+		return;
+	}
+
+	CALLBACK_WITH_SUCCESS(cb, cbd->data);
+}
+
+static void ste_set_rat_mode(struct ofono_radio_settings *rs,
+				enum ofono_radio_access_mode mode,
+				ofono_radio_settings_rat_mode_set_cb_t cb,
+				void *data)
+{
+	struct radio_settings_data *rsd =3D ofono_radio_settings_get_data(rs);
+	struct cb_data *cbd =3D cb_data_new(cb, data);
+	char buf[20];
+	enum ste_ofono_radio_access_mode value;
+
+	if (!ofono_mode_to_ste_mode(mode, &value)) {
+		CALLBACK_WITH_FAILURE(cb, data);
+		g_free(cbd);
+		return;
+	}
+
+	snprintf(buf, sizeof(buf), "AT+CFUN=3D%u", value);
+
+	if (g_at_chat_send(rsd->chat, buf, none_prefix,
+					sterat_modify_cb, cbd, g_free) =3D=3D 0) {
+		CALLBACK_WITH_FAILURE(cb, data);
+		g_free(cbd);
+	}
+}
+
+static int ste_radio_settings_probe(struct ofono_radio_settings *rs,
+					unsigned int vendor, void *data)
+{
+	GAtChat *chat =3D data;
+	struct radio_settings_data *rsd;
+	rsd =3D g_try_new0(struct radio_settings_data, 1);
+	if (!rsd)
+		return -ENOMEM;
+
+	rsd->chat =3D chat;
+
+	ofono_radio_settings_set_data(rs, rsd);
+	ofono_radio_settings_register(rs);
+
+	return 0;
+}
+
+static void ste_radio_settings_remove(struct ofono_radio_settings *rs)
+{
+	struct radio_settings_data *rsd =3D ofono_radio_settings_get_data(rs);
+	ofono_radio_settings_set_data(rs, NULL);
+	g_free(rsd);
+}
+
+static struct ofono_radio_settings_driver driver =3D {
+	.name			=3D "stemodem",
+	.probe			=3D ste_radio_settings_probe,
+	.remove		=3D ste_radio_settings_remove,
+	.query_rat_mode	=3D ste_query_rat_mode,
+	.set_rat_mode		=3D ste_set_rat_mode
+};
+
+void ste_radio_settings_init()
+{
+	ofono_radio_settings_driver_register(&driver);
+}
+
+void ste_radio_settings_exit()
+{
+	ofono_radio_settings_driver_unregister(&driver);
+}
diff --git a/drivers/stemodem/stemodem.c b/drivers/stemodem/stemodem.c
index 34dab80..a5e744e 100644
--- a/drivers/stemodem/stemodem.c
+++ b/drivers/stemodem/stemodem.c
@@ -39,6 +39,7 @@ static int stemodem_init(void)
 	ste_voicecall_init();
 	ste_gprs_context_init();
 	ste_stk_init();
+	ste_radio_settings_init();
 =

 	return 0;
 }
@@ -48,6 +49,7 @@ static void stemodem_exit(void)
 	ste_voicecall_exit();
 	ste_gprs_context_exit();
 	ste_stk_exit();
+	ste_radio_settings_exit();
 }
 =

 OFONO_PLUGIN_DEFINE(stemodem, "STE modem driver", VERSION,
diff --git a/drivers/stemodem/stemodem.h b/drivers/stemodem/stemodem.h
index 27123d4..b33bde8 100644
--- a/drivers/stemodem/stemodem.h
+++ b/drivers/stemodem/stemodem.h
@@ -30,3 +30,6 @@ extern void ste_voicecall_exit();
 =

 extern void ste_stk_init();
 extern void ste_stk_exit();
+
+extern void ste_radio_settings_init();
+extern void ste_radio_settings_exit();
diff --git a/plugins/ste.c b/plugins/ste.c
index d82f48e..fd38a2f 100644
--- a/plugins/ste.c
+++ b/plugins/ste.c
@@ -55,6 +55,7 @@
 #include <ofono/gprs.h>
 #include <ofono/gprs-context.h>
 #include <ofono/stk.h>
+#include <ofono/radio-settings.h>
 #include <drivers/atmodem/vendor.h>
 =

 #include <drivers/stemodem/caif_socket.h>
@@ -294,6 +295,7 @@ static void ste_post_sim(struct ofono_modem *modem)
 			OFONO_VENDOR_STE, "atmodem", data->chat);
 	ofono_stk_create(modem, 0, "stemodem", data->chat);
 	gc =3D ofono_gprs_context_create(modem, 0, "stemodem", data->chat);
+	ofono_radio_settings_create(modem, 0, "stemodem", data->chat);
 =

 	if (gprs && gc)
 		ofono_gprs_add_context(gprs, gc);
-- =

1.7.0.4


--===============4369644296197576645==--

