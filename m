Content-Type: multipart/mixed; boundary="===============7667733150799697561=="
MIME-Version: 1.0
From: Zhenhua Zhang <zhenhua.zhang@intel.com>
Subject: [PATCH 2/2] Add call volume support for hfpmodem
Date: Wed, 11 Nov 2009 21:32:30 +0800
Message-ID: <1257946350.31013.3.camel@zzhan17-mobl.ccr.corp.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7667733150799697561==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The call volume driver listens the speaker volume and microphone
gain from the AG. It also allow to synchronze the speaker and
microphone volume changes with the AG through AT+VGS and AT+VGM.
---
 Makefile.am                    |    3 +-
 drivers/hfpmodem/call-volume.c |  228
++++++++++++++++++++++++++++++++++++++++
 drivers/hfpmodem/hfpmodem.c    |    2 +
 drivers/hfpmodem/hfpmodem.h    |    3 +
 plugins/hfp.c                  |    2 +
 5 files changed, 237 insertions(+), 1 deletions(-)
 create mode 100644 drivers/hfpmodem/call-volume.c

diff --git a/Makefile.am b/Makefile.am
index c3e06b4..ae9feb9 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -127,7 +127,8 @@ builtin_sources +=3D drivers/atmodem/atutil.h \
 			drivers/hfpmodem/hfpmodem.h \
 			drivers/hfpmodem/hfpmodem.c \
 			drivers/hfpmodem/voicecall.c \
-			drivers/hfpmodem/network-registration.c
+			drivers/hfpmodem/network-registration.c \
+			drivers/hfpmodem/call-volume.c
 =

 builtin_modules +=3D mbmmodem
 builtin_sources +=3D drivers/atmodem/atutil.h \
diff --git a/drivers/hfpmodem/call-volume.c
b/drivers/hfpmodem/call-volume.c
new file mode 100644
index 0000000..9859bf6
--- /dev/null
+++ b/drivers/hfpmodem/call-volume.c
@@ -0,0 +1,228 @@
+/*
+ *
+ *  oFono - Open Source Telephony
+ *
+ *  Copyright (C) 2008-2009  Intel Corporation. All rights reserved.
+ *
+ *  This program is free software; you can redistribute it and/or
modify
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
+ *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA
02110-1301  USA
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
+
+#include <ofono/log.h>
+#include <ofono/modem.h>
+#include <ofono/call-volume.h>
+
+#include "gatchat.h"
+#include "gatresult.h"
+
+#include "hfpmodem.h"
+
+#define HFP_CALL_VOLUME_MAX 15
+
+static const char *vgs_prefix[] =3D { "+VGS:", NULL };
+static const char *vgm_prefix[] =3D { "+VGM:", NULL };
+
+struct cv_data {
+	GAtChat *chat;
+	unsigned char cind_pos[HFP_INDICATOR_LAST];
+	int cind_val[HFP_INDICATOR_LAST];
+	unsigned char sp_volume;
+	unsigned char mic_volume;
+};
+
+static void cv_generic_set_cb(gboolean ok, GAtResult *result,
+					gpointer user_data)
+{
+	struct cb_data *cbd =3D user_data;
+	ofono_call_volume_cb_t cb =3D cbd->cb;
+	struct ofono_error error;
+
+	dump_response("generic_set_cb", ok, result);
+	decode_at_error(&error, g_at_result_final_response(result));
+
+	cb(&error, cbd->data);
+}
+
+static void hfp_speaker_volume(struct ofono_call_volume *cv,
+					unsigned char percent,
+					ofono_call_volume_cb_t cb,
+					void *data)
+{
+	struct cv_data *vd =3D ofono_call_volume_get_data(data);
+	struct cb_data *cbd =3D cb_data_new(cb, data);
+	char buf[64];
+
+	if (!cbd)
+		goto error;
+
+	vd->sp_volume =3D percent;
+
+	snprintf(buf, sizeof(buf), "AT+VGS=3D%d",
+				(int)(percent*HFP_CALL_VOLUME_MAX/100));
+
+	if (g_at_chat_send(vd->chat, buf, vgs_prefix,
+				cv_generic_set_cb, cbd, g_free) > 0)
+		return;
+
+error:
+	if (cbd)
+		g_free(cbd);
+
+	CALLBACK_WITH_FAILURE(cb, data);
+}
+
+static void hfp_microphone_volume(struct ofono_call_volume *cv,
+					unsigned char percent,
+					ofono_call_volume_cb_t cb,
+					void *data)
+{
+	struct cv_data *vd =3D ofono_call_volume_get_data(data);
+	struct cb_data *cbd =3D cb_data_new(cb, data);
+	char buf[64];
+
+	if (!cbd)
+		goto error;
+
+	vd->mic_volume =3D percent;
+
+	snprintf(buf, sizeof(buf), "AT+VGM=3D%d",
+				(int)(percent*HFP_CALL_VOLUME_MAX/100));
+
+	if (g_at_chat_send(vd->chat, buf, vgm_prefix,
+				cv_generic_set_cb, cbd, g_free) > 0)
+		return;
+
+error:
+	if (cbd)
+		g_free(cbd);
+
+	CALLBACK_WITH_FAILURE(cb, data);
+}
+
+static void vgs_notify(GAtResult *result, gpointer user_data)
+{
+	struct ofono_call_volume *cv =3D user_data;
+	struct cv_data *vd =3D ofono_call_volume_get_data(cv);
+	GAtResultIter iter;
+	gint value;
+
+	g_at_result_iter_init(&iter, result);
+
+	if (!g_at_result_iter_next(&iter, "+VGS:"))
+		return;
+
+	if (!g_at_result_iter_next_number(&iter, &value))
+		return;
+
+	vd->sp_volume =3D (unsigned char)(value*100/HFP_CALL_VOLUME_MAX);
+	ofono_call_volume_set_speaker_volume(cv, vd->sp_volume);
+}
+
+static void vgm_notify(GAtResult *result, gpointer user_data)
+{
+	struct ofono_call_volume *cv =3D user_data;
+	struct cv_data *vd =3D ofono_call_volume_get_data(cv);
+	GAtResultIter iter;
+	gint value;
+
+	g_at_result_iter_init(&iter, result);
+
+	if (!g_at_result_iter_next(&iter, "+VGM:"))
+		return;
+
+	if (!g_at_result_iter_next_number(&iter, &value))
+		return;
+
+	vd->mic_volume =3D (unsigned char)(value*100/HFP_CALL_VOLUME_MAX);
+	ofono_call_volume_set_microphone_volume(cv, vd->mic_volume);
+}
+
+static void hfp_call_volume_initialized(gpointer user_data)
+{
+	struct ofono_call_volume *cv =3D user_data;
+	struct cv_data *vd =3D ofono_call_volume_get_data(cv);
+
+	DBG("");
+
+	g_at_chat_register(vd->chat, "+VGS:", vgs_notify, FALSE, cv, NULL);
+	g_at_chat_register(vd->chat, "+VGM:", vgm_notify, FALSE, cv, NULL);
+
+	ofono_call_volume_register(cv);
+
+	ofono_call_volume_set_microphone_volume(cv, vd->mic_volume);
+	ofono_call_volume_set_speaker_volume(cv, vd->sp_volume);
+}
+
+static int hfp_call_volume_probe(struct ofono_call_volume *cv,
+					unsigned int vendor, void *data)
+{
+	struct hfp_data *d =3D data;
+	struct cv_data *vd;
+
+	DBG("");
+	vd =3D g_new0(struct cv_data, 1);
+	vd->chat =3D d->chat;
+	/* set sp and mic volume at 50 percents by default */
+	vd->sp_volume =3D 50;
+	vd->mic_volume =3D 50;
+
+	memcpy(vd->cind_pos, d->cind_pos, HFP_INDICATOR_LAST);
+	memcpy(vd->cind_val, d->cind_val, HFP_INDICATOR_LAST);
+
+	ofono_call_volume_set_data(cv, vd);
+
+	hfp_call_volume_initialized(cv);
+
+	return 0;
+}
+
+static void hfp_call_volume_remove(struct ofono_call_volume *cv)
+{
+	struct cv_data *vd =3D ofono_call_volume_get_data(cv);
+
+	g_free(vd);
+}
+
+static struct ofono_call_volume_driver driver =3D {
+	.name			=3D "hfpmodem",
+	.probe			=3D hfp_call_volume_probe,
+	.remove			=3D hfp_call_volume_remove,
+	.speaker_volume		=3D hfp_speaker_volume,
+	.microphone_volume 	=3D hfp_microphone_volume,
+	.mute			=3D NULL,
+};
+
+void hfp_call_volume_init()
+{
+	ofono_call_volume_driver_register(&driver);
+}
+
+void hfp_call_volume_exit()
+{
+	ofono_call_volume_driver_unregister(&driver);
+}
+
diff --git a/drivers/hfpmodem/hfpmodem.c b/drivers/hfpmodem/hfpmodem.c
index 58ae03d..f3c7a91 100644
--- a/drivers/hfpmodem/hfpmodem.c
+++ b/drivers/hfpmodem/hfpmodem.c
@@ -43,6 +43,7 @@ static int hfpmodem_init(void)
 {
 	hfp_voicecall_init();
 	hfp_netreg_init();
+	hfp_call_volume_init();
 =

 	return 0;
 }
@@ -51,6 +52,7 @@ static void hfpmodem_exit(void)
 {
 	hfp_voicecall_exit();
 	hfp_netreg_exit();
+	hfp_call_volume_exit();
 }
 =

 OFONO_PLUGIN_DEFINE(hfpmodem, "Hands-Free Profile Driver", VERSION,
diff --git a/drivers/hfpmodem/hfpmodem.h b/drivers/hfpmodem/hfpmodem.h
index 02f5a4b..c0e4c7e 100644
--- a/drivers/hfpmodem/hfpmodem.h
+++ b/drivers/hfpmodem/hfpmodem.h
@@ -64,6 +64,9 @@ struct hfp_data {
 extern void hfp_netreg_init();
 extern void hfp_netreg_exit();
 =

+extern void hfp_call_volume_init();
+extern void hfp_call_volume_exit();
+
 extern void hfp_voicecall_init();
 extern void hfp_voicecall_exit();
 =

diff --git a/plugins/hfp.c b/plugins/hfp.c
index d696e47..fc29ad9 100644
--- a/plugins/hfp.c
+++ b/plugins/hfp.c
@@ -48,6 +48,7 @@
 #include <ofono/ssn.h>
 #include <ofono/ussd.h>
 #include <ofono/voicecall.h>
+#include <ofono/call-volume.h>
 =

 #include <drivers/hfpmodem/hfpmodem.h>
 =

@@ -313,6 +314,7 @@ static void hfp_pre_sim(struct ofono_modem *modem)
 =

 	ofono_voicecall_create(modem, 0, "hfpmodem", data);
 	ofono_netreg_create(modem, 0, "hfpmodem", data);
+	ofono_call_volume_create(modem, 0, "hfpmodem", data);
 }
 =

 static void hfp_post_sim(struct ofono_modem *modem)
-- =

1.6.2.5




--===============7667733150799697561==--

