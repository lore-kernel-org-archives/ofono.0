Content-Type: multipart/mixed; boundary="===============4447081837375657057=="
MIME-Version: 1.0
From: Zhenhua Zhang <zhenhua.zhang@intel.com>
Subject: [PATCH 4/4] Fix: Fill in the phone number info for outgoing call
Date: Sat, 07 Nov 2009 15:15:31 +0800
Message-ID: <1257578131.2888.6.camel@zzhan17-mobl.ccr.corp.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4447081837375657057==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This is the latest version. Sorry for the noising from previous patches.

There're two cases of outgoing call: dial from HF or dial from
phone.

In the first case, some phones may not support enhanced call status
(AT+CLCC) to query outgoing number. So we need to pass struct
atd_cb_data to fill in the number and type. Later, we invoke
AT+CLCC to query phone number and overwrite ours if we are wrong.

In the second case, the phone is dialing from phone and we know
nothing. So we have to query it through AT+CLCC when callsetup=3D2.
If phone does not support AT+CLCC, we fake a new call for it.

Update: change algorithm in sync_dialing_cb to handle multi calls
situation.
---
 drivers/hfpmodem/voicecall.c |  216
+++++++++++++++++++++++++++++++++++-------
 1 files changed, 181 insertions(+), 35 deletions(-)

diff --git a/drivers/hfpmodem/voicecall.c b/drivers/hfpmodem/voicecall.c
index 15a8b49..5104afa 100644
--- a/drivers/hfpmodem/voicecall.c
+++ b/drivers/hfpmodem/voicecall.c
@@ -49,6 +49,7 @@
 =

 static const char *none_prefix[] =3D { NULL };
 static const char *chld_prefix[] =3D { "+CHLD:", NULL };
+static const char *clcc_prefix[] =3D { "+CLCC:", NULL };
 =

 struct voicecall_data {
 	GAtChat *chat;
@@ -76,6 +77,13 @@ struct change_state_req {
 	int affected_types;
 };
 =

+struct atd_cb_data {
+	void *cb;
+	void *data;
+	void *user;
+	struct ofono_phone_number ph;
+};
+
 static struct ofono_call *create_call(struct voicecall_data *d, int
type,
 					int direction, int status,
 					const char *num, int num_type, int clip)
@@ -108,6 +116,75 @@ static struct ofono_call *create_call(struct
voicecall_data *d, int type,
 	return call;
 }
 =

+static struct ofono_call *new_call_notify(struct ofono_voicecall *vc,
int type,
+					int direction, int status,
+					const char *num, int num_type, int clip)
+{
+	struct voicecall_data *vd =3D ofono_voicecall_get_data(vc);
+	struct ofono_call *c;
+
+	c =3D create_call(vd, type, direction, status, num, num_type, clip);
+
+	ofono_voicecall_notify(vc, c);
+
+	return c;
+}
+
+static GSList *parse_clcc(GAtResult *result)
+{
+	GAtResultIter iter;
+	GSList *l =3D NULL;
+	int id, dir, status, type;
+	struct ofono_call *call;
+
+	g_at_result_iter_init(&iter, result);
+
+	while (g_at_result_iter_next(&iter, "+CLCC:")) {
+		const char *str =3D "";
+		int number_type =3D 129;
+
+		if (!g_at_result_iter_next_number(&iter, &id))
+			continue;
+
+		if (!g_at_result_iter_next_number(&iter, &dir))
+			continue;
+
+		if (!g_at_result_iter_next_number(&iter, &status))
+			continue;
+
+		if (!g_at_result_iter_next_number(&iter, &type))
+			continue;
+
+		if (!g_at_result_iter_skip_next(&iter))
+			continue;
+
+		if (g_at_result_iter_next_string(&iter, &str))
+			g_at_result_iter_next_number(&iter, &number_type);
+
+		call =3D g_try_new0(struct ofono_call, 1);
+
+		if (!call)
+			break;
+
+		call->id =3D id;
+		call->direction =3D dir;
+		call->status =3D status;
+		call->type =3D type;
+		strncpy(call->phone_number.number, str,
+				OFONO_MAX_PHONE_NUMBER_LENGTH);
+		call->phone_number.type =3D number_type;
+
+		if (strlen(call->phone_number.number) > 0)
+			call->clip_validity =3D 0;
+		else
+			call->clip_validity =3D 2;
+
+		l =3D g_slist_insert_sorted(l, call, at_util_call_compare);
+	}
+
+	return l;
+}
+
 static void generic_cb(gboolean ok, GAtResult *result, gpointer
user_data)
 {
 	struct change_state_req *req =3D user_data;
@@ -134,12 +211,11 @@ static void generic_cb(gboolean ok, GAtResult
*result, gpointer user_data)
 =

 static void atd_cb(gboolean ok, GAtResult *result, gpointer user_data)
 {
-	struct cb_data *cbd =3D user_data;
+	struct atd_cb_data *cbd =3D user_data;
 	struct ofono_voicecall *vc =3D cbd->user;
 	struct voicecall_data *vd =3D ofono_voicecall_get_data(vc);
 	ofono_voicecall_cb_t cb =3D cbd->cb;
-	int type =3D 128;
-	int validity =3D 2;
+	struct ofono_phone_number ph =3D cbd->ph;
 	struct ofono_error error;
 	struct ofono_call *call;
 =

@@ -150,7 +226,8 @@ static void atd_cb(gboolean ok, GAtResult *result,
gpointer user_data)
 	if (!ok)
 		goto out;
 =

-	call =3D create_call(vd, 0, 0, CALL_STATUS_DIALING, NULL, type,
validity);
+	call =3D create_call(vd, 0, 0, CALL_STATUS_DIALING,
+					ph.number, ph.type, 0);
 =

 	if (!call) {
 		ofono_error("Unable to allocate call, "
@@ -158,6 +235,8 @@ static void atd_cb(gboolean ok, GAtResult *result,
gpointer user_data)
 		return;
 	}
 =

+	ofono_voicecall_notify(vc, call);
+
 out:
 	cb(&error, cbd->data);
 }
@@ -168,13 +247,20 @@ static void hfp_dial(struct ofono_voicecall *vc,
 			ofono_voicecall_cb_t cb, void *data)
 {
 	struct voicecall_data *vd =3D ofono_voicecall_get_data(vc);
-	struct cb_data *cbd =3D cb_data_new(cb, data);
+	struct atd_cb_data *cbd;
 	char buf[256];
 =

+	cbd =3D g_try_new0(struct atd_cb_data, 1);
+
 	if (!cbd)
 		goto error;
 =

+	cbd->cb =3D cb;
+	cbd->data =3D data;
 	cbd->user =3D vc;
+
+	memcpy(&cbd->ph, ph, sizeof(struct ofono_phone_number));
+
 	if (ph->type =3D=3D 145)
 		sprintf(buf, "ATD+%s", ph->number);
 	else
@@ -351,23 +437,71 @@ static void ciev_call_notify(struct
ofono_voicecall *vc,
 {
 	struct voicecall_data *vd =3D ofono_voicecall_get_data(vc);
 =

-	if (g_slist_length(vd->calls) =3D=3D 1) {
-		switch (value) {
-		case 0:
-			release_call(vc, call);
-			break;
-		case 1:
-			call->status =3D CALL_STATUS_ACTIVE;
-			ofono_voicecall_notify(vc, call);
-			break;
-		default:
-			break;
-		}
+	switch (value) {
+	case 0:
+		release_call(vc, call);
+		break;
+	case 1:
+		call->status =3D CALL_STATUS_ACTIVE;
+		ofono_voicecall_notify(vc, call);
+		break;
+	default:
+		break;
 	}
 =

 	vd->cind_val[HFP_INDICATOR_CALL] =3D value;
 }
 =

+static void sync_dialing_cb(gboolean ok, GAtResult *result, gpointer
user_data)
+{
+	struct ofono_voicecall *vc =3D user_data;
+	struct voicecall_data *vd =3D ofono_voicecall_get_data(vc);
+	struct ofono_error error;
+	GSList *calls =3D NULL;
+	GSList *l =3D NULL;
+	struct ofono_call *nc =3D NULL;
+	struct ofono_call *oc =3D vd->call;
+
+	dump_response("sync_dialing_cb", ok, result);
+	decode_at_error(&error, g_at_result_final_response(result));
+
+	if (!ok)
+		return;
+
+	calls =3D parse_clcc(result);
+
+	if (calls =3D=3D NULL)
+		return;
+
+	while (calls) {
+		nc =3D calls->data;
+
+		if (vd->calls)
+			l =3D g_slist_find_custom(vd->calls, nc,
+						at_util_call_compare);
+
+		if (l) {
+			oc =3D l->data;
+
+			if (memcmp(nc, oc, sizeof(struct ofono_call))) {
+				ofono_voicecall_notify(vc, nc);
+
+				memcpy(oc, nc, sizeof(struct ofono_call));
+			}
+
+		} else
+			new_call_notify(vc, nc->type, nc->direction, nc->status,
+						nc->phone_number.number,
+						nc->phone_number.type,
+						nc->clip_validity);
+
+		calls =3D calls->next;
+	}
+
+	g_slist_foreach(calls, (GFunc) g_free, NULL);
+	g_slist_free(calls);
+}
+
 static void ciev_callsetup_notify(struct ofono_voicecall *vc,
 					struct ofono_call *call,
 					unsigned int value)
@@ -376,24 +510,36 @@ static void ciev_callsetup_notify(struct
ofono_voicecall *vc,
 	unsigned int ciev_callsetup =3D vd->cind_val[HFP_INDICATOR_CALLSETUP];
 	unsigned int ciev_call =3D vd->cind_val[HFP_INDICATOR_CALL];
 =

-	if (g_slist_length(vd->calls) =3D=3D 1) {
-		switch (value) {
-		case 0:
-			/* call=3D0 and callsetup=3D1: reject an incoming call
-			 * call=3D0 and callsetup=3D2,3: interrupt an outgoing call
-			 */
-			if (ciev_call =3D=3D 0 && ciev_callsetup > 0)
-				release_call(vc, call);
-			break;
-		case 1:
-		case 2:
-			break;
-		case 3:
-			call->status =3D CALL_STATUS_ALERTING;
-			ofono_voicecall_notify(vc, call);
-		default:
-			break;
-		}
+	switch (value) {
+	case 0:
+		/* call=3D0 and callsetup=3D1: reject an incoming call
+		 * call=3D0 and callsetup=3D2,3: interrupt an outgoing call
+		 */
+		if ((ciev_call =3D=3D 0) && (ciev_callsetup > 0))
+			release_call(vc, call);
+		break;
+	case 1:
+		break;
+	case 2:
+		/* two cases of outgoing call: dial from HF or AG.
+		 * from HF: query and sync the phone number.
+		 * from AG: query and create call.
+		 * if phone does not support CLLC, we guess the call.
+		 */
+		if (vd->ag_features & AG_FEATURE_ENHANCED_CALL_STATUS)
+			g_at_chat_send(vd->chat, "AT+CLCC", clcc_prefix,
+						sync_dialing_cb,
+						vc, NULL);
+		else if (!vd->call)
+			vd->call =3D new_call_notify(vc, 0, 0,
+						CALL_STATUS_DIALING,
+						NULL, 128, 2);
+		break;
+	case 3:
+		call->status =3D CALL_STATUS_ALERTING;
+		ofono_voicecall_notify(vc, call);
+	default:
+		break;
 	}
 =

 	vd->cind_val[HFP_INDICATOR_CALLSETUP] =3D value;
-- =

1.6.2.5




--===============4447081837375657057==--

