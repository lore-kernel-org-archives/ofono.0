Content-Type: multipart/mixed; boundary="===============8817342220727732683=="
MIME-Version: 1.0
From: Jonas Bonn <jonas@norrbonn.se>
Subject: [PATCH 1/2] ublox: network-registration atom
Date: Fri, 19 Jul 2019 08:51:01 +0200
Message-ID: <20190719065102.32314-1-jonas@norrbonn.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8817342220727732683==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

For uBlox modems, a bit of custom setup is required, but after that the
generic "atmodem" (27.007-compatible) method implementations are
sufficient.  This driver, therefore, just puts the custom probe method
into place and defers remaining functionality to the recently exported
atmodem implementations.
---
 Makefile.am                               |   1 +
 drivers/ubloxmodem/network-registration.c | 426 ++++++++++++++++++++++
 drivers/ubloxmodem/ubloxmodem.c           |   2 +
 drivers/ubloxmodem/ubloxmodem.h           |   3 +
 4 files changed, 432 insertions(+)
 create mode 100644 drivers/ubloxmodem/network-registration.c

diff --git a/Makefile.am b/Makefile.am
index 39777abc..7fb45d35 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -471,6 +471,7 @@ builtin_sources +=3D drivers/atmodem/atutil.h \
 			drivers/ubloxmodem/ubloxmodem.h \
 			drivers/ubloxmodem/ubloxmodem.c \
 			drivers/ubloxmodem/gprs-context.c \
+			drivers/ubloxmodem/network-registration.c \
 			drivers/ubloxmodem/netmon.c \
 			drivers/ubloxmodem/lte.c
 =

diff --git a/drivers/ubloxmodem/network-registration.c b/drivers/ubloxmodem=
/network-registration.c
new file mode 100644
index 00000000..968f83d4
--- /dev/null
+++ b/drivers/ubloxmodem/network-registration.c
@@ -0,0 +1,426 @@
+/*
+ *
+ *  oFono - Open Source Telephony
+ *
+ *  Copyright (C) 2008-2011  Intel Corporation. All rights reserved.
+ *  Copyright (C) 2010  ST-Ericsson AB.
+ *  Copyright (C) 2019  Norrbonn AB
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
+#include <string.h>
+#include <stdlib.h>
+#include <stdio.h>
+
+#include <glib.h>
+
+#include <ofono/log.h>
+#include <ofono/modem.h>
+#include <ofono/netreg.h>
+
+#include "gatchat.h"
+#include "gatresult.h"
+
+#include "common.h"
+#include "ubloxmodem.h"
+#include "drivers/atmodem/vendor.h"
+
+#include "drivers/atmodem/network-registration.h"
+
+static const char *none_prefix[] =3D { NULL };
+static const char *cmer_prefix[] =3D { "+CMER:", NULL };
+static const char *ureg_prefix[] =3D { "+UREG:", NULL };
+
+struct netreg_data {
+	struct at_netreg_data at_data;
+
+	const struct ublox_model *model;
+};
+
+struct tech_query {
+	int status;
+	int lac;
+	int ci;
+	struct ofono_netreg *netreg;
+};
+
+static void ciev_notify(GAtResult *result, gpointer user_data)
+{
+	struct ofono_netreg *netreg =3D user_data;
+	struct at_netreg_data *nd =3D ofono_netreg_get_data(netreg);
+	int strength, ind;
+	GAtResultIter iter;
+
+	g_at_result_iter_init(&iter, result);
+
+	if (!g_at_result_iter_next(&iter, "+CIEV:"))
+		return;
+
+	if (!g_at_result_iter_next_number(&iter, &ind))
+		return;
+
+	if (ind !=3D nd->signal_index)
+		return;
+
+	if (!g_at_result_iter_next_number(&iter, &strength))
+		return;
+
+	if (strength =3D=3D nd->signal_invalid)
+		strength =3D -1;
+	else
+		strength =3D (strength * 100) / (nd->signal_max - nd->signal_min);
+
+	ofono_netreg_strength_notify(netreg, strength);
+}
+
+static gboolean notify_time(gpointer user_data)
+{
+	struct ofono_netreg *netreg =3D user_data;
+	struct at_netreg_data *nd =3D ofono_netreg_get_data(netreg);
+
+	nd->nitz_timeout =3D 0;
+
+	ofono_netreg_time_notify(netreg, &nd->time);
+
+	return FALSE;
+}
+
+static void ctzdst_notify(GAtResult *result, gpointer user_data)
+{
+	struct ofono_netreg *netreg =3D user_data;
+	struct at_netreg_data *nd =3D ofono_netreg_get_data(netreg);
+	int dst;
+	GAtResultIter iter;
+
+	g_at_result_iter_init(&iter, result);
+
+	if (!g_at_result_iter_next(&iter, "+CTZDST:"))
+		return;
+
+	if (!g_at_result_iter_next_number(&iter, &dst))
+		return;
+
+	DBG("dst %d", dst);
+
+	nd->time.dst =3D dst;
+
+	if (nd->nitz_timeout > 0) {
+		g_source_remove(nd->nitz_timeout);
+		nd->nitz_timeout =3D 0;
+	}
+
+	ofono_netreg_time_notify(netreg, &nd->time);
+}
+
+static void ctzv_notify(GAtResult *result, gpointer user_data)
+{
+	struct ofono_netreg *netreg =3D user_data;
+	struct at_netreg_data *nd =3D ofono_netreg_get_data(netreg);
+	int year, mon, mday, hour, min, sec;
+	const char *tz, *time;
+	GAtResultIter iter;
+
+	g_at_result_iter_init(&iter, result);
+
+	if (!g_at_result_iter_next(&iter, "+CTZV:"))
+		return;
+
+	if (!g_at_result_iter_next_unquoted_string(&iter, &tz))
+		return;
+
+	if (!g_at_result_iter_next_string(&iter, &time))
+		return;
+
+	DBG("tz %s time %s", tz, time);
+
+	if (sscanf(time, "%u/%u/%u,%u:%u:%u", &year, &mon, &mday,
+						&hour, &min, &sec) !=3D 6)
+		return;
+
+	nd->time.sec =3D sec;
+	nd->time.min =3D min;
+	nd->time.hour =3D hour;
+	nd->time.mday =3D mday;
+	nd->time.mon =3D mon;
+	nd->time.year =3D 2000 + year;
+
+	nd->time.utcoff =3D atoi(tz) * 15 * 60;
+
+	/* Delay notification in case there's a DST update coming */
+	if (nd->nitz_timeout > 0)
+		g_source_remove(nd->nitz_timeout);
+
+	nd->nitz_timeout =3D g_timeout_add_seconds(1, notify_time, user_data);
+}
+
+static void ctze_notify(GAtResult *result, gpointer user_data)
+{
+	struct ofono_netreg *netreg =3D user_data;
+	struct at_netreg_data *nd =3D ofono_netreg_get_data(netreg);
+	int year, mon, mday, hour, min, sec;
+	int dst;
+	const char *tz, *time;
+	GAtResultIter iter;
+
+	g_at_result_iter_init(&iter, result);
+
+	if (!g_at_result_iter_next(&iter, "+CTZE:"))
+		return;
+
+	if (!g_at_result_iter_next_unquoted_string(&iter, &tz))
+		return;
+
+	if (!g_at_result_iter_next_number(&iter, &dst))
+		return;
+
+	if (!g_at_result_iter_next_string(&iter, &time))
+		return;
+
+	DBG("tz %s dst %d time %s", tz, dst, time);
+
+	if (sscanf(time, "%u/%u/%u,%u:%u:%u", &year, &mon, &mday,
+						&hour, &min, &sec) !=3D 6)
+		return;
+
+	nd->time.sec =3D sec;
+	nd->time.min =3D min;
+	nd->time.hour =3D hour;
+	nd->time.mday =3D mday;
+	nd->time.mon =3D mon;
+	nd->time.year =3D 2000 + year;
+
+	nd->time.utcoff =3D atoi(tz) * 15 * 60;
+	nd->time.dst =3D dst;
+
+	ofono_netreg_time_notify(netreg, &nd->time);
+}
+
+
+static void ublox_query_tech_cb(gboolean ok, GAtResult *result, gpointer u=
ser_data)
+{
+	struct tech_query *tq =3D user_data;
+	GAtResultIter iter;
+	gint enabled, state;
+	int tech =3D -1;
+
+	if (!ok)
+		goto error;
+
+	g_at_result_iter_init(&iter, result);
+
+	if (!g_at_result_iter_next(&iter, "+UREG:"))
+		return;
+
+	if (!g_at_result_iter_next_number(&iter, &enabled))
+		return;
+
+	if (!g_at_result_iter_next_number(&iter, &state))
+		return;
+
+	switch (state) {
+	case 4:
+		tech =3D 5;
+		break;
+	case 5:
+		tech =3D 4;
+		break;
+	case 8:
+		tech =3D 1;
+		break;
+	case 9:
+		tech =3D 2;
+		break;
+	default:
+		tech =3D state;
+	}
+
+error:
+	ofono_netreg_status_notify(tq->netreg,
+			tq->status, tq->lac, tq->ci, tech);
+}
+
+static void creg_notify(GAtResult *result, gpointer user_data)
+{
+	struct ofono_netreg *netreg =3D user_data;
+	int status, lac, ci, tech;
+	struct netreg_data *nd =3D ofono_netreg_get_data(netreg);
+	struct tech_query *tq;
+
+	if (at_util_parse_reg_unsolicited(result, "+CREG:", &status,
+			&lac, &ci, &tech, OFONO_VENDOR_GENERIC) =3D=3D FALSE)
+		return;
+
+	if (status !=3D 1 && status !=3D 5)
+		goto notify;
+
+	if (ublox_is_toby_l4(nd->model)) {
+		tq =3D g_new0(struct tech_query, 1);
+
+		tq->status =3D status;
+		tq->lac =3D lac;
+		tq->ci =3D ci;
+		tq->netreg =3D netreg;
+
+		if (g_at_chat_send(nd->at_data.chat, "AT+UREG?", ureg_prefix,
+				ublox_query_tech_cb, tq, g_free) > 0)
+			return;
+
+		g_free(tq);
+	}
+
+	if ((status =3D=3D 1 || status =3D=3D 5) && tech =3D=3D -1)
+		tech =3D nd->at_data.tech;
+
+notify:
+	ofono_netreg_status_notify(netreg, status, lac, ci, tech);
+}
+
+static void at_cmer_not_supported(struct ofono_netreg *netreg)
+{
+	ofono_error("+CMER not supported by this modem.  If this is an error"
+			" please submit patches to support this hardware");
+
+	ofono_netreg_remove(netreg);
+}
+
+static void ublox_cmer_set_cb(gboolean ok,
+				GAtResult *result, gpointer user_data)
+{
+	struct ofono_netreg *netreg =3D user_data;
+	struct at_netreg_data *nd =3D ofono_netreg_get_data(netreg);
+
+	if (!ok) {
+		at_cmer_not_supported(netreg);
+		return;
+	}
+
+	g_at_chat_register(nd->chat, "+CIEV:",
+			ciev_notify, FALSE, netreg, NULL);
+
+	g_at_chat_register(nd->chat, "+CREG:",
+				creg_notify, FALSE, netreg, NULL);
+
+	ofono_netreg_register(netreg);
+}
+
+static void ublox_creg_set_cb(gboolean ok,
+				GAtResult *result, gpointer user_data)
+{
+	struct ofono_netreg *netreg =3D user_data;
+	struct netreg_data *nd =3D ofono_netreg_get_data(netreg);
+
+	if (!ok) {
+		ofono_error("Unable to initialize Network Registration");
+		ofono_netreg_remove(netreg);
+		return;
+	}
+
+	if (ublox_is_toby_l4(nd->model)) {
+		/* FIXME */
+		ofono_error("TOBY L4 requires polling of ECSQ");
+		ofono_error("TOBY L4 wants UREG notifications for tech updates");
+	}
+
+	/* Register for network time update reports */
+	if (ublox_is_toby_l2(nd->model)) {
+		/* TOBY L2 does not support CTZDST */
+		g_at_chat_register(nd->at_data.chat, "+CTZE:", ctze_notify,
+						FALSE, netreg, NULL);
+		g_at_chat_send(nd->at_data.chat, "AT+CTZR=3D2", none_prefix,
+						NULL, NULL, NULL);
+	} else {
+		g_at_chat_register(nd->at_data.chat, "+CTZV:", ctzv_notify,
+						FALSE, netreg, NULL);
+		g_at_chat_register(nd->at_data.chat, "+CTZDST:", ctzdst_notify,
+						FALSE, netreg, NULL);
+		g_at_chat_send(nd->at_data.chat, "AT+CTZR=3D1", none_prefix,
+						NULL, NULL, NULL);
+	}
+
+	/* AT+CMER NOTES:
+	 * - For all u-blox models, mode 3 is equivalent to mode 1;
+	 * since some models do not support setting modes 2 nor 3
+	 * (see UBX-13002752), we prefer mode 1 for all models.
+	 * - The TOBY L4 does not support ind=3D2
+	 */
+	g_at_chat_send(nd->at_data.chat, "AT+CMER=3D1,0,0,1", cmer_prefix,
+			ublox_cmer_set_cb, netreg, NULL);
+}
+
+/*
+ * uBlox netreg atom probe.
+ * - takes uBlox model ID parameter instead of AT vendor ID
+ */
+static int ublox_netreg_probe(struct ofono_netreg *netreg,
+				unsigned int model_id,
+				void *data)
+{
+	GAtChat *chat =3D data;
+	struct netreg_data *nd;
+
+	nd =3D g_new0(struct netreg_data, 1);
+
+	nd->model =3D ublox_model_from_id(model_id);
+
+	/* There should be no uBlox-specific quirks in the 'generic'
+	 * AT driver
+	 */
+	nd->at_data.vendor =3D OFONO_VENDOR_GENERIC;
+
+	nd->at_data.chat =3D g_at_chat_clone(chat);
+	nd->at_data.tech =3D -1;
+	nd->at_data.time.sec =3D -1;
+	nd->at_data.time.min =3D -1;
+	nd->at_data.time.hour =3D -1;
+	nd->at_data.time.mday =3D -1;
+	nd->at_data.time.mon =3D -1;
+	nd->at_data.time.year =3D -1;
+	nd->at_data.time.dst =3D 0;
+	nd->at_data.time.utcoff =3D 0;
+	ofono_netreg_set_data(netreg, nd);
+
+	/* All uBlox devices support n=3D2 so no need to query this */
+	g_at_chat_send(nd->at_data.chat, "AT+CREG=3D2", none_prefix,
+			ublox_creg_set_cb, netreg, NULL);
+
+	return 0;
+}
+
+static const struct ofono_netreg_driver driver =3D {
+	.name				=3D "ubloxmodem",
+	.probe				=3D ublox_netreg_probe,
+	.remove				=3D at_netreg_remove,
+	.registration_status		=3D at_registration_status,
+	.current_operator		=3D at_current_operator,
+	.list_operators			=3D at_list_operators,
+	.register_auto			=3D at_register_auto,
+	.register_manual		=3D at_register_manual,
+	.strength			=3D at_signal_strength,
+};
+
+void ublox_netreg_init(void)
+{
+	ofono_netreg_driver_register(&driver);
+}
+
+void ublox_netreg_exit(void)
+{
+	ofono_netreg_driver_unregister(&driver);
+}
diff --git a/drivers/ubloxmodem/ubloxmodem.c b/drivers/ubloxmodem/ubloxmode=
m.c
index a52a67ea..719c77a0 100644
--- a/drivers/ubloxmodem/ubloxmodem.c
+++ b/drivers/ubloxmodem/ubloxmodem.c
@@ -115,6 +115,7 @@ int ublox_is_toby_l4(const struct ublox_model *model)
 static int ubloxmodem_init(void)
 {
 	ublox_gprs_context_init();
+	ublox_netreg_init();
 	ublox_netmon_init();
 	ublox_lte_init();
 =

@@ -124,6 +125,7 @@ static int ubloxmodem_init(void)
 static void ubloxmodem_exit(void)
 {
 	ublox_gprs_context_exit();
+	ublox_netreg_exit();
 	ublox_netmon_exit();
 	ublox_lte_exit();
 }
diff --git a/drivers/ubloxmodem/ubloxmodem.h b/drivers/ubloxmodem/ubloxmode=
m.h
index 2c5b7433..81fe9481 100644
--- a/drivers/ubloxmodem/ubloxmodem.h
+++ b/drivers/ubloxmodem/ubloxmodem.h
@@ -43,6 +43,9 @@ int ublox_is_toby_l4(const struct ublox_model *model);
 extern void ublox_gprs_context_init(void);
 extern void ublox_gprs_context_exit(void);
 =

+void ublox_netreg_init(void);
+void ublox_netreg_exit(void);
+
 extern void ublox_netmon_init(void);
 extern void ublox_netmon_exit(void);
 =

-- =

2.20.1


--===============8817342220727732683==--

