Content-Type: multipart/mixed; boundary="===============5391058784722353450=="
MIME-Version: 1.0
From: sjur.brandeland@stericsson.com
Subject: [PATCH 2/6] STE-plugin: Add vendor STE and quirks in atmodem.
Date: Mon, 25 Jan 2010 20:25:29 +0100
Message-ID: <1264447534-2386-3-git-send-email-sjur.brandeland@stericsson.com>
In-Reply-To: <1264447534-2386-2-git-send-email-sjur.brandeland@stericsson.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5391058784722353450==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Add STE modem support in gprs.c and network-registration.c

---
 drivers/atmodem/gprs.c                 |   10 ++++-
 drivers/atmodem/network-registration.c |   78 ++++++++++++++++++++++++++++=
+++-
 drivers/atmodem/vendor.h               |    1 +
 3 files changed, 86 insertions(+), 3 deletions(-)

diff --git a/drivers/atmodem/gprs.c b/drivers/atmodem/gprs.c
index 6034c42..9a8826a 100644
--- a/drivers/atmodem/gprs.c
+++ b/drivers/atmodem/gprs.c
@@ -3,6 +3,7 @@
  *  oFono - Open Source Telephony
  *
  *  Copyright (C) 2008-2010  Intel Corporation. All rights reserved.
+ *  Copyright (C) 2010 ST-Ericsson AB.
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2 as
@@ -38,6 +39,7 @@
 #include "gatresult.h"
 =

 #include "atmodem.h"
+#include "vendor.h"
 =

 static const char *cgreg_prefix[] =3D { "+CGREG:", NULL };
 static const char *cgdcont_prefix[] =3D { "+CGDCONT:", NULL };
@@ -221,7 +223,13 @@ static void at_cgreg_test_cb(gboolean ok, GAtResult *r=
esult,
 =

 	g_at_chat_send(gd->chat, cmd, none_prefix, NULL, NULL, NULL);
 	g_at_chat_send(gd->chat, "AT+CGAUTO=3D0", none_prefix, NULL, NULL, NULL);
-	g_at_chat_send(gd->chat, "AT+CGEREP=3D2,1", none_prefix,
+
+	/* ST-E modem does not support AT+CGEREP =3D 2,1 */
+	if (gd->vendor =3D=3D OFONO_VENDOR_STE)
+		g_at_chat_send(gd->chat, "AT+CGEREP=3D1,0", none_prefix,
+			gprs_initialized, gprs, NULL);
+	else
+		g_at_chat_send(gd->chat, "AT+CGEREP=3D2,1", none_prefix,
 			gprs_initialized, gprs, NULL);
 	return;
 =

diff --git a/drivers/atmodem/network-registration.c b/drivers/atmodem/netwo=
rk-registration.c
index c80acc5..c6489b5 100644
--- a/drivers/atmodem/network-registration.c
+++ b/drivers/atmodem/network-registration.c
@@ -3,6 +3,7 @@
  *  oFono - Open Source Telephony
  *
  *  Copyright (C) 2008-2010  Intel Corporation. All rights reserved.
+ *  Copyright (C) 2010 ST-Ericsson AB.
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2 as
@@ -44,6 +45,9 @@ static const char *none_prefix[] =3D { NULL };
 static const char *creg_prefix[] =3D { "+CREG:", NULL };
 static const char *cops_prefix[] =3D { "+COPS:", NULL };
 static const char *csq_prefix[] =3D { "+CSQ:", NULL };
+static const char *cind_prefix[] =3D { "+CIND:", NULL };
+
+#define SIGNAL_STRENGTH_IND 2
 =

 struct netreg_data {
 	GAtChat *chat;
@@ -554,6 +558,64 @@ static void option_octi_notify(GAtResult *result, gpoi=
nter user_data)
 	ofono_info("OCTI mode: %d", mode);
 }
 =

+static void ste_ciev_notify(GAtResult *result, gpointer user_data)
+{
+	struct ofono_netreg *netreg =3D user_data;
+	int strength, ind;
+	GAtResultIter iter;
+
+	dump_response("ciev_notify", TRUE, result);
+
+	g_at_result_iter_init(&iter, result);
+
+	if (!g_at_result_iter_next(&iter, "+CIEV:"))
+		return;
+
+	if (!g_at_result_iter_next_number(&iter, &ind))
+		return;
+
+	if (ind =3D=3D SIGNAL_STRENGTH_IND) {
+		if (!g_at_result_iter_next_number(&iter, &strength))
+			return;
+
+		strength =3D (strength * 100) / 5;
+		ofono_netreg_strength_notify(netreg, strength);
+	}
+}
+
+static void ste_cind_cb(gboolean ok, GAtResult *result, gpointer user_data)
+{
+	struct cb_data *cbd =3D user_data;
+	ofono_netreg_strength_cb_t cb =3D cbd->cb;
+	int strength;
+	GAtResultIter iter;
+	struct ofono_error error;
+
+	dump_response("cind_cb", ok, result);
+	decode_at_error(&error, g_at_result_final_response(result));
+
+	if (!ok) {
+		cb(&error, -1, cbd->data);
+		return;
+	}
+
+	g_at_result_iter_init(&iter, result);
+
+	if (!g_at_result_iter_next(&iter, "+CIND:")) {
+		CALLBACK_WITH_FAILURE(cb, -1, cbd->data);
+		return;
+	}
+
+	/* Skip battery charge level, which is the first reported  */
+	g_at_result_iter_skip_next(&iter);
+
+	g_at_result_iter_next_number(&iter, &strength);
+
+	strength =3D (strength * 100) / 5;
+
+	cb(&error, strength, cbd->data);
+}
+
 static void option_ossysi_notify(GAtResult *result, gpointer user_data)
 {
 	int mode;
@@ -614,9 +676,15 @@ static void at_signal_strength(struct ofono_netreg *ne=
treg,
 	if (!cbd)
 		goto error;
 =

-	if (g_at_chat_send(nd->chat, "AT+CSQ", csq_prefix,
+	if (nd->vendor =3D=3D OFONO_VENDOR_STE) {
+		if (g_at_chat_send(nd->chat, "AT+CIND?", cind_prefix,
+				ste_cind_cb, cbd, g_free) > 0)
+			return;
+	} else {
+		if (g_at_chat_send(nd->chat, "AT+CSQ", csq_prefix,
 				csq_cb, cbd, g_free) > 0)
-		return;
+			return;
+	}
 =

 error:
 	if (cbd)
@@ -704,6 +772,12 @@ static void at_network_registration_initialized(gboole=
an ok, GAtResult *result,
 		g_at_chat_send(nd->chat, "AT_ODO=3D0", none_prefix,
 				NULL, NULL, NULL);
 		break;
+	case OFONO_VENDOR_STE:
+		g_at_chat_send(nd->chat, "AT+CMER=3D3,0,0,1", NULL,
+				NULL, NULL, NULL);
+		g_at_chat_register(nd->chat, "+CIEV:",
+				ste_ciev_notify, FALSE, netreg, NULL);
+		break;
 	default:
 		break;
 	}
diff --git a/drivers/atmodem/vendor.h b/drivers/atmodem/vendor.h
index d0df3ab..e28ec92 100644
--- a/drivers/atmodem/vendor.h
+++ b/drivers/atmodem/vendor.h
@@ -22,6 +22,7 @@
 enum ofono_vendor {
 	OFONO_VENDOR_GENERIC =3D 0,
 	OFONO_VENDOR_CALYPSO,
+	OFONO_VENDOR_STE,
 	OFONO_VENDOR_QUALCOMM_MSM,
 	OFONO_VENDOR_OPTION_HSO,
 	OFONO_VENDOR_HUAWEI,
-- =

1.6.0.4


--===============5391058784722353450==--

