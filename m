Content-Type: multipart/mixed; boundary="===============3367383728527844424=="
MIME-Version: 1.0
From: KrzysztofX Wilk <krzysztofx.wilk@intel.com>
Subject: [PATCH 5/8] siri: Add atom driver
Date: Mon, 16 Dec 2013 17:52:41 +0000
Message-ID: <1387216364-7138-6-git-send-email-krzysztofx.wilk@intel.com>
In-Reply-To: <1387216364-7138-1-git-send-email-krzysztofx.wilk@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3367383728527844424==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 Makefile.am                 |   3 +-
 drivers/hfpmodem/hfpmodem.c |   2 +
 drivers/hfpmodem/hfpmodem.h |   3 +
 drivers/hfpmodem/siri.c     | 215 ++++++++++++++++++++++++++++++++++++++++=
++++
 4 files changed, 222 insertions(+), 1 deletion(-)
 mode change 100644 =3D> 100755 drivers/hfpmodem/hfpmodem.c
 mode change 100644 =3D> 100755 drivers/hfpmodem/hfpmodem.h
 create mode 100755 drivers/hfpmodem/siri.c

diff --git a/Makefile.am b/Makefile.am
index 371018e..37edf95 100755
--- a/Makefile.am
+++ b/Makefile.am
@@ -315,7 +315,8 @@ builtin_sources +=3D drivers/atmodem/atutil.h \
 			drivers/hfpmodem/network-registration.c \
 			drivers/hfpmodem/call-volume.c \
 			drivers/hfpmodem/devinfo.c \
-			drivers/hfpmodem/handsfree.c
+			drivers/hfpmodem/handsfree.c \
+			drivers/hfpmodem/siri.c
 =

 builtin_modules +=3D speedupmodem
 builtin_sources +=3D drivers/atmodem/atutil.h \
diff --git a/drivers/hfpmodem/hfpmodem.c b/drivers/hfpmodem/hfpmodem.c
old mode 100644
new mode 100755
index 1348beb..1f604ac
--- a/drivers/hfpmodem/hfpmodem.c
+++ b/drivers/hfpmodem/hfpmodem.c
@@ -39,6 +39,7 @@ static int hfpmodem_init(void)
 	hfp_netreg_init();
 	hfp_call_volume_init();
 	hfp_handsfree_init();
+	hfp_siri_init();
 =

 	return 0;
 }
@@ -50,6 +51,7 @@ static void hfpmodem_exit(void)
 	hfp_netreg_exit();
 	hfp_call_volume_exit();
 	hfp_handsfree_exit();
+	hfp_siri_exit();
 }
 =

 OFONO_PLUGIN_DEFINE(hfpmodem, "Hands-Free Profile Driver", VERSION,
diff --git a/drivers/hfpmodem/hfpmodem.h b/drivers/hfpmodem/hfpmodem.h
old mode 100644
new mode 100755
index ef7aea5..e10d2ec
--- a/drivers/hfpmodem/hfpmodem.h
+++ b/drivers/hfpmodem/hfpmodem.h
@@ -34,5 +34,8 @@ extern void hfp_voicecall_exit(void);
 extern void hfp_handsfree_init(void);
 extern void hfp_handsfree_exit(void);
 =

+extern void hfp_siri_init(void);
+extern void hfp_siri_exit(void);
+
 extern void hfp_devinfo_init(void);
 extern void hfp_devinfo_exit(void);
diff --git a/drivers/hfpmodem/siri.c b/drivers/hfpmodem/siri.c
new file mode 100755
index 0000000..36ef168
--- /dev/null
+++ b/drivers/hfpmodem/siri.c
@@ -0,0 +1,215 @@
+/*
+ *
+ *  oFono - Open Source Telephony
+ *
+ *  Copyright (C) 2008-2013  Intel Corporation. All rights reserved.
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
+#include <unistd.h>
+
+#include <glib.h>
+#include <gatchat.h>
+#include <gatresult.h>
+
+#include <ofono/log.h>
+#include <ofono/modem.h>
+#include <ofono/siri.h>
+
+#include "hfpmodem.h"
+#include "hfp.h"
+#include "slc.h"
+
+#define APPLE_SIRI_STATUS_FEATURE 8
+
+static const char *xapl_prefix[] =3D { "+XAPL=3D", NULL };
+static const char *aplsiri_prefix[] =3D { "+APLSIRI:", NULL };
+static const char *aplefm_prefix[] =3D { "+APLEFM:", NULL };
+
+struct siri_data
+{
+	GAtChat *chat;
+};
+
+static void aplsiri_notify(GAtResult *result, gpointer user_data)
+{
+	struct ofono_siri *siri =3D user_data;
+	GAtResultIter iter;
+	gint value;
+
+	g_at_result_iter_init(&iter, result);
+
+	if (!g_at_result_iter_next(&iter, "+APLSIRI:"))
+		return;
+
+	if (!g_at_result_iter_next_number(&iter, &value))
+		return;
+
+	ofono_siri_set_status(siri, value);
+}
+
+static void aplsiri_cb(gboolean ok, GAtResult *result, gpointer user_data)
+{
+	struct ofono_siri *siri =3D user_data;
+	struct siri_data *sd =3D ofono_siri_get_data(siri);
+	struct ofono_error error;
+	GAtResultIter iter;
+	gint value;
+
+	if (!ok)
+		goto fail;
+
+	decode_at_error(&error, g_at_result_final_response(result));
+
+	if (error.type !=3D OFONO_ERROR_TYPE_NO_ERROR)
+		goto fail;
+
+	g_at_result_iter_init(&iter, result);
+
+	if (!g_at_result_iter_next(&iter, "+APLSIRI:"))
+		goto fail;
+
+	if (!g_at_result_iter_next_number(&iter, &value))
+		goto fail;
+
+	if (value =3D=3D 0)
+		goto fail;
+
+	g_at_chat_register(sd->chat, "+APLSIRI:",
+				aplsiri_notify, FALSE, siri, NULL);
+
+	ofono_siri_register(siri);
+
+	ofono_siri_set_status(siri, value);
+
+	return;
+
+fail:
+	ofono_siri_remove(siri);
+}
+
+static void xapl_cb(gboolean ok, GAtResult *result, gpointer user_data)
+{
+	struct ofono_siri *siri =3D user_data;
+	struct siri_data *sd =3D ofono_siri_get_data(siri);
+	struct ofono_error error;
+
+	if (!ok) {
+		ofono_siri_remove(siri);
+		return;
+	}
+
+	decode_at_error(&error, g_at_result_final_response(result));
+	if (error.type !=3D OFONO_ERROR_TYPE_NO_ERROR) {
+		ofono_siri_remove(siri);
+		return;
+	}
+
+	g_at_chat_send(sd->chat, "AT+APLSIRI?",
+				aplsiri_prefix, aplsiri_cb, siri, NULL);
+}
+
+static int hfp_siri_probe(struct ofono_siri *siri, unsigned int vendor,
+				void *data)
+{
+	struct hfp_slc_info *info =3D data;
+	struct siri_data *sd;
+	char at_command[64];
+
+	DBG("");
+	sd =3D g_new0(struct siri_data, 1);
+	sd->chat =3D g_at_chat_clone(info->chat);
+
+	ofono_siri_set_data(siri, sd);
+
+	snprintf(at_command, sizeof(at_command),
+				"AT+XAPL=3DLinux-oFono-%s,%d", VERSION,
+				APPLE_SIRI_STATUS_FEATURE);
+
+	g_at_chat_send(sd->chat, at_command, xapl_prefix, xapl_cb,
+				siri, NULL);
+
+	return 0;
+}
+
+static void hfp_siri_remove(struct ofono_siri *siri)
+{
+	struct siri_data *sd =3D ofono_siri_get_data(siri);
+
+	ofono_siri_set_data(siri, NULL);
+
+	g_at_chat_unref(sd->chat);
+	g_free(sd);
+}
+
+static void hfp_siri_eyes_free_mode_cb(gboolean ok,
+				GAtResult *result, gpointer user_data)
+{
+	struct cb_data *cbd =3D user_data;
+	ofono_siri_cb_t cb =3D cbd->cb;
+	struct ofono_siri *siri =3D cbd->data;
+	struct ofono_error error;
+
+	decode_at_error(&error, g_at_result_final_response(result));
+
+	cb(&error, siri);
+}
+
+static void hfp_siri_set_eyes_free_mode(struct ofono_siri *siri,
+				ofono_siri_cb_t cb,
+				unsigned int val)
+{
+	struct siri_data *sd =3D ofono_siri_get_data(siri);
+	struct cb_data *cbd =3D cb_data_new(cb, siri);
+	char at_command[16];
+
+	snprintf(at_command, sizeof(at_command), "AT+APLEFM=3D%d", val);
+
+	if (g_at_chat_send(sd->chat, at_command, aplefm_prefix,
+				hfp_siri_eyes_free_mode_cb,
+				cbd, g_free) > 0)
+		return;
+
+	g_free(cbd);
+
+	CALLBACK_WITH_FAILURE(cb, NULL);
+}
+
+static struct ofono_siri_driver driver =3D {
+	.name =3D "hfpmodem",
+	.probe =3D hfp_siri_probe,
+	.remove =3D hfp_siri_remove,
+	.set_eyes_free_mode =3D hfp_siri_set_eyes_free_mode,
+};
+
+void hfp_siri_init(void)
+{
+	ofono_siri_driver_register(&driver);
+}
+
+void hfp_siri_exit(void)
+{
+	ofono_siri_driver_unregister(&driver);
+}
-- =

1.7.11.7


--===============3367383728527844424==--

