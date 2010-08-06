Content-Type: multipart/mixed; boundary="===============0919603575070352470=="
MIME-Version: 1.0
From: Inaky Perez-Gonzalez <inaky@linux.intel.com>
Subject: [SMS D-Bus v5 17/17] sms: add test case for state change signals
Date: Thu, 05 Aug 2010 17:55:39 -0700
Message-ID: <fcadbc74da282e45733d4c7a49642905a05c2f83.1281054654.git.inaky.perez-gonzalez@intel.com>
In-Reply-To: <cover.1281054654.git.inaky.perez-gonzalez@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0919603575070352470==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Inaky Perez-Gonzalez <inaky.perez-gonzalez@intel.com>

---
 test/test-sms-msg-state-change |   24 ++++++++++++++++++++++++
 1 files changed, 24 insertions(+), 0 deletions(-)
 create mode 100755 test/test-sms-msg-state-change

diff --git a/test/test-sms-msg-state-change b/test/test-sms-msg-state-change
new file mode 100755
index 0000000..331b722
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
+        if interface =3D=3D "org.ofono.SmsMessage":
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


--===============0919603575070352470==--

