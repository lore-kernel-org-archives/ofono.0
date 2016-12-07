Content-Type: multipart/mixed; boundary="===============4311867100670298192=="
MIME-Version: 1.0
From: Ankit Navik <ankit.p.navik@intel.com>
Subject: [PATCH 1/2] rilmodem: Add lte atom driver
Date: Wed, 07 Dec 2016 08:40:37 +0530
Message-ID: <1481080237-21112-1-git-send-email-ankit.p.navik@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4311867100670298192==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Adds rilmodem driver for setting the default APN command.
The default APN is manage by config storage.
---
 Makefile.am                 |   3 +-
 drivers/rilmodem/lte.c      | 158 ++++++++++++++++++++++++++++++++++++++++=
++++
 drivers/rilmodem/rilmodem.c |   2 +
 drivers/rilmodem/rilmodem.h |   3 +
 4 files changed, 165 insertions(+), 1 deletion(-)
 create mode 100644 drivers/rilmodem/lte.c

diff --git a/Makefile.am b/Makefile.am
index 07adeab..0f25f1f 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -153,7 +153,8 @@ builtin_sources +=3D drivers/rilmodem/rilmodem.h \
 			drivers/rilmodem/netmon.c \
 			drivers/rilmodem/stk.c \
 			drivers/rilmodem/cbs.c \
-			drivers/infineonmodem/infineon_constants.h
+			drivers/infineonmodem/infineon_constants.h \
+			drivers/rilmodem/lte.c
 endif
 =

 if ISIMODEM
diff --git a/drivers/rilmodem/lte.c b/drivers/rilmodem/lte.c
new file mode 100644
index 0000000..d196be8
--- /dev/null
+++ b/drivers/rilmodem/lte.c
@@ -0,0 +1,158 @@
+/*
+ *
+ *  oFono - Open Source Telephony
+ *
+ *  Copyright (C) 2016  Intel Corporation. All rights reserved.
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
+#include <ofono/modem.h>
+#include <ofono/gprs-context.h>
+#include <ofono/log.h>
+#include <ofono/lte.h>
+
+#include <gril/gril.h>
+#include <gril/grilutil.h>
+
+#include "rilmodem.h"
+
+struct ril_lte_data {
+	GRil *ril;
+};
+
+static void ril_lte_set_default_attach_info_cb(struct ril_msg *message,
+							gpointer user_data)
+{
+	struct cb_data *cbd =3D user_data;
+	ofono_lte_cb_t cb =3D cbd->cb;
+	struct ofono_lte *lte =3D cbd->user;
+	struct ril_lte_data *ld =3D ofono_lte_get_data(lte);
+	DBG("");
+
+	if (message->error =3D=3D RIL_E_SUCCESS) {
+		g_ril_print_response_no_args(ld->ril, message);
+		CALLBACK_WITH_SUCCESS(cb, cbd->data);
+	} else {
+		ofono_error("%s: RIL error %s", __func__,
+				ril_error_to_string(message->error));
+		CALLBACK_WITH_FAILURE(cb, cbd->data);
+	}
+}
+
+static void ril_lte_set_default_attach_info(const struct ofono_lte *lte,
+			const struct ofono_lte_default_attach_info *info,
+			ofono_lte_cb_t cb, void *data)
+{
+	struct ril_lte_data *ld =3D ofono_lte_get_data(lte);
+	struct cb_data *cbd =3D cb_data_new(cb, data, (struct ofono_lte *)lte);
+	struct parcel rilp;
+	char buf[OFONO_GPRS_MAX_APN_LENGTH + 1];
+
+	DBG("%s", info->apn);
+
+	parcel_init(&rilp);
+	parcel_w_int32(&rilp, 5);
+
+	if (strlen(info->apn) > 0) {
+		sprintf(buf, "%s", info->apn);
+		parcel_w_string(&rilp, buf);
+	} else
+		parcel_w_string(&rilp, "");	/* apn */
+
+	parcel_w_string(&rilp, "ip");		/* protocol */
+	parcel_w_int32(&rilp, 0);		/* auth type */
+	parcel_w_string(&rilp, "");		/* username */
+	parcel_w_string(&rilp, "");		/* password */
+
+	if (g_ril_send(ld->ril, RIL_REQUEST_SET_INITIAL_ATTACH_APN, &rilp,
+			ril_lte_set_default_attach_info_cb, cbd, g_free) > 0)
+		return;
+
+	g_free(cbd);
+	CALLBACK_WITH_FAILURE(cb, data);
+}
+
+static gboolean lte_delayed_register(gpointer user_data)
+{
+	struct ofono_lte *lte =3D user_data;
+
+	DBG("");
+
+	ofono_lte_register(lte);
+
+	return FALSE;
+}
+
+static int ril_lte_probe(struct ofono_lte *lte, void *user_data)
+{
+	GRil *ril =3D user_data;
+	struct ril_lte_data *ld;
+
+	DBG("");
+
+	ld =3D g_try_new0(struct ril_lte_data, 1);
+	if (ld =3D=3D NULL)
+		return -ENOMEM;
+
+	ld->ril =3D g_ril_clone(ril);
+
+	ofono_lte_set_data(lte, ld);
+
+	g_idle_add(lte_delayed_register, lte);
+
+	return 0;
+}
+
+static void ril_lte_remove(struct ofono_lte *lte)
+{
+	struct ril_lte_data *ld =3D ofono_lte_get_data(lte);
+
+	DBG("");
+
+	ofono_lte_set_data(lte, NULL);
+
+	g_ril_unref(ld->ril);
+	g_free(ld);
+}
+
+static struct ofono_lte_driver driver =3D {
+	.name				=3D RILMODEM,
+	.probe				=3D ril_lte_probe,
+	.remove				=3D ril_lte_remove,
+	.set_default_attach_info	=3D ril_lte_set_default_attach_info,
+};
+
+void ril_lte_init(void)
+{
+	ofono_lte_driver_register(&driver);
+}
+
+void ril_lte_exit(void)
+{
+	ofono_lte_driver_unregister(&driver);
+}
diff --git a/drivers/rilmodem/rilmodem.c b/drivers/rilmodem/rilmodem.c
index ace1621..be1d0ed 100644
--- a/drivers/rilmodem/rilmodem.c
+++ b/drivers/rilmodem/rilmodem.c
@@ -54,6 +54,7 @@ static int rilmodem_init(void)
 	ril_netmon_init();
 	ril_stk_init();
 	ril_cbs_init();
+	ril_lte_init();
 =

 	return 0;
 }
@@ -78,6 +79,7 @@ static void rilmodem_exit(void)
 	ril_netmon_exit();
 	ril_stk_exit();
 	ril_cbs_exit();
+	ril_lte_exit();
 }
 =

 OFONO_PLUGIN_DEFINE(rilmodem, "RIL modem driver", VERSION,
diff --git a/drivers/rilmodem/rilmodem.h b/drivers/rilmodem/rilmodem.h
index cde955e..dd63365 100644
--- a/drivers/rilmodem/rilmodem.h
+++ b/drivers/rilmodem/rilmodem.h
@@ -78,3 +78,6 @@ extern void ril_stk_exit(void);
 =

 extern void ril_cbs_init(void);
 extern void ril_cbs_exit(void);
+
+extern void ril_lte_init(void);
+extern void ril_lte_exit(void);
-- =

1.9.1


--===============4311867100670298192==--

