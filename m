Content-Type: multipart/mixed; boundary="===============1489932388781726801=="
MIME-Version: 1.0
From: Zhenhua Zhang <zhenhua.zhang@intel.com>
Subject: [PATCH 3/3] Add list_calls and send_dtmf support for HFP voicecall
 driver
Date: Sat, 07 Nov 2009 15:26:43 +0800
Message-ID: <1257578804.2888.18.camel@zzhan17-mobl.ccr.corp.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1489932388781726801==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

send_dtmf doesn't allow double quotes in AT commands.
---
 drivers/hfpmodem/voicecall.c |  109
+++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 107 insertions(+), 2 deletions(-)

diff --git a/drivers/hfpmodem/voicecall.c b/drivers/hfpmodem/voicecall.c
index fabcd6d..24841da 100644
--- a/drivers/hfpmodem/voicecall.c
+++ b/drivers/hfpmodem/voicecall.c
@@ -454,6 +454,76 @@ static gboolean poll_clcc(gpointer user_data)
 	return FALSE;
 }
 =

+static void list_calls_cb(gboolean ok, GAtResult *result, gpointer
user_data)
+{
+	struct cb_data *cbd =3D user_data;
+	ofono_call_list_cb_t cb =3D cbd->cb;
+	struct ofono_error error;
+	GSList *calls =3D NULL;
+	GSList *l;
+	struct ofono_call *list;
+	int num =3D 0;
+
+	dump_response("list_calls_cb", ok, result);
+	decode_at_error(&error, g_at_result_final_response(result));
+
+	if (!ok) {
+		cb(&error, 0, NULL, cbd->data);
+		goto out;
+	}
+
+	calls =3D parse_clcc(result);
+
+	if (calls =3D=3D NULL) {
+		CALLBACK_WITH_FAILURE(cb, 0, NULL, cbd->data);
+		goto out;
+	}
+
+	list =3D g_try_new0(struct ofono_call, g_slist_length(calls));
+
+	if (!list) {
+		CALLBACK_WITH_FAILURE(cb, 0, NULL, cbd->data);
+		goto out;
+	}
+
+	for (num =3D 0, l =3D calls; l; l =3D l->next, num++)
+		memcpy(&list[num], l->data, sizeof(struct ofono_call));
+
+	cb(&error, num, list, cbd->data);
+
+	g_free(list);
+
+out:
+	g_slist_foreach(calls, (GFunc) g_free, NULL);
+	g_slist_free(calls);
+}
+
+static void hfp_list_calls(struct ofono_voicecall *vc,
ofono_call_list_cb_t cb,
+				void *data)
+{
+	struct voicecall_data *vd =3D ofono_voicecall_get_data(vc);
+	struct cb_data *cbd =3D cb_data_new(cb, data);
+
+	if (!cbd)
+		goto error;
+
+	if (!(vd->ag_features & AG_FEATURE_ENHANCED_CALL_STATUS)) {
+		ofono_error("The phone doesn't support enhanced "
+				"call status control to get list of calls");
+		goto error;
+	}
+
+	if (g_at_chat_send(vd->chat, "AT+CLCC", clcc_prefix,
+				list_calls_cb, cbd, g_free) > 0)
+		return;
+
+error:
+	if (cbd)
+		g_free(cbd);
+
+	CALLBACK_WITH_FAILURE(cb, 0, NULL, data);
+}
+
 static gboolean check_mpty_feature(struct ofono_voicecall *vc,
 				unsigned int feature,
 				ofono_voicecall_cb_t cb, void *data)
@@ -644,6 +714,41 @@ static void hfp_transfer(struct ofono_voicecall
*vc,
 		hfp_template("AT+CHLD=3D4", vc, generic_cb, transfer, cb, data);
 }
 =

+static void hfp_send_dtmf(struct ofono_voicecall *vc, const char *dtmf,
+			ofono_voicecall_cb_t cb, void *data)
+{
+	struct voicecall_data *vd =3D ofono_voicecall_get_data(vc);
+	struct change_state_req *req =3D g_try_new0(struct change_state_req, 1);
+	char *buf;
+
+	if (!req)
+		goto error;
+
+	req->vc =3D vc;
+	req->cb =3D cb;
+	req->data =3D data;
+	req->affected_types =3D 0;
+
+	/* strlen("AT+VTS=3D") =3D 7 */
+	buf =3D g_try_new(char, strlen(dtmf) + 7);
+
+	if (!buf)
+		goto error;
+
+	sprintf(buf, "AT+VTS=3D%s", dtmf);
+
+	g_at_chat_send(vd->chat, buf, none_prefix,
+				generic_cb, req, g_free);
+
+	g_free(buf);
+
+	return;
+
+error:
+	CALLBACK_WITH_FAILURE(cb, data);
+	return;
+}
+
 static void ring_notify(GAtResult *result, gpointer user_data)
 {
 	struct ofono_voicecall *vc =3D user_data;
@@ -1039,7 +1144,7 @@ static struct ofono_voicecall_driver driver =3D {
 	.dial			=3D hfp_dial,
 	.answer			=3D hfp_answer,
 	.hangup			=3D hfp_hangup,
-	.list_calls		=3D NULL,
+	.list_calls		=3D hfp_list_calls,
 	.hold_all_active	=3D hfp_hold_all_active,
 	.release_all_held	=3D hfp_release_all_held,
 	.set_udub		=3D hfp_set_udub,
@@ -1050,7 +1155,7 @@ static struct ofono_voicecall_driver driver =3D {
 	.transfer		=3D hfp_transfer,
 	.deflect		=3D NULL,
 	.swap_without_accept	=3D NULL,
-	.send_tones		=3D NULL
+	.send_tones		=3D hfp_send_dtmf
 };
 =

 void hfp_voicecall_init()
-- =

1.6.2.5




--===============1489932388781726801==--

