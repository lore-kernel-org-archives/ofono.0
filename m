Content-Type: multipart/mixed; boundary="===============3332249341611458940=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 6/6][RfC] Implement the Send SMS proactive command.
Date: Wed, 30 Jun 2010 17:24:18 +0200
Message-ID: <1277911458-4984-6-git-send-email-andrew.zaborowski@intel.com>
In-Reply-To: <1277911458-4984-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3332249341611458940==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/ofono.h |    7 ++++-
 src/sms.c   |   39 ++++++++++++++++++++++++++++++
 src/stk.c   |   75 +++++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++
 3 files changed, 120 insertions(+), 1 deletions(-)

diff --git a/src/ofono.h b/src/ofono.h
index e2271e6..94e2715 100644
--- a/src/ofono.h
+++ b/src/ofono.h
@@ -168,12 +168,17 @@ void __ofono_atom_free(struct ofono_atom *atom);
 #include <ofono/cbs.h>
 #include <ofono/devinfo.h>
 #include <ofono/phonebook.h>
-#include <ofono/sms.h>
 #include <ofono/voicecall.h>
 #include <ofono/gprs.h>
 #include <ofono/gprs-context.h>
 #include <ofono/radio-settings.h>
 =

+#include <ofono/sms.h>
+
+struct sms;
+void __ofono_sms_submit(struct ofono_sms *sms, const struct sms *msg,
+			ofono_sms_submit_cb_t cb, void *data);
+
 #include <ofono/sim.h>
 #include <ofono/stk.h>
 =

diff --git a/src/sms.c b/src/sms.c
index c848007..54c46a5 100644
--- a/src/sms.c
+++ b/src/sms.c
@@ -87,6 +87,8 @@ struct tx_queue_entry {
 	DBusMessage *msg;
 	gboolean status_report;
 	struct sms_address receiver;
+	ofono_sms_submit_cb_t cb;
+	void *data;
 };
 =

 static const char *sms_bearer_to_string(int bearer)
@@ -413,6 +415,9 @@ static void tx_finished(const struct ofono_error *error=
, int mr, void *data)
 	DBG("tx_finished");
 =

 	if (error->type !=3D OFONO_ERROR_TYPE_NO_ERROR) {
+		if (entry->cb)
+			goto callback;
+
 		entry->retry +=3D 1;
 =

 		if (entry->retry !=3D TXQ_MAX_RETRIES) {
@@ -459,6 +464,9 @@ static void tx_finished(const struct ofono_error *error=
, int mr, void *data)
 		return;
 	}
 =

+	if (entry->cb)
+		goto callback;
+
 	entry =3D g_queue_pop_head(sms->txq);
 	__ofono_dbus_pending_reply(&entry->msg,
 				dbus_message_new_method_return(entry->msg));
@@ -473,6 +481,19 @@ static void tx_finished(const struct ofono_error *erro=
r, int mr, void *data)
 		DBG("Scheduling next");
 		sms->tx_source =3D g_timeout_add(0, tx_next, sms);
 	}
+
+	return;
+
+callback:
+	entry =3D g_queue_pop_head(sms->txq);
+
+	entry->cb(error, mr, entry->data);
+
+	g_free(entry->pdus);
+	g_free(entry);
+
+	if (g_queue_peek_head(sms->txq))
+		sms->tx_source =3D g_timeout_add(0, tx_next, sms);
 }
 =

 static gboolean tx_next(gpointer user_data)
@@ -1285,3 +1306,21 @@ void *ofono_sms_get_data(struct ofono_sms *sms)
 {
 	return sms->driver_data;
 }
+
+void __ofono_sms_submit(struct ofono_sms *sms, const struct sms *msg,
+			ofono_sms_submit_cb_t cb, void *data)
+{
+	GSList msg_list =3D {
+		.data =3D (void *) msg,
+		.next =3D NULL,
+	};
+	struct tx_queue_entry *entry =3D create_tx_queue_entry(&msg_list);
+
+	entry->cb =3D cb;
+	entry->data =3D data;
+
+	g_queue_push_tail(sms->txq, entry);
+
+	if (g_queue_get_length(sms->txq) =3D=3D 1)
+		sms->tx_source =3D g_timeout_add(0, tx_next, sms);
+}
diff --git a/src/stk.c b/src/stk.c
index 5ce0d2a..af91b7d 100644
--- a/src/stk.c
+++ b/src/stk.c
@@ -89,6 +89,7 @@ struct ofono_stk {
 	struct stk_menu *main_menu;
 	struct stk_menu *select_item_menu;
 	struct timeval get_inkey_start_ts;
+	struct sms_submit_req *sms_submit_req;
 =

 	gboolean envelope_q_busy;
 	GQueue *envelope_q;
@@ -101,6 +102,11 @@ struct envelope_op {
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

 #define OFONO_NAVIGATION_PREFIX OFONO_SERVICE ".Navigation."
@@ -1325,6 +1331,71 @@ static gboolean handle_command_get_input(const struc=
t stk_command *cmd,
 	return FALSE;
 }
 =

+static void send_sms_cancel(struct ofono_stk *stk)
+{
+	stk->sms_submit_req->cancelled =3D TRUE;
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
+	return FALSE;
+}
+
 void ofono_stk_proactive_command_cancel(struct ofono_stk *stk)
 {
 	if (!stk->pending_cmd)
@@ -1415,6 +1486,10 @@ void ofono_stk_proactive_command_notify(struct ofono=
_stk *stk,
 		case STK_COMMAND_TYPE_GET_INPUT:
 			respond =3D handle_command_get_input(stk->pending_cmd,
 								&rsp, stk);
+			break;
+		case STK_COMMAND_TYPE_SEND_SMS:
+			respond =3D handle_command_send_sms(stk->pending_cmd,
+								&rsp, stk);
 		}
 =

 		if (respond)
-- =

1.7.1.86.g0e460.dirty


--===============3332249341611458940==--

