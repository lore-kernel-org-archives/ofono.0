Content-Type: multipart/mixed; boundary="===============3983234163037080999=="
MIME-Version: 1.0
From: Pekka.Pessi@nokia.com
Subject: [n900 PATCH 4/5] n900: modem driver plugin for Nokia N900
Date: Wed, 15 Sep 2010 19:59:33 +0300
Message-ID: <1284569974-22505-5-git-send-email-Pekka.Pessi@nokia.com>
In-Reply-To: <1284569974-22505-4-git-send-email-Pekka.Pessi@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3983234163037080999==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Pekka Pessi <ppessi@hamsa.research.nokia.com>

The n900 plugin has modem driver based on isimodem, controlling the N900
internal modem using the appropriate GPIO lines. It runs natively on
N900 with Maemo or Meego kernel.

The plugin conflicts with Maemo userspace, however.
---
 Makefile.am        |    6 +
 plugins/n900.c     |  573 +++++++++++++++++++++++++++++++++++++
 plugins/n900gpio.c |  796 ++++++++++++++++++++++++++++++++++++++++++++++++=
++++
 plugins/n900gpio.h |   54 ++++
 4 files changed, 1429 insertions(+), 0 deletions(-)
 create mode 100644 plugins/n900.c
 create mode 100644 plugins/n900gpio.c
 create mode 100644 plugins/n900gpio.h

diff --git a/Makefile.am b/Makefile.am
index aca5d1b..d643ca8 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -130,12 +130,17 @@ isimodem_sources =3D $(gisi_sources) \
 =

 isigen_sources =3D plugins/isigen.c
 =

+n900_sources =3D plugins/n900.c plugins/n900gpio.h plugins/n900gpio.c
+
 if ISIMODEM
 builtin_modules +=3D isimodem
 builtin_sources +=3D $(isimodem_sources)
 =

 builtin_modules +=3D isigen
 builtin_sources +=3D $(isigen_sources)
+
+builtin_modules +=3D n900
+builtin_sources +=3D $(n900_sources)
 endif
 =

 if ATMODEM
@@ -383,6 +388,7 @@ conf_files =3D src/ofono.conf plugins/modem.conf
 EXTRA_DIST =3D src/genbuiltin plugins/example_history.c $(doc_files) \
 				$(isimodem_sources) \
 				$(isigen_sources) \
+				$(n900_sources) \
 				$(test_scripts) $(conf_files) $(udev_files)
 =

 dist_man_MANS =3D doc/ofonod.8
diff --git a/plugins/n900.c b/plugins/n900.c
new file mode 100644
index 0000000..bd0e156
--- /dev/null
+++ b/plugins/n900.c
@@ -0,0 +1,573 @@
+/*
+ * This file is part of oFono - Open Source Telephony
+ *
+ * Copyright (C) 2009 Nokia Corporation and/or its subsidiary(-ies).
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * version 2 as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA
+ * 02110-1301 USA
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
+#include <ofono/ssn.h>
+#include <ofono/call-forwarding.h>
+#include <ofono/call-settings.h>
+#include <ofono/call-barring.h>
+#include <ofono/call-meter.h>
+#include <ofono/radio-settings.h>
+#include <ofono/gprs.h>
+#include <ofono/gprs-context.h>
+
+#include "drivers/isimodem/isimodem.h"
+#include "drivers/isimodem/isiutil.h"
+#include "drivers/isimodem/infoserver.h"
+#include "drivers/isimodem/mtc.h"
+#include "drivers/isimodem/debug.h"
+
+#include "n900gpio.h"
+
+struct isi_data {
+	struct ofono_modem *modem;
+	char const *ifname;
+	GIsiModem *idx;
+	GIsiClient *client;
+	struct n900_gpio *gpio;
+	struct isi_infoserver *infoserver;
+	int reported;
+	enum n900_power_state power_state;
+	int mtc_state;
+	guint timeout;
+	ofono_bool_t online;
+	struct isi_cb_data *online_cbd;
+};
+
+static void set_power_by_mtc_state(struct isi_data *isi, int state);
+static void mtc_power_off(struct isi_data *isi);
+static gboolean mtc_power_off_poll(gpointer user);
+
+static void report_powered(struct isi_data *isi, ofono_bool_t powered)
+{
+	if (powered !=3D isi->reported)
+		ofono_modem_set_powered(isi->modem, isi->reported =3D powered);
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
+static void set_power_by_mtc_state(struct isi_data *isi, int mtc_state)
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
+		report_powered(isi, 0);
+		break;
+
+	case MTC_RF_INACTIVE:
+	case MTC_NORMAL:
+	default:
+		report_powered(isi, 1);
+	}
+}
+
+static void mtc_state_ind_cb(GIsiClient *client, const void *restrict data,
+				size_t len, uint16_t object, void *opaque)
+{
+	const unsigned char *msg =3D data;
+	struct isi_data *isi =3D opaque;
+
+	if (!msg) {
+		DBG("ISI client error: %d", g_isi_client_error(client));
+		return;
+	}
+
+	if (len < 3 || msg[0] !=3D MTC_STATE_INFO_IND)
+		return;
+
+	if (msg[2] =3D=3D MTC_START) {
+		DBG("target modem state: %s (0x%02X)",
+			mtc_modem_state_name(msg[1]), msg[1]);
+		if (msg[1] =3D=3D MTC_POWER_OFF) {
+			isi->power_state =3D POWER_OFF_STARTED_STATE;
+			mtc_power_off_poll(isi);
+		}
+	} else if (msg[2] =3D=3D MTC_READY) {
+		DBG("current modem state: %s (0x%02X)",
+			mtc_modem_state_name(msg[1]), msg[1]);
+		set_power_by_mtc_state(isi, msg[1]);
+	}
+}
+
+static gboolean mtc_startup_synq_cb(GIsiClient *client,
+					const void *restrict data, size_t len,
+					uint16_t object, void *opaque)
+{
+	const unsigned char *msg =3D data;
+
+	if (!msg) {
+		DBG("%s: %s", "MTC_STARTUP_SYNQ",
+			strerror(-g_isi_client_error(client)));
+		return TRUE;
+	}
+
+	if (len < 3 || msg[0] !=3D MTC_STARTUP_SYNQ_RESP)
+		return FALSE;
+
+	return TRUE;
+}
+
+static gboolean mtc_state_query_cb(GIsiClient *client,
+					const void *restrict data, size_t len,
+					uint16_t object, void *opaque)
+{
+	const unsigned char *msg =3D data;
+	struct isi_data *isi =3D opaque;
+
+	if (!msg) {
+		DBG("ISI client error: %d", g_isi_client_error(client));
+		return TRUE;
+	}
+
+	if (len < 3 || msg[0] !=3D MTC_STATE_QUERY_RESP)
+		return FALSE;
+
+	DBG("current modem state: %s (0x%02X)",
+		mtc_modem_state_name(msg[1]), msg[1]);
+	DBG("target modem state: %s (0x%02X)",
+		mtc_modem_state_name(msg[2]), msg[2]);
+
+	set_power_by_mtc_state(isi, msg[1]);
+
+	{
+		const unsigned char msg[3] =3D {
+			MTC_STARTUP_SYNQ_REQ,
+		};
+		g_isi_request_make(client, msg, sizeof(msg), MTC_TIMEOUT,
+					mtc_startup_synq_cb, opaque);
+	}
+
+	return TRUE;
+}
+
+static void reachable_cb(GIsiClient *client, gboolean alive, uint16_t obje=
ct,
+				void *opaque)
+{
+	const unsigned char msg[] =3D {
+		MTC_STATE_QUERY_REQ,
+		0x00, 0x00 /* Filler */
+	};
+
+	if (!alive) {
+		DBG("MTC client: %s", strerror(-g_isi_client_error(client)));
+		/* XXX */
+		return;
+	}
+
+	DBG("%s (v.%03d.%03d) reachable",
+		pn_resource_name(g_isi_client_resource(client)),
+		g_isi_version_major(client),
+		g_isi_version_minor(client));
+
+	g_isi_subscribe(client, MTC_STATE_INFO_IND, mtc_state_ind_cb, opaque);
+	g_isi_request_make(client, msg, sizeof(msg), MTC_TIMEOUT,
+				mtc_state_query_cb, opaque);
+}
+
+static gboolean mtc_power_off_poll(gpointer user)
+{
+	struct isi_data *isi =3D user;
+
+	const unsigned char req[] =3D {
+		MTC_SHUTDOWN_SYNC_REQ,
+		0x00, 0x00 /* Filler */
+	};
+
+	isi->timeout =3D 0;
+
+	if (isi->power_state =3D=3D POWER_ON_STARTED_STATE ||
+		isi->power_state =3D=3D POWER_OFF_STATE ||
+		isi->power_state =3D=3D POWER_OFF_WAITING_STATE)
+		return FALSE;
+
+	g_isi_request_make(isi->client, req, sizeof(req), MTC_TIMEOUT,
+				NULL, NULL);
+
+	isi->timeout =3D g_timeout_add(200, mtc_power_off_poll, user);
+
+	return FALSE;
+}
+
+static gboolean mtc_power_off_cb(GIsiClient *client,
+					const void *restrict data, size_t len,
+					uint16_t object, void *opaque)
+{
+	struct isi_data *isi =3D opaque;
+	const unsigned char *msg =3D data;
+
+	if (!msg) {
+		DBG("%s: %s", "MTC_POWER_OFF_RESP",
+			strerror(-g_isi_client_error(client)));
+		if (isi->power_state =3D=3D POWER_OFF_STARTED_STATE)
+			mtc_power_off(isi);
+		return TRUE;
+	}
+
+	if (len < 3 || msg[0] !=3D MTC_POWER_OFF_RESP)
+		return FALSE;
+
+	return TRUE;
+}
+
+static void mtc_power_off(struct isi_data *isi)
+{
+	const unsigned char req[] =3D {
+		MTC_POWER_OFF_REQ,
+		0x00, 0x00 /* Filler */
+	};
+
+	g_isi_request_make(isi->client, req, sizeof(req), MTC_TIMEOUT,
+				mtc_power_off_cb, isi);
+}
+
+static void n900_modem_power_cb(enum n900_power_state state,
+				void *data)
+{
+	struct ofono_modem *modem =3D data;
+	struct isi_data *isi =3D ofono_modem_get_data(modem);
+
+	DBG("power state %s", n900_power_state_name(state));
+
+	isi->power_state =3D state;
+
+	if (state =3D=3D POWER_OFF_STARTED_STATE)
+		mtc_power_off(isi);
+	else if (isi->timeout)
+		g_source_remove(isi->timeout);
+
+	if (state =3D=3D POWER_ON_STATE)
+		g_isi_verify(isi->client, reachable_cb, isi);
+	else
+		set_power_by_mtc_state(isi, MTC_STATE_NONE);
+}
+
+static int n900_modem_probe(struct ofono_modem *modem)
+{
+	char const *ifname =3D ofono_modem_get_string(modem, "Interface");
+	GIsiModem *idx;
+	struct isi_data *isi;
+
+	if (ifname =3D=3D NULL)
+		ifname =3D "phonet0";
+
+	DBG("(%p) with %s", modem, ifname);
+
+	idx =3D g_isi_modem_by_name(ifname);
+	if (idx =3D=3D NULL) {
+		DBG("Interface=3D%s: %s", ifname, strerror(errno));
+		return -errno;
+	}
+
+	if (n900_gpio_probe(idx, n900_modem_power_cb, modem) !=3D 0) {
+		DBG("gpio for %s: %s", ifname, strerror(errno));
+		return -errno;
+	}
+
+	isi =3D g_new0(struct isi_data, 1);
+	if (isi =3D=3D NULL) {
+		n900_gpio_remove(modem);
+		return -ENOMEM;
+	}
+
+	ofono_modem_set_data(isi->modem =3D modem, isi);
+
+	isi->idx =3D idx;
+	isi->ifname =3D ifname;
+	isi->client =3D g_isi_client_create(isi->idx, PN_MTC);
+
+	return 0;
+}
+
+static void n900_modem_remove(struct ofono_modem *modem)
+{
+	struct isi_data *isi =3D ofono_modem_get_data(modem);
+
+	DBG("");
+
+	if (isi =3D=3D NULL)
+		return;
+
+	n900_gpio_remove(modem);
+	if (isi->timeout)
+		g_source_remove(isi->timeout);
+	g_isi_client_destroy(isi->client);
+	g_free(isi);
+}
+
+static gboolean mtc_state_cb(GIsiClient *client,
+				const void *restrict data, size_t len,
+				uint16_t object, void *opaque)
+{
+	struct isi_cb_data *cbd =3D opaque;
+	struct ofono_modem *modem =3D cbd->user;
+	ofono_modem_online_cb_t cb =3D cbd->cb;
+	struct isi_data *isi =3D ofono_modem_get_data(modem);
+	const unsigned char *msg =3D data;
+
+	if (!msg) {
+		DBG("ISI client error: %d", g_isi_client_error(client));
+		goto err;
+	}
+
+	if (len < 3 || msg[0] !=3D MTC_STATE_RESP)
+		return FALSE;
+
+	DBG("cause: %s (0x%02X)", mtc_isi_cause_name(msg[1]), msg[1]);
+
+	if (msg[1] =3D=3D MTC_OK) {
+		isi->online_cbd =3D cbd;
+		return TRUE;
+	}
+
+err:
+	if (msg && msg[1] =3D=3D MTC_ALREADY_ACTIVE)
+		CALLBACK_WITH_SUCCESS(cb, cbd->data);
+	else
+		CALLBACK_WITH_FAILURE(cb, cbd->data);
+
+	g_free(cbd);
+	return TRUE;
+}
+
+static void n900_modem_set_online(struct ofono_modem *modem,
+					ofono_bool_t online,
+					ofono_modem_online_cb_t cb, void *data)
+{
+	struct isi_data *isi =3D ofono_modem_get_data(modem);
+	const unsigned char req[] =3D {
+		MTC_STATE_REQ, online ? MTC_NORMAL : MTC_RF_INACTIVE, 0x00
+	};
+	struct isi_cb_data *cbd;
+
+	DBG("(%p) with %s", modem, isi->ifname);
+
+	if (isi->power_state !=3D POWER_ON_STATE)
+		goto error;
+	if (isi->mtc_state =3D=3D MTC_SELFTEST_FAIL)
+		goto error;
+
+	cbd =3D isi_cb_data_new(modem, cb, data);
+	if (!cbd)
+		goto error;
+
+	isi->online =3D online;
+
+	if (g_isi_request_make(isi->client, req, sizeof(req), MTC_TIMEOUT,
+				mtc_state_cb, cbd))
+		return;
+
+	g_free(cbd);
+error:
+	CALLBACK_WITH_FAILURE(cb, data);
+}
+
+static void n900_modem_pre_sim(struct ofono_modem *modem)
+{
+	struct isi_data *isi =3D ofono_modem_get_data(modem);
+
+	DBG("");
+
+	isi->infoserver =3D isi_infoserver_create(isi->modem, isi->idx);
+
+	ofono_sim_create(isi->modem, 0, "isimodem", isi->idx);
+	ofono_devinfo_create(isi->modem, 0, "isimodem", isi->idx);
+	ofono_voicecall_create(isi->modem, 0, "isimodem", isi->idx);
+}
+
+static void n900_modem_post_sim(struct ofono_modem *modem)
+{
+	struct isi_data *isi =3D ofono_modem_get_data(modem);
+
+	DBG("");
+
+	ofono_phonebook_create(isi->modem, 0, "isimodem", isi->idx);
+}
+
+static void n900_modem_post_online(struct ofono_modem *modem)
+{
+	struct isi_data *isi =3D ofono_modem_get_data(modem);
+	struct ofono_gprs *gprs;
+	struct ofono_gprs_context *gc;
+
+	DBG("");
+
+	ofono_netreg_create(isi->modem, 0, "isimodem", isi->idx);
+	ofono_sms_create(isi->modem, 0, "isimodem", isi->idx);
+	ofono_cbs_create(isi->modem, 0, "isimodem", isi->idx);
+	ofono_ssn_create(isi->modem, 0, "isimodem", isi->idx);
+	ofono_ussd_create(isi->modem, 0, "isimodem", isi->idx);
+	ofono_call_forwarding_create(isi->modem, 0, "isimodem", isi->idx);
+	ofono_call_settings_create(isi->modem, 0, "isimodem", isi->idx);
+	ofono_call_barring_create(isi->modem, 0, "isimodem", isi->idx);
+	ofono_call_meter_create(isi->modem, 0, "isimodem", isi->idx);
+	ofono_radio_settings_create(isi->modem, 0, "isimodem", isi->idx);
+	gprs =3D ofono_gprs_create(isi->modem, 0, "isimodem", isi->idx);
+	gc =3D ofono_gprs_context_create(isi->modem, 0, "isimodem", isi->idx);
+
+	if (gprs && gc)
+		ofono_gprs_add_context(gprs, gc);
+	else
+		DBG("Failed to add context");
+}
+
+static int n900_modem_enable(struct ofono_modem *modem)
+{
+	struct isi_data *isi =3D ofono_modem_get_data(modem);
+	DBG("modem=3D%p with %p", modem, isi ? isi->ifname : NULL);
+	return n900_gpio_enable(modem);
+}
+
+static int n900_modem_disable(struct ofono_modem *modem)
+{
+	struct isi_data *isi =3D ofono_modem_get_data(modem);
+	DBG("modem=3D%p with %p", modem, isi ? isi->ifname : NULL);
+	return n900_gpio_disable(modem);
+}
+
+static struct ofono_modem_driver driver =3D {
+	.name =3D "n900",
+	.probe =3D n900_modem_probe,
+	.remove =3D n900_modem_remove,
+	.enable =3D n900_modem_enable,
+	.disable =3D n900_modem_disable,
+	.set_online =3D n900_modem_set_online,
+	.pre_sim =3D n900_modem_pre_sim,
+	.post_sim =3D n900_modem_post_sim,
+	.post_online =3D n900_modem_post_online,
+};
+
+/*
+ * Plug in n900 modem when phonet* phonet interface is added/removed
+ *
+ * Note: this functions assumes the kernel does not configure the
+ * interface and the phonet routes. It also depends on kernel using
+ * magic interface name phonet0 for the hsi link to the modem.
+ */
+static void phonet_status_cb(GIsiModem *idx,
+				GPhonetLinkState st,
+				char const ifname[],
+				void *data)
+{
+	struct ofono_modem *modem;
+	int error;
+
+	DBG("Phonet link %s (%u) is %s",
+		ifname, g_isi_modem_index(idx),
+		st =3D=3D PN_LINK_REMOVED ? "removed" :
+		st =3D=3D PN_LINK_DOWN ? "down" : "up");
+
+	if (strcmp("phonet0", ifname))
+		return;
+
+	if (st =3D=3D PN_LINK_REMOVED)
+		return;
+
+	if (g_pn_netlink_by_modem(idx)) {
+		DBG("Modem for interface %s already exists", ifname);
+		return;
+	}
+
+	error =3D g_pn_netlink_set_address(idx, PN_DEV_SOS);
+	if (error && error !=3D -EEXIST) {
+		DBG("g_pn_netlink_set_address: %s\n", strerror(-error));
+		return;
+	}
+
+	g_pn_netlink_add_route(idx, PN_DEV_HOST);
+
+	modem =3D ofono_modem_create("n900", "n900");
+	if (!modem)
+		return;
+
+	ofono_modem_set_string(modem, "Interface", ifname);
+
+	if (ofono_modem_register(modem) =3D=3D 0)
+		DBG("Done regging modem %s", ofono_modem_get_path(modem));
+	else
+		ofono_modem_remove(modem);
+}
+
+static GPhonetNetlink *link;
+
+static int n900modem_init(void)
+{
+	ofono_modem_driver_register(&driver);
+
+	link =3D g_pn_netlink_start(NULL, phonet_status_cb, NULL);
+
+	return 0;
+}
+
+static void n900modem_exit(void)
+{
+	g_pn_netlink_stop(link);
+	link =3D NULL;
+
+	ofono_modem_driver_unregister(&driver);
+}
+
+OFONO_PLUGIN_DEFINE(n900, "Nokia N900 modem driver", VERSION,
+		OFONO_PLUGIN_PRIORITY_DEFAULT, n900modem_init, n900modem_exit)
diff --git a/plugins/n900gpio.c b/plugins/n900gpio.c
new file mode 100644
index 0000000..9951c4c
--- /dev/null
+++ b/plugins/n900gpio.c
@@ -0,0 +1,796 @@
+/*
+ * This file is part of oFono - Open Source Telephony
+ *
+ * Copyright (C) 2010 Nokia Corporation and/or its subsidiary(-ies).
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * version 2 as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA
+ * 02110-1301 USA
+ *
+ */
+
+#ifdef HAVE_CONFIG_H
+#include <config.h>
+#endif
+
+#include <stdio.h>
+#include <stdint.h>
+#include <string.h>
+#include <errno.h>
+
+#include <unistd.h>
+#include <dirent.h>
+#include <sys/types.h>
+#include <sys/stat.h>
+
+#include <gisi/netlink.h>
+#include <glib.h>
+
+#define OFONO_API_SUBJECT_TO_CHANGE
+#include <ofono/plugin.h>
+#include <ofono/modem.h>
+#include <ofono/log.h>
+
+#include <drivers/isimodem/debug.h>
+#include "n900gpio.h"
+
+#define GPIO_SWITCH	"/sys/devices/platform/gpio-switch"
+#define DEV_CMT		"/dev/cmt"
+
+enum rapu_type {
+	RAPU1, RAPU2
+};
+
+enum {
+	RESET_RETRIES =3D 5,
+	POWER_ON_RETRIES =3D 10
+};
+
+enum phonet_state {
+	PHONET_LINK_NONE =3D 0,
+	PHONET_LINK_DOWN,
+	PHONET_LINK_UP,
+};
+
+enum gpio_power_event {
+	PHONET_LINK_UP_EVENT =3D 1,
+	PHONET_LINK_DOWN_EVENT,
+
+	POWER_ON_EVENT,
+
+	POWER_ON_TIMEOUT_EVENT,
+	POWER_REBOOT_TIMEOUT_EVENT,
+
+	POWER_OFF_EVENT,
+	POWER_OFF_IMMEDIATELY_EVENT,
+
+	POWER_OFF_TIMEOUT_EVENT,
+	POWER_OFF_COMPLETE_EVENT,
+};
+
+struct n900_gpio {
+	GPhonetNetlink *link;
+
+	n900_gpio_callback *callback;
+	void *data;
+
+	enum n900_power_state state;
+
+	enum phonet_state current, target;
+
+	unsigned retries;
+
+	enum gpio_power_event timer_event;
+	guint timeout;
+	guint pollout;
+
+	enum rapu_type rapu;
+
+	unsigned have_gpio_switch:1;
+	unsigned have_cmt_en:1;
+	unsigned have_cmt_rst_rq:1;
+	unsigned have_cmt_rst:1;
+	unsigned have_cmt_bsi:1;
+	unsigned have_cmt_apeslpx:1;
+
+	unsigned reset_in_progress:1;
+	unsigned startup_in_progress:1;
+} self;
+
+#define _(X) case X: return #X
+
+static inline char const *gpio_power_event_name(enum gpio_power_event valu=
e)
+{
+	switch (value) {
+		_(PHONET_LINK_UP_EVENT);
+		_(PHONET_LINK_DOWN_EVENT);
+		_(POWER_ON_EVENT);
+		_(POWER_ON_TIMEOUT_EVENT);
+		_(POWER_REBOOT_TIMEOUT_EVENT);
+		_(POWER_OFF_EVENT);
+		_(POWER_OFF_IMMEDIATELY_EVENT);
+		_(POWER_OFF_TIMEOUT_EVENT);
+		_(POWER_OFF_COMPLETE_EVENT);
+	}
+	return "<UNKNOWN>";
+}
+
+char const *n900_power_state_name(enum n900_power_state value)
+{
+	switch (value) {
+		_(POWER_NONE_STATE);
+		_(POWER_ON_STARTED_STATE);
+		_(POWER_ON_STATE);
+		_(POWER_ON_RESET_STATE);
+		_(POWER_ON_FAILED_STATE);
+		_(POWER_OFF_STARTED_STATE);
+		_(POWER_OFF_WAITING_STATE);
+		_(POWER_OFF_STATE);
+	}
+	return "<UNKNOWN>";
+}
+
+#undef _
+
+static void gpio_power_state_machine(enum gpio_power_event event);
+static void gpio_power_set_state(enum n900_power_state new_state);
+
+static int file_exists(char const *filename)
+{
+	struct stat st;
+
+	return stat(filename, &st) =3D=3D 0;
+}
+
+static int dir_exists(char const *filename)
+{
+	struct stat st;
+
+	return stat(filename, &st) =3D=3D 0 && S_ISDIR(st.st_mode);
+}
+
+static int file_write(char const *filename, char const *output)
+{
+	FILE *f;
+
+	f =3D fopen(filename, "r+");
+	if (!f) {
+		DBG("%s: %s (%d)", filename, strerror(errno), errno);
+		return -1;
+	}
+
+	fputs(output, f);
+
+	return fclose(f);
+}
+
+static int gpio_write(char *line, int value)
+{
+	char filename[256];
+
+	DBG("(\"%s\", \"%s\")", line, value ? "active" : "inactive");
+
+	if (self.have_gpio_switch) {
+		snprintf(filename, sizeof filename, "%s/%s/%s",
+				GPIO_SWITCH, line, "state");
+		return file_write(filename, value ? "active" : "inactive");
+	} else {
+		snprintf(filename, sizeof filename, "%s/%s/%s",
+				DEV_CMT, line, "value");
+		return file_write(filename, value ? "1" : "0");
+	}
+}
+
+#define GPIO_WRITE(line, value) \
+	(self.have_ ## line ? gpio_write(#line, value) : 0)
+
+static int gpio_probe(char const *line)
+{
+	char filename[256];
+	int result;
+
+	if (self.have_gpio_switch)
+		snprintf(filename, sizeof filename,
+				"%s/%s/state", GPIO_SWITCH, line);
+	else
+		snprintf(filename, sizeof filename,
+				"%s/%s/value", DEV_CMT, line);
+
+	result =3D file_exists(filename);
+
+	DBG("%s: %s", line, result ? "found" : "not found");
+
+	return result;
+}
+
+/*
+ * Modem start up function
+ * Sets all lines down and leaves "power key" pressed
+ * (power key must be released after some time)
+ */
+static void gpio_start_modem_power_on(void)
+{
+	DBG("");
+
+	if (self.startup_in_progress)
+		return;
+	self.startup_in_progress =3D 1;
+
+	GPIO_WRITE(cmt_apeslpx, 0);	/* skip flash mode */
+	GPIO_WRITE(cmt_rst_rq, 0);	/* prevent current drain */
+
+	switch (self.rapu) {
+	case RAPU2:
+		GPIO_WRITE(cmt_en, 0);
+		/* 15 ms needed for ASIC poweroff */
+		usleep(20000);
+		GPIO_WRITE(cmt_en, 1);
+		break;
+
+	case RAPU1:
+		/* toggle BSI visible to CMT */
+		GPIO_WRITE(cmt_bsi, 0);
+		GPIO_WRITE(cmt_rst, 0);	/* Assert PURX */
+		GPIO_WRITE(cmt_en, 1);	/* Press "power key" */
+		GPIO_WRITE(cmt_rst, 1);	/* Release CMT to boot */
+		break;
+	}
+
+	GPIO_WRITE(cmt_rst_rq, 1);
+}
+
+static void gpio_finish_modem_power_on(void)
+{
+	DBG("");
+
+	if (!self.startup_in_progress)
+		return;
+	self.startup_in_progress =3D 0;
+
+	switch (self.rapu) {
+	case RAPU2:
+		break;
+
+	case RAPU1:
+		GPIO_WRITE(cmt_en, 0);	/* release "power key" */
+		break;
+	}
+}
+
+static void gpio_start_modem_reset(void)
+{
+	DBG("");
+
+	if (self.reset_in_progress)
+		return;
+	self.reset_in_progress =3D 1;
+
+	if (self.have_cmt_rst_rq) {
+		GPIO_WRITE(cmt_rst_rq, 0); /* Just in case */
+		GPIO_WRITE(cmt_rst_rq, 1);
+	} else
+		gpio_start_modem_power_on();
+}
+
+static void gpio_finish_modem_reset(void)
+{
+	DBG("");
+
+	if (!self.reset_in_progress)
+		return;
+	self.reset_in_progress =3D 0;
+	gpio_finish_modem_power_on();
+}
+
+static void gpio_finish_modem_power_off(void)
+{
+	DBG("");
+
+	if (self.reset_in_progress)
+		gpio_finish_modem_reset();
+	if (self.startup_in_progress)
+		gpio_finish_modem_power_on();
+
+	GPIO_WRITE(cmt_apeslpx, 0);	/* skip flash mode */
+	GPIO_WRITE(cmt_rst_rq, 0);	/* prevent current drain */
+
+	switch (self.rapu) {
+	case RAPU2:
+		GPIO_WRITE(cmt_en, 0);	/* Power off */
+		break;
+
+	case RAPU1:
+		GPIO_WRITE(cmt_rst, 0);	/* force CMT to reset state */
+		GPIO_WRITE(cmt_en, 0);	/* release "power key" */
+		GPIO_WRITE(cmt_rst, 1);	/* release CMT to be powered
+							off by bootloader */
+		break;
+	}
+}
+
+static gboolean gpio_power_timer_cb(gpointer user)
+{
+	self.timeout =3D 0;
+
+	if (self.timer_event)
+		gpio_power_state_machine(self.timer_event);
+
+	return FALSE;
+}
+
+
+static void gpio_power_state_machine(enum gpio_power_event event)
+{
+	enum n900_power_state new_state;
+
+	DBG("(%s) @ state %s",
+		gpio_power_event_name(event),
+		n900_power_state_name(self.state));
+
+	switch (event) {
+	case POWER_ON_EVENT:
+		self.target =3D PHONET_LINK_UP;
+
+		if (self.current =3D=3D PHONET_LINK_NONE)
+			return;
+
+		switch (self.state) {
+		case POWER_ON_STARTED_STATE:
+		case POWER_ON_RESET_STATE:
+		case POWER_ON_STATE:
+			/* Do nothing */
+			break;
+		case POWER_OFF_STARTED_STATE:
+			/* Do nothing */
+			break;
+		case POWER_NONE_STATE:
+		case POWER_OFF_WAITING_STATE:
+		case POWER_OFF_STATE:
+		case POWER_ON_FAILED_STATE:
+			gpio_power_set_state(POWER_ON_STARTED_STATE);
+			break;
+		}
+		return;
+
+	case PHONET_LINK_DOWN_EVENT:
+		switch (self.target) {
+		case PHONET_LINK_DOWN:
+		case PHONET_LINK_NONE:
+		default:
+			if (self.state =3D=3D POWER_OFF_STATE ||
+				self.state =3D=3D POWER_NONE_STATE)
+				new_state =3D POWER_OFF_STATE;
+			else
+				new_state =3D POWER_OFF_WAITING_STATE;
+			gpio_power_set_state(new_state);
+			return;
+		case PHONET_LINK_UP:
+			break;
+		}
+
+		switch (self.state) {
+		case POWER_NONE_STATE:
+			/* first connection down event =3D> start modem */
+			gpio_power_set_state(POWER_ON_STARTED_STATE);
+			break;
+
+		case POWER_ON_STARTED_STATE:
+		case POWER_ON_RESET_STATE:
+			break;
+
+		default:
+			self.retries =3D 0;
+			gpio_power_set_state(POWER_ON_RESET_STATE);
+			break;
+		}
+		return;
+
+	case POWER_ON_TIMEOUT_EVENT:
+		if (self.target =3D=3D PHONET_LINK_DOWN)
+			new_state =3D POWER_OFF_STARTED_STATE;
+		else if (self.retries <=3D POWER_ON_RETRIES)
+			new_state =3D POWER_ON_STARTED_STATE;
+		else
+			new_state =3D POWER_ON_FAILED_STATE;
+		gpio_power_set_state(new_state);
+		return;
+
+	case POWER_REBOOT_TIMEOUT_EVENT:
+		/* Modem is not rebooting itself - try to powercycle it */
+		if (self.target =3D=3D PHONET_LINK_DOWN)
+			new_state =3D POWER_OFF_STARTED_STATE;
+		else if (self.retries <=3D RESET_RETRIES)
+			new_state =3D POWER_ON_RESET_STATE;
+		else
+			new_state =3D POWER_ON_STARTED_STATE;
+		gpio_power_set_state(new_state);
+		return;
+
+	case PHONET_LINK_UP_EVENT:
+		switch (self.state) {
+		case POWER_NONE_STATE:
+			return;
+
+		case POWER_ON_STARTED_STATE:
+		case POWER_ON_RESET_STATE:
+			break;
+
+		case POWER_ON_STATE:
+			return;
+
+		case POWER_OFF_STARTED_STATE:
+		case POWER_OFF_WAITING_STATE:
+		case POWER_OFF_STATE:
+		case POWER_ON_FAILED_STATE:
+			DBG("LINK_UP event while "
+				"modem should be powered off");
+			/* should never come here */
+			break;
+		}
+		if (self.target =3D=3D PHONET_LINK_DOWN)
+			gpio_power_set_state(POWER_OFF_STARTED_STATE);
+		else
+			gpio_power_set_state(POWER_ON_STATE);
+		return;
+
+	case POWER_OFF_EVENT:
+		self.target =3D PHONET_LINK_DOWN;
+
+		switch (self.state) {
+		case POWER_ON_STARTED_STATE:
+		case POWER_ON_RESET_STATE:
+			/* Do nothing until a timer expires */
+			break;
+		case POWER_ON_STATE:
+			gpio_power_set_state(POWER_OFF_STARTED_STATE);
+			break;
+		case POWER_OFF_STARTED_STATE:
+		case POWER_OFF_WAITING_STATE:
+		case POWER_OFF_STATE:
+			/* Do nothing */
+			break;
+		case POWER_NONE_STATE:
+		case POWER_ON_FAILED_STATE:
+			gpio_power_set_state(POWER_OFF_STATE);
+			break;
+		}
+		return;
+
+	case POWER_OFF_IMMEDIATELY_EVENT:
+		gpio_power_set_state(POWER_OFF_STATE);
+		return;
+
+	case POWER_OFF_TIMEOUT_EVENT:
+		DBG("CMT power off timed out");
+		gpio_power_set_state(POWER_OFF_STATE);
+		return;
+
+	case POWER_OFF_COMPLETE_EVENT:
+		if (self.state =3D=3D POWER_OFF_WAITING_STATE) {
+			DBG("Modem shutdown complete");
+			gpio_power_set_state(POWER_OFF_STATE);
+		}
+		return;
+	}
+
+	DBG("Event %s (%d) not handled", gpio_power_event_name(event), event);
+}
+
+
+static void gpio_power_set_state(enum n900_power_state new_state)
+{
+	enum n900_power_state old_state =3D self.state;
+	unsigned timeout =3D 0;
+	enum gpio_power_event timer_event;
+
+	DBG("(%s)@(%s)%s",
+		n900_power_state_name(new_state),
+		n900_power_state_name(old_state),
+		new_state =3D=3D old_state ? " - already" : "");
+
+	switch (old_state) {
+	case POWER_ON_STARTED_STATE:
+		gpio_finish_modem_power_on();
+		break;
+	case POWER_ON_RESET_STATE:
+		gpio_finish_modem_reset();
+		break;
+	default:
+		break;
+	}
+
+	if (self.timeout) {
+		g_source_remove(self.timeout), self.timeout =3D 0;
+		self.timer_event =3D 0;
+	}
+
+	if (old_state =3D=3D new_state &&
+		new_state !=3D POWER_ON_STARTED_STATE &&
+		new_state !=3D POWER_ON_RESET_STATE)
+		return;
+
+	switch (self.state =3D new_state) {
+	case POWER_NONE_STATE:
+		break;
+
+	case POWER_ON_STARTED_STATE:
+		self.retries++;
+		/* Maximum time modem power on procedure on can take */
+		timeout =3D 5000;
+		timer_event =3D POWER_ON_TIMEOUT_EVENT;
+		gpio_start_modem_power_on();
+		break;
+
+	case POWER_ON_RESET_STATE:
+		DBG("Starting modem restart timeout");
+		/* Time allowed for CMT to restart after crash */
+		timeout =3D 5000;
+		timer_event =3D POWER_REBOOT_TIMEOUT_EVENT;
+		if (self.retries++ > 0)
+			gpio_start_modem_reset();
+		break;
+
+	case POWER_ON_STATE:
+		DBG("Power on");
+		self.retries =3D 0;
+		break;
+
+	case POWER_OFF_STARTED_STATE:
+		DBG("Starting power off");
+		/* Maximum time modem power_off can take */
+		timeout =3D 6150;
+		timer_event =3D POWER_OFF_TIMEOUT_EVENT;
+		break;
+
+	case POWER_OFF_WAITING_STATE:
+		gpio_finish_modem_power_off();
+		DBG("Waiting to modem to settle down");
+		/* Cooling time after power off */
+		timeout =3D 1000;
+		timer_event =3D POWER_OFF_COMPLETE_EVENT;
+		break;
+
+	case POWER_OFF_STATE:
+		if (old_state !=3D POWER_OFF_WAITING_STATE &&
+			old_state !=3D POWER_ON_FAILED_STATE)
+			gpio_finish_modem_power_off();
+		break;
+
+	case POWER_ON_FAILED_STATE:
+		DBG("Link to modem cannot be established, giving up");
+		gpio_finish_modem_power_off();
+		break;
+	}
+
+	if (timeout) {
+		self.timer_event =3D timer_event;
+		self.timeout =3D g_timeout_add(timeout,
+					gpio_power_timer_cb, NULL);
+	}
+
+	self.callback(new_state, self.data);
+}
+
+static void phonet_status_cb(GIsiModem *idx,
+				GPhonetLinkState st,
+				char const *ifname,
+				void *dummy)
+{
+	DBG("Link %s (%u) is %s",
+		ifname, g_isi_modem_index(idx),
+		st =3D=3D PN_LINK_REMOVED ? "removed" :
+		st =3D=3D PN_LINK_DOWN ? "down" : "up");
+
+	(void)dummy;
+
+	if (st =3D=3D PN_LINK_UP) {
+		if (self.current =3D=3D PHONET_LINK_UP)
+			return;
+		self.current =3D PHONET_LINK_UP;
+
+		/* link is up - we can lower cmt_rst_rq */
+		GPIO_WRITE(cmt_rst_rq, 0);
+
+		gpio_power_state_machine(PHONET_LINK_UP_EVENT);
+	} else {
+		if (self.current =3D=3D PHONET_LINK_DOWN)
+			return;
+		self.current =3D PHONET_LINK_DOWN;
+
+		gpio_power_state_machine(PHONET_LINK_DOWN_EVENT);
+	}
+}
+
+static int gpio_probe_links(void)
+{
+	char const *gpiodir =3D "/sys/class/gpio";
+	char const *cmtdir =3D "/dev/cmt";
+	DIR *gpio;
+	struct dirent *d, entry[1];
+
+	if (file_exists(cmtdir)) {
+		DBG("Using %s", cmtdir);
+		return 0;
+	}
+
+	DBG("Using %s: trying to make links to %s", gpiodir, cmtdir);
+
+	if (!dir_exists(cmtdir)) {
+		if (mkdir(cmtdir, 0755) =3D=3D -1) {
+			DBG("%s: %s", cmtdir, strerror(errno));
+			return -(errno =3D ENODEV);
+		}
+	}
+
+	gpio =3D opendir(gpiodir);
+	if (gpio =3D=3D NULL) {
+		DBG("%s: %s", "gpiodir", strerror(errno));
+		return -(errno =3D ENODEV);
+	}
+
+	while (readdir_r(gpio, entry, &d) =3D=3D 0) {
+		char nn[PATH_MAX], name[PATH_MAX], from[PATH_MAX], to[PATH_MAX];
+		FILE *nf;
+		size_t len;
+
+		if (d =3D=3D NULL)
+			return 0;
+
+		snprintf(nn, sizeof nn, "%s/%s/name", gpiodir, d->d_name);
+
+		nf =3D fopen(nn, "rb");
+		if (nf =3D=3D NULL) {
+			DBG("%s: %s", nn, strerror(errno));
+			continue;
+		}
+
+		len =3D fread(name, sizeof name, 1, nf);
+
+		if (ferror(nf)) {
+			DBG("read from %s: %s", nn, strerror(errno));
+			fclose(nf);
+			continue;
+		}
+
+		fclose(nf);
+
+		if (len < 4)
+			continue;
+
+		name[--len] =3D '\0';
+
+		if (strncmp(name, "cmt_", 4))
+			continue;
+
+		snprintf(from, sizeof from, "%s/%s", gpiodir, d->d_name);
+		snprintf(to, sizeof to, "%s/%s", cmtdir, name);
+
+		if (symlink(from, to) =3D=3D -1)
+			DBG("%s: %s", to, strerror(errno));
+	}
+
+	DBG("%s: %s", "/sys/class/gpio", strerror(errno));
+
+	return -(errno =3D ENODEV);
+}
+
+
+int n900_gpio_probe(GIsiModem *idx, n900_gpio_callback *callback, void *da=
ta)
+{
+	int error;
+
+	if (callback =3D=3D NULL) {
+		DBG("n900_gpio: %s", "no callback");
+		return -(errno =3D EFAULT);
+	}
+
+	if (self.callback) {
+		DBG("n900_gpio: %s", strerror(EBUSY));
+		return -(errno =3D EBUSY);
+	}
+
+	if (g_pn_netlink_by_modem(idx)) {
+		DBG("Phonet link %p: %s", idx, strerror(EBUSY));
+		return -(errno =3D EBUSY);
+	}
+
+	self.target =3D PHONET_LINK_NONE;
+	self.have_gpio_switch =3D file_exists(GPIO_SWITCH);
+
+	if (self.have_gpio_switch) {
+		DBG("Using GPIO switch");
+	} else {
+		error =3D gpio_probe_links();
+		if (error)
+			return error;
+	}
+
+	/* GPIO lines availability depends on HW and SW versions */
+	self.have_cmt_en =3D gpio_probe("cmt_en");
+	self.have_cmt_rst_rq =3D gpio_probe("cmt_rst_rq");
+	self.have_cmt_rst =3D gpio_probe("cmt_rst");
+	self.have_cmt_bsi =3D gpio_probe("cmt_bsi");
+	self.have_cmt_apeslpx =3D gpio_probe("cmt_apeslpx");
+
+	if (!self.have_cmt_en) {
+		DBG("Modem control GPIO lines are not available");
+		memset(&self, 0, sizeof self);
+		return -(errno =3D ENODEV);
+	}
+
+	if (self.have_cmt_bsi)
+		self.rapu =3D RAPU1;
+	else
+		self.rapu =3D RAPU2;
+
+	self.link =3D g_pn_netlink_start(idx, phonet_status_cb, NULL);
+	if (!self.link) {
+		memset(&self, 0, sizeof self);
+		return -errno;
+	}
+
+	self.callback =3D callback;
+	self.data =3D data;
+
+	error =3D g_pn_netlink_set_address(idx, PN_DEV_SOS);
+	if (error && error !=3D -EEXIST)
+		DBG("g_pn_netlink_set_address: %s\n", strerror(-error));
+
+	error =3D g_pn_netlink_add_route(idx, PN_DEV_HOST);
+	if (error && error !=3D -ENOTSUP)	/* We get ENOTSUP on Maemo 5 kernel */
+		DBG("g_pn_netlink_add_route: %s\n", strerror(-error));
+
+	return 0;
+}
+
+int n900_gpio_remove(void *data)
+{
+	if (self.data !=3D data)
+		return -EINVAL;
+
+	if (self.link)
+		g_pn_netlink_stop(self.link);
+	if (self.timeout)
+		g_source_remove(self.timeout), self.timeout =3D 0;
+
+	memset(&self, 0, sizeof self);
+
+	return 0;
+}
+
+int n900_gpio_enable(void *data)
+{
+	if (self.data !=3D data)
+		return -EINVAL;
+
+	if (self.state =3D=3D POWER_ON_STATE)
+		return 0;
+
+	gpio_power_state_machine(POWER_ON_EVENT);
+
+	return -EINPROGRESS;
+}
+
+int n900_gpio_disable(void *data)
+{
+	if (self.data !=3D data)
+		return -EINVAL;
+
+	if (self.state =3D=3D POWER_OFF_STATE ||
+		self.state =3D=3D POWER_ON_FAILED_STATE)
+		return 0;
+
+	gpio_power_state_machine(POWER_OFF_EVENT);
+
+	return -EINPROGRESS;
+}
diff --git a/plugins/n900gpio.h b/plugins/n900gpio.h
new file mode 100644
index 0000000..27be134
--- /dev/null
+++ b/plugins/n900gpio.h
@@ -0,0 +1,54 @@
+/*
+ * This file is part of oFono - Open Source Telephony
+ *
+ * Copyright (C) 2010 Nokia Corporation and/or its subsidiary(-ies).
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * version 2 as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA
+ * 02110-1301 USA
+ *
+ */
+
+#ifndef __N900_GPIO_H
+#define __N900_GPIO_H
+
+#ifdef __cplusplus
+extern "C" {
+#endif
+
+enum n900_power_state {
+	POWER_NONE_STATE,
+
+	POWER_ON_STARTED_STATE,
+	POWER_ON_STATE,
+	POWER_ON_RESET_STATE,
+	POWER_ON_FAILED_STATE,
+	POWER_OFF_STARTED_STATE,
+	POWER_OFF_WAITING_STATE,
+	POWER_OFF_STATE,
+};
+
+typedef void n900_gpio_callback(enum n900_power_state, void *opaque);
+
+int n900_gpio_probe(GIsiModem *idx, n900_gpio_callback *callback, void *da=
ta);
+int n900_gpio_enable(void *opaque);
+int n900_gpio_disable(void *opaque);
+int n900_gpio_remove(void *opaque);
+
+char const *n900_power_state_name(enum n900_power_state value);
+
+#ifdef __cplusplus
+};
+#endif
+
+#endif /* __N900_GPIO_H */
-- =

1.7.0.4


--===============3983234163037080999==--

