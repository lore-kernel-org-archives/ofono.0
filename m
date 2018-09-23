Content-Type: multipart/mixed; boundary="===============1377422270891056549=="
MIME-Version: 1.0
From: Giacinto Cifelli <gciofono@gmail.com>
Subject: [PATCH] atmodem/gprs: added LTE and NR indicators
Date: Sun, 23 Sep 2018 07:15:52 +0200
Message-ID: <20180923051552.5649-1-gciofono@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1377422270891056549==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

According to the 27.007 CGREG (both as URC and command) is no longer
sufficient to determine the registration state.
New indicators: CEREG for LTE, C5GREG for NR/5G are introduced.

In practice, legacy modems have CGREG, LTE-only modems have CEREG, and
several others have both.
With NR the picture will become even larger.

The handling of these indicators is not straighforward, because each
will report the status in its own access technology. So we might have
CGREG=3D4 but CEREG=3D1. Therefore they must be checked together.
Particularly troublesome is the case of the URC. In case of hand-over,
for example for a CSFB call, a common case is to have '+CEREG: 4'
followed by '+CGREG: 1'. The first URC must be discarded, and this is
done checking the technology reported by 'AT+COPS?' after the URC is
received, in case the status is different from 1 or 5 (to be done:
add the check for other roaming states for NR once the first modems are
available). Note that according to the 27.007 CREG does not apply to PS
networks, so it cannot be reliably used.
If COPS does not report a technology or reports the same technology,
we take the indicator.

Similar handling for AT+CGREG?, AT+CEREG?, AT+C5GREG? : we take the
best result.

An initial verification for the presence of any of these indicators is
required. Also how many of them are available is needed information.
---
 drivers/atmodem/gprs.c | 420 +++++++++++++++++++++++++++++++++++------
 1 file changed, 364 insertions(+), 56 deletions(-)

diff --git a/drivers/atmodem/gprs.c b/drivers/atmodem/gprs.c
index df37d05f..6e01738a 100644
--- a/drivers/atmodem/gprs.c
+++ b/drivers/atmodem/gprs.c
@@ -4,6 +4,7 @@
  *
  *  Copyright (C) 2008-2011  Intel Corporation. All rights reserved.
  *  Copyright (C) 2010  ST-Ericsson AB.
+ *  Copyright (C) 2018 Gemalto M2M
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2 as
@@ -35,6 +36,7 @@
 #include <ofono/log.h>
 #include <ofono/modem.h>
 #include <ofono/gprs.h>
+#include <common.h>
 =

 #include "gatchat.h"
 #include "gatresult.h"
@@ -43,6 +45,8 @@
 #include "vendor.h"
 =

 static const char *cgreg_prefix[] =3D { "+CGREG:", NULL };
+static const char *cereg_prefix[] =3D { "+CEREG:", NULL };
+static const char *c5greg_prefix[] =3D { "+C5GREG:", NULL };
 static const char *cgdcont_prefix[] =3D { "+CGDCONT:", NULL };
 static const char *none_prefix[] =3D { NULL };
 =

@@ -51,7 +55,22 @@ struct gprs_data {
 	unsigned int vendor;
 	unsigned int last_auto_context_id;
 	gboolean telit_try_reattach;
+	gboolean has_cgreg;
+	gboolean has_cereg;
+	gboolean has_c5greg;
+	gboolean nb_inds;
 	int attached;
+	int cgreg_status;
+	int cereg_status;
+	int c5greg_status;
+};
+
+struct netreg_info {
+	struct ofono_gprs *gprs;
+	struct gprs_data *gd;
+	const char *ind;
+	int status;
+	int bearer;
 };
 =

 static void at_cgatt_cb(gboolean ok, GAtResult *result, gpointer user_data)
@@ -92,21 +111,101 @@ static void at_cgreg_cb(gboolean ok, GAtResult *resul=
t, gpointer user_data)
 	struct ofono_error error;
 	int status;
 	struct gprs_data *gd =3D cbd->user;
+	gboolean last =3D !(gd->has_cereg || gd->has_c5greg);
 =

 	decode_at_error(&error, g_at_result_final_response(result));
 =

 	if (!ok) {
-		cb(&error, -1, cbd->data);
-		return;
+		status =3D -1;
+		goto end;
 	}
 =

 	if (at_util_parse_reg(result, "+CGREG:", NULL, &status,
 				NULL, NULL, NULL, gd->vendor) =3D=3D FALSE) {
-		CALLBACK_WITH_FAILURE(cb, -1, cbd->data);
-		return;
+		error.type =3D OFONO_ERROR_TYPE_FAILURE;
+		error.error =3D 0;
+		status =3D -1;
+		goto end;
+	}
+
+end:
+	gd->cgreg_status =3D status;
+
+	if (last)
+		cb(&error, status, cbd->data);
+}
+
+static void at_cereg_cb(gboolean ok, GAtResult *result, gpointer user_data)
+{
+	struct cb_data *cbd =3D user_data;
+	ofono_gprs_status_cb_t cb =3D cbd->cb;
+	struct ofono_error error;
+	int status;
+	struct gprs_data *gd =3D cbd->user;
+	gboolean last =3D !gd->has_c5greg;
+
+	decode_at_error(&error, g_at_result_final_response(result));
+
+	if (!ok) {
+		status =3D -1;
+		goto end;
+	}
+
+	if (at_util_parse_reg(result, "+CEREG:", NULL, &status,
+				NULL, NULL, NULL, gd->vendor) =3D=3D FALSE) {
+		error.type =3D OFONO_ERROR_TYPE_FAILURE;
+		error.error =3D 0;
+		status =3D -1;
+		goto end;
+	}
+
+end:
+	gd->cereg_status =3D status;
+
+	if (last) {
+
+		if (gd->cgreg_status =3D=3D NETWORK_REGISTRATION_STATUS_DENIED ||
+		     gd->cgreg_status =3D=3D NETWORK_REGISTRATION_STATUS_REGISTERED)
+			cb(&error, gd->cgreg_status, cbd->data);
+		else
+			cb(&error, status, cbd->data);
 	}
+}
 =

-	cb(&error, status, cbd->data);
+static void at_c5greg_cb(gboolean ok, GAtResult *result, gpointer user_dat=
a)
+{
+	struct cb_data *cbd =3D user_data;
+	ofono_gprs_status_cb_t cb =3D cbd->cb;
+	struct ofono_error error;
+	int status;
+	struct gprs_data *gd =3D cbd->user;
+
+	decode_at_error(&error, g_at_result_final_response(result));
+
+	if (!ok) {
+		status =3D -1;
+		goto end;
+	}
+
+	if (at_util_parse_reg(result, "+C5GREG:", NULL, &status,
+				NULL, NULL, NULL, gd->vendor) =3D=3D FALSE) {
+		error.type =3D OFONO_ERROR_TYPE_FAILURE;
+		error.error =3D 0;
+		status =3D -1;
+		goto end;
+	}
+
+end:
+	gd->c5greg_status =3D status;
+
+	if (gd->cgreg_status =3D=3D NETWORK_REGISTRATION_STATUS_DENIED ||
+		     gd->cgreg_status =3D=3D NETWORK_REGISTRATION_STATUS_REGISTERED)
+		cb(&error, gd->cgreg_status, cbd->data);
+	else if (gd->cereg_status =3D=3D NETWORK_REGISTRATION_STATUS_DENIED ||
+		gd->cereg_status =3D=3D NETWORK_REGISTRATION_STATUS_REGISTERED)
+		cb(&error, gd->cereg_status, cbd->data);
+	else
+		cb(&error, status, cbd->data);
 }
 =

 static void at_gprs_registration_status(struct ofono_gprs *gprs,
@@ -114,9 +213,6 @@ static void at_gprs_registration_status(struct ofono_gp=
rs *gprs,
 					void *data)
 {
 	struct gprs_data *gd =3D ofono_gprs_get_data(gprs);
-	struct cb_data *cbd =3D cb_data_new(cb, data);
-
-	cbd->user =3D gd;
 =

 	switch (gd->vendor) {
 	case OFONO_VENDOR_GOBI:
@@ -137,13 +233,51 @@ static void at_gprs_registration_status(struct ofono_=
gprs *gprs,
 		break;
 	}
 =

-	if (g_at_chat_send(gd->chat, "AT+CGREG?", cgreg_prefix,
-				at_cgreg_cb, cbd, g_free) > 0)
-		return;
+	/*
+	 * this is long: send all indicators, compare at the end if one reports
+	 * attached and use it, otherwise report status for last indicator
+	 * tested (higher technology).
+	 * Note: AT+CGATT? is not good because doesn't tell us if we are roaming
+	 */
+	if (gd->has_cgreg) {
+		struct cb_data *cbd =3D cb_data_new(cb, data);
+		cbd->user =3D gd;
+		gd->cgreg_status =3D -1; /* preset in case of fail of the at send */
+
+		/* g_at_chat_send fails only if g_new_try fails, so we stop */
+		if (g_at_chat_send(gd->chat, "AT+CGREG?", cgreg_prefix,
+					at_cgreg_cb, cbd, g_free) =3D=3D 0) {
+			g_free(cbd);
+			CALLBACK_WITH_FAILURE(cb, -1, data);
+			return;
+		}
+	}
 =

-	g_free(cbd);
+	if (gd->has_cereg) {
+		struct cb_data *cbd =3D cb_data_new(cb, data);
+		cbd->user =3D gd;
+		gd->cereg_status =3D -1;
 =

-	CALLBACK_WITH_FAILURE(cb, -1, data);
+		if (g_at_chat_send(gd->chat, "AT+CEREG?", cereg_prefix,
+					at_cereg_cb, cbd, g_free) =3D=3D 0) {
+			g_free(cbd);
+			CALLBACK_WITH_FAILURE(cb, -1, data);
+			return;
+		}
+	}
+
+	if (gd->has_c5greg) {
+		struct cb_data *cbd =3D cb_data_new(cb, data);
+		cbd->user =3D gd;
+		gd->c5greg_status =3D -1;
+
+		if (g_at_chat_send(gd->chat, "AT+C5GREG?", c5greg_prefix,
+					at_c5greg_cb, cbd, g_free) =3D=3D 0) {
+			g_free(cbd);
+			CALLBACK_WITH_FAILURE(cb, -1, data);
+			return;
+		}
+	}
 }
 =

 static void at_cgdcont_read_cb(gboolean ok, GAtResult *result,
@@ -188,14 +322,100 @@ static void at_cgdcont_read_cb(gboolean ok, GAtResul=
t *result,
 				activated_cid);
 }
 =

+static int cops_cb(gboolean ok, GAtResult *result)
+{
+	GAtResultIter iter;
+	int format, tech =3D -1;
+
+	if (!ok)
+		goto error;
+
+	g_at_result_iter_init(&iter, result);
+
+	if (!g_at_result_iter_next(&iter, "+COPS:"))
+		goto error;
+
+	g_at_result_iter_skip_next(&iter); /* mode: automatic, manual, ... */
+
+	if (!g_at_result_iter_next_number(&iter, &format))
+		goto error;
+
+	g_at_result_iter_skip_next(&iter); /* operator name or code */
+
+	if (!g_at_result_iter_next_number(&iter, &tech))
+		tech =3D -1; /* make sure it has not been set to something */
+error:
+	return tech;
+}
+
+
+static void netreg_notify_cb(gboolean ok, GAtResult *result, gpointer user=
_data)
+{
+	struct netreg_info *nri =3D user_data;
+	int cops_tech =3D cops_cb(ok, result);
+
+	if (cops_tech =3D=3D -1) { /* take the indicator status */
+		ofono_gprs_status_notify(nri->gprs, nri->status);
+		return;
+	}
+
+	/*
+	 * values taken from the 3GPP 27.007 rel.15
+	 * matching enum access_technology in common.h up to 7.
+	 */
+	if (g_str_equal(nri->ind,"CGREG") && (cops_tech < 7 || cops_tech =3D=3D 8=
))
+		ofono_gprs_status_notify(nri->gprs, nri->status);
+	else if (g_str_equal(nri->ind,"CEREG") && (cops_tech =3D=3D 7 ||
+					cops_tech =3D=3D 9 || cops_tech =3D=3D 12))
+		ofono_gprs_status_notify(nri->gprs, nri->status);
+	else if (g_str_equal(nri->ind,"C5GREG") && (cops_tech =3D=3D 10 ||
+					cops_tech =3D=3D 11 || cops_tech =3D=3D 13))
+		ofono_gprs_status_notify(nri->gprs, nri->status);
+	/* all other cases ignored: indicator not for current AcT */
+}
+
+static void netreg_notify(struct ofono_gprs *gprs, const char* ind, int st=
atus,
+								int bearer)
+{
+	struct gprs_data *gd =3D ofono_gprs_get_data(gprs);
+	struct netreg_info *nri;
+
+	if (status =3D=3D NETWORK_REGISTRATION_STATUS_DENIED ||
+			status =3D=3D NETWORK_REGISTRATION_STATUS_REGISTERED ||
+			status =3D=3D NETWORK_REGISTRATION_STATUS_ROAMING ||
+			gd->nb_inds =3D=3D 1) {
+		/* accept this status and process */
+		ofono_gprs_status_notify(gprs, status);
+
+		if (bearer !=3D -1)
+			ofono_gprs_bearer_notify(gprs, bearer);
+
+		return;
+	}
+
+	/*
+	 * in this case nb_inds>1 && status not listed above
+	 * we check AT+COPS? for a second opinion.
+	 */
+
+	nri =3D g_new0(struct netreg_info, 1);
+	nri->gprs =3D gprs;
+	nri->gd =3D gd;
+	nri->ind =3D ind;
+	nri->status =3D status;
+	nri->bearer =3D bearer;
+	g_at_chat_send(gd->chat, "AT+COPS?", none_prefix, netreg_notify_cb,
+		nri, g_free);
+}
+
 static void cgreg_notify(GAtResult *result, gpointer user_data)
 {
 	struct ofono_gprs *gprs =3D user_data;
-	int status;
 	struct gprs_data *gd =3D ofono_gprs_get_data(gprs);
+	int status, bearer;
 =

-	if (at_util_parse_reg_unsolicited(result, "+CGREG:", &status,
-				NULL, NULL, NULL, gd->vendor) =3D=3D FALSE)
+	if (!at_util_parse_reg_unsolicited(result, "+CGREG:", &status,
+				NULL, NULL, &bearer, gd->vendor) =3D=3D FALSE)
 		return;
 =

 	/*
@@ -220,7 +440,33 @@ static void cgreg_notify(GAtResult *result, gpointer u=
ser_data)
 		gd->telit_try_reattach =3D FALSE;
 	}
 =

-	ofono_gprs_status_notify(gprs, status);
+	netreg_notify(gprs, "CGREG", status, bearer);
+}
+
+static void cereg_notify(GAtResult *result, gpointer user_data)
+{
+	struct ofono_gprs *gprs =3D user_data;
+	struct gprs_data *gd =3D ofono_gprs_get_data(gprs);
+	int status, bearer;
+
+	if (!at_util_parse_reg_unsolicited(result, "+CEREG:", &status,
+				NULL, NULL, &bearer, gd->vendor) =3D=3D FALSE)
+		return;
+
+	netreg_notify(gprs, "CEREG", status, bearer);
+}
+
+static void c5greg_notify(GAtResult *result, gpointer user_data)
+{
+	struct ofono_gprs *gprs =3D user_data;
+	struct gprs_data *gd =3D ofono_gprs_get_data(gprs);
+	int status, bearer;
+
+	if (!at_util_parse_reg_unsolicited(result, "+C5GREG:", &status,
+				NULL, NULL, &bearer, gd->vendor) =3D=3D FALSE)
+		return;
+
+	netreg_notify(gprs, "C5GREG", status, bearer);
 }
 =

 static void cgev_notify(GAtResult *result, gpointer user_data)
@@ -439,14 +685,37 @@ static void cpsb_notify(GAtResult *result, gpointer u=
ser_data)
 	ofono_gprs_bearer_notify(gprs, bearer);
 }
 =

-static void gprs_initialized(gboolean ok, GAtResult *result, gpointer user=
_data)
+static void gprs_initialized(struct ofono_gprs *gprs)
 {
-	struct ofono_gprs *gprs =3D user_data;
 	struct gprs_data *gd =3D ofono_gprs_get_data(gprs);
 =

+	g_at_chat_send(gd->chat, "AT+CGAUTO=3D0", none_prefix, NULL, NULL,
+								NULL);
+
+	switch (gd->vendor) {
+	case OFONO_VENDOR_MBM:
+		/* Ericsson MBM and ST-E modems don't support AT+CGEREP=3D2,1 */
+		g_at_chat_send(gd->chat, "AT+CGEREP=3D1,0", none_prefix,
+			NULL, NULL, NULL);
+		break;
+	case OFONO_VENDOR_NOKIA:
+		/* Nokia data cards don't support AT+CGEREP=3D1,0 either */
+		g_at_chat_send(gd->chat, "AT+CGEREP=3D1", none_prefix,
+			NULL, NULL, NULL);
+		break;
+	default:
+		g_at_chat_send(gd->chat, "AT+CGEREP=3D2,1", none_prefix,
+			NULL, NULL, NULL);
+		break;
+	}
+
 	g_at_chat_register(gd->chat, "+CGEV:", cgev_notify, FALSE, gprs, NULL);
-	g_at_chat_register(gd->chat, "+CGREG:", cgreg_notify,
-						FALSE, gprs, NULL);
+	g_at_chat_register(gd->chat, "+CGREG:", cgreg_notify, FALSE, gprs,
+									NULL);
+	g_at_chat_register(gd->chat, "+CEREG:", cereg_notify, FALSE, gprs,
+									NULL);
+	g_at_chat_register(gd->chat, "+C5GREG:", c5greg_notify, FALSE, gprs,
+									NULL);
 =

 	switch (gd->vendor) {
 	case OFONO_VENDOR_HUAWEI:
@@ -489,16 +758,33 @@ static void gprs_initialized(gboolean ok, GAtResult *=
result, gpointer user_data)
 	ofono_gprs_register(gprs);
 }
 =

-static void at_cgreg_test_cb(gboolean ok, GAtResult *result,
+static void set_indreg(struct gprs_data *gd, const char *ind, gboolean pre=
sent)
+{
+	if (g_str_equal(ind,"CGREG"))
+		gd->has_cgreg =3D present;
+
+	if (g_str_equal(ind,"CEREG"))
+		gd->has_cereg =3D present;
+
+	if (g_str_equal(ind,"C5GREG"))
+		gd->has_c5greg =3D present;
+
+}
+
+static void at_indreg_test_cb(gboolean ok, GAtResult *result,
 				gpointer user_data)
 {
-	struct ofono_gprs *gprs =3D user_data;
+	struct cb_data *cbd =3D user_data;
+	struct ofono_gprs *gprs =3D cbd->cb;
+	const char *ind=3Dcbd->data;
+	const char *last=3Dcbd->user;
+
 	struct gprs_data *gd =3D ofono_gprs_get_data(gprs);
 	gint range[2];
 	GAtResultIter iter;
 	int cgreg1 =3D 0;
 	int cgreg2 =3D 0;
-	const char *cmd;
+	char buf[32];
 =

 	if (!ok)
 		goto error;
@@ -506,7 +792,8 @@ static void at_cgreg_test_cb(gboolean ok, GAtResult *re=
sult,
 	g_at_result_iter_init(&iter, result);
 =

 retry:
-	if (!g_at_result_iter_next(&iter, "+CGREG:"))
+	sprintf(buf,"+%s:",ind);
+	if (!g_at_result_iter_next(&iter, buf))
 		goto error;
 =

 	if (!g_at_result_iter_open_list(&iter))
@@ -521,45 +808,69 @@ retry:
 =

 	g_at_result_iter_close_list(&iter);
 =

-	if (cgreg2)
-		cmd =3D "AT+CGREG=3D2";
-	else if (cgreg1)
-		cmd =3D "AT+CGREG=3D1";
-	else
+	if (cgreg1) {
+		sprintf(buf,"AT+%s=3D1", ind);
+	} else if (cgreg2) {
+		sprintf(buf,"AT+%s=3D2", ind);
+	} else
 		goto error;
 =

-	g_at_chat_send(gd->chat, cmd, none_prefix, NULL, NULL, NULL);
-	g_at_chat_send(gd->chat, "AT+CGAUTO=3D0", none_prefix, NULL, NULL, NULL);
-
-	switch (gd->vendor) {
-	case OFONO_VENDOR_MBM:
-		/* Ericsson MBM and ST-E modems don't support AT+CGEREP=3D2,1 */
-		g_at_chat_send(gd->chat, "AT+CGEREP=3D1,0", none_prefix,
-			gprs_initialized, gprs, NULL);
-		break;
-	case OFONO_VENDOR_NOKIA:
-		/* Nokia data cards don't support AT+CGEREP=3D1,0 either */
-		g_at_chat_send(gd->chat, "AT+CGEREP=3D1", none_prefix,
-			gprs_initialized, gprs, NULL);
-		break;
-	default:
-		g_at_chat_send(gd->chat, "AT+CGEREP=3D2,1", none_prefix,
-			gprs_initialized, gprs, NULL);
-		break;
-	}
+	set_indreg(gd, ind,TRUE);
+	g_at_chat_send(gd->chat, buf, none_prefix, NULL, NULL, NULL);
 =

+	if (last)
+		goto endcheck;
 	return;
 =

 error:
-	ofono_info("GPRS not supported on this device");
-	ofono_gprs_remove(gprs);
+	set_indreg(gd, ind,FALSE);
+	if (!last)
+		return;
+
+endcheck:
+	if (gd->has_cgreg)
+		gd->nb_inds++;
+	if (gd->has_cereg)
+		gd->nb_inds++;
+	if (gd->has_c5greg)
+		gd->nb_inds++;
+
+	if (gd->nb_inds =3D=3D 0) {
+		ofono_info("GPRS not supported on this device");
+		ofono_gprs_remove(gprs);
+		return;
+	}
+
+	gprs_initialized(gprs);
+}
+
+static void test_and_set_regstatus(struct ofono_gprs *gprs) {
+	struct gprs_data *gd =3D ofono_gprs_get_data(gprs);
+	struct cb_data *cbd_cg  =3D cb_data_new(gprs, "CGREG");
+	struct cb_data *cbd_ce  =3D cb_data_new(gprs, "CEREG");
+	struct cb_data *cbd_c5g =3D cb_data_new(gprs, "C5GREG");
+
+	cbd_c5g->user=3D"last";
+
+	/*
+	 * modules can support one to all of the network registration indicators
+	 *
+	 * ofono will execute the next commands and related callbacks in order
+	 * therefore it is possible to verify all result on the last one.
+	 */
+
+	g_at_chat_send(gd->chat, "AT+CGREG=3D?", cgreg_prefix,
+					at_indreg_test_cb, cbd_cg, g_free);
+	g_at_chat_send(gd->chat, "AT+CEREG=3D?", cereg_prefix,
+					at_indreg_test_cb, cbd_ce, g_free);
+	g_at_chat_send(gd->chat, "AT+C5GREG=3D?", c5greg_prefix,
+					at_indreg_test_cb, cbd_c5g, g_free);
 }
 =

 static void at_cgdcont_test_cb(gboolean ok, GAtResult *result,
 				gpointer user_data)
 {
 	struct ofono_gprs *gprs =3D user_data;
-	struct gprs_data *gd =3D ofono_gprs_get_data(gprs);
 	GAtResultIter iter;
 	int min, max;
 	const char *pdp_type;
@@ -600,10 +911,7 @@ static void at_cgdcont_test_cb(gboolean ok, GAtResult =
*result,
 		goto error;
 =

 	ofono_gprs_set_cid_range(gprs, min, max);
-
-	g_at_chat_send(gd->chat, "AT+CGREG=3D?", cgreg_prefix,
-			at_cgreg_test_cb, gprs, NULL);
-
+	test_and_set_regstatus(gprs);
 	return;
 =

 error:
-- =

2.17.1


--===============1377422270891056549==--

