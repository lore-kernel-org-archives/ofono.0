Content-Type: multipart/mixed; boundary="===============7903922680628848172=="
MIME-Version: 1.0
From: Andreas Westin <andreas.westin@stericsson.com>
Subject: [PATCH v2 03/18] plugins: add plugin for u8500
Date: Wed, 23 Feb 2011 12:43:14 +0100
Message-ID: <6791487b6a0b10532aaa9f0bae8215471c989c87.1298460572.git.andreas.westin@stericsson.com>
In-Reply-To: <cover.1298460572.git.andreas.westin@stericsson.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7903922680628848172==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Jessica Nilsson <jessica.j.nilsson@stericsson.com>

---
 Makefile.am     |    3 +
 plugins/u8500.c |  708 +++++++++++++++++++++++++++++++++++++++++++++++++++=
++++
 2 files changed, 711 insertions(+), 0 deletions(-)
 create mode 100644 plugins/u8500.c

diff --git a/Makefile.am b/Makefile.am
index 7bd7f4f..aa4f3f9 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -144,6 +144,9 @@ builtin_sources +=3D plugins/isiusb.c
 =

 builtin_modules +=3D n900
 builtin_sources +=3D plugins/n900.c plugins/nokia-gpio.h plugins/nokia-gpi=
o.c
+
+builtin_modules +=3D u8500
+builtin_sources +=3D plugins/u8500.c
 endif
 =

 if ATMODEM
diff --git a/plugins/u8500.c b/plugins/u8500.c
new file mode 100644
index 0000000..78e1a97
--- /dev/null
+++ b/plugins/u8500.c
@@ -0,0 +1,708 @@
+/*
+ *
+ *  oFono - Open Source Telephony
+ *
+ *  Copyright (C) 2010  Nokia Corporation and/or its subsidiary(-ies).
+ *  Copyright (C) ST-Ericsson SA 2011.
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
+#include <gisi/netlink.h>
+#include <gisi/modem.h>
+#include <gisi/client.h>
+#include <gisi/message.h>
+#include <gisi/iter.h>
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
+	char const *ifname;
+	GIsiModem *modem;
+	GIsiClient *client;
+	GIsiPhonetNetlink *link;
+	enum GIsiPhonetLinkState linkstate;
+	unsigned interval;
+	int reported;
+	ofono_bool_t online;
+	struct isi_cb_data *online_cbd;
+};
+
+struct devinfo_data {
+	GIsiClient *client;
+};
+
+static gboolean check_response_status(const GIsiMessage *msg, uint8_t msgi=
d)
+{
+	if (g_isi_msg_error(msg) < 0) {
+		DBG("Error: %s", strerror(-g_isi_msg_error(msg)));
+		return FALSE;
+	}
+
+	if (g_isi_msg_id(msg) !=3D msgid) {
+		DBG("Unexpected msg: %s",
+			mce_message_id_name(g_isi_msg_id(msg)));
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
+static void set_power_by_mce_state(struct ofono_modem *modem,
+					struct isi_data *isi, int mce_state)
+{
+	switch (mce_state) {
+	case MCE_POWER_OFF:
+		report_powered(modem, isi, FALSE);
+		break;
+	case MCE_NORMAL:
+		if (isi->online_cbd)
+			report_online(isi, mce_state =3D=3D MCE_NORMAL);
+	default:
+		report_powered(modem, isi, TRUE);
+	}
+}
+
+static void mce_state_ind_cb(const GIsiMessage *msg, void *data)
+{
+	struct ofono_modem *modem =3D data;
+	struct isi_data *isi =3D ofono_modem_get_data(modem);
+	uint8_t state;
+	uint8_t action;
+
+	if (isi =3D=3D NULL || g_isi_msg_id(msg) !=3D MCE_MODEM_STATE_IND)
+		return;
+
+	if (!g_isi_msg_data_get_byte(msg, 0, &state) ||
+			!g_isi_msg_data_get_byte(msg, 1, &action))
+		return;
+
+	switch (action) {
+	case MCE_START:
+		DBG("target modem state: %s (0x%02X)",
+			mce_modem_state_name(state), state);
+		break;
+
+	case MCE_READY:
+		DBG("current modem state: %s (0x%02X)",
+			mce_modem_state_name(state), state);
+		set_power_by_mce_state(modem, isi, state);
+		break;
+	default:
+		break;
+	}
+}
+
+static void mce_rf_state_ind_cb(const GIsiMessage *msg, void *data)
+{
+	struct ofono_modem *modem =3D data;
+	struct isi_data *isi =3D ofono_modem_get_data(modem);
+	uint8_t state;
+	uint8_t action;
+
+	if (isi =3D=3D NULL || g_isi_msg_id(msg) !=3D MCE_RF_STATE_IND)
+		return;
+
+	if (!g_isi_msg_data_get_byte(msg, 0, &state) ||
+			!g_isi_msg_data_get_byte(msg, 1, &action))
+		return;
+
+	switch (action) {
+	case MCE_READY:
+		DBG("current rf state: %s (0x%02X)",
+			mce_rf_state_name(state), state);
+		if (isi->online_cbd)
+			report_online(isi, state);
+		break;
+	case MCE_START:
+	default:
+		break;
+	}
+}
+
+static void mce_query_cb(const GIsiMessage *msg, void *data)
+{
+	struct ofono_modem *modem =3D data;
+	struct isi_data *isi =3D ofono_modem_get_data(modem);
+	uint8_t current;
+	uint8_t target;
+
+	if (!check_response_status(msg, MCE_MODEM_STATE_QUERY_RESP))
+		return;
+
+	if (!g_isi_msg_data_get_byte(msg, 0, &current) ||
+			!g_isi_msg_data_get_byte(msg, 1, &target))
+		return;
+
+	DBG("Modem state: current=3D%s (0x%02X) target=3D%s (0x%02X)",
+		mce_modem_state_name(current), current,
+		mce_modem_state_name(target), target);
+
+	if (current =3D=3D target)
+		set_power_by_mce_state(modem, isi, current);
+}
+
+static gboolean bootstrap_current_state(gpointer user)
+{
+	struct ofono_modem *om =3D user;
+	struct isi_data *isi =3D ofono_modem_get_data(om);
+
+	const uint8_t req[] =3D {
+		MCE_MODEM_STATE_QUERY_REQ,
+		0x00, 0x00 /* Filler */
+	};
+	size_t len =3D sizeof(req);
+
+	g_isi_client_send(isi->client, req, len, mce_query_cb, om, NULL);
+
+	return FALSE;
+}
+
+static void reachable_cb(const GIsiMessage *msg, void *data)
+{
+	struct ofono_modem *om =3D data;
+	struct isi_data *isi =3D ofono_modem_get_data(om);
+
+	if (!g_isi_msg_error(msg) < 0)
+		return;
+
+	ISI_VERSION_DBG(msg);
+
+	g_isi_client_ind_subscribe(isi->client, MCE_MODEM_STATE_IND,
+					mce_state_ind_cb, om);
+
+	g_isi_client_ind_subscribe(isi->client, MCE_RF_STATE_IND,
+					mce_rf_state_ind_cb, om);
+
+	/*
+	 * FIXME: There is a theoretical race condition here:
+	 * g_isi_client_ind_subscribe() adds the actual message
+	 * sending for committing changes to subscriptions in idle
+	 * loop, which may or may not preserve ordering.  Thus, we
+	 * might miss a state indication if the bootstrap request ends
+	 * up being sent first.
+	 */
+	g_idle_add(bootstrap_current_state, om);
+}
+
+static void phonet_status_cb(GIsiModem *modem, enum GIsiPhonetLinkState st,
+				char const *ifname, void *data)
+{
+	struct ofono_modem *om =3D data;
+	struct isi_data *isi =3D ofono_modem_get_data(om);
+
+	DBG("Link %s (%u) is %s", isi->ifname, g_isi_modem_index(isi->modem),
+		st =3D=3D PN_LINK_REMOVED ? "removed" :
+		st =3D=3D PN_LINK_DOWN ? "down" : "up");
+
+	isi->linkstate =3D st;
+
+	if (st =3D=3D PN_LINK_UP)
+		g_isi_client_verify(isi->client, reachable_cb, om, NULL);
+	else if (st =3D=3D PN_LINK_DOWN)
+		set_power_by_mce_state(om, isi, MCE_POWER_OFF);
+}
+
+static int u8500_probe(struct ofono_modem *modem)
+{
+	const char *ifname =3D ofono_modem_get_string(modem, "Interface");
+	unsigned address =3D ofono_modem_get_integer(modem, "Address");
+	GIsiModem *isimodem;
+	GIsiClient *client =3D NULL;
+	GIsiPhonetNetlink *link =3D NULL;
+	struct isi_data *isi =3D NULL;
+
+	if (ifname =3D=3D NULL)
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
+
+	if (getenv("OFONO_ISI_DEBUG"))
+		g_isi_modem_set_debug(isimodem, ofono_debug);
+
+	if (getenv("OFONO_ISI_TRACE"))
+		g_isi_modem_set_trace(isimodem, isi_trace);
+
+	if (g_isi_pn_netlink_by_modem(isimodem)) {
+		DBG("%s: %s", ifname, strerror(EBUSY));
+		errno =3D EBUSY;
+		goto error;
+	}
+
+	link =3D g_isi_pn_netlink_start(isimodem, phonet_status_cb, modem);
+	if (link =3D=3D NULL) {
+		DBG("%s: %s", ifname, strerror(errno));
+		goto error;
+	}
+
+	if (address) {
+		int error =3D g_isi_pn_netlink_set_address(isimodem, address);
+		if (error && error !=3D -EEXIST) {
+			DBG("g_isi_pn_netlink_set_address(): %s\n",
+				strerror(-error));
+			errno =3D -error;
+			goto error;
+		}
+	}
+
+	isi =3D g_try_new0(struct isi_data, 1);
+	if (isi =3D=3D NULL) {
+		errno =3D ENOMEM;
+		goto error;
+	}
+
+	client =3D g_isi_client_create(isimodem, PN_MODEM_MCE);
+	if (!client)
+		goto error;
+
+	g_isi_modem_set_device(isimodem, PN_DEV_MODEM);
+
+	isi->modem =3D isimodem;
+	isi->ifname =3D ifname;
+	isi->link =3D link;
+	isi->reported =3D -1;
+	isi->client =3D client;
+
+	ofono_modem_set_data(modem, isi);
+	return 0;
+
+error:
+	g_isi_pn_netlink_stop(link);
+	g_isi_client_destroy(client);
+	g_isi_modem_destroy(isimodem);
+	g_free(isi);
+
+	return -errno;
+}
+
+static void u8500_remove(struct ofono_modem *modem)
+{
+	struct isi_data *isi =3D ofono_modem_get_data(modem);
+
+	ofono_modem_set_data(modem, NULL);
+
+	if (isi =3D=3D NULL)
+		return;
+
+	g_isi_pn_netlink_stop(isi->link);
+	g_isi_client_destroy(isi->client);
+	g_isi_modem_destroy(isi->modem);
+	g_free(isi);
+}
+
+static void mce_state_cb(const GIsiMessage *msg, void *data)
+{
+	struct isi_cb_data *cbd =3D data;
+	struct ofono_modem *modem =3D cbd->user;
+	ofono_modem_online_cb_t cb =3D cbd->cb;
+
+	struct isi_data *isi =3D ofono_modem_get_data(modem);
+	uint8_t cause;
+
+	if (!check_response_status(msg, MCE_RF_STATE_RESP))
+		goto error;
+
+	if (!g_isi_msg_data_get_byte(msg, 0, &cause))
+		goto error;
+
+	DBG("MCE cause: %s (0x%02X)", mce_status_info(cause), cause);
+
+	if (cause =3D=3D MCE_OK) {
+		isi->online_cbd =3D cbd;
+		return;
+	}
+
+	if (cause =3D=3D MCE_ALREADY_ACTIVE) {
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
+static void u8500_online(struct ofono_modem *modem, ofono_bool_t online,
+				ofono_modem_online_cb_t cb, void *data)
+{
+	struct isi_data *isi =3D ofono_modem_get_data(modem);
+	struct isi_cb_data *cbd =3D isi_cb_data_new(modem, cb, data);
+	const uint8_t req[] =3D {
+		MCE_RF_STATE_REQ,
+		online ? MCE_RF_ON : MCE_RF_OFF,
+		0x00
+	};
+
+	DBG("(%p) with %s", modem, isi->ifname);
+
+	if (cbd =3D=3D NULL || isi =3D=3D NULL)
+		goto error;
+
+	if (g_isi_client_send_with_timeout(isi->client, req, sizeof(req),
+				MTC_STATE_REQ_TIMEOUT,
+				mce_state_cb, cbd, NULL)) {
+		isi->online =3D online;
+		return;
+	}
+
+error:
+	CALLBACK_WITH_FAILURE(cb, data);
+	g_free(cbd);
+}
+
+static void u8500_pre_sim(struct ofono_modem *modem)
+{
+	struct isi_data *isi =3D ofono_modem_get_data(modem);
+
+	DBG("(%p) with %s", modem, isi->ifname);
+
+	ofono_sim_create(modem, 0, "isimodem", isi->modem);
+	ofono_devinfo_create(modem, 0, "u8500", isi->modem);
+	ofono_voicecall_create(modem, 0, "isimodem", isi->modem);
+}
+
+static void u8500_post_sim(struct ofono_modem *modem)
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
+static void u8500_post_online(struct ofono_modem *modem)
+{
+	struct isi_data *isi =3D ofono_modem_get_data(modem);
+
+	DBG("(%p) with %s", modem, isi->ifname);
+
+	ofono_netreg_create(modem, 0, "wgmodem2.5", isi->modem);
+	ofono_sms_create(modem, 0, "isimodem", isi->modem);
+	ofono_cbs_create(modem, 0, "isimodem", isi->modem);
+	ofono_ssn_create(modem, 0, "isimodem", isi->modem);
+	ofono_ussd_create(modem, 0, "isimodem", isi->modem);
+	ofono_call_settings_create(modem, 0, "isimodem", isi->modem);
+	ofono_call_barring_create(modem, 0, "isimodem", isi->modem);
+	ofono_call_meter_create(modem, 0, "isimodem", isi->modem);
+	ofono_gprs_create(modem, 0, "isimodem", isi->modem);
+}
+
+static int u8500_enable(struct ofono_modem *modem)
+{
+	return 0;
+}
+
+static int u8500_disable(struct ofono_modem *modem)
+{
+	return 0;
+}
+
+static void u8500_info_resp_cb(const GIsiMessage *msg, void *data)
+{
+	struct isi_cb_data *cbd =3D data;
+	ofono_devinfo_query_cb_t cb =3D cbd->cb;
+	GIsiSubBlockIter iter;
+	uint8_t msgid;
+	uint8_t status;
+
+	msgid =3D g_isi_msg_id(msg);
+	if (msgid !=3D INFO_SERIAL_NUMBER_READ_RESP)
+		goto error;
+
+	if (g_isi_msg_error(msg) < 0)
+		goto error;
+
+	if (!g_isi_msg_data_get_byte(msg, 0, &status))
+		goto error;
+
+	if (status !=3D INFO_OK)
+		goto error;
+
+	for (g_isi_sb_iter_init(&iter, msg, 2);
+			g_isi_sb_iter_is_valid(&iter);
+			g_isi_sb_iter_next(&iter)) {
+
+		uint8_t id =3D g_isi_sb_iter_get_id(&iter);
+		uint8_t chars;
+		char *info =3D NULL;
+
+		if (id !=3D INFO_SB_PRODUCT_INFO_MANUFACTURER &&
+				id !=3D INFO_SB_PRODUCT_INFO_NAME &&
+				id !=3D INFO_SB_MCUSW_VERSION &&
+				id !=3D INFO_SB_SN_IMEI_PLAIN &&
+				id !=3D INFO_SB_MODEMSW_VERSION)
+			continue;
+
+		if (g_isi_sb_iter_get_len(&iter) < 5)
+			goto error;
+
+		if (!g_isi_sb_iter_get_byte(&iter, &chars, 3))
+			goto error;
+
+		if (!g_isi_sb_iter_get_latin_tag(&iter, &info, chars, 4))
+			goto error;
+
+		CALLBACK_WITH_SUCCESS(cb, info, cbd->data);
+
+		g_free(info);
+		return;
+	}
+
+error:
+	CALLBACK_WITH_FAILURE(cb, "", cbd->data);
+}
+
+static void u8500_devinfo_reachable_cb(const GIsiMessage *msg, void *data)
+{
+	struct ofono_devinfo *info =3D data;
+
+	if (g_isi_msg_error(msg) < 0)
+		return;
+
+	ISI_VERSION_DBG(msg);
+
+	ofono_devinfo_register(info);
+}
+
+static void u8500_query_manufacturer(struct ofono_devinfo *info,
+					ofono_devinfo_query_cb_t cb,
+					void *data)
+{
+	CALLBACK_WITH_FAILURE(cb, "", data);
+}
+
+static void u8500_query_model(struct ofono_devinfo *info,
+				ofono_devinfo_query_cb_t cb,
+				void *data)
+{
+	CALLBACK_WITH_FAILURE(cb, "", data);
+}
+
+static void u8500_query_revision(struct ofono_devinfo *info,
+				ofono_devinfo_query_cb_t cb,
+				void *data)
+{
+	struct devinfo_data *dev =3D ofono_devinfo_get_data(info);
+	struct isi_cb_data *cbd =3D isi_cb_data_new(dev, cb, data);
+	const unsigned char msg[] =3D {
+		INFO_SERIAL_NUMBER_READ_REQ,
+		0x00, 0x00,
+		0x00, 0x00, 0x00, 0x01, /* M_INFO_MODEMSW */
+		0x00, 0x00
+	};
+	DBG("");
+
+	if (cbd =3D=3D NULL || dev =3D=3D NULL)
+		goto error;
+
+	if (g_isi_client_send(dev->client, msg, sizeof(msg),
+				u8500_info_resp_cb, cbd, g_free))
+		return;
+
+
+error:
+	CALLBACK_WITH_FAILURE(cb, "", data);
+	g_free(cbd);
+}
+
+static void u8500_query_serial(struct ofono_devinfo *info,
+				ofono_devinfo_query_cb_t cb,
+				void *data)
+{
+	char imei[16]; /* IMEI 15 digits + 1 null*/
+	char numbers[] =3D "1234567890";
+	FILE *fp =3D fopen("/etc/imei", "r");
+	DBG("");
+
+	if (fp =3D=3D NULL) {
+		DBG("failed to open /etc/imei file");
+		goto error;
+	}
+
+	if (fgets(imei, 16, fp)) {
+		DBG(" IMEI =3D %s", imei);
+		if (15 =3D=3D strspn(imei, numbers))
+			CALLBACK_WITH_SUCCESS(cb, imei, data);
+		else {
+			CALLBACK_WITH_FAILURE(cb, "", data);
+			fclose(fp);
+			goto error;
+		}
+	}
+
+	fclose(fp);
+	return;
+
+error:
+	CALLBACK_WITH_FAILURE(cb, "", data);
+}
+
+static int u8500_devinfo_probe(struct ofono_devinfo *info, unsigned int ve=
ndor,
+				void *user)
+{
+	GIsiModem *idx =3D user;
+	struct devinfo_data *data =3D g_try_new0(struct devinfo_data, 1);
+
+	if (data =3D=3D NULL)
+		return -ENOMEM;
+
+	data->client =3D g_isi_client_create(idx, PN_MODEM_INFO);
+	if (data->client =3D=3D NULL)
+		goto nomem;
+
+	ofono_devinfo_set_data(info, data);
+
+	g_isi_client_set_timeout(data->client, INFO_TIMEOUT);
+	g_isi_client_verify(data->client, u8500_devinfo_reachable_cb,
+				info, NULL);
+
+	return 0;
+
+nomem:
+	g_isi_client_destroy(data->client);
+
+	g_free(data);
+	return -ENOMEM;
+
+}
+
+static void u8500_devinfo_remove(struct ofono_devinfo *info)
+{
+	struct devinfo_data *data =3D ofono_devinfo_get_data(info);
+
+	ofono_devinfo_set_data(info, NULL);
+
+	if (data =3D=3D NULL)
+		return;
+
+	g_isi_client_destroy(data->client);
+	g_free(data);
+}
+
+static struct ofono_modem_driver driver =3D {
+	.name =3D "u8500",
+	.probe =3D u8500_probe,
+	.remove =3D u8500_remove,
+	.set_online =3D u8500_online,
+	.pre_sim =3D u8500_pre_sim,
+	.post_sim =3D u8500_post_sim,
+	.post_online =3D u8500_post_online,
+	.enable =3D u8500_enable,
+	.disable =3D u8500_disable,
+};
+
+static struct ofono_devinfo_driver devinfo_driver =3D {
+	.name			=3D "u8500",
+	.probe			=3D u8500_devinfo_probe,
+	.remove			=3D u8500_devinfo_remove,
+	.query_manufacturer	=3D u8500_query_manufacturer,
+	.query_model		=3D u8500_query_model,
+	.query_revision		=3D u8500_query_revision,
+	.query_serial		=3D u8500_query_serial
+};
+
+static int u8500_init(void)
+{
+	int err;
+
+	err =3D ofono_modem_driver_register(&driver);
+
+	if (err < 0)
+		return err;
+
+	ofono_devinfo_driver_register(&devinfo_driver);
+
+	return 0;
+}
+
+static void u8500_exit(void)
+{
+	ofono_devinfo_driver_unregister(&devinfo_driver);
+
+	ofono_modem_driver_unregister(&driver);
+}
+
+OFONO_PLUGIN_DEFINE(u8500, "Generic modem driver for isi",
+			VERSION, OFONO_PLUGIN_PRIORITY_DEFAULT,
+			u8500_init, u8500_exit)
-- =

1.7.3.5


--===============7903922680628848172==--

