Content-Type: multipart/mixed; boundary="===============8631434666696973110=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 3/8] Add an atom for STK, move envelope command to stk driver.
Date: Fri, 09 Apr 2010 08:49:01 +0200
Message-ID: <1270795741-7156-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8631434666696973110==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 Makefile.am           |    4 +-
 drivers/atmodem/sim.c |   77 -------------------
 include/sim.h         |    3 -
 include/stk.h         |   71 +++++++++++++++++
 src/cbs.c             |   10 ++-
 src/modem.c           |    1 +
 src/ofono.h           |    4 +-
 src/sim.c             |   37 ---------
 src/stk.c             |  201 +++++++++++++++++++++++++++++++++++++++++++++=
++++
 9 files changed, 287 insertions(+), 121 deletions(-)
 create mode 100644 include/stk.h
 create mode 100644 src/stk.c

diff --git a/Makefile.am b/Makefile.am
index ee10095..7a18c41 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -12,7 +12,7 @@ include_HEADERS =3D include/log.h include/plugin.h includ=
e/history.h \
 			include/netreg.h include/voicecall.h include/devinfo.h \
 			include/cbs.h include/call-volume.h \
 			include/gprs.h include/gprs-context.h \
-			include/radio-settings.h
+			include/radio-settings.h include/stk.h
 =

 nodist_include_HEADERS =3D include/version.h
 =

@@ -231,7 +231,7 @@ src_ofonod_SOURCES =3D $(gdbus_sources) $(builtin_sourc=
es) \
 			src/network.c src/voicecall.c src/ussd.c src/sms.c \
 			src/call-settings.c src/call-forwarding.c \
 			src/call-meter.c src/smsutil.h src/smsutil.c \
-			src/ssn.c src/call-barring.c src/sim.c \
+			src/ssn.c src/call-barring.c src/sim.c src/stk.c \
 			src/phonebook.c src/history.c src/message-waiting.c \
 			src/simutil.h src/simutil.c src/storage.h \
 			src/storage.c src/cbs.c src/watch.c src/call-volume.c \
diff --git a/drivers/atmodem/sim.c b/drivers/atmodem/sim.c
index 89ddcc6..13e7459 100644
--- a/drivers/atmodem/sim.c
+++ b/drivers/atmodem/sim.c
@@ -709,82 +709,6 @@ error:
 	CALLBACK_WITH_FAILURE(cb, -1, data);
 }
 =

-static void at_csim_envelope_cb(gboolean ok, GAtResult *result,
-		gpointer user_data)
-{
-	struct cb_data *cbd =3D user_data;
-	GAtResultIter iter;
-	ofono_sim_read_cb_t cb =3D cbd->cb;
-	struct ofono_error error;
-	const guint8 *response;
-	gint rlen, len;
-
-	decode_at_error(&error, g_at_result_final_response(result));
-
-	if (!ok)
-		goto error;
-
-	g_at_result_iter_init(&iter, result);
-
-	if (!g_at_result_iter_next(&iter, "+CSIM:"))
-		goto error;
-
-	if (!g_at_result_iter_next_number(&iter, &rlen))
-		goto error;
-
-	if (!g_at_result_iter_next_hexstring(&iter, &response, &len))
-		goto error;
-
-	if (rlen !=3D len * 2 || len < 2 ||
-			response[len - 2] !=3D 0x90 || response[len - 1] !=3D 0)
-		goto error;
-
-	DBG("csim_envelope_cb: %i", len);
-
-	cb(&error, response, len - 2, cbd->data);
-	return;
-
-error:
-	CALLBACK_WITH_FAILURE(cb, NULL, 0, cbd->data);
-}
-
-static void at_sim_envelope(struct ofono_sim *sim, int length,
-				const guint8 *command,
-				ofono_sim_read_cb_t cb, void *data)
-{
-	struct sim_data *sd =3D ofono_sim_get_data(sim);
-	struct cb_data *cbd =3D cb_data_new(cb, data);
-	char *buf =3D g_try_new(char, 64 + length * 2);
-	int len, ret;
-
-	if (!cbd || !buf)
-		goto error;
-
-	len =3D sprintf(buf, "AT+CSIM=3D%i,A0C20000%02hhX",
-			10 + length * 2, length);
-
-	for (; length; length--)
-		len +=3D sprintf(buf + len, "%02hhX", *command++);
-
-	ret =3D g_at_chat_send(sd->chat, buf, crsm_prefix,
-				at_csim_envelope_cb, cbd, g_free);
-
-	g_free(buf);
-	buf =3D NULL;
-
-	if (ret > 0)
-		return;
-
-error:
-	if (buf)
-		g_free(buf);
-
-	if (cbd)
-		g_free(cbd);
-
-	CALLBACK_WITH_FAILURE(cb, NULL, 0, data);
-}
-
 static gboolean at_sim_register(gpointer user)
 {
 	struct ofono_sim *sim =3D user;
@@ -840,7 +764,6 @@ static struct ofono_sim_driver driver =3D {
 	.lock			=3D at_pin_enable,
 	.change_passwd		=3D at_change_passwd,
 	.query_locked		=3D at_pin_query_enabled,
-	.envelope		=3D at_sim_envelope,
 };
 =

 void at_sim_init()
diff --git a/include/sim.h b/include/sim.h
index 2218564..36a99b9 100644
--- a/include/sim.h
+++ b/include/sim.h
@@ -156,9 +156,6 @@ struct ofono_sim_driver {
 	void (*query_locked)(struct ofono_sim *sim,
 			enum ofono_sim_password_type type,
 			ofono_sim_locked_cb_t cb, void *data);
-	void (*envelope)(struct ofono_sim *sim, int length,
-				const guint8 *command,
-				ofono_sim_read_cb_t cb, void *data);
 };
 =

 int ofono_sim_driver_register(const struct ofono_sim_driver *d);
diff --git a/include/stk.h b/include/stk.h
new file mode 100644
index 0000000..dfae261
--- /dev/null
+++ b/include/stk.h
@@ -0,0 +1,71 @@
+/*
+ *
+ *  oFono - Open Source Telephony
+ *
+ *  Copyright (C) 2008-2010  Intel Corporation. All rights reserved.
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
+#ifndef __OFONO_STK_H
+#define __OFONO_STK_H
+
+#ifdef __cplusplus
+extern "C" {
+#endif
+
+#include <ofono/types.h>
+
+struct ofono_stk;
+
+typedef void (*ofono_stk_envelope_cb_t)(const struct ofono_error *error,
+		const unsigned char *rdata, int length, void *data);
+
+typedef void (*ofono_stk_generic_cb_t)(const struct ofono_error *error,
+		void *data);
+
+struct ofono_stk_driver {
+	const char *name;
+	int (*probe)(struct ofono_stk *stk, unsigned int vendor, void *data);
+	void (*remove)(struct ofono_stk *stk);
+	void (*envelope)(struct ofono_stk *stk, int length,
+			const guint8 *command, ofono_stk_envelope_cb_t cb,
+			void *data);
+	void (*terminal_response)(struct ofono_stk *stk, int length,
+			const unsigned char *value, ofono_stk_generic_cb_t cb,
+			void *data);
+};
+
+int ofono_stk_driver_register(const struct ofono_stk_driver *d);
+void ofono_stk_driver_unregister(const struct ofono_stk_driver *d);
+
+struct ofono_stk *ofono_stk_create(struct ofono_modem *modem,
+					unsigned int vendor,
+					const char *driver, void *data);
+
+void ofono_stk_register(struct ofono_stk *stk);
+void ofono_stk_remove(struct ofono_stk *stk);
+
+void ofono_stk_set_data(struct ofono_stk *stk, void *data);
+void *ofono_stk_get_data(struct ofono_stk *stk);
+
+void ofono_stk_proactive_command_notify(struct ofono_stk *stk,
+		int length, const guint8 *pdu);
+
+#ifdef __cplusplus
+}
+#endif
+
+#endif /* __OFONO_STK_H */
diff --git a/src/cbs.c b/src/cbs.c
index 2fa33c1..ff343e3 100644
--- a/src/cbs.c
+++ b/src/cbs.c
@@ -57,6 +57,7 @@ struct ofono_cbs {
 	GSList *topics;
 	GSList *new_topics;
 	struct ofono_sim *sim;
+	struct ofono_stk *stk;
 	struct ofono_netreg *netreg;
 	unsigned int netreg_watch;
 	unsigned int location_watch;
@@ -195,7 +196,7 @@ void ofono_cbs_notify(struct ofono_cbs *cbs, const unsi=
gned char *pdu,
 	}
 =

 	if (cbs_topic_in_range(c.message_identifier, cbs->efcbmid_contents)) {
-		__ofono_cbs_sim_download(cbs->sim, pdu, pdu_len);
+		__ofono_cbs_sim_download(cbs->stk, pdu, pdu_len);
 		return;
 	}
 =

@@ -590,6 +591,7 @@ static void cbs_unregister(struct ofono_atom *atom)
 	}
 =

 	cbs->sim =3D NULL;
+	cbs->stk =3D NULL;
 =

 	if (cbs->reset_source) {
 		g_source_remove(cbs->reset_source);
@@ -1027,6 +1029,7 @@ void ofono_cbs_register(struct ofono_cbs *cbs)
 	struct ofono_modem *modem =3D __ofono_atom_get_modem(cbs->atom);
 	const char *path =3D __ofono_atom_get_path(cbs->atom);
 	struct ofono_atom *sim_atom;
+	struct ofono_atom *stk_atom;
 	struct ofono_atom *netreg_atom;
 =

 	if (!g_dbus_register_interface(conn, path,
@@ -1050,6 +1053,11 @@ void ofono_cbs_register(struct ofono_cbs *cbs)
 			cbs_got_imsi(cbs);
 	}
 =

+	stk_atom =3D __ofono_modem_find_atom(modem, OFONO_ATOM_TYPE_SIM);
+
+	if (stk_atom)
+		cbs->stk =3D __ofono_atom_get_data(stk_atom);
+
 	cbs->netreg_watch =3D __ofono_modem_add_atom_watch(modem,
 					OFONO_ATOM_TYPE_NETREG,
 					netreg_watch, cbs, NULL);
diff --git a/src/modem.c b/src/modem.c
index df74be3..7cdd9c4 100644
--- a/src/modem.c
+++ b/src/modem.c
@@ -31,6 +31,7 @@
 #include <gdbus.h>
 =

 #include "ofono.h"
+#include "sim.h"
 =

 #include "common.h"
 =

diff --git a/src/ofono.h b/src/ofono.h
index ff67728..7b13cce 100644
--- a/src/ofono.h
+++ b/src/ofono.h
@@ -114,6 +114,7 @@ enum ofono_atom_type {
 	OFONO_ATOM_TYPE_GPRS =3D 16,
 	OFONO_ATOM_TYPE_GPRS_CONTEXT =3D 17,
 	OFONO_ATOM_TYPE_RADIO_SETTINGS =3D 18,
+	OFONO_ATOM_TYPE_STK =3D 19,
 };
 =

 enum ofono_atom_watch_condition {
@@ -172,8 +173,9 @@ void __ofono_atom_free(struct ofono_atom *atom);
 #include <ofono/radio-settings.h>
 =

 #include <ofono/sim.h>
+#include <ofono/stk.h>
 =

-void __ofono_cbs_sim_download(struct ofono_sim *sim,
+void __ofono_cbs_sim_download(struct ofono_stk *stk,
 				const guint8 *pdu, int pdu_len);
 =

 #include <ofono/ssn.h>
diff --git a/src/sim.c b/src/sim.c
index 5559be4..41ddd13 100644
--- a/src/sim.c
+++ b/src/sim.c
@@ -42,7 +42,6 @@
 #include "smsutil.h"
 #include "simutil.h"
 #include "storage.h"
-#include "stkutil.h"
 =

 #define SIM_CACHE_MODE 0600
 #define SIM_CACHE_PATH STORAGEDIR "/%s-%i/%04x"
@@ -1883,42 +1882,6 @@ static void sim_set_ready(struct ofono_sim *sim)
 	}
 }
 =

-static void sim_cb_download_cb(const struct ofono_error *error,
-				const unsigned char *data, int len, void *user)
-{
-	if (error->type !=3D OFONO_ERROR_TYPE_NO_ERROR) {
-		ofono_error("CellBroadcast download to UICC failed");
-		return;
-	}
-
-	DBG("CellBroadcast download to UICC reported no error");
-}
-
-void __ofono_cbs_sim_download(struct ofono_sim *sim,
-				const guint8 *pdu, int pdu_len)
-{
-	guint8 tlv[pdu_len + 8];
-
-	if (sim->state !=3D OFONO_SIM_STATE_READY)
-		return;
-
-	if (sim->driver->envelope =3D=3D NULL)
-		return;
-
-	tlv[0] =3D STK_ENVELOPE_TYPE_CBS_PP_DOWNLOAD;
-	tlv[1] =3D 6 + pdu_len;
-	tlv[2] =3D 0x80 | STK_DATA_OBJECT_TYPE_DEVICE_IDENTITIES;
-	tlv[3] =3D 0x02; /* Device Identities length */
-	tlv[4] =3D STK_DEVICE_IDENTITY_TYPE_NETWORK;
-	tlv[5] =3D STK_DEVICE_IDENTITY_TYPE_UICC;
-	tlv[6] =3D 0x80 | STK_DATA_OBJECT_TYPE_CBS_PAGE;
-	tlv[7] =3D pdu_len;
-
-	memcpy(tlv + 8, pdu, pdu_len);
-
-	sim->driver->envelope(sim, pdu_len + 8, tlv, sim_cb_download_cb, sim);
-}
-
 int ofono_sim_driver_register(const struct ofono_sim_driver *d)
 {
 	DBG("driver: %p, name: %s", d, d->name);
diff --git a/src/stk.c b/src/stk.c
new file mode 100644
index 0000000..5f76a86
--- /dev/null
+++ b/src/stk.c
@@ -0,0 +1,201 @@
+/*
+ *
+ *  oFono - Open Source Telephony
+ *
+ *  Copyright (C) 2008-2010  Intel Corporation. All rights reserved.
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
+
+#include <glib.h>
+#include <gdbus.h>
+#include <errno.h>
+
+#include "ofono.h"
+
+#include "smsutil.h"
+#include "stkutil.h"
+
+static GSList *g_drivers =3D NULL;
+
+struct ofono_stk {
+	const struct ofono_stk_driver *driver;
+	void *driver_data;
+	struct ofono_atom *atom;
+};
+
+static void stk_cb_download_cb(const struct ofono_error *error,
+				const unsigned char *data, int len, void *user)
+{
+	if (error->type !=3D OFONO_ERROR_TYPE_NO_ERROR) {
+		ofono_error("CellBroadcast download to UICC failed");
+		return;
+	}
+
+	DBG("CellBroadcast download to UICC reported no error");
+}
+
+void __ofono_cbs_sim_download(struct ofono_stk *stk,
+				const guint8 *pdu, int pdu_len)
+{
+	guint8 tlv[pdu_len + 8];
+
+	if (stk =3D=3D NULL)
+		return;
+
+	if (stk->driver->envelope =3D=3D NULL)
+		return;
+
+	tlv[0] =3D STK_ENVELOPE_TYPE_CBS_PP_DOWNLOAD;
+	tlv[1] =3D 6 + pdu_len;
+	tlv[2] =3D 0x80 | STK_DATA_OBJECT_TYPE_DEVICE_IDENTITIES;
+	tlv[3] =3D 0x02; /* Device Identities length */
+	tlv[4] =3D STK_DEVICE_IDENTITY_TYPE_NETWORK;
+	tlv[5] =3D STK_DEVICE_IDENTITY_TYPE_UICC;
+	tlv[6] =3D 0x80 | STK_DATA_OBJECT_TYPE_CBS_PAGE;
+	tlv[7] =3D pdu_len;
+
+	memcpy(tlv + 8, pdu, pdu_len);
+
+	stk->driver->envelope(stk, pdu_len + 8, tlv, stk_cb_download_cb, stk);
+}
+
+void ofono_stk_proactive_command_notify(struct ofono_stk *stk,
+		int length, const guint8 *pdu)
+{
+	struct stk_command *cmd;
+	char *buf;
+	int i;
+
+	buf =3D g_try_new(char, length * 2 + 1);
+	for (i =3D 0; i < length; i ++)
+		sprintf(buf + i * 2, "%02hhx", pdu[i]);
+	DBG("Proactive command PDU: %s", buf);
+
+	cmd =3D stk_command_new_from_pdu(pdu, length);
+	if (!cmd) {
+		ofono_error("Can't parse proactive command: %s", buf);
+		g_free(buf);
+
+		/* TODO: return TERMINAL RESPONSE with permanent error */
+		return;
+	}
+
+	/* TODO: execute */
+
+	g_free(buf);
+	stk_command_free(cmd);
+}
+
+int ofono_stk_driver_register(const struct ofono_stk_driver *d)
+{
+	DBG("driver: %p, name: %s", d, d->name);
+
+	if (d->probe =3D=3D NULL)
+		return -EINVAL;
+
+	g_drivers =3D g_slist_prepend(g_drivers, (void *)d);
+
+	return 0;
+}
+
+void ofono_stk_driver_unregister(const struct ofono_stk_driver *d)
+{
+	DBG("driver: %p, name: %s", d, d->name);
+
+	g_drivers =3D g_slist_remove(g_drivers, (void *)d);
+}
+
+static void stk_unregister(struct ofono_atom *atom)
+{
+}
+
+static void stk_remove(struct ofono_atom *atom)
+{
+	struct ofono_stk *stk =3D __ofono_atom_get_data(atom);
+
+	DBG("atom: %p", atom);
+
+	if (stk =3D=3D NULL)
+		return;
+
+	if (stk->driver && stk->driver->remove)
+		stk->driver->remove(stk);
+
+	g_free(stk);
+}
+
+struct ofono_stk *ofono_stk_create(struct ofono_modem *modem,
+					unsigned int vendor,
+					const char *driver,
+					void *data)
+{
+	struct ofono_stk *stk;
+	GSList *l;
+
+	if (driver =3D=3D NULL)
+		return NULL;
+
+	stk =3D g_try_new0(struct ofono_stk, 1);
+
+	if (stk =3D=3D NULL)
+		return NULL;
+
+	stk->atom =3D __ofono_modem_add_atom(modem, OFONO_ATOM_TYPE_STK,
+						stk_remove, stk);
+
+	for (l =3D g_drivers; l; l =3D l->next) {
+		const struct ofono_stk_driver *drv =3D l->data;
+
+		if (g_strcmp0(drv->name, driver))
+			continue;
+
+		if (drv->probe(stk, vendor, data) < 0)
+			continue;
+
+		stk->driver =3D drv;
+		break;
+	}
+
+	return stk;
+}
+
+void ofono_stk_register(struct ofono_stk *stk)
+{
+	__ofono_atom_register(stk->atom, stk_unregister);
+}
+
+void ofono_stk_remove(struct ofono_stk *stk)
+{
+	__ofono_atom_free(stk->atom);
+}
+
+void ofono_stk_set_data(struct ofono_stk *stk, void *data)
+{
+	stk->driver_data =3D data;
+}
+
+void *ofono_stk_get_data(struct ofono_stk *stk)
+{
+	return stk->driver_data;
+}
-- =

1.6.1


--===============8631434666696973110==--

