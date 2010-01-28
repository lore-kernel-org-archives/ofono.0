Content-Type: multipart/mixed; boundary="===============9087718685343584503=="
MIME-Version: 1.0
From: sjur.brandeland@stericsson.com
Subject: [PATCH] Add STE voice call support.
Date: Thu, 28 Jan 2010 15:23:02 +0100
Message-ID: <1264688583-9253-1-git-send-email-sjur.brandeland@stericsson.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============9087718685343584503==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Sjur Br=C3=A6ndeland <sjur.brandeland@stericsson.com>

---
 Makefile.am                  |    1 +
 drivers/stemodem/stemodem.c  |    2 +
 drivers/stemodem/stemodem.h  |    3 +
 drivers/stemodem/voicecall.c |  596 ++++++++++++++++++++++++++++++++++++++=
++++
 plugins/ste.c                |    2 +-
 5 files changed, 603 insertions(+), 1 deletions(-)
 create mode 100644 drivers/stemodem/voicecall.c

diff --git a/Makefile.am b/Makefile.am
index ac13d73..ecd2660 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -159,6 +159,7 @@ builtin_sources +=3D drivers/atmodem/atutil.h \
 			drivers/stemodem/stemodem.h \
 			drivers/stemodem/stemodem.c \
 			drivers/stemodem/gprs-context.c \
+			drivers/stemodem/voicecall.c \
 			drivers/stemodem/caif_socket.h \
 			drivers/stemodem/if_caif.h
 =

diff --git a/drivers/stemodem/stemodem.c b/drivers/stemodem/stemodem.c
index 53207db..9184a42 100644
--- a/drivers/stemodem/stemodem.c
+++ b/drivers/stemodem/stemodem.c
@@ -37,6 +37,7 @@
 static int stemodem_init(void)
 {
 	ste_gprs_context_init();
+	ste_voicecall_init();
 =

 	return 0;
 }
@@ -44,6 +45,7 @@ static int stemodem_init(void)
 static void stemodem_exit(void)
 {
 	ste_gprs_context_exit();
+	ste_voicecall_exit();
 }
 =

 OFONO_PLUGIN_DEFINE(stemodem, "STE modem driver", VERSION,
diff --git a/drivers/stemodem/stemodem.h b/drivers/stemodem/stemodem.h
index e55a2c3..e7c6934 100644
--- a/drivers/stemodem/stemodem.h
+++ b/drivers/stemodem/stemodem.h
@@ -25,3 +25,6 @@
 extern void ste_gprs_context_init();
 extern void ste_gprs_context_exit();
 =

+extern void ste_voicecall_init();
+extern void ste_voicecall_exit();
+
diff --git a/drivers/stemodem/voicecall.c b/drivers/stemodem/voicecall.c
new file mode 100644
index 0000000..e74aa3d
--- /dev/null
+++ b/drivers/stemodem/voicecall.c
@@ -0,0 +1,596 @@
+/*
+ *
+ *  oFono - Open Source Telephony
+ *
+ *  Copyright (C) 2008-2009  Intel Corporation. All rights reserved.
+ *  Copyright (C) 2010 ST-Ericsson AB.
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
+
+#include <glib.h>
+
+#include <ofono/log.h>
+#include <ofono/modem.h>
+#include <ofono/voicecall.h>
+
+#include "gatchat.h"
+#include "gatresult.h"
+#include "common.h"
+
+#include "stemodem.h"
+
+enum call_status_ste {
+	STE_CALL_STATUS_IDLE =3D 0,
+	STE_CALL_STATUS_CALLING =3D 1,
+	STE_CALL_STATUS_CONNECTING =3D 2,
+	STE_CALL_STATUS_ACTIVE =3D 3,
+	STE_CALL_STATUS_HOLD =3D 4,
+	STE_CALL_STATUS_WAITING =3D 5,
+	STE_CALL_STATUS_ALERTING =3D 6,
+	STE_CALL_STATUS_BUSY =3D 7
+};
+
+static const char *none_prefix[] =3D { NULL };
+
+struct voicecall_data {
+	GSList *calls;
+	unsigned int local_release;
+	GAtChat *chat;
+};
+
+struct release_id_req {
+	struct ofono_voicecall *vc;
+	ofono_voicecall_cb_t cb;
+	void *data;
+	int id;
+};
+
+struct change_state_req {
+	struct ofono_voicecall *vc;
+	ofono_voicecall_cb_t cb;
+	void *data;
+	int affected_types;
+};
+
+/* Translate from the ECAV-based STE-status to CLCC based status */
+static int call_status_ste_to_ofono(int status)
+{
+	switch (status) {
+	case STE_CALL_STATUS_IDLE:
+		return CALL_STATUS_DISCONNECTED;
+	case STE_CALL_STATUS_CALLING:
+		return CALL_STATUS_DIALING;
+	case STE_CALL_STATUS_CONNECTING:
+		return CALL_STATUS_ALERTING;
+	case STE_CALL_STATUS_ACTIVE:
+		return CALL_STATUS_ACTIVE;
+	case STE_CALL_STATUS_HOLD:
+		return CALL_STATUS_HELD;
+	case STE_CALL_STATUS_WAITING:
+		return CALL_STATUS_WAITING;
+	case STE_CALL_STATUS_ALERTING:
+		return CALL_STATUS_INCOMING;
+	case STE_CALL_STATUS_BUSY:
+		return CALL_STATUS_DISCONNECTED;
+	default:
+		return CALL_STATUS_DISCONNECTED;
+	}
+}
+
+static struct ofono_call *create_call(struct ofono_voicecall *vc, int type,
+					int direction, int status,
+					const char *num, int num_type, int clip)
+{
+	struct voicecall_data *d =3D ofono_voicecall_get_data(vc);
+	struct ofono_call *call;
+
+	/* Generate a call structure for the waiting call */
+	call =3D g_try_new0(struct ofono_call, 1);
+	if (!call)
+		return NULL;
+
+	call->type =3D type;
+	call->direction =3D direction;
+	call->status =3D status;
+
+	if (clip !=3D 2) {
+		strncpy(call->phone_number.number, num,
+			OFONO_MAX_PHONE_NUMBER_LENGTH);
+		call->phone_number.type =3D num_type;
+	}
+
+	call->clip_validity =3D clip;
+
+	d->calls =3D g_slist_insert_sorted(d->calls, call, at_util_call_compare);
+
+	return call;
+}
+
+static void ste_generic_cb(gboolean ok, GAtResult *result, gpointer user_d=
ata)
+{
+	struct change_state_req *req =3D user_data;
+	struct voicecall_data *vd =3D ofono_voicecall_get_data(req->vc);
+	struct ofono_error error;
+
+	dump_response("ste_generic_cb", ok, result);
+	decode_at_error(&error, g_at_result_final_response(result));
+
+	if (ok && req->affected_types) {
+		GSList *l;
+		struct ofono_call *call;
+
+		for (l =3D vd->calls; l; l =3D l->next) {
+			call =3D l->data;
+
+			if (req->affected_types & (0x1 << call->status))
+				vd->local_release |=3D (0x1 << call->id);
+		}
+	}
+
+	req->cb(&error, req->data);
+}
+
+static void release_id_cb(gboolean ok, GAtResult *result,
+				gpointer user_data)
+{
+	struct release_id_req *req =3D user_data;
+	struct voicecall_data *vd =3D ofono_voicecall_get_data(req->vc);
+	struct ofono_error error;
+
+	dump_response("release_id_cb", ok, result);
+	decode_at_error(&error, g_at_result_final_response(result));
+
+	if (ok)
+		vd->local_release =3D 0x1 << req->id;
+
+	req->cb(&error, req->data);
+}
+
+static void atd_cb(gboolean ok, GAtResult *result, gpointer user_data)
+{
+	struct cb_data *cbd =3D user_data;
+	struct ofono_error error;
+	ofono_voicecall_cb_t cb =3D cbd->cb;
+
+	dump_response("atd_cb", ok, result);
+
+	decode_at_error(&error, g_at_result_final_response(result));
+
+	cb(&error, cbd->data);
+}
+
+static void ste_dial(struct ofono_voicecall *vc,
+			const struct ofono_phone_number *ph,
+			enum ofono_clir_option clir, enum ofono_cug_option cug,
+			ofono_voicecall_cb_t cb, void *data)
+{
+	struct voicecall_data *vd =3D ofono_voicecall_get_data(vc);
+	struct cb_data *cbd =3D cb_data_new(cb, data);
+	char buf[256];
+
+	if (!cbd)
+		goto error;
+
+	cbd->user =3D vc;
+
+	if (ph->type =3D=3D 145)
+		sprintf(buf, "ATD+%s", ph->number);
+	else
+		sprintf(buf, "ATD%s", ph->number);
+
+	switch (clir) {
+	case OFONO_CLIR_OPTION_INVOCATION:
+		strcat(buf, "I");
+		break;
+	case OFONO_CLIR_OPTION_SUPPRESSION:
+		strcat(buf, "i");
+		break;
+	default:
+		break;
+	}
+
+	switch (cug) {
+	case OFONO_CUG_OPTION_INVOCATION:
+		strcat(buf, "G");
+		break;
+	default:
+		break;
+	}
+
+	strcat(buf, ";");
+
+	if (g_at_chat_send(vd->chat, buf, none_prefix,
+				atd_cb, cbd, g_free) > 0)
+		return;
+
+error:
+	if (cbd)
+		g_free(cbd);
+
+	CALLBACK_WITH_FAILURE(cb, data);
+}
+
+static void ste_template(const char *cmd, struct ofono_voicecall *vc,
+			GAtResultFunc result_cb, unsigned int affected_types,
+			ofono_voicecall_cb_t cb, void *data)
+{
+	struct voicecall_data *vd =3D ofono_voicecall_get_data(vc);
+	struct change_state_req *req =3D g_try_new0(struct change_state_req, 1);
+
+	if (!req)
+		goto error;
+
+	req->vc =3D vc;
+	req->cb =3D cb;
+	req->data =3D data;
+	req->affected_types =3D affected_types;
+
+	if (g_at_chat_send(vd->chat, cmd, none_prefix,
+				result_cb, req, g_free) > 0)
+		return;
+
+error:
+	if (req)
+		g_free(req);
+
+	CALLBACK_WITH_FAILURE(cb, data);
+}
+
+static void ste_answer(struct ofono_voicecall *vc,
+			ofono_voicecall_cb_t cb, void *data)
+{
+	ste_template("ATA", vc, ste_generic_cb, 0, cb, data);
+}
+
+static void ste_hangup(struct ofono_voicecall *vc,
+			ofono_voicecall_cb_t cb, void *data)
+{
+	ste_template("AT+CHUP", vc, ste_generic_cb, 0x3f, cb, data);
+}
+
+static void ste_hold_all_active(struct ofono_voicecall *vc,
+				ofono_voicecall_cb_t cb, void *data)
+{
+	ste_template("AT+CHLD=3D2", vc, ste_generic_cb, 0, cb, data);
+}
+
+static void ste_release_all_held(struct ofono_voicecall *vc,
+				ofono_voicecall_cb_t cb, void *data)
+{
+	unsigned int held_status =3D 0x1 << 1;
+	ste_template("AT+CHLD=3D0", vc, ste_generic_cb, held_status, cb, data);
+}
+
+static void ste_set_udub(struct ofono_voicecall *vc,
+			ofono_voicecall_cb_t cb, void *data)
+{
+	unsigned int incoming_or_waiting =3D (0x1 << 4) | (0x1 << 5);
+	ste_template("AT+CHLD=3D0", vc, ste_generic_cb, incoming_or_waiting,
+			cb, data);
+}
+
+static void ste_release_all_active(struct ofono_voicecall *vc,
+					ofono_voicecall_cb_t cb, void *data)
+{
+	ste_template("AT+CHLD=3D1", vc, ste_generic_cb, 0x1, cb, data);
+}
+
+static void ste_release_specific(struct ofono_voicecall *vc, int id,
+				ofono_voicecall_cb_t cb, void *data)
+{
+	struct voicecall_data *vd =3D ofono_voicecall_get_data(vc);
+	struct release_id_req *req =3D g_try_new0(struct release_id_req, 1);
+	char buf[32];
+
+	if (!req)
+		goto error;
+
+	req->vc =3D vc;
+	req->cb =3D cb;
+	req->data =3D data;
+	req->id =3D id;
+
+	sprintf(buf, "AT+CHLD=3D1%d", id);
+
+	if (g_at_chat_send(vd->chat, buf, none_prefix,
+				release_id_cb, req, g_free) > 0)
+		return;
+
+error:
+	if (req)
+		g_free(req);
+
+	CALLBACK_WITH_FAILURE(cb, data);
+}
+
+static void ste_private_chat(struct ofono_voicecall *vc, int id,
+				ofono_voicecall_cb_t cb, void *data)
+{
+	char buf[32];
+
+	sprintf(buf, "AT+CHLD=3D2%d", id);
+	ste_template(buf, vc, ste_generic_cb, 0, cb, data);
+}
+
+static void ste_create_multiparty(struct ofono_voicecall *vc,
+					ofono_voicecall_cb_t cb, void *data)
+{
+	ste_template("AT+CHLD=3D3", vc, ste_generic_cb, 0, cb, data);
+}
+
+static void ste_transfer(struct ofono_voicecall *vc,
+			ofono_voicecall_cb_t cb, void *data)
+{
+	/* Held & Active */
+	unsigned int transfer =3D 0x1 | 0x2;
+
+	/* Transfer can puts held & active calls together and disconnects
+	 * from both.  However, some networks support transfering of
+	 * dialing/ringing calls as well.
+	 */
+	transfer |=3D 0x4 | 0x8;
+
+	ste_template("AT+CHLD=3D4", vc, ste_generic_cb, transfer, cb, data);
+}
+
+static void ste_deflect(struct ofono_voicecall *vc,
+			const struct ofono_phone_number *ph,
+			ofono_voicecall_cb_t cb, void *data)
+{
+	char buf[128];
+	unsigned int incoming_or_waiting =3D (0x1 << 4) | (0x1 << 5);
+
+	sprintf(buf, "AT+CTFR=3D\"%s\",%d", ph->number, ph->type);
+	ste_template(buf, vc, ste_generic_cb, incoming_or_waiting, cb, data);
+}
+
+static void vts_cb(gboolean ok, GAtResult *result, gpointer user_data)
+{
+	struct cb_data *cbd =3D user_data;
+	ofono_voicecall_cb_t cb =3D cbd->cb;
+	struct ofono_error error;
+
+	dump_response("vts_cb", ok, result);
+	decode_at_error(&error, g_at_result_final_response(result));
+	cb(&error, cbd->data);
+}
+
+static void ste_send_dtmf(struct ofono_voicecall *vc, const char *dtmf,
+			ofono_voicecall_cb_t cb, void *data)
+{
+	struct voicecall_data *vd =3D ofono_voicecall_get_data(vc);
+	struct cb_data *cbd =3D cb_data_new(cb, data);
+	int len =3D strlen(dtmf);
+	int s;
+	char *buf;
+
+	if (!cbd)
+		goto error;
+
+	/* strlen("AT+VTS=3D) =3D 7 */
+	buf =3D g_try_new(char, len + 7);
+
+	if (!buf)
+		goto error;
+
+	sprintf(buf, "AT+VTS=3D%s", dtmf);
+
+	s =3D g_at_chat_send(vd->chat, buf, none_prefix,
+				vts_cb, cbd, g_free);
+
+	g_free(buf);
+
+	if (s > 0)
+		return;
+
+error:
+	if (cbd)
+		g_free(cbd);
+
+	CALLBACK_WITH_FAILURE(cb, data);
+}
+
+static void ecav_notify(GAtResult *result, gpointer user_data)
+{
+	struct ofono_voicecall *vc =3D user_data;
+	struct voicecall_data *vd =3D ofono_voicecall_get_data(vc);
+	GAtResultIter iter;
+	const char *num;
+	int id;
+	int status;
+	int call_type;
+	int num_type;
+	struct ofono_call *new_call;
+	struct ofono_call *existing_call =3D NULL;
+	GSList *l;
+
+	/* Parse ECAV */
+	dump_response("ecav_notify", TRUE, result);
+
+	g_at_result_iter_init(&iter, result);
+
+	if (!g_at_result_iter_next(&iter, "*ECAV:"))
+		return;
+
+	if (!g_at_result_iter_next_number(&iter, &id))
+		return;
+
+	if (!g_at_result_iter_next_number(&iter, &status))
+		return;
+
+	if (!g_at_result_iter_next_number(&iter, &call_type))
+		return;
+
+	/* Skip process id and exit cause */
+	g_at_result_iter_skip_next(&iter);
+	g_at_result_iter_skip_next(&iter);
+
+	status =3D call_status_ste_to_ofono(status);
+	if (status =3D=3D CALL_STATUS_DIALING ||
+	    status =3D=3D CALL_STATUS_WAITING ||
+	    status =3D=3D CALL_STATUS_INCOMING) {
+		if (!g_at_result_iter_next_string(&iter, &num))
+			return;
+
+		if (!g_at_result_iter_next_number(&iter, &num_type))
+			return;
+	}
+
+	if (call_type !=3D BEARER_CLASS_VOICE)
+		return;
+
+	/*
+	 * Handle the call according to the status.
+	 * If it doesn't exists we make a new one
+	 */
+	l =3D g_slist_find_custom(vd->calls, GUINT_TO_POINTER(id),
+				at_util_call_compare_by_id);
+	if (l)
+		existing_call =3D l->data;
+
+	if (l =3D=3D NULL && status !=3D CALL_STATUS_DIALING &&
+					 status !=3D CALL_STATUS_WAITING &&
+					 status !=3D CALL_STATUS_INCOMING) {
+		ofono_error("ECAV notification for unknow call."
+			    " id: %d, status: %d", id, status);
+		return;
+	}
+
+	switch (status) {
+	case CALL_STATUS_DISCONNECTED: {
+		enum ofono_disconnect_reason reason;
+
+		existing_call->status =3D status;
+
+		if (vd->local_release & (0x1 << existing_call->id))
+			reason =3D OFONO_DISCONNECT_REASON_LOCAL_HANGUP;
+		else
+			reason =3D OFONO_DISCONNECT_REASON_REMOTE_HANGUP;
+
+		ofono_voicecall_disconnected(vc, existing_call->id,
+					     reason, NULL);
+
+		vd->calls =3D g_slist_remove(vd->calls, l->data);
+		break;
+	}
+	case CALL_STATUS_DIALING:
+	case CALL_STATUS_WAITING:
+	case CALL_STATUS_INCOMING: {
+		int clip_validity;
+		int direction;
+
+		if (status =3D=3D CALL_STATUS_DIALING)
+			direction =3D CALL_DIRECTION_MOBILE_ORIGINATED;
+		else
+			direction =3D CALL_DIRECTION_MOBILE_TERMINATED;
+
+		if ((strlen(num)) > 0)
+			clip_validity =3D CLIP_VALIDITY_VALID;
+		else
+			clip_validity =3D CLIP_VALIDITY_NOT_AVAILABLE;
+
+		new_call =3D create_call(vc, call_type, direction, status,
+				       num, num_type, clip_validity);
+		if (!new_call) {
+			ofono_error("Unable to malloc. "
+				    "Call management is fubar");
+			return;
+		}
+
+		new_call->id =3D id;
+		ofono_voicecall_notify(vc, new_call);
+		break;
+	}
+	case CALL_STATUS_ALERTING:
+	case CALL_STATUS_ACTIVE:
+	case CALL_STATUS_HELD:
+		existing_call->status =3D status;
+		ofono_voicecall_notify(vc, existing_call);
+		break;
+	default:
+		break;
+	}
+}
+
+
+static int ste_voicecall_probe(struct ofono_voicecall *vc, unsigned int ve=
ndor,
+				void *data)
+{
+	GAtChat *chat =3D data;
+	struct voicecall_data *vd;
+
+	vd =3D g_new0(struct voicecall_data, 1);
+	vd->chat =3D chat;
+
+	ofono_voicecall_set_data(vc, vd);
+
+	g_at_chat_send(chat, "AT*ECAM=3D1", NULL, NULL, NULL, NULL);
+	g_at_chat_register(chat, "*ECAV:", ecav_notify, FALSE, vc, NULL);
+	ofono_voicecall_register(vc);
+
+	return 0;
+}
+
+static void ste_voicecall_remove(struct ofono_voicecall *vc)
+{
+	struct voicecall_data *vd =3D ofono_voicecall_get_data(vc);
+
+	g_slist_foreach(vd->calls, (GFunc) g_free, NULL);
+	g_slist_free(vd->calls);
+
+	ofono_voicecall_set_data(vc, NULL);
+
+	g_free(vd);
+}
+
+static struct ofono_voicecall_driver driver =3D {
+	.name			=3D "stemodem",
+	.probe			=3D ste_voicecall_probe,
+	.remove			=3D ste_voicecall_remove,
+	.dial			=3D ste_dial,
+	.answer			=3D ste_answer,
+	.hangup			=3D ste_hangup,
+	.hold_all_active	=3D ste_hold_all_active,
+	.release_all_held	=3D ste_release_all_held,
+	.set_udub		=3D ste_set_udub,
+	.release_all_active	=3D ste_release_all_active,
+	.release_specific	=3D ste_release_specific,
+	.private_chat		=3D ste_private_chat,
+	.create_multiparty	=3D ste_create_multiparty,
+	.transfer		=3D ste_transfer,
+	.deflect		=3D ste_deflect,
+	.swap_without_accept	=3D NULL,
+	.send_tones		=3D ste_send_dtmf
+};
+
+void ste_voicecall_init()
+{
+	ofono_voicecall_driver_register(&driver);
+}
+
+void ste_voicecall_exit()
+{
+	ofono_voicecall_driver_unregister(&driver);
+}
diff --git a/plugins/ste.c b/plugins/ste.c
index 172e3bf..34550c8 100644
--- a/plugins/ste.c
+++ b/plugins/ste.c
@@ -198,7 +198,7 @@ static void ste_pre_sim(struct ofono_modem *modem)
 =

 	ofono_devinfo_create(modem, 0, "atmodem", data->chat);
 	ofono_sim_create(modem, 0, "atmodem", data->chat);
-	ofono_voicecall_create(modem, 0, "atmodem", data->chat);
+	ofono_voicecall_create(modem, 0, "stemodem", data->chat);
 }
 =

 static void ste_post_sim(struct ofono_modem *modem)
-- =

1.6.3.3


--===============9087718685343584503==--

