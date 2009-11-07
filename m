Content-Type: multipart/mixed; boundary="===============2287281657079979429=="
MIME-Version: 1.0
From: Zhenhua Zhang <zhenhua.zhang@intel.com>
Subject: [PATCH 1/3] Add multi calls support for HFP voicecall driver
Date: Sat, 07 Nov 2009 15:25:48 +0800
Message-ID: <1257578748.2888.16.camel@zzhan17-mobl.ccr.corp.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2287281657079979429==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

These 3 patches are new multi calls and multiparty call features
support for HFP voicecall driver. So I seperate them with previous
small patches.

I divide big chunk into 3 parts. The first one is multi calls support.
The second is multiparty call support and the latest is send_dtmf
and list_calls implementation.

My test device is iPhone 3G and LG KM900. If you meet problems with
the patch, please paste your log while turning on OFONO_AT_DEBUG and
let me know. Thanks.


This feature is to enable CHLD=3D0, 1 and 2. We have considered
following issues:

1. Some phones shift call index when a smaller index call is
released. So we use phone number to compare status in clcc_poll_cb.

2. Some phones fail to response after CHLD=3D0, 1, 2. Need to poll
status after 2 seconds interval. But if we have another dialing
call, we need cancel +CLCC poll in atd_cb because the new call
is not avaiable until callsetup=3D3 at AG side.

3. In release_specific, if user want to release a hold call, we
first swap the call and then release it.

4. When only one call left in multi calls, we reset ciev_call and
ciev_callsetup status to avoid wrong +CIEV call/callsetup indicator
from previous released call.
---
 drivers/hfpmodem/voicecall.c |  352
+++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 345 insertions(+), 7 deletions(-)

diff --git a/drivers/hfpmodem/voicecall.c b/drivers/hfpmodem/voicecall.c
index b1d144b..43b4c01 100644
--- a/drivers/hfpmodem/voicecall.c
+++ b/drivers/hfpmodem/voicecall.c
@@ -47,6 +47,8 @@
 #define AG_CHLD_3 0x20
 #define AG_CHLD_4 0x40
 =

+#define POLL_CLCC_INTERVAL 2000
+
 static const char *none_prefix[] =3D { NULL };
 static const char *chld_prefix[] =3D { "+CHLD:", NULL };
 static const char *clcc_prefix[] =3D { "+CLCC:", NULL };
@@ -61,6 +63,7 @@ struct voicecall_data {
 	int cind_val[HFP_INDICATOR_LAST];
 	unsigned int id_list;
 	unsigned int local_release;
+	unsigned int clcc_source;
 };
 =

 struct release_id_req {
@@ -252,6 +255,13 @@ static void atd_cb(gboolean ok, GAtResult *result,
gpointer user_data)
 	if (!ok)
 		goto out;
 =

+	/* Disable multiparty call if phone does not support +CLCC */
+	if (vd->call && !(vd->ag_features & AG_FEATURE_ENHANCED_CALL_STATUS))
{
+		ofono_error("Phone does NOT support enhanced "
+				" call status feature, fail to create call");
+		goto out;
+	}
+
 	call =3D create_call(vd, 0, 0, CALL_STATUS_DIALING,
 					ph.number, ph.type, 0);
 =

@@ -276,6 +286,14 @@ static void hfp_dial(struct ofono_voicecall *vc,
 	struct atd_cb_data *cbd;
 	char buf[256];
 =

+	/* Remove +CLCC request if we swap the calls before. See comments in
+	 * hfp_hold_all_active.
+	 */
+	if (vd->clcc_source) {
+		g_source_remove(vd->clcc_source);
+		vd->clcc_source =3D 0;
+	}
+
 	cbd =3D g_try_new0(struct atd_cb_data, 1);
 =

 	if (!cbd)
@@ -348,6 +366,253 @@ static void hfp_hangup(struct ofono_voicecall *vc,
 	hfp_template("AT+CHUP", vc, generic_cb, 0x3f, cb, data);
 }
 =

+static void reset_to_single_call(struct voicecall_data *vd)
+{
+	struct ofono_call *oc =3D vd->calls->data;
+
+	vd->call =3D oc;
+	vd->cind_val[HFP_INDICATOR_CALL] =3D 1;
+
+	if (oc->direction =3D=3D 1)
+		vd->cind_val[HFP_INDICATOR_CALLSETUP] =3D 1;
+	else
+		vd->cind_val[HFP_INDICATOR_CALLSETUP] =3D 3;
+}
+
+static void clcc_poll_cb(gboolean ok, GAtResult *result, gpointer
user_data)
+{
+	struct ofono_voicecall *vc =3D user_data;
+	struct voicecall_data *vd =3D ofono_voicecall_get_data(vc);
+	GSList *n;
+	GSList *c;
+	GSList *o =3D vd->calls;
+	struct ofono_call *nc, *oc;
+	struct ofono_error error;
+
+	dump_response("clcc_poll_cb", ok, result);
+	decode_at_error(&error, g_at_result_final_response(result));
+
+	if (!ok)
+		return;
+
+	n =3D parse_clcc(result);
+
+	while (o) {
+		oc =3D o->data;
+
+		/* Call index may be shift when another call is released.
+		 * So we can only find call by phone number.
+		 */
+		c =3D g_slist_find_custom(n, &oc->phone_number,
+					at_util_call_compare_by_phone_number);
+
+		if (c) {
+			nc =3D c->data;
+
+			if (memcmp(nc, oc, sizeof(struct ofono_call))) {
+				oc->status =3D nc->status;
+
+				/* If phone does not support multiparty call,
+				 * there will have only one active call at one
+				 * time. +CHUP only hang up current active call.
+				 */
+				if (oc->status =3D=3D CALL_STATUS_ACTIVE)
+					vd->call =3D oc;
+
+				ofono_voicecall_notify(vc, oc);
+			}
+
+			o =3D o->next;
+		} else {
+			release_call(vc, oc);
+			o =3D vd->calls;
+		}
+	}
+
+	g_slist_foreach(n, (GFunc) g_free, NULL);
+	g_slist_free(n);
+
+	/* Reset ciev_call and ciev_callsetup based on call info when only one
+	 * call is left
+	 */
+	if (g_slist_length(vd->calls) =3D=3D 1)
+		reset_to_single_call(vd);
+}
+
+static gboolean poll_clcc(gpointer user_data)
+{
+	struct ofono_voicecall *vc =3D user_data;
+	struct voicecall_data *vd =3D ofono_voicecall_get_data(vc);
+
+	if (vd->ag_features & AG_FEATURE_ENHANCED_CALL_STATUS) {
+		g_at_chat_send(vd->chat, "AT+CLCC", clcc_prefix,
+					clcc_poll_cb, vc, NULL);
+
+		vd->clcc_source =3D 0;
+	}
+
+	return FALSE;
+}
+
+static gboolean check_mpty_feature(struct ofono_voicecall *vc,
+				unsigned int feature,
+				ofono_voicecall_cb_t cb, void *data)
+{
+	struct voicecall_data *vd =3D ofono_voicecall_get_data(vc);
+
+	if (vd->ag_mpty_features & feature)
+		return TRUE;
+
+	CALLBACK_WITH_FAILURE(cb, data);
+	return FALSE;
+}
+
+static void hfp_hold_all_active(struct ofono_voicecall *vc,
+				ofono_voicecall_cb_t cb, void *data)
+{
+	struct voicecall_data *vd =3D ofono_voicecall_get_data(vc);
+
+	if (check_mpty_feature(vc, AG_CHLD_2, cb, data)) {
+		hfp_template("AT+CHLD=3D2", vc, generic_cb, 0, cb, data);
+
+		/* Some phones fail to send response back after CHLD=3D2.
+		 * But if we have another dialing out call, we should hold
+		 * +CLCC until AG creates the new call.
+		 */
+		vd->clcc_source =3D g_timeout_add(POLL_CLCC_INTERVAL,
+						poll_clcc, vc);
+	}
+}
+
+static void hfp_release_all_held(struct ofono_voicecall *vc,
+				ofono_voicecall_cb_t cb, void *data)
+{
+	if (check_mpty_feature(vc, AG_CHLD_0, cb, data))
+		hfp_template("AT+CHLD=3D0", vc, generic_cb, 0x10, cb, data);
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
+		vd->local_release |=3D (1 << req->id);
+
+	req->cb(&error, req->data);
+
+	/* Some phones fail to send response back after CHLD=3D1x */
+	vd->clcc_source =3D g_timeout_add(POLL_CLCC_INTERVAL, poll_clcc,
req->vc);
+}
+
+static void hfp_set_udub(struct ofono_voicecall *vc,
+				ofono_voicecall_cb_t cb, void *data)
+{
+	unsigned int incoming_or_waiting =3D (1 << 4) | (1 << 5);
+	struct voicecall_data *vd =3D ofono_voicecall_get_data(vc);
+	struct ofono_call *call =3D vd->call;
+	struct release_id_req *req;
+
+	if (vd->ag_mpty_features & AG_CHLD_0)
+		hfp_template("AT+CHLD=3D0", vc, generic_cb, incoming_or_waiting,
+					cb, data);
+	else {
+		req =3D g_try_new0(struct release_id_req, 1);
+
+		if (!req || !call) {
+			CALLBACK_WITH_FAILURE(cb, data);
+			return;
+		}
+
+		req->vc =3D vc;
+		req->cb =3D cb;
+		req->data =3D data;
+		req->id =3D call->id;
+
+		g_at_chat_send(vd->chat, "AT+CHUP", none_prefix,
+					release_id_cb, req, g_free);
+	}
+}
+
+static void hfp_release_all_active(struct ofono_voicecall *vc,
+					ofono_voicecall_cb_t cb, void *data)
+{
+	struct voicecall_data *vd =3D ofono_voicecall_get_data(vc);
+
+	if (check_mpty_feature(vc, AG_CHLD_1, cb, data)) {
+		hfp_template("AT+CHLD=3D1", vc, generic_cb, 0x1, cb, data);
+
+		vd->clcc_source =3D g_timeout_add(POLL_CLCC_INTERVAL, poll_clcc,
+						vc);
+	}
+}
+
+static gboolean release_hold_cb(gpointer user_data)
+{
+	struct release_id_req *req =3D user_data;
+	struct voicecall_data *vd =3D ofono_voicecall_get_data(req->vc);
+
+	vd->local_release |=3D (1 << req->id);
+
+	hfp_release_all_active(req->vc, req->cb, req->data);
+
+	g_free(req);
+
+	return FALSE;
+}
+
+static void swap_hold_cb(gboolean ok, GAtResult *result, gpointer
user_data)
+{
+	struct release_id_req *req =3D user_data;
+	struct ofono_error error;
+
+	dump_response("generic_cb", ok, result);
+	decode_at_error(&error, g_at_result_final_response(result));
+
+	if (!ok) {
+		CALLBACK_WITH_FAILURE(req->cb, req->data);
+		return;
+	}
+
+	g_timeout_add(POLL_CLCC_INTERVAL, release_hold_cb, req);
+}
+
+static void hfp_release_specific(struct ofono_voicecall *vc, int id,
+				ofono_voicecall_cb_t cb, void *data)
+{
+	struct voicecall_data *vd =3D ofono_voicecall_get_data(vc);
+	struct release_id_req *req =3D g_try_new0(struct release_id_req, 1);
+	char buf[32];
+
+	if (!req) {
+		CALLBACK_WITH_FAILURE(cb, data);
+		return;
+	}
+
+	req->vc =3D vc;
+	req->cb =3D cb;
+	req->data =3D data;
+	req->id =3D id;
+
+	if (vd->ag_features & AG_FEATURE_ENHANCED_CALL_CONTROL) {
+		sprintf(buf, "AT+CHLD=3D1%d", id);
+
+		g_at_chat_send(vd->chat, buf, none_prefix,
+					release_id_cb, req, g_free);
+	} else if (id =3D=3D (int) vd->call->id)
+		g_at_chat_send(vd->chat, "AT+CHUP", none_prefix,
+					release_id_cb, req, g_free);
+	else
+		/* If the call is held, swap and then release it */
+		g_at_chat_send(vd->chat, "AT+CHLD=3D2", none_prefix,
+					swap_hold_cb, req, NULL);
+}
+
 static void ring_notify(GAtResult *result, gpointer user_data)
 {
 	struct ofono_voicecall *vc =3D user_data;
@@ -439,7 +704,10 @@ static void ciev_call_notify(struct ofono_voicecall
*vc,
 =

 	switch (value) {
 	case 0:
-		release_call(vc, call);
+		if (g_slist_length(vd->calls) > 1 && !vd->clcc_source)
+			poll_clcc(vc);
+		else
+			release_call(vc, call);
 		break;
 	case 1:
 		call->status =3D CALL_STATUS_ACTIVE;
@@ -515,7 +783,9 @@ static void ciev_callsetup_notify(struct
ofono_voicecall *vc,
 		/* call=3D0 and callsetup=3D1: reject an incoming call
 		 * call=3D0 and callsetup=3D2,3: interrupt an outgoing call
 		 */
-		if ((ciev_call =3D=3D 0) && (ciev_callsetup > 0))
+		if (g_slist_length(vd->calls) > 1 && !vd->clcc_source)
+			poll_clcc(vc);
+		else if ((ciev_call =3D=3D 0) && (ciev_callsetup > 0))
 			release_call(vc, call);
 		break;
 	case 1:
@@ -538,6 +808,7 @@ static void ciev_callsetup_notify(struct
ofono_voicecall *vc,
 	case 3:
 		call->status =3D CALL_STATUS_ALERTING;
 		ofono_voicecall_notify(vc, call);
+		break;
 	default:
 		break;
 	}
@@ -545,6 +816,18 @@ static void ciev_callsetup_notify(struct
ofono_voicecall *vc,
 	vd->cind_val[HFP_INDICATOR_CALLSETUP] =3D value;
 }
 =

+static void ciev_callheld_notify(struct ofono_voicecall *vc,
+				struct ofono_call *call,
+				unsigned int value)
+{
+	struct voicecall_data *vd =3D ofono_voicecall_get_data(vc);
+
+	if (!vd->clcc_source)
+		poll_clcc(vc);
+
+	vd->cind_val[HFP_INDICATOR_CALLHELD] =3D value;
+}
+
 static void ciev_notify(GAtResult *result, gpointer user_data)
 {
 	struct ofono_voicecall *vc =3D user_data;
@@ -569,6 +852,57 @@ static void ciev_notify(GAtResult *result, gpointer
user_data)
 		ciev_call_notify(vc, call, value);
 	else if (index =3D=3D vd->cind_pos[HFP_INDICATOR_CALLSETUP])
 		ciev_callsetup_notify(vc, call, value);
+	else if (index =3D=3D vd->cind_pos[HFP_INDICATOR_CALLHELD])
+		ciev_callheld_notify(vc, call, value);
+}
+
+static void ccwa_notify(GAtResult *result, gpointer user_data)
+{
+	struct ofono_voicecall *vc =3D user_data;
+	struct voicecall_data *vd =3D ofono_voicecall_get_data(vc);
+	GAtResultIter iter;
+	const char *num;
+	int type;
+	struct ofono_call *call;
+
+	dump_response("ccwa_notify", TRUE, result);
+
+	/* CCWA can be repeat, ignore if we already have a waiting call */
+	if (g_slist_find_custom(vd->calls,
+				GINT_TO_POINTER(CALL_STATUS_WAITING),
+				at_util_call_compare_by_status))
+		return;
+
+	g_at_result_iter_init(&iter, result);
+
+	if (!g_at_result_iter_next(&iter, "+CCWA:"))
+		return;
+
+	if (!g_at_result_iter_next_string(&iter, &num))
+		return;
+
+	if (!g_at_result_iter_next_number(&iter, &type))
+		return;
+
+	/* Skip class field */
+	g_at_result_iter_skip_next(&iter);
+
+	/* Skip alpha field */
+	g_at_result_iter_skip_next(&iter);
+
+	/* Skip validity field */
+	g_at_result_iter_skip_next(&iter);
+
+	call =3D create_call(vd, 0, 1, CALL_STATUS_WAITING,
+				num, type, 0);
+
+	if (!call) {
+		ofono_error("malloc call structfailed."
+				"Call management is fubar");
+		return;
+	}
+
+	ofono_voicecall_notify(vc, call);
 }
 =

 static void chld_cb(gboolean ok, GAtResult *result, gpointer user_data)
@@ -624,6 +958,10 @@ static void hfp_voicecall_initialized(gboolean ok,
GAtResult *result,
 	g_at_chat_register(vd->chat, "+CLIP:", clip_notify, FALSE, vc, NULL);
 	g_at_chat_register(vd->chat, "+CIEV:", ciev_notify, FALSE, vc, NULL);
 =

+	if (vd->ag_features & AG_FEATURE_ENHANCED_CALL_STATUS)
+		g_at_chat_register(vd->chat, "+CCWA:", ccwa_notify, FALSE, vc,
+					NULL);
+
 	ofono_voicecall_register(vc);
 }
 =

@@ -671,11 +1009,11 @@ static struct ofono_voicecall_driver driver =3D {
 	.answer			=3D hfp_answer,
 	.hangup			=3D hfp_hangup,
 	.list_calls		=3D NULL,
-	.hold_all_active	=3D NULL,
-	.release_all_held	=3D NULL,
-	.set_udub		=3D NULL,
-	.release_all_active	=3D NULL,
-	.release_specific	=3D NULL,
+	.hold_all_active	=3D hfp_hold_all_active,
+	.release_all_held	=3D hfp_release_all_held,
+	.set_udub		=3D hfp_set_udub,
+	.release_all_active	=3D hfp_release_all_active,
+	.release_specific	=3D hfp_release_specific,
 	.private_chat		=3D NULL,
 	.create_multiparty	=3D NULL,
 	.transfer		=3D NULL,
-- =

1.6.2.5




--===============2287281657079979429==--

