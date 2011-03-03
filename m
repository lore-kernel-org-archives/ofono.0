Content-Type: multipart/mixed; boundary="===============2523811402309035756=="
MIME-Version: 1.0
From: Andras Domokos <Andras.Domokos@nokia.com>
Subject: [RFC PATCH 1/3] ssn: remove SSN atom completely
Date: Thu, 03 Mar 2011 18:48:05 +0200
Message-ID: <1e15cdd245725a5a12b25ba6b3b0cc8d66792399.1299168583.git.Andras.Domokos@nokia.com>
In-Reply-To: <cover.1299168583.git.Andras.Domokos@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2523811402309035756==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 Makefile.am                 |    6 +-
 drivers/atmodem/atmodem.c   |    2 -
 drivers/atmodem/atmodem.h   |    3 -
 drivers/atmodem/ssn.c       |  147 -------------------------
 drivers/isimodem/isimodem.c |    2 -
 drivers/isimodem/isimodem.h |    3 -
 drivers/isimodem/ssn.c      |   95 -----------------
 include/ssn.h               |   61 -----------
 plugins/calypso.c           |    2 -
 plugins/g1.c                |    2 -
 plugins/huawei.c            |    2 -
 plugins/ifx.c               |    2 -
 plugins/isiusb.c            |    2 -
 plugins/linktop.c           |    2 -
 plugins/n900.c              |    2 -
 plugins/phonesim.c          |    2 -
 plugins/ste.c               |    2 -
 plugins/tc65.c              |    2 -
 plugins/u8500.c             |    2 -
 plugins/wavecom.c           |    2 -
 src/ofono.h                 |   17 ---
 src/ssn.c                   |  247 ---------------------------------------=
----
 22 files changed, 2 insertions(+), 605 deletions(-)
 delete mode 100644 drivers/atmodem/ssn.c
 delete mode 100644 drivers/isimodem/ssn.c
 delete mode 100644 include/ssn.h
 delete mode 100644 src/ssn.c

diff --git a/Makefile.am b/Makefile.am
index 3f20717..b607b0d 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -5,7 +5,7 @@ pkginclude_HEADERS =3D include/log.h include/plugin.h inclu=
de/history.h \
 			include/dbus.h include/modem.h include/types.h \
 			include/call-barring.h include/call-forwarding.h \
 			include/call-meter.h include/call-settings.h \
-			include/phonebook.h include/ssn.h include/ussd.h \
+			include/phonebook.h include/ussd.h \
 			include/sms.h include/sim.h include/message-waiting.h \
 			include/netreg.h include/voicecall.h include/devinfo.h \
 			include/cbs.h include/call-volume.h \
@@ -126,7 +126,6 @@ builtin_sources +=3D $(gisi_sources) \
 				drivers/isimodem/cbs.c \
 				drivers/isimodem/sim.c \
 				drivers/isimodem/sim.h \
-				drivers/isimodem/ssn.c \
 				drivers/isimodem/ussd.c \
 				drivers/isimodem/call-forwarding.c \
 				drivers/isimodem/call-settings.c \
@@ -172,7 +171,6 @@ builtin_sources +=3D $(gatchat_sources) \
 				drivers/atmodem/voicecall.c \
 				drivers/atmodem/call-barring.c \
 				drivers/atmodem/phonebook.c \
-				drivers/atmodem/ssn.c \
 				drivers/atmodem/devinfo.c \
 				drivers/atmodem/call-volume.c \
 				drivers/atmodem/vendor.h \
@@ -372,7 +370,7 @@ src_ofonod_SOURCES =3D $(gdbus_sources) $(builtin_sourc=
es) src/ofono.ver \
 			src/network.c src/voicecall.c src/ussd.c src/sms.c \
 			src/call-settings.c src/call-forwarding.c \
 			src/call-meter.c src/smsutil.h src/smsutil.c \
-			src/ssn.c src/call-barring.c src/sim.c src/stk.c \
+			src/call-barring.c src/sim.c src/stk.c \
 			src/phonebook.c src/history.c src/message-waiting.c \
 			src/simutil.h src/simutil.c src/storage.h \
 			src/storage.c src/cbs.c src/watch.c src/call-volume.c \
diff --git a/drivers/atmodem/atmodem.c b/drivers/atmodem/atmodem.c
index e140281..ce6c10a 100644
--- a/drivers/atmodem/atmodem.c
+++ b/drivers/atmodem/atmodem.c
@@ -41,7 +41,6 @@ static int atmodem_init(void)
 	at_call_meter_init();
 	at_call_settings_init();
 	at_phonebook_init();
-	at_ssn_init();
 	at_ussd_init();
 	at_sms_init();
 	at_sim_init();
@@ -63,7 +62,6 @@ static void atmodem_exit(void)
 	at_sim_exit();
 	at_sms_exit();
 	at_ussd_exit();
-	at_ssn_exit();
 	at_phonebook_exit();
 	at_call_settings_exit();
 	at_call_meter_exit();
diff --git a/drivers/atmodem/atmodem.h b/drivers/atmodem/atmodem.h
index 1b7cf67..a6720d1 100644
--- a/drivers/atmodem/atmodem.h
+++ b/drivers/atmodem/atmodem.h
@@ -54,9 +54,6 @@ extern void at_sms_exit(void);
 extern void at_phonebook_init(void);
 extern void at_phonebook_exit(void);
 =

-extern void at_ssn_init(void);
-extern void at_ssn_exit(void);
-
 extern void at_devinfo_init(void);
 extern void at_devinfo_exit(void);
 =

diff --git a/drivers/atmodem/ssn.c b/drivers/atmodem/ssn.c
deleted file mode 100644
index b7a9df4..0000000
--- a/drivers/atmodem/ssn.c
+++ /dev/null
@@ -1,147 +0,0 @@
-/*
- *
- *  oFono - Open Source Telephony
- *
- *  Copyright (C) 2008-2010  Intel Corporation. All rights reserved.
- *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License version 2 as
- *  published by the Free Software Foundation.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *  GNU General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, write to the Free Software
- *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301 =
 USA
- *
- */
-
-#ifdef HAVE_CONFIG_H
-#include <config.h>
-#endif
-
-#define _GNU_SOURCE
-#include <string.h>
-
-#include <glib.h>
-
-#include <ofono/log.h>
-#include <ofono/modem.h>
-#include <ofono/ssn.h>
-
-#include "gatchat.h"
-#include "gatresult.h"
-
-#include "atmodem.h"
-
-static const char *none_prefix[] =3D { NULL };
-
-static void cssi_notify(GAtResult *result, gpointer user_data)
-{
-	struct ofono_ssn *ssn =3D user_data;
-	GAtResultIter iter;
-	int code1, index;
-
-	g_at_result_iter_init(&iter, result);
-
-	if (!g_at_result_iter_next(&iter, "+CSSI:"))
-		return;
-
-	if (!g_at_result_iter_next_number(&iter, &code1))
-		return;
-
-	if (!g_at_result_iter_next_number(&iter, &index))
-		index =3D 0;
-
-	ofono_ssn_cssi_notify(ssn, code1, index);
-}
-
-static void cssu_notify(GAtResult *result, gpointer user_data)
-{
-	struct ofono_ssn *ssn =3D user_data;
-	GAtResultIter iter;
-	int code2;
-	int index =3D -1;
-	const char *num;
-	struct ofono_phone_number ph;
-
-	ph.number[0] =3D '\0';
-	ph.type =3D 129;
-
-	g_at_result_iter_init(&iter, result);
-
-	if (!g_at_result_iter_next(&iter, "+CSSU:"))
-		return;
-
-	if (!g_at_result_iter_next_number(&iter, &code2))
-		return;
-
-	/* This field is optional, if we can't read it, try to skip it */
-	if (!g_at_result_iter_next_number(&iter, &index) &&
-			!g_at_result_iter_skip_next(&iter))
-		goto out;
-
-	if (!g_at_result_iter_next_string(&iter, &num))
-		goto out;
-
-	strncpy(ph.number, num, OFONO_MAX_PHONE_NUMBER_LENGTH);
-
-	if (!g_at_result_iter_next_number(&iter, &ph.type))
-		return;
-
-out:
-	ofono_ssn_cssu_notify(ssn, code2, index, &ph);
-}
-
-static void at_ssn_initialized(gboolean ok, GAtResult *result,
-				gpointer user_data)
-{
-	struct ofono_ssn *ssn =3D user_data;
-	GAtChat *chat =3D ofono_ssn_get_data(ssn);
-
-	g_at_chat_register(chat, "+CSSI:", cssi_notify, FALSE, ssn, NULL);
-	g_at_chat_register(chat, "+CSSU:", cssu_notify, FALSE, ssn, NULL);
-
-	ofono_ssn_register(ssn);
-}
-
-static int at_ssn_probe(struct ofono_ssn *ssn, unsigned int vendor,
-				void *data)
-{
-	GAtChat *chat =3D data;
-
-	chat =3D g_at_chat_clone(chat);
-
-	ofono_ssn_set_data(ssn, chat);
-	g_at_chat_send(chat, "AT+CSSN=3D1,1", none_prefix,
-			at_ssn_initialized, ssn, NULL);
-
-	return 0;
-}
-
-static void at_ssn_remove(struct ofono_ssn *ssn)
-{
-	GAtChat *chat =3D ofono_ssn_get_data(ssn);
-
-	g_at_chat_unref(chat);
-	ofono_ssn_set_data(ssn, NULL);
-}
-
-static struct ofono_ssn_driver driver =3D {
-	.name =3D "atmodem",
-	.probe =3D at_ssn_probe,
-	.remove =3D at_ssn_remove,
-};
-
-void at_ssn_init(void)
-{
-	ofono_ssn_driver_register(&driver);
-}
-
-void at_ssn_exit(void)
-{
-	ofono_ssn_driver_unregister(&driver);
-}
diff --git a/drivers/isimodem/isimodem.c b/drivers/isimodem/isimodem.c
index ba5cd54..1e3d3f3 100644
--- a/drivers/isimodem/isimodem.c
+++ b/drivers/isimodem/isimodem.c
@@ -44,7 +44,6 @@ static int isimodem_init(void)
 	isi_sms_init();
 	isi_cbs_init();
 	isi_sim_init();
-	isi_ssn_init();
 	isi_ussd_init();
 	isi_call_forwarding_init();
 	isi_call_settings_init();
@@ -67,7 +66,6 @@ static void isimodem_exit(void)
 	isi_sms_exit();
 	isi_cbs_exit();
 	isi_sim_exit();
-	isi_ssn_exit();
 	isi_ussd_exit();
 	isi_call_forwarding_exit();
 	isi_call_settings_exit();
diff --git a/drivers/isimodem/isimodem.h b/drivers/isimodem/isimodem.h
index ed64f9d..f5e1657 100644
--- a/drivers/isimodem/isimodem.h
+++ b/drivers/isimodem/isimodem.h
@@ -43,9 +43,6 @@ extern void isi_sim_exit(void);
 extern void isi_ussd_init(void);
 extern void isi_ussd_exit(void);
 =

-extern void isi_ssn_init(void);
-extern void isi_ssn_exit(void);
-
 extern void isi_call_forwarding_init(void);
 extern void isi_call_forwarding_exit(void);
 =

diff --git a/drivers/isimodem/ssn.c b/drivers/isimodem/ssn.c
deleted file mode 100644
index 068e5e8..0000000
--- a/drivers/isimodem/ssn.c
+++ /dev/null
@@ -1,95 +0,0 @@
-/*
- *
- *  oFono - Open Source Telephony
- *
- *  Copyright (C) 2009-2010 Nokia Corporation and/or its subsidiary(-ies).
- *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License version 2 as
- *  published by the Free Software Foundation.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *  GNU General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, write to the Free Software
- *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301 =
 USA
- *
- */
-
-#ifdef HAVE_CONFIG_H
-#include <config.h>
-#endif
-
-#define _GNU_SOURCE
-#include <stdio.h>
-#include <stdlib.h>
-#include <string.h>
-#include <errno.h>
-
-#include <glib.h>
-
-#include <gisi/client.h>
-
-#include <ofono/log.h>
-#include <ofono/modem.h>
-#include <ofono/ssn.h>
-
-#include "isimodem.h"
-#include "ss.h"
-
-struct ssn_data {
-	GIsiClient *client;
-};
-
-static int isi_ssn_probe(struct ofono_ssn *ssn, unsigned int vendor,
-				void *user)
-{
-	GIsiModem *modem =3D user;
-	struct ssn_data *sd;
-
-	sd =3D g_try_new0(struct ssn_data, 1);
-	if (sd =3D=3D NULL)
-		return -ENOMEM;
-
-	sd->client =3D g_isi_client_create(modem, PN_SS);
-	if (sd->client =3D=3D NULL) {
-		g_free(sd);
-		return -ENOMEM;
-	}
-
-	ofono_ssn_set_data(ssn, sd);
-
-	return 0;
-}
-
-static void isi_ssn_remove(struct ofono_ssn *ssn)
-{
-	struct ssn_data *data =3D ofono_ssn_get_data(ssn);
-
-	ofono_ssn_set_data(ssn, NULL);
-
-	if (data =3D=3D NULL)
-		return;
-
-	g_isi_client_destroy(data->client);
-	g_free(data);
-}
-
-static struct ofono_ssn_driver driver =3D {
-	.name			=3D "isimodem",
-	.probe			=3D isi_ssn_probe,
-	.remove			=3D isi_ssn_remove
-};
-
-void isi_ssn_init(void)
-{
-	ofono_ssn_driver_register(&driver);
-}
-
-void isi_ssn_exit(void)
-{
-	ofono_ssn_driver_unregister(&driver);
-}
diff --git a/include/ssn.h b/include/ssn.h
deleted file mode 100644
index d640cad..0000000
--- a/include/ssn.h
+++ /dev/null
@@ -1,61 +0,0 @@
-/*
- *
- *  oFono - Open Source Telephony
- *
- *  Copyright (C) 2008-2010  Intel Corporation. All rights reserved.
- *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License version 2 as
- *  published by the Free Software Foundation.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *  GNU General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, write to the Free Software
- *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301 =
 USA
- *
- */
-
-#ifndef __OFONO_SSN_H
-#define __OFONO_SSN_H
-
-#ifdef __cplusplus
-extern "C" {
-#endif
-
-#include <ofono/types.h>
-
-struct ofono_ssn;
-
-struct ofono_ssn_driver {
-	const char *name;
-	int (*probe)(struct ofono_ssn *ssn, unsigned int vendor, void *data);
-	void (*remove)(struct ofono_ssn *ssn);
-};
-
-/* SSN notifications (CSSI and CSSU).  */
-void ofono_ssn_cssi_notify(struct ofono_ssn *ssn, int code, int index);
-void ofono_ssn_cssu_notify(struct ofono_ssn *ssn, int code, int index,
-				const struct ofono_phone_number *number);
-
-int ofono_ssn_driver_register(const struct ofono_ssn_driver *d);
-void ofono_ssn_driver_unregister(const struct ofono_ssn_driver *d);
-
-struct ofono_ssn *ofono_ssn_create(struct ofono_modem *modem,
-					unsigned int vendor,
-					const char *driver, void *data);
-
-void ofono_ssn_register(struct ofono_ssn *ssn);
-void ofono_ssn_remove(struct ofono_ssn *ssn);
-
-void ofono_ssn_set_data(struct ofono_ssn *ssn, void *data);
-void *ofono_ssn_get_data(struct ofono_ssn *ssn);
-
-#ifdef __cplusplus
-}
-#endif
-
-#endif /* __OFONO_SSN_H */
diff --git a/plugins/calypso.c b/plugins/calypso.c
index 0e29256..e014581 100644
--- a/plugins/calypso.c
+++ b/plugins/calypso.c
@@ -52,7 +52,6 @@
 #include <ofono/phonebook.h>
 #include <ofono/sim.h>
 #include <ofono/sms.h>
-#include <ofono/ssn.h>
 #include <ofono/ussd.h>
 #include <ofono/voicecall.h>
 #include <ofono/stk.h>
@@ -534,7 +533,6 @@ static void calypso_post_sim(struct ofono_modem *modem)
 				data->dlcs[NETREG_DLC]);
 	ofono_call_meter_create(modem, 0, "atmodem", data->dlcs[AUX_DLC]);
 	ofono_call_barring_create(modem, 0, "atmodem", data->dlcs[AUX_DLC]);
-	ofono_ssn_create(modem, 0, "atmodem", data->dlcs[AUX_DLC]);
 	ofono_call_volume_create(modem, 0, "atmodem", data->dlcs[AUX_DLC]);
 =

 	mw =3D ofono_message_waiting_create(modem);
diff --git a/plugins/g1.c b/plugins/g1.c
index 22bacdc..b882463 100644
--- a/plugins/g1.c
+++ b/plugins/g1.c
@@ -45,7 +45,6 @@
 #include <ofono/phonebook.h>
 #include <ofono/sim.h>
 #include <ofono/sms.h>
-#include <ofono/ssn.h>
 #include <ofono/ussd.h>
 #include <ofono/voicecall.h>
 =

@@ -184,7 +183,6 @@ static void g1_post_sim(struct ofono_modem *modem)
 	ofono_netreg_create(modem, 0, "atmodem", chat);
 	ofono_call_meter_create(modem, 0, "atmodem", chat);
 	ofono_call_barring_create(modem, 0, "atmodem", chat);
-	ofono_ssn_create(modem, 0, "atmodem", chat);
 	ofono_sms_create(modem, OFONO_VENDOR_QUALCOMM_MSM, "atmodem", chat);
 	ofono_phonebook_create(modem, 0, "atmodem", chat);
 =

diff --git a/plugins/huawei.c b/plugins/huawei.c
index 6f05677..e33716d 100644
--- a/plugins/huawei.c
+++ b/plugins/huawei.c
@@ -48,7 +48,6 @@
 #include <ofono/call-forwarding.h>
 #include <ofono/call-settings.h>
 #include <ofono/call-barring.h>
-#include <ofono/ssn.h>
 #include <ofono/phonebook.h>
 #include <ofono/message-waiting.h>
 #include <ofono/log.h>
@@ -685,7 +684,6 @@ static void huawei_post_online(struct ofono_modem *mode=
m)
 		ofono_call_forwarding_create(modem, 0, "atmodem", data->pcui);
 		ofono_call_settings_create(modem, 0, "atmodem", data->pcui);
 		ofono_call_barring_create(modem, 0, "atmodem", data->pcui);
-		ofono_ssn_create(modem, 0, "atmodem", data->pcui);
 =

 		mw =3D ofono_message_waiting_create(modem);
 		if (mw)
diff --git a/plugins/ifx.c b/plugins/ifx.c
index 527a8c4..37cd2bb 100644
--- a/plugins/ifx.c
+++ b/plugins/ifx.c
@@ -47,7 +47,6 @@
 #include <ofono/call-settings.h>
 #include <ofono/call-volume.h>
 #include <ofono/message-waiting.h>
-#include <ofono/ssn.h>
 #include <ofono/sim.h>
 #include <ofono/cbs.h>
 #include <ofono/sms.h>
@@ -717,7 +716,6 @@ static void ifx_post_online(struct ofono_modem *modem)
 	ofono_cbs_create(modem, 0, "atmodem", data->dlcs[AUX_DLC]);
 	ofono_ussd_create(modem, 0, "atmodem", data->dlcs[AUX_DLC]);
 =

-	ofono_ssn_create(modem, 0, "atmodem", data->dlcs[AUX_DLC]);
 	ofono_call_settings_create(modem, 0, "atmodem", data->dlcs[AUX_DLC]);
 	ofono_call_meter_create(modem, 0, "atmodem", data->dlcs[AUX_DLC]);
 	ofono_call_barring_create(modem, 0, "atmodem", data->dlcs[AUX_DLC]);
diff --git a/plugins/isiusb.c b/plugins/isiusb.c
index c036604..0a7a234 100644
--- a/plugins/isiusb.c
+++ b/plugins/isiusb.c
@@ -46,7 +46,6 @@
 #include <ofono/cbs.h>
 #include <ofono/sim.h>
 #include <ofono/ussd.h>
-#include <ofono/ssn.h>
 #include <ofono/call-forwarding.h>
 #include <ofono/call-settings.h>
 #include <ofono/call-barring.h>
@@ -428,7 +427,6 @@ static void isiusb_post_online(struct ofono_modem *mode=
m)
 	ofono_netreg_create(modem, 0, "wgmodem2.5", isi->modem);
 	ofono_sms_create(modem, 0, "isimodem", isi->modem);
 	ofono_cbs_create(modem, 0, "isimodem", isi->modem);
-	ofono_ssn_create(modem, 0, "isimodem", isi->modem);
 	ofono_ussd_create(modem, 0, "isimodem", isi->modem);
 	ofono_call_settings_create(modem, 0, "isimodem", isi->modem);
 	ofono_call_barring_create(modem, 0, "isimodem", isi->modem);
diff --git a/plugins/linktop.c b/plugins/linktop.c
index 2fb3896..953f634 100644
--- a/plugins/linktop.c
+++ b/plugins/linktop.c
@@ -44,7 +44,6 @@
 #include <ofono/sim.h>
 #include <ofono/cbs.h>
 #include <ofono/sms.h>
-#include <ofono/ssn.h>
 #include <ofono/ussd.h>
 #include <ofono/call-volume.h>
 #include <ofono/voicecall.h>
@@ -313,7 +312,6 @@ static void linktop_post_online(struct ofono_modem *mod=
em)
 	ofono_netreg_create(modem, OFONO_VENDOR_MBM, "atmodem", data->control);
 	ofono_call_meter_create(modem, 0, "atmodem", data->control);
 	ofono_call_barring_create(modem, 0, "atmodem", data->control);
-	ofono_ssn_create(modem, 0, "atmodem", data->control);
 	ofono_call_volume_create(modem, 0, "atmodem", data->control);
 	ofono_cbs_create(modem, 0, "atmodem", data->control);
 =

diff --git a/plugins/n900.c b/plugins/n900.c
index c685266..b6af2cb 100644
--- a/plugins/n900.c
+++ b/plugins/n900.c
@@ -45,7 +45,6 @@
 #include <ofono/cbs.h>
 #include <ofono/sim.h>
 #include <ofono/ussd.h>
-#include <ofono/ssn.h>
 #include <ofono/call-forwarding.h>
 #include <ofono/call-settings.h>
 #include <ofono/call-barring.h>
@@ -509,7 +508,6 @@ static void n900_post_online(struct ofono_modem *modem)
 	ofono_netreg_create(modem, 0, "isimodem", isi->modem);
 	ofono_sms_create(modem, 0, "isimodem", isi->modem);
 	ofono_cbs_create(modem, 0, "isimodem", isi->modem);
-	ofono_ssn_create(modem, 0, "isimodem", isi->modem);
 	ofono_ussd_create(modem, 0, "isimodem", isi->modem);
 	ofono_call_settings_create(modem, 0, "isimodem", isi->modem);
 	ofono_call_barring_create(modem, 0, "isimodem", isi->modem);
diff --git a/plugins/phonesim.c b/plugins/phonesim.c
index 2b36fe0..76832dd 100644
--- a/plugins/phonesim.c
+++ b/plugins/phonesim.c
@@ -54,7 +54,6 @@
 #include <ofono/sim.h>
 #include <ofono/stk.h>
 #include <ofono/sms.h>
-#include <ofono/ssn.h>
 #include <ofono/ussd.h>
 #include <ofono/voicecall.h>
 #include <ofono/gprs.h>
@@ -651,7 +650,6 @@ static void phonesim_post_online(struct ofono_modem *mo=
dem)
 =

 	ofono_call_meter_create(modem, 0, "atmodem", data->chat);
 	ofono_call_barring_create(modem, 0, "atmodem", data->chat);
-	ofono_ssn_create(modem, 0, "atmodem", data->chat);
 	ofono_call_volume_create(modem, 0, "atmodem", data->chat);
 =

 	if (!data->calypso)
diff --git a/plugins/ste.c b/plugins/ste.c
index b786571..81a3a29 100644
--- a/plugins/ste.c
+++ b/plugins/ste.c
@@ -50,7 +50,6 @@
 #include <ofono/sim.h>
 #include <ofono/cbs.h>
 #include <ofono/sms.h>
-#include <ofono/ssn.h>
 #include <ofono/ussd.h>
 #include <ofono/call-volume.h>
 #include <ofono/voicecall.h>
@@ -430,7 +429,6 @@ static void ste_post_online(struct ofono_modem *modem)
 	ofono_netreg_create(modem, OFONO_VENDOR_MBM, "atmodem", data->chat);
 	ofono_call_meter_create(modem, 0, "atmodem", data->chat);
 	ofono_call_barring_create(modem, 0, "atmodem", data->chat);
-	ofono_ssn_create(modem, 0, "atmodem", data->chat);
 	ofono_call_volume_create(modem, 0, "atmodem", data->chat);
 	ofono_cbs_create(modem, 0, "atmodem", data->chat);
 =

diff --git a/plugins/tc65.c b/plugins/tc65.c
index f58f33d..257113e 100644
--- a/plugins/tc65.c
+++ b/plugins/tc65.c
@@ -44,7 +44,6 @@
 #include <ofono/phonebook.h>
 #include <ofono/sim.h>
 #include <ofono/sms.h>
-#include <ofono/ssn.h>
 #include <ofono/ussd.h>
 #include <ofono/voicecall.h>
 =

@@ -208,7 +207,6 @@ static void tc65_post_online(struct ofono_modem *modem)
 	ofono_netreg_create(modem, 0, "atmodem", chat);
 	ofono_call_meter_create(modem, 0, "atmodem", chat);
 	ofono_call_barring_create(modem, 0, "atmodem", chat);
-	ofono_ssn_create(modem, 0, "atmodem", chat);
 =

 	gprs =3D ofono_gprs_create(modem, 0, "atmodem", chat);
 	gc =3D ofono_gprs_context_create(modem, 0, "atmodem", chat);
diff --git a/plugins/u8500.c b/plugins/u8500.c
index eb142b4..3ee18e7 100644
--- a/plugins/u8500.c
+++ b/plugins/u8500.c
@@ -48,7 +48,6 @@
 #include <ofono/cbs.h>
 #include <ofono/sim.h>
 #include <ofono/ussd.h>
-#include <ofono/ssn.h>
 #include <ofono/call-forwarding.h>
 #include <ofono/call-settings.h>
 #include <ofono/call-barring.h>
@@ -460,7 +459,6 @@ static void u8500_post_online(struct ofono_modem *modem)
 	ofono_netreg_create(modem, 0, "wgmodem2.5", isi->modem);
 	ofono_sms_create(modem, 0, "isimodem", isi->modem);
 	ofono_cbs_create(modem, 0, "isimodem", isi->modem);
-	ofono_ssn_create(modem, 0, "isimodem", isi->modem);
 	ofono_ussd_create(modem, 0, "isimodem", isi->modem);
 	ofono_call_settings_create(modem, 0, "isimodem", isi->modem);
 	ofono_call_barring_create(modem, 0, "isimodem", isi->modem);
diff --git a/plugins/wavecom.c b/plugins/wavecom.c
index cb55f85..4d234e4 100644
--- a/plugins/wavecom.c
+++ b/plugins/wavecom.c
@@ -44,7 +44,6 @@
 #include <ofono/phonebook.h>
 #include <ofono/sim.h>
 #include <ofono/sms.h>
-#include <ofono/ssn.h>
 #include <ofono/ussd.h>
 #include <ofono/voicecall.h>
 =

@@ -156,7 +155,6 @@ static void wavecom_post_sim(struct ofono_modem *modem)
 	ofono_netreg_create(modem, 0, "atmodem", chat);
 	ofono_call_meter_create(modem, 0, "atmodem", chat);
 	ofono_call_barring_create(modem, 0, "atmodem", chat);
-	ofono_ssn_create(modem, 0, "atmodem", chat);
 	ofono_sms_create(modem, 0, "atmodem", chat);
 	ofono_phonebook_create(modem, 0, "atmodem", chat);
 =

diff --git a/src/ofono.h b/src/ofono.h
index 995a1a5..1628df3 100644
--- a/src/ofono.h
+++ b/src/ofono.h
@@ -346,23 +346,6 @@ struct sms;
 int __ofono_sms_sim_download(struct ofono_stk *stk, const struct sms *msg,
 				__ofono_sms_sim_download_cb_t cb, void *data);
 =

-#include <ofono/ssn.h>
-
-typedef void (*ofono_ssn_mo_notify_cb)(int index, void *user);
-typedef void (*ofono_ssn_mt_notify_cb)(int index,
-					const struct ofono_phone_number *ph,
-					void *user);
-
-unsigned int __ofono_ssn_mo_watch_add(struct ofono_ssn *ssn, int code1,
-					ofono_ssn_mo_notify_cb cb, void *user,
-					ofono_destroy_func destroy);
-gboolean __ofono_ssn_mo_watch_remove(struct ofono_ssn *ssn, unsigned int i=
d);
-
-unsigned int __ofono_ssn_mt_watch_add(struct ofono_ssn *ssn, int code2,
-					ofono_ssn_mt_notify_cb cb, void *user,
-					ofono_destroy_func destroy);
-gboolean __ofono_ssn_mt_watch_remove(struct ofono_ssn *ssn, unsigned int i=
d);
-
 #include <ofono/ussd.h>
 =

 typedef gboolean (*ofono_ussd_ssc_cb_t)(int type,
diff --git a/src/ssn.c b/src/ssn.c
deleted file mode 100644
index 64c94b7..0000000
--- a/src/ssn.c
+++ /dev/null
@@ -1,247 +0,0 @@
-/*
- *
- *  oFono - Open Source Telephony
- *
- *  Copyright (C) 2008-2010  Intel Corporation. All rights reserved.
- *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License version 2 as
- *  published by the Free Software Foundation.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *  GNU General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, write to the Free Software
- *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301 =
 USA
- *
- */
-
-#ifdef HAVE_CONFIG_H
-#include <config.h>
-#endif
-
-#include <string.h>
-#include <stdio.h>
-#include <errno.h>
-
-#include <glib.h>
-
-#include "ofono.h"
-
-#include "common.h"
-
-static GSList *g_drivers =3D NULL;
-
-struct ssn_handler {
-	struct ofono_watchlist_item item;
-	int code;
-};
-
-struct ofono_ssn {
-	struct ofono_watchlist *mo_handler_list;
-	struct ofono_watchlist *mt_handler_list;
-	const struct ofono_ssn_driver *driver;
-	void *driver_data;
-	struct ofono_atom *atom;
-};
-
-static unsigned int add_ssn_handler(struct ofono_watchlist *watchlist,
-					int code, void *notify, void *data,
-					ofono_destroy_func destroy)
-{
-	struct ssn_handler *handler;
-
-	if (notify =3D=3D NULL)
-		return 0;
-
-	handler =3D g_new0(struct ssn_handler, 1);
-
-	handler->code =3D code;
-	handler->item.notify =3D notify;
-	handler->item.notify_data =3D data;
-	handler->item.destroy =3D destroy;
-
-	return __ofono_watchlist_add_item(watchlist,
-				(struct ofono_watchlist_item *)handler);
-}
-
-unsigned int __ofono_ssn_mo_watch_add(struct ofono_ssn *ssn, int code1,
-					ofono_ssn_mo_notify_cb cb, void *user,
-					ofono_destroy_func destroy)
-{
-	if (ssn =3D=3D NULL)
-		return 0;
-
-	DBG("%p, %d", ssn, code1);
-
-	return add_ssn_handler(ssn->mo_handler_list, code1, cb, user, destroy);
-}
-
-gboolean __ofono_ssn_mo_watch_remove(struct ofono_ssn *ssn, unsigned int i=
d)
-{
-	if (ssn =3D=3D NULL)
-		return FALSE;
-
-	DBG("%p, %u", ssn, id);
-
-	return __ofono_watchlist_remove_item(ssn->mo_handler_list, id);
-}
-
-unsigned int __ofono_ssn_mt_watch_add(struct ofono_ssn *ssn, int code2,
-					ofono_ssn_mt_notify_cb cb, void *user,
-					ofono_destroy_func destroy)
-{
-	if (ssn =3D=3D NULL)
-		return 0;
-
-	DBG("%p, %d", ssn, code2);
-
-	return add_ssn_handler(ssn->mt_handler_list, code2, cb, user, destroy);
-}
-
-gboolean __ofono_ssn_mt_watch_remove(struct ofono_ssn *ssn, unsigned int i=
d)
-{
-	if (ssn =3D=3D NULL)
-		return FALSE;
-
-	DBG("%p, %u", ssn, id);
-
-	return __ofono_watchlist_remove_item(ssn->mt_handler_list, id);
-}
-
-void ofono_ssn_cssi_notify(struct ofono_ssn *ssn, int code1, int index)
-{
-	struct ssn_handler *h;
-	GSList *l;
-	ofono_ssn_mo_notify_cb notify;
-
-	for (l =3D ssn->mo_handler_list->items; l; l =3D l->next) {
-		h =3D l->data;
-		notify =3D h->item.notify;
-
-		if (h->code =3D=3D code1)
-			notify(index, h->item.notify_data);
-	}
-}
-
-void ofono_ssn_cssu_notify(struct ofono_ssn *ssn, int code2, int index,
-				const struct ofono_phone_number *ph)
-{
-	struct ssn_handler *h;
-	GSList *l;
-	ofono_ssn_mt_notify_cb notify;
-
-	for (l =3D ssn->mt_handler_list->items; l; l =3D l->next) {
-		h =3D l->data;
-		notify =3D h->item.notify;
-
-		if (h->code =3D=3D code2)
-			notify(index, ph, h->item.notify_data);
-	}
-}
-
-int ofono_ssn_driver_register(const struct ofono_ssn_driver *d)
-{
-	DBG("driver: %p, name: %s", d, d->name);
-
-	if (d->probe =3D=3D NULL)
-		return -EINVAL;
-
-	g_drivers =3D g_slist_prepend(g_drivers, (void *) d);
-
-	return 0;
-}
-
-void ofono_ssn_driver_unregister(const struct ofono_ssn_driver *d)
-{
-	DBG("driver: %p, name: %s", d, d->name);
-
-	g_drivers =3D g_slist_remove(g_drivers, (void *) d);
-}
-
-static void ssn_unregister(struct ofono_atom *atom)
-{
-	struct ofono_ssn *ssn =3D __ofono_atom_get_data(atom);
-
-	__ofono_watchlist_free(ssn->mo_handler_list);
-	ssn->mo_handler_list =3D NULL;
-
-	__ofono_watchlist_free(ssn->mt_handler_list);
-	ssn->mt_handler_list =3D NULL;
-}
-
-static void ssn_remove(struct ofono_atom *atom)
-{
-	struct ofono_ssn *ssn =3D __ofono_atom_get_data(atom);
-
-	DBG("atom: %p", atom);
-
-	if (ssn =3D=3D NULL)
-		return;
-
-	if (ssn->driver && ssn->driver->remove)
-		ssn->driver->remove(ssn);
-
-	g_free(ssn);
-}
-
-struct ofono_ssn *ofono_ssn_create(struct ofono_modem *modem,
-					unsigned int vendor,
-					const char *driver,
-					void *data)
-{
-	struct ofono_ssn *ssn;
-	GSList *l;
-
-	if (driver =3D=3D NULL)
-		return NULL;
-
-	ssn =3D g_try_new0(struct ofono_ssn, 1);
-
-	if (ssn =3D=3D NULL)
-		return NULL;
-
-	ssn->atom =3D __ofono_modem_add_atom(modem, OFONO_ATOM_TYPE_SSN,
-						ssn_remove, ssn);
-
-	for (l =3D g_drivers; l; l =3D l->next) {
-		const struct ofono_ssn_driver *drv =3D l->data;
-
-		if (g_strcmp0(drv->name, driver))
-			continue;
-
-		if (drv->probe(ssn, vendor, data) < 0)
-			continue;
-
-		ssn->driver =3D drv;
-		break;
-	}
-
-	return ssn;
-}
-
-void ofono_ssn_register(struct ofono_ssn *ssn)
-{
-	ssn->mo_handler_list =3D __ofono_watchlist_new(g_free);
-	ssn->mt_handler_list =3D __ofono_watchlist_new(g_free);
-
-	__ofono_atom_register(ssn->atom, ssn_unregister);
-}
-
-void ofono_ssn_remove(struct ofono_ssn *ssn)
-{
-	__ofono_atom_free(ssn->atom);
-}
-
-void ofono_ssn_set_data(struct ofono_ssn *ssn, void *data)
-{
-	ssn->driver_data =3D data;
-}
-
-void *ofono_ssn_get_data(struct ofono_ssn *ssn)
-{
-	return ssn->driver_data;
-}
-- =

1.7.0.4


--===============2523811402309035756==--

