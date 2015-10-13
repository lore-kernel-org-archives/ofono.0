Content-Type: multipart/mixed; boundary="===============6686956311622577225=="
MIME-Version: 1.0
From: Alfonso Sanchez-Beato <alfonso.sanchez-beato@canonical.com>
Subject: [PATCH 5/9] ril: Plugin for Android modems
Date: Tue, 13 Oct 2015 18:07:54 +0200
Message-ID: <1444752478-18198-6-git-send-email-alfonso.sanchez-beato@canonical.com>
In-Reply-To: <1444752478-18198-1-git-send-email-alfonso.sanchez-beato@canonical.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6686956311622577225==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Tony Espy <espy@canonical.com>

Plugin for Android modem, which uses the rilmodem driver.

Co-authored-by: Tony Espy <espy@canonical.com>
Co-authored-by: Ricardo Salveti de Araujo <ricardo.salveti@canonical.com>
Co-authored-by: Alfonso Sanchez-Beato <alfonso.sanchez-beato@canonical.co=
m>
Co-authored-by: Islam Amer <islam.amer@jollamobile.com>
Co-authored-by: Jussi Kangas <jussi.kangas@tieto.com>
Co-authored-by: Juho H=C3=A4m=C3=A4l=C3=A4inen <juho.hamalainen@tieto.com>
Co-authored-by: Martti Piirainen <martti.piirainen@canonical.com>
Co-authored-by: Jarko Poutiainen <Jarko.Poutiainen@oss.tieto.com>
Co-authored-by: Tommi Kenakkala <tommi.kenakkala@oss.tieto.com>
Co-authored-by: Petri Takalokastari <petri.takalokastari@oss.tieto.com>
Co-authored-by: Miia Leinonen <miia.leinonen@oss.tieto.com>
Co-authored-by: Mikko Hurskainen <mikko.hurskainen@nomovok.com>
Co-authored-by: You-Sheng Yang <vicamo.yang@canonical.com>
---
 plugins/ril.c | 461 ++++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++
 plugins/ril.h |  30 ++++
 2 files changed, 491 insertions(+)
 create mode 100644 plugins/ril.c
 create mode 100644 plugins/ril.h

diff --git a/plugins/ril.c b/plugins/ril.c
new file mode 100644
index 0000000..e27c98c
--- /dev/null
+++ b/plugins/ril.c
@@ -0,0 +1,461 @@
+/*
+ *
+ *  oFono - Open Source Telephony - RIL-based devices
+ *
+ *  Copyright (C) 2008-2011  Intel Corporation. All rights reserved.
+ *  Copyright (C) 2012-2014 Canonical Ltd.
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
+#include <stdio.h>
+#include <errno.h>
+#include <stdlib.h>
+#include <string.h>
+
+#include <unistd.h>
+#include <glib.h>
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
+#include <ofono/call-volume.h>
+#include <ofono/radio-settings.h>
+#include <ofono/gprs.h>
+#include <ofono/gprs-context.h>
+#include <ofono/audio-settings.h>
+#include <ofono/types.h>
+
+#include "ofono.h"
+
+#include <grilreply.h>
+#include <grilrequest.h>
+#include <grilunsol.h>
+
+#include "ril.h"
+#include "drivers/rilmodem/rilmodem.h"
+#include "drivers/rilmodem/vendor.h"
+
+#define MAX_SIM_STATUS_RETRIES 15
+
+/* this gives 30s for rild to initialize */
+#define RILD_MAX_CONNECT_RETRIES 5
+#define RILD_CONNECT_RETRY_TIME_S 5
+
+char *RILD_CMD_SOCKET[] =3D {"/dev/socket/rild", "/dev/socket/rild1"};
+char *GRIL_HEX_PREFIX[] =3D {"Device 0: ", "Device 1: "};
+
+struct ril_data {
+	GRil *ril;
+	enum ofono_ril_vendor vendor;
+	int sim_status_retries;
+	ofono_bool_t connected;
+	ofono_bool_t ofono_online;
+	int radio_state;
+	struct ofono_sim *sim;
+	struct ofono_radio_settings *radio_settings;
+	int rild_connect_retries;
+};
+
+static void ril_debug(const char *str, void *user_data)
+{
+	const char *prefix =3D user_data;
+
+	ofono_info("%s%s", prefix, str);
+}
+
+static void ril_radio_state_changed(struct ril_msg *message, gpointer user=
_data)
+{
+	struct ofono_modem *modem =3D user_data;
+	struct ril_data *rd =3D ofono_modem_get_data(modem);
+	int radio_state =3D g_ril_unsol_parse_radio_state_changed(rd->ril,
+								message);
+
+	if (radio_state !=3D rd->radio_state) {
+
+		ofono_info("%s: state: %s rd->ofono_online: %d",
+				__func__,
+				ril_radio_state_to_string(radio_state),
+				rd->ofono_online);
+
+		rd->radio_state =3D radio_state;
+
+		switch (radio_state) {
+		case RADIO_STATE_ON:
+
+			if (rd->radio_settings =3D=3D NULL) {
+				struct ril_radio_settings_driver_data
+						rs_data =3D { rd->ril, modem };
+
+				rd->radio_settings =3D
+					ofono_radio_settings_create(modem,
+							rd->vendor, RILMODEM,
+							&rs_data);
+			}
+
+			break;
+
+		case RADIO_STATE_UNAVAILABLE:
+		case RADIO_STATE_OFF:
+
+			/*
+			 * Unexpected radio state change, as we are supposed to
+			 * be online. UNAVAILABLE has been seen occassionally
+			 * when powering off the phone. We wait 5 secs to avoid
+			 * too fast re-spawns, then exit with error to make
+			 * upstart re-start ofono.
+			 */
+			if (rd->ofono_online) {
+				ofono_error("%s: radio self-powered off!",
+						__func__);
+				sleep(5);
+				exit(1);
+			}
+			break;
+		default:
+			/* Malformed parcel; no radio state =3D=3D broken rild */
+			g_assert(FALSE);
+		}
+	}
+}
+
+int ril_create(struct ofono_modem *modem, enum ofono_ril_vendor vendor)
+{
+	ofono_bool_t lte_cap;
+	struct ril_data *rd =3D g_try_new0(struct ril_data, 1);
+	if (rd =3D=3D NULL) {
+		errno =3D ENOMEM;
+		goto error;
+	}
+
+	DBG("");
+
+	rd->vendor =3D vendor;
+	rd->ofono_online =3D FALSE;
+	rd->radio_state =3D RADIO_STATE_OFF;
+
+	lte_cap =3D getenv("OFONO_RIL_RAT_LTE") ? TRUE : FALSE;
+	ofono_modem_set_boolean(modem, MODEM_PROP_LTE_CAPABLE, lte_cap);
+
+	ofono_modem_set_data(modem, rd);
+
+	return 0;
+
+error:
+	g_free(rd);
+
+	return -errno;
+}
+
+static int ril_probe(struct ofono_modem *modem)
+{
+	return ril_create(modem, OFONO_RIL_VENDOR_AOSP);
+}
+
+void ril_remove(struct ofono_modem *modem)
+{
+	struct ril_data *rd =3D ofono_modem_get_data(modem);
+
+	ofono_modem_set_data(modem, NULL);
+
+	if (!rd)
+		return;
+
+	g_ril_unref(rd->ril);
+
+	g_free(rd);
+}
+
+void ril_pre_sim(struct ofono_modem *modem)
+{
+	struct ril_data *rd =3D ofono_modem_get_data(modem);
+	struct ril_voicecall_driver_data vc_data =3D { rd->ril, modem };
+	struct ril_sim_data sim_data;
+
+	DBG("");
+
+	ofono_devinfo_create(modem, rd->vendor, RILMODEM, rd->ril);
+	ofono_voicecall_create(modem, rd->vendor, RILMODEM, &vc_data);
+	ofono_call_volume_create(modem, rd->vendor, RILMODEM, rd->ril);
+
+	sim_data.gril =3D rd->ril;
+	sim_data.modem =3D modem;
+	sim_data.ril_state_watch =3D NULL;
+
+	rd->sim =3D ofono_sim_create(modem, rd->vendor, RILMODEM, &sim_data);
+	g_assert(rd->sim !=3D NULL);
+}
+
+void ril_post_sim(struct ofono_modem *modem)
+{
+	struct ril_data *rd =3D ofono_modem_get_data(modem);
+	struct ofono_gprs *gprs;
+	struct ofono_gprs_context *gc;
+	struct ofono_message_waiting *mw;
+	struct ril_gprs_driver_data gprs_data =3D { rd->ril, modem };
+	struct ril_gprs_context_data
+		inet_ctx =3D { rd->ril, modem, OFONO_GPRS_CONTEXT_TYPE_INTERNET };
+	struct ril_gprs_context_data
+		mms_ctx =3D { rd->ril, modem, OFONO_GPRS_CONTEXT_TYPE_MMS };
+
+	/* TODO: this function should setup:
+	 *  - phonebook
+	 *  - stk ( SIM toolkit )
+	 *  - radio_settings
+	 */
+	ofono_sms_create(modem, rd->vendor, RILMODEM, rd->ril);
+
+	gprs =3D ofono_gprs_create(modem, rd->vendor, RILMODEM, &gprs_data);
+	gc =3D ofono_gprs_context_create(modem, rd->vendor, RILMODEM, &inet_ctx);
+
+	if (gc) {
+		ofono_gprs_context_set_type(gc,
+					OFONO_GPRS_CONTEXT_TYPE_INTERNET);
+		ofono_gprs_add_context(gprs, gc);
+	}
+
+	gc =3D ofono_gprs_context_create(modem, rd->vendor, RILMODEM, &mms_ctx);
+
+	if (gc) {
+		ofono_gprs_context_set_type(gc,
+					OFONO_GPRS_CONTEXT_TYPE_MMS);
+		ofono_gprs_add_context(gprs, gc);
+	}
+
+	mw =3D ofono_message_waiting_create(modem);
+	if (mw)
+		ofono_message_waiting_register(mw);
+
+	ofono_call_forwarding_create(modem, rd->vendor, RILMODEM, rd->ril);
+
+	ofono_phonebook_create(modem, rd->vendor, RILMODEM, modem);
+}
+
+void ril_post_online(struct ofono_modem *modem)
+{
+	struct ril_data *rd =3D ofono_modem_get_data(modem);
+
+	ofono_netreg_create(modem, rd->vendor, RILMODEM, rd->ril);
+	ofono_ussd_create(modem, rd->vendor, RILMODEM, rd->ril);
+	ofono_call_settings_create(modem, rd->vendor, RILMODEM, rd->ril);
+	ofono_call_barring_create(modem, rd->vendor, RILMODEM, rd->ril);
+}
+
+static void ril_set_online_cb(struct ril_msg *message, gpointer user_data)
+{
+	struct cb_data *cbd =3D user_data;
+	struct ril_data *rd =3D cbd->user;
+	ofono_modem_online_cb_t cb =3D cbd->cb;
+
+	if (message->error =3D=3D RIL_E_SUCCESS) {
+		DBG("%s: set_online OK: rd->ofono_online: %d", __func__,
+			rd->ofono_online);
+		CALLBACK_WITH_SUCCESS(cb, cbd->data);
+	} else {
+		ofono_error("%s: set_online: %d failed", __func__,
+				rd->ofono_online);
+		CALLBACK_WITH_FAILURE(cb, cbd->data);
+	}
+}
+
+static void ril_send_power(struct ril_data *rd, ofono_bool_t online,
+				GRilResponseFunc func,
+				gpointer user_data)
+{
+	struct cb_data *cbd =3D user_data;
+	ofono_modem_online_cb_t cb;
+	GDestroyNotify notify =3D NULL;
+	struct parcel rilp;
+
+	if (cbd !=3D NULL) {
+		notify =3D g_free;
+		cb =3D cbd->cb;
+	}
+
+	DBG("(online =3D 1, offline =3D 0)): %i", online);
+
+	g_ril_request_power(rd->ril, (const gboolean) online, &rilp);
+
+	if (g_ril_send(rd->ril, RIL_REQUEST_RADIO_POWER, &rilp,
+			func, cbd, notify) =3D=3D 0 && cbd !=3D NULL) {
+
+		CALLBACK_WITH_FAILURE(cb, cbd->data);
+		g_free(cbd);
+	}
+}
+
+void ril_set_online(struct ofono_modem *modem, ofono_bool_t online,
+			ofono_modem_online_cb_t callback, void *data)
+{
+	struct ril_data *rd =3D ofono_modem_get_data(modem);
+	struct cb_data *cbd =3D cb_data_new(callback, data, rd);
+
+	rd->ofono_online =3D online;
+
+	DBG("setting rd->ofono_online to: %d", online);
+
+	ril_send_power(rd, online, ril_set_online_cb, cbd);
+}
+
+static void ril_connected(struct ril_msg *message, gpointer user_data)
+{
+	struct ofono_modem *modem =3D (struct ofono_modem *) user_data;
+	struct ril_data *rd =3D ofono_modem_get_data(modem);
+
+	ofono_info("[%d,UNSOL]< %s", g_ril_get_slot(rd->ril),
+		g_ril_unsol_request_to_string(rd->ril, message->req));
+
+	/* TODO: need a disconnect function to restart things! */
+	rd->connected =3D TRUE;
+
+	DBG("calling set_powered(TRUE)");
+
+	ofono_modem_set_powered(modem, TRUE);
+}
+
+static int create_gril(struct ofono_modem *modem)
+{
+	struct ril_data *rd =3D ofono_modem_get_data(modem);
+	int slot_id =3D ofono_modem_get_integer(modem, "Slot");
+
+	ofono_info("Using %s as socket for slot %d.",
+					RILD_CMD_SOCKET[slot_id], slot_id);
+	rd->ril =3D g_ril_new(RILD_CMD_SOCKET[slot_id], OFONO_RIL_VENDOR_AOSP);
+
+	/* NOTE: Since AT modems open a tty, and then call
+	 * g_at_chat_new(), they're able to return -EIO if
+	 * the first fails, and -ENOMEM if the second fails.
+	 * in our case, we already return -EIO if the ril_new
+	 * fails.  If this is important, we can create a ril_socket
+	 * abstraction... ( probaby not a bad idea ).
+	 */
+
+	if (rd->ril =3D=3D NULL) {
+		ofono_error("g_ril_new() failed to create modem!");
+		return -EIO;
+	}
+	g_ril_set_slot(rd->ril, slot_id);
+
+	if (getenv("OFONO_RIL_TRACE"))
+		g_ril_set_trace(rd->ril, TRUE);
+
+	if (getenv("OFONO_RIL_HEX_TRACE"))
+		g_ril_set_debugf(rd->ril, ril_debug, GRIL_HEX_PREFIX[slot_id]);
+
+	g_ril_register(rd->ril, RIL_UNSOL_RIL_CONNECTED,
+			ril_connected, modem);
+
+	g_ril_register(rd->ril, RIL_UNSOL_RESPONSE_RADIO_STATE_CHANGED,
+			ril_radio_state_changed, modem);
+
+	return 0;
+}
+
+static gboolean connect_rild(gpointer user_data)
+{
+	struct ofono_modem *modem =3D (struct ofono_modem *) user_data;
+	struct ril_data *rd =3D ofono_modem_get_data(modem);
+
+	ofono_info("Trying to reconnect to rild...");
+
+	if (rd->rild_connect_retries++ < RILD_MAX_CONNECT_RETRIES) {
+		if (create_gril(modem) < 0)
+			return TRUE;
+	} else {
+		ofono_error("Exiting, can't connect to rild.");
+		exit(0);
+	}
+
+	return FALSE;
+}
+
+int ril_enable(struct ofono_modem *modem)
+{
+	int ret;
+
+	DBG("");
+
+	ret =3D create_gril(modem);
+	if (ret < 0)
+		g_timeout_add_seconds(RILD_CONNECT_RETRY_TIME_S,
+					connect_rild, modem);
+
+	return -EINPROGRESS;
+}
+
+int ril_disable(struct ofono_modem *modem)
+{
+	struct ril_data *rd =3D ofono_modem_get_data(modem);
+
+	DBG("%p", modem);
+
+	ril_send_power(rd, FALSE, NULL, NULL);
+
+	return 0;
+}
+
+static struct ofono_modem_driver ril_driver =3D {
+	.name =3D "ril",
+	.probe =3D ril_probe,
+	.remove =3D ril_remove,
+	.enable =3D ril_enable,
+	.disable =3D ril_disable,
+	.pre_sim =3D ril_pre_sim,
+	.post_sim =3D ril_post_sim,
+	.post_online =3D ril_post_online,
+	.set_online =3D ril_set_online,
+};
+
+/*
+ * This plugin is a generic ( aka default ) device plugin for RIL-based de=
vices.
+ * The plugin 'rildev' is used to determine which RIL plugin should be loa=
ded
+ * based upon an environment variable.
+ */
+static int ril_init(void)
+{
+	int retval =3D ofono_modem_driver_register(&ril_driver);
+
+	if (retval !=3D 0)
+		DBG("ofono_modem_driver_register returned: %d", retval);
+
+	return retval;
+}
+
+static void ril_exit(void)
+{
+	DBG("");
+	ofono_modem_driver_unregister(&ril_driver);
+}
+
+OFONO_PLUGIN_DEFINE(ril, "RIL modem driver", VERSION,
+			OFONO_PLUGIN_PRIORITY_DEFAULT, ril_init, ril_exit)
diff --git a/plugins/ril.h b/plugins/ril.h
new file mode 100644
index 0000000..3897222
--- /dev/null
+++ b/plugins/ril.h
@@ -0,0 +1,30 @@
+/*
+ *
+ *  oFono - Open Source Telephony - RIL-based devices
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
+int ril_create(struct ofono_modem *modem, enum ofono_ril_vendor vendor);
+void ril_remove(struct ofono_modem *modem);
+int ril_enable(struct ofono_modem *modem);
+int ril_disable(struct ofono_modem *modem);
+void ril_pre_sim(struct ofono_modem *modem);
+void ril_post_sim(struct ofono_modem *modem);
+void ril_post_online(struct ofono_modem *modem);
+void ril_set_online(struct ofono_modem *modem, ofono_bool_t online,
+			ofono_modem_online_cb_t callback, void *data);
-- =

2.1.4


--===============6686956311622577225==--

