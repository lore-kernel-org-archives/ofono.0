Content-Type: multipart/mixed; boundary="===============3245403897215097731=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 08/14] stk: Handle the Send SMS proactive command.
Date: Wed, 07 Jul 2010 00:39:03 +0200
Message-ID: <1278455949-2823-9-git-send-email-andrew.zaborowski@intel.com>
In-Reply-To: <1278455949-2823-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3245403897215097731==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/stk.c |  104 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++
 1 files changed, 104 insertions(+), 0 deletions(-)

diff --git a/src/stk.c b/src/stk.c
index b4b65c1..a57342a 100644
--- a/src/stk.c
+++ b/src/stk.c
@@ -34,6 +34,7 @@
 =

 #include "ofono.h"
 =

+#include "common.h"
 #include "smsutil.h"
 #include "stkutil.h"
 =

@@ -47,6 +48,8 @@ struct ofono_stk {
 	void (*cancel_cmd)(struct ofono_stk *stk);
 	gboolean cancelled;
 	GQueue *envelope_q;
+
+	struct sms_submit_req *sms_submit_req;
 };
 =

 struct envelope_op {
@@ -57,6 +60,11 @@ struct envelope_op {
 			const unsigned char *data, int length);
 };
 =

+struct sms_submit_req {
+	struct ofono_stk *stk;
+	gboolean cancelled;
+};
+
 #define ENVELOPE_RETRIES_DEFAULT 5
 =

 static void envelope_queue_run(struct ofono_stk *stk);
@@ -201,6 +209,16 @@ static void stk_command_cb(const struct ofono_error *e=
rror, void *data)
 	DBG("TERMINAL RESPONSE to a command reported no errors");
 }
 =

+static void stk_alpha_id_set(struct ofono_stk *stk, const char *text)
+{
+	/* TODO */
+}
+
+static void stk_alpha_id_unset(struct ofono_stk *stk)
+{
+	/* TODO */
+}
+
 static gboolean handle_command_more_time(const struct stk_command *cmd,
 						struct stk_response *rsp,
 						struct ofono_stk *stk)
@@ -210,6 +228,88 @@ static gboolean handle_command_more_time(const struct =
stk_command *cmd,
 	return TRUE;
 }
 =

+static void send_sms_cancel(struct ofono_stk *stk)
+{
+	stk->sms_submit_req->cancelled =3D TRUE;
+
+	if (!stk->pending_cmd->send_sms.alpha_id ||
+			!stk->pending_cmd->send_sms.alpha_id[0])
+		return;
+
+	stk_alpha_id_unset(stk);
+}
+
+static void send_sms_submit_cb(const struct ofono_error *error, int mr,
+				void *data)
+{
+	struct stk_response rsp;
+	struct sms_submit_req *req =3D data;
+	struct ofono_stk *stk =3D req->stk;
+	struct ofono_error failure =3D { .type =3D OFONO_ERROR_TYPE_FAILURE };
+
+	if (error->type !=3D OFONO_ERROR_TYPE_NO_ERROR)
+		ofono_debug("SMS submission returned errors: %s",
+				telephony_error_to_str(error));
+	else
+		ofono_debug("SMS submission successful");
+
+	if (req->cancelled) {
+		ofono_debug("Received an SMS submitted callback after the "
+				"proactive command was cancelled");
+		goto out;
+	}
+
+	memset(&rsp, 0, sizeof(rsp));
+
+	if (error->type !=3D OFONO_ERROR_TYPE_NO_ERROR)
+		rsp.result.type =3D STK_RESULT_TYPE_NETWORK_UNAVAILABLE;
+
+	if (stk_respond(stk, &rsp, stk_command_cb))
+		stk_command_cb(&failure, stk);
+
+	if (!stk->pending_cmd->send_sms.alpha_id ||
+			!stk->pending_cmd->send_sms.alpha_id[0])
+		goto out;
+
+	stk_alpha_id_unset(stk);
+
+out:
+	g_free(req);
+}
+
+static gboolean handle_command_send_sms(const struct stk_command *cmd,
+					struct stk_response *rsp,
+					struct ofono_stk *stk)
+{
+	struct ofono_modem *modem =3D __ofono_atom_get_modem(stk->atom);
+	struct ofono_atom *sms_atom;
+	struct ofono_sms *sms;
+
+	sms_atom =3D __ofono_modem_find_atom(modem, OFONO_ATOM_TYPE_SMS);
+
+	if (!sms_atom || !__ofono_atom_get_registered(sms_atom)) {
+		rsp->result.type =3D STK_RESULT_TYPE_NOT_CAPABLE;
+		return TRUE;
+	}
+
+	sms =3D __ofono_atom_get_data(sms_atom);
+
+	stk->sms_submit_req =3D g_new0(struct sms_submit_req, 1);
+	stk->sms_submit_req->stk =3D stk;
+
+	__ofono_sms_submit(sms, &cmd->send_sms.gsm_sms,
+				send_sms_submit_cb, stk->sms_submit_req);
+
+	stk->cancel_cmd =3D send_sms_cancel;
+
+	if (!cmd->send_sms.alpha_id || !cmd->send_sms.alpha_id[0])
+		return FALSE;
+
+	stk_alpha_id_set(stk, cmd->send_sms.alpha_id);
+
+	return FALSE;
+}
+
 static void stk_proactive_command_cancel(struct ofono_stk *stk)
 {
 	if (!stk->pending_cmd)
@@ -284,6 +384,10 @@ void ofono_stk_proactive_command_notify(struct ofono_s=
tk *stk,
 			respond =3D handle_command_more_time(stk->pending_cmd,
 								&rsp, stk);
 			break;
+		case STK_COMMAND_TYPE_SEND_SMS:
+			respond =3D handle_command_send_sms(stk->pending_cmd,
+								&rsp, stk);
+			break;
 		}
 =

 		if (respond)
-- =

1.7.1.86.g0e460.dirty


--===============3245403897215097731==--

