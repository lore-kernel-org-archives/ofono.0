Content-Type: multipart/mixed; boundary="===============4903444207210756610=="
MIME-Version: 1.0
From: Jarko Poutiainen <jarko.poutiainen@tieto.com>
Subject: [PATCH] test: add set-call-forwarding
Date: Mon, 10 Jan 2011 11:26:55 +0200
Message-ID: <4D2AD0DF.2020001@tieto.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4903444207210756610==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
  Makefile.am              |    3 +-
  test/set-call-forwarding |   65 =

++++++++++++++++++++++++++++++++++++++++++++++
  2 files changed, 67 insertions(+), 1 deletions(-)
  create mode 100755 test/set-call-forwarding

diff --git a/Makefile.am b/Makefile.am
index 8ad01cd..563da9f 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -440,7 +440,8 @@ test_scripts =3D test/backtrace \
          test/set-tty \
          test/set-gsm-band \
          test/set-umts-band \
-        test/lockdown-modem
+        test/lockdown-modem \
+        test/set-call-forwarding

  if TEST
  testdir =3D $(pkglibdir)/test
diff --git a/test/set-call-forwarding b/test/set-call-forwarding
new file mode 100755
index 0000000..03bf542
--- /dev/null
+++ b/test/set-call-forwarding
@@ -0,0 +1,65 @@
+#!/usr/bin/python
+
+import sys
+import gobject
+
+import dbus
+import dbus.mainloop.glib
+
+def property_changed(property, value):
+
+    if len(value.__str__()) > 0:
+        print "CallForwarding property %s changed to %s" % (property, =

value)
+    else:
+        print "CallForwarding property %s changed to disabled" % (property)
+
+    if canexit:
+        mainloop.quit();
+
+if __name__ =3D=3D "__main__":
+
+    if len(sys.argv) < 3:
+        print "Usage: %s <property> <value>" % (sys.argv[0])
+        print "Properties can be: VoiceUnconditional, VoiceBusy,"
+        print "    VoiceNoReply, VoiceNoReplyTimeout, VoiceNotReachable"
+        print "Value: number to or the timeout"
+        sys.exit(1)
+
+    property =3D sys.argv[1]
+    value =3D sys.argv[2]
+
+    canexit =3D False
+
+    dbus.mainloop.glib.DBusGMainLoop(set_as_default=3DTrue)
+
+    bus =3D dbus.SystemBus()
+
+    manager =3D dbus.Interface(bus.get_object('org.ofono', '/'),
+                            'org.ofono.Manager')
+
+    modems =3D manager.GetModems()
+
+    cf =3D dbus.Interface(bus.get_object('org.ofono', modems[0][0]),
+                'org.ofono.CallForwarding')
+
+    cf.connect_to_signal("PropertyChanged", property_changed)
+
+    if (property =3D=3D "VoiceNoReplyTimeout"):
+        try:
+            cf.SetProperty(property, dbus.UInt16(value), timeout =3D 100)
+        except dbus.DBusException, e:
+            print "Unable SetProperty", e
+            sys.exit(1);
+    else:
+        try:
+            cf.SetProperty(property, value, timeout =3D 100)
+        except dbus.DBusException, e:
+            print "Unable SetProperty", e
+            sys.exit(1);
+
+    print "Set Property successfull"
+
+    canexit =3D True
+
+    mainloop =3D gobject.MainLoop()
+    mainloop.run()
-- =

1.7.0.4

--===============4903444207210756610==--

