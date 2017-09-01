Content-Type: multipart/mixed; boundary="===============0650326246539602673=="
MIME-Version: 1.0
From: Ankit Navik <ankit.p.navik@intel.com>
Subject: [PATCH 2/6] Add support for Intel xmm7xxx series modem driver
Date: Fri, 01 Sep 2017 11:23:01 +0530
Message-ID: <1504245182-17949-2-git-send-email-ankit.p.navik@intel.com>
In-Reply-To: <1504245182-17949-1-git-send-email-ankit.p.navik@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0650326246539602673==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This adds driver as xmm7modem for radio-settings
---
 Makefile.am                        |   5 +
 drivers/xmm7modem/radio-settings.c | 233 +++++++++++++++++++++++++++++++++=
++++
 drivers/xmm7modem/xmm7modem.c      |  50 ++++++++
 drivers/xmm7modem/xmm7modem.h      |  27 +++++
 4 files changed, 315 insertions(+)
 create mode 100644 drivers/xmm7modem/radio-settings.c
 create mode 100644 drivers/xmm7modem/xmm7modem.c
 create mode 100644 drivers/xmm7modem/xmm7modem.h

diff --git a/Makefile.am b/Makefile.am
index 18a806b..658e152 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -396,6 +396,11 @@ builtin_sources +=3D drivers/atmodem/atutil.h \
 			drivers/gemaltomodem/gemaltomodem.c \
 			drivers/gemaltomodem/location-reporting.c
 =

+builtin_modules +=3D xmm7modem
+builtin_sources +=3D drivers/atmodem/atutil.h \
+			drivers/xmm7modem/xmm7modem.h \
+			drivers/xmm7modem/xmm7modem.c \
+			drivers/xmm7modem/radio-settings.c
 =

 if PHONESIM
 builtin_modules +=3D phonesim
diff --git a/drivers/xmm7modem/radio-settings.c b/drivers/xmm7modem/radio-s=
ettings.c
new file mode 100644
index 0000000..8888b31
--- /dev/null
+++ b/drivers/xmm7modem/radio-settings.c
@@ -0,0 +1,233 @@
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
+#include "xmm7modem.h"
+
+static const char *none_prefix[] =3D { NULL };
+static const char *xact_prefix[] =3D { "+XACT:", NULL };
+
+struct radio_settings_data {
+	GAtChat *chat;
+};
+
+static void xact_query_cb(gboolean ok, GAtResult *result, gpointer user_da=
ta)
+{
+	struct cb_data *cbd =3D user_data;
+	ofono_radio_settings_rat_mode_query_cb_t cb =3D cbd->cb;
+	enum ofono_radio_access_mode mode;
+	struct ofono_error error;
+	GAtResultIter iter;
+	int value, preferred;
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
+	if (g_at_result_iter_next(&iter, "+XACT:") =3D=3D FALSE)
+		goto error;
+
+	if (g_at_result_iter_next_number(&iter, &value) =3D=3D FALSE)
+		goto error;
+
+	if (g_at_result_iter_next_number(&iter, &preferred) =3D=3D FALSE)
+		goto error;
+
+	switch (value) {
+	case 0:
+		mode =3D OFONO_RADIO_ACCESS_MODE_GSM;
+		break;
+	case 1:
+		mode =3D OFONO_RADIO_ACCESS_MODE_UMTS;
+		break;
+	case 2:
+		mode =3D OFONO_RADIO_ACCESS_MODE_LTE;
+		break;
+	case 3:
+		mode =3D OFONO_RADIO_ACCESS_MODE_UMTS;
+		break;
+	case 4:
+		mode =3D OFONO_RADIO_ACCESS_MODE_LTE;
+		break;
+	case 5:
+		mode =3D OFONO_RADIO_ACCESS_MODE_LTE;
+		break;
+	case 6:
+		mode =3D OFONO_RADIO_ACCESS_MODE_ANY;
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
+static void xmm_query_rat_mode(struct ofono_radio_settings *rs,
+				ofono_radio_settings_rat_mode_query_cb_t cb,
+				void *data)
+{
+	struct radio_settings_data *rsd =3D ofono_radio_settings_get_data(rs);
+	struct cb_data *cbd =3D cb_data_new(cb, data);
+
+	if (g_at_chat_send(rsd->chat, "AT+XACT?", xact_prefix,
+					xact_query_cb, cbd, g_free) > 0)
+		return;
+
+	CALLBACK_WITH_FAILURE(cb, -1, data);
+	g_free(cbd);
+}
+
+static void xact_modify_cb(gboolean ok, GAtResult *result, gpointer user_d=
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
+static void xmm_set_rat_mode(struct ofono_radio_settings *rs,
+				enum ofono_radio_access_mode mode,
+				ofono_radio_settings_rat_mode_set_cb_t cb,
+				void *data)
+{
+	struct radio_settings_data *rsd =3D ofono_radio_settings_get_data(rs);
+	struct cb_data *cbd =3D cb_data_new(cb, data);
+	char buf[20];
+	int value =3D 6, preferred =3D 2;
+
+	switch (mode) {
+	case OFONO_RADIO_ACCESS_MODE_ANY:
+		value =3D 6;
+		break;
+	case OFONO_RADIO_ACCESS_MODE_GSM:
+		value =3D 0;
+		break;
+	case OFONO_RADIO_ACCESS_MODE_UMTS:
+		value =3D 1;
+		break;
+	case OFONO_RADIO_ACCESS_MODE_LTE:
+		value =3D 2;
+		break;
+	}
+
+	if (value =3D=3D 6)
+		snprintf(buf, sizeof(buf), "AT+XACT=3D%u,%u", value, preferred);
+	else
+		snprintf(buf, sizeof(buf), "AT+XACT=3D%u", value);
+
+	if (g_at_chat_send(rsd->chat, buf, none_prefix,
+					xact_modify_cb, cbd, g_free) > 0)
+		return;
+
+	CALLBACK_WITH_FAILURE(cb, data);
+	g_free(cbd);
+}
+
+static void xact_support_cb(gboolean ok, GAtResult *result, gpointer user_=
data)
+{
+	struct ofono_radio_settings *rs =3D user_data;
+
+	if(!ok) {
+		ofono_radio_settings_remove(rs);
+		return;
+	}
+
+	ofono_radio_settings_register(rs);
+}
+
+static int xmm_radio_settings_probe(struct ofono_radio_settings *rs,
+					unsigned int vendor, void *user)
+{
+	GAtChat *chat =3D user;
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
+	g_at_chat_send(rsd->chat, "AT+XACT=3D?", xact_prefix,
+					xact_support_cb, rs, NULL);
+
+	return 0;
+}
+
+static void xmm_radio_settings_remove(struct ofono_radio_settings *rs)
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
+	.name			=3D "xmm7modem",
+	.probe			=3D xmm_radio_settings_probe,
+	.remove			=3D xmm_radio_settings_remove,
+	.query_rat_mode		=3D xmm_query_rat_mode,
+	.set_rat_mode		=3D xmm_set_rat_mode
+};
+
+void xmm_radio_settings_init(void)
+{
+	ofono_radio_settings_driver_register(&driver);
+}
+
+void xmm_radio_settings_exit(void)
+{
+	ofono_radio_settings_driver_unregister(&driver);
+}
diff --git a/drivers/xmm7modem/xmm7modem.c b/drivers/xmm7modem/xmm7modem.c
new file mode 100644
index 0000000..db1864e
--- /dev/null
+++ b/drivers/xmm7modem/xmm7modem.c
@@ -0,0 +1,50 @@
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
+#include <glib.h>
+#include <gatchat.h>
+
+#define OFONO_API_SUBJECT_TO_CHANGE
+#include <ofono/plugin.h>
+#include <ofono/types.h>
+#include <ofono/modem.h>
+
+#include "xmm7modem.h"
+
+static int xmm7modem_init(void)
+{
+	xmm_radio_settings_init();
+
+	return 0;
+}
+
+static void xmm7modem_exit(void)
+{
+	xmm_radio_settings_exit();
+}
+
+OFONO_PLUGIN_DEFINE(xmm7modem, "Intel xmm7xxx series modem driver",
+			VERSION, OFONO_PLUGIN_PRIORITY_DEFAULT,
+			xmm7modem_init, xmm7modem_exit)
diff --git a/drivers/xmm7modem/xmm7modem.h b/drivers/xmm7modem/xmm7modem.h
new file mode 100644
index 0000000..44fa3d6
--- /dev/null
+++ b/drivers/xmm7modem/xmm7modem.h
@@ -0,0 +1,27 @@
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
+#include <drivers/atmodem/atutil.h>
+
+#define XMM7MODEM "xmm7modem"
+
+extern void xmm_radio_settings_init(void);
+extern void xmm_radio_settings_exit(void);
-- =

1.9.1


--===============0650326246539602673==--

