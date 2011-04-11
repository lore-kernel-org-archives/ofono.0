Content-Type: multipart/mixed; boundary="===============4572633809881687365=="
MIME-Version: 1.0
From: Vijay Nayani <vijay.nayani@elektrobit.com>
Subject: [RFC PATCH 17/20] atmodem: add lte specific functions
Date: Mon, 11 Apr 2011 13:20:15 +0300
Message-ID: <1302517218-2147-18-git-send-email-vijay.nayani@elektrobit.com>
In-Reply-To: <1302517218-2147-1-git-send-email-vijay.nayani@elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4572633809881687365==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Changes include: Registration of CEREG events,
registration status query based on registered
technology, handling of ME PDN ACT CGEV event,
reading of default context params and notification
of default context params to the core.
---
 drivers/atmodem/packet-service.c |  238 ++++++++++++++++++++++++++++++++++=
++++
 1 files changed, 238 insertions(+), 0 deletions(-)

diff --git a/drivers/atmodem/packet-service.c b/drivers/atmodem/packet-serv=
ice.c
index 9999d9d..b766a3b 100644
--- a/drivers/atmodem/packet-service.c
+++ b/drivers/atmodem/packet-service.c
@@ -4,6 +4,7 @@
  *
  *  Copyright (C) 2008-2010  Intel Corporation. All rights reserved.
  *  Copyright (C) 2010 ST-Ericsson AB.
+ *  Copyright 2011 EB(Elektrobit).
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2 as
@@ -40,17 +41,23 @@
 #include "gatchat.h"
 #include "gatresult.h"
 =

+#include  "common.h"
+
 #include "atmodem.h"
 #include "vendor.h"
 =

 static const char *cgreg_prefix[] =3D { "+CGREG:", NULL };
 static const char *cgdcont_prefix[] =3D { "+CGDCONT:", NULL };
+static const char *cereg_prefix[] =3D { "+CEREG:", NULL };
+static const char *cgcontrdp_prefix[] =3D { "+CGCONTRDP:", NULL };
 static const char *none_prefix[] =3D { NULL };
 =

 struct packet_service_data {
 	GAtChat *chat;
 	int default_cid;
 	int default_context_type;
+	int cid_min;
+	int cid_max;
 	unsigned int vendor;
 };
 =

@@ -109,6 +116,134 @@ static void at_cgreg_cb(gboolean ok, GAtResult *resul=
t, gpointer user_data)
 	cb(&error, status, cbd->data);
 }
 =

+static void at_cereg_cb(gboolean ok, GAtResult *result, gpointer user_data)
+{
+	struct cb_data *cbd =3D user_data;
+	ofono_packet_service_status_cb_t cb =3D cbd->cb;
+	struct ofono_error error;
+	int status;
+	struct packet_service_data *psd =3D cbd->user;
+
+	decode_at_error(&error, g_at_result_final_response(result));
+
+	if (!ok) {
+		cb(&error, -1, cbd->data);
+		return;
+	}
+
+	if (at_util_parse_reg(result, "+CEREG:", NULL, &status,
+				NULL, NULL, NULL, psd->vendor) =3D=3D FALSE) {
+		CALLBACK_WITH_FAILURE(cb, -1, cbd->data);
+		return;
+	}
+
+	cb(&error, status, cbd->data);
+}
+
+static void at_cgcontrdp_cb(gboolean ok, GAtResult *result, gpointer user_=
data)
+{
+	struct ofono_packet_service *ps =3D user_data;
+	struct packet_service_data *psd =3D ofono_packet_service_get_data(ps);
+	GAtResultIter iter;
+	int cid, bearer_id;
+	const char *apn, *address, *gateway, *dns1, *dns2;
+	const char *dns[3];
+	struct ofono_default_context_param *param;
+
+	if (!ok)
+		return;
+
+	g_at_result_iter_init(&iter, result);
+
+	if (g_at_result_iter_next(&iter, "+CGCONTRDP:") =3D=3D FALSE)
+		return;
+
+	if (g_at_result_iter_next_number(&iter, &cid) =3D=3D FALSE)
+		return;
+
+	if (g_at_result_iter_next_number(&iter, &bearer_id) =3D=3D FALSE)
+		return;
+
+	if (g_at_result_iter_next_string(&iter, &apn) =3D=3D FALSE)
+		return;
+
+	if (g_at_result_iter_next_string(&iter, &address) =3D=3D FALSE)
+		goto out;
+
+	if (g_at_result_iter_next_string(&iter, &gateway) =3D=3D FALSE)
+		goto out;
+
+	if (g_at_result_iter_next_string(&iter, &dns1) =3D=3D FALSE)
+		goto out;
+
+	if (g_at_result_iter_next_string(&iter, &dns2) =3D=3D FALSE)
+		goto out;
+
+	dns[0] =3D dns1;
+	dns[1] =3D dns2;
+	dns[2] =3D 0;
+
+out:
+	param =3D g_new0(struct ofono_default_context_param, 1);
+	if (param =3D=3D NULL)
+		return;
+
+	param->cid =3D cid;
+	param->proto =3D psd->default_context_type;
+	param->apn =3D apn;
+	param->address =3D address;
+	param->gateway =3D gateway;
+	param->dns =3D dns;
+
+	ofono_packet_service_default_context_notify(ps, param);
+
+	g_free(param);
+	param =3D NULL;
+}
+
+static void at_cgdcont_cb(gboolean ok, GAtResult *result, gpointer user_da=
ta)
+{
+	struct ofono_packet_service *ps =3D user_data;
+	struct packet_service_data *psd =3D ofono_packet_service_get_data(ps);
+	GAtResultIter iter;
+	int cid;
+	const char *pdp_type;
+	char buf[64];
+	gboolean found =3D FALSE;
+
+	if (!ok)
+		return;
+
+	g_at_result_iter_init(&iter, result);
+
+	while (!found && g_at_result_iter_next(&iter, "+CGDCONT:")) {
+		if (g_at_result_iter_next_number(&iter, &cid) =3D=3D FALSE)
+			return;
+
+		if (psd->default_cid !=3D cid)
+			continue;
+
+		g_at_result_iter_next_string(&iter, &pdp_type);
+
+		found =3D TRUE;
+	}
+
+	if (found =3D=3D FALSE)
+		return;
+
+	if (g_str_equal(pdp_type, "IP"))
+		psd->default_context_type =3D OFONO_PACKET_PROTO_IP;
+	else if (g_str_equal(pdp_type, "IPV6"))
+		psd->default_context_type =3D OFONO_PACKET_PROTO_IPV6;
+	else if (g_str_equal(pdp_type, "IPV4V6"))
+		psd->default_context_type =3D OFONO_PACKET_PROTO_IPV4V6;
+
+	snprintf(buf, sizeof(buf), "AT+CGCONTRDP=3D%i", psd->default_cid);
+
+	g_at_chat_send(psd->chat, buf, cgcontrdp_prefix, at_cgcontrdp_cb,
+								ps, NULL);
+}
+
 static void at_packet_service_registration_status(
 					struct ofono_packet_service *ps,
 					ofono_packet_service_status_cb_t cb,
@@ -138,6 +273,13 @@ static void at_packet_service_registration_status(
 		break;
 	}
 =

+	if (ofono_packet_service_get_technology(ps) =3D=3D
+						ACCESS_TECHNOLOGY_EUTRAN) {
+		if (g_at_chat_send(psd->chat, "AT+CEREG?", cereg_prefix,
+					at_cereg_cb, cbd, g_free) > 0)
+			return;
+	}
+
 	if (g_at_chat_send(psd->chat, "AT+CGREG?", cgreg_prefix,
 				at_cgreg_cb, cbd, g_free) > 0)
 		return;
@@ -160,9 +302,23 @@ static void cgreg_notify(GAtResult *result, gpointer u=
ser_data)
 	ofono_packet_service_status_notify(ps, status);
 }
 =

+static void cereg_notify(GAtResult *result, gpointer user_data)
+{
+	struct ofono_packet_service *ps =3D user_data;
+	int status;
+	struct packet_service_data *psd =3D ofono_packet_service_get_data(ps);
+
+	if (at_util_parse_reg_unsolicited(result, "+CEREG:", &status,
+				NULL, NULL, NULL, psd->vendor) =3D=3D FALSE)
+		return;
+
+	ofono_packet_service_status_notify(ps, status);
+}
+
 static void cgev_notify(GAtResult *result, gpointer user_data)
 {
 	struct ofono_packet_service *ps =3D user_data;
+	struct packet_service_data *psd =3D ofono_packet_service_get_data(ps);
 	GAtResultIter iter;
 	const char *event;
 =

@@ -179,6 +335,35 @@ static void cgev_notify(GAtResult *result, gpointer us=
er_data)
 		ofono_packet_service_detached_notify(ps);
 		return;
 	}
+
+	if (g_str_has_prefix(event, "ME PDN ACT")) {
+		/*
+		 * As per 27.007, this even it sent when the mobile termination
+		 * has activated a context. The context represents a PDN
+		 * connection in LTE or a Primary PDP context in GSM/UMTS.
+		 * The <cid> for this context is provided to the TE. This event
+		 * is sent either in result of explicit context activation
+		 * request (+CGACT), or in result of implicit context activation
+		 * request associated to attach request (+CGATT=3D1).
+		 */
+		int cid;
+
+		cid =3D g_ascii_strtoll(&event[11], NULL, 0);
+
+		/*
+		 * Assumption: context id for default EPS context will have
+		 * value outside the ranges indicated in the test form of
+		 * the command +CGDCONT.
+		 */
+		if (cid >=3D psd->cid_min && cid <=3D psd->cid_max)
+			return;
+
+		psd->default_cid =3D cid;
+		g_at_chat_send(psd->chat, "AT+CGDCONT?", cgdcont_prefix,
+				at_cgdcont_cb, ps, NULL);
+
+		return;
+	}
 }
 =

 static void xdatastat_notify(GAtResult *result, gpointer user_data)
@@ -236,6 +421,8 @@ static void packet_service_initialized(gboolean ok, GAt=
Result *result,
 	g_at_chat_register(psd->chat, "+CGEV:", cgev_notify, FALSE, ps, NULL);
 	g_at_chat_register(psd->chat, "+CGREG:", cgreg_notify,
 						FALSE, ps, NULL);
+	g_at_chat_register(psd->chat, "+CEREG:", cereg_notify,
+						FALSE, ps, NULL);
 	g_at_chat_register(psd->chat, "+CPSB:", cpsb_notify, FALSE, ps, NULL);
 =

 	g_at_chat_send(psd->chat, "AT+CPSB=3D1", none_prefix, NULL, NULL, NULL);
@@ -318,6 +505,52 @@ error:
 	ofono_packet_service_remove(ps);
 }
 =

+static void at_cereg_test_cb(gboolean ok, GAtResult *result,
+				gpointer user_data)
+{
+	struct ofono_packet_service *ps =3D user_data;
+	struct packet_service_data *psd =3D ofono_packet_service_get_data(ps);
+	gint range[2];
+	GAtResultIter iter;
+	int cereg1 =3D 0;
+	int cereg2 =3D 0;
+	const char *cmd;
+
+	if (!ok)
+		goto error;
+
+	g_at_result_iter_init(&iter, result);
+
+	if (!g_at_result_iter_next(&iter, "+CEREG:"))
+		goto error;
+
+	if (!g_at_result_iter_open_list(&iter))
+		goto error;
+
+	while (g_at_result_iter_next_range(&iter, &range[0], &range[1])) {
+		if (1 >=3D range[0] && 1 <=3D range[1])
+			cereg1 =3D 1;
+		if (2 >=3D range[0] && 2 <=3D range[1])
+			cereg2 =3D 1;
+	}
+
+	g_at_result_iter_close_list(&iter);
+
+	if (cereg2)
+		cmd =3D "AT+CEREG=3D2";
+	else if (cereg1)
+		cmd =3D "AT+CEREG=3D1";
+	else
+		goto error;
+
+	g_at_chat_send(psd->chat, cmd, none_prefix, NULL, NULL, NULL);
+
+	return;
+
+error:
+	ofono_info("EPS not supported on this device");
+}
+
 static void at_cgdcont_test_cb(gboolean ok, GAtResult *result,
 				gpointer user_data)
 {
@@ -362,11 +595,16 @@ static void at_cgdcont_test_cb(gboolean ok, GAtResult=
 *result,
 	if (found =3D=3D FALSE)
 		goto error;
 =

+	psd->cid_min =3D min;
+	psd->cid_max =3D max;
 	ofono_packet_service_set_cid_range(ps, min, max);
 =

 	g_at_chat_send(psd->chat, "AT+CGREG=3D?", cgreg_prefix,
 			at_cgreg_test_cb, ps, NULL);
 =

+	g_at_chat_send(psd->chat, "AT+CEREG=3D?", cereg_prefix,
+			at_cereg_test_cb, ps, NULL);
+
 	return;
 =

 error:
-- =

1.7.0.4


--===============4572633809881687365==--

