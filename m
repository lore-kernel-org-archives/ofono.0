Content-Type: multipart/mixed; boundary="===============0227348552287675601=="
MIME-Version: 1.0
From: Inaky Perez-Gonzalez <inaky@linux.intel.com>
Subject: [SMS D-Bus v5 06/17] sms: introduce the Wait-for-Status-Report state
Date: Thu, 05 Aug 2010 17:55:28 -0700
Message-ID: <376e87b34d9475f0b1fb986006587dd703c78036.1281054654.git.inaky.perez-gonzalez@intel.com>
In-Reply-To: <cover.1281054654.git.inaky.perez-gonzalez@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0227348552287675601==
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
 src/sms.c |   80 +++++++++++++++++++++++++++++++++++++++++++++++++++++++--=
---
 1 files changed, 73 insertions(+), 7 deletions(-)

diff --git a/src/sms.c b/src/sms.c
index 90be5c1..a5e3a85 100644
--- a/src/sms.c
+++ b/src/sms.c
@@ -67,6 +67,11 @@ const char *ofono_sms_tx_state_to_string(enum ofono_sms_=
tx_state status)
 	}
 }
 =

+/**
+ * @tx_wsrq: Waiting-for-Status-Report queue; messages in this queue
+ *     have been delivered but are waiting to be acknoledged by the
+ *     network.
+ */
 struct ofono_sms {
 	int flags;
 	DBusMessage *pending;
@@ -75,6 +80,7 @@ struct ofono_sms {
 	unsigned int next_msg_id;
 	guint ref;
 	GQueue *txq;
+	GQueue *tx_wsrq;
 	gint tx_source;
 	struct ofono_message_waiting *mw;
 	unsigned int mw_watch;
@@ -475,10 +481,19 @@ static void __ofono_sms_tx_state_set(struct tx_queue_=
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
@@ -521,6 +536,8 @@ static void tx_queue_entry_destroy(struct tx_queue_entr=
y *entry)
 =

 	if (entry->state =3D=3D OFONO_SMS_TX_ST_QUEUED)
 		g_queue_remove(entry->sms_mgr->txq, entry);
+	else if (entry->state =3D=3D OFONO_SMS_TX_ST_WSR)
+		g_queue_remove(entry->sms_mgr->tx_wsrq, entry);
 =

 	entry->state =3D __OFONO_SMS_TX_ST_INVALID;
 	g_free(entry);
@@ -593,12 +610,16 @@ next_q:
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
+		tx_queue_entry_destroy(entry);
+	} else {
 		ofono_sms_tx_state_set(entry, OFONO_SMS_TX_ST_FAILED);
-
-	tx_queue_entry_destroy(entry);
+		tx_queue_entry_destroy(entry);
+	}
 =

 	if (g_queue_peek_head(sms->txq)) {
 		DBG("Scheduling next");
@@ -1041,13 +1062,45 @@ static void handle_deliver(struct ofono_sms *sms, c=
onst struct sms *incoming)
 	g_slist_free(l);
 }
 =

+/*
+ * Pack information needed to locate a message from a Status Report
+ * and decide if it was succesfully delivered.
+ */
+struct sms_msg_sr_locator {
+	unsigned int msg_id;
+	gboolean delivered;
+};
+
+/*
+ * This function is a g_queue_foreach() functor called by
+ * handle_sms_status_report() to destroy the message that matches the
+ * reported MSG-ID in the SMS manager's list of messages waiting for
+ * acknowledgement.
+ */
+static void  __sms_find_destroy_by_msg_id(gpointer _sms_msg, gpointer _loc=
ator)
+{
+	const struct sms_msg_sr_locator *locator =3D _locator;
+	struct tx_queue_entry *sms_msg =3D _sms_msg;
+
+	if (sms_msg->msg_id !=3D locator->msg_id)
+		return;
+	ofono_debug("SMS: ACKED %p msg_id match %x", sms_msg, locator->msg_id);
+	g_queue_remove(sms_msg->sms_mgr->tx_wsrq, sms_msg);
+
+	if (locator->delivered)
+		ofono_sms_tx_state_set(sms_msg, OFONO_SMS_TX_ST_DONE);
+	else
+		ofono_sms_tx_state_set(sms_msg, OFONO_SMS_TX_ST_FAILED);
+
+	tx_queue_entry_destroy(sms_msg);
+}
 =

 /*
  * Handle a delivery/status report has been received for an SMS
  * apparently sent from here.
  *
  * We need to find the message in the SMS manager's
- * waiting-for-acknoledge queue (sms->tx_wfaq) and remove it. As well,
+ * waiting-for-status report queue (sms->tx_wsrq) and remove it. As well,
  * fill out history for it.
  */
 static void handle_sms_status_report(struct ofono_sms *sms,
@@ -1056,11 +1109,16 @@ static void handle_sms_status_report(struct ofono_s=
ms *sms,
 	struct ofono_modem *modem =3D __ofono_atom_get_modem(sms->atom);
 	gboolean delivered;
 	unsigned int msg_id;
+	struct sms_msg_sr_locator locator;
 =

 	if (status_report_assembly_report(sms->sr_assembly, incoming, &msg_id,
 						&delivered) =3D=3D FALSE)
 		return;
 =

+	locator.msg_id =3D msg_id;
+	locator.delivered =3D delivered;
+	g_queue_foreach(sms->tx_wsrq, __sms_find_destroy_by_msg_id, &locator);
+
 	__ofono_history_sms_send_status(modem, msg_id, time(NULL),
 			delivered ? OFONO_HISTORY_SMS_STATUS_DELIVERED :
 			OFONO_HISTORY_SMS_STATUS_DELIVER_FAILED);
@@ -1288,6 +1346,13 @@ static void sms_remove(struct ofono_atom *atom)
 		sms->txq =3D NULL;
 	}
 =

+	if (sms->tx_wsrq) {
+		g_queue_foreach(sms->tx_wsrq,
+				tx_queue_entry_destroy_foreach, NULL);
+		g_queue_free(sms->tx_wsrq);
+		sms->tx_wsrq =3D NULL;
+	}
+
 	if (sms->settings) {
 		g_key_file_set_integer(sms->settings, SETTINGS_GROUP,
 					"NextMessageId", sms->next_msg_id);
@@ -1344,6 +1409,7 @@ struct ofono_sms *ofono_sms_create(struct ofono_modem=
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


--===============0227348552287675601==--

