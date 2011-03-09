Content-Type: multipart/mixed; boundary="===============7765482398023766983=="
MIME-Version: 1.0
From: Bertrand Aygon <bertrand.aygon@intel.com>
Subject: [PATCH v2] test/test-message-waiting: Add a new test file to validate
 org.ofono.MessageWaiting
Date: Wed, 09 Mar 2011 14:31:35 +0100
Message-ID: <1299677495-21937-1-git-send-email-bertrand.aygon@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7765482398023766983==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 Makefile.am               |    3 ++-
 test/test-message-waiting |   40 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 42 insertions(+), 1 deletions(-)
 create mode 100755 test/test-message-waiting

diff --git a/Makefile.am b/Makefile.am
index 3f20717..b3c6ad3 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -501,7 +501,8 @@ test_scripts =3D test/backtrace \
 		test/cdma-hangup \
 		test/disable-call-forwarding \
 		test/list-messages \
-		test/test-sms
+		test/test-sms \
+		test/test-message-waiting
 =

 if TEST
 testdir =3D $(pkglibdir)/test
diff --git a/test/test-message-waiting b/test/test-message-waiting
new file mode 100755
index 0000000..3abe0ba
--- /dev/null
+++ b/test/test-message-waiting
@@ -0,0 +1,40 @@
+#!/usr/bin/python
+
+import gobject
+import sys
+import dbus
+import dbus.mainloop.glib
+
+def mw_property_changed(name, value):
+	if name =3D=3D 'VoicemailMessageCount':
+		print "MessageWaiting property: '%s' changed to '%d'" %\
+			(name,value)
+	else:
+		print "MessageWaiting property: '%s' changed to '%s'" %\
+			(name,value)
+
+if __name__ =3D=3D "__main__":
+	dbus.mainloop.glib.DBusGMainLoop(set_as_default=3DTrue)
+
+	bus =3D dbus.SystemBus()
+
+	manager =3D dbus.Interface(bus.get_object('org.ofono', '/'),
+			'org.ofono.Manager')
+
+	modems =3D manager.GetModems()
+
+	mw =3D dbus.Interface(bus.get_object('org.ofono', modems[0][0]),
+			'org.ofono.MessageWaiting')
+
+	mw.connect_to_signal("PropertyChanged", mw_property_changed)
+
+	properties =3D mw.GetProperties()
+
+	print "Voicemail waiting: %s" % (properties['VoicemailWaiting'])
+	print "Voicemail message count: %d" %\
+		(properties['VoicemailMessageCount'])
+	print "Voicemail mailbox number: %s" %\
+		(properties['VoicemailMailboxNumber'])
+
+	mainloop =3D gobject.MainLoop()
+	mainloop.run()
-- =

1.7.1

---------------------------------------------------------------------
Intel Corporation SAS (French simplified joint stock company)
Registered headquarters: "Les Montalets"- 2, rue de Paris, =

92196 Meudon Cedex, France
Registration Number:  302 456 199 R.C.S. NANTERRE
Capital: 4,572,000 Euros

This e-mail and any attachments may contain confidential material for
the sole use of the intended recipient(s). Any review or distribution
by others is strictly prohibited. If you are not the intended
recipient, please contact the sender and delete all copies.

--===============7765482398023766983==--

