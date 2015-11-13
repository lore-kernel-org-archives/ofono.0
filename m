Content-Type: multipart/mixed; boundary="===============0276084865266089354=="
MIME-Version: 1.0
From: Alfonso Sanchez-Beato <alfonso.sanchez-beato@canonical.com>
Subject: [PATCH 5/7] mtkmodem: Add mtkmodem driver
Date: Fri, 13 Nov 2015 13:25:08 +0100
Message-ID: <1447417510-9368-6-git-send-email-alfonso.sanchez-beato@canonical.com>
In-Reply-To: <1447417510-9368-1-git-send-email-alfonso.sanchez-beato@canonical.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0276084865266089354==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

mtkmodem handles modems MediaTek modems and is based on rilmodem driver.
---
 drivers/mtkmodem/gprs.c           | 188 +++++++++++++++++++++++++++
 drivers/mtkmodem/mtk_constants.h  |  84 ++++++++++++
 drivers/mtkmodem/mtkmodem.c       |  58 +++++++++
 drivers/mtkmodem/mtkmodem.h       |  32 +++++
 drivers/mtkmodem/mtkreply.c       |  98 ++++++++++++++
 drivers/mtkmodem/mtkreply.h       |  43 +++++++
 drivers/mtkmodem/mtkrequest.c     | 163 ++++++++++++++++++++++++
 drivers/mtkmodem/mtkrequest.h     | 143 +++++++++++++++++++++
 drivers/mtkmodem/mtksettings.c    | 261 ++++++++++++++++++++++++++++++++++=
++++
 drivers/mtkmodem/mtksettings.h    |  43 +++++++
 drivers/mtkmodem/mtkunsol.c       | 199 +++++++++++++++++++++++++++++
 drivers/mtkmodem/mtkunsol.h       |  59 +++++++++
 drivers/mtkmodem/mtkutil.c        | 143 +++++++++++++++++++++
 drivers/mtkmodem/mtkutil.h        |  47 +++++++
 drivers/mtkmodem/radio-settings.c | 193 ++++++++++++++++++++++++++++
 drivers/mtkmodem/voicecall.c      | 155 ++++++++++++++++++++++
 16 files changed, 1909 insertions(+)
 create mode 100644 drivers/mtkmodem/gprs.c
 create mode 100644 drivers/mtkmodem/mtk_constants.h
 create mode 100644 drivers/mtkmodem/mtkmodem.c
 create mode 100644 drivers/mtkmodem/mtkmodem.h
 create mode 100644 drivers/mtkmodem/mtkreply.c
 create mode 100644 drivers/mtkmodem/mtkreply.h
 create mode 100644 drivers/mtkmodem/mtkrequest.c
 create mode 100644 drivers/mtkmodem/mtkrequest.h
 create mode 100644 drivers/mtkmodem/mtksettings.c
 create mode 100644 drivers/mtkmodem/mtksettings.h
 create mode 100644 drivers/mtkmodem/mtkunsol.c
 create mode 100644 drivers/mtkmodem/mtkunsol.h
 create mode 100644 drivers/mtkmodem/mtkutil.c
 create mode 100644 drivers/mtkmodem/mtkutil.h
 create mode 100644 drivers/mtkmodem/radio-settings.c
 create mode 100644 drivers/mtkmodem/voicecall.c

diff --git a/drivers/mtkmodem/gprs.c b/drivers/mtkmodem/gprs.c
new file mode 100644
index 0000000..073c3f1
--- /dev/null
+++ b/drivers/mtkmodem/gprs.c
@@ -0,0 +1,188 @@
+/*
+ *
+ *  oFono - Open Source Telephony
+ *
+ *  Copyright (C) 2008-2011  Intel Corporation. All rights reserved.
+ *  Copyright (C) 2010  ST-Ericsson AB.
+ *  Copyright (C) 2013-2014  Canonical Ltd.
+ *  Copyright (C) 2013 Jolla Ltd.
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
+#include <ofono/gprs.h>
+#include <ofono/types.h>
+
+#include "common.h"
+
+#include "mtkutil.h"
+#include "mtkmodem.h"
+#include "mtk_constants.h"
+#include "mtkrequest.h"
+#include "drivers/rilmodem/rilutil.h"
+#include "drivers/rilmodem/gprs.h"
+
+/* Time between get data status retries */
+#define GET_STATUS_TIMER_MS 5000
+
+/*
+ * This module is the ofono_gprs_driver implementation for mtkmodem. Most =
of the
+ * implementation can be found in the rilmodem gprs atom. The main reason =
for
+ * creating a new atom is the need to handle specific MTK requests that are
+ * needed to set-up the data call.
+ *
+ * Notes:
+ *
+ * 1. ofono_gprs_suspend/resume() are not used by this module, as
+ *    the concept of suspended GPRS is not exposed by RILD.
+ */
+
+struct gprs_attach_data {
+	struct ril_gprs_data *gd;
+	gboolean set_attached;
+};
+
+static void mtk_gprs_set_connect_type_cb(struct ril_msg *message,
+						gpointer user_data)
+{
+	struct cb_data *cbd =3D user_data;
+	ofono_gprs_cb_t cb =3D cbd->cb;
+	struct gprs_attach_data *attach_data =3D cbd->user;
+	struct ril_gprs_data *gd =3D attach_data->gd;
+
+	if (message->error =3D=3D RIL_E_SUCCESS) {
+		g_ril_print_response_no_args(gd->ril, message);
+
+		gd->ofono_attached =3D attach_data->set_attached;
+		mtk_set_attach_state(gd->modem, gd->ofono_attached);
+
+		CALLBACK_WITH_SUCCESS(cb, cbd->data);
+	} else {
+		ofono_error("%s: RIL error %s", __func__,
+				ril_error_to_string(message->error));
+		CALLBACK_WITH_FAILURE(cb, cbd->data);
+	}
+
+	g_free(attach_data);
+}
+
+static void mtk_gprs_set_attached(struct ofono_gprs *gprs, int attached,
+					ofono_gprs_cb_t cb, void *data)
+{
+	struct ril_gprs_data *gd =3D ofono_gprs_get_data(gprs);
+	struct cb_data *cbd;
+	struct parcel rilp;
+	struct gprs_attach_data *attach_data =3D
+		g_try_new0(struct gprs_attach_data, 1);
+
+	if (attach_data =3D=3D NULL) {
+		ofono_error("%s: out of memory", __func__);
+		return;
+	}
+
+	DBG("attached: %d", attached);
+
+	attach_data->gd =3D gd;
+	attach_data->set_attached =3D attached;
+
+	cbd =3D cb_data_new(cb, data, attach_data);
+
+	/* MTK controls attachment with this request, as opposed to rilmodem */
+
+	g_mtk_request_set_gprs_connect_type(gd->ril, attached, &rilp);
+
+	if (g_ril_send(gd->ril, MTK_RIL_REQUEST_SET_GPRS_CONNECT_TYPE, &rilp,
+			mtk_gprs_set_connect_type_cb, cbd, g_free) =3D=3D 0) {
+		ofono_error("%s: send failed", __func__);
+		g_free(cbd);
+		CALLBACK_WITH_FAILURE(cb, data);
+	}
+}
+
+static void detach_event(struct ril_msg *message, gpointer user_data)
+{
+	struct ofono_gprs *gprs =3D user_data;
+	struct ril_gprs_data *gd =3D ofono_gprs_get_data(gprs);
+
+	g_ril_print_unsol_no_args(gd->ril, message);
+
+	mtk_detach_received(gd->modem);
+}
+
+static int mtk_gprs_probe(struct ofono_gprs *gprs,
+				unsigned int vendor, void *data)
+{
+	struct ril_gprs_driver_data *driver_data =3D data;
+	struct ril_gprs_data *gd;
+
+	gd =3D g_try_new0(struct ril_gprs_data, 1);
+	if (gd =3D=3D NULL)
+		return -ENOMEM;
+
+	ril_gprs_start(driver_data, gprs, gd);
+
+	/*
+	 * In MTK the event emitted when the gprs state changes is different
+	 * from the one in AOSP ril. Overwrite the one set in parent.
+	 */
+	gd->state_changed_unsol =3D
+				MTK_RIL_UNSOL_RESPONSE_PS_NETWORK_STATE_CHANGED;
+
+	g_ril_register(gd->ril, MTK_RIL_UNSOL_GPRS_DETACH, detach_event, gprs);
+
+	return 0;
+}
+
+static void mtk_gprs_remove(struct ofono_gprs *gprs)
+{
+	struct ril_gprs_data *gd =3D ofono_gprs_get_data(gprs);
+
+	gd->ofono_attached =3D FALSE;
+	mtk_set_attach_state(gd->modem, gd->ofono_attached);
+
+	ril_gprs_remove(gprs);
+}
+
+static struct ofono_gprs_driver driver =3D {
+	.name			=3D MTKMODEM,
+	.probe			=3D mtk_gprs_probe,
+	.remove			=3D mtk_gprs_remove,
+	.set_attached		=3D mtk_gprs_set_attached,
+	.attached_status	=3D ril_gprs_registration_status,
+};
+
+void mtk_gprs_init(void)
+{
+	ofono_gprs_driver_register(&driver);
+}
+
+void mtk_gprs_exit(void)
+{
+	ofono_gprs_driver_unregister(&driver);
+}
diff --git a/drivers/mtkmodem/mtk_constants.h b/drivers/mtkmodem/mtk_consta=
nts.h
new file mode 100644
index 0000000..bd9891b
--- /dev/null
+++ b/drivers/mtkmodem/mtk_constants.h
@@ -0,0 +1,84 @@
+/*
+ *
+ *  RIL constants for MTK modem
+ *
+ *  Copyright (C) 2014 Canonical Ltd.
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
+#ifndef MTK_CONSTANTS_H
+#define MTK_CONSTANTS_H
+
+/* RIL Request Messages */
+#define MTK_RIL_REQUEST_RADIO_POWEROFF 2011
+#define MTK_RIL_REQUEST_DUAL_SIM_MODE_SWITCH 2012
+#define MTK_RIL_REQUEST_SET_GPRS_CONNECT_TYPE 2016
+#define MTK_RIL_REQUEST_SET_GPRS_TRANSFER_TYPE 2017
+#define MTK_RIL_REQUEST_RADIO_POWERON 2033
+#define MTK_RIL_REQUEST_SET_CALL_INDICATION 2036
+#define MTK_RIL_REQUEST_GET_3G_CAPABILITY 2038
+#define MTK_RIL_REQUEST_SET_3G_CAPABILITY 2039
+#define MTK_RIL_REQUEST_SET_TRM 2053
+#define MTK_RIL_REQUEST_SET_FD_MODE 2073
+#define MTK_RIL_REQUEST_RESUME_REGISTRATION 2077
+#define MTK_RIL_REQUEST_STORE_MODEM_TYPE 2078
+#define MTK_RIL_REQUEST_QUERY_MODEM_TYPE 2079
+
+/* RIL Unsolicited Messages */
+#define MTK_RIL_UNSOL_MTK_BASE 3000
+
+#define MTK_RIL_UNSOL_NEIGHBORING_CELL_INFO (MTK_RIL_UNSOL_MTK_BASE + 0)
+#define MTK_RIL_UNSOL_NETWORK_INFO (MTK_RIL_UNSOL_MTK_BASE + 1)
+#define MTK_RIL_UNSOL_CALL_FORWARDING (MTK_RIL_UNSOL_MTK_BASE + 2)
+#define MTK_RIL_UNSOL_CRSS_NOTIFICATION (MTK_RIL_UNSOL_MTK_BASE + 3)
+#define MTK_RIL_UNSOL_CALL_PROGRESS_INFO (MTK_RIL_UNSOL_MTK_BASE + 4)
+#define MTK_RIL_UNSOL_PHB_READY_NOTIFICATION (MTK_RIL_UNSOL_MTK_BASE + 5)
+#define MTK_RIL_UNSOL_SPEECH_INFO (MTK_RIL_UNSOL_MTK_BASE + 6)
+#define MTK_RIL_UNSOL_SIM_INSERTED_STATUS (MTK_RIL_UNSOL_MTK_BASE + 7)
+#define MTK_RIL_UNSOL_RADIO_TEMPORARILY_UNAVAILABLE (MTK_RIL_UNSOL_MTK_BAS=
E + 8)
+#define MTK_RIL_UNSOL_ME_SMS_STORAGE_FULL (MTK_RIL_UNSOL_MTK_BASE + 9)
+#define MTK_RIL_UNSOL_SMS_READY_NOTIFICATION (MTK_RIL_UNSOL_MTK_BASE + 10)
+#define MTK_RIL_UNSOL_SCRI_RESULT (MTK_RIL_UNSOL_MTK_BASE + 11)
+#define MTK_RIL_UNSOL_VT_STATUS_INFO (MTK_RIL_UNSOL_MTK_BASE + 12)
+#define MTK_RIL_UNSOL_VT_RING_INFO (MTK_RIL_UNSOL_MTK_BASE + 13)
+#define MTK_RIL_UNSOL_INCOMING_CALL_INDICATION (MTK_RIL_UNSOL_MTK_BASE + 1=
4)
+#define MTK_RIL_UNSOL_SIM_MISSING (MTK_RIL_UNSOL_MTK_BASE + 15)
+#define MTK_RIL_UNSOL_GPRS_DETACH (MTK_RIL_UNSOL_MTK_BASE + 16)
+#define MTK_RIL_UNSOL_ATCI_RESPONSE (MTK_RIL_UNSOL_MTK_BASE + 17)
+#define MTK_RIL_UNSOL_SIM_RECOVERY (MTK_RIL_UNSOL_MTK_BASE + 18)
+#define MTK_RIL_UNSOL_VIRTUAL_SIM_ON (MTK_RIL_UNSOL_MTK_BASE + 19)
+#define MTK_RIL_UNSOL_VIRTUAL_SIM_OFF (MTK_RIL_UNSOL_MTK_BASE + 20)
+#define MTK_RIL_UNSOL_INVALID_SIM (MTK_RIL_UNSOL_MTK_BASE + 21)
+#define MTK_RIL_UNSOL_RESPONSE_PS_NETWORK_STATE_CHANGED \
+						(MTK_RIL_UNSOL_MTK_BASE + 22)
+#define MTK_RIL_UNSOL_RESPONSE_ACMT (MTK_RIL_UNSOL_MTK_BASE + 23)
+#define MTK_RIL_UNSOL_EF_CSP_PLMN_MODE_BIT (MTK_RIL_UNSOL_MTK_BASE + 24)
+#define MTK_RIL_UNSOL_IMEI_LOCK (MTK_RIL_UNSOL_MTK_BASE + 25)
+#define MTK_RIL_UNSOL_RESPONSE_MMRR_STATUS_CHANGED (MTK_RIL_UNSOL_MTK_BASE=
 + 26)
+#define MTK_RIL_UNSOL_SIM_PLUG_OUT (MTK_RIL_UNSOL_MTK_BASE + 27)
+#define MTK_RIL_UNSOL_SIM_PLUG_IN (MTK_RIL_UNSOL_MTK_BASE + 28)
+#define MTK_RIL_UNSOL_RESPONSE_ETWS_NOTIFICATION (MTK_RIL_UNSOL_MTK_BASE +=
 29)
+#define MTK_RIL_UNSOL_RESPONSE_PLMN_CHANGED (MTK_RIL_UNSOL_MTK_BASE + 30)
+#define MTK_RIL_UNSOL_RESPONSE_REGISTRATION_SUSPENDED \
+						(MTK_RIL_UNSOL_MTK_BASE + 31)
+#define MTK_RIL_UNSOL_STK_EVDL_CALL (MTK_RIL_UNSOL_MTK_BASE + 32)
+#define MTK_RIL_UNSOL_DATA_PACKETS_FLUSH (MTK_RIL_UNSOL_MTK_BASE + 33)
+#define MTK_RIL_UNSOL_CIPHER_INDICATION (MTK_RIL_UNSOL_MTK_BASE + 34)
+#define MTK_RIL_UNSOL_FEMTOCELL_INFO (MTK_RIL_UNSOL_MTK_BASE + 35)
+#define MTK_RIL_UNSOL_CNAP (MTK_RIL_UNSOL_MTK_BASE + 36)
+#define MTK_RIL_UNSOL_RAC_UPDATE (MTK_RIL_UNSOL_MTK_BASE + 37)
+
+#endif /* MTK_CONSTANTS_H */
diff --git a/drivers/mtkmodem/mtkmodem.c b/drivers/mtkmodem/mtkmodem.c
new file mode 100644
index 0000000..91cd8ab
--- /dev/null
+++ b/drivers/mtkmodem/mtkmodem.c
@@ -0,0 +1,58 @@
+/*
+ *
+ *  oFono - Open Source Telephony - RIL Modem Support
+ *
+ *  Copyright (C) 2008-2011  Intel Corporation. All rights reserved.
+ *  Copyright (C) 2014  Canonical, Ltd. All rights reserved.
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
+#include <glib.h>
+#include <gril.h>
+
+#define OFONO_API_SUBJECT_TO_CHANGE
+#include <ofono/plugin.h>
+#include <ofono/log.h>
+#include <ofono/types.h>
+
+#include "mtkmodem.h"
+
+static int mtkmodem_init(void)
+{
+	DBG("");
+
+	mtk_voicecall_init();
+	mtk_gprs_init();
+	mtk_radio_settings_init();
+
+	return 0;
+}
+
+static void mtkmodem_exit(void)
+{
+	DBG("");
+
+	mtk_voicecall_exit();
+	mtk_gprs_exit();
+	mtk_radio_settings_exit();
+}
+
+OFONO_PLUGIN_DEFINE(mtkmodem, "MTK modem driver", VERSION,
+		OFONO_PLUGIN_PRIORITY_DEFAULT, mtkmodem_init, mtkmodem_exit)
diff --git a/drivers/mtkmodem/mtkmodem.h b/drivers/mtkmodem/mtkmodem.h
new file mode 100644
index 0000000..037a57c
--- /dev/null
+++ b/drivers/mtkmodem/mtkmodem.h
@@ -0,0 +1,32 @@
+/*
+ *
+ *  oFono - Open Source Telephony - RIL Modem Support
+ *
+ *  Copyright (C) 2008-2011  Intel Corporation. All rights reserved.
+ *  Copyright (C) 2014  Canonical Ltd.
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
+#define MTKMODEM "mtkmodem"
+
+extern void mtk_voicecall_init(void);
+extern void mtk_voicecall_exit(void);
+
+extern void mtk_gprs_init(void);
+extern void mtk_gprs_exit(void);
+
+extern void mtk_radio_settings_init(void);
+extern void mtk_radio_settings_exit(void);
diff --git a/drivers/mtkmodem/mtkreply.c b/drivers/mtkmodem/mtkreply.c
new file mode 100644
index 0000000..9c7625e
--- /dev/null
+++ b/drivers/mtkmodem/mtkreply.c
@@ -0,0 +1,98 @@
+/*
+ *
+ *  MTK driver for ofono/rilmodem
+ *
+ *  Copyright (C) 2014  Canonical Ltd.
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
+#include <stdio.h>
+
+#include <glib.h>
+
+#include <ofono/log.h>
+
+#include "mtkreply.h"
+
+int g_mtk_reply_parse_get_3g_capability(GRil *gril,
+					const struct ril_msg *message)
+{
+	struct parcel rilp;
+	int slot_3g, numint;
+
+	g_ril_init_parcel(message, &rilp);
+
+	numint =3D parcel_r_int32(&rilp);
+	if (numint < 1) {
+		ofono_error("%s: wrong format", __func__);
+		goto error;
+	}
+
+	/*
+	 * Bitmap with 3g capability per slot. Reply is the same regardless of
+	 * the socket used to sent the request.
+	 */
+	slot_3g =3D parcel_r_int32(&rilp);
+
+	if (rilp.malformed) {
+		ofono_error("%s: malformed parcel", __func__);
+		goto error;
+	}
+
+	g_ril_append_print_buf(gril, "{%d}", slot_3g);
+	g_ril_print_response(gril, message);
+
+	/* Do it zero-based */
+	return slot_3g - 1;
+
+error:
+	return -1;
+}
+
+int g_mtk_reply_parse_query_modem_type(GRil *gril,
+					const struct ril_msg *message)
+{
+	struct parcel rilp;
+	int numint, type;
+
+	g_ril_init_parcel(message, &rilp);
+
+	numint =3D parcel_r_int32(&rilp);
+	if (numint !=3D 1) {
+		ofono_error("%s Wrong format", __func__);
+		goto error;
+	}
+
+	type =3D parcel_r_int32(&rilp);
+
+	if (rilp.malformed) {
+		ofono_error("%s: malformed parcel", __func__);
+		goto error;
+	}
+
+	g_ril_append_print_buf(gril, "{%d}", type);
+	g_ril_print_response(gril, message);
+
+	return type;
+
+error:
+	return -1;
+
+}
diff --git a/drivers/mtkmodem/mtkreply.h b/drivers/mtkmodem/mtkreply.h
new file mode 100644
index 0000000..7a616b6
--- /dev/null
+++ b/drivers/mtkmodem/mtkreply.h
@@ -0,0 +1,43 @@
+/*
+ *
+ *  MTK driver for ofono/rilmodem
+ *
+ *  Copyright (C) 2014  Canonical Ltd.
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
+#ifndef MTKREPLY_H
+#define MTKREPLY_H
+
+#include <ofono/types.h>
+
+#include "gril.h"
+
+#ifdef __cplusplus
+extern "C" {
+#endif
+
+int g_mtk_reply_parse_get_3g_capability(GRil *gril,
+					const struct ril_msg *message);
+
+int g_mtk_reply_parse_query_modem_type(GRil *gril,
+					const struct ril_msg *message);
+
+#ifdef __cplusplus
+}
+#endif
+
+#endif /* MTKREPLY_H */
diff --git a/drivers/mtkmodem/mtkrequest.c b/drivers/mtkmodem/mtkrequest.c
new file mode 100644
index 0000000..4c63df3
--- /dev/null
+++ b/drivers/mtkmodem/mtkrequest.c
@@ -0,0 +1,163 @@
+/*
+ *
+ *  MTK driver for ofono/rilmodem
+ *
+ *  Copyright (C) 2014  Canonical Ltd.
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
+#include <stdio.h>
+#include <ctype.h>
+
+#include <glib.h>
+
+#include <ofono/log.h>
+#include <ofono/modem.h>
+#include <ofono/gprs-context.h>
+
+#include "mtkrequest.h"
+#include "simutil.h"
+#include "util.h"
+#include "common.h"
+
+void g_mtk_request_dual_sim_mode_switch(GRil *gril,
+					int mode,
+					struct parcel *rilp)
+{
+	parcel_init(rilp);
+	parcel_w_int32(rilp, 1);
+	parcel_w_int32(rilp, mode);
+
+	g_ril_append_print_buf(gril, "(%d)", mode);
+}
+
+void g_mtk_request_set_gprs_connect_type(GRil *gril,
+						int always,
+						struct parcel *rilp)
+{
+	parcel_init(rilp);
+	parcel_w_int32(rilp, 1);
+	parcel_w_int32(rilp, always);
+
+	g_ril_append_print_buf(gril, "(%d)", always);
+};
+
+void g_mtk_request_set_gprs_transfer_type(GRil *gril,
+						int callprefer,
+						struct parcel *rilp)
+{
+	parcel_init(rilp);
+	parcel_w_int32(rilp, 1);
+	parcel_w_int32(rilp, callprefer);
+
+	g_ril_append_print_buf(gril, "(%d)", callprefer);
+}
+
+void g_mtk_request_set_call_indication(GRil *gril, int mode, int call_id,
+					int seq_number, struct parcel *rilp)
+{
+	parcel_init(rilp);
+	parcel_w_int32(rilp, 3);
+	/* What the parameters set is unknown */
+	parcel_w_int32(rilp, mode);
+	parcel_w_int32(rilp, call_id);
+	parcel_w_int32(rilp, seq_number);
+
+	g_ril_append_print_buf(gril, "(%d,%d,%d)", mode, call_id, seq_number);
+}
+
+void g_mtk_request_set_fd_mode(GRil *gril, int mode, int param1,
+					int param2, struct parcel *rilp)
+{
+	int num_args;
+
+	switch (mode) {
+	case MTK_FD_MODE_DISABLE:
+	case MTK_FD_MODE_ENABLE:
+		num_args =3D 1;
+		break;
+	case MTK_FD_MODE_SET_TIMER:
+		num_args =3D 3;
+		break;
+	case MTK_FD_MODE_SCREEN_STATUS:
+		num_args =3D 2;
+		break;
+	default:
+		ofono_error("%s: mode %d is wrong", __func__, mode);
+		return;
+	}
+
+	parcel_init(rilp);
+	parcel_w_int32(rilp, num_args);
+	parcel_w_int32(rilp, mode);
+
+	g_ril_append_print_buf(gril, "(%d,%d", num_args, mode);
+
+	if (mode =3D=3D MTK_FD_MODE_SCREEN_STATUS) {
+		parcel_w_int32(rilp, param1);
+		g_ril_append_print_buf(gril, "%s,%d)", print_buf, param1);
+	} else if (mode =3D=3D MTK_FD_MODE_SET_TIMER) {
+		parcel_w_int32(rilp, param1);
+		parcel_w_int32(rilp, param2);
+		g_ril_append_print_buf(gril, "%s,%d,%d)", print_buf,
+					param1, param2);
+	} else {
+		g_ril_append_print_buf(gril, "%s)", print_buf);
+	}
+}
+
+void g_mtk_request_set_3g_capability(GRil *gril, struct parcel *rilp)
+{
+	int mode =3D g_ril_get_slot(gril) + 1;
+
+	parcel_init(rilp);
+	parcel_w_int32(rilp, 1);
+	parcel_w_int32(rilp, mode);
+
+	g_ril_append_print_buf(gril, "(%d)", mode);
+}
+
+void g_mtk_request_store_modem_type(GRil *gril, int mode, struct parcel *r=
ilp)
+{
+	parcel_init(rilp);
+	parcel_w_int32(rilp, 1);
+	parcel_w_int32(rilp, mode);
+
+	g_ril_append_print_buf(gril, "(%d)", mode);
+}
+
+void g_mtk_request_set_trm(GRil *gril, int trm, struct parcel *rilp)
+{
+	parcel_init(rilp);
+	parcel_w_int32(rilp, 1);
+	parcel_w_int32(rilp, trm);
+
+	g_ril_append_print_buf(gril, "(%d)", trm);
+}
+
+void g_mtk_request_resume_registration(GRil *gril, int session_id,
+					struct parcel *rilp)
+{
+	parcel_init(rilp);
+	parcel_w_int32(rilp, 1);
+	parcel_w_int32(rilp, session_id);
+
+	g_ril_append_print_buf(gril, "(%d)", session_id);
+}
diff --git a/drivers/mtkmodem/mtkrequest.h b/drivers/mtkmodem/mtkrequest.h
new file mode 100644
index 0000000..a393124
--- /dev/null
+++ b/drivers/mtkmodem/mtkrequest.h
@@ -0,0 +1,143 @@
+/*
+ *
+ *  MTK driver for ofono/rilmodem
+ *
+ *  Copyright (C) 2014  Canonical Ltd.
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
+#ifndef MTKREQUEST_H
+#define MTKREQUEST_H
+
+#include <ofono/types.h>
+#include <ofono/sim.h>
+
+#include "gril.h"
+
+#ifdef __cplusplus
+extern "C" {
+#endif
+
+#define MTK_SWITCH_MODE_SIM_1_ACTIVE 1
+#define MTK_SWITCH_MODE_SIM_2_ACTIVE 2
+#define MTK_SWITCH_MODE_ALL_INACTIVE -1
+
+#define MTK_GPRS_CONNECT_WHEN_NEEDED 0
+#define MTK_GPRS_CONNECT_ALWAYS 1
+
+#define MTK_GPRS_TRANSFER_DATA_PREFER 0
+#define MTK_GPRS_TRANSFER_CALL_PREFER 1
+
+#define MTK_CALL_INDIC_MODE_AVAIL 0
+#define MTK_CALL_INDIC_MODE_NOT_AVAIL 1
+
+#define MTK_FD_MODE_DISABLE 0
+#define MTK_FD_MODE_ENABLE 1
+#define MTK_FD_MODE_SET_TIMER 2
+#define MTK_FD_MODE_SCREEN_STATUS 3
+
+#define MTK_FD_PAR1_SCREEN_OFF 0
+#define MTK_FD_PAR1_SCREEN_ON 1
+
+#define MTK_MD_TYPE_INVALID 0
+#define MTK_MD_TYPE_2G 1
+#define MTK_MD_TYPE_3G 2
+#define MTK_MD_TYPE_WG 3
+#define MTK_MD_TYPE_TG 4
+/* FDD CSFB modem: LTE FDD - WCDMA - GSM */
+#define MTK_MD_TYPE_LWG 5
+/* TDD CSFB modem: LTE TDD - TD-SCDMA - GSM */
+#define MTK_MD_TYPE_LTG 6
+/* SGLTE modem */
+#define MTK_MD_TYPE_LTNG 7
+
+/*
+ * The meaning of mode seems to be:
+ * -1 -> Both SIMs inactive
+ * 1 -> SIM 1 active
+ * 2 -> SIM 2 active
+ * 3 -> Both SIMs active
+ */
+void g_mtk_request_dual_sim_mode_switch(GRil *gril,
+					int mode,
+					struct parcel *rilp);
+
+/* 0:WHEN_NEEDED , 1: ALWAYS */
+void g_mtk_request_set_gprs_connect_type(GRil *gril,
+						int always,
+						struct parcel *rilp);
+
+/* 0:data prefer , 1: call prefer */
+void g_mtk_request_set_gprs_transfer_type(GRil *gril,
+						int callprefer,
+						struct parcel *rilp);
+
+/*
+ * mode. MTK_CALL_INDIC_MODE_AVAIL: indicates that the specified call can =
be
+ *       answered.
+ *       MTK_CALL_INDIC_MODE_NOT_AVAIL: indicates we are busy, and that the
+ *       specified call cannot be handled
+ * "mode" seems useful for full dual SIM. An example would be that we have=
 an
+ * active call and an incoming call from the other SIM is signalled.
+ *
+ * call_id and seq_number are used to identify a specific call in the mode=
m and
+ * are taken from a previous RIL_UNSOL_INCOMING_CALL_INDICATION.
+ */
+void g_mtk_request_set_call_indication(GRil *gril, int mode, int call_id,
+					int seq_number, struct parcel *rilp);
+
+/*
+ * mode . MTK_FD_MODE_DISABLE: Disable fast dormancy
+ *        MTK_FD_MODE_ENABLE: Enable fast formancy
+ *        MTK_FD_MODE_SET_TIMER: Set fast dormancy timer
+ *        MTK_FD_MODE_SCREEN_STATUS: Inform modem of screen status, to sel=
ect
+ *                                   timers to use for FD.
+ * param1 Id of timer to set or screen status
+ * param2 Value of timer, in units of 0.1 seconds
+ *
+ * Setting timers and enabling FD is done by rild initialization, so we do=
 not
+ * need to do it again in ofono.
+ */
+void g_mtk_request_set_fd_mode(GRil *gril, int mode, int param1,
+					int param2, struct parcel *rilp);
+
+/*
+ * Sets the slot to which the GRil object is connected as the one with 3G
+ * capabilities. This makes the other slot just 2G.
+ */
+void g_mtk_request_set_3g_capability(GRil *gril, struct parcel *rilp);
+
+/*
+ * Set the MTK modem mode. See MTK_MD_TYPE_*.
+ */
+void g_mtk_request_store_modem_type(GRil *gril, int mode, struct parcel *r=
ilp);
+
+/*
+ * Set TRM
+ */
+void g_mtk_request_set_trm(GRil *gril, int trm, struct parcel *rilp);
+
+/*
+ * Request to resume registration.
+ */
+void g_mtk_request_resume_registration(GRil *gril, int session_id,
+					struct parcel *rilp);
+
+#ifdef __cplusplus
+}
+#endif
+
+#endif /* MTKREQUEST_H */
diff --git a/drivers/mtkmodem/mtksettings.c b/drivers/mtkmodem/mtksettings.c
new file mode 100644
index 0000000..165c4d9
--- /dev/null
+++ b/drivers/mtkmodem/mtksettings.c
@@ -0,0 +1,261 @@
+/*
+ *
+ *  oFono - Open Source Telephony
+ *
+ *  Copyright (C) 2014  Canonical Ltd.
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
+#include <string.h>
+#include <stdlib.h>
+#include <stdio.h>
+#include <errno.h>
+#include <glib.h>
+#include <gdbus.h>
+#include <ofono.h>
+
+#define OFONO_API_SUBJECT_TO_CHANGE
+#include <ofono/plugin.h>
+#include <ofono/log.h>
+#include <ofono/modem.h>
+#include <ofono/dbus.h>
+
+#include "drivers/mtkmodem/mtk_constants.h"
+#include "drivers/mtkmodem/mtkrequest.h"
+#include "drivers/mtkmodem/mtkutil.h"
+#include "mtksettings.h"
+
+#define MTK_SETTINGS_INTERFACE "org.ofono.MtkSettings"
+
+struct mtk_settings_data {
+	struct ofono_modem *modem;
+	GRil *ril;
+	ofono_bool_t has_3g;
+	ofono_bool_t has_3g_pending;
+	DBusMessage *pending;
+};
+
+static void set_3g(struct mtk_settings_data *msd, ofono_bool_t has_3g)
+{
+	DBusConnection *conn =3D ofono_dbus_get_connection();
+	const char *path =3D ofono_modem_get_path(msd->modem);
+	dbus_bool_t value =3D has_3g;
+
+	if (msd->has_3g =3D=3D has_3g)
+		return;
+
+	ofono_dbus_signal_property_changed(conn, path, MTK_SETTINGS_INTERFACE,
+						"Has3G", DBUS_TYPE_BOOLEAN,
+						&value);
+	msd->has_3g =3D has_3g;
+}
+
+static void set_3g_cb(struct ril_msg *message, gpointer user_data)
+{
+	struct mtk_settings_data *msd =3D user_data;
+	DBusMessage *reply;
+
+	if (message->error !=3D RIL_E_SUCCESS) {
+		ofono_error("%s: Error setting 3G", __func__);
+
+		msd->has_3g_pending =3D msd->has_3g;
+
+		reply =3D __ofono_error_failed(msd->pending);
+		__ofono_dbus_pending_reply(&msd->pending, reply);
+
+		return;
+	}
+
+	g_ril_print_response_no_args(msd->ril, message);
+
+	reply =3D dbus_message_new_method_return(msd->pending);
+	__ofono_dbus_pending_reply(&msd->pending, reply);
+
+	set_3g(msd, msd->has_3g_pending);
+
+	mtk_reset_all_modems();
+}
+
+static DBusMessage *set_property(DBusConnection *conn, DBusMessage *msg,
+					void *data)
+{
+	struct mtk_settings_data *msd =3D data;
+	DBusMessageIter iter;
+	DBusMessageIter var;
+	const char *property;
+
+	if (msd->pending)
+		return __ofono_error_busy(msg);
+
+	if (!dbus_message_iter_init(msg, &iter))
+		return __ofono_error_invalid_args(msg);
+
+	if (dbus_message_iter_get_arg_type(&iter) !=3D DBUS_TYPE_STRING)
+		return __ofono_error_invalid_args(msg);
+
+	dbus_message_iter_get_basic(&iter, &property);
+	dbus_message_iter_next(&iter);
+
+	if (dbus_message_iter_get_arg_type(&iter) !=3D DBUS_TYPE_VARIANT)
+		return __ofono_error_invalid_args(msg);
+
+	dbus_message_iter_recurse(&iter, &var);
+
+	if (g_strcmp0(property, "Has3G") =3D=3D 0) {
+		dbus_bool_t value;
+		struct parcel rilp;
+
+		if (dbus_message_iter_get_arg_type(&var) !=3D DBUS_TYPE_BOOLEAN)
+			return __ofono_error_invalid_args(msg);
+
+		dbus_message_iter_get_basic(&var, &value);
+
+		if (msd->has_3g_pending =3D=3D (ofono_bool_t) value)
+			return dbus_message_new_method_return(msg);
+
+		/*
+		 * We can only set to true, as setting to false could be
+		 * confusing in a multi-sim environment (>2 SIM)
+		 */
+		if (value =3D=3D FALSE)
+			return __ofono_error_invalid_args(msg);
+
+		g_mtk_request_set_3g_capability(msd->ril, &rilp);
+
+		if (g_ril_send(msd->ril, MTK_RIL_REQUEST_SET_3G_CAPABILITY,
+				&rilp, set_3g_cb, msd, NULL) =3D=3D 0) {
+			ofono_error("%s: unable to set 3G for slot", __func__);
+			return __ofono_error_failed(msg);
+		}
+
+		msd->pending =3D dbus_message_ref(msg);
+		msd->has_3g_pending =3D value;
+
+		return NULL;
+	}
+
+	return __ofono_error_invalid_args(msg);
+}
+
+static DBusMessage *get_properties(DBusConnection *conn,
+					DBusMessage *msg, void *data)
+{
+	struct mtk_settings_data *msd =3D data;
+	DBusMessage *reply;
+	DBusMessageIter iter;
+	DBusMessageIter dict;
+
+	reply =3D dbus_message_new_method_return(msg);
+	if (reply =3D=3D NULL)
+		return NULL;
+
+	dbus_message_iter_init_append(reply, &iter);
+
+	dbus_message_iter_open_container(&iter, DBUS_TYPE_ARRAY,
+					OFONO_PROPERTIES_ARRAY_SIGNATURE,
+					&dict);
+
+	ofono_dbus_dict_append(&dict, "Has3G",
+				DBUS_TYPE_BOOLEAN, &msd->has_3g);
+
+	dbus_message_iter_close_container(&iter, &dict);
+
+	return reply;
+}
+
+static const GDBusMethodTable mtk_settings_methods[] =3D {
+	{ GDBUS_ASYNC_METHOD("GetProperties",
+			NULL, GDBUS_ARGS({ "properties", "a{sv}" }),
+			get_properties) },
+	{ GDBUS_ASYNC_METHOD("SetProperty",
+			GDBUS_ARGS({ "property", "s" }, { "value", "v" }),
+			NULL, set_property) },
+	{ }
+};
+
+static const GDBusSignalTable mtk_settings_signals[] =3D {
+	{ GDBUS_SIGNAL("PropertyChanged",
+			GDBUS_ARGS({ "name", "s" }, { "value", "v" })) },
+	{ }
+};
+
+
+static void register_interface(struct mtk_settings_data *msd)
+{
+	DBusConnection *conn =3D ofono_dbus_get_connection();
+
+	if (!g_dbus_register_interface(conn, ofono_modem_get_path(msd->modem),
+					MTK_SETTINGS_INTERFACE,
+					mtk_settings_methods,
+					mtk_settings_signals,
+					NULL, msd, NULL)) {
+		ofono_error("Could not create %s interface",
+				MTK_SETTINGS_INTERFACE);
+		return;
+	}
+
+	ofono_modem_add_interface(msd->modem, MTK_SETTINGS_INTERFACE);
+}
+
+static void unregister_interface(struct mtk_settings_data *msd)
+{
+	DBusConnection *conn =3D ofono_dbus_get_connection();
+
+	ofono_modem_remove_interface(msd->modem, MTK_SETTINGS_INTERFACE);
+
+	g_dbus_unregister_interface(conn,
+					ofono_modem_get_path(msd->modem),
+					MTK_SETTINGS_INTERFACE);
+}
+
+struct mtk_settings_data *mtk_settings_create(struct ofono_modem *modem,
+						GRil *ril, ofono_bool_t has_3g)
+{
+	struct mtk_settings_data *msd =3D g_try_malloc0(sizeof(*msd));
+
+	DBG("");
+
+	if (msd =3D=3D NULL) {
+		ofono_error("%s: Cannot allocate mtk_settings_data", __func__);
+		return NULL;
+	}
+
+	msd->modem =3D modem;
+	msd->ril =3D g_ril_clone(ril);
+
+	msd->has_3g =3D has_3g;
+	msd->has_3g_pending =3D has_3g;
+
+	register_interface(msd);
+
+	return msd;
+}
+
+void mtk_settings_remove(struct mtk_settings_data *msd)
+{
+	DBG("");
+
+	if (msd =3D=3D NULL)
+		return;
+
+	unregister_interface(msd);
+
+	g_ril_unref(msd->ril);
+	g_free(msd);
+}
diff --git a/drivers/mtkmodem/mtksettings.h b/drivers/mtkmodem/mtksettings.h
new file mode 100644
index 0000000..978f33d
--- /dev/null
+++ b/drivers/mtkmodem/mtksettings.h
@@ -0,0 +1,43 @@
+/*
+ *
+ *  MTK driver for ofono/rilmodem
+ *
+ *  Copyright (C) 2014  Canonical Ltd.
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
+#ifndef MTKSETTINGS_H
+#define MTKSETTINGS_H
+
+#include <ofono/types.h>
+
+#include "gril.h"
+
+#ifdef __cplusplus
+extern "C" {
+#endif
+
+struct mtk_settings_data;
+
+struct mtk_settings_data *mtk_settings_create(struct ofono_modem *modem,
+						GRil *ril, ofono_bool_t has_3g);
+void mtk_settings_remove(struct mtk_settings_data *msd);
+
+#ifdef __cplusplus
+}
+#endif
+
+#endif /* MTKSETTINGS_H */
diff --git a/drivers/mtkmodem/mtkunsol.c b/drivers/mtkmodem/mtkunsol.c
new file mode 100644
index 0000000..dcd58cc
--- /dev/null
+++ b/drivers/mtkmodem/mtkunsol.c
@@ -0,0 +1,199 @@
+/*
+ *
+ *  MTK driver for ofono/rilmodem
+ *
+ *  Copyright (C) 2014  Canonical Ltd.
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
+#include <stdio.h>
+#include <ctype.h>
+
+#include <glib.h>
+
+#include <ofono/log.h>
+
+#include "mtkunsol.h"
+#include "util.h"
+#include "common.h"
+
+void g_mtk_unsol_free_call_indication(struct unsol_call_indication *unsol)
+{
+	g_free(unsol);
+}
+
+struct unsol_call_indication *g_mtk_unsol_parse_incoming_call_indication(
+					GRil *gril, struct ril_msg *message)
+{
+	struct parcel rilp;
+	int numstr;
+	struct unsol_call_indication *unsol;
+	char *call_id, *phone, *mystery, *call_mode, *seq_num;
+	char *endp;
+
+	unsol =3D g_try_malloc0(sizeof(*unsol));
+	if (unsol =3D=3D NULL) {
+		ofono_error("%s: out of memory", __func__);
+		goto error;
+	}
+
+	g_ril_init_parcel(message, &rilp);
+
+	numstr =3D parcel_r_int32(&rilp);
+	if (numstr !=3D 5) {
+		ofono_error("%s: wrong array size (%d)", __func__, numstr);
+		goto error;
+	}
+
+	call_id =3D parcel_r_string(&rilp);
+	phone =3D parcel_r_string(&rilp);
+	mystery =3D parcel_r_string(&rilp);
+	call_mode =3D parcel_r_string(&rilp);
+	seq_num =3D parcel_r_string(&rilp);
+
+	g_ril_append_print_buf(gril, "{%s,%s,%s,%s,%s}", call_id, phone,
+				mystery, call_mode, seq_num);
+
+	g_ril_print_unsol(gril, message);
+
+	if (rilp.malformed) {
+		ofono_error("%s: malformed parcel", __func__);
+		goto err_conv;
+	}
+
+	if (call_id !=3D NULL && *call_id !=3D '\0') {
+		unsol->call_id =3D (int) strtol(call_id, &endp, 10);
+		if (*endp !=3D '\0') {
+			ofono_error("%s: cannot parse call id", __func__);
+			goto err_conv;
+		}
+	} else {
+		ofono_error("%s: no call id", __func__);
+		goto err_conv;
+	}
+
+	if (call_mode !=3D NULL && *call_mode !=3D '\0') {
+		unsol->call_mode =3D (int) strtol(call_mode, &endp, 10);
+		if (*endp !=3D '\0') {
+			ofono_error("%s: cannot parse call mode", __func__);
+			goto err_conv;
+		}
+	} else {
+		ofono_error("%s: no call mode", __func__);
+		goto err_conv;
+	}
+
+	if (seq_num !=3D NULL && *seq_num !=3D '\0') {
+		unsol->seq_number =3D (int) strtol(seq_num, &endp, 10);
+		if (*endp !=3D '\0') {
+			ofono_error("%s: cannot parse seq num", __func__);
+			goto err_conv;
+		}
+	} else {
+		ofono_error("%s: no seq num", __func__);
+		goto err_conv;
+	}
+
+	g_free(call_id);
+	g_free(phone);
+	g_free(mystery);
+	g_free(call_mode);
+	g_free(seq_num);
+
+	return unsol;
+
+err_conv:
+	g_free(call_id);
+	g_free(phone);
+	g_free(mystery);
+	g_free(call_mode);
+	g_free(seq_num);
+
+error:
+	g_free(unsol);
+
+	return NULL;
+}
+
+int g_mtk_unsol_parse_registration_suspended(GRil *gril,
+						const struct ril_msg *message)
+{
+	struct parcel rilp;
+	int numint, session_id;
+
+	g_ril_init_parcel(message, &rilp);
+
+	numint =3D parcel_r_int32(&rilp);
+	if (numint !=3D 1) {
+		ofono_error("%s Wrong format", __func__);
+		goto error;
+	}
+
+	session_id =3D parcel_r_int32(&rilp);
+
+	if (rilp.malformed) {
+		ofono_error("%s: malformed parcel", __func__);
+		goto error;
+	}
+
+	g_ril_append_print_buf(gril, "{%d}", session_id);
+	g_ril_print_unsol(gril, message);
+
+	return session_id;
+
+error:
+	return -1;
+
+}
+
+struct parcel_str_array *g_mtk_unsol_parse_plmn_changed(GRil *gril,
+						const struct ril_msg *message)
+{
+	struct parcel rilp;
+	struct parcel_str_array *str_arr;
+	int i;
+
+	g_ril_init_parcel(message, &rilp);
+
+	str_arr =3D parcel_r_str_array(&rilp);
+	if (str_arr =3D=3D NULL || str_arr->num_str =3D=3D 0) {
+		ofono_error("%s: parse error for %s", __func__,
+				ril_request_id_to_string(message->req));
+		parcel_free_str_array(str_arr);
+		str_arr =3D NULL;
+		goto out;
+	}
+
+	g_ril_append_print_buf(gril, "{");
+
+	for (i =3D 0; i < str_arr->num_str; ++i) {
+		if (i + 1 =3D=3D str_arr->num_str)
+			g_ril_append_print_buf(gril, "%s%s}", print_buf,
+						str_arr->str[i]);
+		else
+			g_ril_append_print_buf(gril, "%s%s, ", print_buf,
+						str_arr->str[i]);
+	}
+
+	g_ril_print_unsol(gril, message);
+
+out:
+	return str_arr;
+}
diff --git a/drivers/mtkmodem/mtkunsol.h b/drivers/mtkmodem/mtkunsol.h
new file mode 100644
index 0000000..135e57e
--- /dev/null
+++ b/drivers/mtkmodem/mtkunsol.h
@@ -0,0 +1,59 @@
+/*
+ *
+ *  MTK driver for ofono/rilmodem
+ *
+ *  Copyright (C) 2014  Canonical Ltd.
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
+#ifndef MTKUNSOL_H
+#define MTKUNSOL_H
+
+#include <ofono/types.h>
+
+#include "gril.h"
+
+#ifdef __cplusplus
+extern "C" {
+#endif
+
+struct unsol_call_indication {
+	int call_id;
+	int call_mode;
+	int seq_number;
+};
+
+void g_mtk_unsol_free_call_indication(struct unsol_call_indication *unsol);
+
+struct unsol_call_indication *g_mtk_unsol_parse_incoming_call_indication(
+					GRil *gril, struct ril_msg *message);
+
+/* Returns a session id that must be used in resume registration request */
+int g_mtk_unsol_parse_registration_suspended(GRil *gril,
+						const struct ril_msg *message);
+
+/*
+ * Returns a minimum of one PLMN or NULL. parcel_free_str_array must be in=
voked
+ * to free the returned pointer.
+ */
+struct parcel_str_array *g_mtk_unsol_parse_plmn_changed(GRil *gril,
+						const struct ril_msg *message);
+
+#ifdef __cplusplus
+}
+#endif
+
+#endif /* MTKUNSOL_H */
diff --git a/drivers/mtkmodem/mtkutil.c b/drivers/mtkmodem/mtkutil.c
new file mode 100644
index 0000000..9f3f42e
--- /dev/null
+++ b/drivers/mtkmodem/mtkutil.c
@@ -0,0 +1,143 @@
+/*
+ *
+ *  MTK driver for ofono/rilmodem
+ *
+ *  Copyright (C) 2014  Canonical Ltd.
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
+#include <stddef.h>
+
+#include "mtkutil.h"
+#include "mtk_constants.h"
+
+const char *mtk_request_id_to_string(int req)
+{
+	switch (req) {
+	case MTK_RIL_REQUEST_RADIO_POWEROFF:
+		return "MTK_RIL_REQUEST_RADIO_POWEROFF";
+	case MTK_RIL_REQUEST_DUAL_SIM_MODE_SWITCH:
+		return "MTK_RIL_REQUEST_DUAL_SIM_MODE_SWITCH";
+	case MTK_RIL_REQUEST_SET_GPRS_CONNECT_TYPE:
+		return "MTK_RIL_REQUEST_SET_GPRS_CONNECT_TYPE";
+	case MTK_RIL_REQUEST_SET_GPRS_TRANSFER_TYPE:
+		return "MTK_RIL_REQUEST_SET_GPRS_TRANSFER_TYPE";
+	case MTK_RIL_REQUEST_RADIO_POWERON:
+		return "MTK_RIL_REQUEST_RADIO_POWERON";
+	case MTK_RIL_REQUEST_SET_CALL_INDICATION:
+		return "MTK_RIL_REQUEST_SET_CALL_INDICATION";
+	case MTK_RIL_REQUEST_GET_3G_CAPABILITY:
+		return "MTK_RIL_REQUEST_GET_3G_CAPABILITY";
+	case MTK_RIL_REQUEST_SET_3G_CAPABILITY:
+		return "MTK_RIL_REQUEST_SET_3G_CAPABILITY";
+	case MTK_RIL_REQUEST_SET_TRM:
+		return "MTK_RIL_REQUEST_SET_TRM";
+	case MTK_RIL_REQUEST_SET_FD_MODE:
+		return "MTK_RIL_REQUEST_SET_FD_MODE";
+	case MTK_RIL_REQUEST_STORE_MODEM_TYPE:
+		return "MTK_RIL_REQUEST_STORE_MODEM_TYPE";
+	case MTK_RIL_REQUEST_RESUME_REGISTRATION:
+		return "MTK_RIL_REQUEST_RESUME_REGISTRATION";
+	case MTK_RIL_REQUEST_QUERY_MODEM_TYPE:
+		return "MTK_RIL_REQUEST_QUERY_MODEM_TYPE";
+	default:
+		return NULL;
+	}
+}
+
+const char *mtk_unsol_request_to_string(int req)
+{
+	switch (req) {
+	case MTK_RIL_UNSOL_NEIGHBORING_CELL_INFO:
+		return "MTK_RIL_UNSOL_NEIGHBORING_CELL_INFO";
+	case MTK_RIL_UNSOL_NETWORK_INFO:
+		return "MTK_RIL_UNSOL_NETWORK_INFO";
+	case MTK_RIL_UNSOL_CALL_FORWARDING:
+		return "MTK_RIL_UNSOL_CALL_FORWARDING";
+	case MTK_RIL_UNSOL_CRSS_NOTIFICATION:
+		return "MTK_RIL_UNSOL_CRSS_NOTIFICATION";
+	case MTK_RIL_UNSOL_CALL_PROGRESS_INFO:
+		return "MTK_RIL_UNSOL_CALL_PROGRESS_INFO";
+	case MTK_RIL_UNSOL_PHB_READY_NOTIFICATION:
+		return "MTK_RIL_UNSOL_PHB_READY_NOTIFICATION";
+	case MTK_RIL_UNSOL_SPEECH_INFO:
+		return "MTK_RIL_UNSOL_SPEECH_INFO";
+	case MTK_RIL_UNSOL_SIM_INSERTED_STATUS:
+		return "MTK_RIL_UNSOL_SIM_INSERTED_STATUS";
+	case MTK_RIL_UNSOL_RADIO_TEMPORARILY_UNAVAILABLE:
+		return "MTK_RIL_UNSOL_RADIO_TEMPORARILY_UNAVAILABLE";
+	case MTK_RIL_UNSOL_ME_SMS_STORAGE_FULL:
+		return "MTK_RIL_UNSOL_ME_SMS_STORAGE_FULL";
+	case MTK_RIL_UNSOL_SMS_READY_NOTIFICATION:
+		return "MTK_RIL_UNSOL_SMS_READY_NOTIFICATION";
+	case MTK_RIL_UNSOL_SCRI_RESULT:
+		return "MTK_RIL_UNSOL_SCRI_RESULT";
+	case MTK_RIL_UNSOL_VT_STATUS_INFO:
+		return "MTK_RIL_UNSOL_VT_STATUS_INFO";
+	case MTK_RIL_UNSOL_VT_RING_INFO:
+		return "MTK_RIL_UNSOL_VT_RING_INFO";
+	case MTK_RIL_UNSOL_INCOMING_CALL_INDICATION:
+		return "MTK_RIL_UNSOL_INCOMING_CALL_INDICATION";
+	case MTK_RIL_UNSOL_SIM_MISSING:
+		return "MTK_RIL_UNSOL_SIM_MISSING";
+	case MTK_RIL_UNSOL_GPRS_DETACH:
+		return "MTK_RIL_UNSOL_GPRS_DETACH";
+	case MTK_RIL_UNSOL_ATCI_RESPONSE:
+		return "MTK_RIL_UNSOL_ATCI_RESPONSE";
+	case MTK_RIL_UNSOL_SIM_RECOVERY:
+		return "MTK_RIL_UNSOL_SIM_RECOVERY";
+	case MTK_RIL_UNSOL_VIRTUAL_SIM_ON:
+		return "MTK_RIL_UNSOL_VIRTUAL_SIM_ON";
+	case MTK_RIL_UNSOL_VIRTUAL_SIM_OFF:
+		return "MTK_RIL_UNSOL_VIRTUAL_SIM_OFF";
+	case MTK_RIL_UNSOL_INVALID_SIM:
+		return "MTK_RIL_UNSOL_INVALID_SIM";
+	case MTK_RIL_UNSOL_RESPONSE_PS_NETWORK_STATE_CHANGED:
+		return "MTK_RIL_UNSOL_RESPONSE_PS_NETWORK_STATE_CHANGED";
+	case MTK_RIL_UNSOL_RESPONSE_ACMT:
+		return "MTK_RIL_UNSOL_RESPONSE_ACMT";
+	case MTK_RIL_UNSOL_EF_CSP_PLMN_MODE_BIT:
+		return "MTK_RIL_UNSOL_EF_CSP_PLMN_MODE_BIT";
+	case MTK_RIL_UNSOL_IMEI_LOCK:
+		return "MTK_RIL_UNSOL_IMEI_LOCK";
+	case MTK_RIL_UNSOL_RESPONSE_MMRR_STATUS_CHANGED:
+		return "MTK_RIL_UNSOL_RESPONSE_MMRR_STATUS_CHANGED";
+	case MTK_RIL_UNSOL_SIM_PLUG_OUT:
+		return "MTK_RIL_UNSOL_SIM_PLUG_OUT";
+	case MTK_RIL_UNSOL_SIM_PLUG_IN:
+		return "MTK_RIL_UNSOL_SIM_PLUG_IN";
+	case MTK_RIL_UNSOL_RESPONSE_ETWS_NOTIFICATION:
+		return "MTK_RIL_UNSOL_RESPONSE_ETWS_NOTIFICATION";
+	case MTK_RIL_UNSOL_RESPONSE_PLMN_CHANGED:
+		return "MTK_RIL_UNSOL_RESPONSE_PLMN_CHANGED";
+	case MTK_RIL_UNSOL_RESPONSE_REGISTRATION_SUSPENDED:
+		return "MTK_RIL_UNSOL_RESPONSE_REGISTRATION_SUSPENDED";
+	case MTK_RIL_UNSOL_STK_EVDL_CALL:
+		return "MTK_RIL_UNSOL_STK_EVDL_CALL";
+	case MTK_RIL_UNSOL_DATA_PACKETS_FLUSH:
+		return "MTK_RIL_UNSOL_DATA_PACKETS_FLUSH";
+	case MTK_RIL_UNSOL_CIPHER_INDICATION:
+		return "MTK_RIL_UNSOL_CIPHER_INDICATION";
+	case MTK_RIL_UNSOL_FEMTOCELL_INFO:
+		return "MTK_RIL_UNSOL_FEMTOCELL_INFO";
+	case MTK_RIL_UNSOL_CNAP:
+		return "MTK_RIL_UNSOL_CNAP";
+	case MTK_RIL_UNSOL_RAC_UPDATE:
+		return "MTK_RIL_UNSOL_RAC_UPDATE";
+	default:
+		return NULL;
+	}
+}
diff --git a/drivers/mtkmodem/mtkutil.h b/drivers/mtkmodem/mtkutil.h
new file mode 100644
index 0000000..b7e6a2a
--- /dev/null
+++ b/drivers/mtkmodem/mtkutil.h
@@ -0,0 +1,47 @@
+/*
+ *
+ *  MTK driver for ofono/rilmodem
+ *
+ *  Copyright (C) 2014  Canonical Ltd.
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
+#ifndef MTKUTIL_H
+#define MTKUTIL_H
+
+#include <ofono/types.h>
+#include <gril.h>
+
+#ifdef __cplusplus
+extern "C" {
+#endif
+
+struct ofono_modem;
+
+void mtk_set_attach_state(struct ofono_modem *modem, ofono_bool_t attached=
);
+void mtk_detach_received(struct ofono_modem *modem);
+
+void mtk_reset_all_modems(void);
+void mtk_reset_modem(struct ofono_modem *modem);
+
+const char *mtk_request_id_to_string(int req);
+const char *mtk_unsol_request_to_string(int req);
+
+#ifdef __cplusplus
+}
+#endif
+
+#endif /* MTKUTIL_H */
diff --git a/drivers/mtkmodem/radio-settings.c b/drivers/mtkmodem/radio-set=
tings.c
new file mode 100644
index 0000000..8f46b0d
--- /dev/null
+++ b/drivers/mtkmodem/radio-settings.c
@@ -0,0 +1,193 @@
+/*
+ *
+ *  oFono - Open Source Telephony
+ *
+ *  Copyright (C) 2014  Canonical Ltd.
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
+#include <ofono/radio-settings.h>
+
+#include "mtk_constants.h"
+#include "mtkunsol.h"
+#include "mtkreply.h"
+#include "mtkrequest.h"
+
+#include "common.h"
+#include "mtkmodem.h"
+#include "drivers/rilmodem/radio-settings.h"
+#include "drivers/rilmodem/rilutil.h"
+
+/*
+ * This is the radio settings atom implementation for mtkmodem. Most of the
+ * implementation can be found in the rilmodem atom. The main reason for
+ * creating a new atom is the need to handle specific MTK requests.
+ */
+
+struct set_fd_mode {
+	struct ofono_radio_settings *rst;
+	gboolean on;
+};
+
+static void mtk_set_fd_mode_cb(struct ril_msg *message, gpointer user_data)
+{
+	struct cb_data *cbd =3D user_data;
+	struct set_fd_mode *user =3D cbd->user;
+	struct ofono_radio_settings *rs =3D user->rst;
+	struct radio_data *rsd =3D ofono_radio_settings_get_data(rs);
+	ofono_radio_settings_fast_dormancy_set_cb_t cb =3D cbd->cb;
+
+	if (message->error =3D=3D RIL_E_SUCCESS ||
+			message->error =3D=3D RIL_E_RADIO_NOT_AVAILABLE) {
+
+		if (message->error =3D=3D RIL_E_RADIO_NOT_AVAILABLE)
+			ofono_warn("Could not set fast dormancy "
+					"as radio is not available");
+
+		g_ril_print_response_no_args(rsd->ril, message);
+		ril_set_fast_dormancy(rs, user->on, cb, cbd->data);
+	} else {
+		CALLBACK_WITH_FAILURE(cb, cbd->data);
+	}
+
+	g_free(user);
+}
+
+static void mtk_set_fast_dormancy(struct ofono_radio_settings *rs,
+				ofono_bool_t enable,
+				ofono_radio_settings_fast_dormancy_set_cb_t cb,
+				void *data)
+{
+	struct radio_data *rsd =3D ofono_radio_settings_get_data(rs);
+	struct set_fd_mode *user =3D g_malloc0(sizeof(*user));
+	struct cb_data *cbd;
+	struct parcel rilp;
+
+	user->rst =3D rs;
+	user->on =3D enable;
+
+	cbd =3D cb_data_new(cb, data, user);
+
+	g_mtk_request_set_fd_mode(rsd->ril, MTK_FD_MODE_SCREEN_STATUS,
+					enable ? FALSE : TRUE, 0, &rilp);
+
+	if (g_ril_send(rsd->ril, MTK_RIL_REQUEST_SET_FD_MODE, &rilp,
+			mtk_set_fd_mode_cb, cbd, g_free) <=3D 0) {
+		g_free(cbd);
+		g_free(user);
+		CALLBACK_WITH_FAILURE(cb, data);
+	}
+}
+
+static int mtk_radio_settings_probe(struct ofono_radio_settings *rs,
+					unsigned int vendor, void *user)
+{
+	GRil *ril =3D user;
+	struct radio_data *rsd =3D g_new0(struct radio_data, 1);
+
+	rsd->ril =3D g_ril_clone(ril);
+
+	ofono_radio_settings_set_data(rs, rsd);
+
+	mtk_set_fast_dormancy(rs, FALSE, ril_delayed_register, rs);
+
+	return 0;
+}
+
+static void mtk_query_available_rats_cb(struct ril_msg *message,
+					gpointer user_data)
+{
+	struct cb_data *cbd =3D user_data;
+	struct ofono_radio_settings *rs =3D cbd->user;
+	struct radio_data *rd =3D ofono_radio_settings_get_data(rs);
+	ofono_radio_settings_available_rats_query_cb_t cb =3D cbd->cb;
+	unsigned int available_rats =3D OFONO_RADIO_ACCESS_MODE_GSM;
+	int slot_3g, is_3g;
+
+	if (message->error !=3D RIL_E_SUCCESS) {
+		ofono_error("%s: error %s", __func__,
+				ril_error_to_string(message->error));
+		CALLBACK_WITH_FAILURE(cb, 0, cbd->data);
+		return;
+	}
+
+	slot_3g =3D g_mtk_reply_parse_get_3g_capability(rd->ril, message);
+	if (slot_3g < 0) {
+		ofono_error("%s: parse error", __func__);
+		CALLBACK_WITH_FAILURE(cb, 0, cbd->data);
+		return;
+	}
+
+	is_3g =3D (g_ril_get_slot(rd->ril) =3D=3D slot_3g);
+
+	if (is_3g) {
+		struct ofono_modem *modem =3D ofono_radio_settings_get_modem(rs);
+		available_rats |=3D OFONO_RADIO_ACCESS_MODE_UMTS;
+
+		if (ofono_modem_get_boolean(modem, MODEM_PROP_LTE_CAPABLE))
+			available_rats |=3D OFONO_RADIO_ACCESS_MODE_LTE;
+	}
+
+	CALLBACK_WITH_SUCCESS(cb, available_rats, cbd->data);
+}
+
+static void mtk_query_available_rats(struct ofono_radio_settings *rs,
+			ofono_radio_settings_available_rats_query_cb_t cb,
+			void *data)
+{
+	struct radio_data *rd =3D ofono_radio_settings_get_data(rs);
+	struct cb_data *cbd =3D cb_data_new(cb, data, rs);
+
+	if (g_ril_send(rd->ril, MTK_RIL_REQUEST_GET_3G_CAPABILITY, NULL,
+			mtk_query_available_rats_cb, cbd, g_free) <=3D 0) {
+		g_free(cbd);
+		CALLBACK_WITH_FAILURE(cb, 0, data);
+	}
+}
+
+static struct ofono_radio_settings_driver driver =3D {
+	.name			=3D MTKMODEM,
+	.probe			=3D mtk_radio_settings_probe,
+	.remove			=3D ril_radio_settings_remove,
+	.query_rat_mode		=3D ril_query_rat_mode,
+	.set_rat_mode		=3D ril_set_rat_mode,
+	.query_fast_dormancy	=3D ril_query_fast_dormancy,
+	.set_fast_dormancy	=3D mtk_set_fast_dormancy,
+	.query_available_rats	=3D mtk_query_available_rats
+};
+
+void mtk_radio_settings_init(void)
+{
+	ofono_radio_settings_driver_register(&driver);
+}
+
+void mtk_radio_settings_exit(void)
+{
+	ofono_radio_settings_driver_unregister(&driver);
+}
diff --git a/drivers/mtkmodem/voicecall.c b/drivers/mtkmodem/voicecall.c
new file mode 100644
index 0000000..bfb3c9d
--- /dev/null
+++ b/drivers/mtkmodem/voicecall.c
@@ -0,0 +1,155 @@
+/*
+ *
+ *  oFono - Open Source Telephony
+ *
+ *  Copyright (C) 2008-2011  Intel Corporation. All rights reserved.
+ *  Copyright (C) 2012-2014  Canonical Ltd.
+ *  Copyright (C) 2013 Jolla Ltd.
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
+#include "mtk_constants.h"
+#include "mtkunsol.h"
+#include "mtkrequest.h"
+
+#include "common.h"
+#include "mtkmodem.h"
+#include "drivers/rilmodem/rilutil.h"
+#include "drivers/rilmodem/voicecall.h"
+
+/*
+ * This is the voicecall atom implementation for mtkmodem. Most of the
+ * implementation can be found in the rilmodem atom. The main reason for
+ * creating a new atom is the need to handle specific MTK requests and
+ * unsolicited events.
+ */
+
+static void mtk_set_indication_cb(struct ril_msg *message, gpointer user_d=
ata)
+{
+	struct ofono_voicecall *vc =3D user_data;
+	struct ril_voicecall_data *vd =3D ofono_voicecall_get_data(vc);
+
+	if (message->error =3D=3D RIL_E_SUCCESS)
+		g_ril_print_response_no_args(vd->ril, message);
+	else
+		ofono_error("%s: RIL error %s", __func__,
+				ril_error_to_string(message->error));
+}
+
+static void mtk_incoming_notify(struct ril_msg *message, gpointer user_dat=
a)
+{
+	struct ofono_voicecall *vc =3D user_data;
+	struct ril_voicecall_data *vd =3D ofono_voicecall_get_data(vc);
+	struct parcel rilp;
+	struct unsol_call_indication *call_ind;
+
+	call_ind =3D g_mtk_unsol_parse_incoming_call_indication(vd->ril, message);
+	if (call_ind =3D=3D NULL) {
+		ofono_error("%s: error parsing event", __func__);
+		return;
+	}
+
+	g_mtk_request_set_call_indication(vd->ril, MTK_CALL_INDIC_MODE_AVAIL,
+						call_ind->call_id,
+						call_ind->seq_number, &rilp);
+
+	if (g_ril_send(vd->ril, MTK_RIL_REQUEST_SET_CALL_INDICATION,
+			&rilp, mtk_set_indication_cb, vc, NULL) =3D=3D 0)
+		ofono_error("%s: cannot send indication", __func__);
+
+	g_mtk_unsol_free_call_indication(call_ind);
+}
+
+static gboolean mtk_delayed_register(gpointer user_data)
+{
+	struct ofono_voicecall *vc =3D user_data;
+	struct ril_voicecall_data *vd =3D ofono_voicecall_get_data(vc);
+
+	/* MTK generates this event instead of CALL_STATE_CHANGED */
+	g_ril_register(vd->ril, MTK_RIL_UNSOL_CALL_PROGRESS_INFO,
+			ril_call_state_notify, vc);
+
+	/* Indicates incoming call, before telling the network our state */
+	g_ril_register(vd->ril, MTK_RIL_UNSOL_INCOMING_CALL_INDICATION,
+			mtk_incoming_notify, vc);
+
+	/* This makes the timeout a single-shot */
+	return FALSE;
+}
+
+static int mtk_voicecall_probe(struct ofono_voicecall *vc, unsigned int ve=
ndor,
+				void *data)
+{
+	GRil *ril =3D data;
+	struct ril_voicecall_data *vd;
+
+	vd =3D g_try_new0(struct ril_voicecall_data, 1);
+	if (vd =3D=3D NULL)
+		return -ENOMEM;
+
+	ril_voicecall_start(ril, vc, vendor, vd);
+
+	/*
+	 * Register events after ofono_voicecall_register() is called from
+	 * ril_delayed_register().
+	 */
+	g_idle_add(mtk_delayed_register, vc);
+
+	return 0;
+}
+
+static struct ofono_voicecall_driver driver =3D {
+	.name			=3D MTKMODEM,
+	.probe			=3D mtk_voicecall_probe,
+	.remove			=3D ril_voicecall_remove,
+	.dial			=3D ril_dial,
+	.answer			=3D ril_answer,
+	.hangup_all		=3D ril_hangup_all,
+	.release_specific	=3D ril_hangup_specific,
+	.send_tones		=3D ril_send_dtmf,
+	.create_multiparty	=3D ril_create_multiparty,
+	.private_chat		=3D ril_private_chat,
+	.swap_without_accept	=3D ril_swap_without_accept,
+	.hold_all_active	=3D ril_hold_all_active,
+	.release_all_held	=3D ril_release_all_held,
+	.set_udub		=3D ril_set_udub,
+	.release_all_active	=3D ril_release_all_active,
+};
+
+void mtk_voicecall_init(void)
+{
+	ofono_voicecall_driver_register(&driver);
+}
+
+void mtk_voicecall_exit(void)
+{
+	ofono_voicecall_driver_unregister(&driver);
+}
-- =

2.5.0


--===============0276084865266089354==--

