Content-Type: multipart/mixed; boundary="===============1627247100738099497=="
MIME-Version: 1.0
From: Inaky Perez-Gonzalez <inaky@linux.intel.com>
Subject: [patch 18/20] SMS: send D-Bus SMS-MSG::PropertyChanged signals when
 message changes status
Date: Fri, 23 Jul 2010 14:00:06 -0700
Message-ID: <2457b1cdd137ab2a223096a3d027e161326be6ad.1279918330.git.inaky.perez-gonzalez@intel.com>
In-Reply-To: <cover.1279918330.git.inaky.perez-gonzalez@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1627247100738099497==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Inaky Perez-Gonzalez <inaky.perez-gonzalez@intel.com>

This hooks sms_msg_stch_dbus_cb() into the SMS state change callback
so that a D-Bus signal will be emitted whenever an SMS Message
transitions state. This allows a client to track, if desired, what is
going on with the SMS Message it cares about.
---
 src/sms.c                      |   36 +++++++++++++++++++++++++++++++++++-
 test/test-sms-msg-state-change |   24 ++++++++++++++++++++++++
 2 files changed, 59 insertions(+), 1 deletions(-)
 create mode 100755 test/test-sms-msg-state-change

diff --git a/src/sms.c b/src/sms.c
index 4569cf3..c0b2e00 100644
--- a/src/sms.c
+++ b/src/sms.c
@@ -820,6 +820,40 @@ struct tx_queue_entry *sms_msg_send(
 =

 =

 /*
+ * Send a PropertyChange signal when the state changes
+ *
+ * D-Bus typing is "ss" for variable/value.
+ */
+static
+void sms_msg_stch_dbus_cb(void *_dbus_data,
+			  enum ofono_sms_tx_state new_state)
+{
+	struct sms_msg_dbus_data *dbus_data =3D _dbus_data;
+	DBusConnection *dbus_conn =3D ofono_dbus_get_connection();
+	DBusMessage *dbus_signal;
+	DBusMessageIter iter;
+	const char *property =3D "TXState";
+	const char *new_state_str;
+
+	/*
+	 * This will be called in the first transition, when all the
+	 * D-Bus stuff is not yet in place.
+	 */
+	if (dbus_data->dbus_path =3D=3D NULL)
+		return;
+	dbus_signal =3D dbus_message_new_signal(
+		dbus_data->dbus_path, SMS_MSG_INTERFACE, "PropertyChanged");
+	if (!dbus_signal)
+		return;
+	dbus_message_iter_init_append(dbus_signal, &iter);
+	dbus_message_iter_append_basic(&iter, DBUS_TYPE_STRING, &property);
+	new_state_str =3D ofono_sms_tx_state_to_string(new_state);
+	dbus_message_iter_append_basic(&iter, DBUS_TYPE_STRING, &new_state_str);
+	g_dbus_send_message(dbus_conn, dbus_signal);
+}
+
+
+/*
  * D-Bus: Send a SMS text message
  *
  * @conn: D-Bus connection
@@ -846,7 +880,7 @@ static DBusMessage *dbus_sms_msg_send(DBusConnection *c=
onn, DBusMessage *msg,
 =

 	dbus_data =3D g_new0(struct sms_msg_dbus_data, 1);
 	sms_msg =3D sms_msg_send(sms, to, text, SMS_MSG_SEND_HISTORY,
-			       NULL,
+			       sms_msg_stch_dbus_cb,
 			       sms_msg_dbus_destroy,
 			       dbus_data);
 	if (sms_msg =3D=3D NULL)
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


--===============1627247100738099497==--

