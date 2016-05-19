Content-Type: multipart/mixed; boundary="===============4820022943179442492=="
MIME-Version: 1.0
From: caiwen.zhang@intel.com
Subject: [PATCH] rilmodem: add cell broadcast message support
Date: Thu, 19 May 2016 11:02:18 +0800
Message-ID: <1463626938-8441-1-git-send-email-caiwen.zhang@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4820022943179442492==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Caiwen Zhang <caiwen.zhang@intel.com>

---
 Makefile.am                 |   1 +
 drivers/rilmodem/cbs.c      | 213 ++++++++++++++++++++++++++++++++++++++++=
++++
 drivers/rilmodem/rilmodem.c |   2 +
 drivers/rilmodem/rilmodem.h |   3 +
 4 files changed, 219 insertions(+)
 create mode 100644 drivers/rilmodem/cbs.c

diff --git a/Makefile.am b/Makefile.am
index 8ab9851..7838d2b 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -152,6 +152,7 @@ builtin_sources +=3D drivers/rilmodem/rilmodem.h \
 			drivers/rilmodem/call-barring.c \
 			drivers/rilmodem/netmon.c \
 			drivers/rilmodem/stk.c \
+			drivers/rilmodem/cbs.c \
 			drivers/infineonmodem/infineon_constants.h
 endif
 =

diff --git a/drivers/rilmodem/cbs.c b/drivers/rilmodem/cbs.c
new file mode 100644
index 0000000..6050f77
--- /dev/null
+++ b/drivers/rilmodem/cbs.c
@@ -0,0 +1,213 @@
+/*
+ *
+ *  oFono - Open Source Telephony
+ *
+ *  Copyright (C) 2008-2016  Intel Corporation. All rights reserved.
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
+#include <stdio.h>
+#include <ctype.h>
+
+#include <glib.h>
+
+#include <ofono/log.h>
+#include <ofono/modem.h>
+#include <ofono/cbs.h>
+#include "util.h"
+
+#include <gril.h>
+#include <parcel.h>
+
+#include "rilmodem.h"
+#include "vendor.h"
+
+struct cbs_data {
+	GRil *ril;
+	unsigned int vendor;
+};
+
+static void ril_cbs_set_cb(struct ril_msg *message, gpointer user_data)
+{
+	struct cb_data *cbd =3D user_data;
+	ofono_cbs_set_cb_t cb =3D cbd->cb;
+	struct cbs_data *cd =3D cbd->user;
+
+	if (message->error =3D=3D RIL_E_SUCCESS) {
+		CALLBACK_WITH_SUCCESS(cb, cbd->data);
+	} else {
+		ofono_error("%s RILD reply failure: %s",
+			g_ril_request_id_to_string(cd->ril, message->req),
+			ril_error_to_string(message->error));
+		CALLBACK_WITH_FAILURE(cb, cbd->data);
+	}
+}
+
+static void ril_cbs_set_topics(struct ofono_cbs *cbs, const char *topics,
+					ofono_cbs_set_cb_t cb, void *user_data)
+{
+	struct cbs_data *cd =3D ofono_cbs_get_data(cbs);
+	struct cb_data *cbd =3D cb_data_new(cb, user_data, cd);
+	int i =3D 0, from, to;
+	const char *p, *pto;
+	char **segments;
+	struct parcel rilp;
+
+	segments =3D g_strsplit(topics, ",", 0);
+
+	while (segments[i])
+		i++;
+
+	parcel_init(&rilp);
+	parcel_w_int32(&rilp, i);
+
+	i =3D 0;
+	while (segments[i]) {
+		p =3D segments[i++];
+		from =3D atoi(p);
+		to =3D from;
+
+		pto =3D strchr(p, '-');
+		if (pto)
+			to =3D atoi(pto + 1);
+
+		parcel_w_int32(&rilp, from);
+		parcel_w_int32(&rilp, to);
+
+		parcel_w_int32(&rilp, 0);
+		parcel_w_int32(&rilp, 0xFF);
+
+		parcel_w_int32(&rilp, 1);
+	}
+
+	g_strfreev(segments);
+
+	if (g_ril_send(cd->ril, RIL_REQUEST_GSM_SET_BROADCAST_SMS_CONFIG, &rilp,
+			ril_cbs_set_cb, cbd, g_free) > 0)
+		return;
+
+	g_free(cbd);
+	CALLBACK_WITH_FAILURE(cb, user_data);
+}
+
+static void ril_cbs_clear_topics(struct ofono_cbs *cbs,
+					ofono_cbs_set_cb_t cb, void *user_data)
+{
+	ril_cbs_set_topics(cbs, "", cb, user_data);
+}
+
+static void ril_cbs_received(struct ril_msg *message, gpointer user_data)
+{
+	struct ofono_cbs *cbs =3D user_data;
+	struct cbs_data *cd =3D ofono_cbs_get_data(cbs);
+	struct parcel rilp;
+	int pdulen;
+	unsigned char *pdu;
+
+	g_ril_print_unsol_no_args(cd->ril, message);
+
+	DBG("req: %d; data_len: %d", message->req, (int) message->buf_len);
+
+	g_ril_init_parcel(message, &rilp);
+	pdu =3D parcel_r_raw(&rilp, &pdulen);
+
+	if (!pdu || pdulen !=3D 88) {
+		ofono_error("%s: it isn't a gsm cell broadcast msg", __func__);
+		return;
+	}
+
+	ofono_cbs_notify(cbs, pdu, pdulen);
+	g_free(pdu);
+}
+
+static void ril_cbs_register(const struct ofono_error *error, void *data)
+{
+	struct ofono_cbs *cbs =3D data;
+	struct cbs_data *cd =3D ofono_cbs_get_data(cbs);
+
+	g_ril_register(cd->ril, RIL_UNSOL_RESPONSE_NEW_BROADCAST_SMS,
+					ril_cbs_received, cbs);
+
+	ofono_cbs_register(cbs);
+}
+
+static void get_cbs_config_cb(struct ril_msg *message,
+					gpointer user_data)
+{
+	struct ofono_cbs *cbs =3D user_data;
+
+	if (message->error !=3D RIL_E_SUCCESS) {
+		ofono_error("%s: RIL error %s", __func__,
+				ril_error_to_string(message->error));
+		ofono_cbs_remove(cbs);
+		return;
+	}
+
+	ril_cbs_clear_topics(cbs, ril_cbs_register, cbs);
+}
+
+static int ril_cbs_probe(struct ofono_cbs *cbs, unsigned int vendor,
+				void *user)
+{
+	GRil *ril =3D user;
+	struct cbs_data *data;
+
+	data =3D g_new0(struct cbs_data, 1);
+	data->ril =3D g_ril_clone(ril);
+	data->vendor =3D vendor;
+
+	ofono_cbs_set_data(cbs, data);
+
+	if (g_ril_send(ril, RIL_REQUEST_GSM_GET_BROADCAST_SMS_CONFIG, NULL,
+			get_cbs_config_cb, cbs, NULL) =3D=3D 0)
+		ofono_error("%s: send failed", __func__);
+
+	return 0;
+}
+
+static void ril_cbs_remove(struct ofono_cbs *cbs)
+{
+	struct cbs_data *data =3D ofono_cbs_get_data(cbs);
+
+	ofono_cbs_set_data(cbs, NULL);
+
+	g_ril_unref(data->ril);
+	g_free(data);
+}
+
+static struct ofono_cbs_driver driver =3D {
+	.name =3D RILMODEM,
+	.probe =3D ril_cbs_probe,
+	.remove =3D ril_cbs_remove,
+	.set_topics =3D ril_cbs_set_topics,
+	.clear_topics =3D ril_cbs_clear_topics,
+};
+
+void ril_cbs_init(void)
+{
+	ofono_cbs_driver_register(&driver);
+}
+
+void ril_cbs_exit(void)
+{
+	ofono_cbs_driver_unregister(&driver);
+}
diff --git a/drivers/rilmodem/rilmodem.c b/drivers/rilmodem/rilmodem.c
index 9a063a2..ace1621 100644
--- a/drivers/rilmodem/rilmodem.c
+++ b/drivers/rilmodem/rilmodem.c
@@ -53,6 +53,7 @@ static int rilmodem_init(void)
 	ril_call_barring_init();
 	ril_netmon_init();
 	ril_stk_init();
+	ril_cbs_init();
 =

 	return 0;
 }
@@ -76,6 +77,7 @@ static void rilmodem_exit(void)
 	ril_call_barring_exit();
 	ril_netmon_exit();
 	ril_stk_exit();
+	ril_cbs_exit();
 }
 =

 OFONO_PLUGIN_DEFINE(rilmodem, "RIL modem driver", VERSION,
diff --git a/drivers/rilmodem/rilmodem.h b/drivers/rilmodem/rilmodem.h
index 7e47573..cde955e 100644
--- a/drivers/rilmodem/rilmodem.h
+++ b/drivers/rilmodem/rilmodem.h
@@ -75,3 +75,6 @@ extern void ril_netmon_exit(void);
 =

 extern void ril_stk_init(void);
 extern void ril_stk_exit(void);
+
+extern void ril_cbs_init(void);
+extern void ril_cbs_exit(void);
-- =

2.7.4


--===============4820022943179442492==--

