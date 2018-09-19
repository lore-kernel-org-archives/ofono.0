Content-Type: multipart/mixed; boundary="===============4802050259171483707=="
MIME-Version: 1.0
From: Giacinto Cifelli <gciofono@gmail.com>
Subject: [PATCH 3/7] extended support for LTE and NR. Some minor fixes. part 3
 of 7
Date: Wed, 19 Sep 2018 07:37:29 +0200
Message-ID: <1537335453-21498-3-git-send-email-gciofono@gmail.com>
In-Reply-To: <1537335453-21498-1-git-send-email-gciofono@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4802050259171483707==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 drivers/atmodem/atutil.h                 |  14 +
 drivers/atmodem/cbs.c                    |   1 +
 drivers/atmodem/gprs-context.c           |   2 +
 drivers/atmodem/gprs.c                   | 554 ++++++++++++++++--
 drivers/atmodem/lte.c                    | 283 ++++++++-
 drivers/atmodem/network-registration.c   | 134 +++--
 drivers/atmodem/sim.c                    |  10 +-
 drivers/atmodem/sms.c                    |  21 +-
 drivers/atmodem/vendor.h                 |   1 +
 drivers/gemaltomodem/gemaltomodem.c      |   5 +-
 drivers/gemaltomodem/gemaltomodem.h      |  19 +-
 drivers/gemaltomodem/gprs-context-wwan.c | 445 ++++++++++++++
 drivers/gemaltomodem/voicecall.c         | 965 +++++++++++++++++++++++++++=
++++
 drivers/mbimmodem/gprs-context.c         |   2 +
 drivers/mbimmodem/mbim.c                 |   3 +
 drivers/mbimmodem/mbimmodem.c            |   2 +-
 drivers/rilmodem/call-forwarding.c       |   2 +-
 drivers/rilmodem/network-registration.c  |   2 +-
 18 files changed, 2343 insertions(+), 122 deletions(-)
 create mode 100644 drivers/gemaltomodem/gprs-context-wwan.c
 create mode 100644 drivers/gemaltomodem/voicecall.c

diff --git a/drivers/atmodem/atutil.h b/drivers/atmodem/atutil.h
index 7113a4c..57573cb 100644
--- a/drivers/atmodem/atutil.h
+++ b/drivers/atmodem/atutil.h
@@ -115,6 +115,20 @@ static inline int at_util_convert_signal_strength(int =
strength)
 	return result;
 }
 =

+static inline int at_util_convert_signal_strength_cesq(int strength_GSM, i=
nt strength_UTRAN, int strength_EUTRAN)
+{
+	int result =3D -1;
+
+	if (strength_GSM !=3D 99)
+		result =3D (strength_GSM * 100) / 63;
+	else if (strength_UTRAN !=3D 255)
+		result =3D (strength_UTRAN * 100) / 96;
+	else if (strength_EUTRAN !=3D 255)
+		result =3D (strength_EUTRAN * 100) / 97;
+
+	return result;
+}
+
 #define CALLBACK_WITH_FAILURE(cb, args...)		\
 	do {						\
 		struct ofono_error cb_e;		\
diff --git a/drivers/atmodem/cbs.c b/drivers/atmodem/cbs.c
index 0a76ba2..1824b47 100644
--- a/drivers/atmodem/cbs.c
+++ b/drivers/atmodem/cbs.c
@@ -166,6 +166,7 @@ static void at_cbs_set_topics(struct ofono_cbs *cbs, co=
nst char *topics,
 	switch (data->vendor) {
 	case OFONO_VENDOR_GOBI:
 	case OFONO_VENDOR_QUALCOMM_MSM:
+	case OFONO_VENDOR_GEMALTO:
 		g_at_chat_send(data->chat, "AT+CSCB=3D0", none_prefix,
 				NULL, NULL, NULL);
 		break;
diff --git a/drivers/atmodem/gprs-context.c b/drivers/atmodem/gprs-context.c
index 79ac4c8..0585850 100644
--- a/drivers/atmodem/gprs-context.c
+++ b/drivers/atmodem/gprs-context.c
@@ -304,6 +304,8 @@ static void at_gprs_activate_primary(struct ofono_gprs_=
context *gc,
 				snprintf(buf + len, sizeof(buf) - len - 3,
 						",\"PAP:%s\"", ctx->apn);
 				break;
+			default:
+				break;
 			}
 			break;
 		default:
diff --git a/drivers/atmodem/gprs.c b/drivers/atmodem/gprs.c
index df37d05..6aa2cf2 100644
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

@@ -51,7 +55,23 @@ struct gprs_data {
 	unsigned int vendor;
 	unsigned int last_auto_context_id;
 	gboolean telit_try_reattach;
+	gboolean has_cgreg;
+	gboolean has_cereg;
+	gboolean has_c5greg;
+	gboolean nb_inds;
+	gboolean auto_attach; /* for LTE modems & co */
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
@@ -69,9 +89,15 @@ static void at_gprs_set_attached(struct ofono_gprs *gprs=
, int attached,
 					ofono_gprs_cb_t cb, void *data)
 {
 	struct gprs_data *gd =3D ofono_gprs_get_data(gprs);
-	struct cb_data *cbd =3D cb_data_new(cb, data);
+	struct cb_data *cbd;
 	char buf[64];
 =

+	if(gd->auto_attach) {
+		CALLBACK_WITH_SUCCESS(cb, data);
+		return;
+	}
+
+	cbd =3D cb_data_new(cb, data);
 	snprintf(buf, sizeof(buf), "AT+CGATT=3D%i", attached ? 1 : 0);
 =

 	if (g_at_chat_send(gd->chat, buf, none_prefix,
@@ -92,21 +118,101 @@ static void at_cgreg_cb(gboolean ok, GAtResult *resul=
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
+	if(last)
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
+	if(last) {
+
+		if (gd->cgreg_status=3D=3DNETWORK_REGISTRATION_STATUS_DENIED ||
+			gd->cgreg_status=3D=3DNETWORK_REGISTRATION_STATUS_REGISTERED)
+			cb(&error, gd->cgreg_status, cbd->data);
+		else
+			cb(&error, status, cbd->data);
+	}
+}
+
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
 	}
 =

-	cb(&error, status, cbd->data);
+end:
+	gd->c5greg_status =3D status;
+
+	if (gd->cgreg_status=3D=3DNETWORK_REGISTRATION_STATUS_DENIED ||
+		gd->cgreg_status=3D=3DNETWORK_REGISTRATION_STATUS_REGISTERED)
+		cb(&error, gd->cgreg_status, cbd->data);
+	else if (gd->cereg_status=3D=3DNETWORK_REGISTRATION_STATUS_DENIED ||
+		gd->cereg_status=3D=3DNETWORK_REGISTRATION_STATUS_REGISTERED)
+		cb(&error, gd->cereg_status, cbd->data);
+	else
+		cb(&error, status, cbd->data);
 }
 =

 static void at_gprs_registration_status(struct ofono_gprs *gprs,
@@ -114,9 +220,6 @@ static void at_gprs_registration_status(struct ofono_gp=
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
@@ -137,13 +240,51 @@ static void at_gprs_registration_status(struct ofono_=
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
+	if(gd->has_cgreg) {
+		struct cb_data *cbd =3D cb_data_new(cb, data);
+		cbd->user =3D gd;
+		gd->cgreg_status=3D-1; /* preset in case of fail of the at send */
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
+	if(gd->has_cereg) {
+		struct cb_data *cbd =3D cb_data_new(cb, data);
+		cbd->user =3D gd;
+		gd->cereg_status=3D-1;
+
+		if (g_at_chat_send(gd->chat, "AT+CEREG?", cereg_prefix,
+					at_cereg_cb, cbd, g_free) =3D=3D 0) {
+			g_free(cbd);
+			CALLBACK_WITH_FAILURE(cb, -1, data);
+			return;
+		}
+	}
+
+	if(gd->has_c5greg) {
+		struct cb_data *cbd =3D cb_data_new(cb, data);
+		cbd->user =3D gd;
+		gd->c5greg_status=3D-1;
 =

-	CALLBACK_WITH_FAILURE(cb, -1, data);
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
@@ -188,14 +329,100 @@ static void at_cgdcont_read_cb(gboolean ok, GAtResul=
t *result,
 				activated_cid);
 }
 =

+static int cops_cb(gboolean ok, GAtResult *result)
+{
+	GAtResultIter iter;
+	int format, tech=3D-1;
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
+	if(cops_tech=3D=3D-1) { /* take the indicator status */
+		ofono_gprs_status_notify(nri->gprs, nri->status);
+		return;
+	}
+
+	/*
+	 * values taken from the 3GPP 27.007 rel.15
+	 * matching enum access_technology in common.h up to 7.
+	 */
+	if (g_str_equal(nri->ind,"CGREG") && (cops_tech<7 || cops_tech=3D=3D8))
+		ofono_gprs_status_notify(nri->gprs, nri->status);
+	else if (g_str_equal(nri->ind,"CEREG") && (cops_tech=3D=3D7 ||
+						cops_tech=3D=3D9 || cops_tech=3D=3D12))
+		ofono_gprs_status_notify(nri->gprs, nri->status);
+	else if (g_str_equal(nri->ind,"C5GREG") && (cops_tech=3D=3D10 ||
+						cops_tech=3D=3D11 || cops_tech=3D=3D13))
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
+	if (status=3D=3DNETWORK_REGISTRATION_STATUS_DENIED ||
+			status=3D=3DNETWORK_REGISTRATION_STATUS_REGISTERED ||
+			status=3D=3DNETWORK_REGISTRATION_STATUS_ROAMING ||
+			gd->nb_inds=3D=3D1) {
+		/* accept this status and process */
+		ofono_gprs_status_notify(gprs, status);
+
+		if(bearer !=3D -1)
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
@@ -220,7 +447,33 @@ static void cgreg_notify(GAtResult *result, gpointer u=
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
@@ -419,6 +672,91 @@ static void ublox_ureg_notify(GAtResult *result, gpoin=
ter user_data)
 	ofono_gprs_bearer_notify(gprs, bearer);
 }
 =

+static void gemalto_ciev_ceer_notify(GAtResult *result, gpointer user_data)
+{
+	struct ofono_gprs *gprs =3D user_data;
+	const char *report;
+	GAtResultIter iter;
+
+	g_at_result_iter_init(&iter, result);
+
+	if (!g_at_result_iter_next(&iter, "+CIEV: ceer,"))
+		return;
+	/*
+	 * No need to check release cause group
+	 * as we only subscribe to no. 5
+	 */
+	if (!g_at_result_iter_skip_next(&iter))
+		return;
+	if (!g_at_result_iter_next_string(&iter, &report))
+		return;
+
+	/* TODO: Handle more of these? */
+
+	if (g_str_equal(report, "Regular deactivation")) {
+		ofono_gprs_detached_notify(gprs);
+		return;
+	}
+}
+
+static void gemalto_ciev_bearer_notify(GAtResult *result, gpointer user_da=
ta)
+{
+	struct ofono_gprs *gprs =3D user_data;
+	int bearer;
+	GAtResultIter iter;
+
+	g_at_result_iter_init(&iter, result);
+
+	if (!g_at_result_iter_next(&iter, "+CIEV: psinfo,"))
+		return;
+	if (!g_at_result_iter_next_number(&iter, &bearer))
+		return;
+
+	/* Go from Gemalto representation to oFono representation */
+	switch (bearer) {
+	case 0: /* GPRS/EGPRS not available */
+		/* Same as "no bearer"? */
+		bearer =3D 0;
+		break;
+	case 1: /* GPRS available, ignore this one */
+		return;
+	case 2: /* GPRS attached */
+		bearer =3D 1;
+		break;
+	case 3: /* EGPRS available, ignore this one */
+		return;
+	case 4: /* EGPRS attached */
+		bearer =3D 2;
+		break;
+	case 5: /* UMTS available, ignore this one */
+		return;
+	case 6: /* UMTS attached */
+		bearer =3D 3;
+		break;
+	case 7: /* HSDPA available, ignore this one */
+		return;
+	case 8: /* HSDPA attached */
+		bearer =3D 5;
+		break;
+	case 9: /* HSDPA/HSUPA available, ignore this one */
+		return;
+	case 10: /* HSDPA/HSUPA attached */
+		bearer =3D 6;
+		break;
+	/* TODO: Limit these cases to ALS3? */
+	case 16: /* E-UTRA available, ignore this one */
+		return;
+	case 17: /* E-UTRA attached */
+		bearer =3D 7;
+		break;
+	default: /* Assume that non-parsable values mean "no bearer" */
+		bearer =3D 0;
+		break;
+	}
+
+	ofono_gprs_bearer_notify(gprs, bearer);
+}
+
 static void cpsb_notify(GAtResult *result, gpointer user_data)
 {
 	struct ofono_gprs *gprs =3D user_data;
@@ -439,14 +777,48 @@ static void cpsb_notify(GAtResult *result, gpointer u=
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

+	switch (gd->vendor) {
+	case OFONO_VENDOR_GEMALTO:
+		break;
+	default:
+		g_at_chat_send(gd->chat, "AT+CGAUTO=3D0", none_prefix, NULL, NULL,
+									NULL);
+	}
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
+	case OFONO_VENDOR_GEMALTO:
+		g_at_chat_send(gd->chat, "AT+CGEREP=3D2", NULL,
+					NULL, NULL, NULL);
+		g_at_chat_send(gd->chat, "AT^SIND=3D\"psinfo\",1", none_prefix,
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
@@ -468,6 +840,12 @@ static void gprs_initialized(gboolean ok, GAtResult *r=
esult, gpointer user_data)
 		g_at_chat_send(gd->chat, "AT#PSNT=3D1", none_prefix,
 						NULL, NULL, NULL);
 		break;
+	case OFONO_VENDOR_GEMALTO:
+		g_at_chat_register(gd->chat, "+CIEV: psinfo,",
+			gemalto_ciev_bearer_notify, FALSE, gprs, NULL);
+		g_at_chat_register(gd->chat, "+CIEV: ceer,",
+			gemalto_ciev_ceer_notify, FALSE, gprs, NULL);
+		break;
 	default:
 		g_at_chat_register(gd->chat, "+CPSB:", cpsb_notify,
 						FALSE, gprs, NULL);
@@ -489,16 +867,33 @@ static void gprs_initialized(gboolean ok, GAtResult *=
result, gpointer user_data)
 	ofono_gprs_register(gprs);
 }
 =

-static void at_cgreg_test_cb(gboolean ok, GAtResult *result,
+static void set_indreg(struct gprs_data *gd, const char *ind, gboolean pre=
sent)
+{
+	if(g_str_equal(ind,"CGREG"))
+		gd->has_cgreg =3D present;
+
+	if(g_str_equal(ind,"CEREG"))
+		gd->has_cereg =3D present;
+
+	if(g_str_equal(ind,"C5GREG"))
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
@@ -506,7 +901,8 @@ static void at_cgreg_test_cb(gboolean ok, GAtResult *re=
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
@@ -521,45 +917,75 @@ retry:
 =

 	g_at_result_iter_close_list(&iter);
 =

-	if (cgreg2)
-		cmd =3D "AT+CGREG=3D2";
-	else if (cgreg1)
-		cmd =3D "AT+CGREG=3D1";
-	else
+	if(gd->vendor=3D=3DOFONO_VENDOR_GEMALTO) {
+		/*
+		 * Gemalto prefers to print as much information as available
+		 * for support purposes
+		 */
+		sprintf(buf, "AT+%s=3D%d",ind, range[1]);
+	} else if (cgreg1) {
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

+	if(last)
+		goto endcheck;
 	return;
 =

 error:
-	ofono_info("GPRS not supported on this device");
-	ofono_gprs_remove(gprs);
+	set_indreg(gd, ind,FALSE);
+	if(!last)
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
+	if(gd->nb_inds=3D=3D0) {
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
@@ -592,18 +1018,16 @@ static void at_cgdcont_test_cb(gboolean ok, GAtResul=
t *result,
 			continue;
 =

 		/* We look for IP PDPs */
-		if (g_str_equal(pdp_type, "IP"))
+		if (g_str_equal(pdp_type, "IP")){
 			found =3D TRUE;
+		}
 	}
 =

 	if (found =3D=3D FALSE)
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
@@ -616,6 +1040,8 @@ static int at_gprs_probe(struct ofono_gprs *gprs,
 {
 	GAtChat *chat =3D data;
 	struct gprs_data *gd;
+	int autoattach;
+	struct ofono_modem* modem=3Dofono_gprs_get_modem(gprs);
 =

 	gd =3D g_try_new0(struct gprs_data, 1);
 	if (gd =3D=3D NULL)
@@ -626,8 +1052,16 @@ static int at_gprs_probe(struct ofono_gprs *gprs,
 =

 	ofono_gprs_set_data(gprs, gd);
 =

-	g_at_chat_send(gd->chat, "AT+CGDCONT=3D?", cgdcont_prefix,
-			at_cgdcont_test_cb, gprs, NULL);
+	if (gd->vendor=3D=3DOFONO_VENDOR_GEMALTO) {
+		autoattach=3Dofono_modem_get_integer(modem, "Gto_Autoattach");
+		/* set autoattach */
+		gd->auto_attach =3D (autoattach=3D=3D1);
+		/* skip the cgdcont scanning: set manually */
+		test_and_set_regstatus(gprs);
+	} else {
+		g_at_chat_send(gd->chat, "AT+CGDCONT=3D?", cgdcont_prefix,
+						at_cgdcont_test_cb, gprs, NULL);
+	}
 =

 	return 0;
 }
diff --git a/drivers/atmodem/lte.c b/drivers/atmodem/lte.c
index efa4e5f..429b847 100644
--- a/drivers/atmodem/lte.c
+++ b/drivers/atmodem/lte.c
@@ -3,6 +3,7 @@
  *  oFono - Open Source Telephony
  *
  *  Copyright (C) 2017  Intel Corporation. All rights reserved.
+ *  Copyright (C) 2018 Gemalto M2M
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2 as
@@ -40,22 +41,273 @@
 #include "gatresult.h"
 =

 #include "atmodem.h"
+#include "vendor.h"
 =

 struct lte_driver_data {
 	GAtChat *chat;
+	unsigned int vendor;
 };
 =

+struct lte_cb_data {
+	const struct ofono_lte_default_attach_info *info;
+	ofono_lte_cb_t cb;
+	const struct ofono_lte *lte;
+	void *data;
+};
+
+static gboolean gemalto_get_auth_command(struct ofono_modem *modem, int ci=
d,
+				enum ofono_gprs_auth_method auth_method,
+				const char *username, const char *password,
+				char *buf, guint buflen)
+{
+	int gto_auth =3D ofono_modem_get_integer(modem, "Gemalto_Auth");
+	int len;
+	/*
+	 * 0: use cgauth
+	 * 1: use sgauth(pwd, user)
+	 * 2: use sgauth(user, pwd)
+	 */
+
+	int auth_type;
+
+	switch (auth_method) {
+	case OFONO_GPRS_AUTH_METHOD_PAP:
+		auth_type=3D1;
+		break;
+	case OFONO_GPRS_AUTH_METHOD_CHAP:
+		auth_type=3D2;
+		break;
+	case OFONO_GPRS_AUTH_METHOD_NONE:
+	default:
+		auth_type=3D0;
+		break;
+	}
+
+	if (auth_type !=3D 0 && (!*username || !*password))
+		return FALSE;
+
+	switch (gto_auth) {
+	case 1:
+	case 2:
+		len =3D snprintf(buf, buflen, "AT^SGAUTH=3D%d", cid);
+		break;
+	case 0:
+	default:
+		len =3D snprintf(buf, buflen, "AT+CGAUTH=3D%d", cid);
+		break;
+	}
+
+	buflen -=3D len;
+
+	switch(auth_type) {
+	case 0:
+
+		switch (gto_auth) {
+		case 2:
+			snprintf(buf+len, buflen, ",0,\"\",\"\"");
+			break;
+		case 0:
+		case 1:
+		default:
+			snprintf(buf+len, buflen, ",0");
+			break;
+		}
+		break;
+
+	case 1:
+	case 2:
+
+		switch (gto_auth) {
+		case 1:
+			snprintf(buf+len, buflen, ",%d,\"%s\",\"%s\"",
+					auth_type, password, username);
+			break;
+		case 0:
+		case 2:
+		default:
+			snprintf(buf+len, buflen, ",%d,\"%s\",\"%s\"",
+					auth_type, username, password);
+		}
+		break;
+
+	default:
+		return FALSE;
+	}
+
+	return TRUE;
+}
+
+static void gemalto_get_cgdcont_command(struct ofono_modem *modem,
+			guint cid, enum ofono_gprs_proto proto, const char *apn,
+							char *buf, guint buflen)
+{
+	int len =3D snprintf(buf, buflen, "AT+CGDCONT=3D%u", cid);
+	buflen-=3Dlen;
+
+	if(!apn) /* it will remove the context */
+		return;
+
+	switch (proto) {
+	case OFONO_GPRS_PROTO_IPV6:
+		snprintf(buf+len, buflen, ",\"IPV6\",\"%s\"", apn);
+		break;
+	case OFONO_GPRS_PROTO_IPV4V6:
+		snprintf(buf+len, buflen, ",\"IPV4V6\",\"%s\"", apn);
+		break;
+	case OFONO_GPRS_PROTO_IP:
+	default:
+		snprintf(buf+len, buflen, ",\"IP\",\"%s\"", apn);
+		break;
+	}
+}
+
+static void at_lte_set_default_auth_info_cb(gboolean ok, GAtResult *result,
+							gpointer user_data)
+{
+	struct lte_cb_data *lcbd =3D user_data;
+	struct ofono_error error;
+	ofono_lte_cb_t cb =3D lcbd->cb;
+	void *data =3D lcbd->data;
+
+	DBG("ok %d", ok);
+
+	decode_at_error(&error, g_at_result_final_response(result));
+	cb(&error, data);
+}
+
+static void gemalto_lte_set_default_auth_info(const struct ofono_lte *lte,
+			const struct ofono_lte_default_attach_info *info,
+			ofono_lte_cb_t cb, void *data)
+{
+	struct lte_cb_data *lcbd =3D data;
+	void* ud =3D lcbd->data;
+	struct lte_driver_data *ldd =3D ofono_lte_get_data(lte);
+	struct ofono_modem *modem =3D ofono_lte_get_modem(lte);
+	char buf[32 + OFONO_GPRS_MAX_USERNAME_LENGTH +
+					OFONO_GPRS_MAX_PASSWORD_LENGTH +1];
+
+	if(!gemalto_get_auth_command(modem, 1, info->auth_method,
+			info->username, info->password, buf, sizeof(buf))) {
+		g_free(lcbd);
+		goto set_auth_failure;
+	}
+
+	if(g_at_chat_send(ldd->chat, buf, NULL, at_lte_set_default_auth_info_cb,
+							lcbd, g_free) > 0)
+		return;
+
+set_auth_failure:
+	CALLBACK_WITH_FAILURE(cb, ud);
+}
+
+static void at_lte_set_default_auth_info(const struct ofono_lte *lte,
+			const struct ofono_lte_default_attach_info *info,
+			ofono_lte_cb_t cb, void *data)
+{
+	struct lte_cb_data *lcbd =3D data;
+	void* ud =3D lcbd->data;
+	struct lte_driver_data *ldd =3D ofono_lte_get_data(lte);
+	char buf[32 + OFONO_GPRS_MAX_USERNAME_LENGTH +
+					OFONO_GPRS_MAX_PASSWORD_LENGTH +1];
+	guint buflen =3D sizeof(buf);
+
+	snprintf(buf, buflen, "AT+CGAUTH=3D0,");
+	buflen-=3Dstrlen(buf);
+
+	switch(info->auth_method) {
+	case OFONO_GPRS_AUTH_METHOD_NONE:
+		snprintf(buf+strlen(buf), buflen, "0");
+		break;
+	case OFONO_GPRS_AUTH_METHOD_PAP:
+		snprintf(buf+strlen(buf), buflen, "1,\"%s\",\"%s\"",
+						info->username, info->password);
+		break;
+	case OFONO_GPRS_AUTH_METHOD_CHAP:
+		snprintf(buf+strlen(buf), buflen, "2,\"%s\",\"%s\"",
+						info->username, info->password);
+		break;
+	default:
+		g_free(lcbd);
+		goto set_auth_failure;
+		break;
+	}
+
+	if(g_at_chat_send(ldd->chat, buf, NULL, at_lte_set_default_auth_info_cb,
+							lcbd, g_free) > 0)
+		return;
+
+set_auth_failure:
+	CALLBACK_WITH_FAILURE(cb, ud);
+}
+
 static void at_lte_set_default_attach_info_cb(gboolean ok, GAtResult *resu=
lt,
 							gpointer user_data)
 {
-	struct cb_data *cbd =3D user_data;
-	ofono_lte_cb_t cb =3D cbd->cb;
+	struct lte_cb_data *lcbd =3D user_data;
+	struct lte_driver_data *ldd =3D ofono_lte_get_data(lcbd->data);
 	struct ofono_error error;
 =

 	DBG("ok %d", ok);
 =

+	if (ok) {
+		switch (ldd->vendor) {
+		case OFONO_VENDOR_GEMALTO:
+			gemalto_lte_set_default_auth_info(lcbd->lte,
+					lcbd->info, lcbd->cb, user_data);
+			return;
+			break;
+		default:
+			at_lte_set_default_auth_info(lcbd->lte,
+					lcbd->info, lcbd->cb, user_data);
+			return;
+			break;
+		}
+	}
+
 	decode_at_error(&error, g_at_result_final_response(result));
-	cb(&error, cbd->data);
+	lcbd->cb(&error, lcbd->data);
+}
+
+static void gemalto_lte_set_default_attach_info(const struct ofono_lte *lt=
e,
+			const struct ofono_lte_default_attach_info *info,
+			ofono_lte_cb_t cb, void *data)
+{
+	struct lte_driver_data *ldd =3D ofono_lte_get_data(lte);
+	struct ofono_modem *modem =3D ofono_lte_get_modem(lte);
+	char buf[32 + OFONO_GPRS_MAX_APN_LENGTH  +1];
+	struct lte_cb_data *lcbd;
+	int gto_autoconf =3D ofono_modem_get_integer(modem, "Gemalto_Autoconf");
+
+	/*
+	 * to be completed. May require additional properties in the driver
+	 * current values plan for Gemalto_Autoconf:
+	 * 0: no autoconf (or no param set)
+	 * 1: autoconf activated but fallback selected
+	 * 2: autoconf activated, profile selected,
+	 *		but custom attach apn required for this application
+	 * 3-9: rfu
+	 * 10: autoconf default bearer and ims
+	 * 20: autoconf 10 + autoconf private apn
+	 */
+	if(gto_autoconf>=3D10) {
+		CALLBACK_WITH_SUCCESS(cb, data);
+		return;
+	}
+
+	lcbd =3D g_new0(struct lte_cb_data, 1);
+	lcbd->data =3D data;
+	lcbd->info =3D info;
+	lcbd->cb =3D cb;
+	lcbd->lte =3D lte;
+
+	gemalto_get_cgdcont_command(modem, 1, info->proto, info->apn, buf,
+								sizeof(buf));
+
+	if (g_at_chat_send(ldd->chat, buf, NULL,
+			at_lte_set_default_attach_info_cb, lcbd, NULL) > 0)
+		return;
+
+	CALLBACK_WITH_FAILURE(cb, data);
 }
 =

 static void at_lte_set_default_attach_info(const struct ofono_lte *lte,
@@ -63,20 +315,28 @@ static void at_lte_set_default_attach_info(const struc=
t ofono_lte *lte,
 			ofono_lte_cb_t cb, void *data)
 {
 	struct lte_driver_data *ldd =3D ofono_lte_get_data(lte);
-	char buf[32 + OFONO_GPRS_MAX_APN_LENGTH + 1];
-	struct cb_data *cbd =3D cb_data_new(cb, data);
+	char buf[32 + OFONO_GPRS_MAX_APN_LENGTH  +1];
+	struct lte_cb_data *lcbd;
 =

-	DBG("LTE config with APN: %s", info->apn);
+	if(ldd->vendor=3D=3DOFONO_VENDOR_GEMALTO) {
+		gemalto_lte_set_default_attach_info(lte, info, cb, data);
+		return;
+	}
+
+	lcbd =3D g_new0(struct lte_cb_data, 1);
+	lcbd->data =3D data;
+	lcbd->info =3D info;
+	lcbd->cb =3D cb;
+	lcbd->lte =3D lte;
 =

 	if (strlen(info->apn) > 0)
 		snprintf(buf, sizeof(buf), "AT+CGDCONT=3D0,\"IP\",\"%s\"",
-				info->apn);
+							info->apn);
 	else
 		snprintf(buf, sizeof(buf), "AT+CGDCONT=3D0,\"IP\"");
 =

-	/* We can't do much in case of failure so don't check response. */
 	if (g_at_chat_send(ldd->chat, buf, NULL,
-			at_lte_set_default_attach_info_cb, cbd, g_free) > 0)
+			at_lte_set_default_attach_info_cb, lcbd, NULL) > 0)
 		return;
 =

 	CALLBACK_WITH_FAILURE(cb, data);
@@ -84,9 +344,7 @@ static void at_lte_set_default_attach_info(const struct =
ofono_lte *lte,
 =

 static gboolean lte_delayed_register(gpointer user_data)
 {
-	struct ofono_lte *lte =3D user_data;
-
-	ofono_lte_register(lte);
+	ofono_lte_register(user_data);
 =

 	return FALSE;
 }
@@ -103,6 +361,7 @@ static int at_lte_probe(struct ofono_lte *lte, unsigned=
 int vendor, void *data)
 		return -ENOMEM;
 =

 	ldd->chat =3D g_at_chat_clone(chat);
+	ldd->vendor =3D vendor;
 =

 	ofono_lte_set_data(lte, ldd);
 =

diff --git a/drivers/atmodem/network-registration.c b/drivers/atmodem/netwo=
rk-registration.c
index 0854cd1..c6d00a9 100644
--- a/drivers/atmodem/network-registration.c
+++ b/drivers/atmodem/network-registration.c
@@ -4,6 +4,7 @@
  *
  *  Copyright (C) 2008-2011  Intel Corporation. All rights reserved.
  *  Copyright (C) 2010  ST-Ericsson AB.
+ *  Copyright (C) 2018 Gemalto M2M
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2 as
@@ -56,6 +57,7 @@ struct netreg_data {
 	GAtChat *chat;
 	char mcc[OFONO_MAX_MCC_LENGTH + 1];
 	char mnc[OFONO_MAX_MNC_LENGTH + 1];
+	unsigned int csq_source;
 	int signal_index; /* If strength is reported via CIND */
 	int signal_min; /* min strength reported via CIND */
 	int signal_max; /* max strength reported via CIND */
@@ -179,7 +181,7 @@ static int option_parse_tech(GAtResult *result)
 	return tech;
 }
 =

-static int cinterion_parse_tech(GAtResult *result)
+static int gemalto_parse_tech(GAtResult *result)
 {
 	int tech =3D -1;
 	GAtResultIter iter;
@@ -231,13 +233,13 @@ static void at_creg_cb(gboolean ok, GAtResult *result=
, gpointer user_data)
 	cb(&error, status, lac, ci, tech, cbd->data);
 }
 =

-static void cinterion_query_tech_cb(gboolean ok, GAtResult *result,
+static void gemalto_query_tech_cb(gboolean ok, GAtResult *result,
                                               gpointer user_data)
 {
 	struct tech_query *tq =3D user_data;
 	int tech;
 =

-	tech =3D cinterion_parse_tech(result);
+	tech =3D gemalto_parse_tech(result);
 =

 	ofono_netreg_status_notify(tq->netreg,
 			tq->status, tq->lac, tq->ci, tech);
@@ -664,6 +666,45 @@ static void csq_notify(GAtResult *result, gpointer use=
r_data)
 				at_util_convert_signal_strength(strength));
 }
 =

+static void cesq_notify(GAtResult *result, gpointer user_data)
+{
+	struct ofono_netreg *netreg =3D user_data;
+	int strength_GSM, strength_UTRAN, strength_EUTRAN;
+	GAtResultIter iter;
+
+	g_at_result_iter_init(&iter, result);
+
+	if (!g_at_result_iter_next(&iter, "+CESQ:"))
+		return;
+
+	/* rxlevel gsm, use as a strength indicator */
+	if (!g_at_result_iter_next_number(&iter, &strength_GSM))
+		return;
+
+	/* ber gsm, ignore*/
+	if (!g_at_result_iter_skip_next(&iter))
+		return;
+
+	/* rscp utran, use as a strength indicator */
+	if (!g_at_result_iter_next_number(&iter, &strength_UTRAN))
+		return;
+
+	/* ecno utran, ignore */
+	if (!g_at_result_iter_skip_next(&iter))
+		return;
+
+	/* rsrq eutran, ignore */
+	if (!g_at_result_iter_skip_next(&iter))
+		return;
+
+	/* rsrp eutran, use as a strength indicator */
+	if (!g_at_result_iter_next_number(&iter, &strength_EUTRAN))
+		return;
+
+	ofono_netreg_strength_notify(netreg,
+				at_util_convert_signal_strength_cesq(strength_GSM, strength_UTRAN, str=
ength_EUTRAN));
+}
+
 static void calypso_csq_notify(GAtResult *result, gpointer user_data)
 {
 	struct ofono_netreg *netreg =3D user_data;
@@ -702,7 +743,6 @@ static void option_osigq_notify(GAtResult *result, gpoi=
nter user_data)
 =

 static void ifx_xhomezr_notify(GAtResult *result, gpointer user_data)
 {
-	//struct ofono_netreg *netreg =3D user_data;
 	const char *label;
 	GAtResultIter iter;
 =

@@ -767,7 +807,6 @@ static void ifx_xreg_notify(GAtResult *result, gpointer=
 user_data)
 =

 static void ifx_xciev_notify(GAtResult *result, gpointer user_data)
 {
-	//struct ofono_netreg *netreg =3D user_data;
 	int ind;
 	GAtResultIter iter;
 =

@@ -876,7 +915,7 @@ static void telit_ciev_notify(GAtResult *result, gpoint=
er user_data)
 	ofono_netreg_strength_notify(netreg, strength);
 }
 =

-static void cinterion_ciev_notify(GAtResult *result, gpointer user_data)
+static void gemalto_ciev_notify(GAtResult *result, gpointer user_data)
 {
 	struct ofono_netreg *netreg =3D user_data;
 	struct netreg_data *nd =3D ofono_netreg_get_data(netreg);
@@ -1233,18 +1272,23 @@ static void at_signal_strength(struct ofono_netreg =
*netreg,
 =

 	cbd->user =3D nd;
 =

-	/*
-	 * If we defaulted to using CIND, then keep using it,
-	 * otherwise fall back to CSQ
-	 */
-	if (nd->signal_index > 0) {
-		if (g_at_chat_send(nd->chat, "AT+CIND?", cind_prefix,
-					cind_cb, cbd, g_free) > 0)
-			return;
-	} else {
-		if (g_at_chat_send(nd->chat, "AT+CSQ", csq_prefix,
-				csq_cb, cbd, g_free) > 0)
-			return;
+	switch(nd->vendor) {
+	case OFONO_VENDOR_GEMALTO:
+		break;
+	default:
+		/*
+		 * If we defaulted to using CIND, then keep using it,
+		 * otherwise fall back to CSQ
+		 */
+		if (nd->signal_index > 0) {
+			if (g_at_chat_send(nd->chat, "AT+CIND?", cind_prefix,
+						cind_cb, cbd, g_free) > 0)
+				return;
+		} else {
+			if (g_at_chat_send(nd->chat, "AT+CSQ", csq_prefix,
+					csq_cb, cbd, g_free) > 0)
+				return;
+		}
 	}
 =

 	g_free(cbd);
@@ -1534,6 +1578,9 @@ static void creg_notify(GAtResult *result, gpointer u=
ser_data)
 	tq->ci =3D ci;
 	tq->netreg =3D netreg;
 =

+	if ((status =3D=3D 1 || status =3D=3D 5) && tech =3D=3D -1)
+		tech =3D nd->tech;
+
 	switch (nd->vendor) {
 	case OFONO_VENDOR_GOBI:
 		if (g_at_chat_send(nd->chat, "AT*CNTI=3D0", none_prefix,
@@ -1556,19 +1603,18 @@ static void creg_notify(GAtResult *result, gpointer=
 user_data)
 					option_query_tech_cb, tq, g_free) > 0)
 			return;
 		break;
-    case OFONO_VENDOR_CINTERION:
-              if (g_at_chat_send(nd->chat, "AT^SMONI",
-                                      smoni_prefix,
-                                      cinterion_query_tech_cb, tq, g_free)=
 > 0)
-                      return;
-              break;
+    case OFONO_VENDOR_GEMALTO:
+		if (tech!=3D-1)
+			break;  /* technology already returned by +CREG, so run the notify labe=
l */
+		if (g_at_chat_send(nd->chat, "AT^SMONI",
+					smoni_prefix,
+					gemalto_query_tech_cb, tq, g_free) > 0)
+			return;
+		break;
 	}
 =

 	g_free(tq);
 =

-	if ((status =3D=3D 1 || status =3D=3D 5) && tech =3D=3D -1)
-		tech =3D nd->tech;
-
 notify:
 	ofono_netreg_status_notify(netreg, status, lac, ci, tech);
 }
@@ -1861,6 +1907,17 @@ error:
 	ofono_netreg_remove(netreg);
 }
 =

+static gboolean gemalto_csq_query(gpointer user_data)
+{
+	struct ofono_netreg *netreg =3D user_data;
+	struct netreg_data *nd =3D ofono_netreg_get_data(netreg);
+
+	g_at_chat_send(nd->chat, "AT+CSQ", none_prefix, NULL, NULL, NULL);
+	g_at_chat_send(nd->chat, "AT+CESQ", none_prefix, NULL, NULL, NULL);
+
+	return TRUE;
+}
+
 static void at_creg_set_cb(gboolean ok, GAtResult *result, gpointer user_d=
ata)
 {
 	struct ofono_netreg *netreg =3D user_data;
@@ -2028,12 +2085,12 @@ static void at_creg_set_cb(gboolean ok, GAtResult *=
result, gpointer user_data)
 		g_at_chat_send(nd->chat, "AT*TLTS=3D1", none_prefix,
 						NULL, NULL, NULL);
 		break;
-	case OFONO_VENDOR_CINTERION:
+	case OFONO_VENDOR_GEMALTO:
 		/*
-		 * We can't set rssi bounds from Cinterion responses
+		 * We can't set rssi bounds from Gemalto responses
 		 * so set them up to specified values here
 		 *
-		 * Cinterion rssi signal strength specified as:
+		 * Gemalto rssi signal strength specified as:
 		 * 0      <=3D -112dBm
 		 * 1 - 4  signal strengh in 15 dB steps
 		 * 5      >=3D -51 dBm
@@ -2042,12 +2099,20 @@ static void at_creg_set_cb(gboolean ok, GAtResult *=
result, gpointer user_data)
 		nd->signal_min =3D 0;
 		nd->signal_max =3D 5;
 		nd->signal_invalid =3D 99;
-
 		/* Register for specific signal strength reports */
+		g_at_chat_register(nd->chat, "+CIEV:",
+				gemalto_ciev_notify, FALSE, netreg, NULL);
 		g_at_chat_send(nd->chat, "AT^SIND=3D\"rssi\",1", none_prefix,
 				NULL, NULL, NULL);
-		g_at_chat_register(nd->chat, "+CIEV:",
-				cinterion_ciev_notify, FALSE, netreg, NULL);
+		/* Register for +CSQ and +CESQ and then poll them periodically */
+		g_at_chat_register(nd->chat, "+CSQ:", csq_notify,
+						FALSE, netreg, NULL);
+		g_at_chat_register(nd->chat, "+CESQ:", cesq_notify,
+						FALSE, netreg, NULL);
+
+		if (!nd->csq_source) /* in case it has already be called, to avoid a mem=
ory leak */
+			nd->csq_source =3D g_timeout_add_seconds(60, gemalto_csq_query, netreg);
+
 		break;
 	case OFONO_VENDOR_NOKIA:
 	case OFONO_VENDOR_SAMSUNG:
@@ -2145,6 +2210,9 @@ static void at_netreg_remove(struct ofono_netreg *net=
reg)
 	if (nd->nitz_timeout)
 		g_source_remove(nd->nitz_timeout);
 =

+	if (nd->csq_source)
+		g_source_remove(nd->csq_source);
+
 	ofono_netreg_set_data(netreg, NULL);
 =

 	g_at_chat_unref(nd->chat);
diff --git a/drivers/atmodem/sim.c b/drivers/atmodem/sim.c
index 0907635..2ce72c8 100644
--- a/drivers/atmodem/sim.c
+++ b/drivers/atmodem/sim.c
@@ -66,7 +66,7 @@ static const char *oercn_prefix[] =3D { "_OERCN:", NULL };
 static const char *cpinr_prefixes[] =3D { "+CPINR:", "+CPINRE:", NULL };
 static const char *epin_prefix[] =3D { "*EPIN:", NULL };
 static const char *simcom_spic_prefix[] =3D { "+SPIC:", NULL };
-static const char *cinterion_spic_prefix[] =3D { "^SPIC:", NULL };
+static const char *gemalto_spic_prefix[] =3D { "^SPIC:", NULL };
 static const char *pct_prefix[] =3D { "#PCT:", NULL };
 static const char *pnnm_prefix[] =3D { "+PNNM:", NULL };
 static const char *qpinc_prefix[] =3D { "+QPINC:", NULL };
@@ -1110,7 +1110,7 @@ error:
 	CALLBACK_WITH_FAILURE(cb, NULL, cbd->data);
 }
 =

-static void cinterion_spic_cb(gboolean ok, GAtResult *result,
+static void gemalto_spic_cb(gboolean ok, GAtResult *result,
 							gpointer user_data)
 {
 	struct cb_data *cbd =3D user_data;
@@ -1227,9 +1227,9 @@ static void at_pin_retries_query(struct ofono_sim *si=
m,
 					upincnt_cb, cbd, g_free) > 0)
 			return;
 		break;
-	case OFONO_VENDOR_CINTERION:
-		if (g_at_chat_send(sd->chat, "AT^SPIC", cinterion_spic_prefix,
-					cinterion_spic_cb, cbd, g_free) > 0)
+	case OFONO_VENDOR_GEMALTO:
+		if (g_at_chat_send(sd->chat, "AT^SPIC", gemalto_spic_prefix,
+					gemalto_spic_cb, cbd, g_free) > 0)
 			return;
 		break;
 	default:
diff --git a/drivers/atmodem/sms.c b/drivers/atmodem/sms.c
index 7e78fcf..64d0f6e 100644
--- a/drivers/atmodem/sms.c
+++ b/drivers/atmodem/sms.c
@@ -219,10 +219,16 @@ static void at_cmgs(struct ofono_sms *sms, const unsi=
gned char *pdu,
 	char buf[512];
 	int len;
 =

-	if (mms) {
-		snprintf(buf, sizeof(buf), "AT+CMMS=3D%d", mms);
-		g_at_chat_send(data->chat, buf, none_prefix,
-				NULL, NULL, NULL);
+	switch(data->vendor) {
+	case OFONO_VENDOR_GEMALTO:
+		break;
+	default:
+		if (mms) {
+			snprintf(buf, sizeof(buf), "AT+CMMS=3D%d", mms);
+			g_at_chat_send(data->chat, buf, none_prefix,
+					NULL, NULL, NULL);
+		}
+		break;
 	}
 =

 	len =3D snprintf(buf, sizeof(buf), "AT+CMGS=3D%d\r", tpdu_len);
@@ -329,7 +335,7 @@ static inline void at_ack_delivery(struct ofono_sms *sm=
s)
 	/* We must acknowledge the PDU using CNMA */
 	if (data->cnma_ack_pdu) {
 		switch (data->vendor) {
-		case OFONO_VENDOR_CINTERION:
+		case OFONO_VENDOR_GEMALTO:
 			snprintf(buf, sizeof(buf), "AT+CNMA=3D1");
 			break;
 		default:
@@ -411,10 +417,10 @@ static void at_cmt_notify(GAtResult *result, gpointer=
 user_data)
 		goto err;
 =

 	switch (data->vendor) {
-	case OFONO_VENDOR_CINTERION:
+	case OFONO_VENDOR_GEMALTO:
 		if (!g_at_result_iter_next_number(&iter, &tpdu_len)) {
 			/*
-			 * Some cinterions modems (ALS3,PLS8...), act in
+			 * Some Gemalto modems (ALS3,PLS8...), act in
 			 * accordance with 3GPP 27.005.  So we need to skip
 			 * the first (<alpha>) field
 			 *  \r\n+CMT: ,23\r\nCAFECAFECAFE... ...\r\n
@@ -455,6 +461,7 @@ static void at_cmt_notify(GAtResult *result, gpointer u=
ser_data)
 =

 	if (data->vendor !=3D OFONO_VENDOR_SIMCOM)
 		at_ack_delivery(sms);
+	return;
 =

 err:
 	ofono_error("Unable to parse CMT notification");
diff --git a/drivers/atmodem/vendor.h b/drivers/atmodem/vendor.h
index 721796e..abe2d89 100644
--- a/drivers/atmodem/vendor.h
+++ b/drivers/atmodem/vendor.h
@@ -49,4 +49,5 @@ enum ofono_vendor {
 	OFONO_VENDOR_UBLOX_TOBY_L2,
 	OFONO_VENDOR_CINTERION,
 	OFONO_VENDOR_XMM,
+	OFONO_VENDOR_GEMALTO,
 };
diff --git a/drivers/gemaltomodem/gemaltomodem.c b/drivers/gemaltomodem/gem=
altomodem.c
index 91cf238..7afd3c1 100644
--- a/drivers/gemaltomodem/gemaltomodem.c
+++ b/drivers/gemaltomodem/gemaltomodem.c
@@ -35,13 +35,16 @@
 static int gemaltomodem_init(void)
 {
 	gemalto_location_reporting_init();
-
+	gemaltowwan_gprs_context_init();
+	gemalto_voicecall_init();
 	return 0;
 }
 =

 static void gemaltomodem_exit(void)
 {
 	gemalto_location_reporting_exit();
+	gemaltowwan_gprs_context_exit();
+	gemalto_voicecall_exit();
 }
 =

 OFONO_PLUGIN_DEFINE(gemaltomodem, "Gemalto modem driver", VERSION,
diff --git a/drivers/gemaltomodem/gemaltomodem.h b/drivers/gemaltomodem/gem=
altomodem.h
index 7ea1e8f..183c370 100644
--- a/drivers/gemaltomodem/gemaltomodem.h
+++ b/drivers/gemaltomodem/gemaltomodem.h
@@ -19,7 +19,24 @@
  *
  */
 =

-#include <drivers/atmodem/atutil.h>
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
+
+#include <drivers/atmodem/atmodem.h>
 =

 extern void gemalto_location_reporting_init();
 extern void gemalto_location_reporting_exit();
+
+extern void gemaltowwan_gprs_context_init();
+extern void gemaltowwan_gprs_context_exit();
+
+extern void gemalto_voicecall_init();
+extern void gemalto_voicecall_exit();
diff --git a/drivers/gemaltomodem/gprs-context-wwan.c b/drivers/gemaltomode=
m/gprs-context-wwan.c
new file mode 100644
index 0000000..669e025
--- /dev/null
+++ b/drivers/gemaltomodem/gprs-context-wwan.c
@@ -0,0 +1,445 @@
+/*
+ *
+ *  oFono - Open Source Telephony
+ *
+ *  Copyright (C) 2017 Piotr Haber. All rights reserved.
+ *  Copyright (C) 2018 Sebastian Arnd. All rights reserved.
+ *  Copyright (C) 2018 Gemalto M2M
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
+#include <sys/stat.h>
+
+#include <glib.h>
+
+#include <ofono/log.h>
+#include <ofono/modem.h>
+#include <ofono/gprs-context.h>
+
+#include "gatchat.h"
+#include "gatresult.h"
+
+#include "gemaltomodem.h"
+
+static const char *none_prefix[] =3D { NULL };
+
+enum state {
+	STATE_IDLE,
+	STATE_ENABLING,
+	STATE_DISABLING,
+	STATE_ACTIVE,
+};
+
+struct gprs_context_data {
+	GAtChat *chat;
+	unsigned int active_context;
+	char username[OFONO_GPRS_MAX_USERNAME_LENGTH + 1];
+	char password[OFONO_GPRS_MAX_PASSWORD_LENGTH + 1];
+	enum ofono_gprs_auth_method auth_method;
+	enum state state;
+	enum ofono_gprs_proto proto;
+	char address[64];
+	char netmask[64];
+	char gateway[64];
+	char dns1[64];
+	char dns2[64];
+	ofono_gprs_context_cb_t cb;
+	void *cb_data;
+	int use_wwan;
+};
+
+static gboolean gemalto_get_auth_command(struct ofono_modem *modem, int ci=
d,
+				enum ofono_gprs_auth_method auth_method,
+				const char *username, const char *password,
+				char *buf, guint buflen)
+{
+	int gto_auth =3D ofono_modem_get_integer(modem, "Gemalto_Auth");
+	int len;
+	/*
+	 * 0: use cgauth
+	 * 1: use sgauth(pwd, user)
+	 * 2: use sgauth(user, pwd)
+	 */
+
+	int auth_type;
+
+	switch (auth_method) {
+	case OFONO_GPRS_AUTH_METHOD_PAP:
+		auth_type=3D1;
+		break;
+	case OFONO_GPRS_AUTH_METHOD_CHAP:
+		auth_type=3D2;
+		break;
+	case OFONO_GPRS_AUTH_METHOD_NONE:
+	default:
+		auth_type=3D0;
+		break;
+	}
+
+	if (auth_type !=3D 0 && (!*username || !*password))
+		return FALSE;
+
+	switch (gto_auth) {
+	case 1:
+	case 2:
+		len =3D snprintf(buf, buflen, "AT^SGAUTH=3D%d", cid);
+		break;
+	case 0:
+	default:
+		len =3D snprintf(buf, buflen, "AT+CGAUTH=3D%d", cid);
+		break;
+	}
+
+	buflen -=3D len;
+
+	switch(auth_type) {
+	case 0:
+
+		switch (gto_auth) {
+		case 2:
+			snprintf(buf+len, buflen, ",0,\"\",\"\"");
+			break;
+		case 0:
+		case 1:
+		default:
+			snprintf(buf+len, buflen, ",0");
+			break;
+		}
+		break;
+
+	case 1:
+	case 2:
+
+		switch (gto_auth) {
+		case 1:
+			snprintf(buf+len, buflen, ",%d,\"%s\",\"%s\"",
+					auth_type, password, username);
+			break;
+		case 0:
+		case 2:
+		default:
+			snprintf(buf+len, buflen, ",%d,\"%s\",\"%s\"",
+					auth_type, username, password);
+		}
+		break;
+
+	default:
+		return FALSE;
+	}
+
+	return TRUE;
+}
+
+static void gemalto_get_cgdcont_command(struct ofono_modem *modem,
+			guint cid, enum ofono_gprs_proto proto, const char *apn,
+							char *buf, guint buflen)
+{
+	int len =3D snprintf(buf, buflen, "AT+CGDCONT=3D%u", cid);
+	buflen-=3Dlen;
+
+	if(!apn) /* it will remove the context */
+		return;
+
+	switch (proto) {
+	case OFONO_GPRS_PROTO_IPV6:
+		snprintf(buf+len, buflen, ",\"IPV6\",\"%s\"", apn);
+		break;
+	case OFONO_GPRS_PROTO_IPV4V6:
+		snprintf(buf+len, buflen, ",\"IPV4V6\",\"%s\"", apn);
+		break;
+	case OFONO_GPRS_PROTO_IP:
+	default:
+		snprintf(buf+len, buflen, ",\"IP\",\"%s\"", apn);
+		break;
+	}
+}
+
+static void failed_setup(struct ofono_gprs_context *gc,
+				GAtResult *result, gboolean deactivate)
+{
+	struct gprs_context_data *gcd =3D ofono_gprs_context_get_data(gc);
+	struct ofono_error error;
+	char buf[64];
+
+	DBG("deactivate %d", deactivate);
+
+	if (deactivate =3D=3D TRUE) {
+
+		if(gcd->use_wwan)
+			sprintf(buf, "AT^SWWAN=3D0,%u", gcd->active_context);
+		else
+			sprintf(buf, "AT+CGACT=3D0,%u", gcd->active_context);
+
+		g_at_chat_send(gcd->chat, buf, none_prefix, NULL, NULL, NULL);
+	}
+
+	gcd->active_context =3D 0;
+	gcd->state =3D STATE_IDLE;
+
+	if (result =3D=3D NULL) {
+		CALLBACK_WITH_FAILURE(gcd->cb, gcd->cb_data);
+		return;
+	}
+
+	decode_at_error(&error, g_at_result_final_response(result));
+	gcd->cb(&error, gcd->cb_data);
+}
+
+static void activate_cb(gboolean ok, GAtResult *result, gpointer user_data)
+{
+	struct ofono_gprs_context *gc =3D user_data;
+	struct gprs_context_data *gcd =3D ofono_gprs_context_get_data(gc);
+
+	DBG("ok %d", ok);
+
+	if (!ok) {
+		ofono_error("Unable activate context");
+		/*
+		 * We've reported sucess already, so can't just call
+		 * failed_setup we call ofono_gprs_context_deactivated instead.
+		 * Thats not a clean solution at all, but as it seems there is
+		 * no clean way to determine whether it is possible to activate
+		 * the context before issuing AT^SWWAN. A possible workaround
+		 * might be to issue AT+CGACT=3D1 and AT+CGACT=3D0 and try if that
+		 * works, before calling CALLBACK_WITH_SUCCESS.
+		 */
+		ofono_gprs_context_deactivated(gc, gcd->active_context);
+		gcd->active_context =3D 0;
+		gcd->state =3D STATE_IDLE;
+		return;
+	}
+	/* We've reported sucess already */
+}
+
+static void setup_cb(gboolean ok, GAtResult *result, gpointer user_data)
+{
+	struct ofono_gprs_context *gc =3D user_data;
+	struct gprs_context_data *gcd =3D ofono_gprs_context_get_data(gc);
+	char buf[32 + OFONO_GPRS_MAX_USERNAME_LENGTH +
+					OFONO_GPRS_MAX_PASSWORD_LENGTH +1];
+	struct ofono_modem *modem =3D ofono_gprs_context_get_modem(gc);
+	const char *interface;
+
+	if (!ok) {
+		ofono_error("Failed to setup context");
+		failed_setup(gc, result, FALSE);
+		return;
+	}
+
+	if(gemalto_get_auth_command(modem, gcd->active_context, gcd->auth_method,
+			gcd->username, gcd->password, buf, sizeof(buf))) {
+		if (!g_at_chat_send(gcd->chat, buf, none_prefix, NULL, NULL,
+									NULL))
+		goto error;
+	}
+	/*
+	 * note that if the auth command is not ok we skip it and continue
+	 * but if the sending fails we do an error
+	 */
+
+	if(gcd->use_wwan)
+		sprintf(buf, "AT^SWWAN=3D1,%u", gcd->active_context);
+	else
+		sprintf(buf, "AT+CGACT=3D%u,1", gcd->active_context);
+
+	if (g_at_chat_send(gcd->chat, buf, none_prefix,
+					activate_cb, gc, NULL) > 0){
+
+		interface =3D ofono_modem_get_string(modem, "NetworkInterface");
+
+		ofono_gprs_context_set_interface(gc, interface);
+		ofono_gprs_context_set_ipv4_address(gc, NULL, FALSE);
+
+		/*
+		 * We report sucess already here because some modules need a
+		 * DHCP request to complete the AT^SWWAN command sucessfully
+		 */
+		gcd->state =3D STATE_ACTIVE;
+
+		CALLBACK_WITH_SUCCESS(gcd->cb, gcd->cb_data);
+
+		return;
+	}
+
+error:
+	failed_setup(gc, NULL, FALSE);
+}
+
+static void gemaltowwan_gprs_activate_primary(struct ofono_gprs_context *g=
c,
+				const struct ofono_gprs_primary_context *ctx,
+				ofono_gprs_context_cb_t cb, void *data)
+{
+	struct gprs_context_data *gcd =3D ofono_gprs_context_get_data(gc);
+	char buf[OFONO_GPRS_MAX_APN_LENGTH + 128];
+	struct ofono_modem *modem =3D ofono_gprs_context_get_modem(gc);
+
+	DBG("cid %u", ctx->cid);
+
+	gcd->use_wwan=3Dofono_modem_get_integer(modem, "Gemalto_WWAN");
+	gcd->active_context =3D ctx->cid;
+	gcd->cb =3D cb;
+	gcd->cb_data =3D data;
+	memcpy(gcd->username, ctx->username, sizeof(ctx->username));
+	memcpy(gcd->password, ctx->password, sizeof(ctx->password));
+	gcd->state =3D STATE_ENABLING;
+	gcd->proto =3D ctx->proto;
+	gcd->auth_method =3D ctx->auth_method;
+
+	gemalto_get_cgdcont_command(modem, ctx->cid, ctx->proto, ctx->apn, buf,
+								sizeof(buf));
+
+	if (g_at_chat_send(gcd->chat, buf, none_prefix,
+				setup_cb, gc, NULL) > 0)
+		return;
+
+	CALLBACK_WITH_FAILURE(cb, data);
+}
+
+static void deactivate_cb(gboolean ok, GAtResult *result, gpointer user_da=
ta)
+{
+	struct ofono_gprs_context *gc =3D user_data;
+	struct gprs_context_data *gcd =3D ofono_gprs_context_get_data(gc);
+
+	DBG("ok %d", ok);
+
+	gcd->active_context =3D 0;
+	gcd->state =3D STATE_IDLE;
+
+	CALLBACK_WITH_SUCCESS(gcd->cb, gcd->cb_data);
+}
+
+static void gemaltowwan_gprs_deactivate_primary(struct ofono_gprs_context =
*gc,
+					unsigned int cid,
+					ofono_gprs_context_cb_t cb, void *data)
+{
+	struct gprs_context_data *gcd =3D ofono_gprs_context_get_data(gc);
+	char buf[64];
+
+	DBG("cid %u", cid);
+
+	gcd->state =3D STATE_DISABLING;
+	gcd->cb =3D cb;
+	gcd->cb_data =3D data;
+
+	if(gcd->use_wwan)
+		sprintf(buf, "AT^SWWAN=3D0,%u", gcd->active_context);
+	else
+		sprintf(buf, "AT+CGACT=3D%u,0", gcd->active_context);
+
+	if (g_at_chat_send(gcd->chat, buf, none_prefix,
+				deactivate_cb, gc, NULL) > 0)
+		return;
+
+	CALLBACK_WITH_SUCCESS(cb, data);
+}
+
+static void cgev_notify(GAtResult *result, gpointer user_data)
+{
+	struct ofono_gprs_context *gc =3D user_data;
+	struct gprs_context_data *gcd =3D ofono_gprs_context_get_data(gc);
+	const char *event;
+	int cid =3D 0;
+	GAtResultIter iter;
+
+	g_at_result_iter_init(&iter, result);
+
+	if (!g_at_result_iter_next(&iter, "+CGEV:"))
+		return;
+
+	if (!g_at_result_iter_next_unquoted_string(&iter, &event))
+		return;
+
+	if (!g_str_has_prefix(event, "ME PDN DEACT"))
+		return;
+
+	sscanf(event, "%*s %*s %*s %u", &cid);
+
+	DBG("cid %d", cid);
+
+	if ((unsigned int) cid !=3D gcd->active_context)
+		return;
+
+	ofono_gprs_context_deactivated(gc, gcd->active_context);
+
+	gcd->active_context =3D 0;
+	gcd->state =3D STATE_IDLE;
+}
+
+static int gemaltowwan_gprs_context_probe(struct ofono_gprs_context *gc,
+					unsigned int model, void *data)
+{
+	GAtChat *chat =3D data;
+	struct gprs_context_data *gcd;
+	struct ofono_modem *modem =3D ofono_gprs_context_get_modem(gc);
+
+	DBG("");
+
+	gcd =3D g_try_new0(struct gprs_context_data, 1);
+	if (gcd =3D=3D NULL)
+		return -ENOMEM;
+
+	if(modem)
+		gcd->use_wwan=3Dofono_modem_get_integer(modem, "Gemalto_WWAN");
+	gcd->chat =3D g_at_chat_clone(chat);
+	ofono_gprs_context_set_data(gc, gcd);
+	g_at_chat_register(chat, "+CGEV:", cgev_notify, FALSE, gc, NULL);
+
+	return 0;
+}
+
+static void gemaltowwan_gprs_context_remove(struct ofono_gprs_context *gc)
+{
+	struct gprs_context_data *gcd =3D ofono_gprs_context_get_data(gc);
+
+	DBG("");
+
+	ofono_gprs_context_set_data(gc, NULL);
+
+	g_at_chat_unref(gcd->chat);
+	g_free(gcd);
+}
+
+static void gemaltowwan_gprs_detach_shutdown(struct ofono_gprs_context *gc,
+					unsigned int cid)
+{
+	DBG("cid %u", cid);
+
+	ofono_gprs_context_deactivated(gc, cid);
+}
+
+static struct ofono_gprs_context_driver driver =3D {
+	.name			=3D "gemaltowwanmodem",
+	.probe			=3D gemaltowwan_gprs_context_probe,
+	.remove			=3D gemaltowwan_gprs_context_remove,
+	.activate_primary	=3D gemaltowwan_gprs_activate_primary,
+	.deactivate_primary	=3D gemaltowwan_gprs_deactivate_primary,
+	.detach_shutdown	=3D gemaltowwan_gprs_detach_shutdown,
+};
+
+void gemaltowwan_gprs_context_init(void)
+{
+	ofono_gprs_context_driver_register(&driver);
+}
+
+void gemaltowwan_gprs_context_exit(void)
+{
+	ofono_gprs_context_driver_unregister(&driver);
+}
diff --git a/drivers/gemaltomodem/voicecall.c b/drivers/gemaltomodem/voicec=
all.c
new file mode 100644
index 0000000..e67da92
--- /dev/null
+++ b/drivers/gemaltomodem/voicecall.c
@@ -0,0 +1,965 @@
+/*
+ *
+ *  oFono - Open Source Telephony
+ *
+ *  Copyright (C) 2008-2011  Intel Corporation. All rights reserved.
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
+#include <ofono/voicecall.h>
+
+#include "gatchat.h"
+#include "gatresult.h"
+
+#include "common.h"
+
+#include "gemaltomodem.h"
+
+static const char *clcc_prefix[] =3D { "+CLCC:", NULL };
+static const char *none_prefix[] =3D { NULL };
+
+/* According to 27.007 COLP is an intermediate status for ATD */
+static const char *atd_prefix[] =3D { "+COLP:", NULL };
+
+#define FLAG_NEED_CLIP 1
+
+struct voicecall_data {
+	GAtChat *chat;
+	GSList *calls;
+	unsigned int local_release;
+	unsigned int vendor;
+	unsigned char flags;
+};
+
+struct release_id_req {
+	struct ofono_voicecall *vc;
+	ofono_voicecall_cb_t cb;
+	void *data;
+	int id;
+};
+
+struct change_state_req {
+	struct ofono_voicecall *vc;
+	ofono_voicecall_cb_t cb;
+	void *data;
+	int affected_types;
+};
+
+static void generic_cb(gboolean ok, GAtResult *result, gpointer user_data)
+{
+	struct change_state_req *req =3D user_data;
+	struct voicecall_data *vd =3D ofono_voicecall_get_data(req->vc);
+	struct ofono_error error;
+
+	decode_at_error(&error, g_at_result_final_response(result));
+
+	if (ok && req->affected_types) {
+		GSList *l;
+		struct ofono_call *call;
+
+		for (l =3D vd->calls; l; l =3D l->next) {
+			call =3D l->data;
+
+			if (req->affected_types & (1 << call->status))
+				vd->local_release |=3D (1 << call->id);
+		}
+	}
+
+	req->cb(&error, req->data);
+}
+
+static void gemalto_template(const char *cmd, struct ofono_voicecall *vc,
+			GAtResultFunc result_cb, unsigned int affected_types,
+			ofono_voicecall_cb_t cb, void *data)
+{
+	struct voicecall_data *vd =3D ofono_voicecall_get_data(vc);
+	struct change_state_req *req =3D g_try_new0(struct change_state_req, 1);
+
+	if (req =3D=3D NULL)
+		goto error;
+
+	req->vc =3D vc;
+	req->cb =3D cb;
+	req->data =3D data;
+	req->affected_types =3D affected_types;
+
+	if (g_at_chat_send(vd->chat, cmd, none_prefix,
+				result_cb, req, g_free) > 0)
+		return;
+
+error:
+	g_free(req);
+
+	CALLBACK_WITH_FAILURE(cb, data);
+}
+
+static void gemalto_answer(struct ofono_voicecall *vc,
+			ofono_voicecall_cb_t cb, void *data)
+{
+	gemalto_template("ATA", vc, generic_cb, 0, cb, data);
+}
+
+static void gemalto_hangup_all(struct ofono_voicecall *vc,
+			ofono_voicecall_cb_t cb, void *data)
+{
+	unsigned int affected =3D (1 << CALL_STATUS_INCOMING) |
+				(1 << CALL_STATUS_DIALING) |
+				(1 << CALL_STATUS_ALERTING) |
+				(1 << CALL_STATUS_WAITING) |
+				(1 << CALL_STATUS_HELD) |
+				(1 << CALL_STATUS_ACTIVE);
+
+	/* Hangup all calls */
+	gemalto_template("AT+CHUP", vc, generic_cb, affected, cb, data);
+}
+
+static void gemalto_hangup(struct ofono_voicecall *vc,
+			ofono_voicecall_cb_t cb, void *data)
+{
+	unsigned int affected =3D (1 << CALL_STATUS_ACTIVE);
+
+	/* Hangup current active call */
+	gemalto_template("AT+CHLD=3D1", vc, generic_cb, affected, cb, data);
+}
+
+static void gemalto_hold_all_active(struct ofono_voicecall *vc,
+				ofono_voicecall_cb_t cb, void *data)
+{
+	unsigned int affected =3D (1 << CALL_STATUS_ACTIVE);
+	gemalto_template("AT+CHLD=3D2", vc, generic_cb, affected, cb, data);
+}
+
+static void gemalto_release_all_held(struct ofono_voicecall *vc,
+				ofono_voicecall_cb_t cb, void *data)
+{
+	unsigned int affected =3D (1 << CALL_STATUS_INCOMING) |
+				(1 << CALL_STATUS_WAITING);
+
+	gemalto_template("AT+CHLD=3D0", vc, generic_cb, affected, cb, data);
+}
+
+static void gemalto_set_udub(struct ofono_voicecall *vc,
+			ofono_voicecall_cb_t cb, void *data)
+{
+	unsigned int affected =3D (1 << CALL_STATUS_INCOMING) |
+				(1 << CALL_STATUS_WAITING);
+
+	gemalto_template("AT+CHLD=3D0", vc, generic_cb, affected, cb, data);
+}
+
+static void gemalto_release_all_active(struct ofono_voicecall *vc,
+					ofono_voicecall_cb_t cb, void *data)
+{
+	unsigned int affected =3D (1 << CALL_STATUS_ACTIVE);
+
+	gemalto_template("AT+CHLD=3D1", vc, generic_cb, affected, cb, data);
+}
+
+static void release_id_cb(gboolean ok, GAtResult *result,
+				gpointer user_data)
+{
+	struct release_id_req *req =3D user_data;
+	struct voicecall_data *vd =3D ofono_voicecall_get_data(req->vc);
+	struct ofono_error error;
+
+	decode_at_error(&error, g_at_result_final_response(result));
+
+	if (ok)
+		vd->local_release =3D 1 << req->id;
+
+	req->cb(&error, req->data);
+}
+
+static void gemalto_release_specific(struct ofono_voicecall *vc, int id,
+				ofono_voicecall_cb_t cb, void *data)
+{
+	struct voicecall_data *vd =3D ofono_voicecall_get_data(vc);
+	struct release_id_req *req =3D g_try_new0(struct release_id_req, 1);
+	char buf[32];
+
+	if (req =3D=3D NULL)
+		goto error;
+
+	req->vc =3D vc;
+	req->cb =3D cb;
+	req->data =3D data;
+	req->id =3D id;
+
+	snprintf(buf, sizeof(buf), "AT+CHLD=3D1%d", id);
+
+	if (g_at_chat_send(vd->chat, buf, none_prefix,
+				release_id_cb, req, g_free) > 0)
+		return;
+
+error:
+	g_free(req);
+
+	CALLBACK_WITH_FAILURE(cb, data);
+}
+
+static void gemalto_private_chat(struct ofono_voicecall *vc, int id,
+				ofono_voicecall_cb_t cb, void *data)
+{
+	char buf[32];
+
+	snprintf(buf, sizeof(buf), "AT+CHLD=3D2%d", id);
+	gemalto_template(buf, vc, generic_cb, 0, cb, data);
+}
+
+static void gemalto_create_multiparty(struct ofono_voicecall *vc,
+					ofono_voicecall_cb_t cb, void *data)
+{
+	gemalto_template("AT+CHLD=3D3", vc, generic_cb, 0, cb, data);
+}
+
+static void gemalto_transfer(struct ofono_voicecall *vc,
+			ofono_voicecall_cb_t cb, void *data)
+{
+	/* Held & Active */
+	unsigned int affected =3D (1 << CALL_STATUS_ACTIVE) |
+				(1 << CALL_STATUS_HELD);
+
+	/* Transfer can puts held & active calls together and disconnects
+	 * from both.  However, some networks support transferring of
+	 * dialing/ringing calls as well.
+	 */
+	affected |=3D (1 << CALL_STATUS_DIALING) |
+				(1 << CALL_STATUS_ALERTING);
+
+	gemalto_template("AT+CHLD=3D4", vc, generic_cb, affected, cb, data);
+}
+
+static void gemalto_send_dtmf(struct ofono_voicecall *vc, const char *dtmf,
+			ofono_voicecall_cb_t cb, void *data)
+{
+	struct voicecall_data *vd =3D ofono_voicecall_get_data(vc);
+	int len =3D strlen(dtmf);
+	int s;
+	int i;
+	char *buf;
+	struct ofono_modem *modem =3D ofono_voicecall_get_modem(vc);
+	int use_quotes =3D ofono_modem_get_integer(modem, "Gemalto_VTS_quotes");
+
+	/* strlen("+VTS=3D\"T\";") =3D 9 + initial AT + null */
+	buf =3D g_try_new(char, len * 9 + 3);
+
+	if (buf =3D=3D NULL) {
+		CALLBACK_WITH_FAILURE(cb, data);
+		return;
+	}
+
+	if(use_quotes)
+		s =3D sprintf(buf, "AT+VTS=3D\"%c\"", dtmf[0]);
+	else
+		s =3D sprintf(buf, "AT+VTS=3D%c", dtmf[0]);
+
+	for (i =3D 1; i < len; i++) {
+
+		if(use_quotes)
+			s +=3D sprintf(buf + s, ";+VTS=3D\"%c\"", dtmf[i]);
+		else
+			s +=3D sprintf(buf + s, ";+VTS=3D%c", dtmf[i]);
+	}
+
+	g_at_chat_send(vd->chat, buf, NULL, NULL, NULL, NULL);
+	g_free(buf);
+}
+
+static struct ofono_call *create_call(struct ofono_voicecall *vc, int type,
+					int direction, int status,
+					const char *num, int num_type, int clip)
+{
+	struct voicecall_data *d =3D ofono_voicecall_get_data(vc);
+	struct ofono_call *call;
+
+	/* Generate a call structure for the waiting call */
+	call =3D g_try_new(struct ofono_call, 1);
+	if (call =3D=3D NULL)
+		return NULL;
+
+	ofono_call_init(call);
+
+	call->id =3D ofono_voicecall_get_next_callid(vc);
+	call->type =3D type;
+	call->direction =3D direction;
+	call->status =3D status;
+
+	if (clip !=3D 2) {
+		strncpy(call->phone_number.number, num,
+			OFONO_MAX_PHONE_NUMBER_LENGTH);
+		call->phone_number.type =3D num_type;
+	}
+
+	call->clip_validity =3D clip;
+	call->cnap_validity =3D CNAP_VALIDITY_NOT_AVAILABLE;
+
+	d->calls =3D g_slist_insert_sorted(d->calls, call, at_util_call_compare);
+
+	return call;
+}
+
+static void atd_cb(gboolean ok, GAtResult *result, gpointer user_data)
+{
+	struct cb_data *cbd =3D user_data;
+	struct ofono_voicecall *vc =3D cbd->user;
+	struct voicecall_data *vd =3D ofono_voicecall_get_data(vc);
+	ofono_voicecall_cb_t cb =3D cbd->cb;
+	GAtResultIter iter;
+	const char *num;
+	int type =3D 128;
+	int validity =3D 2;
+	struct ofono_error error;
+	struct ofono_call *call;
+	GSList *l;
+
+	decode_at_error(&error, g_at_result_final_response(result));
+
+	if (!ok)
+		goto out;
+
+	/* On a success, make sure to put all active calls on hold */
+	for (l =3D vd->calls; l; l =3D l->next) {
+		call =3D l->data;
+
+		if (call->status !=3D CALL_STATUS_ACTIVE)
+			continue;
+
+		call->status =3D CALL_STATUS_HELD;
+		ofono_voicecall_notify(vc, call);
+	}
+
+	g_at_result_iter_init(&iter, result);
+
+	if (g_at_result_iter_next(&iter, "+COLP:")) {
+		g_at_result_iter_next_string(&iter, &num);
+		g_at_result_iter_next_number(&iter, &type);
+
+		if (strlen(num) > 0)
+			validity =3D 0;
+		else
+			validity =3D 2;
+
+		DBG("colp_notify: %s %d %d", num, type, validity);
+	}
+
+	/* Generate a voice call that was just dialed, we guess the ID */
+	call =3D create_call(vc, 0, 0, CALL_STATUS_DIALING, num, type, validity);
+	if (call =3D=3D NULL) {
+		ofono_error("Unable to malloc, call tracking will fail!");
+		return;
+	}
+
+	/* oFono core will generate a call with the dialed number
+	 * inside its dial callback.  Unless we got COLP information
+	 * we do not need to communicate that a call is being
+	 * dialed
+	 */
+	if (validity !=3D 2)
+		ofono_voicecall_notify(vc, call);
+
+out:
+	cb(&error, cbd->data);
+}
+
+static void gemalto_dial(struct ofono_voicecall *vc,
+			const struct ofono_phone_number *ph,
+			enum ofono_clir_option clir, ofono_voicecall_cb_t cb,
+			void *data)
+{
+	struct voicecall_data *vd =3D ofono_voicecall_get_data(vc);
+	struct cb_data *cbd =3D cb_data_new(cb, data);
+	char buf[256];
+
+	cbd->user =3D vc;
+
+	if (ph->type =3D=3D 145)
+		snprintf(buf, sizeof(buf), "ATD+%s", ph->number);
+	else
+		snprintf(buf, sizeof(buf), "ATD%s", ph->number);
+
+	switch (clir) {
+	case OFONO_CLIR_OPTION_INVOCATION:
+		strcat(buf, "I");
+		break;
+	case OFONO_CLIR_OPTION_SUPPRESSION:
+		strcat(buf, "i");
+		break;
+	default:
+		break;
+	}
+
+	strcat(buf, ";");
+
+	if (g_at_chat_send(vd->chat, buf, atd_prefix,
+				atd_cb, cbd, g_free) > 0)
+		return;
+
+	g_free(cbd);
+
+	CALLBACK_WITH_FAILURE(cb, data);
+}
+
+static GSList *gemalto_parse_slcc(GAtResult *result, unsigned int *ret_mpt=
y_ids)
+{
+	GAtResultIter iter;
+	GSList *l =3D NULL;
+	int id, dir, status, type;
+	ofono_bool_t mpty;
+	struct ofono_call *call;
+	unsigned int mpty_ids =3D 0;
+
+	g_at_result_iter_init(&iter, result);
+
+	while (g_at_result_iter_next(&iter, "+CLCC:")) {
+		const char *str =3D "";
+		int number_type =3D 129;
+
+		if (!g_at_result_iter_next_number(&iter, &id))
+			continue;
+
+		if (id =3D=3D 0)
+			continue;
+
+		if (!g_at_result_iter_next_number(&iter, &dir))
+			continue;
+
+		if (!g_at_result_iter_next_number(&iter, &status))
+			continue;
+
+		if (status > 5)
+			continue;
+
+		if (!g_at_result_iter_next_number(&iter, &type))
+			continue;
+
+		if (!g_at_result_iter_next_number(&iter, &mpty))
+			continue;
+
+		/* skip 'Reserved=3D0' parameter, only difference from CLCC */
+		if (!g_at_result_iter_skip_next(&iter))
+			continue;
+
+		if (g_at_result_iter_next_string(&iter, &str))
+			g_at_result_iter_next_number(&iter, &number_type);
+
+		call =3D g_try_new(struct ofono_call, 1);
+		if (call =3D=3D NULL)
+			break;
+
+		ofono_call_init(call);
+
+		call->id =3D id;
+		call->direction =3D dir;
+		call->status =3D status;
+		call->type =3D type;
+		strncpy(call->phone_number.number, str,
+				OFONO_MAX_PHONE_NUMBER_LENGTH);
+		call->phone_number.type =3D number_type;
+
+		if (strlen(call->phone_number.number) > 0)
+			call->clip_validity =3D 0;
+		else
+			call->clip_validity =3D 2;
+
+		l =3D g_slist_insert_sorted(l, call, at_util_call_compare);
+
+		if (mpty)
+			mpty_ids |=3D 1 << id;
+	}
+
+	if (ret_mpty_ids)
+		*ret_mpty_ids =3D mpty_ids;
+
+	return l;
+}
+
+static void clcc_cb(gboolean ok, GAtResult *result, gpointer user_data)
+{
+	struct ofono_voicecall *vc =3D user_data;
+	struct voicecall_data *vd =3D ofono_voicecall_get_data(vc);
+	GSList *l;
+
+	if (!ok)
+		return;
+
+	vd->calls =3D at_util_parse_clcc(result, NULL);
+
+	for (l =3D vd->calls; l; l =3D l->next)
+		ofono_voicecall_notify(vc, l->data);
+}
+
+static void slcc_notify(GAtResult *result, gpointer user_data)
+{
+	struct ofono_voicecall *vc =3D user_data;
+	struct voicecall_data *vd =3D ofono_voicecall_get_data(vc);
+	GSList *calls;
+	GSList *n, *o;
+	struct ofono_call *nc, *oc;
+
+	calls =3D gemalto_parse_slcc(result, NULL);
+
+	n =3D calls;
+	o =3D vd->calls;
+
+	while (n || o) {
+		nc =3D n ? n->data : NULL;
+		oc =3D o ? o->data : NULL;
+
+		if (oc && (nc =3D=3D NULL || (nc->id > oc->id))) {
+			enum ofono_disconnect_reason reason;
+
+			if (vd->local_release & (1 << oc->id))
+				reason =3D OFONO_DISCONNECT_REASON_LOCAL_HANGUP;
+			else
+				reason =3D OFONO_DISCONNECT_REASON_REMOTE_HANGUP;
+
+			if (!oc->type)
+				ofono_voicecall_disconnected(vc, oc->id,
+								reason, NULL);
+
+			o =3D o->next;
+		} else if (nc && (oc =3D=3D NULL || (nc->id < oc->id))) {
+
+			if (nc->type =3D=3D 0) /* new call, signal it */
+				ofono_voicecall_notify(vc, nc);
+
+			n =3D n->next;
+		} else {
+			/*
+			 * Always use the clip_validity from old call
+			 * the only place this is truly told to us is
+			 * in the CLIP notify, the rest are fudged
+			 * anyway.  Useful when RING, CLIP is used,
+			 * and we're forced to use CLCC/SLCC and clip_validity
+			 * is 1
+			 */
+			if (oc->clip_validity =3D=3D 1)
+				nc->clip_validity =3D oc->clip_validity;
+
+			/*
+			 * CNAP doesn't arrive as part of CLCC, always
+			 * re-use from the old call
+			 */
+			strncpy(nc->name, oc->name,
+					OFONO_MAX_CALLER_NAME_LENGTH);
+			nc->name[OFONO_MAX_CALLER_NAME_LENGTH] =3D '\0';
+			nc->cnap_validity =3D oc->cnap_validity;
+
+			/*
+			 * CDIP doesn't arrive as part of CLCC, always
+			 * re-use from the old call
+			 */
+			memcpy(&nc->called_number, &oc->called_number,
+					sizeof(oc->called_number));
+
+			/*
+			 * If the CLIP is not provided and the CLIP never
+			 * arrives, or RING is used, then signal the call
+			 * here
+			 */
+			if (nc->status =3D=3D CALL_STATUS_INCOMING &&
+					(vd->flags & FLAG_NEED_CLIP)) {
+				if (nc->type =3D=3D 0)
+					ofono_voicecall_notify(vc, nc);
+
+				vd->flags &=3D ~FLAG_NEED_CLIP;
+			} else if (memcmp(nc, oc, sizeof(*nc)) && nc->type =3D=3D 0)
+				ofono_voicecall_notify(vc, nc);
+
+			n =3D n->next;
+			o =3D o->next;
+		}
+	}
+
+	g_slist_free_full(vd->calls, g_free);
+
+	vd->calls =3D calls;
+
+	vd->local_release =3D 0;
+}
+
+static void ring_notify(GAtResult *result, gpointer user_data)
+{
+	struct ofono_voicecall *vc =3D user_data;
+	struct voicecall_data *vd =3D ofono_voicecall_get_data(vc);
+	struct ofono_call *call;
+
+	/* See comment in CRING */
+	if (g_slist_find_custom(vd->calls,
+				GINT_TO_POINTER(CALL_STATUS_WAITING),
+				at_util_call_compare_by_status))
+		return;
+
+	/* RING can repeat, ignore if we already have an incoming call */
+	if (g_slist_find_custom(vd->calls,
+				GINT_TO_POINTER(CALL_STATUS_INCOMING),
+				at_util_call_compare_by_status))
+		return;
+
+	/* Generate an incoming call of unknown type */
+	call =3D create_call(vc, 9, 1, CALL_STATUS_INCOMING, NULL, 128, 2);
+	if (call =3D=3D NULL) {
+		ofono_error("Couldn't create call!");
+		return;
+	}
+
+	/* We don't know the call type, we must wait for the SLCC URC */
+	vd->flags =3D FLAG_NEED_CLIP;
+}
+
+static void cring_notify(GAtResult *result, gpointer user_data)
+{
+	struct ofono_voicecall *vc =3D user_data;
+	struct voicecall_data *vd =3D ofono_voicecall_get_data(vc);
+	GAtResultIter iter;
+	const char *line;
+	int type;
+
+	/* Handle the following situation:
+	 * Active Call + Waiting Call.  Active Call is Released.  The Waiting
+	 * call becomes Incoming and RING/CRING indications are signaled.
+	 * Sometimes these arrive before we get the SLCC URC to find about
+	 * the stage change.  If this happens, simply ignore the RING/CRING
+	 * when a waiting call exists (cannot have waiting + incoming in GSM)
+	 */
+	if (g_slist_find_custom(vd->calls,
+				GINT_TO_POINTER(CALL_STATUS_WAITING),
+				at_util_call_compare_by_status))
+		return;
+
+	/* CRING can repeat, ignore if we already have an incoming call */
+	if (g_slist_find_custom(vd->calls,
+				GINT_TO_POINTER(CALL_STATUS_INCOMING),
+				at_util_call_compare_by_status))
+		return;
+
+	g_at_result_iter_init(&iter, result);
+
+	if (!g_at_result_iter_next(&iter, "+CRING:"))
+		return;
+
+	line =3D g_at_result_iter_raw_line(&iter);
+	if (line =3D=3D NULL)
+		return;
+
+	/* Ignore everything that is not voice for now */
+	if (!strcasecmp(line, "VOICE"))
+		type =3D 0;
+	else
+		type =3D 9;
+
+	/* Generate an incoming call */
+	create_call(vc, type, 1, CALL_STATUS_INCOMING, NULL, 128, 2);
+
+	/* We have a call, and call type but don't know the number and
+	 * must wait for the CLIP to arrive before announcing the call.
+	 * And we wait also for SLCC. If the CLIP arrives
+	 * earlier, we announce the call there
+	 */
+	vd->flags =3D FLAG_NEED_CLIP;
+
+	DBG("");
+}
+
+static void clip_notify(GAtResult *result, gpointer user_data)
+{
+	struct ofono_voicecall *vc =3D user_data;
+	struct voicecall_data *vd =3D ofono_voicecall_get_data(vc);
+	GAtResultIter iter;
+	const char *num;
+	int type, validity;
+	GSList *l;
+	struct ofono_call *call;
+
+	l =3D g_slist_find_custom(vd->calls,
+				GINT_TO_POINTER(CALL_STATUS_INCOMING),
+				at_util_call_compare_by_status);
+	if (l =3D=3D NULL) {
+		ofono_error("CLIP for unknown call");
+		return;
+	}
+
+	/* We have already saw a CLIP for this call, no need to parse again */
+	if ((vd->flags & FLAG_NEED_CLIP) =3D=3D 0)
+		return;
+
+	g_at_result_iter_init(&iter, result);
+
+	if (!g_at_result_iter_next(&iter, "+CLIP:"))
+		return;
+
+	if (!g_at_result_iter_next_string(&iter, &num))
+		return;
+
+	if (!g_at_result_iter_next_number(&iter, &type))
+		return;
+
+	if (strlen(num) > 0)
+		validity =3D CLIP_VALIDITY_VALID;
+	else
+		validity =3D CLIP_VALIDITY_NOT_AVAILABLE;
+
+	/* Skip subaddr, satype and alpha */
+	g_at_result_iter_skip_next(&iter);
+	g_at_result_iter_skip_next(&iter);
+	g_at_result_iter_skip_next(&iter);
+
+	/* If we have CLI validity field, override our guessed value */
+	g_at_result_iter_next_number(&iter, &validity);
+
+	DBG("%s %d %d", num, type, validity);
+
+	call =3D l->data;
+
+	strncpy(call->phone_number.number, num,
+		OFONO_MAX_PHONE_NUMBER_LENGTH);
+	call->phone_number.number[OFONO_MAX_PHONE_NUMBER_LENGTH] =3D '\0';
+	call->phone_number.type =3D type;
+	call->clip_validity =3D validity;
+
+	if (call->type =3D=3D 0)
+		ofono_voicecall_notify(vc, call);
+
+	vd->flags &=3D ~FLAG_NEED_CLIP;
+}
+
+static int class_to_call_type(int cls)
+{
+	switch (cls) {
+	case 1:
+		return 0;
+	case 4:
+		return 2;
+	case 8:
+		return 9;
+	default:
+		return 1;
+	}
+}
+
+static void ccwa_notify(GAtResult *result, gpointer user_data)
+{
+	struct ofono_voicecall *vc =3D user_data;
+	struct voicecall_data *vd =3D ofono_voicecall_get_data(vc);
+	GAtResultIter iter;
+	const char *num;
+	int num_type, validity, cls;
+	struct ofono_call *call;
+
+	/* if CCWA is resent, ignore it the second time around */
+	if (g_slist_find_custom(vd->calls,
+				GINT_TO_POINTER(CALL_STATUS_WAITING),
+				at_util_call_compare_by_status))
+		return;
+
+	g_at_result_iter_init(&iter, result);
+
+	if (!g_at_result_iter_next(&iter, "+CCWA:"))
+		return;
+
+	if (!g_at_result_iter_next_string(&iter, &num))
+		return;
+
+	if (!g_at_result_iter_next_number(&iter, &num_type))
+		return;
+
+	if (!g_at_result_iter_next_number(&iter, &cls))
+		return;
+
+	/* Skip alpha field */
+	g_at_result_iter_skip_next(&iter);
+
+	if (strlen(num) > 0)
+		validity =3D 0;
+	else
+		validity =3D 2;
+
+	/* If we have CLI validity field, override our guessed value */
+	g_at_result_iter_next_number(&iter, &validity);
+
+	DBG("%s %d %d %d", num, num_type, cls, validity);
+
+	call =3D create_call(vc, class_to_call_type(cls), 1, CALL_STATUS_WAITING,
+				num, num_type, validity);
+	if (call =3D=3D NULL) {
+		ofono_error("Unable to malloc. Call management is fubar");
+		return;
+	}
+
+	if (call->type =3D=3D 0) /* Only notify voice calls */
+		ofono_voicecall_notify(vc, call);
+}
+
+static void cssi_notify(GAtResult *result, gpointer user_data)
+{
+	struct ofono_voicecall *vc =3D user_data;
+	GAtResultIter iter;
+	int code, index;
+
+	g_at_result_iter_init(&iter, result);
+
+	if (!g_at_result_iter_next(&iter, "+CSSI:"))
+		return;
+
+	if (!g_at_result_iter_next_number(&iter, &code))
+		return;
+
+	if (!g_at_result_iter_next_number(&iter, &index))
+		index =3D 0;
+
+	ofono_voicecall_ssn_mo_notify(vc, 0, code, index);
+}
+
+static void cssu_notify(GAtResult *result, gpointer user_data)
+{
+	struct ofono_voicecall *vc =3D user_data;
+	GAtResultIter iter;
+	int code;
+	int index;
+	const char *num;
+	struct ofono_phone_number ph;
+
+	ph.number[0] =3D '\0';
+	ph.type =3D 129;
+
+	g_at_result_iter_init(&iter, result);
+
+	if (!g_at_result_iter_next(&iter, "+CSSU:"))
+		return;
+
+	if (!g_at_result_iter_next_number(&iter, &code))
+		return;
+
+	if (!g_at_result_iter_next_number_default(&iter, -1, &index))
+		goto out;
+
+	if (!g_at_result_iter_next_string(&iter, &num))
+		goto out;
+
+	strncpy(ph.number, num, OFONO_MAX_PHONE_NUMBER_LENGTH);
+
+	if (!g_at_result_iter_next_number(&iter, &ph.type))
+		return;
+
+out:
+	ofono_voicecall_ssn_mt_notify(vc, 0, code, index, &ph);
+}
+
+static void gemalto_voicecall_initialized(gboolean ok, GAtResult *result,
+					gpointer user_data)
+{
+	struct ofono_voicecall *vc =3D user_data;
+	struct voicecall_data *vd =3D ofono_voicecall_get_data(vc);
+
+	DBG("voicecall_init: registering to notifications");
+
+	/* NO CARRIER, NO ANSWER, BUSY, NO DIALTONE are handled through SLCC */
+	g_at_chat_register(vd->chat, "^SLCC:", slcc_notify, FALSE, vc, NULL);
+	g_at_chat_register(vd->chat, "RING", ring_notify, FALSE, vc, NULL);
+	g_at_chat_register(vd->chat, "+CRING:", cring_notify, FALSE, vc, NULL);
+	g_at_chat_register(vd->chat, "+CLIP:", clip_notify, FALSE, vc, NULL);
+	g_at_chat_register(vd->chat, "+CCWA:", ccwa_notify, FALSE, vc, NULL);
+	g_at_chat_register(vd->chat, "+CSSI:", cssi_notify, FALSE, vc, NULL);
+	g_at_chat_register(vd->chat, "+CSSU:", cssu_notify, FALSE, vc, NULL);
+
+	ofono_voicecall_register(vc);
+
+	/* Populate the call list */
+	g_at_chat_send(vd->chat, "AT+CLCC", clcc_prefix, clcc_cb, vc, NULL);
+}
+
+static int gemalto_voicecall_probe(struct ofono_voicecall *vc,
+					unsigned int vendor, void *data)
+{
+	GAtChat *chat =3D data;
+	struct voicecall_data *vd;
+
+	vd =3D g_try_new0(struct voicecall_data, 1);
+
+	if (vd =3D=3D NULL)
+		return -ENOMEM;
+
+	vd->chat =3D g_at_chat_clone(chat);
+	vd->vendor =3D vendor;
+	ofono_voicecall_set_data(vc, vd);
+
+	// TODO: move to a config atom
+	g_at_chat_send(vd->chat, "AT^SNFS=3D5", NULL, NULL, NULL, NULL);
+
+	g_at_chat_send(vd->chat, "AT+CRC=3D1", NULL, NULL, NULL, NULL);
+	g_at_chat_send(vd->chat, "AT+COLP=3D1", NULL, NULL, NULL, NULL);
+	g_at_chat_send(vd->chat, "AT+CLIP=3D1", NULL, NULL, NULL, NULL);
+	g_at_chat_send(vd->chat, "AT+CCWA=3D1", NULL, NULL, NULL, NULL);
+	g_at_chat_send(vd->chat, "AT+CSSN=3D1,1", NULL, NULL, NULL, NULL);
+	g_at_chat_send(vd->chat, "AT^SLCC=3D1", NULL,
+				gemalto_voicecall_initialized, vc, NULL);
+	return 0;
+}
+
+static void gemalto_voicecall_remove(struct ofono_voicecall *vc)
+{
+	struct voicecall_data *vd =3D ofono_voicecall_get_data(vc);
+
+	ofono_voicecall_set_data(vc, NULL);
+
+	g_at_chat_unref(vd->chat);
+	g_free(vd);
+}
+
+static struct ofono_voicecall_driver driver =3D {
+	.name			=3D "gemaltomodem",
+	.probe			=3D gemalto_voicecall_probe,
+	.remove			=3D gemalto_voicecall_remove,
+	.dial			=3D gemalto_dial,
+	.answer			=3D gemalto_answer,
+	.hangup_all		=3D gemalto_hangup_all,
+	.hangup_active		=3D gemalto_hangup,
+	.hold_all_active	=3D gemalto_hold_all_active,
+	.release_all_held	=3D gemalto_release_all_held,
+	.set_udub		=3D gemalto_set_udub,
+	.release_all_active	=3D gemalto_release_all_active,
+	.release_specific	=3D gemalto_release_specific,
+	.private_chat		=3D gemalto_private_chat,
+	.create_multiparty	=3D gemalto_create_multiparty,
+	.transfer		=3D gemalto_transfer,
+	.deflect		=3D NULL,
+	.swap_without_accept	=3D NULL,
+	.send_tones		=3D gemalto_send_dtmf
+};
+
+void gemalto_voicecall_init(void)
+{
+	ofono_voicecall_driver_register(&driver);
+}
+
+void gemalto_voicecall_exit(void)
+{
+	ofono_voicecall_driver_unregister(&driver);
+}
diff --git a/drivers/mbimmodem/gprs-context.c b/drivers/mbimmodem/gprs-cont=
ext.c
index 79793c9..ce33b92 100644
--- a/drivers/mbimmodem/gprs-context.c
+++ b/drivers/mbimmodem/gprs-context.c
@@ -75,6 +75,8 @@ static uint32_t auth_method_to_auth_protocol(enum ofono_g=
prs_auth_method method)
 		return 2; /* MBIMAuthProtocolChap */
 	case OFONO_GPRS_AUTH_METHOD_PAP:
 		return 1; /* MBIMAuthProtocolPap */
+	default:
+		return 0;
 	}
 =

 	return 0;
diff --git a/drivers/mbimmodem/mbim.c b/drivers/mbimmodem/mbim.c
index 9fcf44b..f4132d0 100644
--- a/drivers/mbimmodem/mbim.c
+++ b/drivers/mbimmodem/mbim.c
@@ -781,6 +781,9 @@ static bool open_read_handler(struct l_io *io, void *us=
er_data)
 	/* Grab OPEN_DONE Status field */
 	if (l_get_le32(buf) !=3D 0) {
 		close(fd);
+		if (device->disconnect_handler)
+			device->disconnect_handler(device->ready_data);
+		device->is_ready =3D false;
 		return false;
 	}
 =

diff --git a/drivers/mbimmodem/mbimmodem.c b/drivers/mbimmodem/mbimmodem.c
index a4c9daa..2a01dd6 100644
--- a/drivers/mbimmodem/mbimmodem.c
+++ b/drivers/mbimmodem/mbimmodem.c
@@ -33,7 +33,7 @@ static int mbimmodem_init(void)
 	mbim_devinfo_init();
 	mbim_sim_init();
 	mbim_netreg_init();
-	mbim_sms_exit();
+	mbim_sms_init();
 	mbim_gprs_init();
 	mbim_gprs_context_init();
 	return 0;
diff --git a/drivers/rilmodem/call-forwarding.c b/drivers/rilmodem/call-for=
warding.c
index 4aff4d3..0bdab3f 100644
--- a/drivers/rilmodem/call-forwarding.c
+++ b/drivers/rilmodem/call-forwarding.c
@@ -38,7 +38,7 @@
 #include <ofono/call-forwarding.h>
 #include "common.h"
 =

-#pragma GCC diagnostic ignored "-Wrestrict"
+//#pragma GCC diagnostic ignored "-Wrestrict"
 =

 #include "gril.h"
 =

diff --git a/drivers/rilmodem/network-registration.c b/drivers/rilmodem/net=
work-registration.c
index 809b3bc..9895c6d 100644
--- a/drivers/rilmodem/network-registration.c
+++ b/drivers/rilmodem/network-registration.c
@@ -37,7 +37,7 @@
 #include <ofono/modem.h>
 #include <ofono/netreg.h>
 =

-#pragma GCC diagnostic ignored "-Wrestrict"
+//#pragma GCC diagnostic ignored "-Wrestrict"
 =

 #include <gril/gril.h>
 =

-- =

1.9.1


--===============4802050259171483707==--

