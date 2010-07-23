Content-Type: multipart/mixed; boundary="===============6461633946435766444=="
MIME-Version: 1.0
From: Inaky Perez-Gonzalez <inaky@linux.intel.com>
Subject: [patch 16/20] SMS: introduce a state change callback for TX messages
Date: Fri, 23 Jul 2010 14:00:04 -0700
Message-ID: <c3c61aeae69d44b94105a080b263fc6e27fc1ee3.1279918330.git.inaky.perez-gonzalez@intel.com>
In-Reply-To: <cover.1279918330.git.inaky.perez-gonzalez@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6461633946435766444==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Inaky Perez-Gonzalez <inaky.perez-gonzalez@intel.com>

When the SMS message going through the TX hoops changes states, call
the given callback function (if any). This will be used later to hook
up the D-Bus propagation of property changed signals.

Note this will takes away with the ofono_sms_txq_submit_cb callback,
as it can be implemented in terms of a state change callback.
---
 src/ofono.h |    5 +++--
 src/sms.c   |   36 +++++++++++++++++++++++++-----------
 src/stk.c   |   22 ++++++++++++++++++----
 3 files changed, 46 insertions(+), 17 deletions(-)

diff --git a/src/ofono.h b/src/ofono.h
index 51c2743..d5ac6f5 100644
--- a/src/ofono.h
+++ b/src/ofono.h
@@ -216,11 +216,12 @@ enum ofono_sms_tx_state {
 =

 const char *ofono_sms_tx_state_to_string(enum ofono_sms_tx_state);
 =

-typedef void (*ofono_sms_txq_submit_cb_t)(gboolean ok, void *data);
+typedef void (*ofono_sms_msg_stch_cb_t)(void *data,
+					enum ofono_sms_tx_state new_state);
 =

 struct tx_queue_entry * __ofono_sms_txq_submit(struct ofono_sms *sms, GSLi=
st *list,
 					unsigned int flags, unsigned ref,
-					ofono_sms_txq_submit_cb_t cb,
+					ofono_sms_msg_stch_cb_t stch_cb,
 					void *data, ofono_destroy_func destroy);
 =

 #include <ofono/sim.h>
diff --git a/src/sms.c b/src/sms.c
index 1075f33..668a645 100644
--- a/src/sms.c
+++ b/src/sms.c
@@ -114,7 +114,7 @@ struct tx_queue_entry {
 	unsigned int msg_id;
 	unsigned int retry;
 	unsigned int flags;
-	ofono_sms_txq_submit_cb_t cb;
+	ofono_sms_msg_stch_cb_t stch_cb;
 	void *data;
 	ofono_destroy_func destroy;
 };
@@ -530,6 +530,8 @@ static void __ofono_sms_tx_state_set(struct tx_queue_en=
try *entry,
 	ofono_debug("%s:%d: SMS state change: %p %u -> %u\n",
 		    file, line, entry, state_old, state_new);
 	entry->state =3D state_new;
+	if (entry->stch_cb)
+		entry->stch_cb(entry->data, state_new);
 }
 =

 =

@@ -602,10 +604,6 @@ static void tx_finished(const struct ofono_error *erro=
r, int mr, void *data)
 next_q:
 	entry =3D g_queue_peek_head(sms->txq);
 =

-#warning FIXME: cb should not be called on WSR?
-	if (entry->cb)
-		entry->cb(ok, entry->data);
-
 	if (entry->flags & OFONO_SMS_SUBMIT_FLAG_RECORD_HISTORY) {
 		enum ofono_history_sms_status hs;
 =

@@ -700,12 +698,27 @@ static struct tx_queue_entry *tx_queue_entry_new(GSLi=
st *msg_list)
 	return entry;
 }
 =

-static void send_message_cb(gboolean ok, void *data)
+static void send_message_stch_cb(void *data, enum ofono_sms_tx_state new_s=
tate)
 {
 	DBusConnection *conn =3D ofono_dbus_get_connection();
 	struct sms_msg_dbus_data *dbus_data =3D data;
 	DBusMessage *msg =3D dbus_data->dbus_msg;
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
@@ -795,9 +808,10 @@ static DBusMessage *sms_send_message(DBusConnection *c=
onn, DBusMessage *msg,
 	if (sms->use_delivery_reports)
 		flags |=3D OFONO_SMS_SUBMIT_FLAG_REQUEST_SR;
 =

-	sms_msg =3D __ofono_sms_txq_submit(sms, msg_list, flags, msg_id, send_mes=
sage_cb,
-						dbus_message_ref(msg),
-						send_message_destroy);
+	sms_msg =3D __ofono_sms_txq_submit(sms, msg_list, flags, msg_id,
+					 send_message_stch_cb,
+					 dbus_message_ref(msg),
+					 send_message_destroy);
 =

 	g_slist_foreach(msg_list, (GFunc)g_free, NULL);
 	g_slist_free(msg_list);
@@ -1528,7 +1542,7 @@ void *ofono_sms_get_data(struct ofono_sms *sms)
 =

 struct tx_queue_entry * __ofono_sms_txq_submit(struct ofono_sms *sms, GSLi=
st *list,
 					unsigned int flags, unsigned msg_id,
-					ofono_sms_txq_submit_cb_t cb,
+					ofono_sms_msg_stch_cb_t stch_cb,
 					void *data, ofono_destroy_func destroy)
 {
 	struct tx_queue_entry *entry =3D tx_queue_entry_new(list);
@@ -1542,7 +1556,7 @@ struct tx_queue_entry * __ofono_sms_txq_submit(struct=
 ofono_sms *sms, GSList *li
 =

 	entry->msg_id =3D msg_id;
 	entry->flags =3D flags;
-	entry->cb =3D cb;
+	entry->stch_cb =3D stch_cb;
 	entry->data =3D data;
 	entry->destroy =3D destroy;
 	entry->sms_mgr =3D sms;
diff --git a/src/stk.c b/src/stk.c
index 400b033..c253aa2 100644
--- a/src/stk.c
+++ b/src/stk.c
@@ -287,13 +287,27 @@ static void send_sms_cancel(struct ofono_stk *stk)
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
 =

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
 	ofono_debug("SMS submission %s", ok ? "successful" : "failed");
 =

 	if (req->cancelled) {
@@ -339,8 +353,8 @@ static gboolean handle_command_send_sms(const struct st=
k_command *cmd,
 	msg_list.data =3D (void *) &cmd->send_sms.gsm_sms;
 	msg_list.next =3D NULL;
 #warning FIXME: fix msg_id, missing
-	__ofono_sms_txq_submit(sms, &msg_list, 0, 0, send_sms_submit_cb,
-				stk->sms_submit_req, g_free);
+	__ofono_sms_txq_submit(sms, &msg_list, 0, 0, send_sms_stch_cb,
+			       stk->sms_submit_req, g_free);
 =

 	stk->cancel_cmd =3D send_sms_cancel;
 =

-- =

1.6.6.1


--===============6461633946435766444==--

