Content-Type: multipart/mixed; boundary="===============4722544443655851247=="
MIME-Version: 1.0
From: djalal@endocode.com
Subject: [PATCH 3/5] ubloxmodem: add the netmon driver
Date: Fri, 25 Nov 2016 15:00:13 +0100
Message-ID: <1480082415-30822-4-git-send-email-djalal@endocode.com>
In-Reply-To: <1480082415-30822-1-git-send-email-djalal@endocode.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4722544443655851247==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Djalal Harouni <djalal@endocode.com>

This adds a netmon driver for ublox. The driver support both +COPS and
+CESQ commands to return the previously added ofono netmon types:

RSCP: Received Signal Code Power
ECN0: Received Energy Ratio
RSRQ: Reference Signal Received Quality
RSRP: Reference Signal Received Power
OPERATOR: the operator
---
 Makefile.am                 |   1 +
 drivers/ubloxmodem/netmon.c | 339 ++++++++++++++++++++++++++++++++++++++++=
++++
 2 files changed, 340 insertions(+)
 create mode 100644 drivers/ubloxmodem/netmon.c

diff --git a/Makefile.am b/Makefile.am
index 3d7774b..07adeab 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -383,6 +383,7 @@ builtin_sources +=3D drivers/atmodem/atutil.h \
 			drivers/ubloxmodem/ubloxmodem.h \
 			drivers/ubloxmodem/ubloxmodem.c \
 			drivers/ubloxmodem/gprs-context.c \
+			drivers/ubloxmodem/netmon.c \
 			drivers/ubloxmodem/lte.c
 =

 =

diff --git a/drivers/ubloxmodem/netmon.c b/drivers/ubloxmodem/netmon.c
new file mode 100644
index 0000000..6b9d74f
--- /dev/null
+++ b/drivers/ubloxmodem/netmon.c
@@ -0,0 +1,339 @@
+/*
+ *
+ *  oFono - Open Source Telephony
+ *
+ *  Copyright (C) 2016  EndoCode AG. All rights reserved.
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
+#include <stdio.h>
+#include <stdlib.h>
+#include <stdint.h>
+#include <string.h>
+#include <errno.h>
+
+#include <glib.h>
+
+#include <ofono/log.h>
+#include <ofono/modem.h>
+#include <ofono/netmon.h>
+
+#include "gatchat.h"
+#include "gatresult.h"
+
+#include "common.h"
+#include "netreg.h"
+#include "ubloxmodem.h"
+#include "drivers/atmodem/vendor.h"
+
+static const char *cops_prefix[] =3D { "+COPS:", NULL };
+static const char *cesq_prefix[] =3D { "+CESQ:", NULL };
+
+struct netmon_driver_data {
+	GAtChat *modem;
+	GAtChat *aux;
+};
+
+struct req_cb_data {
+	struct ofono_netmon *netmon;
+
+	ofono_netmon_cb_t cb;
+	void *data;
+
+	struct ofono_network_operator op;
+
+	int rxlev;	/* CESQ: Received Signal Strength Indication */
+	int ber;	/* CESQ: Bit Error Rate */
+	int rscp;	/* CESQ: Received Signal Code Powe */
+	int rsrp;	/* CESQ: Reference Signal Received Power */
+	double ecn0;	/* CESQ: Received Energy Ratio */
+	double rsrq;	/* CESQ: Reference Signal Received Quality */
+};
+
+/*
+ * Returns the appropriate radio access technology.
+ *
+ * If we can not resolve to a specific radio access technolgy
+ * we return OFONO_NETMON_CELL_TYPE_GSM by default.
+ */
+static int ublox_map_radio_access_technology(int tech)
+{
+	switch (tech) {
+	case ACCESS_TECHNOLOGY_GSM:
+	case ACCESS_TECHNOLOGY_GSM_COMPACT:
+		return OFONO_NETMON_CELL_TYPE_GSM;
+	case ACCESS_TECHNOLOGY_UTRAN:
+	case ACCESS_TECHNOLOGY_UTRAN_HSDPA:
+	case ACCESS_TECHNOLOGY_UTRAN_HSUPA:
+	case ACCESS_TECHNOLOGY_UTRAN_HSDPA_HSUPA:
+		return OFONO_NETMON_CELL_TYPE_UMTS;
+	case ACCESS_TECHNOLOGY_EUTRAN:
+		return OFONO_NETMON_CELL_TYPE_LTE;
+	}
+
+	return OFONO_NETMON_CELL_TYPE_GSM;
+}
+
+static inline struct req_cb_data *req_cb_data_new0(void *cb, void *data, v=
oid *user)
+{
+	struct req_cb_data *ret =3D g_new0(struct req_cb_data, 1);
+	if (ret =3D=3D NULL)
+		return NULL;
+
+
+	ret->cb =3D cb;
+	ret->data =3D data;
+	ret->netmon =3D user;
+	ret->rxlev =3D -1;
+	ret->ber =3D -1;
+	ret->rscp =3D -1;
+	ret->rsrp =3D -1;
+	ret->ecn0 =3D -1;
+	ret->rsrq =3D -1;
+
+	return ret;
+}
+
+static gboolean ublox_delayed_register(gpointer user_data)
+{
+	struct ofono_netmon *netmon =3D user_data;
+
+	ofono_netmon_register(netmon);
+
+	return FALSE;
+}
+
+static void cesq_cb(gboolean ok, GAtResult *result, gpointer user_data)
+{
+	enum cesq_ofono_netmon_info {
+		CESQ_RXLEV,
+		CESQ_BER,
+		CESQ_RSCP,
+		CESQ_ECN0,
+		CESQ_RSRQ,
+		CESQ_RSRP,
+		_MAX,
+	};
+
+	struct req_cb_data *cbd =3D user_data;
+	struct ofono_netmon *nm =3D cbd->netmon;
+	struct ofono_error error;
+	GAtResultIter iter;
+	int idx, number;
+
+	DBG("ok %d", ok);
+
+	decode_at_error(&error, g_at_result_final_response(result));
+
+	if (!ok) {
+		goto error;
+	}
+
+	g_at_result_iter_init(&iter, result);
+
+	if (!g_at_result_iter_next(&iter, "+CESQ:"))
+		return;
+
+	for (idx =3D 0; idx < _MAX; idx++) {
+
+		ok =3D g_at_result_iter_next_number(&iter, &number);
+		if (!ok) {
+			DBG(" error@idx: %d", idx);
+			goto error;
+		}
+
+		switch (idx) {
+		case CESQ_RXLEV:
+			cbd->rxlev =3D number !=3D 99 ? number:cbd->rxlev;
+			break;
+		case CESQ_BER:
+			cbd->ber =3D number !=3D 99 ? number:cbd->ber;
+			break;
+		case CESQ_RSCP:
+			cbd->rscp=3D number !=3D 255 ? number:cbd->rscp;
+			break;
+		case CESQ_ECN0:
+			cbd->ecn0=3D number !=3D 255 ? number:cbd->ecn0;
+			break;
+		case CESQ_RSRQ:
+			cbd->rsrq=3D number !=3D 255 ? number:cbd->rsrq;
+			break;
+		case CESQ_RSRP:
+			cbd->rsrp=3D number !=3D 255 ? number:cbd->rsrp;
+			break;
+		}
+	}
+
+	DBG(" RXLEV	%d ", cbd->rxlev);
+	DBG(" BER	%d ", cbd->ber);
+	DBG(" RSCP	%d ", cbd->rscp);
+	DBG(" ECN0	%f ", cbd->ecn0);
+	DBG(" RSRQ	%f ", cbd->rsrq);
+	DBG(" RSRP	%d ", cbd->rsrp);
+
+	ofono_netmon_serving_cell_notify(nm,
+					 cbd->op.tech,
+					 OFONO_NETMON_INFO_OPERATOR, cbd->op.name,
+					 OFONO_NETMON_INFO_RXLEV, cbd->rxlev,
+					 OFONO_NETMON_INFO_BER, cbd->ber,
+					 OFONO_NETMON_INFO_RSCP, cbd->rscp,
+					 OFONO_NETMON_INFO_ECN0, cbd->ecn0,
+					 OFONO_NETMON_INFO_RSRQ, cbd->rsrq,
+					 OFONO_NETMON_INFO_RSRP, cbd->rsrp,
+					 OFONO_NETMON_INFO_INVALID);
+
+	CALLBACK_WITH_SUCCESS(cbd->cb, cbd->data);
+	g_free(cbd);
+	return;
+
+error:
+	CALLBACK_WITH_FAILURE(cbd->cb, cbd->data);
+	g_free(cbd);
+}
+
+static void cops_cb(gboolean ok, GAtResult *result, gpointer user_data)
+{
+	struct req_cb_data *cbd =3D user_data;
+	struct ofono_netmon *nm =3D cbd->netmon;
+	struct netmon_driver_data *nmd =3D ofono_netmon_get_data(nm);
+	struct ofono_error error;
+	GAtResultIter iter;
+	int tech;
+	const char *name;
+
+	DBG("ok %d", ok);
+
+	decode_at_error(&error, g_at_result_final_response(result));
+
+	if (!ok) {
+		goto error;
+	}
+
+	g_at_result_iter_init(&iter, result);
+
+	if (!g_at_result_iter_next(&iter, "+COPS:"))
+		return;
+
+	g_at_result_iter_skip_next(&iter);
+	g_at_result_iter_skip_next(&iter);
+
+	if (g_at_result_iter_next_string(&iter, &name) =3D=3D FALSE)
+		goto error;
+
+	strncpy(cbd->op.name, name, OFONO_MAX_OPERATOR_NAME_LENGTH);
+	cbd->op.name[OFONO_MAX_OPERATOR_NAME_LENGTH] =3D '\0';
+
+	/* Ignored for now. TODO: maybe read format but value
+	 * wouldn't be forwarder anywhere
+	 */
+	cbd->op.mcc[0] =3D '\0';
+	cbd->op.mnc[0] =3D '\0';
+
+	/* Default to GSM */
+	if (g_at_result_iter_next_number(&iter, &tech) =3D=3D FALSE)
+		cbd->op.tech =3D ublox_map_radio_access_technology(ACCESS_TECHNOLOGY_GSM=
);
+	else
+		cbd->op.tech =3D ublox_map_radio_access_technology(tech);
+
+	if (g_at_chat_send(nmd->aux, "AT+CESQ", cesq_prefix,
+			   cesq_cb, cbd, NULL)) {
+		return;
+	}
+
+error:
+	CALLBACK_WITH_FAILURE(cbd->cb, cbd->data);
+	g_free(cbd);
+}
+
+
+static void ublox_netmon_request_update(struct ofono_netmon *netmon,
+					ofono_netmon_cb_t cb, void *data)
+{
+	struct netmon_driver_data *nmd =3D ofono_netmon_get_data(netmon);
+	struct req_cb_data *cbd;
+
+	DBG("ublox netmon request update");
+
+	cbd =3D req_cb_data_new0(cb, data, netmon);
+	if (!cbd) {
+		CALLBACK_WITH_FAILURE(cb, data);
+		return;
+	}
+
+	if (g_at_chat_send(nmd->aux, "AT+COPS?", cops_prefix,
+			   cops_cb, cbd, NULL) =3D=3D 0) {
+		CALLBACK_WITH_FAILURE(cb, data);
+		g_free(cbd);
+	}
+}
+
+static int ublox_netmon_probe(struct ofono_netmon *netmon,
+			      unsigned int vendor, void *user)
+{
+	struct netmon_driver_data *n =3D user;
+	struct netmon_driver_data *nmd;
+
+	DBG("ublox netmon probe");
+
+	nmd =3D g_try_new0(struct netmon_driver_data, 1);
+	if (nmd =3D=3D NULL)
+		return -ENOMEM;
+
+	nmd->modem =3D g_at_chat_clone(n->modem);
+	nmd->aux =3D g_at_chat_clone(n->aux);
+
+	ofono_netmon_set_data(netmon, nmd);
+
+	g_idle_add(ublox_delayed_register, netmon);
+
+	return 0;
+}
+
+static void ublox_netmon_remove(struct ofono_netmon *netmon)
+{
+	struct netmon_driver_data *nmd =3D ofono_netmon_get_data(netmon);
+
+	DBG("ublox netmon remove");
+
+	ofono_netmon_set_data(netmon, NULL);
+
+	g_at_chat_unref(nmd->modem);
+	g_at_chat_unref(nmd->aux);
+
+	g_free(nmd);
+}
+
+static struct ofono_netmon_driver driver =3D {
+	.name			=3D UBLOXMODEM,
+	.probe			=3D ublox_netmon_probe,
+	.remove			=3D ublox_netmon_remove,
+	.request_update		=3D ublox_netmon_request_update,
+};
+
+void ublox_netmon_init(void)
+{
+	ofono_netmon_driver_register(&driver);
+}
+
+void ublox_netmon_exit(void)
+{
+	ofono_netmon_driver_unregister(&driver);
+}
-- =

2.5.5


--===============4722544443655851247==--

