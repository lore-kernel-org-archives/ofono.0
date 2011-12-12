Content-Type: multipart/mixed; boundary="===============6945987777504583669=="
MIME-Version: 1.0
From: marko.saukko@gmail.com
Subject: [PATCH 1/3] n950: Add modem plugin for the N950
Date: Mon, 12 Dec 2011 13:39:42 +0200
Message-ID: <1323689984-24866-2-git-send-email-marko.saukko@gmail.com>
In-Reply-To: <1323689984-24866-1-git-send-email-marko.saukko@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6945987777504583669==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Aki Niemi <aki.niemi@nokia.com>

---
 Makefile.am          |    3 +
 plugins/n900.c       |   12 +-
 plugins/n950.c       |  563 ++++++++++++++++++++++++++++++++++++++++++++++=
++++
 plugins/nokia-gpio.c |  105 ++++------
 plugins/nokia-gpio.h |   38 +++-
 5 files changed, 651 insertions(+), 70 deletions(-)
 create mode 100644 plugins/n950.c

diff --git a/Makefile.am b/Makefile.am
index 337aeb7..f5d366d 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -147,6 +147,9 @@ builtin_sources +=3D plugins/isiusb.c
 builtin_modules +=3D n900
 builtin_sources +=3D plugins/n900.c plugins/nokia-gpio.h plugins/nokia-gpi=
o.c
 =

+builtin_modules +=3D n950
+builtin_sources +=3D plugins/n950.c
+
 builtin_modules +=3D u8500
 builtin_sources +=3D plugins/u8500.c
 endif
diff --git a/plugins/n900.c b/plugins/n900.c
index 44e2e75..420fd0c 100644
--- a/plugins/n900.c
+++ b/plugins/n900.c
@@ -308,7 +308,7 @@ static void n900_power_cb(enum power_state state, void =
*data)
 	struct ofono_modem *modem =3D data;
 	struct isi_data *isi =3D ofono_modem_get_data(modem);
 =

-	DBG("power state %s", gpio_power_state_name(state));
+	DBG("power state %s", nokia_gpio_power_state_name(state));
 =

 	isi->power_state =3D state;
 =

@@ -358,7 +358,7 @@ static int n900_probe(struct ofono_modem *modem)
 	if (getenv("OFONO_ISI_TRACE"))
 		g_isi_modem_set_trace(isimodem, isi_trace);
 =

-	if (gpio_probe(isimodem, address, n900_power_cb, modem) !=3D 0) {
+	if (nokia_gpio_probe(isimodem, address, n900_power_cb, modem) !=3D 0) {
 		DBG("gpio for %s: %s", ifname, strerror(errno));
 		goto error;
 	}
@@ -382,7 +382,7 @@ static int n900_probe(struct ofono_modem *modem)
 =

 error:
 	g_isi_modem_destroy(isimodem);
-	gpio_remove(modem);
+	nokia_gpio_remove(modem);
 	g_free(isi);
 =

 	return -errno;
@@ -397,7 +397,7 @@ static void n900_remove(struct ofono_modem *modem)
 	if (!isi)
 		return;
 =

-	gpio_remove(modem);
+	nokia_gpio_remove(modem);
 =

 	if (isi->timeout)
 		g_source_remove(isi->timeout);
@@ -523,7 +523,7 @@ static int n900_enable(struct ofono_modem *modem)
 =

 	isi->enabled =3D TRUE;
 =

-	return gpio_enable(modem);
+	return nokia_gpio_enable(modem);
 }
 =

 static int n900_disable(struct ofono_modem *modem)
@@ -534,7 +534,7 @@ static int n900_disable(struct ofono_modem *modem)
 =

 	isi->enabled =3D FALSE;
 =

-	return gpio_disable(modem);
+	return nokia_gpio_disable(modem);
 }
 =

 static struct ofono_modem_driver n900_driver =3D {
diff --git a/plugins/n950.c b/plugins/n950.c
new file mode 100644
index 0000000..6c9a9da
--- /dev/null
+++ b/plugins/n950.c
@@ -0,0 +1,563 @@
+/*
+ *
+ *  oFono - Open Source Telephony
+ *
+ *  Copyright (C) 2011  Nokia Corporation and/or its subsidiary(-ies).
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
+#include <errno.h>
+#include <stdlib.h>
+#include <string.h>
+#include <glib.h>
+
+#include <gisi/modem.h>
+#include <gisi/netlink.h>
+#include <gisi/client.h>
+
+#define OFONO_API_SUBJECT_TO_CHANGE
+#include <ofono/plugin.h>
+#include <ofono/log.h>
+#include <ofono/modem.h>
+#include <ofono/devinfo.h>
+#include <ofono/phonebook.h>
+#include <ofono/netreg.h>
+#include <ofono/voicecall.h>
+#include <ofono/sms.h>
+#include <ofono/cbs.h>
+#include <ofono/sim.h>
+#include <ofono/ussd.h>
+#include <ofono/call-forwarding.h>
+#include <ofono/call-settings.h>
+#include <ofono/call-barring.h>
+#include <ofono/call-meter.h>
+#include <ofono/radio-settings.h>
+#include <ofono/gprs.h>
+#include <ofono/gprs-context.h>
+#include <ofono/audio-settings.h>
+
+#include "drivers/isimodem/isimodem.h"
+#include "drivers/isimodem/isiutil.h"
+#include "drivers/isimodem/infoserver.h"
+#include "drivers/isimodem/mtc.h"
+#include "drivers/isimodem/debug.h"
+
+#include "nokia-gpio.h"
+
+struct isi_data {
+	const char *ifname;
+	GIsiModem *modem;
+	GIsiClient *client;
+	struct isi_infoserver *infoserver;
+	ofono_bool_t enabled;
+	ofono_bool_t online;
+	ofono_bool_t reported;
+	enum power_state power_state;
+	int mtc_state;
+	guint timeout;
+	struct isi_cb_data *online_cbd;
+};
+
+static void mtc_power_off(struct isi_data *isi);
+static gboolean mtc_power_off_poll(gpointer user);
+
+static gboolean check_response_status(const GIsiMessage *msg, uint8_t msgi=
d)
+{
+	if (g_isi_msg_error(msg) < 0) {
+		DBG("Error: %s", g_isi_msg_strerror(msg));
+		return FALSE;
+	}
+
+	if (g_isi_msg_id(msg) !=3D msgid) {
+		DBG("Unexpected msg: %s",
+			mtc_message_id_name(g_isi_msg_id(msg)));
+		return FALSE;
+	}
+	return TRUE;
+}
+
+static void report_powered(struct ofono_modem *modem, struct isi_data *isi,
+				ofono_bool_t powered)
+{
+	if (powered =3D=3D isi->reported)
+		return;
+
+	DBG("%s", powered ? "Powered on"
+		: isi->enabled ? "Reset"
+		: "Powered off");
+
+	isi->reported =3D powered;
+	ofono_modem_set_powered(modem, powered);
+}
+
+static void report_online(struct isi_data *isi, ofono_bool_t online)
+{
+	struct isi_cb_data *cbd =3D isi->online_cbd;
+	ofono_modem_online_cb_t cb =3D cbd->cb;
+
+	isi->online_cbd =3D NULL;
+
+	if (isi->online =3D=3D online)
+		CALLBACK_WITH_SUCCESS(cb, cbd->data);
+	else
+		CALLBACK_WITH_FAILURE(cb, cbd->data);
+
+	g_free(cbd);
+}
+
+static void set_power_by_mtc_state(struct ofono_modem *modem,
+					struct isi_data *isi, int mtc_state)
+{
+	isi->mtc_state =3D mtc_state;
+
+	if (isi->online_cbd)
+		report_online(isi, mtc_state =3D=3D MTC_NORMAL);
+
+	switch (mtc_state) {
+	case MTC_STATE_NONE:
+	case MTC_POWER_OFF:
+	case MTC_CHARGING:
+	case MTC_SELFTEST_FAIL:
+		report_powered(modem, isi, FALSE);
+		break;
+
+	case MTC_RF_INACTIVE:
+	case MTC_NORMAL:
+	default:
+		report_powered(modem, isi, TRUE);
+	}
+}
+
+static void mtc_state_ind_cb(const GIsiMessage *msg, void *data)
+{
+	struct ofono_modem *modem =3D data;
+	struct isi_data *isi =3D ofono_modem_get_data(modem);
+	uint8_t action;
+	uint8_t state;
+
+	if (g_isi_msg_error(msg) < 0)
+		return;
+
+	if (g_isi_msg_id(msg) !=3D MTC_STATE_INFO_IND)
+		return;
+
+	if (!g_isi_msg_data_get_byte(msg, 0, &state) ||
+			!g_isi_msg_data_get_byte(msg, 1, &action))
+		return;
+
+	if (action =3D=3D MTC_START) {
+		DBG("target modem state: %s (0x%02X)",
+			mtc_modem_state_name(state), state);
+
+		if (state =3D=3D MTC_POWER_OFF) {
+			isi->power_state =3D POWER_STATE_OFF_STARTED;
+			mtc_power_off_poll(isi);
+		}
+	} else if (action =3D=3D MTC_READY) {
+		DBG("current modem state: %s (0x%02X)",
+			mtc_modem_state_name(state), state);
+
+		set_power_by_mtc_state(modem, isi, state);
+	}
+}
+
+static void mtc_startup_synq_cb(const GIsiMessage *msg, void *data)
+{
+	check_response_status(msg, MTC_STARTUP_SYNQ_RESP);
+}
+
+static void mtc_startup_synq(struct isi_data *isi)
+{
+	const uint8_t msg[] =3D {
+		MTC_STARTUP_SYNQ_REQ,
+		0, 0,
+	};
+
+	g_isi_client_send(isi->client, msg, sizeof(msg),
+				mtc_startup_synq_cb, NULL, NULL);
+}
+
+static void mtc_query_cb(const GIsiMessage *msg, void *data)
+{
+	struct ofono_modem *modem =3D data;
+	struct isi_data *isi =3D ofono_modem_get_data(modem);
+	uint8_t current;
+	uint8_t target;
+
+	if (!check_response_status(msg, MTC_STATE_QUERY_RESP))
+		return;
+
+	if (!g_isi_msg_data_get_byte(msg, 0, &current) ||
+			!g_isi_msg_data_get_byte(msg, 1, &target))
+		return;
+
+	DBG("Modem state: current=3D%s (0x%02X) target=3D%s (0x%02X)",
+		mtc_modem_state_name(current), current,
+		mtc_modem_state_name(target), target);
+
+	set_power_by_mtc_state(modem, isi, current);
+
+	mtc_startup_synq(isi);
+}
+
+static void mtc_state_query(struct ofono_modem *modem)
+{
+	struct isi_data *isi =3D ofono_modem_get_data(modem);
+	const uint8_t msg[] =3D {
+		MTC_STATE_QUERY_REQ,
+		0, 0,
+	};
+
+	if (!isi)
+		return;
+
+	g_isi_client_send(isi->client, msg, sizeof(msg),
+				mtc_query_cb, modem, NULL);
+}
+
+static void mtc_reachable_cb(const GIsiMessage *msg, void *data)
+{
+	struct ofono_modem *modem =3D data;
+	struct isi_data *isi =3D ofono_modem_get_data(modem);
+
+	if (!g_isi_msg_error(msg) < 0)
+		return;
+
+	ISI_RESOURCE_DBG(msg);
+
+	g_isi_client_ind_subscribe(isi->client, MTC_STATE_INFO_IND,
+					mtc_state_ind_cb, modem);
+
+	mtc_state_query(modem);
+}
+
+static void mtc_shutdown_sync(struct isi_data *isi)
+{
+	const uint8_t msg[] =3D {
+		MTC_SHUTDOWN_SYNC_REQ,
+		0, 0,
+	};
+
+	g_isi_client_send(isi->client, msg, sizeof(msg), NULL, NULL, NULL);
+}
+
+
+static gboolean mtc_power_off_poll(gpointer user)
+{
+	struct isi_data *isi =3D user;
+
+	isi->timeout =3D 0;
+
+	if (isi->power_state =3D=3D POWER_STATE_ON_STARTED
+			|| isi->power_state =3D=3D POWER_STATE_OFF
+			|| isi->power_state =3D=3D POWER_STATE_OFF_WAITING)
+		return FALSE;
+
+	mtc_shutdown_sync(isi);
+
+	isi->timeout =3D g_timeout_add(200, mtc_power_off_poll, user);
+
+	return FALSE;
+}
+
+static void mtc_power_off_cb(const GIsiMessage *msg, void *data)
+{
+	struct isi_data *isi =3D data;
+
+	if (!check_response_status(msg, MTC_POWER_OFF_RESP)) {
+
+		if (isi->power_state =3D=3D POWER_STATE_OFF_STARTED)
+			mtc_power_off(isi);
+		return;
+	}
+
+	/* power off poll is started by mtc_state_ind_cb() */
+}
+
+static void mtc_power_off(struct isi_data *isi)
+{
+	const uint8_t msg[] =3D {
+		MTC_POWER_OFF_REQ,
+		0, 0,
+	};
+
+	g_isi_client_send(isi->client, msg, sizeof(msg),
+				mtc_power_off_cb, isi, NULL);
+}
+
+static void n950_power_cb(enum power_state state, void *data)
+{
+	struct ofono_modem *modem =3D data;
+	struct isi_data *isi =3D ofono_modem_get_data(modem);
+
+	DBG("power state %s", nokia_gpio_power_state_name(state));
+
+	isi->power_state =3D state;
+
+	if (state =3D=3D POWER_STATE_OFF_STARTED)
+		mtc_power_off(isi);
+	else if (isi->timeout)
+		g_source_remove(isi->timeout);
+
+	if (state =3D=3D POWER_STATE_ON)
+		g_isi_client_verify(isi->client, mtc_reachable_cb, modem, NULL);
+	else if (isi->enabled)
+		/* If enabled, report modem crash */
+		set_power_by_mtc_state(modem, isi, MTC_STATE_NONE);
+	else if (state =3D=3D POWER_STATE_OFF || state =3D=3D POWER_STATE_ON_FAIL=
ED)
+		/* If being disabled, report powered off only when safe */
+		report_powered(modem, isi, 0);
+	else
+		isi->mtc_state =3D MTC_STATE_NONE;
+}
+
+static int n950_probe(struct ofono_modem *modem)
+{
+	char const *ifname =3D ofono_modem_get_string(modem, "Interface");
+	unsigned address =3D ofono_modem_get_integer(modem, "Address");
+
+	struct isi_data *isi =3D NULL;
+	GIsiModem *isimodem;
+	GIsiClient *client;
+
+	if (!ifname)
+		return -EINVAL;
+
+	DBG("(%p) with %s", modem, ifname);
+
+	isimodem =3D g_isi_modem_create_by_name(ifname);
+	if (isimodem =3D=3D NULL) {
+		DBG("Interface=3D%s: %s", ifname, strerror(errno));
+		return -errno;
+	}
+
+	g_isi_modem_set_userdata(isimodem, modem);
+	g_isi_modem_set_flags(isimodem, GISI_MODEM_FLAG_USE_LEGACY_SUBSCRIBE);
+
+	if (getenv("OFONO_ISI_DEBUG"))
+		g_isi_modem_set_debug(isimodem, ofono_debug);
+
+	if (getenv("OFONO_ISI_TRACE"))
+		g_isi_modem_set_trace(isimodem, isi_trace);
+
+	if (nokia_gpio_probe(isimodem, address, n950_power_cb, modem) !=3D 0) {
+		DBG("gpio for %s: %s", ifname, strerror(errno));
+		goto error;
+	}
+
+	isi =3D g_try_new0(struct isi_data, 1);
+	if (isi =3D=3D NULL) {
+		errno =3D ENOMEM;
+		goto error;
+	}
+
+	client =3D g_isi_client_create(isimodem, PN_MTC);
+	if (!client)
+		goto error;
+
+	isi->modem =3D isimodem;
+	isi->ifname =3D ifname;
+	isi->client =3D client;
+
+	ofono_modem_set_data(modem, isi);
+	return 0;
+
+error:
+	g_isi_modem_destroy(isimodem);
+	nokia_gpio_remove(modem);
+	g_free(isi);
+
+	return -errno;
+}
+
+static void n950_remove(struct ofono_modem *modem)
+{
+	struct isi_data *isi =3D ofono_modem_get_data(modem);
+
+	ofono_modem_set_data(modem, NULL);
+
+	if (!isi)
+		return;
+
+	nokia_gpio_remove(modem);
+
+	if (isi->timeout)
+		g_source_remove(isi->timeout);
+
+	g_isi_client_destroy(isi->client);
+	g_isi_modem_destroy(isi->modem);
+	g_free(isi);
+}
+
+static void mtc_state_cb(const GIsiMessage *msg, void *data)
+{
+	struct isi_cb_data *cbd =3D data;
+	struct ofono_modem *modem =3D cbd->user;
+	ofono_modem_online_cb_t cb =3D cbd->cb;
+
+	struct isi_data *isi =3D ofono_modem_get_data(modem);
+	uint8_t cause;
+
+	if (!check_response_status(msg, MTC_STATE_RESP))
+		goto error;
+
+	if (!g_isi_msg_data_get_byte(msg, 0, &cause))
+		goto error;
+
+	DBG("MTC cause: %s (0x%02X)", mtc_isi_cause_name(cause), cause);
+
+	if (cause =3D=3D MTC_OK) {
+		isi->online_cbd =3D cbd;
+		return;
+	}
+
+	if (cause =3D=3D MTC_ALREADY_ACTIVE) {
+		CALLBACK_WITH_SUCCESS(cb, cbd->data);
+		g_free(cbd);
+		return;
+	}
+
+error:
+	CALLBACK_WITH_FAILURE(cb, cbd->data);
+	g_free(cbd);
+}
+
+static void n950_set_online(struct ofono_modem *modem,
+					ofono_bool_t online,
+					ofono_modem_online_cb_t cb, void *data)
+{
+	struct isi_data *isi =3D ofono_modem_get_data(modem);
+	struct isi_cb_data *cbd =3D isi_cb_data_new(modem, cb, data);
+	const uint8_t req[] =3D {
+		MTC_STATE_REQ,
+		online ? MTC_NORMAL : MTC_RF_INACTIVE, 0
+	};
+
+	DBG("(%p) with %s", modem, isi->ifname);
+
+	if (cbd =3D=3D NULL || isi =3D=3D NULL)
+		goto error;
+
+	if (isi->power_state !=3D POWER_STATE_ON)
+		goto error;
+
+	if (isi->mtc_state =3D=3D MTC_SELFTEST_FAIL)
+		goto error;
+
+	if (g_isi_client_send_with_timeout(isi->client, req, sizeof(req),
+				MTC_STATE_REQ_TIMEOUT,
+				mtc_state_cb, cbd, NULL)) {
+		isi->online =3D online;
+		return;
+	}
+
+error:
+	CALLBACK_WITH_FAILURE(cb, data);
+	g_free(cbd);
+}
+
+static void n950_pre_sim(struct ofono_modem *modem)
+{
+	struct isi_data *isi =3D ofono_modem_get_data(modem);
+
+	DBG("(%p) with %s", modem, isi->ifname);
+
+	isi->infoserver =3D isi_infoserver_create(modem, isi->modem);
+
+	ofono_sim_create(modem, 0, "isimodem", isi->modem);
+	ofono_devinfo_create(modem, 0, "isimodem", isi->modem);
+	ofono_voicecall_create(modem, 0, "isimodem", isi->modem);
+	ofono_audio_settings_create(modem, 0, "isimodem", isi->modem);
+}
+
+static void n950_post_sim(struct ofono_modem *modem)
+{
+	struct isi_data *isi =3D ofono_modem_get_data(modem);
+
+	DBG("(%p) with %s", modem, isi->ifname);
+
+	ofono_phonebook_create(modem, 0, "isimodem", isi->modem);
+	ofono_call_forwarding_create(modem, 0, "isimodem", isi->modem);
+	ofono_radio_settings_create(modem, 0, "isimodem", isi->modem);
+}
+
+static void n950_post_online(struct ofono_modem *modem)
+{
+	struct isi_data *isi =3D ofono_modem_get_data(modem);
+
+	DBG("(%p) with %s", modem, isi->ifname);
+
+	ofono_netreg_create(modem, 0, "isimodem", isi->modem);
+	ofono_sms_create(modem, 0, "isimodem", isi->modem);
+	ofono_cbs_create(modem, 0, "isimodem", isi->modem);
+	ofono_ussd_create(modem, 0, "isimodem", isi->modem);
+	ofono_call_settings_create(modem, 0, "isimodem", isi->modem);
+	ofono_call_barring_create(modem, 0, "isimodem", isi->modem);
+	ofono_call_meter_create(modem, 0, "isimodem", isi->modem);
+	ofono_gprs_create(modem, 0, "isimodem", isi->modem);
+}
+
+static int n950_enable(struct ofono_modem *modem)
+{
+	struct isi_data *isi =3D ofono_modem_get_data(modem);
+
+	DBG("modem=3D%p with %p", modem, isi ? isi->ifname : NULL);
+
+	isi->enabled =3D TRUE;
+
+	return nokia_gpio_enable(modem);
+}
+
+static int n950_disable(struct ofono_modem *modem)
+{
+	struct isi_data *isi =3D ofono_modem_get_data(modem);
+
+	DBG("modem=3D%p with %p", modem, isi ? isi->ifname : NULL);
+
+	isi->enabled =3D FALSE;
+
+	return nokia_gpio_disable(modem);
+}
+
+static struct ofono_modem_driver n950_driver =3D {
+	.name =3D "n950",
+	.probe =3D n950_probe,
+	.remove =3D n950_remove,
+	.enable =3D n950_enable,
+	.disable =3D n950_disable,
+	.set_online =3D n950_set_online,
+	.pre_sim =3D n950_pre_sim,
+	.post_sim =3D n950_post_sim,
+	.post_online =3D n950_post_online,
+};
+
+static int n950_init(void)
+{
+	return ofono_modem_driver_register(&n950_driver);
+}
+
+static void n950_exit(void)
+{
+	ofono_modem_driver_unregister(&n950_driver);
+}
+
+OFONO_PLUGIN_DEFINE(n950, "Nokia N950 modem driver", VERSION,
+			OFONO_PLUGIN_PRIORITY_DEFAULT, n950_init, n950_exit)
diff --git a/plugins/nokia-gpio.c b/plugins/nokia-gpio.c
index 57aad8d..23dd62a 100644
--- a/plugins/nokia-gpio.c
+++ b/plugins/nokia-gpio.c
@@ -60,18 +60,6 @@ enum phonet_link {
 	PHONET_LINK_UP,
 };
 =

-enum power_event {
-	POWER_EVENT_PHONET_LINK_UP =3D 1,
-	POWER_EVENT_PHONET_LINK_DOWN,
-	POWER_EVENT_ON,
-	POWER_EVENT_ON_TIMEOUT,
-	POWER_EVENT_REBOOT_TIMEOUT,
-	POWER_EVENT_OFF,
-	POWER_EVENT_OFF_IMMEDIATELY,
-	POWER_EVENT_OFF_TIMEOUT,
-	POWER_EVENT_OFF_COMPLETE,
-};
-
 struct gpio_data {
 	GIsiPhonetNetlink *link;
 	gpio_finished_cb_t callback;
@@ -98,41 +86,6 @@ struct gpio_data {
 =

 static struct gpio_data self;
 =

-#define _(X) case X: return #X
-
-static inline char const *gpio_power_event_name(enum power_event value)
-{
-	switch (value) {
-		_(POWER_EVENT_PHONET_LINK_UP);
-		_(POWER_EVENT_PHONET_LINK_DOWN);
-		_(POWER_EVENT_ON);
-		_(POWER_EVENT_ON_TIMEOUT);
-		_(POWER_EVENT_REBOOT_TIMEOUT);
-		_(POWER_EVENT_OFF);
-		_(POWER_EVENT_OFF_IMMEDIATELY);
-		_(POWER_EVENT_OFF_TIMEOUT);
-		_(POWER_EVENT_OFF_COMPLETE);
-	}
-	return "<UNKNOWN>";
-}
-
-char const *gpio_power_state_name(enum power_state value)
-{
-	switch (value) {
-		_(POWER_STATE_NONE);
-		_(POWER_STATE_ON_STARTED);
-		_(POWER_STATE_ON);
-		_(POWER_STATE_ON_RESET);
-		_(POWER_STATE_ON_FAILED);
-		_(POWER_STATE_OFF_STARTED);
-		_(POWER_STATE_OFF_WAITING);
-		_(POWER_STATE_OFF);
-	}
-	return "<UNKNOWN>";
-}
-
-#undef _
-
 static void gpio_power_state_machine(enum power_event event);
 static void gpio_power_set_state(enum power_state new_state);
 =

@@ -324,14 +277,13 @@ static gboolean gpio_power_timer_cb(gpointer user)
 	return FALSE;
 }
 =

-
 static void gpio_power_state_machine(enum power_event event)
 {
 	enum power_state new_state;
 =

 	DBG("(%s) @ state %s",
-		gpio_power_event_name(event),
-		gpio_power_state_name(self.state));
+		nokia_gpio_power_event_name(event),
+		nokia_gpio_power_state_name(self.state));
 =

 	switch (event) {
 	case POWER_EVENT_ON:
@@ -491,10 +443,9 @@ static void gpio_power_state_machine(enum power_event =
event)
 		return;
 	}
 =

-	DBG("Event %s (%d) not handled", gpio_power_event_name(event), event);
+	DBG("Event %s (%d) not handled", nokia_gpio_power_event_name(event), even=
t);
 }
 =

-
 static void gpio_power_set_state(enum power_state new_state)
 {
 	enum power_state old_state =3D self.state;
@@ -502,8 +453,8 @@ static void gpio_power_set_state(enum power_state new_s=
tate)
 	enum power_event timer_event;
 =

 	DBG("(%s) at (%s)%s",
-		gpio_power_state_name(new_state),
-		gpio_power_state_name(old_state),
+		nokia_gpio_power_state_name(new_state),
+		nokia_gpio_power_state_name(old_state),
 		new_state =3D=3D old_state ? " - already" : "");
 =

 	switch (old_state) {
@@ -707,8 +658,8 @@ static int gpio_probe_links(void)
 	return -(errno =3D ENODEV);
 }
 =

-
-int gpio_probe(GIsiModem *idx, unsigned addr, gpio_finished_cb_t cb, void =
*data)
+int nokia_gpio_probe(GIsiModem *idx, unsigned addr, gpio_finished_cb_t cb,
+			void *data)
 {
 	int error;
 =

@@ -774,7 +725,7 @@ int gpio_probe(GIsiModem *idx, unsigned addr, gpio_fini=
shed_cb_t cb, void *data)
 	return 0;
 }
 =

-int gpio_remove(void *data)
+int nokia_gpio_remove(void *data)
 {
 	if (self.data !=3D data)
 		return -EINVAL;
@@ -792,7 +743,7 @@ int gpio_remove(void *data)
 	return 0;
 }
 =

-int gpio_enable(void *data)
+int nokia_gpio_enable(void *data)
 {
 	if (self.data !=3D data)
 		return -EINVAL;
@@ -805,7 +756,7 @@ int gpio_enable(void *data)
 	return -EINPROGRESS;
 }
 =

-int gpio_disable(void *data)
+int nokia_gpio_disable(void *data)
 {
 	if (self.data !=3D data)
 		return -EINVAL;
@@ -818,3 +769,39 @@ int gpio_disable(void *data)
 =

 	return -EINPROGRESS;
 }
+
+
+#define _(X) case X: return #X
+
+const char *nokia_gpio_power_event_name(enum power_event value)
+{
+	switch (value) {
+		_(POWER_EVENT_PHONET_LINK_UP);
+		_(POWER_EVENT_PHONET_LINK_DOWN);
+		_(POWER_EVENT_ON);
+		_(POWER_EVENT_ON_TIMEOUT);
+		_(POWER_EVENT_REBOOT_TIMEOUT);
+		_(POWER_EVENT_OFF);
+		_(POWER_EVENT_OFF_IMMEDIATELY);
+		_(POWER_EVENT_OFF_TIMEOUT);
+		_(POWER_EVENT_OFF_COMPLETE);
+	}
+	return "<UNKNOWN>";
+}
+
+const char *nokia_gpio_power_state_name(enum power_state value)
+{
+	switch (value) {
+		_(POWER_STATE_NONE);
+		_(POWER_STATE_ON_STARTED);
+		_(POWER_STATE_ON);
+		_(POWER_STATE_ON_RESET);
+		_(POWER_STATE_ON_FAILED);
+		_(POWER_STATE_OFF_STARTED);
+		_(POWER_STATE_OFF_WAITING);
+		_(POWER_STATE_OFF);
+	}
+	return "<UNKNOWN>";
+}
+
+#undef _
diff --git a/plugins/nokia-gpio.h b/plugins/nokia-gpio.h
index b653bb8..59ffe23 100644
--- a/plugins/nokia-gpio.h
+++ b/plugins/nokia-gpio.h
@@ -19,6 +19,13 @@
  *
  */
 =

+#ifndef __NOKIA_GPIO_H
+#define __NOKIA_GPIO_H
+
+#ifdef __cplusplus
+extern "C" {
+#endif
+
 enum power_state {
 	POWER_STATE_NONE,
 	POWER_STATE_ON_STARTED,
@@ -30,11 +37,32 @@ enum power_state {
 	POWER_STATE_OFF,
 };
 =

+enum power_event {
+	POWER_EVENT_PHONET_LINK_UP =3D 1,
+	POWER_EVENT_PHONET_LINK_DOWN,
+	POWER_EVENT_ON,
+	POWER_EVENT_ON_TIMEOUT,
+	POWER_EVENT_REBOOT_TIMEOUT,
+	POWER_EVENT_OFF,
+	POWER_EVENT_OFF_IMMEDIATELY,
+	POWER_EVENT_OFF_TIMEOUT,
+	POWER_EVENT_OFF_COMPLETE,
+};
+
 typedef void (*gpio_finished_cb_t)(enum power_state value, void *opaque);
 =

-int gpio_probe(GIsiModem *idx, unsigned addr, gpio_finished_cb_t cb, void =
*data);
-int gpio_enable(void *opaque);
-int gpio_disable(void *opaque);
-int gpio_remove(void *opaque);
+int nokia_gpio_probe(GIsiModem *idx, unsigned addr, gpio_finished_cb_t cb,=
 void *data);
+int nokia_gpio_enable(void *opaque);
+int nokia_gpio_disable(void *opaque);
+int nokia_gpio_remove(void *opaque);
+
+const char *nokia_gpio_power_event_name(enum power_event value);
+const char *nokia_gpio_power_state_name(enum power_state value);
+
+#undef _
+
+#ifdef __cplusplus
+};
+#endif
 =

-char const *gpio_power_state_name(enum power_state value);
+#endif /* !__NOKIA_GPIO_H */
-- =

1.7.6.4


--===============6945987777504583669==--

