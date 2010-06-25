Content-Type: multipart/mixed; boundary="===============8149021376921073615=="
MIME-Version: 1.0
From: Inaky Perez-Gonzalez <inaky@linux.intel.com>
Subject: [SMS D-Bus 13/23] SMS: introduce bare state machine and transitions
Date: Fri, 25 Jun 2010 16:15:35 -0700
Message-ID: <3504942ae775e0844cd56f5c0d85b18e42de357a.1277507431.git.inaky.perez-gonzalez@intel.com>
In-Reply-To: <cover.1277507431.git.inaky.perez-gonzalez@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8149021376921073615==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Inaky Perez-Gonzalez <inaky.perez-gonzalez@intel.com>

This adds state to outgoing/in-transit SMS messages. This will be used
later on for persistence / D-Bus, when the SMS life cycle is expanded.

The state is a variable in the 'struct tx_queue_entry' which gets
updated as messages go through the hoops.
---
 src/sms.c |  107 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++
 1 files changed, 107 insertions(+), 0 deletions(-)

diff --git a/src/sms.c b/src/sms.c
index 87ea926..0bdfc45 100644
--- a/src/sms.c
+++ b/src/sms.c
@@ -50,6 +50,35 @@ static gboolean tx_next(gpointer user_data);
 =

 static GSList *g_drivers =3D NULL;
 =

+/*
+ * SMS TX message's state
+ *
+ * When a message is queued to be delivered, it will transition
+ * through a set of states.
+ *
+ * Allowed transition table (Allowed, Not-allowed) from left to right:
+ *
+ *          UNINITIALIZED     CANCELING  FAILED
+ *               | QUEUED DONE   | CANCELLED  EXPIRED
+ * UNINITIALIZED -    A     N    N    N    N    N
+ * QUEUED        N    -     A    A    N    A    N
+ * DONE          A    N     -    N    N    N    N
+ * CANCELING     N    N     N    -    A    A    A
+ * CANCELLED     A    N     N    N    -    N    N
+ * FAILED        A    N     N    N    N    -    N
+ * EXPIRED       A    N     N    N    N    N    -
+ */
+enum ofono_sms_tx_state {
+	OFONO_SMS_TX_ST_UNINITIALIZED,
+	OFONO_SMS_TX_ST_QUEUED,
+	OFONO_SMS_TX_ST_DONE,
+	OFONO_SMS_TX_ST_CANCELING,
+	OFONO_SMS_TX_ST_CANCELLED,
+	OFONO_SMS_TX_ST_FAILED,
+	OFONO_SMS_TX_ST_EXPIRED,
+	__OFONO_SMS_TX_ST_INVALID,
+};
+
 struct ofono_sms {
 	int flags;
 	DBusMessage *pending;
@@ -79,6 +108,7 @@ struct pending_pdu {
 =

 /*
  * @name: Name for the SMS message object (used by D-Bus)
+ * @state: Current state of the (in-transit) SMS
  */
 struct tx_queue_entry {
 	struct pending_pdu *pdus;
@@ -90,6 +120,7 @@ struct tx_queue_entry {
 	gboolean status_report;
 	struct sms_address receiver;
 	char *name;
+	enum ofono_sms_tx_state state;
 };
 =

 static void set_sca(struct ofono_sms *sms,
@@ -297,6 +328,77 @@ static DBusMessage *sms_set_property(DBusConnection *c=
onn, DBusMessage *msg,
 }
 =

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
+
+/*
+ * Set a pending SMS's state
+ *
+ * This is just syntatic sugar that validates that the transition is
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
@@ -307,6 +409,7 @@ static void tx_queue_entry_destroy(struct tx_queue_entr=
y *entry)
 {
 	g_free(entry->pdus);
 	g_free(entry->name);
+	entry->state =3D __OFONO_SMS_TX_ST_INVALID;
 }
 =

 static void tx_queue_entry_destroy_free(gpointer _entry, gpointer unused)
@@ -337,6 +440,7 @@ static void tx_finished(const struct ofono_error *error=
, int mr, void *data)
 =

 		DBG("Max retries reached, giving up");
 =

+		ofono_sms_tx_state_set(entry, OFONO_SMS_TX_ST_CANCELING);
 		entry =3D g_queue_pop_head(sms->txq);
 		__ofono_dbus_pending_reply(&entry->msg,
 					__ofono_error_failed(entry->msg));
@@ -345,6 +449,7 @@ static void tx_finished(const struct ofono_error *error=
, int mr, void *data)
 					time(NULL),
 					OFONO_HISTORY_SMS_STATUS_SUBMIT_FAILED);
 =

+		ofono_sms_tx_state_set(entry, OFONO_SMS_TX_ST_FAILED);
 		tx_queue_entry_destroy(entry);
 		g_free(entry);
 =

@@ -378,6 +483,7 @@ static void tx_finished(const struct ofono_error *error=
, int mr, void *data)
 					time(NULL),
 					OFONO_HISTORY_SMS_STATUS_SUBMITTED);
 =

+	ofono_sms_tx_state_set(entry, OFONO_SMS_TX_ST_DONE);
 	tx_queue_entry_destroy(entry);
 	g_free(entry);
 =

@@ -534,6 +640,7 @@ static DBusMessage *sms_send_message(DBusConnection *co=
nn, DBusMessage *msg,
 	ofono_debug("sms/entry %p name %s\n", entry, entry->name);
 =

 	g_queue_push_tail(sms->txq, entry);
+	ofono_sms_tx_state_set(entry, OFONO_SMS_TX_ST_QUEUED);
 =

 	modem =3D __ofono_atom_get_modem(sms->atom);
 	__ofono_history_sms_send_pending(modem, entry->msg_id, to,
-- =

1.6.6.1


--===============8149021376921073615==--

