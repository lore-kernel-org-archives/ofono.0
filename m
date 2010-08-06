Content-Type: multipart/mixed; boundary="===============2907083012464942476=="
MIME-Version: 1.0
From: Inaky Perez-Gonzalez <inaky@linux.intel.com>
Subject: [SMS D-Bus v5 07/17] sms: introduce a state change callback for
 messages
Date: Thu, 05 Aug 2010 17:55:29 -0700
Message-ID: <253c51f49b1260f3fcab643ce950e1838e3dbb89.1281054654.git.inaky.perez-gonzalez@intel.com>
In-Reply-To: <cover.1281054654.git.inaky.perez-gonzalez@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2907083012464942476==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Inaky Perez-Gonzalez <inaky.perez-gonzalez@intel.com>

When the SMS message going through the TX hoops changes states, call
the given callback function (if any). This will be used later to hook
up the D-Bus propagation of property changed signals.

Note this will do away with the ofono_sms_txq_submit_cb callback, as
it can be implemented in terms of a state change callback.
---
 src/ofono.h |    5 +++--
 src/sms.c   |   31 +++++++++++++++++++++++--------
 src/stk.c   |   19 +++++++++++++++++--
 3 files changed, 43 insertions(+), 12 deletions(-)

diff --git a/src/ofono.h b/src/ofono.h
index 2f7dfba..38e877f 100644
--- a/src/ofono.h
+++ b/src/ofono.h
@@ -216,12 +216,13 @@ enum ofono_sms_tx_state {
 =

 const char *ofono_sms_tx_state_to_string(enum ofono_sms_tx_state);
 =

-typedef void (*ofono_sms_txq_submit_cb_t)(gboolean ok, void *data);
+typedef void (*ofono_sms_msg_stch_cb_t)(void *data,
+					enum ofono_sms_tx_state new_state);
 =

 struct tx_queue_entry *__ofono_sms_txq_submit(struct ofono_sms *sms,
 						GSList *list,
 						unsigned int flags,
-						ofono_sms_txq_submit_cb_t cb,
+						ofono_sms_msg_stch_cb_t stch_cb,
 						void *data,
 						ofono_destroy_func destroy);
 =

diff --git a/src/sms.c b/src/sms.c
index a5e3a85..0d786a1 100644
--- a/src/sms.c
+++ b/src/sms.c
@@ -115,7 +115,7 @@ struct tx_queue_entry {
 	unsigned int msg_id;
 	unsigned int retry;
 	unsigned int flags;
-	ofono_sms_txq_submit_cb_t cb;
+	ofono_sms_msg_stch_cb_t stch_cb;
 	void *data;
 	ofono_destroy_func destroy;
 };
@@ -518,6 +518,8 @@ static void __ofono_sms_tx_state_set(struct tx_queue_en=
try *entry,
 	ofono_debug("%s:%d: SMS state change: %p %u -> %u\n",
 		    file, line, entry, state_old, state_new);
 	entry->state =3D state_new;
+	if (entry->stch_cb)
+		entry->stch_cb(entry->data, state_new);
 }
 =

 =

@@ -596,9 +598,6 @@ static void tx_finished(const struct ofono_error *error=
, int mr, void *data)
 next_q:
 	entry =3D g_queue_peek_head(sms->txq);
 =

-	if (entry->cb)
-		entry->cb(ok, entry->data);
-
 	if (entry->flags & OFONO_SMS_SUBMIT_FLAG_RECORD_HISTORY) {
 		enum ofono_history_sms_status hs;
 =

@@ -742,11 +741,26 @@ static struct tx_queue_entry *tx_queue_entry_new(GSLi=
st *msg_list)
 	return entry;
 }
 =

-static void send_message_cb(gboolean ok, void *data)
+static void send_message_stch_cb(void *data, enum ofono_sms_tx_state new_s=
tate)
 {
 	DBusConnection *conn =3D ofono_dbus_get_connection();
 	DBusMessage *msg =3D data;
 	DBusMessage *reply;
+	gboolean ok;
+
+	/*
+	 * We care about only the final states
+	 * (DONE/CANCELLED/FAILED/EXPIRED), the rest are just
+	 * ignored.
+	 */
+	if (new_state =3D=3D OFONO_SMS_TX_ST_DONE)
+		ok =3D TRUE;
+	else if (new_state =3D=3D OFONO_SMS_TX_ST_CANCELLED
+		 || new_state =3D=3D OFONO_SMS_TX_ST_FAILED
+		 || new_state =3D=3D OFONO_SMS_TX_ST_EXPIRED)
+		ok =3D FALSE;
+	else
+		return;
 =

 	if (ok)
 		reply =3D dbus_message_new_method_return(msg);
@@ -817,7 +831,8 @@ static DBusMessage *sms_send_message(DBusConnection *co=
nn, DBusMessage *msg,
 	if (sms->use_delivery_reports)
 		flags |=3D OFONO_SMS_SUBMIT_FLAG_REQUEST_SR;
 =

-	sms_msg =3D __ofono_sms_txq_submit(sms, msg_list, flags, send_message_cb,
+	sms_msg =3D __ofono_sms_txq_submit(sms, msg_list, flags,
+						send_message_stch_cb,
 						dbus_message_ref(msg),
 						send_message_destroy);
 =

@@ -1561,7 +1576,7 @@ void *ofono_sms_get_data(struct ofono_sms *sms)
 struct tx_queue_entry *__ofono_sms_txq_submit(struct ofono_sms *sms,
 						GSList *list,
 						unsigned int flags,
-						ofono_sms_txq_submit_cb_t cb,
+						ofono_sms_msg_stch_cb_t stch_cb,
 						void *data,
 						ofono_destroy_func destroy)
 {
@@ -1575,7 +1590,7 @@ struct tx_queue_entry *__ofono_sms_txq_submit(struct =
ofono_sms *sms,
 	}
 =

 	entry->flags =3D flags;
-	entry->cb =3D cb;
+	entry->stch_cb =3D stch_cb;
 	entry->data =3D data;
 	entry->destroy =3D destroy;
 	entry->sms_mgr =3D sms;
diff --git a/src/stk.c b/src/stk.c
index 7d98f92..5636eb6 100644
--- a/src/stk.c
+++ b/src/stk.c
@@ -660,12 +660,27 @@ static void send_sms_cancel(struct ofono_stk *stk)
 	stk_alpha_id_unset(stk);
 }
 =

-static void send_sms_submit_cb(gboolean ok, void *data)
+static void send_sms_stch_cb(void *data, enum ofono_sms_tx_state new_state)
 {
 	struct sms_submit_req *req =3D data;
 	struct ofono_stk *stk =3D req->stk;
 	struct ofono_error failure =3D { .type =3D OFONO_ERROR_TYPE_FAILURE };
 	struct stk_response rsp;
+	gboolean ok;
+
+	/*
+	 * We care about only the final states
+	 * (DONE/CANCELLED/FAILED/EXPIRED), the rest are just
+	 * ignored.
+	 */
+	if (new_state =3D=3D OFONO_SMS_TX_ST_DONE)
+		ok =3D TRUE;
+	else if (new_state =3D=3D OFONO_SMS_TX_ST_CANCELLED
+		 || new_state =3D=3D OFONO_SMS_TX_ST_FAILED
+		 || new_state =3D=3D OFONO_SMS_TX_ST_EXPIRED)
+		ok =3D FALSE;
+	else
+		return;
 =

 	ofono_debug("SMS submission %s", ok ? "successful" : "failed");
 =

@@ -712,7 +727,7 @@ static gboolean handle_command_send_sms(const struct st=
k_command *cmd,
 	msg_list.data =3D (void *) &cmd->send_sms.gsm_sms;
 	msg_list.next =3D NULL;
 =

-	__ofono_sms_txq_submit(sms, &msg_list, 0, send_sms_submit_cb,
+	__ofono_sms_txq_submit(sms, &msg_list, 0, send_sms_stch_cb,
 				stk->sms_submit_req, g_free);
 =

 	stk->cancel_cmd =3D send_sms_cancel;
-- =

1.6.6.1


--===============2907083012464942476==--

