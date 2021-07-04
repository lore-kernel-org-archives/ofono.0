Content-Type: multipart/mixed; boundary="===============6507377714660465308=="
MIME-Version: 1.0
From: Sergey Matyukevich <geomatsi@gmail.com>
Subject: [PATCH 1/3] gemalto: add radio-settings driver
Date: Sun, 04 Jul 2021 18:53:46 +0300
Message-ID: <20210704155348.432964-2-geomatsi@gmail.com>
In-Reply-To: <20210704155348.432964-1-geomatsi@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6507377714660465308==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Add support for Gemalto specific radio settings.

---
 Makefile.am                           |   1 +
 drivers/gemaltomodem/gemaltomodem.c   |   2 +
 drivers/gemaltomodem/gemaltomodem.h   |   3 +
 drivers/gemaltomodem/radio-settings.c | 267 ++++++++++++++++++++++++++
 4 files changed, 273 insertions(+)
 create mode 100644 drivers/gemaltomodem/radio-settings.c

diff --git a/Makefile.am b/Makefile.am
index 0159fcb0..6f6e71ee 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -487,6 +487,7 @@ builtin_sources +=3D drivers/atmodem/atutil.h \
 			drivers/gemaltomodem/location-reporting.c \
 			drivers/gemaltomodem/voicecall.c \
 			drivers/gemaltomodem/gprs-context.c \
+			drivers/gemaltomodem/radio-settings.c \
 			drivers/gemaltomodem/netmon.c
 =

 builtin_modules +=3D xmm7modem
diff --git a/drivers/gemaltomodem/gemaltomodem.c b/drivers/gemaltomodem/gem=
altomodem.c
index f7e4ff3e..bcf37e5e 100644
--- a/drivers/gemaltomodem/gemaltomodem.c
+++ b/drivers/gemaltomodem/gemaltomodem.c
@@ -36,6 +36,7 @@
 static int gemaltomodem_init(void)
 {
 	gemalto_location_reporting_init();
+	gemalto_radio_settings_init();
 	gemalto_gprs_context_init();
 	gemalto_voicecall_init();
 	gemalto_netmon_init();
@@ -46,6 +47,7 @@ static int gemaltomodem_init(void)
 static void gemaltomodem_exit(void)
 {
 	gemalto_location_reporting_exit();
+	gemalto_radio_settings_exit();
 	gemalto_gprs_context_exit();
 	gemalto_voicecall_exit();
 	gemalto_netmon_exit();
diff --git a/drivers/gemaltomodem/gemaltomodem.h b/drivers/gemaltomodem/gem=
altomodem.h
index ae8f2141..91a70baa 100644
--- a/drivers/gemaltomodem/gemaltomodem.h
+++ b/drivers/gemaltomodem/gemaltomodem.h
@@ -33,3 +33,6 @@ extern void gemalto_gprs_context_exit();
 =

 extern void gemalto_netmon_init(void);
 extern void gemalto_netmon_exit(void);
+
+extern void gemalto_radio_settings_init(void);
+extern void gemalto_radio_settings_exit(void);
diff --git a/drivers/gemaltomodem/radio-settings.c b/drivers/gemaltomodem/r=
adio-settings.c
new file mode 100644
index 00000000..d2de89cf
--- /dev/null
+++ b/drivers/gemaltomodem/radio-settings.c
@@ -0,0 +1,267 @@
+/*
+ *
+ *  oFono - Open Source Telephony
+ *
+ *  Copyright (C) 2017 Intel Corporation. All rights reserved.
+ *  Copyright (C) 2021 Sergey Matyukevich. All rights reserved.
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
+#include "gemaltomodem.h"
+
+static const char *none_prefix[] =3D { NULL };
+static const char *sxrat_prefix[] =3D { "^SXRAT:", NULL };
+
+struct radio_settings_data {
+	GAtChat *chat;
+};
+
+static void sxrat_query_cb(gboolean ok, GAtResult *result, gpointer user_d=
ata)
+{
+	struct cb_data *cbd =3D user_data;
+	ofono_radio_settings_rat_mode_query_cb_t cb =3D cbd->cb;
+	enum ofono_radio_access_mode mode;
+	struct ofono_error error;
+	int value, pref1, pref2;
+	GAtResultIter iter;
+
+	DBG("ok %d", ok);
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
+	if (!g_at_result_iter_next(&iter, "^SXRAT:"))
+		goto error;
+
+	if (!g_at_result_iter_next_number(&iter, &value))
+		goto error;
+
+	g_at_result_iter_next_number_default(&iter, -1, &pref1);
+	g_at_result_iter_next_number_default(&iter, -1, &pref2);
+
+	DBG("mode %d pref1 %d pref2 %d", value, pref1, pref2);
+
+	switch (value) {
+	case 0:
+		mode =3D OFONO_RADIO_ACCESS_MODE_GSM;
+		break;
+	case 1:
+		mode =3D OFONO_RADIO_ACCESS_MODE_GSM |
+			OFONO_RADIO_ACCESS_MODE_UMTS;
+		break;
+	case 2:
+		mode =3D OFONO_RADIO_ACCESS_MODE_UMTS;
+		break;
+	case 3:
+		mode =3D OFONO_RADIO_ACCESS_MODE_LTE;
+		break;
+	case 4:
+		mode =3D OFONO_RADIO_ACCESS_MODE_UMTS |
+			OFONO_RADIO_ACCESS_MODE_LTE;
+		break;
+	case 5:
+		mode =3D OFONO_RADIO_ACCESS_MODE_GSM |
+			OFONO_RADIO_ACCESS_MODE_LTE;
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
+static void gemalto_query_rat_mode(struct ofono_radio_settings *rs,
+				ofono_radio_settings_rat_mode_query_cb_t cb,
+				void *data)
+{
+	struct radio_settings_data *rsd =3D ofono_radio_settings_get_data(rs);
+	struct cb_data *cbd =3D cb_data_new(cb, data);
+
+	DBG("");
+
+	if (g_at_chat_send(rsd->chat, "AT^SXRAT?", sxrat_prefix,
+				sxrat_query_cb, cbd, g_free) =3D=3D 0) {
+		CALLBACK_WITH_FAILURE(cb, -1, data);
+		g_free(cbd);
+	}
+}
+
+static void sxrat_modify_cb(gboolean ok, GAtResult *result, gpointer user_=
data)
+{
+	struct cb_data *cbd =3D user_data;
+	ofono_radio_settings_rat_mode_set_cb_t cb =3D cbd->cb;
+	struct ofono_error error;
+
+	DBG("ok %d", ok);
+
+	decode_at_error(&error, g_at_result_final_response(result));
+	cb(&error, cbd->data);
+}
+
+static void gemalto_set_rat_mode(struct ofono_radio_settings *rs,
+				enum ofono_radio_access_mode m,
+				ofono_radio_settings_rat_mode_set_cb_t cb,
+				void *data)
+{
+	struct radio_settings_data *rsd =3D ofono_radio_settings_get_data(rs);
+	struct cb_data *cbd =3D cb_data_new(cb, data);
+	int val=3D 6, p1 =3D 3, p2 =3D 2;
+	char buf[20];
+
+	DBG("mode %d", m);
+
+	switch (m) {
+	case OFONO_RADIO_ACCESS_MODE_ANY:
+		val =3D 6;
+		p1 =3D 3;
+		p2 =3D 2;
+		break;
+	case OFONO_RADIO_ACCESS_MODE_GSM:
+		val =3D 0;
+		break;
+	case OFONO_RADIO_ACCESS_MODE_UMTS:
+		val =3D 2;
+		break;
+	case OFONO_RADIO_ACCESS_MODE_LTE:
+		val =3D 3;
+		break;
+	}
+
+	if (m =3D=3D (OFONO_RADIO_ACCESS_MODE_UMTS|OFONO_RADIO_ACCESS_MODE_GSM)) {
+		val =3D 1;
+		p1 =3D 2;
+	}
+
+	if (m =3D=3D (OFONO_RADIO_ACCESS_MODE_LTE|OFONO_RADIO_ACCESS_MODE_UMTS)) {
+		val =3D 4;
+		p1 =3D 3;
+	}
+
+	if (m =3D=3D (OFONO_RADIO_ACCESS_MODE_LTE|OFONO_RADIO_ACCESS_MODE_GSM)) {
+		val =3D 5;
+		p1 =3D 3;
+	}
+
+	if (val =3D=3D 6)
+		snprintf(buf, sizeof(buf), "AT^SXRAT=3D%u,%u,%u", val, p1, p2);
+	else if (val =3D=3D 1 || val =3D=3D 4 || val =3D=3D 5)
+		snprintf(buf, sizeof(buf), "AT^SXRAT=3D%u,%u", val, p1);
+	else
+		snprintf(buf, sizeof(buf), "AT^SXRAT=3D%u", val);
+
+	if (g_at_chat_send(rsd->chat, buf, none_prefix,
+				sxrat_modify_cb, cbd, g_free) > 0)
+		return;
+
+	CALLBACK_WITH_FAILURE(cb, data);
+	g_free(cbd);
+}
+
+static void sxrat_support_cb(gboolean ok, GAtResult *result, gpointer user=
_data)
+{
+	struct ofono_radio_settings *rs =3D user_data;
+
+	DBG("ok %d", ok);
+
+	if (!ok) {
+		ofono_radio_settings_remove(rs);
+		return;
+	}
+
+	ofono_radio_settings_register(rs);
+}
+
+static int gemalto_radio_settings_probe(struct ofono_radio_settings *rs,
+					unsigned int vendor, void *data)
+{
+	GAtChat *chat =3D data;
+	struct radio_settings_data *rsd;
+
+	DBG("");
+
+	rsd =3D g_new0(struct radio_settings_data, 1);
+
+	rsd->chat =3D g_at_chat_clone(chat);
+
+	ofono_radio_settings_set_data(rs, rsd);
+
+	g_at_chat_send(rsd->chat, "AT^SXRAT=3D?", sxrat_prefix,
+			sxrat_support_cb, rs, NULL);
+
+	return 0;
+}
+
+static void gemalto_radio_settings_remove(struct ofono_radio_settings *rs)
+{
+	struct radio_settings_data *rsd =3D ofono_radio_settings_get_data(rs);
+
+	DBG("");
+
+	ofono_radio_settings_set_data(rs, NULL);
+	g_at_chat_unref(rsd->chat);
+	g_free(rsd);
+}
+
+static const struct ofono_radio_settings_driver driver =3D {
+	.name			=3D "gemaltomodem",
+	.probe			=3D gemalto_radio_settings_probe,
+	.remove			=3D gemalto_radio_settings_remove,
+	.query_rat_mode		=3D gemalto_query_rat_mode,
+	.set_rat_mode		=3D gemalto_set_rat_mode
+};
+
+void gemalto_radio_settings_init(void)
+{
+	ofono_radio_settings_driver_register(&driver);
+}
+
+void gemalto_radio_settings_exit(void)
+{
+	ofono_radio_settings_driver_unregister(&driver);
+}
--===============6507377714660465308==--

