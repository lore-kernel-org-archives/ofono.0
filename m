Content-Type: multipart/mixed; boundary="===============5072710955137628652=="
MIME-Version: 1.0
From: Inaky Perez-Gonzalez <inaky@linux.intel.com>
Subject: [patch 15/20] SMS: introduce Wait-for-Status-Report state and
 infrastructure
Date: Fri, 23 Jul 2010 14:00:03 -0700
Message-ID: <d81c41faaf9a048f66d0b14674557ad0bc8f1753.1279918330.git.inaky.perez-gonzalez@intel.com>
In-Reply-To: <cover.1279918330.git.inaky.perez-gonzalez@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5072710955137628652==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Inaky Perez-Gonzalez <inaky.perez-gonzalez@intel.com>

A WSR (Waiting for Status Report) state definition is added to the
state transtition machine; as well, a queue (ofono_sms->tx_wfaq) where
messages waiting for an status report are queued. When the message's
delivery is acknowledged, the message is removed from the queue and
the message's status machine is updated, which can trigger things such
as D-Bus signals.
---
 src/sms.c |   70 +++++++++++++++++++++++++++++++++++++++++++++++++++++----=
---
 1 files changed, 61 insertions(+), 9 deletions(-)

diff --git a/src/sms.c b/src/sms.c
index de6eb7f..1075f33 100644
--- a/src/sms.c
+++ b/src/sms.c
@@ -67,6 +67,11 @@ const char *ofono_sms_tx_state_to_string(enum ofono_sms_=
tx_state status)
 }
 =

 =

+/**
+ * @tx_wsrq: Waiting-for-Status-Report queue; messages in this queue
+ *     have been delivered but are waiting to be acknoledged by the
+ *     network.
+ */
 struct ofono_sms {
 	int flags;
 	DBusMessage *pending;
@@ -74,6 +79,7 @@ struct ofono_sms {
 	struct sms_assembly *assembly;
 	guint ref;
 	GQueue *txq;
+	GQueue *tx_wsrq;
 	gint tx_source;
 	struct ofono_message_waiting *mw;
 	unsigned int mw_watch;
@@ -487,10 +493,19 @@ static void __ofono_sms_tx_state_set(struct tx_queue_=
entry *entry,
 	case OFONO_SMS_TX_ST_QUEUED:
 		ofono_sms_tx_state_check(
 			file, line, entry, state_old, state_new,
+			1 << OFONO_SMS_TX_ST_WSR
+			| 1 << OFONO_SMS_TX_ST_DONE
+			| 1 << OFONO_SMS_TX_ST_CANCELING);
+		g_queue_remove(entry->sms_mgr->txq, entry);
+		break;
+	case OFONO_SMS_TX_ST_WSR:
+		ofono_sms_tx_state_check(
+			file, line, entry, state_old, state_new,
 			1 << OFONO_SMS_TX_ST_DONE
 			| 1 << OFONO_SMS_TX_ST_CANCELING
-			| 1 << OFONO_SMS_TX_ST_FAILED);
-		g_queue_remove(entry->sms_mgr->txq, entry);
+			| 1 << OFONO_SMS_TX_ST_FAILED
+			| 1 << OFONO_SMS_TX_ST_EXPIRED);
+		g_queue_remove(entry->sms_mgr->tx_wsrq, entry);
 		break;
 	case OFONO_SMS_TX_ST_CANCELING:
 		ofono_sms_tx_state_check(
@@ -522,8 +537,8 @@ static void __ofono_sms_tx_state_set(struct tx_queue_en=
try *entry,
  * Destroy/release the contents of a 'struct tx_queue_entry'
  *
  * This releases resources allocated *inside* @entry and @entry
- * itself. We blindly remove from the submission queue, in case it is
- * still in any. We could do it with a 'checked' state change to
+ * itself. We blindly remove from both submission queues, in case it
+ * is still in any. We could do it with a 'checked' state change to
  * INVALID if we modify that function.
  */
 static void tx_queue_entry_destroy_free(gpointer _entry, gpointer unused)
@@ -534,6 +549,7 @@ static void tx_queue_entry_destroy_free(gpointer _entry=
, gpointer unused)
 		entry->destroy(entry->data);
 	g_free(entry->pdus);
 	g_queue_remove(entry->sms_mgr->txq, entry);
+	g_queue_remove(entry->sms_mgr->tx_wsrq, entry);
 	entry->state =3D __OFONO_SMS_TX_ST_INVALID;
 	g_free(entry);
 }
@@ -586,6 +602,7 @@ static void tx_finished(const struct ofono_error *error=
, int mr, void *data)
 next_q:
 	entry =3D g_queue_peek_head(sms->txq);
 =

+#warning FIXME: cb should not be called on WSR?
 	if (entry->cb)
 		entry->cb(ok, entry->data);
 =

@@ -599,12 +616,16 @@ next_q:
 		__ofono_history_sms_send_status(modem, entry->msg_id,
 						time(NULL), hs);
 	}
-	if (ok)
+	if (ok && entry->flags & OFONO_SMS_SUBMIT_FLAG_REQUEST_SR) {
+		ofono_sms_tx_state_set(entry, OFONO_SMS_TX_ST_WSR);
+		g_queue_push_tail(sms->tx_wsrq, entry);
+	} else if (ok && !(entry->flags & OFONO_SMS_SUBMIT_FLAG_REQUEST_SR)) {
 		ofono_sms_tx_state_set(entry, OFONO_SMS_TX_ST_DONE);
-	else
+		tx_queue_entry_destroy_free(entry, NULL);
+	} else {
 		ofono_sms_tx_state_set(entry, OFONO_SMS_TX_ST_FAILED);
-
-	tx_queue_entry_destroy_free(entry, NULL);
+		tx_queue_entry_destroy_free(entry, NULL);
+	}
 =

 	if (g_queue_peek_head(sms->txq)) {
 		DBG("Scheduling next");
@@ -1030,11 +1051,31 @@ static void handle_deliver(struct ofono_sms *sms, c=
onst struct sms *incoming)
 =

 =

 /*
+ * This function is a g_queue_foreach() functor called by
+ * handle_sms_status_report() to destroy the message that matches the
+ * reported MSG-ID in the SMS manager's list of messages waiting for
+ * acknowledgement.
+ */
+static void  __sms_find_destroy_by_msg_id(gpointer _sms_msg, gpointer _msg=
_id)
+{
+	unsigned msg_id =3D (unsigned) _msg_id;
+	struct tx_queue_entry *sms_msg =3D _sms_msg;
+
+	if (sms_msg->msg_id !=3D msg_id)
+		return;
+	ofono_debug("SMS: ACKED %p msg_id match %x", sms_msg, msg_id);
+	g_queue_remove(sms_msg->sms_mgr->tx_wsrq, sms_msg);
+	ofono_sms_tx_state_set(sms_msg, OFONO_SMS_TX_ST_DONE);
+	tx_queue_entry_destroy_free(sms_msg, NULL);
+}
+
+
+/*
  * Handle a delivery/status report has been received for an SMS
  * apparently sent from here.
  *
  * We need to find the message in the SMS manager's
- * waiting-for-acknoledge queue (sms->tx_wfaq) and remove it. As well,
+ * waiting-for-status report queue (sms->tx_wsrq) and remove it. As well,
  * fill out history for it.
  */
 static void handle_sms_status_report(struct ofono_sms *sms,
@@ -1048,6 +1089,9 @@ static void handle_sms_status_report(struct ofono_sms=
 *sms,
 						&delivered) =3D=3D FALSE)
 		return;
 =

+	g_queue_foreach(sms->tx_wsrq, __sms_find_destroy_by_msg_id,
+			(void *) msg_id);
+
 	__ofono_history_sms_send_status(modem, msg_id, time(NULL),
 			delivered ? OFONO_HISTORY_SMS_STATUS_DELIVERED :
 			OFONO_HISTORY_SMS_STATUS_DELIVER_FAILED);
@@ -1275,6 +1319,13 @@ static void sms_remove(struct ofono_atom *atom)
 		sms->txq =3D NULL;
 	}
 =

+	if (sms->tx_wsrq) {
+		g_queue_foreach(sms->tx_wsrq,
+				tx_queue_entry_destroy_free, NULL);
+		g_queue_free(sms->tx_wsrq);
+		sms->tx_wsrq =3D NULL;
+	}
+
 	if (sms->settings) {
 		g_key_file_set_integer(sms->settings, SETTINGS_GROUP,
 					"NextReference", sms->ref);
@@ -1329,6 +1380,7 @@ struct ofono_sms *ofono_sms_create(struct ofono_modem=
 *modem,
 	sms->sca.type =3D 129;
 	sms->ref =3D 1;
 	sms->txq =3D g_queue_new();
+	sms->tx_wsrq =3D g_queue_new();
 	sms->atom =3D __ofono_modem_add_atom(modem, OFONO_ATOM_TYPE_SMS,
 						sms_remove, sms);
 =

-- =

1.6.6.1


--===============5072710955137628652==--

