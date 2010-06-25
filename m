Content-Type: multipart/mixed; boundary="===============4308266934130910899=="
MIME-Version: 1.0
From: Inaky Perez-Gonzalez <inaky@linux.intel.com>
Subject: [SMS D-Bus 20/23] SMS: send D-Bus SMS-MSG::ProperyChanged signals
 when message changes status
Date: Fri, 25 Jun 2010 16:15:42 -0700
Message-ID: <83b794b43f4840b09be9d4019fbbba4ad07ef94e.1277507431.git.inaky.perez-gonzalez@intel.com>
In-Reply-To: <cover.1277507431.git.inaky.perez-gonzalez@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4308266934130910899==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Inaky Perez-Gonzalez <inaky.perez-gonzalez@intel.com>

This hooks __sms_msg_state_change_dbus_signal() into
__ofono_sms_tx_state_set(), so that a D-Bus signal will be emitted
whenever an SMS Message transitions state. This allows a client to
track, if desired, what is going on with the SMS Message it cares about.

With this, we can remove, in tx_finished() the asynchornous
finalization of the call (via sms_msg->dbus_msg) and make the call
synchronous (follow up commit).

The rest of the sites that were calling __ofono_sms_tx_state_set() get
(by definition) to send the signal.
---
 src/sms.c                      |   33 +++++++++++++++++++++++++++------
 test/test-sms-msg-state-change |   24 ++++++++++++++++++++++++
 2 files changed, 51 insertions(+), 6 deletions(-)
 create mode 100755 test/test-sms-msg-state-change

diff --git a/src/sms.c b/src/sms.c
index 77904ad..11d1f33 100644
--- a/src/sms.c
+++ b/src/sms.c
@@ -380,6 +380,32 @@ static void ofono_sms_tx_state_check(const char *file,=
 unsigned line,
 =

 =

 /*
+ * Send a PropertyChange signal when the state changes
+ *
+ * D-Bus typing is "ss" for variable/value.
+ */
+static
+void __sms_msg_state_change_dbus_signal(struct tx_queue_entry *sms_msg)
+{
+	DBusConnection *dbus_conn =3D ofono_dbus_get_connection();
+	DBusMessage *dbus_signal;
+	DBusMessageIter iter;
+	const char *property =3D "TXState";
+	const char *new_state_str;
+
+	dbus_signal =3D dbus_message_new_signal(
+		sms_msg->dbus_path, SMS_MSG_INTERFACE, "PropertyChanged");
+	if (!dbus_signal)
+		return;
+	dbus_message_iter_init_append(dbus_signal, &iter);
+	dbus_message_iter_append_basic(&iter, DBUS_TYPE_STRING, &property);
+	new_state_str =3D ofono_sms_tx_state_to_string(sms_msg->state);
+	dbus_message_iter_append_basic(&iter, DBUS_TYPE_STRING, &new_state_str);
+	g_dbus_send_message(dbus_conn, dbus_signal);
+}
+
+
+/*
  * Set a pending SMS's state
  *
  * This is just syntatic sugar that validates that the transition is
@@ -441,6 +467,7 @@ static void __ofono_sms_tx_state_set(struct tx_queue_en=
try *entry,
 	ofono_debug("%s:%d: SMS state change: %p %u -> %u\n",
 		    file, line, entry, state_old, state_new);
 	entry->state =3D state_new;
+	__sms_msg_state_change_dbus_signal(entry);
 }
 =

 =

@@ -584,10 +611,7 @@ static void tx_finished(const struct ofono_error *erro=
r, int mr, void *data)
 =

 		DBG("Max retries reached, giving up");
 =

-		ofono_sms_tx_state_set(entry, OFONO_SMS_TX_ST_CANCELING);
 		entry =3D g_queue_pop_head(sms->txq);
-		__ofono_dbus_pending_reply(&entry->dbus_msg,
-					__ofono_error_failed(entry->dbus_msg));
 =

 		__ofono_history_sms_send_status(modem, entry->msg_id,
 					time(NULL),
@@ -621,9 +645,6 @@ static void tx_finished(const struct ofono_error *error=
, int mr, void *data)
 	}
 =

 	entry =3D g_queue_pop_head(sms->txq);
-	__ofono_dbus_pending_reply(
-		&entry->dbus_msg,
-		dbus_message_new_method_return(entry->dbus_msg));
 	__ofono_history_sms_send_status(modem, entry->msg_id,
 					time(NULL),
 					OFONO_HISTORY_SMS_STATUS_SUBMITTED);
diff --git a/test/test-sms-msg-state-change b/test/test-sms-msg-state-change
new file mode 100755
index 0000000..18486bf
--- /dev/null
+++ b/test/test-sms-msg-state-change
@@ -0,0 +1,24 @@
+#!/usr/bin/python
+
+import gobject
+
+import dbus
+import dbus.mainloop.glib
+
+def property_changed(name, value, path, interface):
+        if interface =3D=3D "org.ofono.SMSMessage":
+                print "%s: name %s value %s interface %s" \
+                    % (path, name, value, interface)
+
+if __name__ =3D=3D '__main__':
+        print "FIXME: this should test the whole state change transition m=
achine"
+	dbus.mainloop.glib.DBusGMainLoop(set_as_default=3DTrue)
+
+	bus =3D dbus.SystemBus()
+
+	bus.add_signal_receiver(
+                property_changed, bus_name=3D"org.ofono",
+                signal_name =3D "PropertyChanged", path_keyword=3D"path",
+                interface_keyword=3D"interface")
+	mainloop =3D gobject.MainLoop()
+	mainloop.run()
-- =

1.6.6.1


--===============4308266934130910899==--

