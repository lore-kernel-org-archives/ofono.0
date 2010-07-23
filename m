Content-Type: multipart/mixed; boundary="===============2234604901571735581=="
MIME-Version: 1.0
From: Inaky Perez-Gonzalez <inaky@linux.intel.com>
Subject: [patch 19/20] SMS: introduce sms_msg_cancel and its D-Bus wrapper
Date: Fri, 23 Jul 2010 14:00:07 -0700
Message-ID: <6d6f0ad3aacec87f5a6e75fed17e1020bfcddb0a.1279918330.git.inaky.perez-gonzalez@intel.com>
In-Reply-To: <cover.1279918330.git.inaky.perez-gonzalez@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2234604901571735581==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Inaky Perez-Gonzalez <inaky.perez-gonzalez@intel.com>

This introduces the ability to cancel a pending SMS message,
accessible via an internal API and over a D-Bus wrapper.

Sending a note to the network to cancel an in-transit message is not
yet implemented.

Note the test case code requires follow up commits that propagate the
message's state changes over D-Bus.
---
 src/sms.c                |   63 +++++++++++++++++
 src/smsutil.h            |   15 ++++
 test/test-sms-msg-cancel |  173 ++++++++++++++++++++++++++++++++++++++++++=
++++
 3 files changed, 251 insertions(+), 0 deletions(-)
 create mode 100755 test/test-sms-msg-cancel

diff --git a/src/sms.c b/src/sms.c
index c0b2e00..97c9eab 100644
--- a/src/sms.c
+++ b/src/sms.c
@@ -538,6 +538,24 @@ static void __ofono_sms_tx_state_set(struct tx_queue_e=
ntry *entry,
 =

 =

 /*
+ * Note that the D-Bus specific cleanups are taken care by the
+ * sms_msg_dbus_destroy() callback passed in dbus_sms_msg_send().
+ */
+static DBusMessage *dbus_sms_msg_cancel(
+	DBusConnection * conn, DBusMessage *msg, void *data)
+{
+	gboolean do_network_cancel =3D FALSE;
+	struct tx_queue_entry *sms_msg =3D data;
+	if (!dbus_message_get_args(msg, NULL,
+				   DBUS_TYPE_BOOLEAN, &do_network_cancel))
+		return __ofono_error_invalid_args(msg);
+	sms_msg_cancel(sms_msg,
+		       do_network_cancel ? SMS_MSG_CANCEL_IN_NETWORK : 0);
+	return dbus_message_new_method_return(msg);
+}
+
+
+/*
  * D-Bus SMS Message interface
  *
  * NOTE: the sms_msg_{methods,signals} tables should be const, but
@@ -546,6 +564,8 @@ static void __ofono_sms_tx_state_set(struct tx_queue_en=
try *entry,
 =

 static
 GDBusMethodTable sms_msg_methods[] =3D {
+	{ "Cancel",		DBUS_TYPE_BOOLEAN_AS_STRING,	"",
+	  dbus_sms_msg_cancel, 0 },
 	{ }
 };
 =

@@ -587,6 +607,11 @@ static void tx_finished(const struct ofono_error *erro=
r, int mr, void *data)
 	gboolean ok =3D error->type =3D=3D OFONO_ERROR_TYPE_NO_ERROR;
 =

 	DBG("tx_finished");
+	/*
+	 * Queue is empty? Messages might have been cancelled.
+	 */
+	if (entry =3D=3D NULL)
+		return;
 =

 	if (ok =3D=3D FALSE) {
 		if (!(entry->flags & OFONO_SMS_SUBMIT_FLAG_RETRY)) {
@@ -819,6 +844,44 @@ struct tx_queue_entry *sms_msg_send(
 }
 =

 =

+/**
+ * Cancel a pending SMS message
+ *
+ * @sms_msg: message to cancel
+ * @flags: modifies for the action
+ *
+ * This function cancels a message that is pending or being
+ * actively transmitted. Note that after this function returns, the
+ * @sms_msg handle is no longer valid.
+ *
+ * \internal
+ *
+ * There is no need to cancel the calling of tx_next() by
+ * g_timeout_add() scheduled in sms_msg_send(). The rationale behind
+ * this is that the tx_next() function is scheduled to go over the
+ * list of messages in the @sms object, so it might have been
+ * scheduled for other messages also rather than just for this one
+ * @sms_msg. By the time it gets to run, it might see the list empty
+ * or see other messages, but @sms_msg won't be there.
+ */
+void sms_msg_cancel(struct tx_queue_entry *sms_msg,
+		    enum sms_msg_cancel_flags flags)
+{
+	struct ofono_sms *sms =3D sms_msg->sms_mgr;
+	DBG("%s (%p)\n", __func__, sms_msg);
+	if (sms_msg->state =3D=3D OFONO_SMS_TX_ST_QUEUED)
+		g_queue_remove(sms->txq, sms_msg);
+	else if (sms_msg->state =3D=3D OFONO_SMS_TX_ST_WSR)
+		g_queue_remove(sms->tx_wsrq, sms_msg);
+	ofono_sms_tx_state_set(sms_msg, OFONO_SMS_TX_ST_CANCELING);
+	if (flags & SMS_MSG_CANCEL_IN_NETWORK)
+		ofono_warn("%s(): SMS_MSG_CANCEL_IN_NETWORK support "
+			   "not yet implemented\n", __func__);
+	ofono_sms_tx_state_set(sms_msg, OFONO_SMS_TX_ST_CANCELLED);
+	tx_queue_entry_destroy_free(sms_msg, NULL);
+}
+
+
 /*
  * Send a PropertyChange signal when the state changes
  *
diff --git a/src/smsutil.h b/src/smsutil.h
index 20b24f0..fce4278 100644
--- a/src/smsutil.h
+++ b/src/smsutil.h
@@ -560,6 +560,21 @@ gboolean cbs_topic_in_range(unsigned int topic, GSList=
 *ranges);
 =

 char *ussd_decode(int dcs, int len, const unsigned char *data);
 =

+/*
+ * SMS Message API
+ */
+
+enum sms_msg_cancel_flags {
+	/**
+	 * The cancelled message will be reported to the network so it
+	 * tries to cancel it if in transit.
+	 */
+	SMS_MSG_CANCEL_IN_NETWORK =3D 0x1,
+};
+
+struct tx_queue_entry;
+void sms_msg_cancel(struct tx_queue_entry *sms_msg, enum sms_msg_cancel_fl=
ags);
+
 enum {
 	/* Note this has to be a multiple of sizeof(guint32);
 	 * Compilation will assert-fail if this is not met. */
diff --git a/test/test-sms-msg-cancel b/test/test-sms-msg-cancel
new file mode 100755
index 0000000..24cc7e2
--- /dev/null
+++ b/test/test-sms-msg-cancel
@@ -0,0 +1,173 @@
+#!/usr/bin/python
+#
+# Sends a message and inmediately cancels it once the state moves to
+# "queued"; fails if the message doesn't move to the CANCELLED state.
+#
+# Arguments are: DEST-PHONE-NUMBER MSG-TEXT BOOLEAN
+#
+# BOOLEAN: request delivery confirmation / no
+#
+# Notes: accessing the globals result and reason using 'globals'
+#
+
+import gobject
+import sys
+import dbus
+import dbus.mainloop.glib
+
+dbus.mainloop.glib.DBusGMainLoop(set_as_default=3DTrue)
+
+class sms_msg_cancel_test:
+        number =3D ""
+        text =3D ""
+        wsr =3D ""
+        target_state =3D ""
+
+        result =3D ""
+        reason =3D ""
+
+        sms_msg_path =3D ""
+
+        # FIXME
+        def __init__(self, number, text, wsr):
+                self.number =3D number
+                self.text =3D text
+                self.wsr =3D wsr
+                self.mainloop =3D gobject.MainLoop()
+
+                self.dbus =3D dbus.SystemBus()
+                ofono_manager =3D dbus.Interface(self.dbus.get_object('org=
.ofono', '/'),
+                                               'org.ofono.Manager')
+                path =3D ofono_manager.GetProperties()["Modems"][0]
+                self.sms_manager =3D dbus.Interface(self.dbus.get_object('=
org.ofono', path),
+                                                  'org.ofono.SmsManager')
+                self.sms_manager.SetProperty("UseDeliveryReports", dbus.Bo=
olean(int(self.wsr)))
+
+                # Connect the signal *before* creating the message, otherw=
ise we miss
+                # the transition - this also means we can't use sms_msg.co=
nnect_to_signal()
+                self.dbus.add_signal_receiver(self.property_changed, bus_n=
ame=3D"org.ofono",
+                                              signal_name =3D "PropertyCha=
nged",
+                                              path_keyword=3D"path",
+                                              interface_keyword=3D"interfa=
ce")
+                self.result =3D "FAILED"
+                self.reason =3D "didn't see CANCELING state"
+
+        # Cancel the message and update test state
+        def msg_cancel(self):
+                print "I: %s[%s]: SMS message: canceling because " \
+                    "target state was reached" \
+                    % (self.sms_msg_path, self.target_state)
+                sms_msg =3D dbus.Interface(self.dbus.get_object('org.ofono=
', self.sms_msg_path),
+                                         'org.ofono.SMSMessage')
+                try:
+                        sms_msg.Cancel(0)
+                except dbus.DBusException as dbus_ex:
+                        if dbus_ex.get_dbus_name() !=3D 'org.freedesktop.D=
Bus.Error.UnknownMethod':
+                                pass
+                        # Object has been cancelled already--this is
+                        # why we get the D-Bus exception, so we can
+                        # consider this a win
+                        print "I: %s[%s]: SMS message: ok, D-Bus object al=
ready removed" \
+                            % (self.sms_msg_path, self.target_state)
+                        self.result =3D "SUCCESS"
+                        self.reason =3D "object dissapeared from the bus, =
meaning it was cancelled"
+                        self.mainloop.quit()
+                        return
+
+        # Run the actual test FIXME
+        def run(self, target_state):
+                self.target_state =3D target_state
+
+                self.result =3D "FAILED"
+                self.reason =3D "didn't see %s state to allow cancelling" \
+                    % target_state
+
+                print "I: [%s]: starting test" % self.target_state
+                self.sms_msg_path =3D self.sms_manager.SendMessage(number,=
 text)
+                print "I: %s[%s]: SMS message: D-Bus object created" \
+                    % (self.sms_msg_path, self.target_state)
+
+                # wait for property changed signals, property_changed() wi=
ll be called
+                # when there is a transition and the thing cancelled.
+                gobject.timeout_add(20000, self.timeout_fail)
+                # If the target state to cancel on is QUEUED, schedule a
+                # cancellation inmediately -- note we need to schedule it =
in
+                # the mainloop to ensure property_changed() signals are
+                # properly propagated.
+                if target_state =3D=3D "queued" \
+                            or target_state =3D=3D "canceling" \
+                            or target_state =3D=3D "cancelled":
+                        gobject.idle_add(self.msg_cancel)
+                self.mainloop.run()
+                if self.result =3D=3D "SUCCESS":
+                        letter =3D "I"
+                        result =3D 0
+                else:
+                        letter =3D "E"
+                        result =3D 1
+                print "%s: %s[%s]: %s: %s" % (letter, self.sms_msg_path,
+                                              self.target_state,
+                                              self.result, self.reason)
+                return result
+
+        def timeout_fail(self):
+                self.result =3D "FAILED"
+                self.reason =3D "%s (timedout)" % self.reason
+                self.mainloop.quit()
+                # Don't rearm the timeout ... doesn't really matter as we
+                # quit the mainloop.
+                return 0
+
+
+        # When the message's state (the one we created) switches to QUEUED=
, cancel
+        def property_changed(self, property_name, property_value,
+                             path, interface):
+                if interface !=3D "org.ofono.SMSMessage":
+                        return
+                if self.sms_msg_path !=3D path:
+                        return
+                if property_name !=3D "TXState":
+                        return
+                print "I: %s[%s]: SMS message: transitioning to %s state" \
+                    % (self.sms_msg_path, self.target_state, property_valu=
e)
+                if property_value =3D=3D "canceling":
+                        print "I: %s[%s]: SMS message: ok, saw canceling s=
tate" \
+                            % (self.sms_msg_path, self.target_state)
+                        self.result =3D "FAIL"
+                        self.reason =3D "didn't see the CANCELLED state"
+                if property_value =3D=3D "cancelled":
+                        print "I: %s[%s]: SMS message: ok, saw cancelled s=
tate, quiting" \
+                            % (self.sms_msg_path, self.target_state)
+                        self.result =3D "SUCCESS"
+                        self.reason =3D "saw CANCELLED state"
+                        self.mainloop.quit()
+                # If we get to the state that is the target state for
+                # the test, cancel the message -- we need to do this
+                # after evaluating propery_value or we might enter
+                # into conflicts (as self.msg_cancel() will change
+                # self.{result,reason} if it turns out the operation
+                # is complete).
+                if self.target_state =3D=3D property_value:
+                        # Cancel the message
+                        self.msg_cancel()
+
+
+# Send the message
+if len(sys.argv) =3D=3D 4:
+        wsr =3D int(sys.argv[3])
+elif len(sys.argv) =3D=3D 3:
+        wsr =3D 0
+else:
+        raise NameError("E: Bad number of arguments (expected NUMBER TEXT =
[BOOLEAN])")
+
+number =3D sys.argv[1]
+text =3D sys.argv[2]
+global test
+
+test =3D sms_msg_cancel_test(number, text, wsr)
+
+test.run('queued')
+test.run('wsr')
+test.run('canceling')
+test.run('cancelled')
+test.run('done')
-- =

1.6.6.1


--===============2234604901571735581==--

