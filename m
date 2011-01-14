Content-Type: multipart/mixed; boundary="===============7056188151731031867=="
MIME-Version: 1.0
From: Jarko Poutiainen <jarko.poutiainen@tieto.com>
Subject: [PATCH] test: add disable-call-forwarding
Date: Fri, 14 Jan 2011 10:24:29 +0200
Message-ID: <1294993469-12532-1-git-send-email-jarko.poutiainen@tieto.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7056188151731031867==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 Makefile.am                  |    3 +-
 test/disable-call-forwarding |   53 ++++++++++++++++++++++++++++++++++++++=
++++
 2 files changed, 55 insertions(+), 1 deletions(-)
 create mode 100755 test/disable-call-forwarding

diff --git a/Makefile.am b/Makefile.am
index 7dcf7a9..ce4799e 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -464,7 +464,8 @@ test_scripts =3D test/backtrace \
 		test/set-call-forwarding \
 		test/cdma-list-call \
 		test/cdma-dial-number \
-		test/cdma-hangup
+		test/cdma-hangup \
+		test/disable-call-forwarding
 =

 if TEST
 testdir =3D $(pkglibdir)/test
diff --git a/test/disable-call-forwarding b/test/disable-call-forwarding
new file mode 100755
index 0000000..ca0ba90
--- /dev/null
+++ b/test/disable-call-forwarding
@@ -0,0 +1,53 @@
+#!/usr/bin/python
+
+import sys
+import gobject
+
+import dbus
+import dbus.mainloop.glib
+
+def property_changed(property, value):
+	if len(value.__str__()) > 0:
+		print "CF property %s changed to %s" % (property, value)
+	else:
+		print "CF property %s changed to disabled" % (property)
+
+	if canexit:
+		mainloop.quit();
+
+if __name__ =3D=3D "__main__":
+	if len(sys.argv) < 2:
+		print "Usage: %s <type>" % (sys.argv[0])
+		print "Type can be: all, conditional"
+		sys.exit(1)
+
+	canexit =3D False
+
+	type =3D sys.argv[1]
+
+	dbus.mainloop.glib.DBusGMainLoop(set_as_default=3DTrue)
+
+	bus =3D dbus.SystemBus()
+
+	manager =3D dbus.Interface(bus.get_object('org.ofono', '/'),
+							'org.ofono.Manager')
+
+	modems =3D manager.GetModems()
+
+	cf =3D dbus.Interface(bus.get_object('org.ofono', modems[0][0]),
+				'org.ofono.CallForwarding')
+
+	cf.connect_to_signal("PropertyChanged", property_changed)
+
+	try:
+		cf.DisableAll(type, timeout =3D 100)
+	except dbus.DBusException, e:
+		print "Unable to DisableAll", e
+		sys.exit(1);
+
+	print "DisableAll successful"
+
+	canexit =3D True
+
+	mainloop =3D gobject.MainLoop()
+	mainloop.run()
-- =

1.7.0.4


--===============7056188151731031867==--

