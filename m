Content-Type: multipart/mixed; boundary="===============6812575424415940002=="
MIME-Version: 1.0
From: Bertrand Aygon <bertrand.aygon@intel.com>
Subject: [PATCH 2/3] ztemodem: Add radio settings support
Date: Fri, 23 Mar 2012 12:01:09 +0100
Message-ID: <1332500470-8297-3-git-send-email-bertrand.aygon@intel.com>
In-Reply-To: <1332500470-8297-1-git-send-email-bertrand.aygon@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6812575424415940002==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 Makefile.am                       |    3 +-
 drivers/ztemodem/radio-settings.c |  212 +++++++++++++++++++++++++++++++++=
++++
 drivers/ztemodem/ztemodem.c       |    3 +
 drivers/ztemodem/ztemodem.h       |    3 +
 4 files changed, 220 insertions(+), 1 deletions(-)
 create mode 100644 drivers/ztemodem/radio-settings.c

diff --git a/Makefile.am b/Makefile.am
index 5c48222..af3c5a2 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -194,7 +194,8 @@ builtin_sources +=3D drivers/atmodem/atutil.h \
 builtin_modules +=3D ztemodem
 builtin_sources +=3D drivers/atmodem/atutil.h \
 			drivers/ztemodem/ztemodem.h \
-			drivers/ztemodem/ztemodem.c
+			drivers/ztemodem/ztemodem.c \
+			drivers/ztemodem/radio-settings.c
 =

 builtin_modules +=3D huaweimodem
 builtin_sources +=3D drivers/atmodem/atutil.h \
diff --git a/drivers/ztemodem/radio-settings.c b/drivers/ztemodem/radio-set=
tings.c
new file mode 100644
index 0000000..dab03e1
--- /dev/null
+++ b/drivers/ztemodem/radio-settings.c
@@ -0,0 +1,212 @@
+/*
+ *
+ *  oFono - Open Source Telephony
+ *
+ *  Copyright (C) 2008-2012  Intel Corporation. All rights reserved.
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
+#include <ofono/radio-settings.h>
+
+#include "gatchat.h"
+#include "gatresult.h"
+
+#include "ztemodem.h"
+
+static const char *none_prefix[] =3D { NULL };
+static const char *zsnt_prefix[] =3D { "+ZSNT:", NULL };
+
+struct radio_settings_data {
+	GAtChat *chat;
+};
+
+static void zsnt_query_cb(gboolean ok, GAtResult *result, gpointer user_da=
ta)
+{
+	struct cb_data *cbd =3D user_data;
+	ofono_radio_settings_rat_mode_query_cb_t cb =3D cbd->cb;
+	enum ofono_radio_access_mode mode;
+	struct ofono_error error;
+	GAtResultIter iter;
+	int value;
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
+	if (g_at_result_iter_next(&iter, "+ZSNT:") =3D=3D FALSE)
+		goto error;
+
+	if (g_at_result_iter_next_number(&iter, &value) =3D=3D FALSE)
+		goto error;
+
+	switch (value) {
+	case 0:
+		mode =3D OFONO_RADIO_ACCESS_MODE_ANY;
+		break;
+	case 1:
+		mode =3D OFONO_RADIO_ACCESS_MODE_GSM;
+		break;
+	case 2:
+		mode =3D OFONO_RADIO_ACCESS_MODE_UMTS;
+		break;
+	default:
+		CALLBACK_WITH_FAILURE(cb, -1, cbd->data);
+		return;
+	}
+
+	cb(&error, mode, cbd->data);
+
+	return;
+
+error:
+	CALLBACK_WITH_FAILURE(cb, -1, cbd->data);
+}
+
+static void zte_query_rat_mode(struct ofono_radio_settings *rs,
+				ofono_radio_settings_rat_mode_query_cb_t cb,
+				void *data)
+{
+	struct radio_settings_data *rsd =3D ofono_radio_settings_get_data(rs);
+	struct cb_data *cbd =3D cb_data_new(cb, data);
+
+	if (g_at_chat_send(rsd->chat, "AT+ZSNT?", zsnt_prefix,
+					zsnt_query_cb, cbd, g_free) =3D=3D 0) {
+		CALLBACK_WITH_FAILURE(cb, -1, data);
+		g_free(cbd);
+	}
+}
+
+static void zsnt_modify_cb(gboolean ok, GAtResult *result, gpointer user_d=
ata)
+{
+	struct cb_data *cbd =3D user_data;
+	ofono_radio_settings_rat_mode_set_cb_t cb =3D cbd->cb;
+	struct ofono_error error;
+
+	decode_at_error(&error, g_at_result_final_response(result));
+	cb(&error, cbd->data);
+}
+
+static void zte_set_rat_mode(struct ofono_radio_settings *rs,
+				enum ofono_radio_access_mode mode,
+				ofono_radio_settings_rat_mode_set_cb_t cb,
+				void *data)
+{
+	struct radio_settings_data *rsd =3D ofono_radio_settings_get_data(rs);
+	struct cb_data *cbd =3D cb_data_new(cb, data);
+	char buf[20];
+	int value;
+
+	switch (mode) {
+	case OFONO_RADIO_ACCESS_MODE_ANY:
+		value =3D 0;
+		break;
+	case OFONO_RADIO_ACCESS_MODE_GSM:
+		value =3D 1;
+		break;
+	case OFONO_RADIO_ACCESS_MODE_UMTS:
+		value =3D 2;
+		break;
+	case OFONO_RADIO_ACCESS_MODE_LTE:
+		goto error;
+	}
+
+	snprintf(buf, sizeof(buf), "AT+ZSNT=3D%u,0,0", value);
+
+	if (g_at_chat_send(rsd->chat, buf, none_prefix,
+					zsnt_modify_cb, cbd, g_free) > 0)
+		return;
+
+error:
+	CALLBACK_WITH_FAILURE(cb, data);
+	g_free(cbd);
+}
+
+static void zsnt_support_cb(gboolean ok, GAtResult *result, gpointer user_=
data)
+{
+	struct ofono_radio_settings *rs =3D user_data;
+
+	if (!ok)
+		return;
+
+	ofono_radio_settings_register(rs);
+}
+
+static int zte_radio_settings_probe(struct ofono_radio_settings *rs,
+					unsigned int vendor, void *data)
+{
+	GAtChat *chat =3D data;
+	struct radio_settings_data *rsd;
+
+	rsd =3D g_try_new0(struct radio_settings_data, 1);
+	if (rsd =3D=3D NULL)
+		return -ENOMEM;
+
+	rsd->chat =3D g_at_chat_clone(chat);
+
+	ofono_radio_settings_set_data(rs, rsd);
+
+	g_at_chat_send(rsd->chat, "AT+ZSNT=3D?", none_prefix,
+					zsnt_support_cb, rs, NULL);
+
+	return 0;
+}
+
+static void zte_radio_settings_remove(struct ofono_radio_settings *rs)
+{
+	struct radio_settings_data *rsd =3D ofono_radio_settings_get_data(rs);
+
+	ofono_radio_settings_set_data(rs, NULL);
+
+	g_at_chat_unref(rsd->chat);
+	g_free(rsd);
+}
+
+static struct ofono_radio_settings_driver driver =3D {
+	.name			=3D "ztemodem",
+	.probe			=3D zte_radio_settings_probe,
+	.remove			=3D zte_radio_settings_remove,
+	.query_rat_mode		=3D zte_query_rat_mode,
+	.set_rat_mode		=3D zte_set_rat_mode
+};
+
+void zte_radio_settings_init(void)
+{
+	ofono_radio_settings_driver_register(&driver);
+}
+
+void zte_radio_settings_exit(void)
+{
+	ofono_radio_settings_driver_unregister(&driver);
+}
diff --git a/drivers/ztemodem/ztemodem.c b/drivers/ztemodem/ztemodem.c
index 729e911..09a69d2 100644
--- a/drivers/ztemodem/ztemodem.c
+++ b/drivers/ztemodem/ztemodem.c
@@ -34,11 +34,14 @@
 =

 static int ztemodem_init(void)
 {
+	zte_radio_settings_init();
+
 	return 0;
 }
 =

 static void ztemodem_exit(void)
 {
+	zte_radio_settings_exit();
 }
 =

 OFONO_PLUGIN_DEFINE(ztemodem, "ZTE modem driver", VERSION,
diff --git a/drivers/ztemodem/ztemodem.h b/drivers/ztemodem/ztemodem.h
index d88fb94..675f176 100644
--- a/drivers/ztemodem/ztemodem.h
+++ b/drivers/ztemodem/ztemodem.h
@@ -20,3 +20,6 @@
  */
 =

 #include <drivers/atmodem/atutil.h>
+
+extern void zte_radio_settings_init(void);
+extern void zte_radio_settings_exit(void);
-- =

1.7.5.4

---------------------------------------------------------------------
Intel Corporation SAS (French simplified joint stock company)
Registered headquarters: "Les Montalets"- 2, rue de Paris, =

92196 Meudon Cedex, France
Registration Number:  302 456 199 R.C.S. NANTERRE
Capital: 4,572,000 Euros

This e-mail and any attachments may contain confidential material for
the sole use of the intended recipient(s). Any review or distribution
by others is strictly prohibited. If you are not the intended
recipient, please contact the sender and delete all copies.

--===============6812575424415940002==--

