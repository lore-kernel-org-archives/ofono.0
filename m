Content-Type: multipart/mixed; boundary="===============5814252305160518822=="
MIME-Version: 1.0
From: Andres Salomon <dilinger@collabora.co.uk>
Subject: [PATCH 3/3] G1: Add G1-specific SMS support
Date: Sun, 30 Aug 2009 00:07:18 -0400
Message-ID: <20090830040718.GA28091@mycelium.queued.net>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5814252305160518822==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This is based on the atmodem SMS code, with lots of stuff dropped.

The G1's modem advertises support for CNMI mode 2, but attempting to
set that actually fails.  Instead, we _need_ to use mode 1.  Along
those lines, CNMA doesn't appear to work properly, so we disable it
and use CMTI rather than CMT for PDUs.  CDS notifications (for status
notifications) are disabled completely.
---
 Makefile.am     |    3 +-
 plugins/g1.c    |    7 +-
 plugins/g1sms.c |  554 +++++++++++++++++++++++++++++++++++++++++++++++++++=
++++
 plugins/g1sms.h |   29 +++
 4 files changed, 591 insertions(+), 2 deletions(-)
 create mode 100644 plugins/g1sms.c
 create mode 100644 plugins/g1sms.h

diff --git a/Makefile.am b/Makefile.am
index a2d3569..72997c1 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -80,7 +80,8 @@ endif
 =

 if G1MODEM
 builtin_modules +=3D g1
-builtin_sources +=3D plugins/g1.c
+builtin_sources +=3D plugins/g1.c \
+				plugins/g1sms.c
 endif
 =

 if MAINTAINER_MODE
diff --git a/plugins/g1.c b/plugins/g1.c
index b0208bc..5d7c279 100644
--- a/plugins/g1.c
+++ b/plugins/g1.c
@@ -33,6 +33,7 @@
 =

 #include <glib.h>
 #include <gatchat.h>
+#include "g1sms.h"
 =

 #define OFONO_API_SUBJECT_TO_CHANGE
 #include <ofono/plugin.h>
@@ -334,7 +335,7 @@ static int g1_populate(struct ofono_modem *modem)
 	ofono_call_meter_create(modem, "generic_at", chat);
 	ofono_call_barring_create(modem, "generic_at", chat);
 	ofono_ssn_create(modem, "generic_at", chat);
-	ofono_sms_create(modem, "generic_at", chat);
+	ofono_sms_create(modem, "HTC G1", chat);
 	ofono_phonebook_create(modem, "generic_at", chat);
 =

 	mw =3D ofono_message_waiting_create(modem);
@@ -357,6 +358,8 @@ static int g1_init(void)
 {
 	int err;
 =

+	g1_sms_init();
+
 	err =3D ofono_modem_driver_register(&g1_driver);
 	if (err)
 		goto done;
@@ -385,6 +388,8 @@ static void g1_exit(void)
 {
 	ofono_modem_remove(g1_modem);
 	ofono_modem_driver_unregister(&g1_driver);
+
+	g1_sms_exit();
 }
 =

 OFONO_PLUGIN_DEFINE(g1, "HTC G1 modem driver", VERSION,
diff --git a/plugins/g1sms.c b/plugins/g1sms.c
new file mode 100644
index 0000000..617bb6a
--- /dev/null
+++ b/plugins/g1sms.c
@@ -0,0 +1,554 @@
+/*
+ *
+ *  oFono - Open Source Telephony
+ *
+ *  Copyright (C) 2008-2009  Intel Corporation. All rights reserved.
+ *  Copyright (C) 2009  Collabora Ltd.  All rights reserved.
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
+
+#include <glib.h>
+
+#include <ofono/log.h>
+#include <ofono/modem.h>
+#include <ofono/sms.h>
+#include "smsutil.h"
+#include "util.h"
+
+#include "gatchat.h"
+#include "gatresult.h"
+
+#include "drivers/atmodem/at.h"
+
+static const char *csca_prefix[] =3D { "+CSCA:", NULL };
+static const char *csms_prefix[] =3D { "+CSMS:", NULL };
+static const char *cmgf_prefix[] =3D { "+CMGF:", NULL };
+static const char *cpms_prefix[] =3D { "+CPMS:", NULL };
+static const char *cnmi_prefix[] =3D { "+CNMI:", NULL };
+static const char *cmgs_prefix[] =3D { "+CMGS:", NULL };
+static const char *none_prefix[] =3D { NULL };
+
+static const char *storages[] =3D {
+	"SM",
+	"ME",
+	"MT",
+};
+
+#define SM_STORE 0
+#define ME_STORE 1
+#define MT_STORE 2
+
+struct sms_data {
+	int store;
+	int incoming;
+	GAtChat *chat;
+};
+
+struct cpms_request {
+	struct ofono_sms *sms;
+	int store;
+	int index;
+};
+
+static void at_csca_set_cb(gboolean ok, GAtResult *result, gpointer user_d=
ata)
+{
+	struct cb_data *cbd =3D user_data;
+	ofono_sms_sca_set_cb_t cb =3D cbd->cb;
+	struct ofono_error error;
+
+	dump_response("csca_set_cb", ok, result);
+	decode_at_error(&error, g_at_result_final_response(result));
+
+	cb(&error, cbd->data);
+}
+
+static void at_csca_set(struct ofono_sms *sms,
+			const struct ofono_phone_number *sca,
+			ofono_sms_sca_set_cb_t cb, void *user_data)
+{
+	struct sms_data *data =3D ofono_sms_get_data(sms);
+	struct cb_data *cbd =3D cb_data_new(cb, user_data);
+	char buf[64];
+
+	if (!cbd)
+		goto error;
+
+	sprintf(buf, "AT+CSCA=3D\"%s\",%d", sca->number, sca->type);
+
+	if (g_at_chat_send(data->chat, buf, csca_prefix,
+				at_csca_set_cb, cbd, g_free) > 0)
+		return;
+
+error:
+	if (cbd)
+		g_free(cbd);
+
+	{
+		DECLARE_FAILURE(error);
+		cb(&error, user_data);
+	}
+}
+
+static void at_csca_query_cb(gboolean ok, GAtResult *result, gpointer user=
_data)
+{
+	struct cb_data *cbd =3D user_data;
+	GAtResultIter iter;
+	ofono_sms_sca_query_cb_t cb =3D cbd->cb;
+	struct ofono_error error;
+	struct ofono_phone_number sca;
+	const char *number;
+
+	dump_response("at_csca_cb", ok, result);
+	decode_at_error(&error, g_at_result_final_response(result));
+
+	if (!ok) {
+		cb(&error, NULL, cbd->data);
+		return;
+	}
+
+	g_at_result_iter_init(&iter, result);
+
+	if (!g_at_result_iter_next(&iter, "+CSCA:"))
+		goto err;
+
+	if (!g_at_result_iter_next_string(&iter, &number))
+		goto err;
+
+	if (number[0] =3D=3D '+') {
+		number =3D number + 1;
+		sca.type =3D 145;
+	} else
+		sca.type =3D 129;
+
+	strncpy(sca.number, number, OFONO_MAX_PHONE_NUMBER_LENGTH);
+	sca.number[OFONO_MAX_PHONE_NUMBER_LENGTH] =3D '\0';
+
+	g_at_result_iter_next_number(&iter, &sca.type);
+
+	ofono_debug("csca_query_cb: %s, %d", sca.number, sca.type);
+
+	cb(&error, &sca, cbd->data);
+
+	return;
+
+err:
+	{
+		DECLARE_FAILURE(error);
+		cb(&error, NULL, cbd->data);
+	}
+}
+
+static void at_csca_query(struct ofono_sms *sms, ofono_sms_sca_query_cb_t =
cb,
+					void *user_data)
+{
+	struct sms_data *data =3D ofono_sms_get_data(sms);
+	struct cb_data *cbd =3D cb_data_new(cb, user_data);
+
+	if (!cbd)
+		goto error;
+
+	if (g_at_chat_send(data->chat, "AT+CSCA?", csca_prefix,
+				at_csca_query_cb, cbd, g_free) > 0)
+		return;
+
+error:
+	if (cbd)
+		g_free(cbd);
+
+	{
+		DECLARE_FAILURE(error);
+		cb(&error, NULL, user_data);
+	}
+}
+
+static void at_cmgs_cb(gboolean ok, GAtResult *result, gpointer user_data)
+{
+	struct cb_data *cbd =3D user_data;
+	GAtResultIter iter;
+	ofono_sms_submit_cb_t cb =3D cbd->cb;
+	struct ofono_error error;
+	int mr;
+
+	dump_response("at_cmgs_cb", ok, result);
+	decode_at_error(&error, g_at_result_final_response(result));
+
+	if (!ok) {
+		cb(&error, -1, cbd->data);
+		return;
+	}
+
+	g_at_result_iter_init(&iter, result);
+
+	if (!g_at_result_iter_next(&iter, "+CMGS:"))
+		goto err;
+
+	if (!g_at_result_iter_next_number(&iter, &mr))
+		goto err;
+
+	ofono_debug("Got MR: %d", mr);
+
+	cb(&error, mr, cbd->data);
+	return;
+
+err:
+	{
+		DECLARE_FAILURE(error);
+		cb(&error, -1, cbd->data);
+	}
+}
+
+static void at_cmgs(struct ofono_sms *sms, unsigned char *pdu, int pdu_len,
+			int tpdu_len, int mms, ofono_sms_submit_cb_t cb,
+			void *user_data)
+{
+	struct sms_data *data =3D ofono_sms_get_data(sms);
+	struct cb_data *cbd =3D cb_data_new(cb, user_data);
+	char buf[512];
+	int len;
+
+	if (!cbd)
+		goto error;
+
+	if (mms) {
+		sprintf(buf, "AT+CMMS=3D%d", mms);
+		g_at_chat_send(data->chat, buf, none_prefix,
+				NULL, NULL, NULL);
+	}
+
+	len =3D sprintf(buf, "AT+CMGS=3D%d\r", tpdu_len);
+	encode_hex_own_buf(pdu, pdu_len, 0, buf+len);
+
+	if (g_at_chat_send(data->chat, buf, cmgs_prefix,
+				at_cmgs_cb, cbd, g_free) > 0)
+		return;
+
+error:
+	if (cbd)
+		g_free(cbd);
+
+	{
+		DECLARE_FAILURE(error);
+		cb(&error, -1, user_data);
+	}
+}
+
+static gboolean at_parse_pdu_common(GAtResult *result, const char *prefix,
+					const char **pdu, int *pdulen)
+{
+	GAtResultIter iter;
+
+	g_at_result_iter_init(&iter, result);
+
+	if (!g_at_result_iter_next(&iter, prefix))
+		return FALSE;
+
+	if (!strcmp(prefix, "+CMT:") && !g_at_result_iter_skip_next(&iter))
+		return FALSE;
+
+	if (!g_at_result_iter_next_number(&iter, pdulen))
+		return FALSE;
+
+	*pdu =3D g_at_result_pdu(result);
+
+	return TRUE;
+}
+
+static void at_cbm_notify(GAtResult *result, gpointer user_data)
+{
+	int pdulen;
+	const char *pdu;
+
+	dump_response("at_cbm_notify", TRUE, result);
+
+	if (!at_parse_pdu_common(result, "+CBM:", &pdu, &pdulen)) {
+		ofono_error("Unable to parse CBM notification");
+		return;
+	}
+
+	ofono_debug("Got new Cell Broadcast via CBM: %s, %d", pdu, pdulen);
+}
+
+static void at_cmgr_notify(GAtResult *result, gpointer user_data)
+{
+	struct ofono_sms *sms =3D user_data;
+	GAtResultIter iter;
+	const char *hexpdu;
+	unsigned char pdu[164];
+	long pdu_len;
+	int tpdu_len;
+
+	dump_response("at_cmgr_notify", TRUE, result);
+
+	g_at_result_iter_init(&iter, result);
+
+	if (!g_at_result_iter_next(&iter, "+CMGR:"))
+		goto err;
+
+	if (!g_at_result_iter_skip_next(&iter))
+		goto err;
+
+	if (!g_at_result_iter_skip_next(&iter))
+		goto err;
+
+	if (!g_at_result_iter_next_number(&iter, &tpdu_len))
+		goto err;
+
+	hexpdu =3D g_at_result_pdu(result);
+
+	ofono_debug("Got PDU: %s, with len: %d", hexpdu, tpdu_len);
+
+	decode_hex_own_buf(hexpdu, -1, &pdu_len, 0, pdu);
+	ofono_sms_deliver_notify(sms, pdu, pdu_len, tpdu_len);
+	return;
+
+err:
+	ofono_error("Unable to parse CMGR response");
+}
+
+static void at_cmgr_cb(gboolean ok, GAtResult *result, gpointer user_data)
+{
+	if (!ok)
+		ofono_error("Received a CMTI indication but CMGR failed!");
+}
+
+static void at_cmgd_cb(gboolean ok, GAtResult *result, gpointer user_data)
+{
+	if (!ok)
+		ofono_error("Unable to delete received SMS");
+}
+
+static void at_cmti_cpms_cb(gboolean ok, GAtResult *result, gpointer user_=
data)
+{
+	struct cpms_request *req =3D user_data;
+	struct ofono_sms *sms =3D req->sms;
+	struct sms_data *data =3D ofono_sms_get_data(sms);
+	char buf[128];
+
+	if (!ok) {
+		ofono_error("Received CMTI, but CPMS request failed");
+		return;
+	}
+
+	data->store =3D req->store;
+
+	sprintf(buf, "AT+CMGR=3D%d", req->index);
+	g_at_chat_send(data->chat, buf, none_prefix, at_cmgr_cb, NULL, NULL);
+
+	/* We don't buffer SMS on the SIM/ME, send along a CMGD as well */
+	sprintf(buf, "AT+CMGD=3D%d", req->index);
+	g_at_chat_send(data->chat, buf, none_prefix, at_cmgd_cb, NULL, NULL);
+}
+
+static void at_cmti_notify(GAtResult *result, gpointer user_data)
+{
+	struct ofono_sms *sms =3D user_data;
+	struct sms_data *data =3D ofono_sms_get_data(sms);
+	const char *strstore;
+	int store;
+	GAtResultIter iter;
+	int index;
+
+	dump_response("at_cmti_notify", TRUE, result);
+
+	g_at_result_iter_init(&iter, result);
+
+	if (!g_at_result_iter_next(&iter, "+CMTI:"))
+		goto err;
+
+	if (!g_at_result_iter_next_string(&iter, &strstore))
+		goto err;
+
+	if (!strcmp(strstore, "ME"))
+		store =3D ME_STORE;
+	else if (!strcmp(strstore, "SM"))
+		store =3D SM_STORE;
+	else
+		goto err;
+
+	if (!g_at_result_iter_next_number(&iter, &index))
+		goto err;
+
+	ofono_debug("Got a CMTI indication at %s, index: %d", strstore, index);
+
+	if (store =3D=3D data->store) {
+		struct cpms_request req;
+
+		req.sms =3D sms;
+		req.store =3D store;
+		req.index =3D index;
+
+		at_cmti_cpms_cb(TRUE, NULL, &req);
+	} else {
+		char buf[128];
+		const char *incoming =3D storages[data->incoming];
+		struct cpms_request *req =3D g_new(struct cpms_request, 1);
+
+		req->sms =3D sms;
+		req->store =3D store;
+		req->index =3D index;
+
+		sprintf(buf, "AT+CPMS=3D\"%s\",\"%s\",\"%s\"",
+			strstore, strstore, incoming);
+
+		g_at_chat_send(data->chat, buf, cpms_prefix, at_cmti_cpms_cb,
+				req, g_free);
+	}
+
+	return;
+
+err:
+	ofono_error("Unable to parse CMTI notification");
+}
+
+static void at_sms_initialized(struct ofono_sms *sms)
+{
+	struct sms_data *data =3D ofono_sms_get_data(sms);
+
+	g_at_chat_register(data->chat, "+CMTI:", at_cmti_notify, FALSE,
+				sms, NULL);
+	g_at_chat_register(data->chat, "+CBM:", at_cbm_notify, TRUE,
+				sms, NULL);
+
+	/* We treat CMGR just like a notification */
+	g_at_chat_register(data->chat, "+CMGR:", at_cmgr_notify, TRUE,
+				sms, NULL);
+
+	ofono_sms_register(sms);
+}
+
+static void at_sms_not_supported(struct ofono_sms *sms)
+{
+	ofono_error("SMS not supported by this modem.  If this is in error"
+			" please submit patches to support this hardware");
+
+	ofono_sms_remove(sms);
+}
+
+static void at_cnmi_set_cb(gboolean ok, GAtResult *result, gpointer user_d=
ata)
+{
+	struct ofono_sms *sms =3D user_data;
+
+	if (!ok)
+		return at_sms_not_supported(sms);
+
+	at_sms_initialized(sms);
+}
+
+static void at_cpms_set_cb(gboolean ok, GAtResult *result, gpointer user_d=
ata)
+{
+	struct ofono_sms *sms =3D user_data;
+	struct sms_data *data =3D ofono_sms_get_data(sms);
+
+	dump_response("at_cpms_set_cb", ok, result);
+	if (!ok) {
+		at_sms_not_supported(sms);
+		return;
+	}
+
+	/* the G1 is very particular about CNMI; mode 1 is required */
+	g_at_chat_send(data->chat, "AT+CNMI=3D1,1,2,0,1", cnmi_prefix,
+			at_cnmi_set_cb, sms, NULL);
+}
+
+static void at_cmgf_set_cb(gboolean ok, GAtResult *result, gpointer user_d=
ata)
+{
+	struct ofono_sms *sms =3D user_data;
+	struct sms_data *data =3D ofono_sms_get_data(sms);
+
+	dump_response("at_cmgf_set_cb", ok, result);
+
+	if (!ok) {
+		at_sms_not_supported(sms);
+		return;
+	}
+
+	g_at_chat_send(data->chat, "AT+CPMS=3D\"ME\",\"ME\",\"ME\"", cpms_prefix,
+			at_cpms_set_cb, sms, NULL);
+}
+
+static void at_csms_set_cb(gboolean ok, GAtResult *result,
+				gpointer user_data)
+{
+	struct ofono_sms *sms =3D user_data;
+	struct sms_data *data =3D ofono_sms_get_data(sms);
+
+	dump_response("at_csms_set_cb", ok, result);
+
+	if (!ok) {
+		at_sms_not_supported(sms);
+		return;
+	}
+
+	/* use ME for everything */
+	data->store =3D ME_STORE;
+	data->incoming =3D ME_STORE;
+
+	g_at_chat_send(data->chat, "AT+CMGF=3D0", cmgf_prefix,
+			at_cmgf_set_cb, sms, NULL);
+}
+
+static int at_sms_probe(struct ofono_sms *sms)
+{
+	GAtChat *chat =3D ofono_sms_get_data(sms);
+	struct sms_data *data;
+
+	data =3D g_new0(struct sms_data, 1);
+	data->chat =3D chat;
+
+	ofono_sms_set_data(sms, data);
+
+	g_at_chat_send(data->chat, "AT+CSMS=3D0", csms_prefix,
+			at_csms_set_cb, sms, NULL);
+
+	return 0;
+}
+
+static int at_sms_remove(struct ofono_sms *sms)
+{
+	struct sms_data *data =3D ofono_sms_get_data(sms);
+
+	g_free(data);
+
+	return 0;
+}
+
+static struct ofono_sms_driver g1_driver =3D {
+	.name =3D "HTC G1",
+	.probe =3D at_sms_probe,
+	.remove =3D at_sms_remove,
+	.sca_query	=3D at_csca_query,
+	.sca_set	=3D at_csca_set,
+	.submit		=3D at_cmgs,
+};
+
+void g1_sms_init()
+{
+	ofono_sms_driver_register(&g1_driver);
+}
+
+void g1_sms_exit()
+{
+	ofono_sms_driver_unregister(&g1_driver);
+}
diff --git a/plugins/g1sms.h b/plugins/g1sms.h
new file mode 100644
index 0000000..482ce61
--- /dev/null
+++ b/plugins/g1sms.h
@@ -0,0 +1,29 @@
+/*
+ *
+ *  oFono - Open Source Telephony
+ *
+ *  Copyright (C) 2008-2009  Intel Corporation. All rights reserved.
+ *  Copyright (C) 2009  Collabora Ltd.  All rights reserved.
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
+#ifndef __G1SMS_H
+#define __G1SMS_H
+
+extern void g1_sms_init(void);
+extern void g1_sms_exit(void);
+
+#endif
-- =

1.6.3.3

--===============5814252305160518822==--

