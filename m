Content-Type: multipart/mixed; boundary="===============2124311120672017242=="
MIME-Version: 1.0
From: Inaky Perez-Gonzalez <inaky@linux.intel.com>
Subject: [SMS D-Bus 16/23] SMS: introduce wait-for-ack state and infrastructure
Date: Fri, 25 Jun 2010 16:15:38 -0700
Message-ID: <6bdef8322417d1c7bc18848b118ec3ff29c1643c.1277507431.git.inaky.perez-gonzalez@intel.com>
In-Reply-To: <cover.1277507431.git.inaky.perez-gonzalez@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2124311120672017242==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Inaky Perez-Gonzalez <inaky.perez-gonzalez@intel.com>

This introduces basic infrastructure to support wait-for-ack in SMS
messages. It consists of a state definition in the state transtition
machine, a wait-for-ack queue (ofono_sms->wfaq) and a flag setting in
which a message is tagged as 'requests wait for ack'.

This does not implement the network bits, just the basic
infrastructure bits.
---
 src/sms.c |   61 ++++++++++++++++++++++++++++++++++++++++++++++++---------=
----
 1 files changed, 48 insertions(+), 13 deletions(-)

diff --git a/src/sms.c b/src/sms.c
index 0182ac8..97c7429 100644
--- a/src/sms.c
+++ b/src/sms.c
@@ -62,19 +62,21 @@ static GSList *g_drivers =3D NULL;
  *
  * Allowed transition table (Allowed, Not-allowed) from left to right:
  *
- *          UNINITIALIZED     CANCELING  FAILED
- *               | QUEUED DONE   | CANCELLED  EXPIRED
- * UNINITIALIZED -    A     N    N    N    N    N
- * QUEUED        N    -     A    A    N    A    N
- * DONE          A    N     -    N    N    N    N
- * CANCELING     N    N     N    -    A    A    A
- * CANCELLED     A    N     N    N    -    N    N
- * FAILED        A    N     N    N    N    -    N
- * EXPIRED       A    N     N    N    N    N    -
+ *          UNINITIALIZED         CANCELING  FAILED
+ *               | QUEUED WFA DONE   | CANCELLED  EXPIRED
+ * UNINITIALIZED -    A    N    N    N    N    N    N
+ * QUEUED        N    -    A    A    A    N    A    N
+ * WFA           N    N    -    A    A    N    A    A
+ * DONE          A    N    N    -    N    N    N    N
+ * CANCELING     N    N    N    N    -    A    A    A
+ * CANCELLED     A    N    N    N    N    -    N    N
+ * FAILED        A    N    N    N    N    N    -    N
+ * EXPIRED       A    N    N    N    N    N    N    -
  */
 enum ofono_sms_tx_state {
 	OFONO_SMS_TX_ST_UNINITIALIZED,
 	OFONO_SMS_TX_ST_QUEUED,
+	OFONO_SMS_TX_ST_WFA,
 	OFONO_SMS_TX_ST_DONE,
 	OFONO_SMS_TX_ST_CANCELING,
 	OFONO_SMS_TX_ST_CANCELLED,
@@ -83,6 +85,12 @@ enum ofono_sms_tx_state {
 	__OFONO_SMS_TX_ST_INVALID,
 };
 =

+
+/**
+ * @wfaq: Waiting-For-Acknoledgement queue; messages in this queue
+ *     have been delivered but are waiting to be acknoledged by the
+ *     network.
+ */
 struct ofono_sms {
 	int flags;
 	DBusMessage *pending;
@@ -90,6 +98,7 @@ struct ofono_sms {
 	struct sms_assembly *assembly;
 	guint ref;
 	GQueue *txq;
+	GQueue *tx_wfaq;
 	gint tx_source;
 	struct ofono_message_waiting *mw;
 	unsigned int mw_watch;
@@ -113,9 +122,13 @@ struct pending_pdu {
 /*
  * @name: Name for the SMS message object (used by D-Bus)
  * @dbus_path: D-Bus path for this object
+ * @sms_mgr: SMS manager / driver object
  * @state: Current state of the (in-transit) SMS
+ * @status_report: message reception/delivery should be acknoledged by
+ *     the network.
  */
 struct tx_queue_entry {
+	struct ofono_sms *sms_mgr;
 	struct pending_pdu *pdus;
 	unsigned char num_pdus;
 	unsigned char cur_pdu;
@@ -375,9 +388,17 @@ static void __ofono_sms_tx_state_set(struct tx_queue_e=
ntry *entry,
 	case OFONO_SMS_TX_ST_QUEUED:
 		ofono_sms_tx_state_check(
 			file, line, entry, state_old, state_new,
+			1 << OFONO_SMS_TX_ST_WFA
+			| 1 << OFONO_SMS_TX_ST_DONE
+			| 1 << OFONO_SMS_TX_ST_CANCELING);
+		break;
+	case OFONO_SMS_TX_ST_WFA:
+		ofono_sms_tx_state_check(
+			file, line, entry, state_old, state_new,
 			1 << OFONO_SMS_TX_ST_DONE
 			| 1 << OFONO_SMS_TX_ST_CANCELING
-			| 1 << OFONO_SMS_TX_ST_FAILED);
+			| 1 << OFONO_SMS_TX_ST_FAILED
+			| 1 << OFONO_SMS_TX_ST_EXPIRED);
 		break;
 	case OFONO_SMS_TX_ST_CANCELING:
 		ofono_sms_tx_state_check(
@@ -543,9 +564,14 @@ static void tx_finished(const struct ofono_error *erro=
r, int mr, void *data)
 					time(NULL),
 					OFONO_HISTORY_SMS_STATUS_SUBMITTED);
 =

-	ofono_sms_tx_state_set(entry, OFONO_SMS_TX_ST_DONE);
-	tx_queue_entry_destroy(entry);
-	g_free(entry);
+	if (entry->status_report) {
+		ofono_sms_tx_state_set(entry, OFONO_SMS_TX_ST_WFA);
+		g_queue_push_tail(sms->tx_wfaq, entry);
+	} else {
+		ofono_sms_tx_state_set(entry, OFONO_SMS_TX_ST_DONE);
+		tx_queue_entry_destroy(entry);
+		g_free(entry);
+	}
 =

 	if (g_queue_peek_head(sms->txq)) {
 		DBG("Scheduling next");
@@ -683,6 +709,7 @@ struct tx_queue_entry *sms_msg_send(
 		    entry, ref, ref_offset, msg_id_str);
 	entry->msg_id =3D ref;
 	entry->receiver =3D receiver;
+	entry->sms_mgr =3D sms;
 =

 	g_slist_foreach(msg_list, (GFunc)g_free, NULL);
 	g_slist_free(msg_list);
@@ -1217,6 +1244,13 @@ static void sms_remove(struct ofono_atom *atom)
 		sms->txq =3D NULL;
 	}
 =

+	if (sms->tx_wfaq) {
+		g_queue_foreach(sms->tx_wfaq,
+				tx_queue_entry_destroy_free, NULL);
+		g_queue_free(sms->tx_wfaq);
+		sms->tx_wfaq =3D NULL;
+	}
+
 	if (sms->settings) {
 		g_key_file_set_integer(sms->settings, SETTINGS_GROUP,
 					"NextReference", sms->ref);
@@ -1269,6 +1303,7 @@ struct ofono_sms *ofono_sms_create(struct ofono_modem=
 *modem,
 	sms->sca.type =3D 129;
 	sms->ref =3D 1;
 	sms->txq =3D g_queue_new();
+	sms->tx_wfaq =3D g_queue_new();
 	sms->atom =3D __ofono_modem_add_atom(modem, OFONO_ATOM_TYPE_SMS,
 						sms_remove, sms);
 =

-- =

1.6.6.1


--===============2124311120672017242==--

