Content-Type: multipart/mixed; boundary="===============4816125967963137474=="
MIME-Version: 1.0
From: Inaky Perez-Gonzalez <inaky@linux.intel.com>
Subject: [SMS D-Bus v5 16/17] sms: add test case for message cancel
Date: Thu, 05 Aug 2010 17:55:38 -0700
Message-ID: <69df7ec06f4cffe95329afcf084951d4f2765f0d.1281054654.git.inaky.perez-gonzalez@intel.com>
In-Reply-To: <cover.1281054654.git.inaky.perez-gonzalez@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4816125967963137474==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Inaky Perez-Gonzalez <inaky.perez-gonzalez@intel.com>

---
 test/test-sms-msg-cancel |  173 ++++++++++++++++++++++++++++++++++++++++++=
++++
 1 files changed, 173 insertions(+), 0 deletions(-)
 create mode 100755 test/test-sms-msg-cancel

diff --git a/test/test-sms-msg-cancel b/test/test-sms-msg-cancel
new file mode 100755
index 0000000..e9bb40f
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
+                                         'org.ofono.SmsMessage')
+                try:
+                        sms_msg.Cancel()
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
+                if interface !=3D "org.ofono.SmsMessage":
+                        return
+                if self.sms_msg_path !=3D path:
+                        return
+                if property_name !=3D "State":
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


--===============4816125967963137474==--

