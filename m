Content-Type: multipart/mixed; boundary="===============7252978574808035558=="
MIME-Version: 1.0
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: [PATCH 2/6] huaweimodem: Add support for radio settings
Date: Thu, 09 Dec 2010 14:43:36 -0200
Message-ID: <1291913020-3103-2-git-send-email-lucas.demarchi@profusion.mobi>
In-Reply-To: <1291913020-3103-1-git-send-email-lucas.demarchi@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7252978574808035558==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 Makefile.am                          |    3 +-
 drivers/huaweimodem/huaweimodem.c    |    2 +
 drivers/huaweimodem/huaweimodem.h    |    3 +
 drivers/huaweimodem/radio-settings.c |  218 ++++++++++++++++++++++++++++++=
++++
 4 files changed, 225 insertions(+), 1 deletions(-)
 create mode 100644 drivers/huaweimodem/radio-settings.c

diff --git a/Makefile.am b/Makefile.am
index 881204a..1768c57 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -180,7 +180,8 @@ builtin_sources +=3D drivers/atmodem/atutil.h \
 			drivers/huaweimodem/huaweimodem.c \
 			drivers/huaweimodem/voicecall.c \
 			drivers/huaweimodem/audio-settings.c \
-			drivers/huaweimodem/gprs-context.c
+			drivers/huaweimodem/gprs-context.c \
+			drivers/huaweimodem/radio-settings.c
 =

 builtin_modules +=3D calypsomodem
 builtin_sources +=3D drivers/atmodem/atutil.h \
diff --git a/drivers/huaweimodem/huaweimodem.c b/drivers/huaweimodem/huawei=
modem.c
index c8b6522..8097a9c 100644
--- a/drivers/huaweimodem/huaweimodem.c
+++ b/drivers/huaweimodem/huaweimodem.c
@@ -36,6 +36,7 @@ static int huaweimodem_init(void)
 {
 	huawei_voicecall_init();
 	huawei_audio_settings_init();
+	huawei_radio_settings_init();
 	huawei_gprs_context_init();
 =

 	return 0;
@@ -44,6 +45,7 @@ static int huaweimodem_init(void)
 static void huaweimodem_exit(void)
 {
 	huawei_gprs_context_exit();
+	huawei_radio_settings_exit();
 	huawei_audio_settings_exit();
 	huawei_voicecall_exit();
 }
diff --git a/drivers/huaweimodem/huaweimodem.h b/drivers/huaweimodem/huawei=
modem.h
index 03d52ef..596aa08 100644
--- a/drivers/huaweimodem/huaweimodem.h
+++ b/drivers/huaweimodem/huaweimodem.h
@@ -27,5 +27,8 @@ extern void huawei_voicecall_exit();
 extern void huawei_audio_settings_init();
 extern void huawei_audio_settings_exit();
 =

+extern void huawei_radio_settings_init();
+extern void huawei_radio_settings_exit();
+
 extern void huawei_gprs_context_init();
 extern void huawei_gprs_context_exit();
diff --git a/drivers/huaweimodem/radio-settings.c b/drivers/huaweimodem/rad=
io-settings.c
new file mode 100644
index 0000000..30961da
--- /dev/null
+++ b/drivers/huaweimodem/radio-settings.c
@@ -0,0 +1,218 @@
+/*
+ *
+ *  oFono - Open Source Telephony
+ *
+ *  Copyright (C) 2010  Intel Corporation. All rights reserved.
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
+#include "huaweimodem.h"
+
+static const char *none_prefix[] =3D { NULL };
+static const char *syscfg_prefix[] =3D { "^SYSCFG:", NULL };
+
+struct radio_settings_data {
+	GAtChat *chat;
+};
+
+static void syscfg_query_cb(gboolean ok, GAtResult *result, gpointer user_=
data)
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
+	if (g_at_result_iter_next(&iter, "^SYSCFG:") =3D=3D FALSE)
+		goto error;
+
+	if (g_at_result_iter_next_number(&iter, &value) =3D=3D FALSE)
+		goto error;
+
+	switch (value) {
+	case 2:
+		mode =3D OFONO_RADIO_ACCESS_MODE_ANY;
+		break;
+	case 13:
+		mode =3D OFONO_RADIO_ACCESS_MODE_GSM;
+		break;
+	case 14:
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
+static void huawei_query_rat_mode(struct ofono_radio_settings *rs,
+			ofono_radio_settings_rat_mode_query_cb_t cb, void *data)
+{
+	struct radio_settings_data *rsd =3D ofono_radio_settings_get_data(rs);
+	struct cb_data *cbd =3D cb_data_new(cb, data);
+
+	if (g_at_chat_send(rsd->chat, "AT^SYSCFG?", syscfg_prefix,
+					syscfg_query_cb, cbd, g_free) =3D=3D 0) {
+		CALLBACK_WITH_FAILURE(cb, -1, data);
+		g_free(cbd);
+	}
+}
+
+static void syscfg_modify_cb(gboolean ok, GAtResult *result, gpointer user=
_data)
+{
+	struct cb_data *cbd =3D user_data;
+	ofono_radio_settings_rat_mode_set_cb_t cb =3D cbd->cb;
+	struct ofono_error error;
+
+	decode_at_error(&error, g_at_result_final_response(result));
+	cb(&error, cbd->data);
+}
+
+static void huawei_set_rat_mode(struct ofono_radio_settings *rs,
+				enum ofono_radio_access_mode mode,
+				ofono_radio_settings_rat_mode_set_cb_t cb,
+				void *data)
+{
+	struct radio_settings_data *rsd =3D ofono_radio_settings_get_data(rs);
+	struct cb_data *cbd =3D cb_data_new(cb, data);
+	char buf[40];
+	unsigned int value =3D 2, acq_order =3D 0;
+
+	switch (mode) {
+	case OFONO_RADIO_ACCESS_MODE_ANY:
+		value =3D 2;
+		acq_order =3D 0;
+		break;
+	case OFONO_RADIO_ACCESS_MODE_GSM:
+		value =3D 13;
+		acq_order =3D 1;
+		break;
+	case OFONO_RADIO_ACCESS_MODE_UMTS:
+		value =3D 14;
+		acq_order =3D 2;
+		break;
+	case OFONO_RADIO_ACCESS_MODE_LTE:
+		goto error;
+	}
+
+	snprintf(buf, sizeof(buf), "AT^SYSCFG=3D%u,%u,3FFFFFFF,2,4",
+			value, acq_order);
+
+	if (g_at_chat_send(rsd->chat, buf, none_prefix,
+					syscfg_modify_cb, cbd, g_free) > 0)
+		return;
+
+error:
+	CALLBACK_WITH_FAILURE(cb, data);
+	g_free(cbd);
+}
+
+static void syscfg_support_cb(gboolean ok, GAtResult *result,
+				gpointer user_data)
+{
+	struct ofono_radio_settings *rs =3D user_data;
+
+	if (!ok) {
+		ofono_radio_settings_remove(rs);
+		return;
+	}
+
+	ofono_radio_settings_register(rs);
+}
+
+static int huawei_radio_settings_probe(struct ofono_radio_settings *rs,
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
+	g_at_chat_send(rsd->chat, "AT^SYSCFG=3D?", syscfg_prefix,
+					syscfg_support_cb, rs, NULL);
+
+	return 0;
+}
+
+static void huawei_radio_settings_remove(struct ofono_radio_settings *rs)
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
+	.name			=3D "huaweimodem",
+	.probe			=3D huawei_radio_settings_probe,
+	.remove			=3D huawei_radio_settings_remove,
+	.query_rat_mode		=3D huawei_query_rat_mode,
+	.set_rat_mode		=3D huawei_set_rat_mode,
+};
+
+void huawei_radio_settings_init()
+{
+	ofono_radio_settings_driver_register(&driver);
+}
+
+void huawei_radio_settings_exit()
+{
+	ofono_radio_settings_driver_unregister(&driver);
+}
-- =

1.7.3.3


--===============7252978574808035558==--

