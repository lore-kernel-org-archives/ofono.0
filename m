Content-Type: multipart/mixed; boundary="===============1882815757485748186=="
MIME-Version: 1.0
From: Pekka.Pessi@nokia.com
Subject: [n900 PATCH 2/5] isigen: generic modem driver plugin for isimodems
Date: Wed, 15 Sep 2010 19:59:31 +0300
Message-ID: <1284569974-22505-3-git-send-email-Pekka.Pessi@nokia.com>
In-Reply-To: <1284569974-22505-2-git-send-email-Pekka.Pessi@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1882815757485748186==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Pekka Pessi <ppessi@hamsa.research.nokia.com>

The new isigen modem driver replaces the uspnmodem plugin and the
generic isimodem driver.
---
 Makefile.am          |    8 +-
 plugins/isigen.c     |  518 ++++++++++++++++++++++++++++++++++++++++++++++=
++++
 plugins/usbpnmodem.c |  104 ----------
 3 files changed, 522 insertions(+), 108 deletions(-)
 create mode 100644 plugins/isigen.c
 delete mode 100644 plugins/usbpnmodem.c

diff --git a/Makefile.am b/Makefile.am
index 79ef4e4..aca5d1b 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -128,14 +128,14 @@ isimodem_sources =3D $(gisi_sources) \
 				drivers/isimodem/gprs-context.c \
 				drivers/isimodem/gpds.h
 =

-usbpn_sources =3D plugins/usbpnmodem.c
+isigen_sources =3D plugins/isigen.c
 =

 if ISIMODEM
 builtin_modules +=3D isimodem
 builtin_sources +=3D $(isimodem_sources)
 =

-builtin_modules +=3D usbpnmodem
-builtin_sources +=3D $(usbpn_sources)
+builtin_modules +=3D isigen
+builtin_sources +=3D $(isigen_sources)
 endif
 =

 if ATMODEM
@@ -382,7 +382,7 @@ conf_files =3D src/ofono.conf plugins/modem.conf
 =

 EXTRA_DIST =3D src/genbuiltin plugins/example_history.c $(doc_files) \
 				$(isimodem_sources) \
-				$(usbpn_sources) \
+				$(isigen_sources) \
 				$(test_scripts) $(conf_files) $(udev_files)
 =

 dist_man_MANS =3D doc/ofonod.8
diff --git a/plugins/isigen.c b/plugins/isigen.c
new file mode 100644
index 0000000..1439a49
--- /dev/null
+++ b/plugins/isigen.c
@@ -0,0 +1,518 @@
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
+#include "drivers/isimodem/mtc.h"
+#include "drivers/isimodem/debug.h"
+
+struct isi_data {
+	struct ofono_modem *modem;
+	char const *ifname;
+	GIsiModem *idx;
+	GIsiClient *client;
+	GPhonetNetlink *link;
+	GPhonetLinkState linkstate;
+	unsigned interval;
+	int reported;
+	ofono_bool_t online;
+	struct isi_cb_data *online_cbd;
+};
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
+static void mtc_state_ind_cb(GIsiClient *client,
+				const void *restrict data, size_t len,
+				uint16_t object, void *opaque)
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
+	} else if (msg[2] =3D=3D MTC_READY) {
+		DBG("current modem state: %s (0x%02X)",
+			mtc_modem_state_name(msg[1]), msg[1]);
+		set_power_by_mtc_state(isi, msg[1]);
+	}
+}
+
+static gboolean mtc_poll_query_cb(GIsiClient *client,
+					const void *restrict data, size_t len,
+					uint16_t object, void *opaque)
+{
+	const unsigned char *msg =3D data;
+	struct isi_data *isi =3D opaque;
+
+	if (!msg) {
+		const unsigned char req[] =3D {
+			MTC_STATE_QUERY_REQ, 0x00, 0x00
+		};
+
+		if (isi->linkstate !=3D PN_LINK_UP)
+			return TRUE;
+
+		isi->interval *=3D 2;
+		if (isi->interval >=3D 20)
+			isi->interval =3D 20;
+
+		g_isi_request_make(client, req, sizeof(req),
+					isi->interval,
+					mtc_poll_query_cb, opaque);
+
+		return TRUE;
+	}
+
+	if (len < 3 || msg[0] !=3D MTC_STATE_QUERY_RESP)
+		return FALSE;
+
+	g_isi_subscribe(client, MTC_STATE_INFO_IND, mtc_state_ind_cb, opaque);
+
+	DBG("current modem state: %s (0x%02X)",
+		mtc_modem_state_name(msg[1]), msg[1]);
+	DBG("target modem state: %s (0x%02X)",
+		mtc_modem_state_name(msg[2]), msg[2]);
+
+	if (msg[1] =3D=3D msg[2])
+		set_power_by_mtc_state(isi, msg[1]);
+
+	return TRUE;
+}
+
+static gboolean mtc_query_cb(GIsiClient *client,
+				const void *restrict data, size_t len,
+				uint16_t object, void *opaque)
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
+	if (msg[1] =3D=3D msg[2])
+		set_power_by_mtc_state(isi, msg[1]);
+
+	return TRUE;
+}
+
+static void reachable_cb(GIsiClient *client, gboolean alive, uint16_t obje=
ct,
+				void *opaque)
+{
+	struct isi_data *isi =3D opaque;
+
+	const unsigned char msg[] =3D {
+		MTC_STATE_QUERY_REQ,
+		0x00, 0x00 /* Filler */
+	};
+
+	if (!alive) {
+		DBG("MTC client: %s", strerror(-g_isi_client_error(client)));
+
+		if (isi->linkstate =3D=3D PN_LINK_UP)
+			g_isi_request_make(client, msg, sizeof(msg),
+						isi->interval =3D MTC_TIMEOUT,
+						mtc_poll_query_cb, opaque);
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
+				mtc_query_cb, opaque);
+}
+
+static void phonet_status_cb(GIsiModem *idx,
+				GPhonetLinkState st,
+				char const *ifname,
+				void *data)
+{
+	struct ofono_modem *modem =3D data;
+	struct isi_data *isi =3D ofono_modem_get_data(modem);
+
+	DBG("Link %s (%u) is %s",
+		isi->ifname, g_isi_modem_index(isi->idx),
+		st =3D=3D PN_LINK_REMOVED ? "removed" :
+		st =3D=3D PN_LINK_DOWN ? "down" : "up");
+
+	isi->linkstate =3D st;
+
+	if (st =3D=3D PN_LINK_UP)
+		g_isi_verify(isi->client, reachable_cb, isi);
+	else if (st =3D=3D PN_LINK_DOWN)
+		set_power_by_mtc_state(isi, MTC_STATE_NONE);
+	else if (st =3D=3D PN_LINK_REMOVED)
+		ofono_modem_remove(modem);
+}
+
+static int isigen_probe(struct ofono_modem *modem)
+{
+	struct isi_data *isi;
+	char const *ifname =3D ofono_modem_get_string(modem, "Interface");
+	GIsiModem *idx;
+	GPhonetNetlink *link;
+
+	if (ifname =3D=3D NULL)
+		return -EINVAL;
+
+	DBG("(%p) with %s", modem, ifname);
+
+	idx =3D g_isi_modem_by_name(ifname);
+	if (idx =3D=3D NULL) {
+		DBG("Interface=3D%s: %s", ifname, strerror(errno));
+		return -errno;
+	}
+
+	if (g_pn_netlink_by_modem(idx)) {
+		DBG("%s: %s", ifname, strerror(EBUSY));
+		return -EBUSY;
+	}
+
+	link =3D g_pn_netlink_start(idx, phonet_status_cb, modem);
+	if (!link) {
+		DBG("%s: %s", ifname, strerror(errno));
+		return -errno;
+	}
+
+	isi =3D g_new0(struct isi_data, 1);
+	if (isi =3D=3D NULL)
+		return -ENOMEM;
+
+	ofono_modem_set_data(isi->modem =3D modem, isi);
+
+	isi->idx =3D idx;
+	isi->ifname =3D ifname;
+	isi->link =3D link;
+	isi->client =3D g_isi_client_create(isi->idx, PN_MTC);
+	isi->reported =3D -1;
+
+	return 0;
+}
+
+static void isigen_remove(struct ofono_modem *modem)
+{
+	struct isi_data *isi =3D ofono_modem_get_data(modem);
+
+	if (!isi)
+		return;
+
+	ofono_modem_set_data(modem, NULL);
+	g_isi_client_destroy(isi->client);
+	g_pn_netlink_stop(isi->link);
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
+static void isigen_online(struct ofono_modem *modem, ofono_bool_t online,
+				ofono_modem_online_cb_t cb, void *data)
+{
+	struct isi_data *isi =3D ofono_modem_get_data(modem);
+	const unsigned char req[] =3D {
+		MTC_STATE_REQ, online ? MTC_NORMAL : MTC_RF_INACTIVE, 0x00
+	};
+	struct isi_cb_data *cbd =3D isi_cb_data_new(modem, cb, data);
+
+	DBG("(%p) with %s", modem, isi->ifname);
+
+	if (!cbd)
+		goto error;
+
+	isi->online =3D online;
+
+	if (g_isi_request_make(isi->client, req, sizeof(req), MTC_TIMEOUT,
+				mtc_state_cb, cbd))
+		return;
+
+error:
+	g_free(cbd);
+	CALLBACK_WITH_FAILURE(cb, data);
+}
+
+static void isigen_pre_sim(struct ofono_modem *modem)
+{
+	struct isi_data *isi =3D ofono_modem_get_data(modem);
+
+	DBG("(%p) with %s", modem, isi->ifname);
+
+	ofono_sim_create(isi->modem, 0, "isimodem", isi->idx);
+	ofono_devinfo_create(isi->modem, 0, "isimodem", isi->idx);
+	ofono_voicecall_create(isi->modem, 0, "isimodem", isi->idx);
+}
+
+static void isigen_post_sim(struct ofono_modem *modem)
+{
+	struct isi_data *isi =3D ofono_modem_get_data(modem);
+
+	DBG("(%p) with %s", modem, isi->ifname);
+
+	ofono_phonebook_create(isi->modem, 0, "isimodem", isi->idx);
+}
+
+static void isigen_post_online(struct ofono_modem *modem)
+{
+	struct isi_data *isi =3D ofono_modem_get_data(modem);
+	struct ofono_gprs *gprs;
+	struct ofono_gprs_context *gc;
+
+	DBG("(%p) with %s", modem, isi->ifname);
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
+static int match_ifname(char const *name, char const *ifname)
+{
+	size_t namelen =3D strlen(name);
+
+	if (strncmp(name, ifname, namelen) !=3D 0)
+		return FALSE;
+
+	if (ifname[namelen + strspn(ifname + namelen, "0123456789")] !=3D '\0')
+		return FALSE;
+
+	return TRUE;
+}
+
+static struct ofono_modem_driver driver =3D {
+	.name =3D "isigen",
+	.probe =3D isigen_probe,
+	.remove =3D isigen_remove,
+	.set_online =3D isigen_online,
+	.pre_sim =3D isigen_pre_sim,
+	.post_sim =3D isigen_post_sim,
+	.post_online =3D isigen_post_online,
+};
+
+/*
+ * Add/remove isigen modem when usbpn* phonet interfaces are
+ * added/removed
+ */
+static void usbpn_status_cb(GIsiModem *idx,
+				GPhonetLinkState st,
+				char const ifname[],
+				void *data)
+{
+	struct ofono_modem *modem;
+	int error;
+	uint8_t address =3D 0;
+
+	DBG("Phonet link %s (%u) is %s",
+		ifname, g_isi_modem_index(idx),
+		st =3D=3D PN_LINK_REMOVED ? "removed" :
+		st =3D=3D PN_LINK_DOWN ? "down" : "up");
+
+	if (st =3D=3D PN_LINK_REMOVED)
+		return;
+
+	if (!match_ifname("usbpn", ifname))
+		return;
+
+	address =3D PN_DEV_PC;
+
+	if (g_pn_netlink_by_modem(idx)) {
+		DBG("Modem for interface %s already exists", ifname);
+		return;
+	}
+
+	error =3D g_pn_netlink_set_address(idx, address);
+	if (error && error !=3D -EEXIST) {
+		DBG("g_pn_netlink_set_address: %s\n", strerror(-error));
+		return;
+	}
+
+	modem =3D ofono_modem_create(NULL, "isimodem");
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
+static GPhonetNetlink *usbpn_link;
+
+static int isigen_init(void)
+{
+	ofono_modem_driver_register(&driver);
+
+	usbpn_link =3D g_pn_netlink_start(NULL, usbpn_status_cb, NULL);
+
+	return 0;
+}
+
+static void isigen_exit(void)
+{
+	g_pn_netlink_stop(usbpn_link);
+	usbpn_link =3D NULL;
+
+	ofono_modem_driver_unregister(&driver);
+}
+
+OFONO_PLUGIN_DEFINE(isigen, "Hotplug driver for isimodem", VERSION,
+			OFONO_PLUGIN_PRIORITY_DEFAULT,
+			isigen_init, isigen_exit)
diff --git a/plugins/usbpnmodem.c b/plugins/usbpnmodem.c
deleted file mode 100644
index 68beb6f..0000000
--- a/plugins/usbpnmodem.c
+++ /dev/null
@@ -1,104 +0,0 @@
-/*
- * This file is part of oFono - Open Source Telephony
- *
- * Copyright (C) 2009 Nokia Corporation and/or its subsidiary(-ies).
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License
- * version 2 as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA
- * 02110-1301 USA
- *
- */
-
-#ifdef HAVE_CONFIG_H
-#include <config.h>
-#endif
-
-#include <stdio.h>
-#include <errno.h>
-#include <stdlib.h>
-#include <string.h>
-#include <glib.h>
-
-#include <gisi/netlink.h>
-#include <gisi/client.h>
-
-#define OFONO_API_SUBJECT_TO_CHANGE
-#include <ofono/plugin.h>
-#include <ofono/log.h>
-#include <ofono/modem.h>
-
-static GPhonetNetlink *link =3D NULL;
-
-/*
- * Add or remove isimodems
- * when usbpn* phonet interfaces are added/removed
- */
-static void usbpn_status_cb(GIsiModem *idx,
-				GPhonetLinkState st,
-				char const ifname[],
-				void *data)
-{
-	struct ofono_modem *modem;
-	int error;
-
-	DBG("Phonet link %s (%u) is %s",
-		ifname, g_isi_modem_index(idx),
-		st =3D=3D PN_LINK_REMOVED ? "removed" :
-		st =3D=3D PN_LINK_DOWN ? "down" : "up");
-
-	/* Expect phonet interface name usbpn<idx> */
-	if (strncmp(ifname, "usbpn", 5) ||
-		ifname[5 + strspn(ifname + 5, "0123456789")])
-		return;
-
-	if (st =3D=3D PN_LINK_REMOVED)
-		return;
-
-	if (g_pn_netlink_by_modem(idx)) {
-		DBG("Modem for interface %s already exists", ifname);
-		return;
-	}
-
-	error =3D g_pn_netlink_set_address(idx, PN_DEV_PC);
-	if (error && error !=3D -EEXIST) {
-		DBG("g_pn_netlink_set_address: %s\n", strerror(-error));
-		return;
-	}
-
-	modem =3D ofono_modem_create(NULL, "isimodem");
-	if (!modem)
-		return;
-
-	ofono_modem_set_string(modem, "Interface", ifname);
-
-	if (ofono_modem_register(modem) =3D=3D 0)
-		DBG("Done regging modem %s", ofono_modem_get_path(modem));
-	else
-		ofono_modem_remove(modem);
-}
-
-static int usbpn_init(void)
-{
-	link =3D g_pn_netlink_start(NULL, usbpn_status_cb, NULL);
-	return 0;
-}
-
-static void usbpn_exit(void)
-{
-	g_pn_netlink_stop(link);
-	link =3D NULL;
-}
-
-OFONO_PLUGIN_DEFINE(usbpnmodem, "Hotplug driver for USB Phonet modems", VE=
RSION,
-			OFONO_PLUGIN_PRIORITY_DEFAULT,
-			usbpn_init, usbpn_exit)
-- =

1.7.0.4


--===============1882815757485748186==--

