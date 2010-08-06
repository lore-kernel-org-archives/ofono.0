Content-Type: multipart/mixed; boundary="===============4536582842454310459=="
MIME-Version: 1.0
From: Inaky Perez-Gonzalez <inaky@linux.intel.com>
Subject: [SMS D-Bus v5 05/17] sms: introduce bare state machine and transitions
Date: Thu, 05 Aug 2010 17:55:27 -0700
Message-ID: <396febd501a127750faf0ad9623118f775c0dd59.1281054654.git.inaky.perez-gonzalez@intel.com>
In-Reply-To: <cover.1281054654.git.inaky.perez-gonzalez@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4536582842454310459==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Inaky Perez-Gonzalez <inaky.perez-gonzalez@intel.com>

This adds state to outgoing/in-transit SMS messages. This will be used
later on for persistence / D-Bus, when the SMS life cycle is expanded.

The state is a variable in the 'struct tx_queue_entry' which gets
updated as messages go through the hoops.
---
 src/ofono.h |   33 +++++++++++++++++
 src/sms.c   |  117 +++++++++++++++++++++++++++++++++++++++++++++++++++++++=
+++-
 2 files changed, 148 insertions(+), 2 deletions(-)

diff --git a/src/ofono.h b/src/ofono.h
index 6fba8c3..2f7dfba 100644
--- a/src/ofono.h
+++ b/src/ofono.h
@@ -183,6 +183,39 @@ enum ofono_sms_submit_flag {
 	OFONO_SMS_SUBMIT_FLAG_RETRY =3D		0x4,
 };
 =

+/*
+ * SMS TX message's state
+ *
+ * When a message is queued to be delivered, it will transition
+ * through a set of states.
+ *
+ * Allowed transition table (Allowed, Not-allowed) from left to right:
+ *
+ *          UNINITIALIZED         CANCELING  FAILED
+ *               | QUEUED WSR DONE   | CANCELLED  EXPIRED
+ * UNINITIALIZED -    A    N    N    N    N    N    N
+ * QUEUED        N    -    A    A    A    N    A    N
+ * WSR           N    N    -    A    A    N    A    A
+ * DONE          A    N    N    -    N    N    N    N
+ * CANCELING     N    N    N    N    -    A    A    A
+ * CANCELLED     A    N    N    N    N    -    N    N
+ * FAILED        A    N    N    N    N    N    -    N
+ * EXPIRED       A    N    N    N    N    N    N    -
+ */
+enum ofono_sms_tx_state {
+	OFONO_SMS_TX_ST_UNINITIALIZED,
+	OFONO_SMS_TX_ST_QUEUED,
+	OFONO_SMS_TX_ST_WSR,
+	OFONO_SMS_TX_ST_DONE,
+	OFONO_SMS_TX_ST_CANCELING,
+	OFONO_SMS_TX_ST_CANCELLED,
+	OFONO_SMS_TX_ST_FAILED,
+	OFONO_SMS_TX_ST_EXPIRED,
+	__OFONO_SMS_TX_ST_INVALID,
+};
+
+const char *ofono_sms_tx_state_to_string(enum ofono_sms_tx_state);
+
 typedef void (*ofono_sms_txq_submit_cb_t)(gboolean ok, void *data);
 =

 struct tx_queue_entry *__ofono_sms_txq_submit(struct ofono_sms *sms,
diff --git a/src/sms.c b/src/sms.c
index d0563d0..90be5c1 100644
--- a/src/sms.c
+++ b/src/sms.c
@@ -51,6 +51,22 @@ static gboolean tx_next(gpointer user_data);
 =

 static GSList *g_drivers =3D NULL;
 =

+const char *ofono_sms_tx_state_to_string(enum ofono_sms_tx_state status)
+{
+	switch (status) {
+	case OFONO_SMS_TX_ST_UNINITIALIZED:	return "uninitialized";
+	case OFONO_SMS_TX_ST_QUEUED:		return "queued";
+	case OFONO_SMS_TX_ST_WSR:		return "wsr";
+	case OFONO_SMS_TX_ST_DONE:		return "done";
+	case OFONO_SMS_TX_ST_CANCELING:		return "canceling";
+	case OFONO_SMS_TX_ST_CANCELLED:		return "cancelled";
+	case OFONO_SMS_TX_ST_FAILED:		return "failed";
+	case OFONO_SMS_TX_ST_EXPIRED:		return "expired";
+	default:
+						return "invalid";
+	}
+}
+
 struct ofono_sms {
 	int flags;
 	DBusMessage *pending;
@@ -79,11 +95,17 @@ struct pending_pdu {
 	int pdu_len;
 };
 =

+/*
+ * @sms_mgr: SMS manager / driver object
+ * @state: Current state of the (in-transit) SMS
+ */
 struct tx_queue_entry {
+	struct ofono_sms *sms_mgr;
 	struct pending_pdu *pdus;
 	unsigned char num_pdus;
 	unsigned char cur_pdu;
 	struct sms_address receiver;
+	enum ofono_sms_tx_state state;
 	unsigned int msg_id;
 	unsigned int retry;
 	unsigned int flags;
@@ -407,6 +429,83 @@ static DBusMessage *sms_set_property(DBusConnection *c=
onn, DBusMessage *msg,
 	return __ofono_error_invalid_args(msg);
 }
 =

+/* Check if a state transition is legal */
+static void ofono_sms_tx_state_check(const char *file, unsigned line,
+				     const struct tx_queue_entry *entry,
+				     enum ofono_sms_tx_state state_old,
+				     enum ofono_sms_tx_state state_new,
+				     unsigned states_allowed_bm)
+{
+	if (((1 << state_new) & states_allowed_bm) =3D=3D 0)
+		ofono_warn("%s:%d: SW BUG? Forbidden state change "
+			   "%p %u -> %u\n",
+			   file, line, entry, state_old, state_new);
+}
+
+/*
+ * Set a pending SMS's state
+ *
+ * When leaving state, we do basic cleanup/release of resources
+ * allocated when we entered it.
+ *
+ * This is just syntactic sugar that validates that the transition is
+ * correct and warns out otherwise. The transition table is defined in
+ * the doc block for 'enum ofono_sms_tx_state'.
+ *
+ * In case of inconsistency, we just warn and press forward.
+ */
+#define ofono_sms_tx_state_set(entry, new_state) \
+	__ofono_sms_tx_state_set(entry, new_state, __FILE__, __LINE__)
+
+static void __ofono_sms_tx_state_set(struct tx_queue_entry *entry,
+				     enum ofono_sms_tx_state state_new,
+				     const char *file, unsigned line)
+{
+	enum ofono_sms_tx_state state_old =3D entry->state;
+
+	if (state_new =3D=3D state_old)
+		return;
+
+	switch (state_old) {
+	case OFONO_SMS_TX_ST_UNINITIALIZED:
+		ofono_sms_tx_state_check(
+			file, line, entry, state_old, state_new,
+			1 << OFONO_SMS_TX_ST_QUEUED);
+		break;
+	case OFONO_SMS_TX_ST_QUEUED:
+		ofono_sms_tx_state_check(
+			file, line, entry, state_old, state_new,
+			1 << OFONO_SMS_TX_ST_DONE
+			| 1 << OFONO_SMS_TX_ST_CANCELING
+			| 1 << OFONO_SMS_TX_ST_FAILED);
+		g_queue_remove(entry->sms_mgr->txq, entry);
+		break;
+	case OFONO_SMS_TX_ST_CANCELING:
+		ofono_sms_tx_state_check(
+			file, line, entry, state_old, state_new,
+			1 << OFONO_SMS_TX_ST_CANCELLED
+			| 1 << OFONO_SMS_TX_ST_FAILED
+			| 1 << OFONO_SMS_TX_ST_EXPIRED);
+		break;
+	case OFONO_SMS_TX_ST_DONE:
+	case OFONO_SMS_TX_ST_CANCELLED:
+	case OFONO_SMS_TX_ST_FAILED:
+	case OFONO_SMS_TX_ST_EXPIRED:
+		ofono_sms_tx_state_check(
+			file, line, entry, state_old, state_new,
+			1 << OFONO_SMS_TX_ST_UNINITIALIZED);
+		break;
+	case __OFONO_SMS_TX_ST_INVALID:
+	default:
+		ofono_warn("%s:%d: SW BUG? Bad state change %p %u -> %u\n",
+			   file, line, entry, state_old, state_new);
+	}
+	ofono_debug("%s:%d: SMS state change: %p %u -> %u\n",
+		    file, line, entry, state_old, state_new);
+	entry->state =3D state_new;
+}
+
+
 /*
  * Destroy/release the contents of a 'struct tx_queue_entry'
  *
@@ -419,6 +518,11 @@ static void tx_queue_entry_destroy(struct tx_queue_ent=
ry *entry)
 		entry->destroy(entry->data);
 =

 	g_free(entry->pdus);
+
+	if (entry->state =3D=3D OFONO_SMS_TX_ST_QUEUED)
+		g_queue_remove(entry->sms_mgr->txq, entry);
+
+	entry->state =3D __OFONO_SMS_TX_ST_INVALID;
 	g_free(entry);
 }
 =

@@ -437,8 +541,10 @@ static void tx_finished(const struct ofono_error *erro=
r, int mr, void *data)
 	DBG("tx_finished");
 =

 	if (ok =3D=3D FALSE) {
-		if (!(entry->flags & OFONO_SMS_SUBMIT_FLAG_RETRY))
+		if (!(entry->flags & OFONO_SMS_SUBMIT_FLAG_RETRY)) {
+			ofono_sms_tx_state_set(entry, OFONO_SMS_TX_ST_FAILED);
 			goto next_q;
+		}
 =

 		entry->retry +=3D 1;
 =

@@ -451,6 +557,7 @@ static void tx_finished(const struct ofono_error *error=
, int mr, void *data)
 		}
 =

 		DBG("Max retries reached, giving up");
+		ofono_sms_tx_state_set(entry, OFONO_SMS_TX_ST_FAILED);
 		goto next_q;
 	}
 =

@@ -470,7 +577,7 @@ static void tx_finished(const struct ofono_error *error=
, int mr, void *data)
 	}
 =

 next_q:
-	entry =3D g_queue_pop_head(sms->txq);
+	entry =3D g_queue_peek_head(sms->txq);
 =

 	if (entry->cb)
 		entry->cb(ok, entry->data);
@@ -486,6 +593,10 @@ next_q:
 		__ofono_history_sms_send_status(modem, entry->msg_id,
 						time(NULL), hs);
 	}
+	if (ok)
+		ofono_sms_tx_state_set(entry, OFONO_SMS_TX_ST_DONE);
+	else
+		ofono_sms_tx_state_set(entry, OFONO_SMS_TX_ST_FAILED);
 =

 	tx_queue_entry_destroy(entry);
 =

@@ -1401,8 +1512,10 @@ struct tx_queue_entry *__ofono_sms_txq_submit(struct=
 ofono_sms *sms,
 	entry->cb =3D cb;
 	entry->data =3D data;
 	entry->destroy =3D destroy;
+	entry->sms_mgr =3D sms;
 =

 	g_queue_push_tail(sms->txq, entry);
+	ofono_sms_tx_state_set(entry, OFONO_SMS_TX_ST_QUEUED);
 =

 	if (g_queue_get_length(sms->txq) =3D=3D 1)
 		sms->tx_source =3D g_timeout_add(0, tx_next, sms);
-- =

1.6.6.1


--===============4536582842454310459==--

