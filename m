Content-Type: multipart/mixed; boundary="===============8698186734566191252=="
MIME-Version: 1.0
From: Inaky Perez-Gonzalez <inaky@linux.intel.com>
Subject: [SMS D-Bus 14/23] SMS: export outgoing messages over D-Bus (skeleton)
Date: Fri, 25 Jun 2010 16:15:36 -0700
Message-ID: <35d2fe59c28a8e703a5204cbfcc1e981cf5479d0.1277507431.git.inaky.perez-gonzalez@intel.com>
In-Reply-To: <cover.1277507431.git.inaky.perez-gonzalez@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8698186734566191252==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Inaky Perez-Gonzalez <inaky.perez-gonzalez@intel.com>

This creates two frunctions, sms_msg_[un]register() which will
add/remove a D-Bus object for each SMS message when in transit.

Future changes make sms_msg_register() need information that is not
available at the time create_tx_queue_entry() is called, thus why
registration happens later.
---
 src/sms.c |   58 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 57 insertions(+), 1 deletions(-)

diff --git a/src/sms.c b/src/sms.c
index 0bdfc45..49b9c4c 100644
--- a/src/sms.c
+++ b/src/sms.c
@@ -41,6 +41,10 @@
 =

 #define SMS_MANAGER_FLAG_CACHED 0x1
 =

+/* D-Bus interface name for SMS messages (not for the manager!) */
+static
+const char SMS_MSG_INTERFACE[] =3D "org.ofono.SMSMessage";
+
 #define SETTINGS_STORE "sms"
 #define SETTINGS_GROUP "Settings"
 =

@@ -108,6 +112,7 @@ struct pending_pdu {
 =

 /*
  * @name: Name for the SMS message object (used by D-Bus)
+ * @dbus_path: D-Bus path for this object
  * @state: Current state of the (in-transit) SMS
  */
 struct tx_queue_entry {
@@ -120,6 +125,7 @@ struct tx_queue_entry {
 	gboolean status_report;
 	struct sms_address receiver;
 	char *name;
+	char *dbus_path;
 	enum ofono_sms_tx_state state;
 };
 =

@@ -400,6 +406,55 @@ static void __ofono_sms_tx_state_set(struct tx_queue_e=
ntry *entry,
 =

 =

 /*
+ * D-Bus SMS Message interface
+ *
+ * NOTE: the sms_msg_{methods,signals} tables should be const, but
+ * then g_dbus_register_interface() type warns.
+ */
+
+static
+GDBusMethodTable sms_msg_methods[] =3D {
+	{ }
+};
+
+
+static
+GDBusSignalTable sms_msg_signals[] =3D {
+	{ "PropertyChanged",	"sv"		},
+	{ }
+};
+
+
+static
+void sms_msg_register(struct tx_queue_entry *sms_msg)
+{
+	g_assert(sms_msg->name !=3D NULL);
+	sms_msg->dbus_path =3D g_strdup(sms_msg->name);
+	if (!g_dbus_register_interface(ofono_dbus_get_connection(),
+				       sms_msg->dbus_path, SMS_MSG_INTERFACE,
+				       sms_msg_methods, sms_msg_signals,
+				       NULL, sms_msg, NULL)) {
+		ofono_error("%s: Could not create %s interface",
+			    sms_msg->dbus_path, SMS_MSG_INTERFACE);
+		g_free(sms_msg->dbus_path);
+	}
+	ofono_debug("%s: %d: sms %p: MSG registered @ %s",
+		    __FILE__, __LINE__, sms_msg, sms_msg->dbus_path);
+}
+
+
+static
+void sms_msg_unregister(struct tx_queue_entry *sms_msg)
+{
+	g_dbus_unregister_interface(ofono_dbus_get_connection(),
+				    sms_msg->dbus_path, SMS_MSG_INTERFACE);
+	g_free(sms_msg->dbus_path);
+	ofono_debug("%s: %d: sms %p: MSG unregistered",
+		    __FILE__, __LINE__, sms_msg);
+}
+
+
+/*
  * Destroy/release the contents of a 'struct tx_queue_entry'
  *
  * This *only* releases resources allocated *inside* @entry. The
@@ -407,6 +462,7 @@ static void __ofono_sms_tx_state_set(struct tx_queue_en=
try *entry,
  */
 static void tx_queue_entry_destroy(struct tx_queue_entry *entry)
 {
+	sms_msg_unregister(entry);
 	g_free(entry->pdus);
 	g_free(entry->name);
 	entry->state =3D __OFONO_SMS_TX_ST_INVALID;
@@ -556,7 +612,6 @@ static struct tx_queue_entry *create_tx_queue_entry(GSL=
ist *msg_list)
 		DBG("pdu_len: %d, tpdu_len: %d",
 				pdu->pdu_len, pdu->tpdu_len);
 	}
-
 	return entry;
 }
 =

@@ -638,6 +693,7 @@ static DBusMessage *sms_send_message(DBusConnection *co=
nn, DBusMessage *msg,
 	entry->name =3D g_strdup_printf(SMS_MSG_NAME_FMT, sms_path,
 				      msg_id_str, entry->num_pdus);
 	ofono_debug("sms/entry %p name %s\n", entry, entry->name);
+	sms_msg_register(entry);
 =

 	g_queue_push_tail(sms->txq, entry);
 	ofono_sms_tx_state_set(entry, OFONO_SMS_TX_ST_QUEUED);
-- =

1.6.6.1


--===============8698186734566191252==--

