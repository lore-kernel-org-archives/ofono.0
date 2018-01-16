Content-Type: multipart/mixed; boundary="===============2208925890288085501=="
MIME-Version: 1.0
From: Alexander Couzens <lynxis@fe80.eu>
Subject: [PATCH 2/2] qmi: add USSD support for MO services
Date: Tue, 16 Jan 2018 16:33:25 +0100
Message-ID: <20180116153325.20491-2-lynxis@fe80.eu>
In-Reply-To: <20180116153325.20491-1-lynxis@fe80.eu>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2208925890288085501==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 drivers/qmimodem/ussd.c | 187 ++++++++++++++++++++++++++++++++++++++++++++=
++--
 1 file changed, 183 insertions(+), 4 deletions(-)

diff --git a/drivers/qmimodem/ussd.c b/drivers/qmimodem/ussd.c
index 90c32097c94d..c1cb7d3697d1 100644
--- a/drivers/qmimodem/ussd.c
+++ b/drivers/qmimodem/ussd.c
@@ -3,6 +3,7 @@
  *  oFono - Open Source Telephony
  *
  *  Copyright (C) 2011-2012  Intel Corporation. All rights reserved.
+ *  Copyright (C) 2017 by sysmocom s.f.m.c. GmbH <info@sysmocom.de>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2 as
@@ -23,20 +24,103 @@
 #include <config.h>
 #endif
 =

+#define _GNU_SOURCE
+#include <string.h>
+
+#include <glib.h>
+
 #include <ofono/log.h>
 #include <ofono/modem.h>
 #include <ofono/ussd.h>
-
+#include <smsutil.h>
 #include "qmi.h"
 =

 #include "qmimodem.h"
 =

+#include "voice.h"
+
 struct ussd_data {
 	struct qmi_service *voice;
 	uint16_t major;
 	uint16_t minor;
 };
 =

+static int validate_ussd_data(const struct qmi_ussd_data *data, int size)
+{
+	if (data =3D=3D NULL)
+		return 1;
+
+	if (size < sizeof(*data))
+		return 1;
+
+	if (size < sizeof(*data) + data->length)
+		return 1;
+
+	if (data->dcs < QMI_USSD_DCS_ASCII || data->dcs > QMI_USSD_DCS_UCS2)
+		return 1;
+
+	return 0;
+}
+
+static int convert_qmi_dcs_gsm_dcs(int qmi_dcs, int *gsm_dcs)
+{
+	switch (qmi_dcs) {
+	case QMI_USSD_DCS_ASCII:
+		*gsm_dcs =3D USSD_DCS_8BIT;
+		break;
+	default:
+		return 1;
+	}
+
+	return 0;
+}
+
+static void async_orig_ind(struct qmi_result *result, void *user_data)
+{
+	struct ofono_ussd *ussd =3D user_data;
+	const struct qmi_ussd_data *qmi_ussd;
+	uint16_t error =3D 0;
+	uint16_t len;
+	int gsm_dcs;
+
+	DBG("");
+
+	qmi_result_get_uint16(result, QMI_VOICE_PARAM_ASYNC_USSD_ERROR, &error);
+
+	switch (error) {
+	case 0:
+		/* no error */
+		break;
+	case 92:
+		qmi_result_get_uint16(result,
+				      QMI_VOICE_PARAM_ASYNC_USSD_FAILURE_CASE,
+				      &error);
+		DBG("Failure Cause: 0x%04x", error);
+		goto error;
+	default:
+		DBG("USSD Error 0x%04x", error);
+		goto error;
+	}
+
+	qmi_ussd =3D qmi_result_get(result, QMI_VOICE_PARAM_ASYNC_USSD_DATA,
+				  &len);
+	if (qmi_ussd =3D=3D NULL)
+		return;
+
+	if (validate_ussd_data(qmi_ussd, len))
+		goto error;
+
+	if (convert_qmi_dcs_gsm_dcs(qmi_ussd->dcs, &gsm_dcs))
+		goto error;
+
+	ofono_ussd_notify(ussd, OFONO_USSD_STATUS_NOTIFY, gsm_dcs,
+			  qmi_ussd->data, qmi_ussd->length);
+	return;
+
+error:
+	ofono_ussd_notify(ussd, OFONO_USSD_STATUS_TERMINATED, 0, NULL, 0);
+}
+
 static void create_voice_cb(struct qmi_service *service, void *user_data)
 {
 	struct ofono_ussd *ussd =3D user_data;
@@ -44,7 +128,7 @@ static void create_voice_cb(struct qmi_service *service,=
 void *user_data)
 =

 	DBG("");
 =

-	if (!service) {
+	if (service =3D=3D NULL) {
 		ofono_error("Failed to request Voice service");
 		ofono_ussd_remove(ussd);
 		return;
@@ -58,11 +142,14 @@ static void create_voice_cb(struct qmi_service *servic=
e, void *user_data)
 =

 	data->voice =3D qmi_service_ref(service);
 =

+	qmi_service_register(data->voice, QMI_VOICE_ASYNC_ORIG_USSD,
+					async_orig_ind, ussd, NULL);
+
 	ofono_ussd_register(ussd);
 }
 =

 static int qmi_ussd_probe(struct ofono_ussd *ussd,
-				unsigned int vendor, void *user_data)
+			  unsigned int vendor, void *user_data)
 {
 	struct qmi_device *device =3D user_data;
 	struct ussd_data *data;
@@ -77,7 +164,6 @@ static int qmi_ussd_probe(struct ofono_ussd *ussd,
 						create_voice_cb, ussd, NULL);
 =

 	return 0;
-
 }
 =

 static void qmi_ussd_remove(struct ofono_ussd *ussd)
@@ -93,10 +179,103 @@ static void qmi_ussd_remove(struct ofono_ussd *ussd)
 	g_free(data);
 }
 =

+static void qmi_ussd_cancel(struct ofono_ussd *ussd,
+				ofono_ussd_cb_t cb, void *user_data)
+{
+	struct ussd_data *ud =3D ofono_ussd_get_data(ussd);
+
+	DBG("");
+
+	if (qmi_service_send(ud->voice, QMI_VOICE_CANCEL_USSD, NULL,
+					NULL, NULL, NULL) > 0)
+		CALLBACK_WITH_SUCCESS(cb, user_data);
+	else
+		CALLBACK_WITH_FAILURE(cb, user_data);
+}
+
+/*
+ * The cb is called when the request (on modem layer) reports success or
+ * failure. It doesn't contain a network result. We get the network answer
+ * via VOICE_IND.
+ */
+static void qmi_ussd_request_cb(struct qmi_result *result, void *user_data)
+{
+	struct cb_data *cbd =3D user_data;
+	ofono_ussd_cb_t cb =3D cbd->cb;
+
+	DBG("");
+
+	qmi_result_print_tlvs(result);
+
+	if (qmi_result_set_error(result, NULL)) {
+		CALLBACK_WITH_FAILURE(cb, cbd->data);
+		return;
+	}
+
+	CALLBACK_WITH_SUCCESS(cb, cbd->data);
+}
+
+static void qmi_ussd_request(struct ofono_ussd *ussd, int dcs,
+			const unsigned char *pdu, int len,
+			ofono_ussd_cb_t cb, void *data)
+{
+	struct ussd_data *ud =3D ofono_ussd_get_data(ussd);
+	struct cb_data *cbd =3D cb_data_new(cb, data);
+	struct qmi_ussd_data *qmi_ussd;
+	struct qmi_param *param;
+	char *utf8 =3D NULL;
+	long utf8_len =3D 0;
+
+	DBG("");
+
+	switch (dcs) {
+	case 0xf: /* 7bit GSM unspecific */
+		utf8 =3D ussd_decode(dcs, len, pdu);
+		if (!utf8)
+			goto error;
+
+		utf8_len =3D strlen(utf8);
+		break;
+	default:
+		DBG("Unsupported USSD Data Coding Scheme 0x%x", dcs);
+		goto error;
+	}
+
+	/*
+	 * So far only DCS_ASCII works.
+	 * DCS_8BIT and DCS_UCS2 is broken, because the modem firmware
+	 * (least on a EC20) encodes those in-correctly onto the air interface,
+	 * resulting in wrong decoded USSD data.
+	 */
+	qmi_ussd =3D alloca(sizeof(struct qmi_ussd_data) + utf8_len);
+	qmi_ussd->dcs =3D QMI_USSD_DCS_ASCII;
+	qmi_ussd->length =3D len;
+	memcpy(qmi_ussd->data, utf8, utf8_len);
+
+	param =3D qmi_param_new();
+	if (param =3D=3D NULL)
+		goto error;
+
+	qmi_param_append(param, QMI_VOICE_PARAM_USS_DATA,
+			sizeof(struct qmi_ussd_data) + utf8_len, qmi_ussd);
+
+	if (qmi_service_send(ud->voice, QMI_VOICE_ASYNC_ORIG_USSD, param,
+					qmi_ussd_request_cb, cbd, g_free) > 0)
+		return;
+
+	qmi_param_free(param);
+error:
+	g_free(utf8);
+	g_free(cbd);
+	CALLBACK_WITH_FAILURE(cb, data);
+}
+
 static struct ofono_ussd_driver driver =3D {
 	.name		=3D "qmimodem",
 	.probe		=3D qmi_ussd_probe,
 	.remove		=3D qmi_ussd_remove,
+	.request	=3D qmi_ussd_request,
+	.cancel		=3D qmi_ussd_cancel
 };
 =

 void qmi_ussd_init(void)
-- =

2.15.1


--===============2208925890288085501==--

