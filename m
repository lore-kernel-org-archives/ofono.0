Content-Type: multipart/mixed; boundary="===============1360345356413784065=="
MIME-Version: 1.0
From: sjur.brandeland@stericsson.com
Subject: [RFC v2 3/7] STE-plugin: Add vendor STE and quirks in atmodem.
Date: Tue, 19 Jan 2010 17:11:48 +0100
Message-ID: <1263917513-6756-3-git-send-email-sjur.brandeland@stericsson.com>
In-Reply-To: <1263917513-6756-2-git-send-email-sjur.brandeland@stericsson.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1360345356413784065==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Added STE as vendor and quirks needed in "atmodem" for ST-Ericsson modem.
Added at_util_call_compare_by_id
---
 drivers/atmodem/atutil.c               |   14 ++++++
 drivers/atmodem/atutil.h               |    1 +
 drivers/atmodem/gprs.c                 |   13 +++++-
 drivers/atmodem/network-registration.c |   76 ++++++++++++++++++++++++++++=
+++-
 drivers/atmodem/vendor.h               |    1 +
 5 files changed, 101 insertions(+), 4 deletions(-)

diff --git a/drivers/atmodem/atutil.c b/drivers/atmodem/atutil.c
index b72e919..128e692 100644
--- a/drivers/atmodem/atutil.c
+++ b/drivers/atmodem/atutil.c
@@ -76,6 +76,20 @@ gint at_util_call_compare_by_phone_number(gconstpointer =
a, gconstpointer b)
 				sizeof(struct ofono_phone_number));
 }
 =

+gint at_util_call_compare_by_id(gconstpointer a, gconstpointer b)
+{
+	const struct ofono_call *call =3D a;
+	unsigned int id =3D GPOINTER_TO_UINT(b);
+
+	if (id < call->id)
+		return -1;
+
+	if (id > call->id)
+		return 1;
+
+	return 0;
+}
+
 gint at_util_call_compare(gconstpointer a, gconstpointer b)
 {
 	const struct ofono_call *ca =3D a;
diff --git a/drivers/atmodem/atutil.h b/drivers/atmodem/atutil.h
index 4b60cd1..643ff71 100644
--- a/drivers/atmodem/atutil.h
+++ b/drivers/atmodem/atutil.h
@@ -23,6 +23,7 @@ void decode_at_error(struct ofono_error *error, const cha=
r *final);
 void dump_response(const char *func, gboolean ok, GAtResult *result);
 gint at_util_call_compare_by_status(gconstpointer a, gconstpointer b);
 gint at_util_call_compare_by_phone_number(gconstpointer a, gconstpointer b=
);
+gint at_util_call_compare_by_id(gconstpointer a, gconstpointer b);
 gint at_util_call_compare(gconstpointer a, gconstpointer b);
 GSList *at_util_parse_clcc(GAtResult *result);
 gboolean at_util_parse_reg(GAtResult *result, const char *prefix,
diff --git a/drivers/atmodem/gprs.c b/drivers/atmodem/gprs.c
index 76085d9..661f063 100644
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
@@ -45,6 +47,7 @@ static const char *none_prefix[] =3D { NULL };
 =

 struct gprs_data {
 	GAtChat *chat;
+	unsigned int vendor;
 };
 =

 static void at_cgatt_cb(gboolean ok, GAtResult *result, gpointer user_data)
@@ -216,7 +219,13 @@ static void at_cgreg_test_cb(gboolean ok, GAtResult *r=
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

@@ -289,7 +298,7 @@ static int at_gprs_probe(struct ofono_gprs *gprs,
 =

 	gd =3D g_new0(struct gprs_data, 1);
 	gd->chat =3D chat;
-
+	gd->vendor =3D vendor;
 	ofono_gprs_set_data(gprs, gd);
 =

 	g_at_chat_send(chat, "AT+CGDCONT=3D?", cgdcont_prefix,
diff --git a/drivers/atmodem/network-registration.c b/drivers/atmodem/netwo=
rk-registration.c
index 202256a..e368155 100644
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
@@ -44,6 +45,7 @@ static const char *none_prefix[] =3D { NULL };
 static const char *creg_prefix[] =3D { "+CREG:", NULL };
 static const char *cops_prefix[] =3D { "+COPS:", NULL };
 static const char *csq_prefix[] =3D { "+CSQ:", NULL };
+static const char *cind_prefix[] =3D { "+CIND:", NULL };
 =

 struct netreg_data {
 	GAtChat *chat;
@@ -551,6 +553,64 @@ static void option_octi_notify(GAtResult *result, gpoi=
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
+	if (ind =3D=3D 2) { /* signal strength indication */
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
@@ -611,9 +671,15 @@ static void at_signal_strength(struct ofono_netreg *ne=
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
@@ -700,6 +766,12 @@ static void at_network_registration_initialized(gboole=
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
index 8d9ed47..a254ed2 100644
--- a/drivers/atmodem/vendor.h
+++ b/drivers/atmodem/vendor.h
@@ -22,6 +22,7 @@
 enum ofono_vendor {
 	OFONO_VENDOR_GENERIC =3D 0,
 	OFONO_VENDOR_CALYPSO,
+	OFONO_VENDOR_STE,
 	OFONO_VENDOR_QUALCOMM_MSM,
 	OFONO_VENDOR_OPTION_HSO,
 };
-- =

1.6.0.4


--===============1360345356413784065==--

